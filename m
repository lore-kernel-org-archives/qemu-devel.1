Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D66DC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163DF2067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHk7tShc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163DF2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZu5-0004yf-A6
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 10:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipZem-00009K-SH
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipZel-0000A6-AU
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:23:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28083
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipZel-00006t-5c
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578583410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEB5J+exbJGBcgBu1CXxgeJ3mLfk648Rs1grVXpU7U4=;
 b=UHk7tShcqRPOGcpAYfO3CVDACPnFahwf6vrwt40NbPthSNXJfGsfr4DD/+pO0uD1Unx02f
 GPWxC1838fplpFpfDnpr3NZ47FxA7h/DqTnoGmVFgk2u5yBq2kEgv9Xlz/b2fEpdoS15nV
 1s8azLvgrVMgHUt0DCXcwrd5yrpwbH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-GrJTMZRwNw-0xA4bX3RZSQ-1; Thu, 09 Jan 2020 10:23:29 -0500
X-MC-Unique: GrJTMZRwNw-0xA4bX3RZSQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79BB0800D48;
 Thu,  9 Jan 2020 15:23:27 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-180.brq.redhat.com [10.40.204.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 496647FB5C;
 Thu,  9 Jan 2020 15:23:21 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/15] accel: Replace current_machine->accelerator by
 current_accel() method
Date: Thu,  9 Jan 2020 16:21:31 +0100
Message-Id: <20200109152133.23649-14-philmd@redhat.com>
In-Reply-To: <20200109152133.23649-1-philmd@redhat.com>
References: <20200109152133.23649-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, qemu-ppc@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we want to remove the global current_machine,
replace 'current_machine->accelerator' by current_accel().

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 accel/kvm/kvm-all.c | 4 ++--
 accel/tcg/tcg-all.c | 2 +-
 memory.c            | 2 +-
 target/arm/kvm64.c  | 4 ++--
 target/i386/kvm.c   | 2 +-
 target/ppc/kvm.c    | 2 +-
 vl.c                | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b2f1a5bcb5..be1980f250 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -164,7 +164,7 @@ static NotifierList kvm_irqchip_change_notifiers =3D
=20
 int kvm_get_max_memslots(void)
 {
-    KVMState *s =3D KVM_STATE(current_machine->accelerator);
+    KVMState *s =3D KVM_STATE(current_accel());
=20
     return s->nr_slots;
 }
@@ -1847,7 +1847,7 @@ static int kvm_max_vcpu_id(KVMState *s)
=20
 bool kvm_vcpu_id_is_valid(int vcpu_id)
 {
-    KVMState *s =3D KVM_STATE(current_machine->accelerator);
+    KVMState *s =3D KVM_STATE(current_accel());
     return vcpu_id >=3D 0 && vcpu_id < kvm_max_vcpu_id(s);
 }
=20
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 1dc384c8d2..1802ce02f6 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -124,7 +124,7 @@ static void tcg_accel_instance_init(Object *obj)
=20
 static int tcg_init(MachineState *ms)
 {
-    TCGState *s =3D TCG_STATE(current_machine->accelerator);
+    TCGState *s =3D TCG_STATE(current_accel());
=20
     tcg_exec_init(s->tb_size * 1024 * 1024);
     cpu_interrupt_handler =3D tcg_handle_interrupt;
diff --git a/memory.c b/memory.c
index 57e38b1f50..60e8993499 100644
--- a/memory.c
+++ b/memory.c
@@ -3106,7 +3106,7 @@ void mtree_info(bool flatview, bool dispatch_tree, =
bool owner)
         };
         GArray *fv_address_spaces;
         GHashTable *views =3D g_hash_table_new(g_direct_hash, g_direct_e=
qual);
-        AccelClass *ac =3D ACCEL_GET_CLASS(current_machine->accelerator)=
;
+        AccelClass *ac =3D ACCEL_GET_CLASS(current_accel());
=20
         if (ac->has_memory) {
             fvi.ac =3D ac;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 876184b8fe..f677877a1e 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -613,14 +613,14 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatur=
es *ahcf)
=20
 bool kvm_arm_aarch32_supported(CPUState *cpu)
 {
-    KVMState *s =3D KVM_STATE(current_machine->accelerator);
+    KVMState *s =3D KVM_STATE(current_accel());
=20
     return kvm_check_extension(s, KVM_CAP_ARM_EL1_32BIT);
 }
=20
 bool kvm_arm_sve_supported(CPUState *cpu)
 {
-    KVMState *s =3D KVM_STATE(current_machine->accelerator);
+    KVMState *s =3D KVM_STATE(current_accel());
=20
     return kvm_check_extension(s, KVM_CAP_ARM_SVE);
 }
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 0b511906e3..2ed15814dc 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -147,7 +147,7 @@ bool kvm_allows_irq0_override(void)
=20
 static bool kvm_x2apic_api_set_flags(uint64_t flags)
 {
-    KVMState *s =3D KVM_STATE(current_machine->accelerator);
+    KVMState *s =3D KVM_STATE(current_accel());
=20
     return !kvm_vm_enable_cap(s, KVM_CAP_X2APIC_API, 0, flags);
 }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d1c334f0e3..2d011308e0 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -258,7 +258,7 @@ static void kvm_get_smmu_info(struct kvm_ppc_smmu_inf=
o *info, Error **errp)
=20
 struct ppc_radix_page_info *kvm_get_radix_page_info(void)
 {
-    KVMState *s =3D KVM_STATE(current_machine->accelerator);
+    KVMState *s =3D KVM_STATE(current_accel());
     struct ppc_radix_page_info *radix_page_info;
     struct kvm_ppc_rmmu_info rmmu_info;
     int i;
diff --git a/vl.c b/vl.c
index 86474a55c9..3ff3548183 100644
--- a/vl.c
+++ b/vl.c
@@ -2804,7 +2804,7 @@ static void configure_accelerators(const char *prog=
name)
     }
=20
     if (init_failed) {
-        AccelClass *ac =3D ACCEL_GET_CLASS(current_machine->accelerator)=
;
+        AccelClass *ac =3D ACCEL_GET_CLASS(current_accel());
         error_report("falling back to %s", ac->name);
     }
=20
--=20
2.21.1


