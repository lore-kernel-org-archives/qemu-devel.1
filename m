Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C42C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4784B2065D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyaAYzyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4784B2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOK92-0000TG-PZ
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJvA-0004Cr-5E
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJuz-0003Ra-Fa
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601640718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ubNgyxnI1ncFy+ev6LEYB8xPbgVFuajTGk/5+8i4/+Y=;
 b=EyaAYzylhvFVxfjhl1FA9ELCouztpQjtjIDlRZNj1TxEZaVLX0Ke1UwiviriGvtuuDGd/Z
 cSMOMujd2n9OZBg+ZqtxY986HCoEtdfUeeRLFSVEJ1t5Vg+2AA4wRtZkrCu/EG5r77lttp
 75E6b9/cjLN+cALN/1XbpoOXjWZPKV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-Qi2kKg3TMcejw6meB3WlEQ-1; Fri, 02 Oct 2020 08:11:55 -0400
X-MC-Unique: Qi2kKg3TMcejw6meB3WlEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 693001074644;
 Fri,  2 Oct 2020 12:11:54 +0000 (UTC)
Received: from localhost (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E56860C05;
 Fri,  2 Oct 2020 12:11:51 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/19] s390x/tcg: Implement MONITOR CALL
Date: Fri,  2 Oct 2020 14:11:08 +0200
Message-Id: <20201002121118.180315-10-cohuck@redhat.com>
In-Reply-To: <20201002121118.180315-1-cohuck@redhat.com>
References: <20201002121118.180315-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

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

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200918085122.26132-1-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/excp_helper.c | 23 +++++++++++++++++++++++
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  3 +++
 target/s390x/translate.c   | 21 +++++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 3b58d10df3ca..0adfbbda2708 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -610,4 +610,27 @@ void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     tcg_s390_program_interrupt(env, PGM_SPECIFICATION, retaddr);
 }
 
+static void QEMU_NORETURN monitor_event(CPUS390XState *env,
+                                        uint64_t monitor_code,
+                                        uint8_t monitor_class, uintptr_t ra)
+{
+    /* Store the Monitor Code and the Monitor Class Number into the lowcore */
+    stq_phys(env_cpu(env)->as,
+             env->psa + offsetof(LowCore, monitor_code), monitor_code);
+    stw_phys(env_cpu(env)->as,
+             env->psa + offsetof(LowCore, mon_class_num), monitor_class);
+
+    tcg_s390_program_interrupt(env, PGM_MONITOR, ra);
+}
+
+void HELPER(monitor_call)(CPUS390XState *env, uint64_t monitor_code,
+                          uint32_t monitor_class)
+{
+    g_assert(monitor_class <= 0xff);
+
+    if (env->cregs[8] & (0x8000 >> monitor_class)) {
+        monitor_event(env, monitor_code, monitor_class, GETPC());
+    }
+}
+
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index b7887b552bbb..55bd1551e604 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -349,4 +349,5 @@ DEF_HELPER_3(sic, void, env, i64, i64)
 DEF_HELPER_3(rpcit, void, env, i32, i32)
 DEF_HELPER_5(pcistb, void, env, i32, i32, i64, i32)
 DEF_HELPER_4(mpcifc, void, env, i32, i64, i32)
+DEF_HELPER_3(monitor_call, void, env, i64, i32)
 #endif
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index d79ae9e3f114..e14cbd63fa0a 100644
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
index a777343821bb..90dc1740e7ab 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3302,6 +3302,27 @@ static DisasJumpType op_lcbb(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
+static DisasJumpType op_mc(DisasContext *s, DisasOps *o)
+{
+#if !defined(CONFIG_USER_ONLY)
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
+    i2 = tcg_const_i32(monitor_class);
+    gen_helper_monitor_call(cpu_env, o->addr1, i2);
+    tcg_temp_free_i32(i2);
+#endif
+    /* Defaults to a NOP. */
+    return DISAS_NEXT;
+}
+
 static DisasJumpType op_mov2(DisasContext *s, DisasOps *o)
 {
     o->out = o->in2;
-- 
2.25.4


