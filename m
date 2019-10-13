Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C751C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 20:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C63620673
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 20:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="N1DuToE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C63620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJkqS-0004pN-7k
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 16:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iJkof-0003YS-96
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 16:50:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iJkod-0006y8-Kp
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 16:50:12 -0400
Received: from 6.130.60.178.static.reverse-mundo-r.com ([178.60.130.6]:34463
 helo=fanzine.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iJkod-0006bR-1t; Sun, 13 Oct 2019 16:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=OBrDj1CP4bLQyTFrO2ilHsg5cU7WOeNqHGGdr6oBxio=; 
 b=N1DuToE964Zg2z/xR0fJu8Pk3waHCrloJiTBCofTxjf2ch9G9UXi/ea2AvqhVtUMQ2hXXQkw3yFM4XdfRQ/w3Hl5WfdOz2L62dZKuu3zvf6r4e6eBaqKXex0ydR5FN5viwxBgljWy7mMjiMyt1nEbBh/+60sClEwc7RyB4z7Y59M7t7bp7LVii6MaHMJJ5GDlF2yP1IK9cwXFoj7YuAJvfsPAXWxDdlhzvMDLZvURbpCff9KaqG2KClLo3BuGmP8szxaU/Yiaj+k7kTFIVVnrqUqw/WJgUTE0W8epd+pfQnpx6mExZybufmx9HwzSs5XGqp/j5Nst8nyNdh6BIigFg==;
Received: from 87-100-137-117.bb.dnainternet.fi ([87.100.137.117]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iJkoJ-0004KZ-9L; Sun, 13 Oct 2019 22:49:51 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iJknS-0000Hl-GX; Sun, 13 Oct 2019 23:48:58 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] block: Reject misaligned write requests with
 BDRV_REQ_NO_FALLBACK
Date: Sun, 13 Oct 2019 23:48:53 +0300
Message-Id: <20191013204853.1046-1-berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The BDRV_REQ_NO_FALLBACK flag means that an operation should only be
performed if it can be offloaded or otherwise performed efficiently.

However a misaligned write request requires a RMW so we should return
an error and let the caller decide how to proceed.

This hits an assertion since commit c8bb23cbdb if the required
alignment is larger than the cluster size:

qemu-img create -f qcow2 -o cluster_size=2k img.qcow2 4G
qemu-io -c "open -o driver=qcow2,file.align=4k blkdebug::img.qcow2" \
        -c 'write 0 512'
qemu-io: block/io.c:1127: bdrv_driver_pwritev: Assertion `!(flags & BDRV_REQ_NO_FALLBACK)' failed.
Aborted

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/io.c                 |  6 +++++
 tests/qemu-iotests/268     | 55 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/268.out |  7 +++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 69 insertions(+)
 create mode 100755 tests/qemu-iotests/268
 create mode 100644 tests/qemu-iotests/268.out

diff --git a/block/io.c b/block/io.c
index 4f9ee97c2b..c5d4d029da 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2071,6 +2071,12 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
         return ret;
     }
 
+    /* If the request is misaligned then we can't make it efficient */
+    if (((offset & (align - 1)) || (bytes & (align - 1))) &&
+        (flags & BDRV_REQ_NO_FALLBACK)) {
+        return -ENOTSUP;
+    }
+
     bdrv_inc_in_flight(bs);
     /*
      * Align write if necessary by performing a read-modify-write cycle.
diff --git a/tests/qemu-iotests/268 b/tests/qemu-iotests/268
new file mode 100755
index 0000000000..895f6e593f
--- /dev/null
+++ b/tests/qemu-iotests/268
@@ -0,0 +1,55 @@
+#!/usr/bin/env bash
+#
+# Test write request with required alignment larger than the cluster size
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
+owner=berto@igalia.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
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
+echo "== Required alignment larger than cluster size =="
+
+CLUSTER_SIZE=2k _make_test_img 1M
+# Since commit c8bb23cbdb writing to an allocated cluster fills the
+# empty COW areas with bdrv_write_zeroes(flags=BDRV_REQ_NO_FALLBACK)
+$QEMU_IO -c "open -o driver=$IMGFMT,file.align=4k blkdebug::$TEST_IMG" \
+         -c "write 0 512" | _filter_qemu_io
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/268.out b/tests/qemu-iotests/268.out
new file mode 100644
index 0000000000..2ed6c68529
--- /dev/null
+++ b/tests/qemu-iotests/268.out
@@ -0,0 +1,7 @@
+QA output created by 268
+
+== Required alignment larger than cluster size ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
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
-- 
2.20.1


