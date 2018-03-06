Received: from eggs.gnu.org ([2001:4830:134:3::10]:33222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1et7R8-0005sL-T1
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:55:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1et7R4-0000OA-Vr
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:55:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1et7R4-0000NZ-Oc
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:54:58 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w267sHMU140363
	for <qemu-devel@nongnu.org>; Tue, 6 Mar 2018 02:54:57 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ghnretre6-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 02:54:57 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Tue, 6 Mar 2018 07:54:54 -0000
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Tue,  6 Mar 2018 08:54:48 +0100
Message-Id: <20180306075448.1179-1-haoqf@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 1/1] iotests: bypass s390x for case 200
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peterx@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, famz@redhat.com, QingFeng Hao <haoqf@linux.vnet.ibm.com>

In s390x, the case 200 failed as:
 === Starting QEMU VM ===

+QEMU_PROG: boot menu is not supported for this device type.
 {"return": {}}

 === Sending stream/cancel, checking for SIGSEGV only ===
Failures: 200
Failed 1 of 1 tests

It was caused by the command which isn't supported by s390x now:
qemu-system-s390x -device pci-bridge,id=bridge1,chassis_nr=1,bus=pci.0 -object iothread,id=iothread0 -device virtio-scsi-pci,bus=bridge1,addr=0x1f,id=scsi0,iothread=iothread0 -drive file=.../scratch/test.img,media=disk,if=none,cache=writeback,id=drive_sysdisk,format=qcow2 -device scsi-hd,drive=drive_sysdisk,bus=scsi0.0,id=sysdisk,bootindex=0 -nographic

Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
---
 tests/qemu-iotests/200 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index ddbdedc476..7e53bd7774 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -45,6 +45,10 @@ _supported_fmt qcow2 qed
 _supported_proto file
 _supported_os Linux
 
+if [ "$QEMU_DEFAULT_MACHINE" != "pc" ]; then
+    _notrun "Requires a PC machine"
+fi
+
 BACKING_IMG="${TEST_DIR}/backing.img"
 TEST_IMG="${TEST_DIR}/test.img"
 
-- 
2.13.5
