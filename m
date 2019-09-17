Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B331C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C749214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C749214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iABJz-0005vS-RX
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 07:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iABIA-0004Qk-Kk
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iABI8-0007D3-5F
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:05:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iABHz-00074o-3H; Tue, 17 Sep 2019 07:04:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 21FADA2666F;
 Tue, 17 Sep 2019 11:04:54 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-202.ams2.redhat.com
 [10.36.116.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B88E460606;
 Tue, 17 Sep 2019 11:04:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 17 Sep 2019 13:04:43 +0200
Message-Id: <20190917110443.2029-3-kwolf@redhat.com>
In-Reply-To: <20190917110443.2029-1-kwolf@redhat.com>
References: <20190917110443.2029-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 17 Sep 2019 11:04:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] iotests: Test internal snapshots with
 -blockdev
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/267           | 165 ++++++++++++++++++++++++++++
 tests/qemu-iotests/267.out       | 182 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/common.filter |   5 +-
 tests/qemu-iotests/group         |   1 +
 4 files changed, 349 insertions(+), 4 deletions(-)
 create mode 100755 tests/qemu-iotests/267
 create mode 100644 tests/qemu-iotests/267.out

diff --git a/tests/qemu-iotests/267 b/tests/qemu-iotests/267
new file mode 100755
index 0000000000..0d085c60a7
--- /dev/null
+++ b/tests/qemu-iotests/267
@@ -0,0 +1,165 @@
+#!/usr/bin/env bash
+#
+# Test which nodes are involved in internal snapshots
+#
+# Copyright (C) 2019 Red Hat, Inc.
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
+owner=3Dkwolf@redhat.com
+
+seq=3D`basename $0`
+echo "QA output created by $seq"
+
+status=3D1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    rm -f "$TEST_DIR/nbd"
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
+
+do_run_qemu()
+{
+    echo Testing: "$@"
+    (
+        if ! test -t 0; then
+            while read cmd; do
+                echo $cmd
+            done
+        fi
+        echo quit
+    ) | $QEMU -nographic -monitor stdio -nodefaults "$@"
+    echo
+}
+
+run_qemu()
+{
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_hmp=
 |
+        _filter_generated_node_ids | _filter_imgfmt
+}
+
+size=3D128M
+
+run_test()
+{
+    _make_test_img $size
+    printf "savevm snap0\ninfo snapshots\nloadvm snap0\n" | run_qemu "$@=
" | _filter_date
+}
+
+
+echo
+echo "=3D=3D=3D No block devices at all =3D=3D=3D"
+echo
+
+run_test
+
+echo
+echo "=3D=3D=3D -drive if=3Dnone =3D=3D=3D"
+echo
+
+run_test -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dnone
+run_test -drive driver=3D$IMGFMT,file=3D"$TEST_IMG",if=3Dnone
+run_test -drive driver=3D$IMGFMT,file=3D"$TEST_IMG",if=3Dnone -device vi=
rtio-blk,drive=3Dnone0
+
+echo
+echo "=3D=3D=3D -drive if=3Dvirtio =3D=3D=3D"
+echo
+
+run_test -drive driver=3Dfile,file=3D"$TEST_IMG",if=3Dvirtio
+run_test -drive driver=3D$IMGFMT,file=3D"$TEST_IMG",if=3Dvirtio
+
+echo
+echo "=3D=3D=3D Simple -blockdev =3D=3D=3D"
+echo
+
+run_test -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-name=3Dfile
+run_test -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-name=3Dfile=
 \
+         -blockdev driver=3D$IMGFMT,file=3Dfile,node-name=3Dfmt
+run_test -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-name=3Dfile=
 \
+         -blockdev driver=3Draw,file=3Dfile,node-name=3Draw \
+         -blockdev driver=3D$IMGFMT,file=3Draw,node-name=3Dfmt
+
+echo
+echo "=3D=3D=3D -blockdev with a filter on top =3D=3D=3D"
+echo
+
+run_test -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-name=3Dfile=
 \
+         -blockdev driver=3D$IMGFMT,file=3Dfile,node-name=3Dfmt \
+         -blockdev driver=3Dcopy-on-read,file=3Dfmt,node-name=3Dfilter
+
+echo
+echo "=3D=3D=3D -blockdev with a backing file =3D=3D=3D"
+echo
+
+TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
+
+IMGOPTS=3D"backing_file=3D$TEST_IMG.base" \
+run_test -blockdev driver=3Dfile,filename=3D"$TEST_IMG.base",node-name=3D=
backing-file \
+         -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-name=3Dfile=
 \
+         -blockdev driver=3D$IMGFMT,file=3Dfile,backing=3Dbacking-file,n=
ode-name=3Dfmt
+
+IMGOPTS=3D"backing_file=3D$TEST_IMG.base" \
+run_test -blockdev driver=3Dfile,filename=3D"$TEST_IMG.base",node-name=3D=
backing-file \
+         -blockdev driver=3D$IMGFMT,file=3Dbacking-file,node-name=3Dback=
ing-fmt \
+         -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-name=3Dfile=
 \
+         -blockdev driver=3D$IMGFMT,file=3Dfile,backing=3Dbacking-fmt,no=
de-name=3Dfmt
+
+# A snapshot should be present on the overlay, but not the backing file
+echo Internal snapshots on overlay:
+$QEMU_IMG snapshot -l "$TEST_IMG" | _filter_date
+
+echo Internal snapshots on backing file:
+$QEMU_IMG snapshot -l "$TEST_IMG.base" | _filter_date
+
+echo
+echo "=3D=3D=3D -blockdev with NBD server on the backing file =3D=3D=3D"
+echo
+
+IMGOPTS=3D"backing_file=3D$TEST_IMG.base" _make_test_img $size
+cat <<EOF |
+nbd_server_start unix:$TEST_DIR/nbd
+nbd_server_add -w backing-fmt
+savevm snap0
+info snapshots
+loadvm snap0
+EOF
+run_qemu -blockdev driver=3Dfile,filename=3D"$TEST_IMG.base",node-name=3D=
backing-file \
+         -blockdev driver=3D$IMGFMT,file=3Dbacking-file,node-name=3Dback=
ing-fmt \
+         -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-name=3Dfile=
 \
+         -blockdev driver=3D$IMGFMT,file=3Dfile,backing=3Dbacking-fmt,no=
de-name=3Dfmt |
+         _filter_date
+
+# This time, a snapshot should be created on both files
+echo Internal snapshots on overlay:
+$QEMU_IMG snapshot -l "$TEST_IMG" | _filter_date
+
+echo Internal snapshots on backing file:
+$QEMU_IMG snapshot -l "$TEST_IMG.base" | _filter_date
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
new file mode 100644
index 0000000000..bb13f0ae3c
--- /dev/null
+++ b/tests/qemu-iotests/267.out
@@ -0,0 +1,182 @@
+QA output created by 267
+
+=3D=3D=3D No block devices at all =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
+Testing:
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+Error: No block device can accept snapshots
+(qemu) info snapshots
+No available block device supports snapshots
+(qemu) loadvm snap0
+Error: No block device supports snapshots
+(qemu) quit
+
+
+=3D=3D=3D -drive if=3Dnone =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
+Testing: -drive driver=3Dfile,file=3DTEST_DIR/t.IMGFMT,if=3Dnone
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+Error: Device 'none0' is writable but does not support snapshots
+(qemu) info snapshots
+No available block device supports snapshots
+(qemu) loadvm snap0
+Error: Device 'none0' is writable but does not support snapshots
+(qemu) quit
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
+Testing: -drive driver=3DIMGFMT,file=3DTEST_DIR/t.IMGFMT,if=3Dnone
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0               591 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
+Testing: -drive driver=3DIMGFMT,file=3DTEST_DIR/t.IMGFMT,if=3Dnone -devi=
ce virtio-blk,drive=3Dnone0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0               636 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+
+=3D=3D=3D -drive if=3Dvirtio =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
+Testing: -drive driver=3Dfile,file=3DTEST_DIR/t.IMGFMT,if=3Dvirtio
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+Error: Device 'virtio0' is writable but does not support snapshots
+(qemu) info snapshots
+No available block device supports snapshots
+(qemu) loadvm snap0
+Error: Device 'virtio0' is writable but does not support snapshots
+(qemu) quit
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
+Testing: -drive driver=3DIMGFMT,file=3DTEST_DIR/t.IMGFMT,if=3Dvirtio
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0               636 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+
+=3D=3D=3D Simple -blockdev =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
+Testing: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-name=3D=
file
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+Error: Device '' is writable but does not support snapshots
+(qemu) info snapshots
+No available block device supports snapshots
+(qemu) loadvm snap0
+Error: Device '' is writable but does not support snapshots
+(qemu) quit
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
+Testing: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-name=3D=
file -blockdev driver=3DIMGFMT,file=3Dfile,node-name=3Dfmt
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0               591 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
+Testing: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-name=3D=
file -blockdev driver=3Draw,file=3Dfile,node-name=3Draw -blockdev driver=3D=
IMGFMT,file=3Draw,node-name=3Dfmt
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0               591 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+
+=3D=3D=3D -blockdev with a filter on top =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
+Testing: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-name=3D=
file -blockdev driver=3DIMGFMT,file=3Dfile,node-name=3Dfmt -blockdev driv=
er=3Dcopy-on-read,file=3Dfmt,node-name=3Dfilter
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0               591 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+
+=3D=3D=3D -blockdev with a backing file =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_fi=
le=3DTEST_DIR/t.IMGFMT.base
+Testing: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT.base,node-=
name=3Dbacking-file -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,=
node-name=3Dfile -blockdev driver=3DIMGFMT,file=3Dfile,backing=3Dbacking-=
file,node-name=3Dfmt
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0               591 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_fi=
le=3DTEST_DIR/t.IMGFMT.base
+Testing: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT.base,node-=
name=3Dbacking-file -blockdev driver=3DIMGFMT,file=3Dbacking-file,node-na=
me=3Dbacking-fmt -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,nod=
e-name=3Dfile -blockdev driver=3DIMGFMT,file=3Dfile,backing=3Dbacking-fmt=
,node-name=3Dfmt
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0               591 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+Internal snapshots on overlay:
+Snapshot list:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+1         snap0               591 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+Internal snapshots on backing file:
+
+=3D=3D=3D -blockdev with NBD server on the backing file =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_fi=
le=3DTEST_DIR/t.IMGFMT.base
+Testing: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT.base,node-=
name=3Dbacking-file -blockdev driver=3DIMGFMT,file=3Dbacking-file,node-na=
me=3Dbacking-fmt -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,nod=
e-name=3Dfile -blockdev driver=3DIMGFMT,file=3Dfile,backing=3Dbacking-fmt=
,node-name=3Dfmt
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) nbd_server_start unix:TEST_DIR/nbd
+(qemu) nbd_server_add -w backing-fmt
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0               591 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+Internal snapshots on overlay:
+Snapshot list:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+1         snap0                   0 B yyyy-mm-dd hh:mm:ss   00:00:00.000
+Internal snapshots on backing file:
+Snapshot list:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+1         snap0               591 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+*** done
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common=
.filter
index 445a1c23e0..841f7642af 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -19,12 +19,9 @@
 # standard filters
 #
=20
-# ctime(3) dates
-#
 _filter_date()
 {
-    $SED \
-        -e 's/[A-Z][a-z][a-z] [A-z][a-z][a-z]  *[0-9][0-9]* [0-9][0-9]:[=
0-9][0-9]:[0-9][0-9] [0-9][0-9][0-9][0-9]$/DATE/'
+    $SED -re 's/[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}/yy=
yy-mm-dd hh:mm:ss/'
 }
=20
 _filter_generated_node_ids()
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 5d3da937e4..5805a79d9e 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -277,3 +277,4 @@
 263 rw quick
 265 rw auto quick
 266 rw quick
+267 rw auto quick snapshot
--=20
2.20.1


