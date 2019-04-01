Received: from eggs.gnu.org ([209.51.188.92]:42713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB471-0003XJ-8Y
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB470-0004tP-6p
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48280
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB46z-0004es-T6
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:58 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4NGG017084
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:32 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rks40kg10-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:28 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:53 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:48 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-75-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 74/97] iotests: make 235 work on s390 (and
 others)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Kevin Wolf <kwolf@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

"-machine pc" will not work all architectures. Lets fall back to the
default machine by not specifying it.

In addition we also need to specify -no-shutdown on s390 as qemu will
exit otherwise.

Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 2c26e648e4350079b0c86a6627b2d3566c3709c0)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/235 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
index da044ed34e..d6edd97ab4 100755
--- a/tests/qemu-iotests/235
+++ b/tests/qemu-iotests/235
@@ -49,7 +49,9 @@ qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocation=metadata', disk,
                 str(size))
 
 vm = QEMUMachine(iotests.qemu_prog)
-vm.add_args('-machine', 'pc,accel=kvm')
+vm.add_args('-machine', 'accel=kvm')
+if iotests.qemu_default_machine == 's390-ccw-virtio':
+        vm.add_args('-no-shutdown')
 vm.add_args('-drive', 'id=src,file=' + disk)
 vm.launch()
 
-- 
2.17.1
