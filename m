Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5D1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 03:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B45920738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 03:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LH0pkriZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B45920738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbcCF-0003Py-Jn
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 23:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jbc7J-00036l-KH; Wed, 20 May 2020 23:43:33 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:57969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jbc7I-0003X1-4U; Wed, 20 May 2020 23:43:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49SFns4mdTz9sV0; Thu, 21 May 2020 13:43:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590032593;
 bh=U1JW5BDbXm0zdTvvoJUG5+cAZw/o4R4aBteoujOcyYA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LH0pkriZQttTukg4x4P39LZVM9wx+SFxVNcmLoSgpTodbLbDl8797SJBYknTwwNQI
 0LE1G2YvPXtlcGpCivrhkl/nRzxDs4FSvTPfZ0adx3s8pJQlSmaUifLRPCHQIF6tbA
 zMZclgtndQdlAXTNpTDXzhy0iW+qe5ue4uqBNw9M=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org, brijesh.singh@amd.com, frankja@linux.ibm.com,
 dgilbert@redhat.com, pair@us.ibm.com
Subject: [RFC v2 11/18] guest memory protection: Handle memory encrption via
 interface
Date: Thu, 21 May 2020 13:42:57 +1000
Message-Id: <20200521034304.340040-12-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521034304.340040-1-david@gibson.dropbear.id.au>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the moment AMD SEV sets a special function pointer, plus an opaque
handle in KVMState to let things know how to encrypt guest memory.

Now that we have a QOM interface for handling things related to guest
memory protection, use a QOM method on that interface, rather than a bare
function pointer for this.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 accel/kvm/kvm-all.c                    | 23 +++----
 accel/kvm/sev-stub.c                   |  5 --
 include/exec/guest-memory-protection.h |  2 +
 include/sysemu/sev.h                   |  6 +-
 target/i386/sev.c                      | 84 ++++++++++++++------------
 5 files changed, 63 insertions(+), 57 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d06cc04079..40997de38c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -45,6 +45,7 @@
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
 #include "sysemu/reset.h"
+#include "exec/guest-memory-protection.h"
 
 #include "hw/boards.h"
 
@@ -119,8 +120,7 @@ struct KVMState
     QLIST_HEAD(, KVMParkedVcpu) kvm_parked_vcpus;
 
     /* memory encryption */
-    void *memcrypt_handle;
-    int (*memcrypt_encrypt_data)(void *handle, uint8_t *ptr, uint64_t len);
+    GuestMemoryProtection *guest_memory_protection;
 
     /* For "info mtree -f" to tell if an MR is registered in KVM */
     int nr_as;
@@ -172,7 +172,7 @@ int kvm_get_max_memslots(void)
 
 bool kvm_memcrypt_enabled(void)
 {
-    if (kvm_state && kvm_state->memcrypt_handle) {
+    if (kvm_state && kvm_state->guest_memory_protection) {
         return true;
     }
 
@@ -181,10 +181,13 @@ bool kvm_memcrypt_enabled(void)
 
 int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
 {
-    if (kvm_state->memcrypt_handle &&
-        kvm_state->memcrypt_encrypt_data) {
-        return kvm_state->memcrypt_encrypt_data(kvm_state->memcrypt_handle,
-                                              ptr, len);
+    GuestMemoryProtection *gmpo = kvm_state->guest_memory_protection;
+
+    if (gmpo) {
+        GuestMemoryProtectionClass *gmpc =
+            GUEST_MEMORY_PROTECTION_GET_CLASS(gmpo);
+
+        return gmpc->encrypt_data(gmpo, ptr, len);
     }
 
     return 1;
@@ -2101,13 +2104,11 @@ static int kvm_init(MachineState *ms)
      * encryption context.
      */
     if (ms->memory_encryption) {
-        kvm_state->memcrypt_handle = sev_guest_init(ms->memory_encryption);
-        if (!kvm_state->memcrypt_handle) {
+        kvm_state->guest_memory_protection = sev_guest_init(ms->memory_encryption);
+        if (!kvm_state->guest_memory_protection) {
             ret = -1;
             goto err;
         }
-
-        kvm_state->memcrypt_encrypt_data = sev_encrypt_data;
     }
 
     ret = kvm_arch_init(ms, s);
diff --git a/accel/kvm/sev-stub.c b/accel/kvm/sev-stub.c
index 4f97452585..4a5cc5569e 100644
--- a/accel/kvm/sev-stub.c
+++ b/accel/kvm/sev-stub.c
@@ -15,11 +15,6 @@
 #include "qemu-common.h"
 #include "sysemu/sev.h"
 
-int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
-{
-    abort();
-}
-
 void *sev_guest_init(const char *id)
 {
     return NULL;
diff --git a/include/exec/guest-memory-protection.h b/include/exec/guest-memory-protection.h
index 38e9b01667..eb712a5804 100644
--- a/include/exec/guest-memory-protection.h
+++ b/include/exec/guest-memory-protection.h
@@ -30,6 +30,8 @@ typedef struct GuestMemoryProtection GuestMemoryProtection;
 
 typedef struct GuestMemoryProtectionClass {
     InterfaceClass parent;
+
+    int (*encrypt_data)(GuestMemoryProtection *, uint8_t *, uint64_t);
 } GuestMemoryProtectionClass;
 
 #endif /* QEMU_GUEST_MEMORY_PROTECTION_H */
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index 98c1ec8d38..7735a7942e 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -16,6 +16,8 @@
 
 #include "sysemu/kvm.h"
 
-void *sev_guest_init(const char *id);
-int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
+typedef struct GuestMemoryProtection GuestMemoryProtection;
+
+GuestMemoryProtection *sev_guest_init(const char *id);
+
 #endif
diff --git a/target/i386/sev.c b/target/i386/sev.c
index d273174ad3..986c2fee51 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -28,6 +28,7 @@
 #include "sysemu/runstate.h"
 #include "trace.h"
 #include "migration/blocker.h"
+#include "exec/guest-memory-protection.h"
 
 #define TYPE_SEV_GUEST "sev-guest"
 #define SEV_GUEST(obj)                                          \
@@ -281,26 +282,6 @@ sev_guest_set_sev_device(Object *obj, const char *value, Error **errp)
     sev->sev_device = g_strdup(value);
 }
 
-static void
-sev_guest_class_init(ObjectClass *oc, void *data)
-{
-    object_class_property_add_str(oc, "sev-device",
-                                  sev_guest_get_sev_device,
-                                  sev_guest_set_sev_device);
-    object_class_property_set_description(oc, "sev-device",
-            "SEV device to use");
-    object_class_property_add_str(oc, "dh-cert-file",
-                                  sev_guest_get_dh_cert_file,
-                                  sev_guest_set_dh_cert_file);
-    object_class_property_set_description(oc, "dh-cert-file",
-            "guest owners DH certificate (encoded with base64)");
-    object_class_property_add_str(oc, "session-file",
-                                  sev_guest_get_session_file,
-                                  sev_guest_set_session_file);
-    object_class_property_set_description(oc, "session-file",
-            "guest owners session parameters (encoded with base64)");
-}
-
 static void
 sev_guest_instance_init(Object *obj)
 {
@@ -319,20 +300,6 @@ sev_guest_instance_init(Object *obj)
                                    OBJ_PROP_FLAG_READWRITE);
 }
 
-/* sev guest info */
-static const TypeInfo sev_guest_info = {
-    .parent = TYPE_OBJECT,
-    .name = TYPE_SEV_GUEST,
-    .instance_size = sizeof(SevGuestState),
-    .instance_finalize = sev_guest_finalize,
-    .class_init = sev_guest_class_init,
-    .instance_init = sev_guest_instance_init,
-    .interfaces = (InterfaceInfo[]) {
-        { TYPE_USER_CREATABLE },
-        { }
-    }
-};
-
 static SevGuestState *
 lookup_sev_guest_info(const char *id)
 {
@@ -670,7 +637,7 @@ sev_vm_state_change(void *opaque, int running, RunState state)
     }
 }
 
-void *
+GuestMemoryProtection *
 sev_guest_init(const char *id)
 {
     SevGuestState *sev;
@@ -748,16 +715,16 @@ sev_guest_init(const char *id)
     qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
     qemu_add_vm_change_state_handler(sev_vm_state_change, sev);
 
-    return sev;
+    return GUEST_MEMORY_PROTECTION(sev);
 err:
     sev_guest = NULL;
     return NULL;
 }
 
-int
-sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
+static int
+sev_encrypt_data(GuestMemoryProtection *opaque, uint8_t *ptr, uint64_t len)
 {
-    SevGuestState *sev = handle;
+    SevGuestState *sev = SEV_GUEST(opaque);
 
     assert(sev);
 
@@ -769,6 +736,45 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
     return 0;
 }
 
+static void
+sev_guest_class_init(ObjectClass *oc, void *data)
+{
+    GuestMemoryProtectionClass *gmpc = GUEST_MEMORY_PROTECTION_CLASS(oc);
+
+    object_class_property_add_str(oc, "sev-device",
+                                  sev_guest_get_sev_device,
+                                  sev_guest_set_sev_device);
+    object_class_property_set_description(oc, "sev-device",
+        "SEV device to use");
+    object_class_property_add_str(oc, "dh-cert-file",
+                                  sev_guest_get_dh_cert_file,
+                                  sev_guest_set_dh_cert_file);
+    object_class_property_set_description(oc, "dh-cert-file",
+        "guest owners DH certificate (encoded with base64)");
+    object_class_property_add_str(oc, "session-file",
+                                  sev_guest_get_session_file,
+                                  sev_guest_set_session_file);
+    object_class_property_set_description(oc, "session-file",
+        "guest owners session parameters (encoded with base64)");
+
+    gmpc->encrypt_data = sev_encrypt_data;
+}
+
+/* sev guest info */
+static const TypeInfo sev_guest_info = {
+    .parent = TYPE_OBJECT,
+    .name = TYPE_SEV_GUEST,
+    .instance_size = sizeof(SevGuestState),
+    .instance_finalize = sev_guest_finalize,
+    .class_init = sev_guest_class_init,
+    .instance_init = sev_guest_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_GUEST_MEMORY_PROTECTION },
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
 static void
 sev_register_types(void)
 {
-- 
2.26.2


