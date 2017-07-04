Received: from eggs.gnu.org ([2001:4830:134:3::10]:38671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dSJGK-0004h3-6C
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dSJGG-0004c1-88
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:32:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34156
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1dSJGG-0004bX-1W
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:32:44 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v648TDvP082806
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 04:32:42 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bg6gcv39e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 04:32:42 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Tue, 4 Jul 2017 09:32:40 +0100
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Tue,  4 Jul 2017 10:32:31 +0200
In-Reply-To: <20170704083231.98056-1-haoqf@linux.vnet.ibm.com>
References: <20170704083231.98056-1-haoqf@linux.vnet.ibm.com>
Message-Id: <20170704083231.98056-2-haoqf@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/1] virtio-scsi-ccw: use ioeventfd even
 when KVM is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, stefanha@redhat.com, kwolf@redhat.com, famz@redhat.com, peterx@redhat.com, cohuck@kernel.org, QingFeng Hao <haoqf@linux.vnet.ibm.com>

This patch is based on a similar patch from Stefan Hajnoczi -
commit c324fd0a39c (" virtio-pci: use ioeventfd even when KVM is disabled)

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
---
 hw/s390x/virtio-ccw.c | 2 +-
 target/s390x/cpu.h    | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

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
 
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 9faca04b52..bdb9bdbc9d 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -1264,7 +1264,11 @@ static inline int s390_assign_subch_ioeventfd(EventNotifier *notifier,
                                               uint32_t sch_id, int vq,
                                               bool assign)
 {
-    return kvm_s390_assign_subch_ioeventfd(notifier, sch_id, vq, assign);
+    if (kvm_enabled()) {
+        return kvm_s390_assign_subch_ioeventfd(notifier, sch_id, vq, assign);
+    } else {
+        return 0;
+    }
 }
 
 static inline void s390_crypto_reset(void)
-- 
2.11.2
