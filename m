Received: from eggs.gnu.org ([2001:4830:134:3::10]:34138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVq9D-0003nu-Eq
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVq99-0001M0-Ea
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:16:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVq99-0001Lc-81
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4934D369C9
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 02:15:58 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 14 Jul 2017 10:15:09 +0800
Message-Id: <20170714021509.23681-21-famz@redhat.com>
In-Reply-To: <20170714021509.23681-1-famz@redhat.com>
References: <20170714021509.23681-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 20/20] spapr_rng: Convert to DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/ppc/spapr_rng.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
index 80515eb..d2acd61 100644
--- a/hw/ppc/spapr_rng.c
+++ b/hw/ppc/spapr_rng.c
@@ -96,17 +96,11 @@ static target_ulong h_random(PowerPCCPU *cpu, sPAPRMachineState *spapr,
 
 static void spapr_rng_instance_init(Object *obj)
 {
-    sPAPRRngState *rngstate = SPAPR_RNG(obj);
-
     if (object_resolve_path_type("", TYPE_SPAPR_RNG, NULL) != NULL) {
         error_report("spapr-rng can not be instantiated twice!");
         return;
     }
 
-    object_property_add_link(obj, "rng", TYPE_RNG_BACKEND,
-                             (Object **)&rngstate->backend,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE, NULL);
     object_property_set_description(obj, "rng",
                                     "ID of the random number generator backend",
                                     NULL);
@@ -163,6 +157,8 @@ int spapr_rng_populate_dt(void *fdt)
 
 static Property spapr_rng_properties[] = {
     DEFINE_PROP_BOOL("use-kvm", sPAPRRngState, use_kvm, false),
+    DEFINE_PROP_LINK("rng", sPAPRRngState, backend, TYPE_RNG_BACKEND,
+                     RngBackend *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.9.4
