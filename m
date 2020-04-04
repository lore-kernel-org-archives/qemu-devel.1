Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E25C2BA16
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 08:32:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C63206F5
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 08:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUt/JUPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C63206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKeEY-00022v-6W
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 04:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jKeB9-0005kw-RT
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arilou@gmail.com>) id 1jKeB7-0001v9-JL
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:29:23 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34701)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arilou@gmail.com>) id 1jKeB7-0001uS-D2
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:29:21 -0400
Received: by mail-wr1-x443.google.com with SMTP id 65so11273590wrl.1
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2020 01:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ah312KBMSHRpUiO/v1i0MNGqjwvrG+Bz23qtxXquL8I=;
 b=ZUt/JUPFmMAFWF5XiYgctWUM9zlvrzxupYixvBB1EZDhs2mu02bnmtfApumuvzAKou
 V7W1p9q/QkTNxUOF4dI1Qj8Cwr3KYdZB2Bz+MX95UzmKcya5LsXevXe4Rcqmy6y4Ljc7
 pQPDesJPBObtrg8YOkzYtcqcfrncO9CyKUw6IOl3S6gjHMIh8T7uqknTUswOKax08xO9
 EB3C96Q/SnYbzwBBW18j8X24QN8eKnL4mAnx2WSGtr1oZVn+gvoobsQQZf21ACLtQg78
 M2auQxDMjAxqXHGSguBB7kPciclWJkQETc6CKLaJYG1E3FmWaVRj5WPXqzfJSEBrfEuN
 ZrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ah312KBMSHRpUiO/v1i0MNGqjwvrG+Bz23qtxXquL8I=;
 b=ojNjkLowpENMjxbp+FKcJ2bOIQ2eII8pFF3AmmkqkMgZEGKiXj76ABw74g3yhiGt6R
 3ttz2Aq2t0w4If+9+AmIGM1HtXrrwQYOkCA+41LcRSRdWXmjxh18f/loy5rnVQJq8SPm
 77b4wTCErxOx50nEI6JHV5UtV0JoT7Q8EC2IJ9Dif6Hq6s+3phwHALK2yPFdBEJrziFT
 E/AC0gfFt6mftwn+lC7tFvntXpJclBm1WvoaTbLLFOYA++j8I3bWzFFMfRrZyrLTwwaB
 S3XMkYx/cokFW6JS1RMVxz/wW6qTZv5mpp2mIHvKVT2tzpANg1itoUSZgJDjm7MYH02+
 wDpg==
X-Gm-Message-State: AGi0PuZ1YdrLUOgGUTWoZo41kscBX0PJX1UtH7KeE3poCmpFEXxRC34n
 am1XLtaT6rE1k8ZKk1xTn0A6PBbOMKP9wA==
X-Google-Smtp-Source: APiQypIzAowKi4bdFqIG/CxFr2yEFU3RuHNY/dGg00XhU56g0mrIUE0kF/4abmWRLQBMlw+wfF74ZQ==
X-Received: by 2002:adf:b246:: with SMTP id y6mr27271wra.2.1585988960109;
 Sat, 04 Apr 2020 01:29:20 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-40.inter.net.il. [84.229.155.40])
 by smtp.gmail.com with ESMTPSA id
 a10sm15884778wrm.87.2020.04.04.01.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2020 01:29:19 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/7] hyperv: SControl is optional to enable SynIc
Date: Sat,  4 Apr 2020 11:28:55 +0300
Message-Id: <20200404082900.33711-3-arilou@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200404082900.33711-1-arilou@gmail.com>
References: <20200404082900.33711-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: mail@maciej.szmigiero.name, eyakovlev@virtuozzo.com, ehabkost@redhat.com,
 rvkagan@gmail.com, liran.alon@oracle.com, pbonzini@redhat.com,
 vkuznets@redhat.com, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SynIc can be enabled regardless of the SControl mechanisim which can
register a GSI for a given SintRoute.

This behaviour can achived by setting enabling SIMP and then the guest
will poll on the message slot.

Once there is another message pending the host will set the message slot
with the pending flag.
When the guest polls from the message slot, incase the pending flag is
set it will write to the HV_X64_MSR_EOM indicating it has cleared the
slow and we can try and push our message again.

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 hw/hyperv/hyperv.c         | 242 ++++++++++++++++++++++++-------------
 include/hw/hyperv/hyperv.h |   2 +
 target/i386/hyperv.c       |   2 +
 3 files changed, 164 insertions(+), 82 deletions(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index ddf4f32c60..1dc577a0ab 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -20,18 +20,72 @@
 #include "qemu/rcu_queue.h"
 #include "hw/hyperv/hyperv.h"
 
+/*
+ * KVM has its own message producers (SynIC timers).  To guarantee
+ * serialization with both KVM vcpu and the guest cpu, the messages are first
+ * staged in an intermediate area and then posted to the SynIC message page in
+ * the vcpu thread.
+ */
+typedef struct HvSintStagedMessage {
+    /* message content staged by hyperv_post_msg */
+    struct hyperv_message msg;
+    /* callback + data (r/o) to complete the processing in a BH */
+    HvSintMsgCb cb;
+    void *cb_data;
+    /* message posting status filled by cpu_post_msg */
+    int status;
+    /* passing the buck: */
+    enum {
+        /* initial state */
+        HV_STAGED_MSG_FREE,
+        /*
+         * hyperv_post_msg (e.g. in main loop) grabs the staged area (FREE ->
+         * BUSY), copies msg, and schedules cpu_post_msg on the assigned cpu
+         */
+        HV_STAGED_MSG_BUSY,
+        /*
+         * cpu_post_msg (vcpu thread) tries to copy staged msg to msg slot,
+         * notify the guest, records the status, marks the posting done (BUSY
+         * -> POSTED), and schedules sint_msg_bh BH
+         */
+        HV_STAGED_MSG_POSTED,
+        /*
+         * sint_msg_bh (BH) verifies that the posting is done, runs the
+         * callback, and starts over (POSTED -> FREE)
+         */
+    } state;
+} HvSintStagedMessage;
+
+struct SynICState;
+
+struct HvSintRoute {
+    uint32_t sint;
+    struct SynICState *synic;
+    int gsi;
+    EventNotifier sint_set_notifier;
+    EventNotifier sint_ack_notifier;
+
+    HvSintStagedMessage *staged_msg;
+
+    unsigned refcount;
+    QLIST_ENTRY(HvSintRoute) link;
+};
+
 typedef struct SynICState {
     DeviceState parent_obj;
 
     CPUState *cs;
 
-    bool enabled;
+    bool sctl_enabled;
     hwaddr msg_page_addr;
     hwaddr event_page_addr;
     MemoryRegion msg_page_mr;
     MemoryRegion event_page_mr;
     struct hyperv_message_page *msg_page;
     struct hyperv_event_flags_page *event_page;
+
+    QemuMutex sint_routes_mutex;
+    QLIST_HEAD(, HvSintRoute) sint_routes;
 } SynICState;
 
 #define TYPE_SYNIC "hyperv-synic"
@@ -49,11 +103,11 @@ static SynICState *get_synic(CPUState *cs)
     return SYNIC(object_resolve_path_component(OBJECT(cs), "synic"));
 }
 
-static void synic_update(SynICState *synic, bool enable,
+static void synic_update(SynICState *synic, bool sctl_enable,
                          hwaddr msg_page_addr, hwaddr event_page_addr)
 {
 
-    synic->enabled = enable;
+    synic->sctl_enabled = sctl_enable;
     if (synic->msg_page_addr != msg_page_addr) {
         if (synic->msg_page_addr) {
             memory_region_del_subregion(get_system_memory(),
@@ -78,7 +132,7 @@ static void synic_update(SynICState *synic, bool enable,
     }
 }
 
-void hyperv_synic_update(CPUState *cs, bool enable,
+void hyperv_synic_update(CPUState *cs, bool sctl_enable,
                          hwaddr msg_page_addr, hwaddr event_page_addr)
 {
     SynICState *synic = get_synic(cs);
@@ -87,7 +141,7 @@ void hyperv_synic_update(CPUState *cs, bool enable,
         return;
     }
 
-    synic_update(synic, enable, msg_page_addr, event_page_addr);
+    synic_update(synic, sctl_enable, msg_page_addr, event_page_addr);
 }
 
 static void synic_realize(DeviceState *dev, Error **errp)
@@ -108,16 +162,20 @@ static void synic_realize(DeviceState *dev, Error **errp)
                            sizeof(*synic->event_page), &error_abort);
     synic->msg_page = memory_region_get_ram_ptr(&synic->msg_page_mr);
     synic->event_page = memory_region_get_ram_ptr(&synic->event_page_mr);
+    qemu_mutex_init(&synic->sint_routes_mutex);
+    QLIST_INIT(&synic->sint_routes);
 
     g_free(msgp_name);
     g_free(eventp_name);
 }
+
 static void synic_reset(DeviceState *dev)
 {
     SynICState *synic = SYNIC(dev);
     memset(synic->msg_page, 0, sizeof(*synic->msg_page));
     memset(synic->event_page, 0, sizeof(*synic->event_page));
     synic_update(synic, false, 0, 0);
+    assert(QLIST_EMPTY(&synic->sint_routes));
 }
 
 static void synic_class_init(ObjectClass *klass, void *data)
@@ -166,54 +224,6 @@ static void synic_register_types(void)
 
 type_init(synic_register_types)
 
-/*
- * KVM has its own message producers (SynIC timers).  To guarantee
- * serialization with both KVM vcpu and the guest cpu, the messages are first
- * staged in an intermediate area and then posted to the SynIC message page in
- * the vcpu thread.
- */
-typedef struct HvSintStagedMessage {
-    /* message content staged by hyperv_post_msg */
-    struct hyperv_message msg;
-    /* callback + data (r/o) to complete the processing in a BH */
-    HvSintMsgCb cb;
-    void *cb_data;
-    /* message posting status filled by cpu_post_msg */
-    int status;
-    /* passing the buck: */
-    enum {
-        /* initial state */
-        HV_STAGED_MSG_FREE,
-        /*
-         * hyperv_post_msg (e.g. in main loop) grabs the staged area (FREE ->
-         * BUSY), copies msg, and schedules cpu_post_msg on the assigned cpu
-         */
-        HV_STAGED_MSG_BUSY,
-        /*
-         * cpu_post_msg (vcpu thread) tries to copy staged msg to msg slot,
-         * notify the guest, records the status, marks the posting done (BUSY
-         * -> POSTED), and schedules sint_msg_bh BH
-         */
-        HV_STAGED_MSG_POSTED,
-        /*
-         * sint_msg_bh (BH) verifies that the posting is done, runs the
-         * callback, and starts over (POSTED -> FREE)
-         */
-    } state;
-} HvSintStagedMessage;
-
-struct HvSintRoute {
-    uint32_t sint;
-    SynICState *synic;
-    int gsi;
-    EventNotifier sint_set_notifier;
-    EventNotifier sint_ack_notifier;
-
-    HvSintStagedMessage *staged_msg;
-
-    unsigned refcount;
-};
-
 static CPUState *hyperv_find_vcpu(uint32_t vp_index)
 {
     CPUState *cs = qemu_get_cpu(vp_index);
@@ -257,7 +267,7 @@ static void cpu_post_msg(CPUState *cs, run_on_cpu_data data)
 
     assert(staged_msg->state == HV_STAGED_MSG_BUSY);
 
-    if (!synic->enabled || !synic->msg_page_addr) {
+    if (!synic->msg_page_addr) {
         staged_msg->status = -ENXIO;
         goto posted;
     }
@@ -341,7 +351,7 @@ int hyperv_set_event_flag(HvSintRoute *sint_route, unsigned eventno)
     if (eventno > HV_EVENT_FLAGS_COUNT) {
         return -EINVAL;
     }
-    if (!synic->enabled || !synic->event_page_addr) {
+    if (!synic->sctl_enabled || !synic->event_page_addr) {
         return -ENXIO;
     }
 
@@ -362,11 +372,13 @@ int hyperv_set_event_flag(HvSintRoute *sint_route, unsigned eventno)
 HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
                                    HvSintMsgCb cb, void *cb_data)
 {
-    HvSintRoute *sint_route;
-    EventNotifier *ack_notifier;
+    HvSintRoute *sint_route = NULL;
+    EventNotifier *ack_notifier = NULL;
     int r, gsi;
     CPUState *cs;
     SynICState *synic;
+    bool ack_event_initialized = false, sint_notifier_initialized = false,
+         irqfd_initialized = false;
 
     cs = hyperv_find_vcpu(vp_index);
     if (!cs) {
@@ -379,57 +391,82 @@ HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
     }
 
     sint_route = g_new0(HvSintRoute, 1);
-    r = event_notifier_init(&sint_route->sint_set_notifier, false);
-    if (r) {
-        goto err;
+    if (!sint_route) {
+        goto cleanup_err;
     }
 
+    sint_route->gsi = 0;
+    sint_route->synic = synic;
+    sint_route->sint = sint;
+    sint_route->refcount = 1;
 
     ack_notifier = cb ? &sint_route->sint_ack_notifier : NULL;
     if (ack_notifier) {
         sint_route->staged_msg = g_new0(HvSintStagedMessage, 1);
+        if (!sint_route->staged_msg) {
+            goto cleanup_err;
+        }
         sint_route->staged_msg->cb = cb;
         sint_route->staged_msg->cb_data = cb_data;
 
         r = event_notifier_init(ack_notifier, false);
         if (r) {
-            goto err_sint_set_notifier;
+            goto cleanup_err;
         }
-
         event_notifier_set_handler(ack_notifier, sint_ack_handler);
+        ack_event_initialized = true;
+    }
+
+    /* See if we are done or we need to setup a GSI for this SintRoute */
+    if (!synic->sctl_enabled) {
+        goto cleanup;
+    }
+
+    /* We need to setup a GSI for this SintRoute */
+    r = event_notifier_init(&sint_route->sint_set_notifier, false);
+    if (r) {
+        goto cleanup_err;
     }
+    sint_notifier_initialized = true;
 
     gsi = kvm_irqchip_add_hv_sint_route(kvm_state, vp_index, sint);
     if (gsi < 0) {
-        goto err_gsi;
+        goto cleanup_err;
     }
+    irqfd_initialized = true;
 
     r = kvm_irqchip_add_irqfd_notifier_gsi(kvm_state,
                                            &sint_route->sint_set_notifier,
                                            ack_notifier, gsi);
     if (r) {
-        goto err_irqfd;
+        goto cleanup_err;
     }
     sint_route->gsi = gsi;
-    sint_route->synic = synic;
-    sint_route->sint = sint;
-    sint_route->refcount = 1;
-
+cleanup:
+    qemu_mutex_lock(&synic->sint_routes_mutex);
+    QLIST_INSERT_HEAD_RCU(&synic->sint_routes, sint_route, link);
+    qemu_mutex_unlock(&synic->sint_routes_mutex);
     return sint_route;
 
-err_irqfd:
-    kvm_irqchip_release_virq(kvm_state, gsi);
-err_gsi:
+cleanup_err:
+    if (irqfd_initialized) {
+        kvm_irqchip_release_virq(kvm_state, gsi);
+    }
+
+    if (sint_notifier_initialized) {
+        event_notifier_cleanup(&sint_route->sint_set_notifier);
+    }
+
     if (ack_notifier) {
-        event_notifier_set_handler(ack_notifier, NULL);
-        event_notifier_cleanup(ack_notifier);
+        if (ack_event_initialized) {
+            event_notifier_set_handler(ack_notifier, NULL);
+            event_notifier_cleanup(ack_notifier);
+        }
+
         g_free(sint_route->staged_msg);
     }
-err_sint_set_notifier:
-    event_notifier_cleanup(&sint_route->sint_set_notifier);
-err:
-    g_free(sint_route);
 
+    g_free(sint_route);
     return NULL;
 }
 
@@ -440,6 +477,8 @@ void hyperv_sint_route_ref(HvSintRoute *sint_route)
 
 void hyperv_sint_route_unref(HvSintRoute *sint_route)
 {
+    SynICState *synic;
+
     if (!sint_route) {
         return;
     }
@@ -450,21 +489,33 @@ void hyperv_sint_route_unref(HvSintRoute *sint_route)
         return;
     }
 
-    kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state,
-                                          &sint_route->sint_set_notifier,
-                                          sint_route->gsi);
-    kvm_irqchip_release_virq(kvm_state, sint_route->gsi);
+    synic = sint_route->synic;
+    qemu_mutex_lock(&synic->sint_routes_mutex);
+    QLIST_REMOVE_RCU(sint_route, link);
+    qemu_mutex_unlock(&synic->sint_routes_mutex);
+
+    if (sint_route->gsi) {
+        kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state,
+                                              &sint_route->sint_set_notifier,
+                                              sint_route->gsi);
+        kvm_irqchip_release_virq(kvm_state, sint_route->gsi);
+        event_notifier_cleanup(&sint_route->sint_set_notifier);
+    }
+
     if (sint_route->staged_msg) {
         event_notifier_set_handler(&sint_route->sint_ack_notifier, NULL);
         event_notifier_cleanup(&sint_route->sint_ack_notifier);
         g_free(sint_route->staged_msg);
     }
-    event_notifier_cleanup(&sint_route->sint_set_notifier);
     g_free(sint_route);
 }
 
 int hyperv_sint_route_set_sint(HvSintRoute *sint_route)
 {
+    if (!sint_route->gsi) {
+        return 0;
+    }
+
     return event_notifier_set(&sint_route->sint_set_notifier);
 }
 
@@ -528,6 +579,33 @@ unlock:
     return ret;
 }
 
+int hyperv_synic_eom(CPUState *cs)
+{
+    SynICState *synic = get_synic(cs);
+    HvSintRoute *sint_route;
+
+    if (!synic) {
+        return -1;
+    }
+
+    qemu_mutex_lock(&synic->sint_routes_mutex);
+    QLIST_FOREACH(sint_route, &synic->sint_routes, link) {
+        HvSintStagedMessage *staged_msg = sint_route->staged_msg;
+
+        /* Skip a SintRoute that has a GSI registered with it */
+        if (sint_route->gsi ||
+            atomic_read(&staged_msg->state) != HV_STAGED_MSG_POSTED) {
+            continue;
+        }
+
+        aio_bh_schedule_oneshot(qemu_get_aio_context(), sint_msg_bh,
+                                sint_route);
+    }
+    qemu_mutex_unlock(&synic->sint_routes_mutex);
+
+    return 0;
+}
+
 uint16_t hyperv_hcall_post_message(uint64_t param, bool fast)
 {
     uint16_t ret;
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index a63ee0003c..ef9f6b6c09 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -28,6 +28,8 @@ void hyperv_sint_route_unref(HvSintRoute *sint_route);
 
 int hyperv_sint_route_set_sint(HvSintRoute *sint_route);
 
+int hyperv_synic_eom(CPUState *cs);
+
 /*
  * Submit a message to be posted in vcpu context.  If the submission succeeds,
  * the status of posting the message is reported via the callback associated
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 26efc1e0e6..f11268df48 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -66,6 +66,8 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
         case HV_X64_MSR_SIEFP:
             env->msr_hv_synic_evt_page = exit->u.synic.evt_page;
             break;
+        case HV_X64_MSR_EOM:
+            return hyperv_synic_eom(CPU(cpu));
         default:
             return -1;
         }
-- 
2.24.1


