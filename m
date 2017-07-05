Received: from eggs.gnu.org ([2001:4830:134:3::10]:42455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dSg0f-0000fs-7a
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dSg0c-00057z-6C
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:50:09 -0400
Received: from 5.mo4.mail-out.ovh.net ([188.165.44.50]:46991)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dSg0b-00057k-Vi
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:50:06 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 107B582670
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 10:50:04 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 05 Jul 2017 10:49:52 +0200
Message-ID: <149924459296.25523.6693809356627708668.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] ppc/kvm: have the "family" CPU alias to point
 to TYPE_HOST_POWERPC_CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

When running KVM on POWER, we allow the user to pass "-cpu POWERx" instead
of "-cpu host". This is achieved by patching the ppc_cpu_aliases[] array
so that "POWERx" points to the CPU class with the same PVR as the host CPU.
This causes CPUs to be instantiated from this CPU class instead of the
TYPE_HOST_POWERPC_CPU class which is used with "-cpu host". These CPUs thus
miss all the KVM specific tuning from kvmppc_host_cpu_class_init().

This currently causes QEMU with "-cpu POWER9" to fail when running KVM on a
POWER9 DD1 host:

qemu-system-ppc64: Register sync failed... If you're using kvm-hv.ko, only
 "-cpu host" is possible
kvm_init_vcpu failed: Invalid argument

Let's have the "POWERx" alias to point to TYPE_HOST_POWERPC_CPU directly,
so that "-cpu POWERx" instantiates CPUs from the same class as "-cpu host".

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/kvm.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index f2f7c531bc7b..f7a7ea5858a3 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2445,6 +2445,7 @@ static int kvm_ppc_register_host_cpu_type(void)
         .class_init = kvmppc_host_cpu_class_init,
     };
     PowerPCCPUClass *pvr_pcc;
+    ObjectClass *oc;
     DeviceClass *dc;
     int i;
 
@@ -2455,6 +2456,9 @@ static int kvm_ppc_register_host_cpu_type(void)
     type_info.parent = object_class_get_name(OBJECT_CLASS(pvr_pcc));
     type_register(&type_info);
 
+    oc = object_class_by_name(type_info.name);
+    g_assert(oc);
+
 #if defined(TARGET_PPC64)
     type_info.name = g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, "host");
     type_info.parent = TYPE_SPAPR_CPU_CORE,
@@ -2474,7 +2478,6 @@ static int kvm_ppc_register_host_cpu_type(void)
     dc = DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
     for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
         if (strcmp(ppc_cpu_aliases[i].alias, dc->desc) == 0) {
-            ObjectClass *oc = OBJECT_CLASS(pvr_pcc);
             char *suffix;
 
             ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));
