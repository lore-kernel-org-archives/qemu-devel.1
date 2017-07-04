Received: from eggs.gnu.org ([2001:4830:134:3::10]:53125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSOUt-00088i-Vy
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSOUp-0003XO-V4
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:08:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dSOUp-0003Wk-Kc
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:08:07 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v64E4VIQ000778
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 10:08:06 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bg6j6jt12-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 10:08:06 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 4 Jul 2017 15:08:03 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue,  4 Jul 2017 16:07:56 +0200
In-Reply-To: <1499177279-131407-1-git-send-email-borntraeger@de.ibm.com>
References: <1499177279-131407-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499177279-131407-5-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 4/7] s390x: fix realize inheritance for kvm-flic
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

Commit f6f4ce4211 ("s390x: add property adapter_routes_max_batch",
2016-12-09) introduces a common realize (intended to be common for all
the subclasses) for flic, but fails to make sure the kvm-flic which had
it's own is actually calling this common realize.

This omission fortunately does not result in a grave problem. The common
realize was only supposed to catch a possible programming mistake by
validating a value of a property set via the compat machine macros. Since
there was no programming mistake we don't need this fixed for stable.

Let's fix this problem by making sure kvm flic honors the realize of its
parent class.

Let us also improve on the error message we would hypothetically emit
when the validation fails.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Fixes: f6f4ce4211 ("s390x: add property adapter_routes_max_batch")
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/intc/s390_flic.c     |  4 ++--
 hw/intc/s390_flic_kvm.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index a99a350..837158b 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -101,8 +101,8 @@ static void s390_flic_common_realize(DeviceState *dev, Error **errp)
     uint32_t max_batch = S390_FLIC_COMMON(dev)->adapter_routes_max_batch;
 
     if (max_batch > ADAPTER_ROUTES_MAX_GSI) {
-        error_setg(errp, "flic adapter_routes_max_batch too big"
-                   "%d (%d allowed)", max_batch, ADAPTER_ROUTES_MAX_GSI);
+        error_setg(errp, "flic property adapter_routes_max_batch too big"
+                   " (%d > %d)", max_batch, ADAPTER_ROUTES_MAX_GSI);
     }
 }
 
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index bea3997..535d99d 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -392,6 +392,17 @@ static const VMStateDescription kvm_s390_flic_vmstate = {
     }
 };
 
+typedef struct KVMS390FLICStateClass {
+    S390FLICStateClass parent_class;
+    DeviceRealize parent_realize;
+} KVMS390FLICStateClass;
+
+#define KVM_S390_FLIC_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(KVMS390FLICStateClass, (obj), TYPE_KVM_S390_FLIC)
+
+#define KVM_S390_FLIC_CLASS(klass) \
+    OBJECT_CLASS_CHECK(KVMS390FLICStateClass, (klass), TYPE_KVM_S390_FLIC)
+
 static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
 {
     KVMS390FLICState *flic_state = KVM_S390_FLIC(dev);
@@ -400,6 +411,10 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
     int ret;
     Error *errp_local = NULL;
 
+    KVM_S390_FLIC_GET_CLASS(dev)->parent_realize(dev, &errp_local);
+    if (errp_local) {
+        goto fail;
+    }
     flic_state->fd = -1;
     if (!kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
         error_setg_errno(&errp_local, errno, "KVM is missing capability"
@@ -454,6 +469,7 @@ static void kvm_s390_flic_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     S390FLICStateClass *fsc = S390_FLIC_COMMON_CLASS(oc);
 
+    KVM_S390_FLIC_CLASS(oc)->parent_realize = dc->realize;
     dc->realize = kvm_s390_flic_realize;
     dc->vmsd = &kvm_s390_flic_vmstate;
     dc->reset = kvm_s390_flic_reset;
@@ -468,6 +484,7 @@ static const TypeInfo kvm_s390_flic_info = {
     .name          = TYPE_KVM_S390_FLIC,
     .parent        = TYPE_S390_FLIC_COMMON,
     .instance_size = sizeof(KVMS390FLICState),
+    .class_size    = sizeof(KVMS390FLICStateClass),
     .class_init    = kvm_s390_flic_class_init,
 };
 
-- 
2.7.4
