Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508D3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3E8206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0OJu+Sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3E8206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtHbr-0007pX-52
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 17:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtHaE-0006Eu-KF
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:26:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42583
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtHa9-0001pn-Sd
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594243579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8mY74RftPXZQ+KxMfUON2KgzxLg2AeBCb09DYzYZyE=;
 b=O0OJu+Sqfd4ITwu1Pf/r+/D6MYbn+9HP7MOIsBwF1rd4KpUZT2KM6zUsdZf+Q0MwrLC8nx
 Ws8fMeqrpko4D0lla0wwRSbGtz9ohklD3v+MnOhpWor8EuZOq8ZnCNawmvNxTTCfKwQwMG
 AWx3F8d+Ts8g+H+DQLQdIxNOLgZirWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-ALqI6sx4NbmJJ8vmwUR1aQ-1; Wed, 08 Jul 2020 13:25:45 -0400
X-MC-Unique: ALqI6sx4NbmJJ8vmwUR1aQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57365107AFDB;
 Wed,  8 Jul 2020 17:25:44 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4B93B3A65;
 Wed,  8 Jul 2020 17:25:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 09/52] target/i386: fix IEEE SSE floating-point exception
 raising
Date: Wed,  8 Jul 2020 13:25:40 -0400
Message-Id: <20200708172542.25012-2-pbonzini@redhat.com>
In-Reply-To: <20200708172542.25012-1-pbonzini@redhat.com>
References: <20200708172542.25012-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joseph Myers <joseph@codesourcery.com>

The SSE instruction implementations all fail to raise the expected
IEEE floating-point exceptions because they do nothing to convert the
exception state from the softfloat machinery into the exception flags
in MXCSR.

Fix this by adding such conversions.  Unlike for x87, emulated SSE
floating-point operations might be optimized using hardware floating
point on the host, and so a different approach is taken that is
compatible with such optimizations.  The required invariant is that
all exceptions set in env->sse_status (other than "denormal operand",
for which the SSE semantics are different from those in the softfloat
code) are ones that are set in the MXCSR; the emulated MXCSR is
updated lazily when code reads MXCSR, while when code sets MXCSR, the
exceptions in env->sse_status are set accordingly.

A few instructions do not raise all the exceptions that would be
raised by the softfloat code, and those instructions are made to save
and restore the softfloat exception state accordingly.

Nothing is done about "denormal operand"; setting that (only for the
case when input denormals are *not* flushed to zero, the opposite of
the logic in the softfloat code for such an exception) will require
custom code for relevant instructions, or else architecture-specific
conditionals in the softfloat code for when to set such an exception
together with custom code for various SSE conversion and rounding
instructions that do not set that exception.

Nothing is done about trapping exceptions (for which there is minimal
and largely broken support in QEMU's emulation in the x87 case and no
support at all in the SSE case).

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Message-Id: <alpine.DEB.2.21.2006252358000.3832@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/Makefile.objs                 |   1 +
 target/i386/cpu.h                         |   1 +
 target/i386/fpu_helper.c                  |  35 +
 target/i386/gdbstub.c                     |   1 +
 target/i386/helper.c                      |   1 +
 target/i386/helper.h                      |   1 +
 target/i386/ops_sse.h                     |  28 +-
 target/i386/tcg-stub.c                    |  25 +
 target/i386/translate.c                   |   1 +
 tests/tcg/i386/Makefile.target            |   4 +
 tests/tcg/i386/test-i386-sse-exceptions.c | 813 ++++++++++++++++++++++
 11 files changed, 899 insertions(+), 12 deletions(-)
 create mode 100644 target/i386/tcg-stub.c
 create mode 100644 tests/tcg/i386/test-i386-sse-exceptions.c

diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 48e0c28434..0b93143e27 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -3,6 +3,7 @@ obj-$(CONFIG_TCG) += translate.o
 obj-$(CONFIG_TCG) += bpt_helper.o cc_helper.o excp_helper.o fpu_helper.o
 obj-$(CONFIG_TCG) += int_helper.o mem_helper.o misc_helper.o mpx_helper.o
 obj-$(CONFIG_TCG) += seg_helper.o smm_helper.o svm_helper.o
+obj-$(call lnot,$(CONFIG_TCG)) += tcg-stub.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 ifeq ($(CONFIG_SOFTMMU),y)
 obj-y += machine.o arch_memory_mapping.o arch_dump.o monitor.o
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7d77efd9e4..06b2e3a5c6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2143,6 +2143,7 @@ static inline bool cpu_vmx_maybe_enabled(CPUX86State *env)
 /* fpu_helper.c */
 void update_fp_status(CPUX86State *env);
 void update_mxcsr_status(CPUX86State *env);
+void update_mxcsr_from_sse_status(CPUX86State *env);
 
 static inline void cpu_set_mxcsr(CPUX86State *env, uint32_t mxcsr)
 {
diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index ec5b9db8b9..f5e6c4b88d 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -2539,6 +2539,7 @@ static void do_xsave_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 
 static void do_xsave_mxcsr(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 {
+    update_mxcsr_from_sse_status(env);
     cpu_stl_data_ra(env, ptr + XO(legacy.mxcsr), env->mxcsr, ra);
     cpu_stl_data_ra(env, ptr + XO(legacy.mxcsr_mask), 0x0000ffff, ra);
 }
@@ -2968,6 +2969,14 @@ void update_mxcsr_status(CPUX86State *env)
     }
     set_float_rounding_mode(rnd_type, &env->sse_status);
 
+    /* Set exception flags.  */
+    set_float_exception_flags((mxcsr & FPUS_IE ? float_flag_invalid : 0) |
+                              (mxcsr & FPUS_ZE ? float_flag_divbyzero : 0) |
+                              (mxcsr & FPUS_OE ? float_flag_overflow : 0) |
+                              (mxcsr & FPUS_UE ? float_flag_underflow : 0) |
+                              (mxcsr & FPUS_PE ? float_flag_inexact : 0),
+                              &env->sse_status);
+
     /* set denormals are zero */
     set_flush_inputs_to_zero((mxcsr & SSE_DAZ) ? 1 : 0, &env->sse_status);
 
@@ -2975,6 +2984,32 @@ void update_mxcsr_status(CPUX86State *env)
     set_flush_to_zero((mxcsr & SSE_FZ) ? 1 : 0, &env->sse_status);
 }
 
+void update_mxcsr_from_sse_status(CPUX86State *env)
+{
+    if (tcg_enabled()) {
+        uint8_t flags = get_float_exception_flags(&env->sse_status);
+        /*
+         * The MXCSR denormal flag has opposite semantics to
+         * float_flag_input_denormal (the softfloat code sets that flag
+         * only when flushing input denormals to zero, but SSE sets it
+         * only when not flushing them to zero), so is not converted
+         * here.
+         */
+        env->mxcsr |= ((flags & float_flag_invalid ? FPUS_IE : 0) |
+                       (flags & float_flag_divbyzero ? FPUS_ZE : 0) |
+                       (flags & float_flag_overflow ? FPUS_OE : 0) |
+                       (flags & float_flag_underflow ? FPUS_UE : 0) |
+                       (flags & float_flag_inexact ? FPUS_PE : 0) |
+                       (flags & float_flag_output_denormal ? FPUS_UE | FPUS_PE :
+                        0));
+    }
+}
+
+void helper_update_mxcsr(CPUX86State *env)
+{
+    update_mxcsr_from_sse_status(env);
+}
+
 void helper_ldmxcsr(CPUX86State *env, uint32_t val)
 {
     cpu_set_mxcsr(env, val);
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index b98a99500a..9ae43bda0f 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -184,6 +184,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
             return gdb_get_reg32(mem_buf, 0); /* fop */
 
         case IDX_MXCSR_REG:
+            update_mxcsr_from_sse_status(env);
             return gdb_get_reg32(mem_buf, env->mxcsr);
 
         case IDX_CTL_CR0_REG:
diff --git a/target/i386/helper.c b/target/i386/helper.c
index c3a6e4fabe..fa2a1dcdda 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -544,6 +544,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         for(i = 0; i < 8; i++) {
             fptag |= ((!env->fptags[i]) << i);
         }
+        update_mxcsr_from_sse_status(env);
         qemu_fprintf(f, "FCW=%04x FSW=%04x [ST=%d] FTW=%02x MXCSR=%08x\n",
                      env->fpuc,
                      (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11,
diff --git a/target/i386/helper.h b/target/i386/helper.h
index 8f9e1905c3..c2ae2f7e61 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -207,6 +207,7 @@ DEF_HELPER_FLAGS_2(pext, TCG_CALL_NO_RWG_SE, tl, tl, tl)
 /* MMX/SSE */
 
 DEF_HELPER_2(ldmxcsr, void, env, i32)
+DEF_HELPER_1(update_mxcsr, void, env)
 DEF_HELPER_1(enter_mmx, void, env)
 DEF_HELPER_1(emms, void, env)
 DEF_HELPER_3(movq, void, env, ptr, ptr)
diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 14f2b16abd..c7614f8b0b 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -843,6 +843,7 @@ int64_t helper_cvttsd2sq(CPUX86State *env, ZMMReg *s)
 
 void helper_rsqrtps(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 {
+    uint8_t old_flags = get_float_exception_flags(&env->sse_status);
     d->ZMM_S(0) = float32_div(float32_one,
                               float32_sqrt(s->ZMM_S(0), &env->sse_status),
                               &env->sse_status);
@@ -855,26 +856,33 @@ void helper_rsqrtps(CPUX86State *env, ZMMReg *d, ZMMReg *s)
     d->ZMM_S(3) = float32_div(float32_one,
                               float32_sqrt(s->ZMM_S(3), &env->sse_status),
                               &env->sse_status);
+    set_float_exception_flags(old_flags, &env->sse_status);
 }
 
 void helper_rsqrtss(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 {
+    uint8_t old_flags = get_float_exception_flags(&env->sse_status);
     d->ZMM_S(0) = float32_div(float32_one,
                               float32_sqrt(s->ZMM_S(0), &env->sse_status),
                               &env->sse_status);
+    set_float_exception_flags(old_flags, &env->sse_status);
 }
 
 void helper_rcpps(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 {
+    uint8_t old_flags = get_float_exception_flags(&env->sse_status);
     d->ZMM_S(0) = float32_div(float32_one, s->ZMM_S(0), &env->sse_status);
     d->ZMM_S(1) = float32_div(float32_one, s->ZMM_S(1), &env->sse_status);
     d->ZMM_S(2) = float32_div(float32_one, s->ZMM_S(2), &env->sse_status);
     d->ZMM_S(3) = float32_div(float32_one, s->ZMM_S(3), &env->sse_status);
+    set_float_exception_flags(old_flags, &env->sse_status);
 }
 
 void helper_rcpss(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 {
+    uint8_t old_flags = get_float_exception_flags(&env->sse_status);
     d->ZMM_S(0) = float32_div(float32_one, s->ZMM_S(0), &env->sse_status);
+    set_float_exception_flags(old_flags, &env->sse_status);
 }
 
 static inline uint64_t helper_extrq(uint64_t src, int shift, int len)
@@ -1764,6 +1772,7 @@ void glue(helper_phminposuw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 void glue(helper_roundps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                   uint32_t mode)
 {
+    uint8_t old_flags = get_float_exception_flags(&env->sse_status);
     signed char prev_rounding_mode;
 
     prev_rounding_mode = env->sse_status.float_rounding_mode;
@@ -1789,19 +1798,18 @@ void glue(helper_roundps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
     d->ZMM_S(2) = float32_round_to_int(s->ZMM_S(2), &env->sse_status);
     d->ZMM_S(3) = float32_round_to_int(s->ZMM_S(3), &env->sse_status);
 
-#if 0 /* TODO */
-    if (mode & (1 << 3)) {
+    if (mode & (1 << 3) && !(old_flags & float_flag_inexact)) {
         set_float_exception_flags(get_float_exception_flags(&env->sse_status) &
                                   ~float_flag_inexact,
                                   &env->sse_status);
     }
-#endif
     env->sse_status.float_rounding_mode = prev_rounding_mode;
 }
 
 void glue(helper_roundpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                   uint32_t mode)
 {
+    uint8_t old_flags = get_float_exception_flags(&env->sse_status);
     signed char prev_rounding_mode;
 
     prev_rounding_mode = env->sse_status.float_rounding_mode;
@@ -1825,19 +1833,18 @@ void glue(helper_roundpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
     d->ZMM_D(0) = float64_round_to_int(s->ZMM_D(0), &env->sse_status);
     d->ZMM_D(1) = float64_round_to_int(s->ZMM_D(1), &env->sse_status);
 
-#if 0 /* TODO */
-    if (mode & (1 << 3)) {
+    if (mode & (1 << 3) && !(old_flags & float_flag_inexact)) {
         set_float_exception_flags(get_float_exception_flags(&env->sse_status) &
                                   ~float_flag_inexact,
                                   &env->sse_status);
     }
-#endif
     env->sse_status.float_rounding_mode = prev_rounding_mode;
 }
 
 void glue(helper_roundss, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                   uint32_t mode)
 {
+    uint8_t old_flags = get_float_exception_flags(&env->sse_status);
     signed char prev_rounding_mode;
 
     prev_rounding_mode = env->sse_status.float_rounding_mode;
@@ -1860,19 +1867,18 @@ void glue(helper_roundss, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
 
     d->ZMM_S(0) = float32_round_to_int(s->ZMM_S(0), &env->sse_status);
 
-#if 0 /* TODO */
-    if (mode & (1 << 3)) {
+    if (mode & (1 << 3) && !(old_flags & float_flag_inexact)) {
         set_float_exception_flags(get_float_exception_flags(&env->sse_status) &
                                   ~float_flag_inexact,
                                   &env->sse_status);
     }
-#endif
     env->sse_status.float_rounding_mode = prev_rounding_mode;
 }
 
 void glue(helper_roundsd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                   uint32_t mode)
 {
+    uint8_t old_flags = get_float_exception_flags(&env->sse_status);
     signed char prev_rounding_mode;
 
     prev_rounding_mode = env->sse_status.float_rounding_mode;
@@ -1895,13 +1901,11 @@ void glue(helper_roundsd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
 
     d->ZMM_D(0) = float64_round_to_int(s->ZMM_D(0), &env->sse_status);
 
-#if 0 /* TODO */
-    if (mode & (1 << 3)) {
+    if (mode & (1 << 3) && !(old_flags & float_flag_inexact)) {
         set_float_exception_flags(get_float_exception_flags(&env->sse_status) &
                                   ~float_flag_inexact,
                                   &env->sse_status);
     }
-#endif
     env->sse_status.float_rounding_mode = prev_rounding_mode;
 }
 
diff --git a/target/i386/tcg-stub.c b/target/i386/tcg-stub.c
new file mode 100644
index 0000000000..b00e23d606
--- /dev/null
+++ b/target/i386/tcg-stub.c
@@ -0,0 +1,25 @@
+/*
+ *  x86 FPU, MMX/3DNow!/SSE/SSE2/SSE3/SSSE3/SSE4/PNI helpers
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+
+void update_mxcsr_from_sse_status(CPUX86State *env)
+{
+}
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 5e5dbb41b0..b3fea54411 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8157,6 +8157,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_exception(s, EXCP07_PREX, pc_start - s->cs_base);
                 break;
             }
+            gen_helper_update_mxcsr(cpu_env);
             gen_lea_modrm(env, s, modrm);
             tcg_gen_ld32u_tl(s->T0, cpu_env, offsetof(CPUX86State, mxcsr));
             gen_op_st_v(s, MO_32, s->T0, s->A0);
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 1a6463a7dc..a66232a67d 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -10,6 +10,10 @@ ALL_X86_TESTS=$(I386_SRCS:.c=)
 SKIP_I386_TESTS=test-i386-ssse3
 X86_64_TESTS:=$(filter test-i386-ssse3, $(ALL_X86_TESTS))
 
+test-i386-sse-exceptions: CFLAGS += -msse4.1 -mfpmath=sse
+run-test-i386-sse-exceptions: QEMU_OPTS += -cpu max
+run-plugin-test-i386-sse-exceptions-%: QEMU_OPTS += -cpu max
+
 test-i386-pcmpistri: CFLAGS += -msse4.2
 run-test-i386-pcmpistri: QEMU_OPTS += -cpu max
 run-plugin-test-i386-pcmpistri-%: QEMU_OPTS += -cpu max
diff --git a/tests/tcg/i386/test-i386-sse-exceptions.c b/tests/tcg/i386/test-i386-sse-exceptions.c
new file mode 100644
index 0000000000..a104f46c11
--- /dev/null
+++ b/tests/tcg/i386/test-i386-sse-exceptions.c
@@ -0,0 +1,813 @@
+/* Test SSE exceptions.  */
+
+#include <float.h>
+#include <stdint.h>
+#include <stdio.h>
+
+volatile float f_res;
+volatile double d_res;
+
+volatile float f_snan = __builtin_nansf("");
+volatile float f_half = 0.5f;
+volatile float f_third = 1.0f / 3.0f;
+volatile float f_nan = __builtin_nanl("");
+volatile float f_inf = __builtin_inff();
+volatile float f_ninf = -__builtin_inff();
+volatile float f_one = 1.0f;
+volatile float f_two = 2.0f;
+volatile float f_zero = 0.0f;
+volatile float f_nzero = -0.0f;
+volatile float f_min = FLT_MIN;
+volatile float f_true_min = 0x1p-149f;
+volatile float f_max = FLT_MAX;
+volatile float f_nmax = -FLT_MAX;
+
+volatile double d_snan = __builtin_nans("");
+volatile double d_half = 0.5;
+volatile double d_third = 1.0 / 3.0;
+volatile double d_nan = __builtin_nan("");
+volatile double d_inf = __builtin_inf();
+volatile double d_ninf = -__builtin_inf();
+volatile double d_one = 1.0;
+volatile double d_two = 2.0;
+volatile double d_zero = 0.0;
+volatile double d_nzero = -0.0;
+volatile double d_min = DBL_MIN;
+volatile double d_true_min = 0x1p-1074;
+volatile double d_max = DBL_MAX;
+volatile double d_nmax = -DBL_MAX;
+
+volatile int32_t i32_max = INT32_MAX;
+
+#define IE (1 << 0)
+#define ZE (1 << 2)
+#define OE (1 << 3)
+#define UE (1 << 4)
+#define PE (1 << 5)
+#define EXC (IE | ZE | OE | UE | PE)
+
+uint32_t mxcsr_default = 0x1f80;
+uint32_t mxcsr_ftz = 0x9f80;
+
+int main(void)
+{
+    uint32_t mxcsr;
+    int32_t i32_res;
+    int ret = 0;
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = f_snan;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: widen float snan\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = d_min;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (UE | PE)) {
+        printf("FAIL: narrow float underflow\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = d_max;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (OE | PE)) {
+        printf("FAIL: narrow float overflow\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = d_third;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != PE) {
+        printf("FAIL: narrow float inexact\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = d_snan;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: narrow float snan\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("roundss $4, %0, %0" : "=x" (f_res) : "0" (f_min));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != PE) {
+        printf("FAIL: roundss min\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("roundss $12, %0, %0" : "=x" (f_res) : "0" (f_min));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != 0) {
+        printf("FAIL: roundss no-inexact min\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("roundss $4, %0, %0" : "=x" (f_res) : "0" (f_snan));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: roundss snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("roundss $12, %0, %0" : "=x" (f_res) : "0" (f_snan));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: roundss no-inexact snan\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("roundsd $4, %0, %0" : "=x" (d_res) : "0" (d_min));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != PE) {
+        printf("FAIL: roundsd min\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("roundsd $12, %0, %0" : "=x" (d_res) : "0" (d_min));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != 0) {
+        printf("FAIL: roundsd no-inexact min\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("roundsd $4, %0, %0" : "=x" (d_res) : "0" (d_snan));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: roundsd snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("roundsd $12, %0, %0" : "=x" (d_res) : "0" (d_snan));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: roundsd no-inexact snan\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("comiss %1, %0" : : "x" (f_nan), "x" (f_zero));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: comiss nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("ucomiss %1, %0" : : "x" (f_nan), "x" (f_zero));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != 0) {
+        printf("FAIL: ucomiss nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("ucomiss %1, %0" : : "x" (f_snan), "x" (f_zero));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: ucomiss snan\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("comisd %1, %0" : : "x" (d_nan), "x" (d_zero));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: comisd nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("ucomisd %1, %0" : : "x" (d_nan), "x" (d_zero));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != 0) {
+        printf("FAIL: ucomisd nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("ucomisd %1, %0" : : "x" (d_snan), "x" (d_zero));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: ucomisd snan\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_max + f_max;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (OE | PE)) {
+        printf("FAIL: float add overflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_max + f_min;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != PE) {
+        printf("FAIL: float add inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_inf + f_ninf;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: float add inf -inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_snan + f_third;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: float add snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_ftz));
+    f_res = f_true_min + f_true_min;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (UE | PE)) {
+        printf("FAIL: float add FTZ underflow\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_max + d_max;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (OE | PE)) {
+        printf("FAIL: double add overflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_max + d_min;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != PE) {
+        printf("FAIL: double add inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_inf + d_ninf;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: double add inf -inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_snan + d_third;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: double add snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_ftz));
+    d_res = d_true_min + d_true_min;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (UE | PE)) {
+        printf("FAIL: double add FTZ underflow\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_max - f_nmax;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (OE | PE)) {
+        printf("FAIL: float sub overflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_max - f_min;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != PE) {
+        printf("FAIL: float sub inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_inf - f_inf;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: float sub inf inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_snan - f_third;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: float sub snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_ftz));
+    f_res = f_min - f_true_min;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (UE | PE)) {
+        printf("FAIL: float sub FTZ underflow\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_max - d_nmax;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (OE | PE)) {
+        printf("FAIL: double sub overflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_max - d_min;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != PE) {
+        printf("FAIL: double sub inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_inf - d_inf;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: double sub inf inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_snan - d_third;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: double sub snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_ftz));
+    d_res = d_min - d_true_min;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (UE | PE)) {
+        printf("FAIL: double sub FTZ underflow\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_max * f_max;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (OE | PE)) {
+        printf("FAIL: float mul overflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_third * f_third;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != PE) {
+        printf("FAIL: float mul inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_min * f_min;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (UE | PE)) {
+        printf("FAIL: float mul underflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_inf * f_zero;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: float mul inf 0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_snan * f_third;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: float mul snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_ftz));
+    f_res = f_min * f_half;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (UE | PE)) {
+        printf("FAIL: float mul FTZ underflow\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_max * d_max;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (OE | PE)) {
+        printf("FAIL: double mul overflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_third * d_third;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != PE) {
+        printf("FAIL: double mul inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_min * d_min;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (UE | PE)) {
+        printf("FAIL: double mul underflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_inf * d_zero;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: double mul inf 0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_snan * d_third;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: double mul snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_ftz));
+    d_res = d_min * d_half;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (UE | PE)) {
+        printf("FAIL: double mul FTZ underflow\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_max / f_min;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (OE | PE)) {
+        printf("FAIL: float div overflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_one / f_third;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != PE) {
+        printf("FAIL: float div inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_min / f_max;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (UE | PE)) {
+        printf("FAIL: float div underflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_one / f_zero;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != ZE) {
+        printf("FAIL: float div 1 0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_inf / f_zero;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != 0) {
+        printf("FAIL: float div inf 0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_nan / f_zero;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != 0) {
+        printf("FAIL: float div nan 0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_zero / f_zero;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: float div 0 0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_inf / f_inf;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: float div inf inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    f_res = f_snan / f_third;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: float div snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_ftz));
+    f_res = f_min / f_two;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (UE | PE)) {
+        printf("FAIL: float div FTZ underflow\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_max / d_min;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (OE | PE)) {
+        printf("FAIL: double div overflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_one / d_third;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != PE) {
+        printf("FAIL: double div inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_min / d_max;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (UE | PE)) {
+        printf("FAIL: double div underflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_one / d_zero;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != ZE) {
+        printf("FAIL: double div 1 0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_inf / d_zero;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != 0) {
+        printf("FAIL: double div inf 0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_nan / d_zero;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != 0) {
+        printf("FAIL: double div nan 0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_zero / d_zero;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: double div 0 0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_inf / d_inf;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: double div inf inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    d_res = d_snan / d_third;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: double div snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_ftz));
+    d_res = d_min / d_two;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != (UE | PE)) {
+        printf("FAIL: double div FTZ underflow\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("sqrtss %0, %0" : "=x" (f_res) : "0" (f_max));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != PE) {
+        printf("FAIL: sqrtss inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("sqrtss %0, %0" : "=x" (f_res) : "0" (f_nmax));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: sqrtss -max\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("sqrtss %0, %0" : "=x" (f_res) : "0" (f_ninf));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: sqrtss -inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("sqrtss %0, %0" : "=x" (f_res) : "0" (f_snan));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: sqrtss snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("sqrtss %0, %0" : "=x" (f_res) : "0" (f_nzero));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != 0) {
+        printf("FAIL: sqrtss -0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("sqrtss %0, %0" : "=x" (f_res) :
+                      "0" (-__builtin_nanf("")));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != 0) {
+        printf("FAIL: sqrtss -nan\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("sqrtsd %0, %0" : "=x" (d_res) : "0" (d_max));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != PE) {
+        printf("FAIL: sqrtsd inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("sqrtsd %0, %0" : "=x" (d_res) : "0" (d_nmax));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: sqrtsd -max\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("sqrtsd %0, %0" : "=x" (d_res) : "0" (d_ninf));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: sqrtsd -inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("sqrtsd %0, %0" : "=x" (d_res) : "0" (d_snan));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: sqrtsd snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("sqrtsd %0, %0" : "=x" (d_res) : "0" (d_nzero));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != 0) {
+        printf("FAIL: sqrtsd -0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("sqrtsd %0, %0" : "=x" (d_res) :
+                      "0" (-__builtin_nan("")));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != 0) {
+        printf("FAIL: sqrtsd -nan\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("maxss %1, %0" : : "x" (f_nan), "x" (f_zero));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: maxss nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("minss %1, %0" : : "x" (f_nan), "x" (f_zero));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: minss nan\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("maxsd %1, %0" : : "x" (d_nan), "x" (d_zero));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: maxsd nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("minsd %1, %0" : : "x" (d_nan), "x" (d_zero));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: minsd nan\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("cvtsi2ss %1, %0" : "=x" (f_res) : "m" (i32_max));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != PE) {
+        printf("FAIL: cvtsi2ss inexact\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("cvtsi2sd %1, %0" : "=x" (d_res) : "m" (i32_max));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != 0) {
+        printf("FAIL: cvtsi2sd exact\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("cvtss2si %1, %0" : "=r" (i32_res) : "x" (1.5f));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != PE) {
+        printf("FAIL: cvtss2si inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("cvtss2si %1, %0" : "=r" (i32_res) : "x" (0x1p31f));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: cvtss2si 0x1p31\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("cvtss2si %1, %0" : "=r" (i32_res) : "x" (f_inf));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: cvtss2si inf\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("cvtsd2si %1, %0" : "=r" (i32_res) : "x" (1.5));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != PE) {
+        printf("FAIL: cvtsd2si inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("cvtsd2si %1, %0" : "=r" (i32_res) : "x" (0x1p31));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: cvtsd2si 0x1p31\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("cvtsd2si %1, %0" : "=r" (i32_res) : "x" (d_inf));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: cvtsd2si inf\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("cvttss2si %1, %0" : "=r" (i32_res) : "x" (1.5f));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != PE) {
+        printf("FAIL: cvttss2si inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("cvttss2si %1, %0" : "=r" (i32_res) : "x" (0x1p31f));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: cvttss2si 0x1p31\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("cvttss2si %1, %0" : "=r" (i32_res) : "x" (f_inf));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: cvttss2si inf\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("cvttsd2si %1, %0" : "=r" (i32_res) : "x" (1.5));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != PE) {
+        printf("FAIL: cvttsd2si inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("cvttsd2si %1, %0" : "=r" (i32_res) : "x" (0x1p31));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: cvttsd2si 0x1p31\n");
+        ret = 1;
+    }
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("cvttsd2si %1, %0" : "=r" (i32_res) : "x" (d_inf));
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != IE) {
+        printf("FAIL: cvttsd2si inf\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("rcpss %0, %0" : "=x" (f_res) : "0" (f_snan));
+    f_res += f_one;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != 0) {
+        printf("FAIL: rcpss snan\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("ldmxcsr %0" : : "m" (mxcsr_default));
+    __asm__ volatile ("rsqrtss %0, %0" : "=x" (f_res) : "0" (f_snan));
+    f_res += f_one;
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr));
+    if ((mxcsr & EXC) != 0) {
+        printf("FAIL: rsqrtss snan\n");
+        ret = 1;
+    }
+
+    return ret;
+}
-- 
2.26.2



