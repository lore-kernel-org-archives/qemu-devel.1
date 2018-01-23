Received: from eggs.gnu.org ([2001:4830:134:3::10]:44249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ee2nG-0002ml-8V
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 12:55:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ee2nB-0004E6-5m
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 12:55:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1ee2nA-0004DG-9j
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 12:55:28 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0NHtIbh011786
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 12:55:26 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fp9jpgq09-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 12:55:21 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 23 Jan 2018 10:54:19 -0700
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Tue, 23 Jan 2018 15:54:09 -0200
Message-Id: <20180123175409.9349-1-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2] kvm-all: Partially reverts 4fe6d78b2e to
 remove the cleanup call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com
Cc: anton@samba.org, danielhb@linux.vnet.ibm.com, ghammer@redhat.com

This commit partially reverts the commit 4fe6d78b2e because of issues
reported in the virtio.

Examples:

$ qemu-system-ppc64 -cpu POWER8 -nographic -vga none -m 4G \
  -M pseries,accel=kvm -netdev type=user,id=net0 \
  -device virtio-net-pci,netdev=net0 -drive file=../disk.qcow2,if=virtio

Populating /vdevice/nvram@71000001
Populating /vdevice/v-scsi@71000002
       SCSI: Looking for devices
          8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
Populating /pci@800000020000000
                     00 0000 (D) : 1af4 1000    virtio [ net ]
Aborted

$ qemu-system-x86_64 -m 4G -enable-kvm -drive file=util.qcow2,if=virtio

Running QEMU with GTK 2.x is deprecated, and will be removed
in a future release. Please switch to GTK 3.x instead
[1]    5282 abort

Reference http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg05457.html

Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 accel/kvm/kvm-all.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 071f4f57c0..f290f487a5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -812,10 +812,6 @@ static void kvm_mem_ioeventfd_del(MemoryListener *listener,
     if (r < 0) {
         abort();
     }
-
-    if (e->cleanup) {
-        e->cleanup(e);
-    }
 }
 
 static void kvm_io_ioeventfd_add(MemoryListener *listener,
-- 
2.14.3
