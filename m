Received: from eggs.gnu.org ([209.51.188.92]:41003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44g-0001UZ-5P
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44e-0003VL-NX
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53112
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44e-0003Li-FX
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:32 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1pox095693
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:20 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkswegwwp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:19 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:18 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:16 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-43-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 42/97] block/rbd: add iotest for rbd legacy
 keyvalue filename parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jeff Cody <jcody@redhat.com>

From: Jeff Cody <jcody@redhat.com>

This is a small test that will check for the ability to parse
both legacy and modern options for rbd.

The way the test is set up is for failure to occur, but without
having to wait to timeout on a non-existent rbd server.  The error
messages in the success path show that the arguments were parsed.

The failure behavior prior to the patch series that has this test, is
qemu-img complaining about mandatory options (e.g. 'pool') not being
provided.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
Message-id: f830580e339b974a83ed4870d11adcdc17f49a47.1536704901.git.jcody@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
(cherry picked from commit 66e6a735e97450ac50fcaf40f78600c688534cae)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/231     | 62 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/231.out |  9 ++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 72 insertions(+)
 create mode 100755 tests/qemu-iotests/231
 create mode 100644 tests/qemu-iotests/231.out

diff --git a/tests/qemu-iotests/231 b/tests/qemu-iotests/231
new file mode 100755
index 0000000000..3e283708b4
--- /dev/null
+++ b/tests/qemu-iotests/231
@@ -0,0 +1,62 @@
+#!/bin/bash
+#
+# Test legacy and modern option parsing for rbd/ceph.  This will not
+# actually connect to a ceph server, but rather looks for the appropriate
+# error message that indicates we parsed the options correctly.
+#
+# Copyright (C) 2018 Red Hat, Inc.
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
+owner=jcody@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+
+_cleanup()
+{
+    rm "${BOGUS_CONF}"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt generic
+_supported_proto rbd
+_supported_os Linux
+
+BOGUS_CONF=${TEST_DIR}/ceph-$$.conf
+touch "${BOGUS_CONF}"
+
+_filter_conf()
+{
+    sed -e "s#$BOGUS_CONF#BOGUS_CONF#g"
+}
+
+# We expect this to fail, with no monitor ip provided and a null conf file.  Just want it
+# to fail in the right way.
+$QEMU_IMG info "json:{'file.driver':'rbd','file.filename':'rbd:rbd/bogus:conf=${BOGUS_CONF}'}" 2>&1 | _filter_conf
+$QEMU_IMG info "json:{'file.driver':'rbd','file.pool':'rbd','file.image':'bogus','file.conf':'${BOGUS_CONF}'}" 2>&1 | _filter_conf
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/231.out b/tests/qemu-iotests/231.out
new file mode 100644
index 0000000000..579ba11c16
--- /dev/null
+++ b/tests/qemu-iotests/231.out
@@ -0,0 +1,9 @@
+QA output created by 231
+qemu-img: RBD options encoded in the filename as keyvalue pairs is deprecated.  Future versions may cease to parse these options in the future.
+unable to get monitor info from DNS SRV with service name: ceph-mon
+no monitors specified to connect to.
+qemu-img: Could not open 'json:{'file.driver':'rbd','file.filename':'rbd:rbd/bogus:conf=BOGUS_CONF'}': error connecting: No such file or directory
+unable to get monitor info from DNS SRV with service name: ceph-mon
+no monitors specified to connect to.
+qemu-img: Could not open 'json:{'file.driver':'rbd','file.pool':'rbd','file.image':'bogus','file.conf':'BOGUS_CONF'}': error connecting: No such file or directory
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 743790745b..31f6e77dcb 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -226,3 +226,4 @@
 226 auto quick
 227 auto quick
 229 auto quick
+231 auto quick
-- 
2.17.1
