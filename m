Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2754CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 02:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5531206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 02:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nfyg+H1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5531206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jynvj-0000ZK-4g
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 22:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jynuL-0007Ef-1M; Thu, 23 Jul 2020 22:58:01 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51663 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jynuH-00060B-OC; Thu, 23 Jul 2020 22:58:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BCYlv4Z8Sz9sSn; Fri, 24 Jul 2020 12:57:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595559467;
 bh=R0fgLYiXYKzsBYFKyppNWeAvNHP70nX+ch1lmvuKdkA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nfyg+H1j2J84kBQamTgGTxcM7EJvrRZ+dLtwvoISyZJ9FIF3BwuTfOeq7x76/C0/W
 U4DTmGjwwPKE+0UwUR5DhjQcFxzLuHbN3JuJLtbWPvhqdT8k9qOKkbDOFpBjyR9HvI
 TRE7xA2fFVoIgxJ5fW2b5jvI2Y9BuFFLrtcEkyIc=
From: David Gibson <david@gibson.dropbear.id.au>
To: dgilbert@redhat.com, frankja@linux.ibm.com, pair@us.ibm.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, brijesh.singh@amd.com
Subject: [for-5.2 v4 04/10] host trust limitation: Rework the
 "memory-encryption" property
Date: Fri, 24 Jul 2020 12:57:38 +1000
Message-Id: <20200724025744.69644-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200724025744.69644-1-david@gibson.dropbear.id.au>
References: <20200724025744.69644-1-david@gibson.dropbear.id.au>
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
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 ehabkost@redhat.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, mdroth@linux.vnet.ibm.com,
 pasic@linux.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-all.c | 23 +++++++----------------
 hw/core/machine.c   | 41 ++++++++++++++++++++++++++++++++++++-----
 include/hw/boards.h |  2 +-
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d7d95eacc7..e2d8f47f93 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2186,25 +2186,16 @@ static int kvm_init(MachineState *ms)
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
index 035a1fc631..b599b0ba65 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -27,6 +27,7 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
 #include "migration/vmstate.h"
+#include "exec/host-trust-limitation.h"
 
 GlobalProperty hw_compat_5_0[] = {
     { "virtio-balloon-device", "page-poison", "false" },
@@ -422,16 +423,37 @@ static char *machine_get_memory_encryption(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
 
-    return g_strdup(ms->memory_encryption);
+    if (ms->htl) {
+        return g_strdup(object_get_canonical_path_component(OBJECT(ms->htl)));
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
+    object_property_set_link(obj, "host-trust-limitation", htl, errp);
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
@@ -852,6 +874,15 @@ static void machine_class_init(ObjectClass *oc, void *data)
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
@@ -1123,7 +1154,7 @@ void machine_run_board_init(MachineState *machine)
         }
     }
 
-    if (machine->memory_encryption) {
+    if (machine->htl) {
         /*
          * With host trust limitation, the host can't see the real
          * contents of RAM, so there's no point in it trying to merge
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 426ce5f625..c70fb8bd9f 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -278,7 +278,7 @@ struct MachineState {
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


