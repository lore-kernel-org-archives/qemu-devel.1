Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695C4ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 379D320854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379D320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK30M-0001nG-RR
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iK2pL-00036m-3z
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iK2pJ-0006dK-J6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49006)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iK2pE-0006Wp-Gt; Mon, 14 Oct 2019 12:04:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ABE188980E0;
 Mon, 14 Oct 2019 16:03:59 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A47885C1D4;
 Mon, 14 Oct 2019 16:03:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 08/15] block: Reject misaligned write requests with
 BDRV_REQ_NO_FALLBACK
Date: Mon, 14 Oct 2019 18:03:42 +0200
Message-Id: <20191014160343.8211-9-kwolf@redhat.com>
In-Reply-To: <20191014160343.8211-1-kwolf@redhat.com>
References: <20191014160343.8211-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Mon, 14 Oct 2019 16:03:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

The BDRV_REQ_NO_FALLBACK flag means that an operation should only be
performed if it can be offloaded or otherwise performed efficiently.

However a misaligned write request requires a RMW so we should return
an error and let the caller decide how to proceed.

This hits an assertion since commit c8bb23cbdb if the required
alignment is larger than the cluster size:

qemu-img create -f qcow2 -o cluster_size=3D2k img.qcow2 4G
qemu-io -c "open -o driver=3Dqcow2,file.align=3D4k blkdebug::img.qcow2" \
        -c 'write 0 512'
qemu-io: block/io.c:1127: bdrv_driver_pwritev: Assertion `!(flags & BDRV_=
REQ_NO_FALLBACK)' failed.
Aborted

The reason is that when writing to an unallocated cluster we try to
skip the copy-on-write part and zeroize it using BDRV_REQ_NO_FALLBACK
instead, resulting in a write request that is too small (2KB cluster
size vs 4KB required alignment).

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c                 |  7 +++++
 tests/qemu-iotests/268     | 55 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/268.out |  7 +++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 70 insertions(+)
 create mode 100755 tests/qemu-iotests/268
 create mode 100644 tests/qemu-iotests/268.out

diff --git a/block/io.c b/block/io.c
index 8b6dace056..f0b86c1d19 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2090,6 +2090,13 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *c=
hild,
         return ret;
     }
=20
+    /* If the request is misaligned then we can't make it efficient */
+    if ((flags & BDRV_REQ_NO_FALLBACK) &&
+        !QEMU_IS_ALIGNED(offset | bytes, align))
+    {
+        return -ENOTSUP;
+    }
+
     bdrv_inc_in_flight(bs);
     /*
      * Align write if necessary by performing a read-modify-write cycle.
diff --git a/tests/qemu-iotests/268 b/tests/qemu-iotests/268
new file mode 100755
index 0000000000..78c3f4db3a
--- /dev/null
+++ b/tests/qemu-iotests/268
@@ -0,0 +1,55 @@
+#!/usr/bin/env bash
+#
+# Test write request with required alignment larger than the cluster siz=
e
+#
+# Copyright (C) 2019 Igalia, S.L.
+# Author: Alberto Garcia <berto@igalia.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner=3Dberto@igalia.com
+
+seq=3D`basename $0`
+echo "QA output created by $seq"
+
+status=3D1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto file
+
+echo
+echo "=3D=3D Required alignment larger than cluster size =3D=3D"
+
+CLUSTER_SIZE=3D2k _make_test_img 1M
+# Since commit c8bb23cbdb writing to an unallocated cluster fills the
+# empty COW areas with bdrv_write_zeroes(flags=3DBDRV_REQ_NO_FALLBACK)
+$QEMU_IO -c "open -o driver=3D$IMGFMT,file.align=3D4k blkdebug::$TEST_IM=
G" \
+         -c "write 0 512" | _filter_qemu_io
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/268.out b/tests/qemu-iotests/268.out
new file mode 100644
index 0000000000..2ed6c68529
--- /dev/null
+++ b/tests/qemu-iotests/268.out
@@ -0,0 +1,7 @@
+QA output created by 268
+
+=3D=3D Required alignment larger than cluster size =3D=3D
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 5805a79d9e..4c861f7eed 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -278,3 +278,4 @@
 265 rw auto quick
 266 rw quick
 267 rw auto quick snapshot
+268 rw auto quick
--=20
2.20.1


