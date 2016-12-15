Received: from eggs.gnu.org ([2001:4830:134:3::10]:42315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBl-0002Op-Ko
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBi-0001Bw-Dm
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38417
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBi-0001BV-91
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:22 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0heJm140102
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:21 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm28w96-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:21 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:46:21 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:17 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-24-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 23/67] qcow2: fix encryption during cow of
 sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Broken in previous commit:

  commit aaa4d20b4972bb1a811ce929502e6741835d584e
  Author: Kevin Wolf <kwolf@redhat.com>
  Date:   Wed Jun 1 15:21:05 2016 +0200

      qcow2: Make copy_sectors() byte based

The copy_sectors() code was originally using the 'sector'
parameter for encryption, which was passed in by the caller
from the QCowL2Meta.offset field (aka the guest logical
offset).

After the change, the code is using 'cluster_offset' which
was passed in from QCow2L2Meta.alloc_offset field (aka the
host physical offset).

This would cause the data to be encrypted using an incorrect
initialization vector which will in turn cause later reads
to return garbage.

Although current qcow2 built-in encryption is blocked from
usage in the emulator, one could still hit this if writing
to the file via qemu-{img,io,nbd} commands.

Cc: qemu-stable@nongnu.org
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit bb9f8dd0e15a9744b8d09d06ecb6a18ca3dcc173)
Conflicts:
	tests/qemu-iotests/group

* drop context dependancy on non-2.7 iotest groups

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/qcow2-cluster.c      |  2 +-
 tests/qemu-iotests/158     | 80 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/158.out | 36 +++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/158
 create mode 100644 tests/qemu-iotests/158.out

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f941835..9ba2d71 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -427,7 +427,7 @@ static int coroutine_fn do_perform_cow(BlockDriverState *bs,
 
     if (bs->encrypted) {
         Error *err = NULL;
-        int64_t sector = (cluster_offset + offset_in_cluster)
+        int64_t sector = (src_cluster_offset + offset_in_cluster)
                          >> BDRV_SECTOR_BITS;
         assert(s->cipher);
         assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
new file mode 100755
index 0000000..a6cdd6d
--- /dev/null
+++ b/tests/qemu-iotests/158
@@ -0,0 +1,80 @@
+#!/bin/bash
+#
+# Test encrypted read/write using backing files
+#
+# Copyright (C) 2015 Red Hat, Inc.
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
+owner=berrange@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+
+_cleanup()
+{
+	_cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto generic
+_supported_os Linux
+
+
+size=128M
+TEST_IMG_BASE=$TEST_IMG.base
+
+TEST_IMG_SAVE=$TEST_IMG
+TEST_IMG=$TEST_IMG_BASE
+echo "== create base =="
+IMGOPTS="encryption=on" _make_test_img $size
+TEST_IMG=$TEST_IMG_SAVE
+
+echo
+echo "== writing whole image =="
+echo "astrochicken" | $QEMU_IO -c "write -P 0xa 0 $size" "$TEST_IMG_BASE" | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== verify pattern =="
+echo "astrochicken" | $QEMU_IO -c "read -P 0xa 0 $size" "$TEST_IMG_BASE" | _filter_qemu_io | _filter_testdir
+
+echo "== create overlay =="
+IMGOPTS="encryption=on" _make_test_img -b "$TEST_IMG_BASE" $size
+
+echo
+echo "== writing part of a cluster =="
+echo "astrochicken" | $QEMU_IO -c "write -P 0xe 0 1024" "$TEST_IMG" | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== verify pattern =="
+echo "astrochicken" | $QEMU_IO -c "read -P 0xe 0 1024" "$TEST_IMG" | _filter_qemu_io | _filter_testdir
+echo
+echo "== verify pattern =="
+echo "astrochicken" | $QEMU_IO -c "read -P 0xa 1024 64512" "$TEST_IMG" | _filter_qemu_io | _filter_testdir
+
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/158.out b/tests/qemu-iotests/158.out
new file mode 100644
index 0000000..b3f37e2
--- /dev/null
+++ b/tests/qemu-iotests/158.out
@@ -0,0 +1,36 @@
+QA output created by 158
+== create base ==
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728 encryption=on
+
+== writing whole image ==
+Disk image 'TEST_DIR/t.qcow2.base' is encrypted.
+password:
+wrote 134217728/134217728 bytes at offset 0
+128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify pattern ==
+Disk image 'TEST_DIR/t.qcow2.base' is encrypted.
+password:
+read 134217728/134217728 bytes at offset 0
+128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== create overlay ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base encryption=on
+
+== writing part of a cluster ==
+Disk image 'TEST_DIR/t.qcow2' is encrypted.
+password:
+wrote 1024/1024 bytes at offset 0
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify pattern ==
+Disk image 'TEST_DIR/t.qcow2' is encrypted.
+password:
+read 1024/1024 bytes at offset 0
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify pattern ==
+Disk image 'TEST_DIR/t.qcow2' is encrypted.
+password:
+read 64512/64512 bytes at offset 1024
+63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 50ddeed..ad3518d 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -157,4 +157,5 @@
 155 rw auto
 156 rw auto quick
 157 auto
+158 rw auto quick
 162 auto quick
-- 
1.9.1
