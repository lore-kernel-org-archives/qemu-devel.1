Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2FAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFAFB2078C
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Owx5hPsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAFB2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeOQX-0007yp-3m
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 15:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOLz-0000EU-SL
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:11 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:35550 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOLy-00075b-Ok
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:11 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 77C774C869;
 Thu, 28 May 2020 19:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1590694686; x=1592509087; bh=MDOpHat93jWYyvJkzwlZq9JxpeU/Q4XrPyV
 em3gyozQ=; b=Owx5hPsM+q8UJEwIDVmOjHs0CL7XIOHwQbNLXqQ03pbC/fNWB8W
 o+2irlHm6qcDVcxSQ/yWvlj3a3cDZJJ3GEcqUeI+vlL4mmDaIibsd5CSzpFrvakU
 vy2v1kWNX/lSdek9Jtst1nZA8VkEP2TbdoWVQJuwE4vYUB3L0cIkU60s=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qbhOnV_96yFf; Thu, 28 May 2020 22:38:06 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id C90B44C86D;
 Thu, 28 May 2020 22:38:04 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 28
 May 2020 22:38:06 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 10/13] i386: hvf: Drop regs in HVFX86EmulatorState
Date: Thu, 28 May 2020 22:37:55 +0300
Message-ID: <20200528193758.51454-11-r.bolshakov@yadro.com>
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

HVFX86EmulatorState carries it's own copy of x86 registers. It can be
dropped in favor of regs in generic CPUX86State.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
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
2.26.1


