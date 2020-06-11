Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551F6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212C52073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbJrt20b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212C52073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjU3a-0002Rn-CZ
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAJ-0001gm-4J
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37596
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAH-0001Om-3M
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7QLfxjfd2csDrjuBSLw6r1kZqpug+IOoFmV+B6qm9Q=;
 b=QbJrt20b5pWI7G+DRGxCGAtFlbNXYy+y0dRl8Tc4pIh+gNLXKJN+lF8UzgdadmAjTHEDoM
 G7Ptb/7cXwWSGpsm+I+HVYPss9Jmcb2sUsIjDr8Cz34dq6AqdwXjiKI+kRC0W6tcfsNiD/
 RL6i/cV4OkMWkBJOJbZbuWlHDTP1DCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-3f8f4-FTP92DUJ1cR5bdqg-1; Thu, 11 Jun 2020 15:47:01 -0400
X-MC-Unique: 3f8f4-FTP92DUJ1cR5bdqg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB23C91164;
 Thu, 11 Jun 2020 19:47:00 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E6D710013D7;
 Thu, 11 Jun 2020 19:47:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 092/115] i386: hvf: Drop fetch_rip from HVFX86EmulatorState
Date: Thu, 11 Jun 2020 15:44:26 -0400
Message-Id: <20200611194449.31468-93-pbonzini@redhat.com>
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

The field is used to print address of instructions that have no parser
in decode_invalid(). RIP from VMCS is saved into fetch_rip before
decoding starts but it's also saved into env->eip in load_regs().
Therefore env->eip can be used instead of fetch_rip.

While at it, correct address printed in decode_invalid(). It prints an
address before the unknown instruction.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200528193758.51454-8-r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.26.2



