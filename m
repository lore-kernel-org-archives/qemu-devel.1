Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AEBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 18:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C220922525
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 18:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANZAT28Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C220922525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itbhk-0008Qu-PZ
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 13:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1itbgY-00074b-2v
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1itbgT-0008H3-5D
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:22:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59394
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1itbgS-0008Ga-LL
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579544515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4h394zVYwzBK1bDgWPwOkluW3Bm8JJtIZLYnXuoV6F0=;
 b=ANZAT28QTIKvsS7uEpggG2+1oxak0MqlNdotKwwxjJYGsscHoeVtu7/A3iyTPyo+oobDF/
 g8/8otXt2pzUMfWKoeU3hthIEe2XPBnsXd9Q2TGnDkvW8JWqbbl5wyWKCZR37NNDJ6J9ok
 df7zEA4FPdvCdrelhDiKMMnqVI/08SE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-NU6wtaCEPF2qS_bdfr0z1A-1; Mon, 20 Jan 2020 13:21:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78DF28010C4;
 Mon, 20 Jan 2020 18:21:51 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3543260BF7;
 Mon, 20 Jan 2020 18:21:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] target/i386: add a ucode-rev property
Date: Mon, 20 Jan 2020 19:21:43 +0100
Message-Id: <1579544504-3616-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579544504-3616-1-git-send-email-pbonzini@redhat.com>
References: <1579544504-3616-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: NU6wtaCEPF2qS_bdfr0z1A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: vkuznets@redhat.com, liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the property and plumb it in TCG and HVF (the latter of which
tried to support returning a constant value but used the wrong MSR).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c         | 10 ++++++++++
 target/i386/cpu.h         |  3 +++
 target/i386/hvf/x86_emu.c |  4 +---
 target/i386/misc_helper.c |  4 ++++
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 41f28ce..05ce64c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6418,6 +6418,15 @@ static void x86_cpu_realizefn(DeviceState *dev, Erro=
r **errp)
         }
     }
=20
+    if (cpu->ucode_rev =3D=3D 0) {
+        /* The default is the same as KVM's.  */
+        if (IS_AMD_CPU(env)) {
+            cpu->ucode_rev =3D 0x01000065;
+        } else {
+            cpu->ucode_rev =3D 0x100000000ULL;
+        }
+    }
+
     /* mwait extended info: needed for Core compatibility */
     /* We always wake on interrupt even if host does not have the capabili=
ty */
     cpu->mwait.ecx |=3D CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
@@ -7100,6 +7109,7 @@ static Property x86_cpu_properties[] =3D {
     DEFINE_PROP_UINT32("min-level", X86CPU, env.cpuid_min_level, 0),
     DEFINE_PROP_UINT32("min-xlevel", X86CPU, env.cpuid_min_xlevel, 0),
     DEFINE_PROP_UINT32("min-xlevel2", X86CPU, env.cpuid_min_xlevel2, 0),
+    DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
     DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_leve=
l, true),
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor_id),
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e6de38a..576f309 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -348,6 +348,7 @@ typedef enum X86Seg {
 #define MSR_IA32_SPEC_CTRL              0x48
 #define MSR_VIRT_SSBD                   0xc001011f
 #define MSR_IA32_PRED_CMD               0x49
+#define MSR_IA32_UCODE_REV              0x8b
 #define MSR_IA32_CORE_CAPABILITY        0xcf
=20
 #define MSR_IA32_ARCH_CAPABILITIES      0x10a
@@ -1627,6 +1628,8 @@ struct X86CPU {
     CPUNegativeOffsetState neg;
     CPUX86State env;
=20
+    uint64_t ucode_rev;
+
     uint32_t hyperv_spinlock_attempts;
     char *hyperv_vendor_id;
     bool hyperv_synic_kvm_only;
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 3df7672..92ab815 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -664,8 +664,6 @@ static void exec_lods(struct CPUX86State *env, struct x=
86_decode *decode)
     RIP(env) +=3D decode->len;
 }
=20
-#define MSR_IA32_UCODE_REV 0x00000017
-
 void simulate_rdmsr(struct CPUState *cpu)
 {
     X86CPU *x86_cpu =3D X86_CPU(cpu);
@@ -681,7 +679,7 @@ void simulate_rdmsr(struct CPUState *cpu)
         val =3D cpu_get_apic_base(X86_CPU(cpu)->apic_state);
         break;
     case MSR_IA32_UCODE_REV:
-        val =3D (0x100000000ULL << 32) | 0x100000000ULL;
+        val =3D x86_cpu->ucode_rev;
         break;
     case MSR_EFER:
         val =3D rvmcs(cpu->hvf_fd, VMCS_GUEST_IA32_EFER);
diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index 3eff688..aed16fe 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -229,6 +229,7 @@ void helper_rdmsr(CPUX86State *env)
 #else
 void helper_wrmsr(CPUX86State *env)
 {
+    X86CPU *x86_cpu =3D env_archcpu(env);
     uint64_t val;
=20
     cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 1, GETPC());
@@ -371,6 +372,9 @@ void helper_wrmsr(CPUX86State *env)
         env->msr_bndcfgs =3D val;
         cpu_sync_bndcs_hflags(env);
         break;
+     case MSR_IA32_UCODE_REV:
+        val =3D x86_cpu->ucode_rev;
+        break;
     default:
         if ((uint32_t)env->regs[R_ECX] >=3D MSR_MC0_CTL
             && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
--=20
1.8.3.1



