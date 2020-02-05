Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87425C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532C920702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+BneKJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532C920702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLYk-0007et-Gn
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1izLVN-0001Y4-0I
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1izLVL-0004om-Ok
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37623
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1izLVL-0004ln-K2
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580912291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fz3NNX5AQ85UcY6yKGiJK1sZmDXeAQTTmBMXqMLh684=;
 b=R+BneKJBDucE9RFoA4zUIF5yKb0stZV92pcajhxQ4M/AqX5FzewZF3/xK3hWaMKXrIFaDc
 FyWdKXS2+ou2PLY7qQNmyeCRuY+7k0ebctaA908P0CfiUyaAmL0iPv9Gsk4yDQM3O7a27G
 MYAdQ9Cptk+c3Abg7zwm6w3sjGFIo7k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-DC4CotIQOo-M7wdC33_lMQ-1; Wed, 05 Feb 2020 09:18:09 -0500
Received: by mail-qk1-f198.google.com with SMTP id a132so1366021qkg.5
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 06:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rx27vFBWamWKMWsj2aJzAbu6Jt3ncPu4wuVyMsyAlAQ=;
 b=azhuGRi76uueVOW0W4/asNOJmCuXuzWbo10KTowfT2fOe6tUh6P83fnMnTqRB/+/a9
 y5pvL1SyamiwCQQjqwnHkzUnHU2h5HtIwR88V55kH7Xc2LEQgzcZ4+RQMuspWAD/ZEpl
 OAykaEnhDfvD9mHQgjQ9AAItEdErtsJMNYqlMmw3jMzijjdxqmV33EKN3PR/s1BEiI/R
 E3FdZIuWNSwH9JEJONVNEOvuhrLGRhQ3wqPGAVfdYEmnhrY07Bcps5hgKhzNvlHH5KGv
 2aOZZ6BoZBKyGAuFrYvL/irr8oi+5GSs/8NoKV9tMIgKe6YB4gXL2e8NfW4tmjIHRxzO
 gndQ==
X-Gm-Message-State: APjAAAWTg0jXUo3RCaajHB4plwujjVNxBi0egLN0tPLo4TVABUTqtEdQ
 GRTNl/716o7NGXm1EoblqlM8XMH/WUIz1DKi0wNd22O9xUHu2PQXkvX2y5q+/aEWs+40M0MX2pl
 tCp33KfUZ08G43QU=
X-Received: by 2002:a05:620a:1112:: with SMTP id
 o18mr32769346qkk.126.1580912288750; 
 Wed, 05 Feb 2020 06:18:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/x/dJ4OZGUf2SQESxUQiKdI8ZLgPdImKUIXqQVipxlQkM4ZKAfQcJh6Hd1PUgIRFjx8LDdw==
X-Received: by 2002:a05:620a:1112:: with SMTP id
 o18mr32769315qkk.126.1580912288407; 
 Wed, 05 Feb 2020 06:18:08 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id q5sm12833489qkf.14.2020.02.05.06.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 06:18:07 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 8/9] KVM: Add dirty-ring-size property
Date: Wed,  5 Feb 2020 09:17:48 -0500
Message-Id: <20200205141749.378044-9-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205141749.378044-1-peterx@redhat.com>
References: <20200205141749.378044-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: DC4CotIQOo-M7wdC33_lMQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a parameter for size of dirty ring.  If zero, dirty ring is
disabled.  Otherwise dirty ring will be enabled with the per-vcpu size
as specified.  If dirty ring cannot be enabled due to unsupported
kernel, it'll fallback to dirty logging.  By default, dirty ring is
not enabled (dirty-ring-size=3D=3D0).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx     |  3 +++
 2 files changed, 67 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ea7b8f7ca5..6d145a8b98 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -127,6 +127,8 @@ struct KVMState
         KVMMemoryListener *ml;
         AddressSpace *as;
     } *as;
+    int kvm_dirty_ring_size;
+    int kvm_dirty_gfn_count;    /* If nonzero, then kvm dirty ring enabled=
 */
 };
=20
 KVMState *kvm_state;
@@ -2077,6 +2079,33 @@ static int kvm_init(MachineState *ms)
     s->memory_listener.listener.coalesced_io_add =3D kvm_coalesce_mmio_reg=
ion;
     s->memory_listener.listener.coalesced_io_del =3D kvm_uncoalesce_mmio_r=
egion;
=20
+    /*
+     * Enable KVM dirty ring if supported, otherwise fall back to
+     * dirty logging mode
+     */
+    if (s->kvm_dirty_ring_size > 0) {
+        /* Read the max supported pages */
+        ret =3D kvm_vm_check_extension(kvm_state, KVM_CAP_DIRTY_LOG_RING);
+        if (ret > 0) {
+            if (s->kvm_dirty_ring_size > ret) {
+                error_report("KVM dirty ring size %d too big (maximum is %=
d). "
+                             "Please use a smaller value.",
+                             s->kvm_dirty_ring_size, ret);
+                goto err;
+            }
+
+            ret =3D kvm_vm_enable_cap(s, KVM_CAP_DIRTY_LOG_RING, 0,
+                                    s->kvm_dirty_ring_size);
+            if (ret) {
+                error_report("Enabling of KVM dirty ring failed: %d", ret)=
;
+                goto err;
+            }
+
+            s->kvm_dirty_gfn_count =3D
+                s->kvm_dirty_ring_size / sizeof(struct kvm_dirty_gfn);
+        }
+    }
+
     kvm_memory_listener_register(s, &s->memory_listener,
                                  &address_space_memory, 0);
     memory_listener_register(&kvm_io_listener,
@@ -3037,6 +3066,33 @@ bool kvm_kernel_irqchip_split(void)
     return kvm_state->kernel_irqchip_split =3D=3D ON_OFF_AUTO_ON;
 }
=20
+static void kvm_get_dirty_ring_size(Object *obj, Visitor *v,
+                                    const char *name, void *opaque,
+                                    Error **errp)
+{
+    KVMState *s =3D KVM_STATE(obj);
+    int64_t value =3D s->kvm_dirty_ring_size;
+
+    visit_type_int(v, name, &value, errp);
+}
+
+static void kvm_set_dirty_ring_size(Object *obj, Visitor *v,
+                                    const char *name, void *opaque,
+                                    Error **errp)
+{
+    KVMState *s =3D KVM_STATE(obj);
+    Error *error =3D NULL;
+    int64_t value;
+
+    visit_type_int(v, name, &value, &error);
+    if (error) {
+        error_propagate(errp, error);
+        return;
+    }
+
+    s->kvm_dirty_ring_size =3D value;
+}
+
 static void kvm_accel_instance_init(Object *obj)
 {
     KVMState *s =3D KVM_STATE(obj);
@@ -3044,6 +3100,8 @@ static void kvm_accel_instance_init(Object *obj)
     s->kvm_shadow_mem =3D -1;
     s->kernel_irqchip_allowed =3D true;
     s->kernel_irqchip_split =3D ON_OFF_AUTO_AUTO;
+    /* By default off */
+    s->kvm_dirty_ring_size =3D 0;
 }
=20
 static void kvm_accel_class_init(ObjectClass *oc, void *data)
@@ -3065,6 +3123,12 @@ static void kvm_accel_class_init(ObjectClass *oc, vo=
id *data)
         NULL, NULL, &error_abort);
     object_class_property_set_description(oc, "kvm-shadow-mem",
         "KVM shadow MMU size", &error_abort);
+
+    object_class_property_add(oc, "dirty-ring-size", "int",
+        kvm_get_dirty_ring_size, kvm_set_dirty_ring_size,
+        NULL, NULL, &error_abort);
+    object_class_property_set_description(oc, "dirty-ring-size",
+        "KVM dirty ring size (<=3D0 to disable)", &error_abort);
 }
=20
 static const TypeInfo kvm_accel_type =3D {
diff --git a/qemu-options.hx b/qemu-options.hx
index 224a8e8712..140bd38726 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -119,6 +119,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "                kernel-irqchip=3Don|off|split controls accelerated ir=
qchip support (default=3Don)\n"
     "                kvm-shadow-mem=3Dsize of KVM shadow MMU in bytes\n"
     "                tb-size=3Dn (TCG translation block cache size)\n"
+    "                dirty-ring-size=3Dn (KVM dirty ring size in Bytes)\n"
     "                thread=3Dsingle|multi (enable multi-threaded TCG)\n",=
 QEMU_ARCH_ALL)
 STEXI
 @item -accel @var{name}[,prop=3D@var{value}[,...]]
@@ -140,6 +141,8 @@ irqchip completely is not recommended except for debugg=
ing purposes.
 Defines the size of the KVM shadow MMU.
 @item tb-size=3D@var{n}
 Controls the size (in MiB) of the TCG translation block cache.
+@item dirty-ring-size=3D@val{n}
+Controls the size (in Bytes) of KVM dirty ring (<=3D0 to disable).
 @item thread=3Dsingle|multi
 Controls number of TCG threads. When the TCG is multi-threaded there will =
be one
 thread per vCPU therefor taking advantage of additional host cores. The de=
fault
--=20
2.24.1


