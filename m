Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B89C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:59:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA132073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJMwrMDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA132073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjUI8-0003bp-3i
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAJ-0001hx-Hd
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49803
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAG-0001Oe-AI
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=akk/FE9CRg5BGr6grrg/fhbWnvUGM+OXlldTVi8enSA=;
 b=iJMwrMDz6XnivhM/BPj6oY4pn6XLPN+wwZiZtD5FKLpRnAorcHl/E0qdxUozLAx3quY4KP
 yJmgXL25hRIglfGsGBiUeD6RugpemmlJgJuc5Kt25WQX3GYQkBM1sVxhxK8ErBNTDnQhGW
 yEkdtwraC+XmUNlXyh5ofTGdLWu1p80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-DKbvb5ZuNyG8Yu2-wC1NuQ-1; Thu, 11 Jun 2020 15:47:01 -0400
X-MC-Unique: DKbvb5ZuNyG8Yu2-wC1NuQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D86A1940921;
 Thu, 11 Jun 2020 19:47:00 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90D4410013D7;
 Thu, 11 Jun 2020 19:46:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 091/115] i386: hvf: Use IP from CPUX86State
Date: Thu, 11 Jun 2020 15:44:25 -0400
Message-Id: <20200611194449.31468-92-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:57:53
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Bolshakov <r.bolshakov@yadro.com>

Drop and replace rip field from HVFX86EmulatorState in favor of eip from
common CPUX86State.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200528193758.51454-7-r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/i386/hvf/hvf.c        |  6 +--
 target/i386/hvf/x86.h        |  3 --
 target/i386/hvf/x86_decode.c |  6 +--
 target/i386/hvf/x86_emu.c    | 86 ++++++++++++++++++------------------
 target/i386/hvf/x86_task.c   |  4 +-
 5 files changed, 51 insertions(+), 54 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 8ff1d25521..45ae55dd27 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -797,7 +797,7 @@ int hvf_vcpu_exec(CPUState *cpu)
                 } else {
                     RAX(env) = (uint64_t)val;
                 }
-                RIP(env) += ins_len;
+                env->eip += ins_len;
                 store_regs(cpu);
                 break;
             } else if (!string && !in) {
@@ -871,7 +871,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             } else {
                 simulate_wrmsr(cpu);
             }
-            RIP(env) += ins_len;
+            env->eip += ins_len;
             store_regs(cpu);
             break;
         }
@@ -907,7 +907,7 @@ int hvf_vcpu_exec(CPUState *cpu)
                 error_report("Unrecognized CR %d", cr);
                 abort();
             }
-            RIP(env) += ins_len;
+            env->eip += ins_len;
             store_regs(cpu);
             break;
         }
diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index 56fcde13c6..e3ab7c5137 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -294,7 +294,6 @@ typedef struct lazy_flags {
 /* Definition of hvf_x86_state is here */
 struct HVFX86EmulatorState {
     uint64_t fetch_rip;
-    uint64_t rip;
     struct x86_register regs[16];
     struct x86_reg_flags   rflags;
     struct lazy_flags   lflags;
@@ -302,8 +301,6 @@ struct HVFX86EmulatorState {
 };
 
 /* useful register access  macros */
-#define RIP(cpu)    (cpu->hvf_emul->rip)
-#define EIP(cpu)    ((uint32_t)cpu->hvf_emul->rip)
 #define RFLAGS(cpu) (cpu->hvf_emul->rflags.rflags)
 #define EFLAGS(cpu) (cpu->hvf_emul->rflags.eflags)
 
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 77c346605f..a590088f54 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -75,7 +75,7 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
         VM_PANIC_EX("%s invalid size %d\n", __func__, size);
         break;
     }
-    target_ulong va  = linear_rip(env_cpu(env), RIP(env)) + decode->len;
+    target_ulong va  = linear_rip(env_cpu(env), env->eip) + decode->len;
     vmx_read_mem(env_cpu(env), &val, va, size);
     decode->len += size;
     
@@ -1771,7 +1771,7 @@ void calc_modrm_operand32(CPUX86State *env, struct x86_decode *decode,
         ptr += get_sib_val(env, decode, &seg);
     } else if (!decode->modrm.mod && 5 == decode->modrm.rm) {
         if (x86_is_long_mode(env_cpu(env))) {
-            ptr += RIP(env) + decode->len;
+            ptr += env->eip + decode->len;
         } else {
             ptr = decode->displacement;
         }
@@ -1807,7 +1807,7 @@ void calc_modrm_operand64(CPUX86State *env, struct x86_decode *decode,
     if (4 == rm) {
         ptr = get_sib_val(env, decode, &seg) + offset;
     } else if (0 == mod && 5 == rm) {
-        ptr = RIP(env) + decode->len + (int32_t) offset;
+        ptr = env->eip + decode->len + (int32_t) offset;
     } else {
         ptr = get_reg_val(env, src, decode->rex.rex, decode->rex.b, 8) +
               (int64_t) offset;
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 92ab815f5d..0efd9f9928 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -267,49 +267,49 @@ static void exec_mov(struct CPUX86State *env, struct x86_decode *decode)
     write_val_ext(env, decode->op[0].ptr, decode->op[1].val,
                   decode->operand_size);
 
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_add(struct CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, +, SET_FLAGS_OSZAPC_ADD, true);
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_or(struct CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, |, SET_FLAGS_OSZAPC_LOGIC, true);
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_adc(struct CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, +get_CF(env)+, SET_FLAGS_OSZAPC_ADD, true);
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_sbb(struct CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, -get_CF(env)-, SET_FLAGS_OSZAPC_SUB, true);
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_and(struct CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, &, SET_FLAGS_OSZAPC_LOGIC, true);
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_sub(struct CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, true);
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_xor(struct CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, ^, SET_FLAGS_OSZAPC_LOGIC, true);
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_neg(struct CPUX86State *env, struct x86_decode *decode)
@@ -332,13 +332,13 @@ static void exec_neg(struct CPUX86State *env, struct x86_decode *decode)
     }
 
     /*lflags_to_rflags(env);*/
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_cmp(struct CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_inc(struct CPUX86State *env, struct x86_decode *decode)
@@ -348,7 +348,7 @@ static void exec_inc(struct CPUX86State *env, struct x86_decode *decode)
 
     EXEC_2OP_FLAGS_CMD(env, decode, +1+, SET_FLAGS_OSZAP_ADD, true);
 
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_dec(struct CPUX86State *env, struct x86_decode *decode)
@@ -357,13 +357,13 @@ static void exec_dec(struct CPUX86State *env, struct x86_decode *decode)
     decode->op[1].val = 0;
 
     EXEC_2OP_FLAGS_CMD(env, decode, -1-, SET_FLAGS_OSZAP_SUB, true);
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_tst(struct CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, &, SET_FLAGS_OSZAPC_LOGIC, false);
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_not(struct CPUX86State *env, struct x86_decode *decode)
@@ -372,7 +372,7 @@ static void exec_not(struct CPUX86State *env, struct x86_decode *decode)
 
     write_val_ext(env, decode->op[0].ptr, ~decode->op[0].val,
                   decode->operand_size);
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 void exec_movzx(struct CPUX86State *env, struct x86_decode *decode)
@@ -392,7 +392,7 @@ void exec_movzx(struct CPUX86State *env, struct x86_decode *decode)
     decode->op[1].val = read_val_ext(env, decode->op[1].ptr, src_op_size);
     write_val_ext(env, decode->op[0].ptr, decode->op[1].val, op_size);
 
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_out(struct CPUX86State *env, struct x86_decode *decode)
@@ -416,7 +416,7 @@ static void exec_out(struct CPUX86State *env, struct x86_decode *decode)
         VM_PANIC("Bad out opcode\n");
         break;
     }
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_in(struct CPUX86State *env, struct x86_decode *decode)
@@ -452,7 +452,7 @@ static void exec_in(struct CPUX86State *env, struct x86_decode *decode)
         break;
     }
 
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static inline void string_increment_reg(struct CPUX86State *env, int reg,
@@ -505,7 +505,7 @@ static void exec_ins(struct CPUX86State *env, struct x86_decode *decode)
         exec_ins_single(env, decode);
     }
 
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_outs_single(struct CPUX86State *env, struct x86_decode *decode)
@@ -528,7 +528,7 @@ static void exec_outs(struct CPUX86State *env, struct x86_decode *decode)
         exec_outs_single(env, decode);
     }
 
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_movs_single(struct CPUX86State *env, struct x86_decode *decode)
@@ -556,7 +556,7 @@ static void exec_movs(struct CPUX86State *env, struct x86_decode *decode)
         exec_movs_single(env, decode);
     }
 
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_cmps_single(struct CPUX86State *env, struct x86_decode *decode)
@@ -586,7 +586,7 @@ static void exec_cmps(struct CPUX86State *env, struct x86_decode *decode)
     } else {
         exec_cmps_single(env, decode);
     }
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 
@@ -612,7 +612,7 @@ static void exec_stos(struct CPUX86State *env, struct x86_decode *decode)
         exec_stos_single(env, decode);
     }
 
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_scas_single(struct CPUX86State *env, struct x86_decode *decode)
@@ -638,7 +638,7 @@ static void exec_scas(struct CPUX86State *env, struct x86_decode *decode)
         exec_scas_single(env, decode);
     }
 
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_lods_single(struct CPUX86State *env, struct x86_decode *decode)
@@ -661,7 +661,7 @@ static void exec_lods(struct CPUX86State *env, struct x86_decode *decode)
         exec_lods_single(env, decode);
     }
 
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 void simulate_rdmsr(struct CPUState *cpu)
@@ -758,7 +758,7 @@ void simulate_rdmsr(struct CPUState *cpu)
 static void exec_rdmsr(struct CPUX86State *env, struct x86_decode *decode)
 {
     simulate_rdmsr(env_cpu(env));
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 void simulate_wrmsr(struct CPUState *cpu)
@@ -853,7 +853,7 @@ void simulate_wrmsr(struct CPUState *cpu)
 static void exec_wrmsr(struct CPUX86State *env, struct x86_decode *decode)
 {
     simulate_wrmsr(env_cpu(env));
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 /*
@@ -909,25 +909,25 @@ static void do_bt(struct CPUX86State *env, struct x86_decode *decode, int flag)
 static void exec_bt(struct CPUX86State *env, struct x86_decode *decode)
 {
     do_bt(env, decode, 0);
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_btc(struct CPUX86State *env, struct x86_decode *decode)
 {
     do_bt(env, decode, 1);
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_btr(struct CPUX86State *env, struct x86_decode *decode)
 {
     do_bt(env, decode, 3);
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_bts(struct CPUX86State *env, struct x86_decode *decode)
 {
     do_bt(env, decode, 2);
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 void exec_shl(struct CPUX86State *env, struct x86_decode *decode)
@@ -991,7 +991,7 @@ void exec_shl(struct CPUX86State *env, struct x86_decode *decode)
 
 exit:
     /* lflags_to_rflags(env); */
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 void exec_movsx(CPUX86State *env, struct x86_decode *decode)
@@ -1014,7 +1014,7 @@ void exec_movsx(CPUX86State *env, struct x86_decode *decode)
 
     write_val_ext(env, decode->op[0].ptr, decode->op[1].val, op_size);
 
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 void exec_ror(struct CPUX86State *env, struct x86_decode *decode)
@@ -1092,7 +1092,7 @@ void exec_ror(struct CPUX86State *env, struct x86_decode *decode)
         break;
         }
     }
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 void exec_rol(struct CPUX86State *env, struct x86_decode *decode)
@@ -1173,7 +1173,7 @@ void exec_rol(struct CPUX86State *env, struct x86_decode *decode)
         break;
         }
     }
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 
@@ -1259,7 +1259,7 @@ void exec_rcl(struct CPUX86State *env, struct x86_decode *decode)
         break;
         }
     }
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 void exec_rcr(struct CPUX86State *env, struct x86_decode *decode)
@@ -1334,7 +1334,7 @@ void exec_rcr(struct CPUX86State *env, struct x86_decode *decode)
         break;
         }
     }
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_xchg(struct CPUX86State *env, struct x86_decode *decode)
@@ -1346,7 +1346,7 @@ static void exec_xchg(struct CPUX86State *env, struct x86_decode *decode)
     write_val_ext(env, decode->op[1].ptr, decode->op[0].val,
                   decode->operand_size);
 
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static void exec_xadd(struct CPUX86State *env, struct x86_decode *decode)
@@ -1355,7 +1355,7 @@ static void exec_xadd(struct CPUX86State *env, struct x86_decode *decode)
     write_val_ext(env, decode->op[1].ptr, decode->op[0].val,
                   decode->operand_size);
 
-    RIP(env) += decode->len;
+    env->eip += decode->len;
 }
 
 static struct cmd_handler {
@@ -1434,7 +1434,7 @@ void load_regs(struct CPUState *cpu)
 
     RFLAGS(env) = rreg(cpu->hvf_fd, HV_X86_RFLAGS);
     rflags_to_lflags(env);
-    RIP(env) = rreg(cpu->hvf_fd, HV_X86_RIP);
+    env->eip = rreg(cpu->hvf_fd, HV_X86_RIP);
 }
 
 void store_regs(struct CPUState *cpu)
@@ -1457,20 +1457,20 @@ void store_regs(struct CPUState *cpu)
 
     lflags_to_rflags(env);
     wreg(cpu->hvf_fd, HV_X86_RFLAGS, RFLAGS(env));
-    macvm_set_rip(cpu, RIP(env));
+    macvm_set_rip(cpu, env->eip);
 }
 
 bool exec_instruction(struct CPUX86State *env, struct x86_decode *ins)
 {
     /*if (hvf_vcpu_id(cpu))
-    printf("%d, %llx: exec_instruction %s\n", hvf_vcpu_id(cpu),  RIP(cpu),
+    printf("%d, %llx: exec_instruction %s\n", hvf_vcpu_id(cpu),  env->eip,
           decode_cmd_to_string(ins->cmd));*/
 
     if (!_cmd_handler[ins->cmd].handler) {
-        printf("Unimplemented handler (%llx) for %d (%x %x) \n", RIP(env),
+        printf("Unimplemented handler (%llx) for %d (%x %x) \n", env->eip,
                 ins->cmd, ins->opcode[0],
                 ins->opcode_len > 1 ? ins->opcode[1] : 0);
-        RIP(env) += ins->len;
+        env->eip += ins->len;
         return true;
     }
 
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index 1daac6cc2b..834baec3ea 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -38,7 +38,7 @@ static void save_state_to_tss32(CPUState *cpu, struct x86_tss_segment32 *tss)
     CPUX86State *env = &x86_cpu->env;
 
     /* CR3 and ldt selector are not saved intentionally */
-    tss->eip = EIP(env);
+    tss->eip = (uint32_t)env->eip;
     tss->eflags = EFLAGS(env);
     tss->eax = EAX(env);
     tss->ecx = ECX(env);
@@ -64,7 +64,7 @@ static void load_state_from_tss32(CPUState *cpu, struct x86_tss_segment32 *tss)
 
     wvmcs(cpu->hvf_fd, VMCS_GUEST_CR3, tss->cr3);
 
-    RIP(env) = tss->eip;
+    env->eip = tss->eip;
     EFLAGS(env) = tss->eflags | 2;
 
     /* General purpose registers */
-- 
2.26.2



