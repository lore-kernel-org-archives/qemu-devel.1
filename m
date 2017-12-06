Received: from eggs.gnu.org ([2001:4830:134:3::10]:49447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCS-0000iX-LY
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCP-0000gQ-DF
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34444
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCP-0000fk-64
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:41 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE85d036928
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:40 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epne8b8m9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:40 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:40 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:29 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-37-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 36/55] hw/intc/arm_gicv3_its: Don't abort on
 table save failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Auger <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Eric Auger <eric.auger@redhat.com>

The ITS is not fully properly reset at the moment. Caches are
not emptied.

After a reset, in case we attempt to save the state before
the bound devices have registered their MSIs and after the
1st level table has been allocated by the ITS driver
(device BASER is valid), the first level entries are still
invalid. If the device cache is not empty (devices registered
before the reset), vgic_its_save_device_tables fails with -EINVAL.
This causes a QEMU abort().

Cc: qemu-stable@nongnu.org
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: wanghaibin <wanghaibin.wang@huawei.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 8a7348b5d62d7ea16807e6bea54b448a0184bb0f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/intc/arm_gicv3_its_kvm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 1f8991b8a6..1cc58c2da3 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -64,20 +64,16 @@ static void vm_change_state_handler(void *opaque, int running,
 {
     GICv3ITSState *s = (GICv3ITSState *)opaque;
     Error *err = NULL;
-    int ret;
 
     if (running) {
         return;
     }
 
-    ret = kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
-                            KVM_DEV_ARM_ITS_SAVE_TABLES, NULL, true, &err);
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+                      KVM_DEV_ARM_ITS_SAVE_TABLES, NULL, true, &err);
     if (err) {
         error_report_err(err);
     }
-    if (ret < 0 && ret != -EFAULT) {
-        abort();
-    }
 }
 
 static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
-- 
2.11.0
