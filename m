Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF96C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B35420720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cc6y1+lO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B35420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTsY-0007ym-HU
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAK-0001k4-Gx
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58966
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAI-0001PD-GL
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+uHjjnAp5c/+6ufY1U7RXcDnUhIgzyjschgUlhs8fQ=;
 b=Cc6y1+lO1ijn3qI1zkwIp5N2v+XVv/vUpI8C3GjlPfc8C6u8aOu4NcsFNMJVShRXe9FCZD
 +wK4BInnTxlkDdHlF//wQWjVl/ivb8HNfDBhCmQeDuSqZRayoM+EqnWI2C5+XEEIC6fYDq
 UFEb4kNDz1B/KrNbwDf3ikS1q4xjvY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-Us5AppWfPEOowKH2jjDaVg-1; Thu, 11 Jun 2020 15:47:03 -0400
X-MC-Unique: Us5AppWfPEOowKH2jjDaVg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD93584638F;
 Thu, 11 Jun 2020 19:47:02 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6056A10013D0;
 Thu, 11 Jun 2020 19:47:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 095/115] i386: hvf: Drop regs in HVFX86EmulatorState
Date: Thu, 11 Jun 2020 15:44:29 -0400
Message-Id: <20200611194449.31468-96-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:52:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Bolshakov <r.bolshakov@yadro.com>

HVFX86EmulatorState carries it's own copy of x86 registers. It can be
dropped in favor of regs in generic CPUX86State.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200528193758.51454-11-r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86.h     | 13 +++++++------
 target/i386/hvf/x86_emu.c | 18 +++++++++---------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index f0d03faff9..6048b5cc74 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -235,13 +235,14 @@ typedef struct lazy_flags {
 
 /* Definition of hvf_x86_state is here */
 struct HVFX86EmulatorState {
-    struct x86_register regs[16];
     struct lazy_flags   lflags;
     uint8_t mmio_buf[4096];
 };
 
 /* useful register access  macros */
-#define RRX(cpu, reg) (cpu->hvf_emul->regs[reg].rrx)
+#define x86_reg(cpu, reg) ((x86_register *) &cpu->regs[reg])
+
+#define RRX(cpu, reg)   (x86_reg(cpu, reg)->rrx)
 #define RAX(cpu)        RRX(cpu, R_EAX)
 #define RCX(cpu)        RRX(cpu, R_ECX)
 #define RDX(cpu)        RRX(cpu, R_EDX)
@@ -259,7 +260,7 @@ struct HVFX86EmulatorState {
 #define R14(cpu)        RRX(cpu, R_R14)
 #define R15(cpu)        RRX(cpu, R_R15)
 
-#define ERX(cpu, reg)   (cpu->hvf_emul->regs[reg].erx)
+#define ERX(cpu, reg)   (x86_reg(cpu, reg)->erx)
 #define EAX(cpu)        ERX(cpu, R_EAX)
 #define ECX(cpu)        ERX(cpu, R_ECX)
 #define EDX(cpu)        ERX(cpu, R_EDX)
@@ -269,7 +270,7 @@ struct HVFX86EmulatorState {
 #define ESI(cpu)        ERX(cpu, R_ESI)
 #define EDI(cpu)        ERX(cpu, R_EDI)
 
-#define RX(cpu, reg)   (cpu->hvf_emul->regs[reg].rx)
+#define RX(cpu, reg)   (x86_reg(cpu, reg)->rx)
 #define AX(cpu)        RX(cpu, R_EAX)
 #define CX(cpu)        RX(cpu, R_ECX)
 #define DX(cpu)        RX(cpu, R_EDX)
@@ -279,13 +280,13 @@ struct HVFX86EmulatorState {
 #define SI(cpu)        RX(cpu, R_ESI)
 #define DI(cpu)        RX(cpu, R_EDI)
 
-#define RL(cpu, reg)   (cpu->hvf_emul->regs[reg].lx)
+#define RL(cpu, reg)   (x86_reg(cpu, reg)->lx)
 #define AL(cpu)        RL(cpu, R_EAX)
 #define CL(cpu)        RL(cpu, R_ECX)
 #define DL(cpu)        RL(cpu, R_EDX)
 #define BL(cpu)        RL(cpu, R_EBX)
 
-#define RH(cpu, reg)   (cpu->hvf_emul->regs[reg].hx)
+#define RH(cpu, reg)   (x86_reg(cpu, reg)->hx)
 #define AH(cpu)        RH(cpu, R_EAX)
 #define CH(cpu)        RH(cpu, R_ECX)
 #define DH(cpu)        RH(cpu, R_EDX)
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 04fac64e72..1ad2c30e16 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -95,13 +95,13 @@ target_ulong read_reg(CPUX86State *env, int reg, int size)
 {
     switch (size) {
     case 1:
-        return env->hvf_emul->regs[reg].lx;
+        return x86_reg(env, reg)->lx;
     case 2:
-        return env->hvf_emul->regs[reg].rx;
+        return x86_reg(env, reg)->rx;
     case 4:
-        return env->hvf_emul->regs[reg].erx;
+        return x86_reg(env, reg)->erx;
     case 8:
-        return env->hvf_emul->regs[reg].rrx;
+        return x86_reg(env, reg)->rrx;
     default:
         abort();
     }
@@ -112,16 +112,16 @@ void write_reg(CPUX86State *env, int reg, target_ulong val, int size)
 {
     switch (size) {
     case 1:
-        env->hvf_emul->regs[reg].lx = val;
+        x86_reg(env, reg)->lx = val;
         break;
     case 2:
-        env->hvf_emul->regs[reg].rx = val;
+        x86_reg(env, reg)->rx = val;
         break;
     case 4:
-        env->hvf_emul->regs[reg].rrx = (uint32_t)val;
+        x86_reg(env, reg)->rrx = (uint32_t)val;
         break;
     case 8:
-        env->hvf_emul->regs[reg].rrx = val;
+        x86_reg(env, reg)->rrx = val;
         break;
     default:
         abort();
@@ -173,7 +173,7 @@ void write_val_to_reg(target_ulong reg_ptr, target_ulong val, int size)
 
 static bool is_host_reg(struct CPUX86State *env, target_ulong ptr)
 {
-    return (ptr - (target_ulong)&env->hvf_emul->regs[0]) < sizeof(env->hvf_emul->regs);
+    return (ptr - (target_ulong)&env->regs[0]) < sizeof(env->regs);
 }
 
 void write_val_ext(struct CPUX86State *env, target_ulong ptr, target_ulong val, int size)
-- 
2.26.2



