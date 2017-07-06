Received: from eggs.gnu.org ([2001:4830:134:3::10]:49436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dT18w-0003At-B7
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dT18r-0005Ns-AB
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:24:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dT18r-0005NF-0G
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:24:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v667NwA9005141
	for <qemu-devel@nongnu.org>; Thu, 6 Jul 2017 03:23:59 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bgwen653e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 03:23:59 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 6 Jul 2017 08:23:44 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu,  6 Jul 2017 09:23:36 +0200
In-Reply-To: <1499325817-9166-1-git-send-email-borntraeger@de.ibm.com>
References: <1499325817-9166-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499325817-9166-8-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 7/8] virtio-scsi-ccw: use ioeventfd even when
 KVM is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: QingFeng Hao <haoqf@linux.vnet.ibm.com>

This patch is based on a similar patch from Stefan Hajnoczi -
commit c324fd0a39c ("virtio-pci: use ioeventfd even when KVM is disabled")

Do not check kvm_eventfds_enabled() when KVM is disabled since it
always returns 0.  Since commit 8c56c1a592b5092d91da8d8943c17777d6462a6f
("memory: emulate ioeventfd") it has been possible to use ioeventfds in
qtest or TCG mode.

This patch makes -device virtio-scsi-ccw,iothread=iothread0 work even
when KVM is disabled.
Currently we don't have an equivalent to "memory: emulate ioeventfd"
for ccw yet, but that this doesn't hurt and qemu-iotests 068 can pass with
skipping iothread arguments.

I have tested that virtio-scsi-ccw works under tcg both with and without
iothread.

This patch fixes qemu-iotests 068, which was accidentally merged early
despite the dependency on ioeventfd.

Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20170704132350.11874-2-haoqf@linux.vnet.ibm.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/virtio-ccw.c | 2 +-
 target/s390x/cpu.h    | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index f0e7fc8..e18fd26 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -789,7 +789,7 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
         sch->cssid, sch->ssid, sch->schid, sch->devno,
         ccw_dev->devno.valid ? "user-configured" : "auto-configured");
 
-    if (!kvm_eventfds_enabled()) {
+    if (kvm_enabled() && !kvm_eventfds_enabled()) {
         dev->flags &= ~VIRTIO_CCW_FLAG_USE_IOEVENTFD;
     }
 
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 9faca04..bdb9bdb 100644
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
2.7.4
