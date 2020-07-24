Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F7CC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 02:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A9E7206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 02:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DC+6Qtnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9E7206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jynw6-0001Wl-On
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 22:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jynuV-0007aW-Bh; Thu, 23 Jul 2020 22:58:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54029 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jynuO-00061k-Es; Thu, 23 Jul 2020 22:58:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BCYlv6Cjvz9sSy; Fri, 24 Jul 2020 12:57:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595559467;
 bh=JRbdSSqaG0liT/aslzU3m1hnjce6fptMd9RZ6TZwddU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DC+6Qtnf39Aai/D6H6P+axBMx2XtA8CqUBXghtuGqnWLCxlAl8ULsWtB8yeiWgOTr
 BgzzWGWvgW7tYg6H4e7aTsYsTVgI6T2WFB0Qh+TozWdOKmI00eLAPxHPt2RIRw0H4Z
 9kOu41/eZJKnbw5YFCo7cYkulVBqhQCoMdYj5/ms=
From: David Gibson <david@gibson.dropbear.id.au>
To: dgilbert@redhat.com, frankja@linux.ibm.com, pair@us.ibm.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, brijesh.singh@amd.com
Subject: [for-5.2 v4 05/10] host trust limitation: Decouple kvm_memcrypt_*()
 helpers from KVM
Date: Fri, 24 Jul 2020 12:57:39 +1000
Message-Id: <20200724025744.69644-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200724025744.69644-1-david@gibson.dropbear.id.au>
References: <20200724025744.69644-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 22:57:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

The kvm_memcrypt_enabled() and kvm_memcrypt_encrypt_data() helper functions
don't conceptually have any connection to KVM (although it's not possible
in practice to use them without it).

They also rely on looking at the global KVMState.  But the same information
is available from the machine, and the only existing callers have natural
access to the machine state.

Therefore, move and rename them to helpers in host-trust-limitation.h,
taking an explicit machine parameter.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-all.c                  | 27 ---------------------
 accel/stubs/kvm-stub.c               | 10 --------
 hw/i386/pc_sysfw.c                   |  6 +++--
 include/exec/host-trust-limitation.h | 36 ++++++++++++++++++++++++++++
 include/sysemu/kvm.h                 | 17 -------------
 5 files changed, 40 insertions(+), 56 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e2d8f47f93..4b6402c12c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -117,9 +117,6 @@ struct KVMState
     KVMMemoryListener memory_listener;
     QLIST_HEAD(, KVMParkedVcpu) kvm_parked_vcpus;
 
-    /* host trust limitation (e.g. by guest memory encryption) */
-    HostTrustLimitation *htl;
-
     /* For "info mtree -f" to tell if an MR is registered in KVM */
     int nr_as;
     struct KVMAs {
@@ -218,28 +215,6 @@ int kvm_get_max_memslots(void)
     return s->nr_slots;
 }
 
-bool kvm_memcrypt_enabled(void)
-{
-    if (kvm_state && kvm_state->htl) {
-        return true;
-    }
-
-    return false;
-}
-
-int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
-{
-    HostTrustLimitation *htl = kvm_state->htl;
-
-    if (htl) {
-        HostTrustLimitationClass *htlc = HOST_TRUST_LIMITATION_GET_CLASS(htl);
-
-        return htlc->encrypt_data(htl, ptr, len);
-    }
-
-    return 1;
-}
-
 /* Called with KVMMemoryListener.slots_lock held */
 static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
 {
@@ -2194,8 +2169,6 @@ static int kvm_init(MachineState *ms)
         if (ret < 0) {
             goto err;
         }
-
-        kvm_state->htl = ms->htl;
     }
 
     ret = kvm_arch_init(ms, s);
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 82f118d2df..78b3eef117 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -104,16 +104,6 @@ int kvm_on_sigbus(int code, void *addr)
     return 1;
 }
 
-bool kvm_memcrypt_enabled(void)
-{
-    return false;
-}
-
-int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
-{
-  return 1;
-}
-
 #ifndef CONFIG_USER_ONLY
 int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
 {
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index b6c0822fe3..e8d3b795a1 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -38,6 +38,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/block/flash.h"
 #include "sysemu/kvm.h"
+#include "exec/host-trust-limitation.h"
 
 /*
  * We don't have a theoretically justifiable exact lower bound on the base
@@ -201,10 +202,11 @@ static void pc_system_flash_map(PCMachineState *pcms,
             pc_isa_bios_init(rom_memory, flash_mem, size);
 
             /* Encrypt the pflash boot ROM */
-            if (kvm_memcrypt_enabled()) {
+            if (host_trust_limitation_enabled(MACHINE(pcms))) {
                 flash_ptr = memory_region_get_ram_ptr(flash_mem);
                 flash_size = memory_region_size(flash_mem);
-                ret = kvm_memcrypt_encrypt_data(flash_ptr, flash_size);
+                ret = host_trust_limitation_encrypt(MACHINE(pcms),
+                                                    flash_ptr, flash_size);
                 if (ret) {
                     error_report("failed to encrypt pflash rom");
                     exit(1);
diff --git a/include/exec/host-trust-limitation.h b/include/exec/host-trust-limitation.h
index a19f12ae14..fc30ea3f78 100644
--- a/include/exec/host-trust-limitation.h
+++ b/include/exec/host-trust-limitation.h
@@ -14,6 +14,7 @@
 #define QEMU_HOST_TRUST_LIMITATION_H
 
 #include "qom/object.h"
+#include "hw/boards.h"
 
 #define TYPE_HOST_TRUST_LIMITATION "host-trust-limitation"
 #define HOST_TRUST_LIMITATION(obj)                                    \
@@ -33,4 +34,39 @@ typedef struct HostTrustLimitationClass {
     int (*encrypt_data)(HostTrustLimitation *, uint8_t *, uint64_t);
 } HostTrustLimitationClass;
 
+/**
+ * host_trust_limitation_enabled - return whether guest memory is protected
+ *                                 from hypervisor access (with memory
+ *                                 encryption or otherwise)
+ * Returns: true guest memory is not directly accessible to qemu
+ *          false guest memory is directly accessible to qemu
+ */
+static inline bool host_trust_limitation_enabled(MachineState *machine)
+{
+    return !!machine->htl;
+}
+
+/**
+ * host_trust_limitation_encrypt: encrypt the memory range to make
+ *                                it guest accessible
+ *
+ * Return: 1 failed to encrypt the range
+ *         0 succesfully encrypted memory region
+ */
+static inline int host_trust_limitation_encrypt(MachineState *machine,
+                                                uint8_t *ptr, uint64_t len)
+{
+    HostTrustLimitation *htl = machine->htl;
+
+    if (htl) {
+        HostTrustLimitationClass *htlc = HOST_TRUST_LIMITATION_GET_CLASS(htl);
+
+        if (htlc->encrypt_data) {
+            return htlc->encrypt_data(htl, ptr, len);
+        }
+    }
+
+    return 1;
+}
+
 #endif /* QEMU_HOST_TRUST_LIMITATION_H */
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index b4174d941c..c7b9739609 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -231,23 +231,6 @@ int kvm_destroy_vcpu(CPUState *cpu);
  */
 bool kvm_arm_supports_user_irq(void);
 
-/**
- * kvm_memcrypt_enabled - return boolean indicating whether memory encryption
- *                        is enabled
- * Returns: 1 memory encryption is enabled
- *          0 memory encryption is disabled
- */
-bool kvm_memcrypt_enabled(void);
-
-/**
- * kvm_memcrypt_encrypt_data: encrypt the memory range
- *
- * Return: 1 failed to encrypt the range
- *         0 succesfully encrypted memory region
- */
-int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len);
-
-
 #ifdef NEED_CPU_H
 #include "cpu.h"
 
-- 
2.26.2


