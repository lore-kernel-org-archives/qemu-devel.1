Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58024C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E5520704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nz5PE0gG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E5520704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iug9d-0007vZ-Jo
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuctr-0000WB-4N
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuctp-0000VY-P1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35415
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuctp-0000TE-Li
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+zu8pJ4KXnZi5gS2YErITxGb5XKI6g0YeXMXaix92U=;
 b=Nz5PE0gGIRxxpYX4BcZlXUcl/s4sj4X4YJlCnO7TkjhpIRpPYNwMsHgLeDPUdGQNhLvGmi
 cl927izXRVWcmq/v0J1gZY1E/fDN5cH1y36l2/rz4CRgRheAwuNpDZyJED6Qa7f+/qQwPE
 xSQwZB9yre1Mj6O2bHdJZoZuoNEp9so=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-L4YjQPpGN_qJsw7fk7Xa4w-1; Thu, 23 Jan 2020 08:51:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B86D4A0CC7
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:51:54 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B501984DBD;
 Thu, 23 Jan 2020 13:51:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/59] accel: Replace current_machine->accelerator by
 current_accel() wrapper
Date: Thu, 23 Jan 2020 14:50:19 +0100
Message-Id: <1579787449-27599-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: L4YjQPpGN_qJsw7fk7Xa4w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

We actually want to access the accelerator, not the machine, so
use the current_accel() wrapper instead.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200121110349.25842-10-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 4 ++--
 accel/tcg/tcg-all.c | 2 +-
 memory.c            | 2 +-
 target/arm/kvm64.c  | 5 ++---
 target/i386/kvm.c   | 2 +-
 target/ppc/kvm.c    | 4 ++--
 vl.c                | 2 +-
 7 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 1ada2f4..c111312 100644
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
@@ -1848,7 +1848,7 @@ static int kvm_max_vcpu_id(KVMState *s)
=20
 bool kvm_vcpu_id_is_valid(int vcpu_id)
 {
-    KVMState *s =3D KVM_STATE(current_machine->accelerator);
+    KVMState *s =3D KVM_STATE(current_accel());
     return vcpu_id >=3D 0 && vcpu_id < kvm_max_vcpu_id(s);
 }
=20
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 1dc384c..1802ce0 100644
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
index d7b9bb6..8547987 100644
--- a/memory.c
+++ b/memory.c
@@ -3104,7 +3104,7 @@ void mtree_info(bool flatview, bool dispatch_tree, bo=
ol owner)
         };
         GArray *fv_address_spaces;
         GHashTable *views =3D g_hash_table_new(g_direct_hash, g_direct_equ=
al);
-        AccelClass *ac =3D ACCEL_GET_CLASS(current_machine->accelerator);
+        AccelClass *ac =3D ACCEL_GET_CLASS(current_accel());
=20
         if (ac->has_memory) {
             fvi.ac =3D ac;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 876184b..e3c580e 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -26,7 +26,6 @@
 #include "sysemu/kvm.h"
 #include "sysemu/kvm_int.h"
 #include "kvm_arm.h"
-#include "hw/boards.h"
 #include "internals.h"
=20
 static bool have_guest_debug;
@@ -613,14 +612,14 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures=
 *ahcf)
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
index 1b67090..6ef291d 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -149,7 +149,7 @@ bool kvm_allows_irq0_override(void)
=20
 static bool kvm_x2apic_api_set_flags(uint64_t flags)
 {
-    KVMState *s =3D KVM_STATE(current_machine->accelerator);
+    KVMState *s =3D KVM_STATE(current_accel());
=20
     return !kvm_vm_enable_cap(s, KVM_CAP_X2APIC_API, 0, flags);
 }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index b5799e6..06fd0cc 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -258,7 +258,7 @@ static void kvm_get_smmu_info(struct kvm_ppc_smmu_info =
*info, Error **errp)
=20
 struct ppc_radix_page_info *kvm_get_radix_page_info(void)
 {
-    KVMState *s =3D KVM_STATE(current_machine->accelerator);
+    KVMState *s =3D KVM_STATE(current_accel());
     struct ppc_radix_page_info *radix_page_info;
     struct kvm_ppc_rmmu_info rmmu_info;
     int i;
@@ -2907,7 +2907,7 @@ void kvmppc_svm_off(Error **errp)
         return;
     }
=20
-    rc =3D kvm_vm_ioctl(KVM_STATE(current_machine->accelerator), KVM_PPC_S=
VM_OFF);
+    rc =3D kvm_vm_ioctl(KVM_STATE(current_accel()), KVM_PPC_SVM_OFF);
     if (rc && rc !=3D -ENOTTY) {
         error_setg_errno(errp, -rc, "KVM_PPC_SVM_OFF ioctl failed");
     }
diff --git a/vl.c b/vl.c
index 9f5f477..368dda1 100644
--- a/vl.c
+++ b/vl.c
@@ -2824,7 +2824,7 @@ static void configure_accelerators(const char *progna=
me)
     }
=20
     if (init_failed) {
-        AccelClass *ac =3D ACCEL_GET_CLASS(current_machine->accelerator);
+        AccelClass *ac =3D ACCEL_GET_CLASS(current_accel());
         error_report("falling back to %s", ac->name);
     }
=20
--=20
1.8.3.1



