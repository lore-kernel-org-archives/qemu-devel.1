Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3239C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12C1207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="WCYXZ5Ny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12C1207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeOSw-0003HH-QK
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 15:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOMC-0000lS-CW
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:24 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:35572 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOMB-00076T-6H
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:24 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id ED9E74C864;
 Thu, 28 May 2020 19:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1590694688; x=1592509089; bh=HgjR93uelGBoFdHjqGPepD4JvDATupwEFyC
 LV/jL4pY=; b=WCYXZ5NydBa7e1t+dr4cFSBDazWVWr96zU5YDyk+Hy4sx5Fj9Rn
 4ckP5MFxkmNxUUCKv1vqt5rNlk5DLNPhWttHJ9kdMxtqXWDPFJSzBSBwRij2HSAv
 xTR30StgTk2KFxlI6CoweBhSjntJk1SgCXKpD0SWpWCYn3xhb8Ud5EG0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PXKA1WLIC0Ab; Thu, 28 May 2020 22:38:08 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id E94B14C861;
 Thu, 28 May 2020 22:38:05 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 28
 May 2020 22:38:07 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 12/13] i386: hvf: Move mmio_buf into CPUX86State
Date: Thu, 28 May 2020 22:37:57 +0300
Message-ID: <20200528193758.51454-13-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200528193758.51454-1-r.bolshakov@yadro.com>
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 15:38:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There's no similar field in CPUX86State, but it's needed for MMIO traps.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 target/i386/cpu.h         |  1 +
 target/i386/hvf/hvf.c     |  5 +++++
 target/i386/hvf/x86.h     |  1 -
 target/i386/hvf/x86_emu.c | 12 ++++++------
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7e6566565a..be44e19154 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1593,6 +1593,7 @@ typedef struct CPUX86State {
 #endif
 #if defined(CONFIG_HVF)
     hvf_lazy_flags hvf_lflags;
+    void *hvf_mmio_buf;
     HVFX86EmulatorState *hvf_emul;
 #endif
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 4cee496d71..57696c46c7 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -533,7 +533,11 @@ void hvf_reset_vcpu(CPUState *cpu) {
 
 void hvf_vcpu_destroy(CPUState *cpu)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
     hv_return_t ret = hv_vcpu_destroy((hv_vcpuid_t)cpu->hvf_fd);
+    g_free(env->hvf_mmio_buf);
     assert_hvf_ok(ret);
 }
 
@@ -563,6 +567,7 @@ int hvf_init_vcpu(CPUState *cpu)
     init_decoder();
 
     hvf_state->hvf_caps = g_new0(struct hvf_vcpu_caps, 1);
+    env->hvf_mmio_buf = g_new(char, 4096);
     env->hvf_emul = g_new0(HVFX86EmulatorState, 1);
 
     r = hv_vcpu_create((hv_vcpuid_t *)&cpu->hvf_fd, HV_VCPU_DEFAULT);
diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index 2363616c07..483fcea762 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -230,7 +230,6 @@ typedef struct x68_segment_selector {
 
 /* Definition of hvf_x86_state is here */
 struct HVFX86EmulatorState {
-    uint8_t mmio_buf[4096];
 };
 
 /* useful register access  macros */
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 1ad2c30e16..d3e289ed87 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -187,8 +187,8 @@ void write_val_ext(struct CPUX86State *env, target_ulong ptr, target_ulong val,
 
 uint8_t *read_mmio(struct CPUX86State *env, target_ulong ptr, int bytes)
 {
-    vmx_read_mem(env_cpu(env), env->hvf_emul->mmio_buf, ptr, bytes);
-    return env->hvf_emul->mmio_buf;
+    vmx_read_mem(env_cpu(env), env->hvf_mmio_buf, ptr, bytes);
+    return env->hvf_mmio_buf;
 }
 
 
@@ -489,9 +489,9 @@ static void exec_ins_single(struct CPUX86State *env, struct x86_decode *decode)
     target_ulong addr = linear_addr_size(env_cpu(env), RDI(env),
                                          decode->addressing_size, R_ES);
 
-    hvf_handle_io(env_cpu(env), DX(env), env->hvf_emul->mmio_buf, 0,
+    hvf_handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 0,
                   decode->operand_size, 1);
-    vmx_write_mem(env_cpu(env), addr, env->hvf_emul->mmio_buf,
+    vmx_write_mem(env_cpu(env), addr, env->hvf_mmio_buf,
                   decode->operand_size);
 
     string_increment_reg(env, R_EDI, decode);
@@ -512,9 +512,9 @@ static void exec_outs_single(struct CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr = decode_linear_addr(env, decode, RSI(env), R_DS);
 
-    vmx_read_mem(env_cpu(env), env->hvf_emul->mmio_buf, addr,
+    vmx_read_mem(env_cpu(env), env->hvf_mmio_buf, addr,
                  decode->operand_size);
-    hvf_handle_io(env_cpu(env), DX(env), env->hvf_emul->mmio_buf, 1,
+    hvf_handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 1,
                   decode->operand_size, 1);
 
     string_increment_reg(env, R_ESI, decode);
-- 
2.26.1


