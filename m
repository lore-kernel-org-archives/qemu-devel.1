Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74BCC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B0E20735
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0ZPINbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B0E20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcdVZ-0006hD-Oi
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 19:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRs-0007MX-2V
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:21:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51919
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRq-0000UI-MX
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590276058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Vf79eVB2XK0J+Fvwx282tsbcI9o5vEmo7tTYQwHKag=;
 b=A0ZPINbMq3Hh2BWNBblA+xcPmJoKrmjpPAYjPthyaU7L4WnSM/A2qMqvZw3suj4TMq+cre
 Y2SKnJzxH1mVmpS0/PZBgMXuOg873VD1g2qkOo4RifXS0l2W1XEQmexgqi1RnamUY05Xqq
 RfPAET8Bv+crUFUSljgkg7Sv5VW2j74=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-wwS8s7vsPaSnSq1WOl0ksg-1; Sat, 23 May 2020 19:20:55 -0400
X-MC-Unique: wwS8s7vsPaSnSq1WOl0ksg-1
Received: by mail-qt1-f198.google.com with SMTP id l11so15927963qti.19
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 16:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4Vf79eVB2XK0J+Fvwx282tsbcI9o5vEmo7tTYQwHKag=;
 b=AgE9W60nxhznuNMkhjWk4qokiyRsU4PxsJV4F3Ocbx1BHwSEDC82RHOw0GOiFVtMeg
 8ojCPqoy+NCy5M2AeeztNHB2OpZyJXyetG0LHL6060tyZ2YiRArKnlXztplvsV0wqg2U
 WjfGPdSq6nwE96N2xlc7Vkowdsk01z7YK8r0wMFs2c4f1t35TZ0TwLWCzf0CV/eVZj3N
 +UyxM4TY1K/1oEW8/+CdatvK88JdT9CA4XowcDBcwLiYjVN73YIxHwUSSTMdhgo6dfEt
 h+UKdTlO+UtSuxSLIy0yBGrP980bZPuRQkc7areqCSlRCbhhHq0jlgjKT6JgVkAqb/kl
 2Y6w==
X-Gm-Message-State: AOAM53254aqaP1l0NR002LAeAuuM7nkHD7Af0zLkgNxAvfyDqAWhv3pa
 CjXn8asaIv1O41FEZoQFqbXXAYsXHHu6MxiOwTwS+B5TeZ7DUe9H/DXnEsjIBOi+AMhZG09m2dC
 dGw8mrUxVwZrhTKA=
X-Received: by 2002:a0c:b5c1:: with SMTP id o1mr3467975qvf.9.1590276054667;
 Sat, 23 May 2020 16:20:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyc97PaUnm7AfdbPF9CtfOXDQKZkAKXDj+yOCG8MhfQJFPTEHJ2oyry6t0vcPLK2kwbTTgQnA==
X-Received: by 2002:a0c:b5c1:: with SMTP id o1mr3467965qvf.9.1590276054424;
 Sat, 23 May 2020 16:20:54 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id m33sm11974235qtb.88.2020.05.23.16.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 16:20:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v3 10/11] KVM: Add dirty-gfn-count property
Date: Sat, 23 May 2020 19:20:34 -0400
Message-Id: <20200523232035.1029349-11-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523232035.1029349-1-peterx@redhat.com>
References: <20200523232035.1029349-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/23 18:49:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a parameter for dirty gfn count for dirty rings.  If zero, dirty ring is
disabled.  Otherwise dirty ring will be enabled with the per-vcpu gfn count as
specified.  If dirty ring cannot be enabled due to unsupported kernel or
illegal parameter, it'll fallback to dirty logging.

By default, dirty ring is not enabled (dirty-gfn-count default to 0).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 72 +++++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx     |  5 ++++
 2 files changed, 77 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b9aaa7912c..dd017d0720 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -128,6 +128,9 @@ struct KVMState
         KVMMemoryListener *ml;
         AddressSpace *as;
     } *as;
+    bool kvm_dirty_ring_enabled;    /* Whether KVM dirty ring is enabled */
+    uint64_t kvm_dirty_ring_size;   /* Size of the per-vcpu dirty ring */
+    uint32_t kvm_dirty_gfn_count;   /* Number of dirty GFNs per ring */
 };
 
 KVMState *kvm_state;
@@ -2129,6 +2132,40 @@ static int kvm_init(MachineState *ms)
     s->memory_listener.listener.coalesced_io_add = kvm_coalesce_mmio_region;
     s->memory_listener.listener.coalesced_io_del = kvm_uncoalesce_mmio_region;
 
+    /*
+     * Enable KVM dirty ring if supported, otherwise fall back to
+     * dirty logging mode
+     */
+    if (s->kvm_dirty_gfn_count > 0) {
+        uint64_t ring_size;
+
+        ring_size = s->kvm_dirty_gfn_count * sizeof(struct kvm_dirty_gfn);
+
+        /* Read the max supported pages */
+        ret = kvm_vm_check_extension(kvm_state, KVM_CAP_DIRTY_LOG_RING);
+        if (ret > 0) {
+            if (ring_size > ret) {
+                error_report("KVM dirty GFN count %" PRIu32 " too big "
+                             "(maximum is %ld).  Please use a smaller value.",
+                             s->kvm_dirty_gfn_count,
+                             ret / sizeof(struct kvm_dirty_gfn));
+                ret = -EINVAL;
+                goto err;
+            }
+
+            ret = kvm_vm_enable_cap(s, KVM_CAP_DIRTY_LOG_RING, 0, ring_size);
+            if (ret) {
+                error_report("Enabling of KVM dirty ring failed: %d. "
+                             "Suggested mininum value is 1024. "
+                             "Please also make sure it's a power of two.", ret);
+                goto err;
+            }
+
+            s->kvm_dirty_ring_size = ring_size;
+            s->kvm_dirty_ring_enabled = true;
+        }
+    }
+
     kvm_memory_listener_register(s, &s->memory_listener,
                                  &address_space_memory, 0);
     memory_listener_register(&kvm_io_listener,
@@ -3089,6 +3126,33 @@ bool kvm_kernel_irqchip_split(void)
     return kvm_state->kernel_irqchip_split == ON_OFF_AUTO_ON;
 }
 
+static void kvm_get_dirty_gfn_count(Object *obj, Visitor *v,
+                                    const char *name, void *opaque,
+                                    Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+    uint32_t value = s->kvm_dirty_gfn_count;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void kvm_set_dirty_gfn_count(Object *obj, Visitor *v,
+                                    const char *name, void *opaque,
+                                    Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+    Error *error = NULL;
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, &error);
+    if (error) {
+        error_propagate(errp, error);
+        return;
+    }
+
+    s->kvm_dirty_gfn_count = value;
+}
+
 static void kvm_accel_instance_init(Object *obj)
 {
     KVMState *s = KVM_STATE(obj);
@@ -3096,6 +3160,8 @@ static void kvm_accel_instance_init(Object *obj)
     s->kvm_shadow_mem = -1;
     s->kernel_irqchip_allowed = true;
     s->kernel_irqchip_split = ON_OFF_AUTO_AUTO;
+    /* KVM dirty ring is by default off */
+    s->kvm_dirty_gfn_count = 0;
 }
 
 static void kvm_accel_class_init(ObjectClass *oc, void *data)
@@ -3117,6 +3183,12 @@ static void kvm_accel_class_init(ObjectClass *oc, void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "kvm-shadow-mem",
         "KVM shadow MMU size");
+
+    object_class_property_add(oc, "dirty-gfn-count", "uint32",
+        kvm_get_dirty_gfn_count, kvm_set_dirty_gfn_count,
+        NULL, NULL);
+    object_class_property_set_description(oc, "dirty-gfn-count",
+        "KVM dirty GFN count (=0 to disable dirty ring)");
 }
 
 static const TypeInfo kvm_accel_type = {
diff --git a/qemu-options.hx b/qemu-options.hx
index 93bde2bbc8..b59d47473e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -124,6 +124,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "                kernel-irqchip=on|off|split controls accelerated irqchip support (default=on)\n"
     "                kvm-shadow-mem=size of KVM shadow MMU in bytes\n"
     "                tb-size=n (TCG translation block cache size)\n"
+    "                dirty-gfn-count=n (KVM dirty ring GFN count, default 0)\n"
     "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
 SRST
 ``-accel name[,prop=value[,...]]``
@@ -158,6 +159,10 @@ SRST
         where both the back-end and front-ends support it and no
         incompatible TCG features have been enabled (e.g.
         icount/replay).
+
+    ``dirty-gfn-count=n``
+        Controls the per-vcpu KVM dirty ring GFN count (=0 to disable).
+
 ERST
 
 DEF("smp", HAS_ARG, QEMU_OPTION_smp,
-- 
2.26.2


