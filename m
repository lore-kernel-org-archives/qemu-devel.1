Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CF4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2D4207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d20n0S15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2D4207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuegK-0002e8-3G
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:46:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrO-000503-Hd
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrN-0003LW-5f
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:26 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:54227)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrM-0003KN-Ut
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:25 -0500
Received: by mail-wm1-x32d.google.com with SMTP id m24so2637198wmc.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=qaX9ibASrC+U4AOLQHROo7/WmwP1t+LSS0nvSrlZ/0c=;
 b=d20n0S15I4NT5fQEJ7D7WRfwl+FUe37oObbW38bPV57IPOWbVTK1LYvAkoy0+IlMHm
 lBDHXgzJdYyQBzDhTtPV2SRfB70+o3Lp6Nj950Y+ltJMZ7MOHo/+Y8xvmU1wgOHTQA27
 xdEJkDdhla2Enb4udnzWyqgPw2NAKyp9aE5DxpqTiHto8BANxYZnJjBxYQzs54d7yBYZ
 wogxC8xr6AseKi4QSODX1whe17bbM3Djk5K9MamjTTtlsVpWkqNt8T0rNjd1WMbHWcQY
 buqW+O5A4e3JBb1iJqfobSEvTE7cCwcnUKJpnFOLNh0RnID2C1agOADgiUuFcQPHFcIe
 4FKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=qaX9ibASrC+U4AOLQHROo7/WmwP1t+LSS0nvSrlZ/0c=;
 b=qX4IKM0y5eGBAfL4L+hIwrm9wQgdSz3+8m4Yphq4kwTkNzhA7kRpH/R/kLXLBoLDtr
 i3yZVc1DBtuhiMeBHg/SUXpluBzbOWD3zE2fufEK4m8AdMTvxNjd3GUk/ba97CRUMx5v
 jy6fqZZkwlvFD1owYFi6SIb/qnReQczzBzeMHVeXP5oNrQBJQutqHF6sEYzj2bfUqzQW
 fG9MrtWCXnJxQ5fB4cxjT/sTBa1BbUbrKMRzVGF95uhPni/jCnqOcZmByxGEZjS3oUZ6
 ymGAdZ/eFZhoGufdHbZJpk/YSv61+Vfa3KR+eCovR4koggIr9DI92YgTaB2opFDYObwz
 ggTg==
X-Gm-Message-State: APjAAAUeGu6okW8BS5PeGGIUq0c92g1fBxq1ksVDtwckV9xuOVDvaSww
 tdIUokvklw3MB+7ibtGrQoUTAfBO
X-Google-Smtp-Source: APXvYqzvc4marP26fSl3Dz0Jrh90Zj5WO/ja3cd+BtajACURDCu2V7HkT8Eb8oJyodVNpqi0UnF+nw==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr4413993wmi.20.1579787363725;
 Thu, 23 Jan 2020 05:49:23 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/59] target/i386: add a ucode-rev property
Date: Thu, 23 Jan 2020 14:48:22 +0100
Message-Id: <1579787342-27146-20-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the property and plumb it in TCG and HVF (the latter of which
tried to support returning a constant value but used the wrong MSR).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1579544504-3616-3-git-send-email-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c         | 10 ++++++++++
 target/i386/cpu.h         |  3 +++
 target/i386/hvf/x86_emu.c |  4 +---
 target/i386/misc_helper.c |  4 ++++
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 78bdb7c..790254e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6418,6 +6418,15 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
+    if (cpu->ucode_rev == 0) {
+        /* The default is the same as KVM's.  */
+        if (IS_AMD_CPU(env)) {
+            cpu->ucode_rev = 0x01000065;
+        } else {
+            cpu->ucode_rev = 0x100000000ULL;
+        }
+    }
+
     /* mwait extended info: needed for Core compatibility */
     /* We always wake on interrupt even if host does not have the capability */
     cpu->mwait.ecx |= CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
@@ -7100,6 +7109,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT32("min-level", X86CPU, env.cpuid_min_level, 0),
     DEFINE_PROP_UINT32("min-xlevel", X86CPU, env.cpuid_min_xlevel, 0),
     DEFINE_PROP_UINT32("min-xlevel2", X86CPU, env.cpuid_min_xlevel2, 0),
+    DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
     DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
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
 
 #define MSR_IA32_ARCH_CAPABILITIES      0x10a
@@ -1627,6 +1628,8 @@ struct X86CPU {
     CPUNegativeOffsetState neg;
     CPUX86State env;
 
+    uint64_t ucode_rev;
+
     uint32_t hyperv_spinlock_attempts;
     char *hyperv_vendor_id;
     bool hyperv_synic_kvm_only;
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 3df7672..92ab815 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -664,8 +664,6 @@ static void exec_lods(struct CPUX86State *env, struct x86_decode *decode)
     RIP(env) += decode->len;
 }
 
-#define MSR_IA32_UCODE_REV 0x00000017
-
 void simulate_rdmsr(struct CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -681,7 +679,7 @@ void simulate_rdmsr(struct CPUState *cpu)
         val = cpu_get_apic_base(X86_CPU(cpu)->apic_state);
         break;
     case MSR_IA32_UCODE_REV:
-        val = (0x100000000ULL << 32) | 0x100000000ULL;
+        val = x86_cpu->ucode_rev;
         break;
     case MSR_EFER:
         val = rvmcs(cpu->hvf_fd, VMCS_GUEST_IA32_EFER);
diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index 3eff688..aed16fe 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -229,6 +229,7 @@ void helper_rdmsr(CPUX86State *env)
 #else
 void helper_wrmsr(CPUX86State *env)
 {
+    X86CPU *x86_cpu = env_archcpu(env);
     uint64_t val;
 
     cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 1, GETPC());
@@ -371,6 +372,9 @@ void helper_wrmsr(CPUX86State *env)
         env->msr_bndcfgs = val;
         cpu_sync_bndcs_hflags(env);
         break;
+     case MSR_IA32_UCODE_REV:
+        val = x86_cpu->ucode_rev;
+        break;
     default:
         if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
             && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
-- 
1.8.3.1



