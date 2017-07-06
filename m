Received: from eggs.gnu.org ([2001:4830:134:3::10]:49382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dT18o-00035R-6m
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dT18j-0005JE-5b
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:23:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dT18i-0005Is-RL
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:23:53 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v667NoSl089381
	for <qemu-devel@nongnu.org>; Thu, 6 Jul 2017 03:23:51 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bh38m5vuf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 03:23:50 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 6 Jul 2017 08:23:43 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu,  6 Jul 2017 09:23:32 +0200
In-Reply-To: <1499325817-9166-1-git-send-email-borntraeger@de.ibm.com>
References: <1499325817-9166-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499325817-9166-4-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 3/8] s390x: fix error propagation in kvm-flic's
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

>From the moment it was introduced by commit a2875e6f98 ("s390x/kvm:
implement floating-interrupt controller device", 2013-07-16) the kvm-flic
is not making realize fail properly in case it's impossible to create the
KVM device which basically serves as a backend and is absolutely
essential for having an operational kvm-flic.

Let's fix this by making sure we do proper error propagation in realize.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Fixes: a2875e6f98 "s390x/kvm: implement floating-interrupt controller device"
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/intc/s390_flic_kvm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index b4c61d8..56f1b81 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -15,6 +15,7 @@
 #include "cpu.h"
 #include <sys/ioctl.h>
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "sysemu/kvm.h"
 #include "hw/s390x/s390_flic.h"
@@ -397,18 +398,22 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
     struct kvm_create_device cd = {0};
     struct kvm_device_attr test_attr = {0};
     int ret;
+    Error *errp_local = NULL;
 
     flic_state->fd = -1;
     if (!kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
+        error_setg_errno(&errp_local, errno, "KVM is missing capability"
+                         " KVM_CAP_DEVICE_CTRL");
         trace_flic_no_device_api(errno);
-        return;
+        goto fail;
     }
 
     cd.type = KVM_DEV_TYPE_FLIC;
     ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd);
     if (ret < 0) {
+        error_setg_errno(&errp_local, errno, "Creating the KVM device failed");
         trace_flic_create_device(errno);
-        return;
+        goto fail;
     }
     flic_state->fd = cd.fd;
 
@@ -417,6 +422,9 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
     flic_state->clear_io_supported = !ioctl(flic_state->fd,
                                             KVM_HAS_DEVICE_ATTR, test_attr);
 
+    return;
+fail:
+    error_propagate(errp, errp_local);
 }
 
 static void kvm_s390_flic_reset(DeviceState *dev)
-- 
2.7.4
