Received: from eggs.gnu.org ([2001:4830:134:3::10]:47900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dRvxB-0006JI-R8
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dRvx8-00012L-OP
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:39:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44681
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1dRvx8-000122-IN
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:39:26 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v637dNi2052128
	for <qemu-devel@nongnu.org>; Mon, 3 Jul 2017 03:39:25 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bf13v4fm3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 03:39:24 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Mon, 3 Jul 2017 08:38:50 +0100
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Mon,  3 Jul 2017 09:38:36 +0200
In-Reply-To: <20170703073836.72092-1-haoqf@linux.vnet.ibm.com>
References: <20170703073836.72092-1-haoqf@linux.vnet.ibm.com>
Message-Id: <20170703073836.72092-2-haoqf@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] virtio-scsi-ccw: use ioeventfd even when
 KVM is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, stefanha@redhat.com, kwolf@redhat.com, famz@redhat.com, peterx@redhat.com, QingFeng Hao <haoqf@linux.vnet.ibm.com>

Do not check kvm_eventfds_enabled() when KVM is disabled since it
always returns 0.  Since commit 8c56c1a592b5092d91da8d8943c17777d6462a6f
("memory: emulate ioeventfd") it has been possible to use ioeventfds in
qtest or TCG mode.

This patch makes -device virtio-scsi-ccw,iothread=iothread0 work even
when KVM is disabled.

I have tested that virtio-scsi-ccw works under tcg both with and without
iothread.

This patch fixes qemu-iotests 068, which was accidentally merged early
despite the dependency on ioeventfd.

Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/s390x/virtio-ccw.c | 2 +-
 target/s390x/kvm.c    | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 90d37cb9ff..35896eb007 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -711,7 +711,7 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
         sch->cssid, sch->ssid, sch->schid, sch->devno,
         ccw_dev->devno.valid ? "user-configured" : "auto-configured");
 
-    if (!kvm_eventfds_enabled()) {
+    if (kvm_enabled() && !kvm_eventfds_enabled()) {
         dev->flags &= ~VIRTIO_CCW_FLAG_USE_IOEVENTFD;
     }
 
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index a3d00196f4..c37f9c3b9e 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2220,6 +2220,9 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
         .addr = sch,
         .len = 8,
     };
+    if (!kvm_enabled()) {
+        return 0;
+    }
     if (!kvm_check_extension(kvm_state, KVM_CAP_IOEVENTFD)) {
         return -ENOSYS;
     }
-- 
2.11.2
