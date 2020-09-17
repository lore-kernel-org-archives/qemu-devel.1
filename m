Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9699AC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 11:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F5920707
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 11:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqCSUY+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F5920707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIsVt-00076D-VF
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 07:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kIsVF-0006cd-G3
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 07:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kIsVA-00086t-H7
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 07:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600343699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VB3B+fleWAtLaCFiu3MvbFlxA9PCfi4y0CfVuvhROt0=;
 b=BqCSUY+STu88onFzcKflOlhfS0VOzgr7uJB2+80nGGOs8DDVwvDqh2FvdFGYVwFy+4apTY
 HwL+mW2ZYqo63gFV2xXv2U6N5oc6ThxrmoLMWsl9UW9p0K1EwKYyBMsqB33nbIheNYu3rZ
 dNtc2SGEolv+D6bz9pahOFaoaJc0Joo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-A3UjFiZUPlSJk9UO7u6zqA-1; Thu, 17 Sep 2020 07:54:57 -0400
X-MC-Unique: A3UjFiZUPlSJk9UO7u6zqA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 139188030C7;
 Thu, 17 Sep 2020 11:54:56 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-153.ams2.redhat.com [10.36.114.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BBD6219D6C;
 Thu, 17 Sep 2020 11:54:51 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1] s390x/tcg: Implement MONITOR CALL
Date: Thu, 17 Sep 2020 13:54:47 +0200
Message-Id: <20200917115447.10503-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recent upstream Linux uses the MONITOR CALL instruction for things like
BUG_ON() and WARN_ON(). We currently inject an operation exception when
we hit a MONITOR CALL instruction - which is wrong, as the instruction
is not glued to specific CPU features.

Doing a simple WARN_ON_ONCE() currently results in a panic:
  [   18.162801] illegal operation: 0001 ilc:2 [#1] SMP
  [   18.162889] Modules linked in:
  [...]
  [   18.165476] Kernel panic - not syncing: Fatal exception: panic_on_oops

With a proper implementation, we now get:
  [   18.242754] ------------[ cut here ]------------
  [   18.242855] WARNING: CPU: 7 PID: 1 at init/main.c:1534 [...]
  [   18.242919] Modules linked in:
  [...]
  [   18.246262] ---[ end trace a420477d71dc97b4 ]---
  [   18.259014] Freeing unused kernel memory: 4220K

To be able to translate it to a NOP easily, mangle the 16 monitor masks
bits from the cr8 into the TB flags.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h         | 32 ++++++++++++++++++++++++++++++++
 target/s390x/excp_helper.c | 14 ++++++++++++++
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  3 +++
 target/s390x/translate.c   | 29 +++++++++++++++++++++++++++++
 5 files changed, 79 insertions(+)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 035427521c..a1871bfa24 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -266,6 +266,7 @@ extern const VMStateDescription vmstate_s390_cpu;
 #define PSW_SHIFT_KEY           52
 #define PSW_MASK_SHORTPSW       0x0008000000000000ULL
 #define PSW_MASK_MCHECK         0x0004000000000000ULL
+#define PSW_SHIFT_MCHECK        50
 #define PSW_MASK_WAIT           0x0002000000000000ULL
 #define PSW_MASK_PSTATE         0x0001000000000000ULL
 #define PSW_MASK_ASC            0x0000C00000000000ULL
@@ -274,6 +275,11 @@ extern const VMStateDescription vmstate_s390_cpu;
 #define PSW_MASK_PM             0x00000F0000000000ULL
 #define PSW_SHIFT_MASK_PM       40
 #define PSW_MASK_RI             0x0000008000000000ULL
+#define PSW_MASK_UNUSED_25      0x0000004000000000ULL
+#define PSW_MASK_UNUSED_26      0x0000002000000000ULL
+#define PSW_MASK_UNUSED_27      0x0000001000000000ULL
+#define PSW_MASK_UNUSED_27      0x0000001000000000ULL
+#define PSW_SHIFT_UNUSED_27     36
 #define PSW_MASK_64             0x0000000100000000ULL
 #define PSW_MASK_32             0x0000000080000000ULL
 #define PSW_MASK_SHORT_ADDR     0x000000007fffffffULL
@@ -311,6 +317,19 @@ extern const VMStateDescription vmstate_s390_cpu;
 #define FLAG_MASK_AFP           (PSW_MASK_UNUSED_2 >> FLAG_MASK_PSW_SHIFT)
 #define FLAG_MASK_VECTOR        (PSW_MASK_UNUSED_3 >> FLAG_MASK_PSW_SHIFT)
 
+/*
+ * We'll store the monitor mask bits in a mixture of unused PSW positions
+ * and used PSW positions that are not copied to tb flags (see FLAG_MASK_PSW).
+ */
+#define FLAG_MASK_MM0_7         ((PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_KEY | \
+                                  PSW_MASK_SHORTPSW | PSW_MASK_MCHECK) >> \
+                                 FLAG_MASK_PSW_SHIFT)
+#define FLAG_SHIFT_MM0_7        (PSW_SHIFT_MCHECK - FLAG_MASK_PSW_SHIFT)
+#define FLAG_MASK_MM8_15        ((PSW_MASK_PM | PSW_MASK_RI | \
+                                 PSW_MASK_UNUSED_25 | PSW_MASK_UNUSED_26 | \
+                                 PSW_MASK_UNUSED_27) >> FLAG_MASK_PSW_SHIFT)
+#define FLAG_SHIFT_MM8_15       (PSW_SHIFT_UNUSED_27 - FLAG_MASK_PSW_SHIFT)
+
 /* Control register 0 bits */
 #define CR0_LOWPROT             0x0000000010000000ULL
 #define CR0_SECONDARY           0x0000000004000000ULL
@@ -324,6 +343,9 @@ extern const VMStateDescription vmstate_s390_cpu;
 #define CR0_CPU_TIMER_SC        0x0000000000000400ULL
 #define CR0_SERVICE_SC          0x0000000000000200ULL
 
+/* Control register 8 bits */
+#define CR8_MONITOR_MASK        0x000000000000ffffULL
+
 /* Control register 14 bits */
 #define CR14_CHANNEL_REPORT_SC  0x0000000010000000ULL
 
@@ -367,6 +389,8 @@ static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
 static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
 {
+    uint8_t byte;
+
     *pc = env->psw.addr;
     *cs_base = env->ex_value;
     *flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
@@ -376,6 +400,14 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
     if (env->cregs[0] & CR0_VECTOR) {
         *flags |= FLAG_MASK_VECTOR;
     }
+    /* Copy over the monitor mask bits (16) as two separate bytes. */
+    byte = (env->cregs[8] & CR8_MONITOR_MASK) >> 8;
+    *flags |= (uint32_t)byte << FLAG_SHIFT_MM0_7;
+    byte = env->cregs[8] & CR8_MONITOR_MASK;
+    *flags |= (uint32_t)byte << FLAG_SHIFT_MM8_15;
+
+    QEMU_BUILD_BUG_ON((FLAG_MASK_AFP | FLAG_MASK_VECTOR | FLAG_MASK_MM0_7 |
+                       FLAG_MASK_MM8_15) & FLAG_MASK_PSW);
 }
 
 /* PER bits from control register 9 */
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 3b58d10df3..ba6dc53074 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -610,4 +610,18 @@ void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     tcg_s390_program_interrupt(env, PGM_SPECIFICATION, retaddr);
 }
 
+void HELPER(monitor_event)(CPUS390XState *env, uint64_t monitor_code,
+                           uint32_t monitor_class)
+{
+    g_assert(monitor_class <= 0xff);
+
+    /* Store the Monitor Class Number and the Monitor Code into the lowcore */
+    stw_phys(env_cpu(env)->as,
+             env->psa + offsetof(LowCore, mon_class_num), monitor_class);
+    stq_phys(env_cpu(env)->as,
+             env->psa + offsetof(LowCore, monitor_code), monitor_code);
+
+    tcg_s390_program_interrupt(env, PGM_MONITOR, GETPC());
+}
+
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index b7887b552b..e72b32e0ca 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -295,6 +295,7 @@ DEF_HELPER_4(gvec_vftci64s, void, ptr, cptr, env, i32)
 DEF_HELPER_3(servc, i32, env, i64, i64)
 DEF_HELPER_4(diag, void, env, i32, i32, i32)
 DEF_HELPER_3(load_psw, noreturn, env, i64, i64)
+DEF_HELPER_3(monitor_event, noreturn, env, i64, i32)
 DEF_HELPER_FLAGS_2(spx, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_2(sck, TCG_CALL_NO_RWG, i32, env, i64)
 DEF_HELPER_FLAGS_2(sckc, TCG_CALL_NO_RWG, void, env, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index d79ae9e3f1..e14cbd63fa 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -617,6 +617,9 @@
     C(0x9a00, LAM,     RS_a,  Z,   0, a2, 0, 0, lam, 0)
     C(0xeb9a, LAMY,    RSY_a, LD,  0, a2, 0, 0, lam, 0)
 
+/* MONITOR CALL */
+    C(0xaf00, MC,      SI,    Z,   la1, 0, 0, 0, mc, 0)
+
 /* MOVE */
     C(0xd200, MVC,     SS_a,  Z,   la1, a2, 0, 0, mvc, 0)
     C(0xe544, MVHHI,   SIL,   GIE, la1, i2, 0, m1_16, mov2, 0)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index a777343821..3f2bf6576a 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3302,6 +3302,35 @@ static DisasJumpType op_lcbb(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
+static DisasJumpType op_mc(DisasContext *s, DisasOps *o)
+{
+#if !defined(CONFIG_USER_ONLY)
+    /* Reconstruct the monitor mask from the tb flags. */
+    uint16_t monitor_mask = ((s->base.tb->flags & FLAG_MASK_MM0_7) >>
+                             (FLAG_SHIFT_MM0_7 - 8)) |
+                            ((s->base.tb->flags & FLAG_MASK_MM8_15) >>
+                             FLAG_SHIFT_MM8_15);
+    TCGv_i32 i2;
+#endif
+    const uint16_t monitor_class = get_field(s, i2);
+
+    if (monitor_class & 0xff00) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+#if !defined(CONFIG_USER_ONLY)
+    if (monitor_mask & (0x8000 >> monitor_class)) {
+        i2 = tcg_const_i32(get_field(s, i2));
+        gen_helper_monitor_event(cpu_env, o->addr1, i2);
+        tcg_temp_free_i32(i2);
+        return DISAS_NORETURN;
+    }
+#endif
+    /* Defaults to a NOP. */
+    return DISAS_NEXT;
+}
+
 static DisasJumpType op_mov2(DisasContext *s, DisasOps *o)
 {
     o->out = o->in2;
-- 
2.26.2


