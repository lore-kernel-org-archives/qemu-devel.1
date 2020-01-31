Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4CDC35248
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7161222522
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edmyrVdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7161222522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaQN-0001ni-Ig
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixaLs-0003TK-Hv
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:45:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixaLp-0004u2-Ro
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:45:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48990
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixaLp-0004tY-LL
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580492705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSq7DecclquLgo3YGvTsrqUS/ylJr0pUGFtgCoasKd0=;
 b=edmyrVdGXxGZTmq/REkoNzE8kdeYR0uap4VSUuj036JEf5nQXPgKPOem6MorUFghOCpZ+r
 yZdxVBpYoBnUEIGgLhC+5hukJhUVjbzg6n60lJBHWGIx1K3MVyGNZjrqlscBEvdQwLGRLM
 6R9sY8WAnyngJr4x5t/7SC17gvtZyvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-Lc1a6eBuNwuGlmU6qd7oHg-1; Fri, 31 Jan 2020 12:45:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D63981937FC0;
 Fri, 31 Jan 2020 17:44:59 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FCC87FB60;
 Fri, 31 Jan 2020 17:44:57 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/17] iotests: Add new test for qcow2 all-zero bit
Date: Fri, 31 Jan 2020 11:44:35 -0600
Message-Id: <20200131174436.2961874-17-eblake@redhat.com>
In-Reply-To: <20200131174436.2961874-1-eblake@redhat.com>
References: <20200131174436.2961874-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Lc1a6eBuNwuGlmU6qd7oHg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cover various scenarios to show that the bit gets set even for
fully-allocated images, as well as scenarios where it is properly
cleared.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/285     | 107 +++++++++++++++
 tests/qemu-iotests/285.out | 257 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 365 insertions(+)
 create mode 100755 tests/qemu-iotests/285
 create mode 100644 tests/qemu-iotests/285.out

diff --git a/tests/qemu-iotests/285 b/tests/qemu-iotests/285
new file mode 100755
index 000000000000..66037af237a1
--- /dev/null
+++ b/tests/qemu-iotests/285
@@ -0,0 +1,107 @@
+#!/usr/bin/env bash
+#
+# Test qcow2 all-zero autoclear bit
+#
+# Copyright (C) 2020 Red Hat, Inc.
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
+seq=3D$(basename $0)
+echo "QA output created by $seq"
+
+status=3D1=09# failure is the default!
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
+_supported_os Linux
+# Autoclear bit is not available in compat=3D0.10;
+# encrypted images never advertise all-zero bit
+_unsupported_imgopts 'compat=3D0.10' encrypt
+
+for mode in off metadata falloc full; do
+
+    echo
+    echo "=3D=3D=3D preallocation=3D$mode =3D=3D=3D"
+    echo
+
+    _make_test_img -o "preallocation=3D$mode" 32M
+
+    # Actions that do not lose the all-zero nature of the image:
+    $QEMU_IO -c 'w -z 0 16M' -c 'discard 8M 16M' "$TEST_IMG" | _filter_qem=
u_io
+    $QEMU_IMG resize --preallocation=3D$mode "$TEST_IMG" +8M
+    $QEMU_IO -c 'r -P 0 0 40M' "$TEST_IMG" | _filter_qemu_io
+    $QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
+
+    # Writing data must clear the all-zero bit:
+    $QEMU_IO -c 'w -P 1 32M 1M' "$TEST_IMG" | _filter_qemu_io
+    $QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
+
+    # Alas, rewriting the image back to zero does not restore the bit
+    # (checking if each write gets us back to zero does not scale)
+    $QEMU_IO -c 'w -z 32M 1M' "$TEST_IMG" | _filter_qemu_io
+    $QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
+
+done
+
+echo
+echo "=3D=3D=3D backing files =3D=3D=3D"
+echo
+
+# Even when a backing file is all zero, we do not set all-zero bit;
+# this is true whether we create with a backing file or rebase later
+TEST_IMG_SAVE=3D$TEST_IMG
+TEST_IMG=3D$TEST_IMG.base
+_make_test_img 32M
+TEST_IMG=3D$TEST_IMG_SAVE
+_make_test_img -b "$TEST_IMG.base" -F qcow2 32M
+$QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
+_make_test_img 32M
+$QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
+$QEMU_IMG rebase -u -F qcow2 -b "$TEST_IMG.base" "$TEST_IMG"
+$QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
+
+# qemu-img commit clears an image, but because it still has a backing file=
,
+# setting the all-zero bit is not correct
+$QEMU_IO -c 'w -P 1 0 1M' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG commit "$TEST_IMG"
+$QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
+
+echo
+echo "=3D=3D=3D internal snapshots =3D=3D=3D"
+echo
+
+# For now, internal snapshots do not remember the all-zero bit
+_make_test_img 32M
+$QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
+$QEMU_IMG snapshot -c snap "$TEST_IMG"
+$QEMU_IO -c 'w -P 1 0 1M' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG snapshot -l snap "$TEST_IMG"
+$QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific \
+    | _filter_date | _filter_vmstate_size
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/285.out b/tests/qemu-iotests/285.out
new file mode 100644
index 000000000000..e43ff9906b5f
--- /dev/null
+++ b/tests/qemu-iotests/285.out
@@ -0,0 +1,257 @@
+QA output created by 285
+
+=3D=3D=3D preallocation=3Doff =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432 preallocation=
=3Doff
+wrote 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 16777216/16777216 bytes at offset 8388608
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Image resized.
+read 41943040/41943040 bytes at offset 0
+40 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 40 MiB (41943040 bytes)
+disk size: 260 KiB
+Format specific information:
+    compat: 1.1
+    all zero: true
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+wrote 1048576/1048576 bytes at offset 33554432
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 40 MiB (41943040 bytes)
+disk size: 1.25 MiB
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+wrote 1048576/1048576 bytes at offset 33554432
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 40 MiB (41943040 bytes)
+disk size: 1.25 MiB
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+
+=3D=3D=3D preallocation=3Dmetadata =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432 preallocation=
=3Dmetadata
+wrote 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 16777216/16777216 bytes at offset 8388608
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Image resized.
+read 41943040/41943040 bytes at offset 0
+40 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 40 MiB (41943040 bytes)
+disk size: 260 KiB
+Format specific information:
+    compat: 1.1
+    all zero: true
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+wrote 1048576/1048576 bytes at offset 33554432
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 40 MiB (41943040 bytes)
+disk size: 1.25 MiB
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+wrote 1048576/1048576 bytes at offset 33554432
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 40 MiB (41943040 bytes)
+disk size: 1.25 MiB
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+
+=3D=3D=3D preallocation=3Dfalloc =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432 preallocation=
=3Dfalloc
+wrote 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 16777216/16777216 bytes at offset 8388608
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Image resized.
+read 41943040/41943040 bytes at offset 0
+40 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 40 MiB (41943040 bytes)
+disk size: 24.3 MiB
+Format specific information:
+    compat: 1.1
+    all zero: true
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+wrote 1048576/1048576 bytes at offset 33554432
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 40 MiB (41943040 bytes)
+disk size: 24.3 MiB
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+wrote 1048576/1048576 bytes at offset 33554432
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 40 MiB (41943040 bytes)
+disk size: 24.3 MiB
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+
+=3D=3D=3D preallocation=3Dfull =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432 preallocation=
=3Dfull
+wrote 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 16777216/16777216 bytes at offset 8388608
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Image resized.
+read 41943040/41943040 bytes at offset 0
+40 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 40 MiB (41943040 bytes)
+disk size: 24.3 MiB
+Format specific information:
+    compat: 1.1
+    all zero: true
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+wrote 1048576/1048576 bytes at offset 33554432
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 40 MiB (41943040 bytes)
+disk size: 24.3 MiB
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+wrote 1048576/1048576 bytes at offset 33554432
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 40 MiB (41943040 bytes)
+disk size: 24.3 MiB
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+
+=3D=3D=3D backing files =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D33554432
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 32 MiB (33554432 bytes)
+disk size: 196 KiB
+backing file: TEST_DIR/t.IMGFMT.base
+backing file format: IMGFMT
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 32 MiB (33554432 bytes)
+disk size: 196 KiB
+Format specific information:
+    compat: 1.1
+    all zero: true
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 32 MiB (33554432 bytes)
+disk size: 196 KiB
+backing file: TEST_DIR/t.IMGFMT.base
+backing file format: IMGFMT
+Format specific information:
+    compat: 1.1
+    all zero: true
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Image committed.
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 32 MiB (33554432 bytes)
+disk size: 260 KiB
+backing file: TEST_DIR/t.IMGFMT.base
+backing file format: IMGFMT
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+
+=3D=3D=3D internal snapshots =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 32 MiB (33554432 bytes)
+disk size: 196 KiB
+Format specific information:
+    compat: 1.1
+    all zero: true
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img: Expecting one image file name
+Try 'qemu-img --help' for more information
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 32 MiB (33554432 bytes)
+disk size:     SIZE
+Snapshot list:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+1         snap                   SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index e041cc1ee360..e9b20818fad5 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -289,3 +289,4 @@
 279 rw backing quick
 280 rw migration quick
 281 rw quick
+285 rw quick
--=20
2.24.1


