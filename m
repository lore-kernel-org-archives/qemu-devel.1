Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8A9CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2524720684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7Fj5dEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2524720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfKE-0002DT-6i
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdjG-0008O6-Pe
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdjF-0007y5-AH
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:42 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdjF-0007xO-3i
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:41 -0400
Received: by mail-wm1-x341.google.com with SMTP id q70so3013197wme.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=hs3ekp8CnLHyDVgFbGkCYGX2UG3bGpyZUnsgM/bA+io=;
 b=r7Fj5dEzBAZJ61VvjvvXtAO8/av+7byDTbxOIH7LMC92gqndUfZNA4YseXUqCNu4rs
 z2epSrmxWUIzvn/OOcas2gF8PsgWtt1EbxdSyl/oQ0u1YgG4btZm6m9TpaSDCM1oF7bT
 wgqI3SqFs/mShN9Kpif7m1jfXrH7OnYbB0hvLyLStFInroJ+tEakRWAlFd9gQYdSVG4j
 aaJnNVxQpKAlNo30rCJN1cF39gd5qSMY5F9LHWGuNMi0jiFpxw2N70RbS51OlDt0slWS
 iIk+PXsvfIeGU3jTy5uwnDI3pySyQWGv5K2wIHfH9KHxucR9r4CpeXOCSWI/rp0tyvqB
 p81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=hs3ekp8CnLHyDVgFbGkCYGX2UG3bGpyZUnsgM/bA+io=;
 b=er070TLY5z8+FN1f0Usty4U7MHDyr0w5jqAfqvigfYJcOFA3mMJV/6qnvTXQmOZEka
 Ort3gzyHWyIKdK6Oyy6X/+GITbDrq/CgBXpGkZeszHK+Ej85/Ffy1vKubqYyDs/ZEIrz
 +JBx6150Eg60Ab7hQf5W9xabg6NIDMfFH6AYWh9Jv99BaBMgl03MdcRnA0HlBsH6Kmds
 VuI4eQuq+B10tgftt4M6I4riZB0TJdzbUmXwYBePmSoQutZ3O2tEJCrKWpi7cXArOTiw
 cxCgzTnYbd7bNZzr8iY2pDwydJFMdxLwEu5Vjh2qCMotscOSM7q8hk9WQEWEPqS5D7uC
 dnag==
X-Gm-Message-State: APjAAAUn/5IxtvifgMCY+nzP0siwrC2AOEDOBsoB13frr7FkkpjS2DFo
 WxW0OLVy4Ej6C/NmxYteh2pspCsR
X-Google-Smtp-Source: APXvYqypAw00Z5CzoK4GZv2D1OoMhxL8/qr0aBKvaXE2h0t7o8np5MIRFgROQ2a07kLFSMOa8WHiJA==
X-Received: by 2002:a1c:398b:: with SMTP id g133mr5415568wma.130.1571925879801; 
 Thu, 24 Oct 2019 07:04:39 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 39/39] i386: implement IGNNE
Date: Thu, 24 Oct 2019 16:03:55 +0200
Message-Id: <1571925835-31930-40-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

Change the handling of port F0h writes and FPU exceptions to implement IGNNE.

The implementation mixes a bit what the chipset and processor do in real
hardware, but the effect is the same as what happens with actual FERR#
and IGNNE# pins: writing to port F0h asserts IGNNE# in addition to lowering
FP_IRQ; while clearing the SE bit in the FPU status word deasserts IGNNE#.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c             |  2 +-
 target/i386/cpu.h        |  4 +++-
 target/i386/fpu_helper.c | 34 +++++++++++++++++++++++++++-------
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 66d865b..174b0bd 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -385,7 +385,7 @@ static void ioportF0_write(void *opaque, hwaddr addr, uint64_t data,
                            unsigned size)
 {
     if (tcg_enabled()) {
-        cpu_clear_ferr();
+        cpu_set_ignne();
     }
 }
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 01e052b..5352c9f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -203,6 +203,7 @@ typedef enum X86Seg {
 #define HF2_SMM_INSIDE_NMI_SHIFT 4 /* CPU serving SMI nested inside NMI */
 #define HF2_MPX_PR_SHIFT         5 /* BNDCFGx.BNDPRESERVE */
 #define HF2_NPT_SHIFT            6 /* Nested Paging enabled */
+#define HF2_IGNNE_SHIFT          7 /* Ignore CR0.NE=0 */
 
 #define HF2_GIF_MASK            (1 << HF2_GIF_SHIFT)
 #define HF2_HIF_MASK            (1 << HF2_HIF_SHIFT)
@@ -211,6 +212,7 @@ typedef enum X86Seg {
 #define HF2_SMM_INSIDE_NMI_MASK (1 << HF2_SMM_INSIDE_NMI_SHIFT)
 #define HF2_MPX_PR_MASK         (1 << HF2_MPX_PR_SHIFT)
 #define HF2_NPT_MASK            (1 << HF2_NPT_SHIFT)
+#define HF2_IGNNE_MASK          (1 << HF2_IGNNE_SHIFT)
 
 #define CR0_PE_SHIFT 0
 #define CR0_MP_SHIFT 1
@@ -1762,7 +1764,7 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env);
 int cpu_get_pic_interrupt(CPUX86State *s);
 /* MSDOS compatibility mode FPU exception support */
 void x86_register_ferr_irq(qemu_irq irq);
-void cpu_clear_ferr(void);
+void cpu_set_ignne(void);
 /* mpx_helper.c */
 void cpu_sync_bndcs_hflags(CPUX86State *env);
 
diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 6825024..99f28f2 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -70,14 +70,24 @@ void x86_register_ferr_irq(qemu_irq irq)
     ferr_irq = irq;
 }
 
-void cpu_clear_ferr(void)
+static void cpu_clear_ignne(void)
 {
-    qemu_irq_lower(ferr_irq);
+    CPUX86State *env = &X86_CPU(first_cpu)->env;
+    env->hflags2 &= ~HF2_IGNNE_MASK;
 }
 
-static void cpu_set_ferr(void)
+void cpu_set_ignne(void)
 {
-    qemu_irq_raise(ferr_irq);
+    CPUX86State *env = &X86_CPU(first_cpu)->env;
+    env->hflags2 |= HF2_IGNNE_MASK;
+    /*
+     * We get here in response to a write to port F0h.  The chipset should
+     * deassert FP_IRQ and FERR# instead should stay signaled until FPSW_SE is
+     * cleared, because FERR# and FP_IRQ are two separate pins on real
+     * hardware.  However, we don't model FERR# as a qemu_irq, so we just
+     * do directly what the chipset would do, i.e. deassert FP_IRQ.
+     */
+    qemu_irq_lower(ferr_irq);
 }
 #endif
 
@@ -160,8 +170,8 @@ static void fpu_raise_exception(CPUX86State *env, uintptr_t retaddr)
         raise_exception_ra(env, EXCP10_COPR, retaddr);
     }
 #if !defined(CONFIG_USER_ONLY)
-    else {
-        cpu_set_ferr();
+    else if (ferr_irq && !(env->hflags2 & HF2_IGNNE_MASK)) {
+        qemu_irq_raise(ferr_irq);
     }
 #endif
 }
@@ -1056,7 +1066,17 @@ void helper_fstenv(CPUX86State *env, target_ulong ptr, int data32)
 static void cpu_set_fpus(CPUX86State *env, uint16_t fpus)
 {
     env->fpstt = (fpus >> 11) & 7;
-    env->fpus = fpus & ~0x3800;
+    env->fpus = fpus & ~0x3800 & ~FPUS_B;
+    env->fpus |= env->fpus & FPUS_SE ? FPUS_B : 0;
+#if !defined(CONFIG_USER_ONLY)
+    if (!(env->fpus & FPUS_SE)) {
+        /*
+         * Here the processor deasserts FERR#; in response, the chipset deasserts
+         * IGNNE#.
+         */
+        cpu_clear_ignne();
+    }
+#endif
 }
 
 static void do_fldenv(CPUX86State *env, target_ulong ptr, int data32,
-- 
1.8.3.1


