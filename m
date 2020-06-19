Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6337EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 02:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B5B20773
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 02:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="drqFS3tp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B5B20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm6RV-0005Lm-Cb
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 22:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jm6Q6-0002wE-5p; Thu, 18 Jun 2020 22:06:18 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:48763)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jm6Q1-0000nR-Qf; Thu, 18 Jun 2020 22:06:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49p2GS51gdz9sSf; Fri, 19 Jun 2020 12:06:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1592532368;
 bh=Tyfc+G1PqLXR9Edr87dtqwm5FYWBIwO1iB0LtB7dWSM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=drqFS3tpsGIz2+f7bAqa/NyDDVa8fH74EB+evMxQBZ+GKXjKVqjxhls6+I8ngzm4X
 aYxiIo3goBkbOVNhJO3Kxp/sVaSHSc8Yn/BFhn0ZiluUUAP7vKlkigQ70pu7WuRso9
 DHGoeXqhC1s5d09Esffgc94vIW1vDMUjWYMAEf6g=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org, brijesh.singh@amd.com, pair@us.ibm.com,
 pbonzini@redhat.com, dgilbert@redhat.com, frankja@linux.ibm.com
Subject: [PATCH v3 4/9] host trust limitation: Rework the "memory-encryption"
 property
Date: Fri, 19 Jun 2020 12:05:57 +1000
Message-Id: <20200619020602.118306-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200619020602.118306-1-david@gibson.dropbear.id.au>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, mst@redhat.com,
 cohuck@redhat.com, david@redhat.com, mdroth@linux.vnet.ibm.com,
 pasic@linux.ibm.com, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the "memory-encryption" property is only looked at once we get to
kvm_init().  Although protection of guest memory from the hypervisor isn't
something that could really ever work with TCG, it's not conceptually tied
to the KVM accelerator.

In addition, the way the string property is resolved to an object is
almost identical to how a QOM link property is handled.

So, create a new "host-trust-limitation" link property which sets this QOM
interface link directly in the machine.  For compatibility we keep the
"memory-encryption" property, but now implemented in terms of the new
property.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 accel/kvm/kvm-all.c | 23 +++++++----------------
 hw/core/machine.c   | 41 ++++++++++++++++++++++++++++++++++++-----
 include/hw/boards.h |  2 +-
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 1e43e27f45..d8e8fa345e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2180,25 +2180,16 @@ static int kvm_init(MachineState *ms)
      * if memory encryption object is specified then initialize the memory
      * encryption context.
      */
-    if (ms->memory_encryption) {
-        Object *obj = object_resolve_path_component(object_get_objects_root(),
-                                                    ms->memory_encryption);
-
-        if (object_dynamic_cast(obj, TYPE_HOST_TRUST_LIMITATION)) {
-            HostTrustLimitation *htl = HOST_TRUST_LIMITATION(obj);
-            HostTrustLimitationClass *htlc
-                = HOST_TRUST_LIMITATION_GET_CLASS(htl);
-
-            ret = htlc->kvm_init(htl);
-            if (ret < 0) {
-                goto err;
-            }
+    if (ms->htl) {
+        HostTrustLimitationClass *htlc =
+            HOST_TRUST_LIMITATION_GET_CLASS(ms->htl);
 
-            kvm_state->htl = htl;
-        } else {
-            ret = -1;
+        ret = htlc->kvm_init(ms->htl);
+        if (ret < 0) {
             goto err;
         }
+
+        kvm_state->htl = ms->htl;
     }
 
     ret = kvm_arch_init(ms, s);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index fdc0c7e038..a71792bc16 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -27,6 +27,7 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
 #include "migration/vmstate.h"
+#include "exec/host-trust-limitation.h"
 
 GlobalProperty hw_compat_5_0[] = {
     { "virtio-balloon-device", "page-poison", "false" },
@@ -425,16 +426,37 @@ static char *machine_get_memory_encryption(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
 
-    return g_strdup(ms->memory_encryption);
+    if (ms->htl) {
+        return object_get_canonical_path_component(OBJECT(ms->htl));
+    }
+
+    return NULL;
 }
 
 static void machine_set_memory_encryption(Object *obj, const char *value,
                                         Error **errp)
 {
-    MachineState *ms = MACHINE(obj);
+    Object *htl =
+        object_resolve_path_component(object_get_objects_root(), value);
+
+    if (!htl) {
+        error_setg(errp, "No such memory encryption object '%s'", value);
+        return;
+    }
 
-    g_free(ms->memory_encryption);
-    ms->memory_encryption = g_strdup(value);
+    object_property_set_link(obj, htl, "host-trust-limitation", errp);
+}
+
+static void machine_check_host_trust_limitation(const Object *obj,
+                                                const char *name,
+                                                Object *new_target,
+                                                Error **errp)
+{
+    /*
+     * So far the only constraint is that the target has the
+     * TYPE_HOST_TRUST_LIMITATION interface, and that's checked by the
+     * QOM core
+     */
 }
 
 static bool machine_get_nvdimm(Object *obj, Error **errp)
@@ -855,6 +877,15 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "enforce-config-section",
         "Set on to enforce configuration section migration");
 
+    object_class_property_add_link(oc, "host-trust-limitation",
+                                   TYPE_HOST_TRUST_LIMITATION,
+                                   offsetof(MachineState, htl),
+                                   machine_check_host_trust_limitation,
+                                   OBJ_PROP_LINK_STRONG);
+    object_class_property_set_description(oc, "host-trust-limitation",
+        "Set host trust limitation object to use");
+
+    /* For compatibility */
     object_class_property_add_str(oc, "memory-encryption",
         machine_get_memory_encryption, machine_set_memory_encryption);
     object_class_property_set_description(oc, "memory-encryption",
@@ -1127,7 +1158,7 @@ void machine_run_board_init(MachineState *machine)
         }
     }
 
-    if (machine->memory_encryption) {
+    if (machine->htl) {
         /*
          * With host trust limitation, the host can't see the real
          * contents of RAM, so there's no point in it trying to merge
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 18815d9be2..a9f8444729 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -277,7 +277,7 @@ struct MachineState {
     bool suppress_vmdesc;
     bool enforce_config_section;
     bool enable_graphics;
-    char *memory_encryption;
+    HostTrustLimitation *htl;
     char *ram_memdev_id;
     /*
      * convenience alias to ram_memdev_id backend memory region
-- 
2.26.2


