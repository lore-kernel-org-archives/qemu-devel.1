Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42466C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152FC207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="UFPQSevX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152FC207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeOOL-000538-8p
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 15:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOLx-00007h-7e
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:09 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:35528 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOLw-00074Y-2z
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:08 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id C61EF4C86C;
 Thu, 28 May 2020 19:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1590694683; x=1592509084; bh=HVRzyDynPbZtCFOM0hgLRkscuGEiqCkA6G3
 QSR37gYE=; b=UFPQSevXGV85jaio4QQ1+pMkgI1JQRN4XV0gJNti7Za8FlmJVPw
 1804bG4Xl1ZKBILds5C2q76XP9hLAtXd2AS40LT1y/ea9oeIP+bIVilS3H69mV9C
 sN1WzHRDxfsqnXnQlPSNzROxXFmMvyCekRo0vip+t58uKk1L1ADBlCOg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oZEwOPLAEQQm; Thu, 28 May 2020 22:38:03 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 04C454C862;
 Thu, 28 May 2020 22:38:03 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 28
 May 2020 22:38:04 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 07/13] i386: hvf: Drop fetch_rip from HVFX86EmulatorState
Date: Thu, 28 May 2020 22:37:52 +0300
Message-ID: <20200528193758.51454-8-r.bolshakov@yadro.com>
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

The field is used to print address of instructions that have no parser
in decode_invalid(). RIP from VMCS is saved into fetch_rip before
decoding starts but it's also saved into env->eip in load_regs().
Therefore env->eip can be used instead of fetch_rip.

While at it, correct address printed in decode_invalid(). It prints an
address before the unknown instruction.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 target/i386/hvf/hvf.c        | 6 ------
 target/i386/hvf/x86.h        | 1 -
 target/i386/hvf/x86_decode.c | 3 +--
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 45ae55dd27..416a6fae7c 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -767,8 +767,6 @@ int hvf_vcpu_exec(CPUState *cpu)
                 struct x86_decode decode;
 
                 load_regs(cpu);
-                env->hvf_emul->fetch_rip = rip;
-
                 decode_instruction(env, &decode);
                 exec_instruction(env, &decode);
                 store_regs(cpu);
@@ -809,8 +807,6 @@ int hvf_vcpu_exec(CPUState *cpu)
             struct x86_decode decode;
 
             load_regs(cpu);
-            env->hvf_emul->fetch_rip = rip;
-
             decode_instruction(env, &decode);
             assert(ins_len == decode.len);
             exec_instruction(env, &decode);
@@ -915,8 +911,6 @@ int hvf_vcpu_exec(CPUState *cpu)
             struct x86_decode decode;
 
             load_regs(cpu);
-            env->hvf_emul->fetch_rip = rip;
-
             decode_instruction(env, &decode);
             exec_instruction(env, &decode);
             store_regs(cpu);
diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index e3ab7c5137..411e4b6599 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -293,7 +293,6 @@ typedef struct lazy_flags {
 
 /* Definition of hvf_x86_state is here */
 struct HVFX86EmulatorState {
-    uint64_t fetch_rip;
     struct x86_register regs[16];
     struct x86_reg_flags   rflags;
     struct lazy_flags   lflags;
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index a590088f54..d881542181 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -29,8 +29,7 @@
 
 static void decode_invalid(CPUX86State *env, struct x86_decode *decode)
 {
-    printf("%llx: failed to decode instruction ", env->hvf_emul->fetch_rip -
-           decode->len);
+    printf("%llx: failed to decode instruction ", env->eip);
     for (int i = 0; i < decode->opcode_len; i++) {
         printf("%x ", decode->opcode[i]);
     }
-- 
2.26.1


