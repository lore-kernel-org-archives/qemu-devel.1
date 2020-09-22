Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D593BC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404D1206FB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBxoP/8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404D1206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfi5-0005tV-5E
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kKfaR-0004EI-Fh
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:31:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kKfaP-0006SN-0p
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600770708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9jkd+9WrIX5vZF1mzci7p5oHp9uENb90pHj8SNwHtM=;
 b=NBxoP/8q1RlawSaQwYLA690FOx41M6ofyG/nqCfRqBF8p7s9rSaKeWGU4CjB6QOKANPznG
 iqB/H5Ed/8PaLGwwJUOyti3AH2w5Fu5msTY4vl86oXnxZJMhNyO+1rukbf1WoYNWb84Ruc
 N0BMO+m+VQTnQdo5mfH05848Q595nUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-pykDW5GUO7-Y77s81-VbOw-1; Tue, 22 Sep 2020 06:31:46 -0400
X-MC-Unique: pykDW5GUO7-Y77s81-VbOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 739F110BBECD;
 Tue, 22 Sep 2020 10:31:45 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-20.ams2.redhat.com [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 192E819C4F;
 Tue, 22 Sep 2020 10:31:43 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 6/8] s390x/tcg: Implement MULTIPLY SINGLE (MSC, MSGC, MSGRKC,
 MSRKC)
Date: Tue, 22 Sep 2020 12:31:27 +0200
Message-Id: <20200922103129.12824-7-david@redhat.com>
In-Reply-To: <20200922103129.12824-1-david@redhat.com>
References: <20200922103129.12824-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need new CC handling, determining the CC based on the intermediate
result (64bit for MSC and MSRKC, 128bit for MSGC and MSGRKC).

We want to store out2 ("low") after muls128 to r1, so add
"wout_out2_r1".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cc_helper.c   | 34 ++++++++++++++++++++++++++++++++++
 target/s390x/helper.c      |  2 ++
 target/s390x/insn-data.def |  4 ++++
 target/s390x/internal.h    |  2 ++
 target/s390x/translate.c   | 19 +++++++++++++++++++
 5 files changed, 61 insertions(+)

diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
index 44731e4a85..62074648e6 100644
--- a/target/s390x/cc_helper.c
+++ b/target/s390x/cc_helper.c
@@ -417,6 +417,35 @@ static uint32_t cc_calc_vc(uint64_t low, uint64_t high)
     }
 }
 
+static uint32_t cc_calc_muls_32(int64_t res)
+{
+    /* Arithmetic shift with sign extension so we can compare against -1ull. */
+    const uint64_t tmp = res >> 31;
+
+    if (!res) {
+        return 0;
+    } else if (!(!tmp || tmp == -1ull)) {
+        return 3;
+    } else if (res < 0) {
+        return 1;
+    }
+    return 2;
+}
+
+static uint64_t cc_calc_muls_64(int64_t res_high, uint64_t res_low)
+{
+    const uint8_t tmp = res_low >> 63;
+
+    if (!res_high && !res_low) {
+        return 0;
+    } else if (!(!res_high && !tmp) || !(res_high == -1ull && tmp)) {
+        return 3;
+    } else if (res_high < 0) {
+        return 1;
+    }
+    return 2;
+}
+
 static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
                                   uint64_t src, uint64_t dst, uint64_t vr)
 {
@@ -484,6 +513,9 @@ static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
     case CC_OP_COMP_64:
         r =  cc_calc_comp_64(dst);
         break;
+    case CC_OP_MULS_64:
+        r = cc_calc_muls_64(src, dst);
+        break;
 
     case CC_OP_ADD_32:
         r =  cc_calc_add_32(src, dst, vr);
@@ -512,6 +544,8 @@ static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
     case CC_OP_COMP_32:
         r =  cc_calc_comp_32(dst);
         break;
+    case CC_OP_MULS_32:
+        r = cc_calc_muls_32(dst);
 
     case CC_OP_ICM:
         r =  cc_calc_icm(src, dst);
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 9257d388ba..b877690845 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -430,6 +430,8 @@ const char *cc_name(enum cc_op cc_op)
         [CC_OP_FLOGR]     = "CC_OP_FLOGR",
         [CC_OP_LCBB]      = "CC_OP_LCBB",
         [CC_OP_VC]        = "CC_OP_VC",
+        [CC_OP_MULS_32]   = "CC_OP_MULS_32",
+        [CC_OP_MULS_64]   = "CC_OP_MULS_64",
     };
 
     return cc_names[cc_op];
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index dfb0ec067b..bcd424e9ae 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -679,11 +679,15 @@
     C(0xe386, MLG,     RXY_a, Z,   r1p1, m2_64, r1_P, 0, mul128, 0)
 /* MULTIPLY SINGLE */
     C(0xb252, MSR,     RRE,   Z,   r1_o, r2_o, new, r1_32, mul, 0)
+    C(0xb9fd, MSRKC,   RRF_a, MIE2,r3_32s, r2_32s, new, r1_32, mul, muls32)
     C(0x7100, MS,      RX_a,  Z,   r1_o, m2_32s, new, r1_32, mul, 0)
     C(0xe351, MSY,     RXY_a, LD,  r1_o, m2_32s, new, r1_32, mul, 0)
+    C(0xe353, MSC,     RXY_a, MIE2,r1_32s, m2_32s, new, r1_32, mul, muls32)
     C(0xb90c, MSGR,    RRE,   Z,   r1_o, r2_o, r1, 0, mul, 0)
+    C(0xb9ed, MSGRKC,  RRF_a, MIE2,r3_o, r2_o, new_P, out2_r1, muls128, muls64)
     C(0xb91c, MSGFR,   RRE,   Z,   r1_o, r2_32s, r1, 0, mul, 0)
     C(0xe30c, MSG,     RXY_a, Z,   r1_o, m2_64, r1, 0, mul, 0)
+    C(0xe383, MSGC,    RXY_a, MIE2,r1_o, m2_64, new_P, out2_r1, muls128, muls64)
     C(0xe31c, MSGF,    RXY_a, Z,   r1_o, m2_32s, r1, 0, mul, 0)
 /* MULTIPLY SINGLE IMMEDIATE */
     C(0xc201, MSFI,    RIL_a, GIE, r1_o, i2, new, r1_32, mul, 0)
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index b1e0ebf67f..c5d32237ea 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -175,6 +175,7 @@ enum cc_op {
     CC_OP_SUBB_64,              /* overflow on unsigned sub-borrow (64bit) */
     CC_OP_ABS_64,               /* sign eval on abs (64bit) */
     CC_OP_NABS_64,              /* sign eval on nabs (64bit) */
+    CC_OP_MULS_64,              /* overflow on signed multiply (64bit) */
 
     CC_OP_ADD_32,               /* overflow on add (32bit) */
     CC_OP_ADDU_32,              /* overflow on unsigned add (32bit) */
@@ -184,6 +185,7 @@ enum cc_op {
     CC_OP_SUBB_32,              /* overflow on unsigned sub-borrow (32bit) */
     CC_OP_ABS_32,               /* sign eval on abs (64bit) */
     CC_OP_NABS_32,              /* sign eval on nabs (64bit) */
+    CC_OP_MULS_32,              /* overflow on signed multiply (32bit) */
 
     CC_OP_COMP_32,              /* complement */
     CC_OP_COMP_64,              /* complement */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 383edf7419..c90cb37aae 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -646,6 +646,7 @@ static void gen_op_calc_cc(DisasContext *s)
     case CC_OP_NZ_F64:
     case CC_OP_FLOGR:
     case CC_OP_LCBB:
+    case CC_OP_MULS_32:
         /* 1 argument */
         gen_helper_calc_cc(cc_op, cpu_env, local_cc_op, dummy, cc_dst, dummy);
         break;
@@ -660,6 +661,7 @@ static void gen_op_calc_cc(DisasContext *s)
     case CC_OP_SLA_64:
     case CC_OP_NZ_F128:
     case CC_OP_VC:
+    case CC_OP_MULS_64:
         /* 2 arguments */
         gen_helper_calc_cc(cc_op, cpu_env, local_cc_op, cc_src, cc_dst, dummy);
         break;
@@ -5294,6 +5296,17 @@ static void cout_tm64(DisasContext *s, DisasOps *o)
     gen_op_update2_cc_i64(s, CC_OP_TM_64, o->in1, o->in2);
 }
 
+static void cout_muls32(DisasContext *s, DisasOps *o)
+{
+    gen_op_update1_cc_i64(s, CC_OP_MULS_32, o->out);
+}
+
+static void cout_muls64(DisasContext *s, DisasOps *o)
+{
+    /* out contains "high" part, out2 contains "low" part of 128 bit result */
+    gen_op_update2_cc_i64(s, CC_OP_MULS_64, o->out, o->out2);
+}
+
 /* ====================================================================== */
 /* The "PREParation" generators.  These initialize the DisasOps.OUT fields
    with the TCG register to which we will write.  Used in combination with
@@ -5349,6 +5362,12 @@ static void wout_r1(DisasContext *s, DisasOps *o)
 }
 #define SPEC_wout_r1 0
 
+static void wout_out2_r1(DisasContext *s, DisasOps *o)
+{
+    store_reg(get_field(s, r1), o->out2);
+}
+#define SPEC_wout_out2_r1 0
+
 static void wout_r1_8(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s, r1);
-- 
2.26.2


