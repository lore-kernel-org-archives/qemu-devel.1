Received: from eggs.gnu.org ([2001:4830:134:3::10]:53126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSOUt-00088j-W9
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSOUp-0003XI-Ti
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:08:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dSOUp-0003Wi-Jh
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:08:07 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v64E4VgZ134827
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 10:08:06 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bg8uv0vv4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 10:08:05 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 4 Jul 2017 15:08:03 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue,  4 Jul 2017 16:07:55 +0200
In-Reply-To: <1499177279-131407-1-git-send-email-borntraeger@de.ibm.com>
References: <1499177279-131407-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499177279-131407-4-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 3/7] s390x: fix error propagation in kvm-flic's
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
 hw/intc/s390_flic_kvm.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index b4c61d8..bea3997 100644
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
-        trace_flic_create_device(errno);
-        return;
+        error_setg_errno(&errp_local, errno, "Creating the KVM device failed");
+        trace_flic_no_device_api(errno);
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
