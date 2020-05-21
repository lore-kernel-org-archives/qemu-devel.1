Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6570C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 03:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 746A620721
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 03:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="n0ZFujpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746A620721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbcEI-0007DE-KS
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 23:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jbc7J-00037e-SK; Wed, 20 May 2020 23:43:33 -0400
Received: from ozlabs.org ([203.11.71.1]:47609)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jbc7I-0003X6-D6; Wed, 20 May 2020 23:43:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49SFns5ftgz9sV2; Thu, 21 May 2020 13:43:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590032593;
 bh=gQ7WBzFCWsSO8Y6ZBoDXD7CE89Jjg6PXDsNnEC8gJ/Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n0ZFujptmNQqtbScYQR4NUz+GHU4Vsgmyl8ih2NxLksU8mYVfT4boyRqjAwNl3Xmi
 awB/JgMXVbR+xvGfa/QWWx0we5QVVFToVhV6hotfIpLip9UKr6WoROxF7EVDs4/+3N
 09EIlfDem8HP41lnmEC3dVhyeuDNQAREPYoJITC8=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org, brijesh.singh@amd.com, frankja@linux.ibm.com,
 dgilbert@redhat.com, pair@us.ibm.com
Subject: [RFC v2 12/18] guest memory protection: Perform KVM init via interface
Date: Thu, 21 May 2020 13:42:58 +1000
Message-Id: <20200521034304.340040-13-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521034304.340040-1-david@gibson.dropbear.id.au>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

Currently the "memory-encryption" machine option is notionally generic,
but in fact is only used for AMD SEV setups.  Make another step towards it
being actually generic, but having using the GuestMemoryProtection QOM
interface to dispatch the initial setup, rather than directly calling
sev_guest_init() from kvm_init().

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 accel/kvm/kvm-all.c                    | 18 ++++++++++---
 include/exec/guest-memory-protection.h |  1 +
 target/i386/sev.c                      | 37 ++++----------------------
 3 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 40997de38c..5cf1a397e3 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -39,7 +39,6 @@
 #include "qemu/main-loop.h"
 #include "trace.h"
 #include "hw/irq.h"
-#include "sysemu/sev.h"
 #include "sysemu/balloon.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-types-common.h"
@@ -2104,8 +2103,21 @@ static int kvm_init(MachineState *ms)
      * encryption context.
      */
     if (ms->memory_encryption) {
-        kvm_state->guest_memory_protection = sev_guest_init(ms->memory_encryption);
-        if (!kvm_state->guest_memory_protection) {
+        Object *obj = object_resolve_path_component(object_get_objects_root(),
+                                                    ms->memory_encryption);
+
+        if (object_dynamic_cast(obj, TYPE_GUEST_MEMORY_PROTECTION)) {
+            GuestMemoryProtection *gmpo = GUEST_MEMORY_PROTECTION(obj);
+            GuestMemoryProtectionClass *gmpc =
+                GUEST_MEMORY_PROTECTION_GET_CLASS(gmpo);
+
+            ret = gmpc->kvm_init(gmpo);
+            if (ret < 0) {
+                goto err;
+            }
+
+            kvm_state->guest_memory_protection = gmpo;
+        } else {
             ret = -1;
             goto err;
         }
diff --git a/include/exec/guest-memory-protection.h b/include/exec/guest-memory-protection.h
index eb712a5804..3707b96515 100644
--- a/include/exec/guest-memory-protection.h
+++ b/include/exec/guest-memory-protection.h
@@ -31,6 +31,7 @@ typedef struct GuestMemoryProtection GuestMemoryProtection;
 typedef struct GuestMemoryProtectionClass {
     InterfaceClass parent;
 
+    int (*kvm_init)(GuestMemoryProtection *);
     int (*encrypt_data)(GuestMemoryProtection *, uint8_t *, uint64_t);
 } GuestMemoryProtectionClass;
 
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 986c2fee51..60e9d8c735 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -300,26 +300,6 @@ sev_guest_instance_init(Object *obj)
                                    OBJ_PROP_FLAG_READWRITE);
 }
 
-static SevGuestState *
-lookup_sev_guest_info(const char *id)
-{
-    Object *obj;
-    SevGuestState *info;
-
-    obj = object_resolve_path_component(object_get_objects_root(), id);
-    if (!obj) {
-        return NULL;
-    }
-
-    info = (SevGuestState *)
-            object_dynamic_cast(obj, TYPE_SEV_GUEST);
-    if (!info) {
-        return NULL;
-    }
-
-    return info;
-}
-
 bool
 sev_enabled(void)
 {
@@ -637,23 +617,15 @@ sev_vm_state_change(void *opaque, int running, RunState state)
     }
 }
 
-GuestMemoryProtection *
-sev_guest_init(const char *id)
+static int sev_kvm_init(GuestMemoryProtection *gmpo)
 {
-    SevGuestState *sev;
+    SevGuestState *sev = SEV_GUEST(gmpo);
     char *devname;
     int ret, fw_error;
     uint32_t ebx;
     uint32_t host_cbitpos;
     struct sev_user_data_status status = {};
 
-    sev = lookup_sev_guest_info(id);
-    if (!sev) {
-        error_report("%s: '%s' is not a valid '%s' object",
-                     __func__, id, TYPE_SEV_GUEST);
-        goto err;
-    }
-
     sev_guest = sev;
     sev->state = SEV_STATE_UNINIT;
 
@@ -715,10 +687,10 @@ sev_guest_init(const char *id)
     qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
     qemu_add_vm_change_state_handler(sev_vm_state_change, sev);
 
-    return GUEST_MEMORY_PROTECTION(sev);
+    return 0;
 err:
     sev_guest = NULL;
-    return NULL;
+    return -1;
 }
 
 static int
@@ -757,6 +729,7 @@ sev_guest_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "session-file",
         "guest owners session parameters (encoded with base64)");
 
+    gmpc->kvm_init = sev_kvm_init;
     gmpc->encrypt_data = sev_encrypt_data;
 }
 
-- 
2.26.2


