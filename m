Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D63EC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 297BB22DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAJkx+R4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297BB22DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VfY-0004Ij-0a
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URz-0001tB-4D
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URs-0008V7-GV
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:10 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:32971)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URq-0008R0-95
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:04 -0400
Received: by mail-yb1-xb41.google.com with SMTP id b16so1357689ybq.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vcpkVqHLV0kMPcYTaYpjopPrKdBPQ0gpahGAjWT5lGI=;
 b=dAJkx+R4p73wspvsOAGnoGTF8M7wL1VQt/gT85V9hnD4C03ij1KOXl1AJqbQXe7h9e
 3OCmbzhAryPqMfqG1I9Dc3Bgy1iCfTOUUy15xybmnyG1Mkk3gdJKDRy2Pob4P/1GgZdd
 CV9WQTpnICGv2W5fippl6DLRTIYA4JhxtalMJY+Svfs2kDXr4Nu2n9Noi+IKlXBgpfQ8
 7BNyo0+jnzLiAf4MxYA0nk1RFt42wbXtOECU5njB31emW1+ALthlsC0MbP9UT2VxbSMF
 d2+1vdNXa0ikrmc4t8LNQ4nByYhUJ1XdDoEfaYCwVu9ZLsJMZzd4DGyVyQD6HJdJmMVX
 S2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vcpkVqHLV0kMPcYTaYpjopPrKdBPQ0gpahGAjWT5lGI=;
 b=GGqPoFY+hyJLALEppTo9ms4AxP1RNeaa2SR8jOLASjB2fdJf8nr23mJ3RetJgfm/s8
 W4vQAcx3zu0I3mVjqOWaBK6/8g1JEBVCAvIME4botI/9JjWudCoBOfOPV+36R65r9eRP
 6Z+j7V79WTzW8YWMonKwKBI50KpzLr06qu2ojzoaF5MfTVf790dVd+JvBpD/JNqbJ+TQ
 Mzhj7Z9q0B4T4UkqwpiqTE1Ure5zvhXgaMgtBaoljBgjwm/kdB2hpuXJMBOIyiOg4RQX
 k++Hj26mjAYAqc5oD+NI89/iqoKBnS9o8eiiqdNIhbHU8P7Z5JOHncOrpc57ARj1PQVJ
 oYYg==
X-Gm-Message-State: APjAAAXbWIQr3AHnzWpHpWXa5VgPlW1junFH/s0qeLkgPfkJ73InzHGG
 /Onjt/7tZakKGftFYoufTtgv/KMB
X-Google-Smtp-Source: APXvYqxDLfGCQQyTuRzshzgIP6of6qPM0xdweA3zD+e6EXeeUBWpuXkk+1pmOrp+oftfI4hMdbs1ow==
X-Received: by 2002:a25:2bc8:: with SMTP id
 r191mr24059684ybr.327.1566408660229; 
 Wed, 21 Aug 2019 10:31:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:59 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:39 -0400
Message-Id: <20190821172951.15333-64-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RFC PATCH v4 63/75] target/i386: introduce AVX2 code
 generators
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce code generators required by AVX2 instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 407 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 395 insertions(+), 12 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 3f4bb40932..3149989d68 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4946,6 +4946,11 @@ DEF_INSNOP_ALIAS(Mhq, M)
 DEF_INSNOP_ALIAS(Mdq, M)
 DEF_INSNOP_ALIAS(Mqq, M)
 
+DEF_INSNOP_ALIAS(MDdq, M)
+DEF_INSNOP_ALIAS(MDqq, M)
+DEF_INSNOP_ALIAS(MQdq, M)
+DEF_INSNOP_ALIAS(MQqq, M)
+
 /*
  * 32-bit general register operands
  */
@@ -5907,6 +5912,14 @@ GEN_INSN2(vpmovmskb, Gq, Udq)
     tcg_gen_extu_i32_i64(arg1, arg1_r32);
     tcg_temp_free_i32(arg1_r32);
 }
+DEF_GEN_INSN2_HELPER_DEP(vpmovmskb, pmovmskb_xmm, Gd, Uqq)
+GEN_INSN2(vpmovmskb, Gq, Uqq)
+{
+    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
+    gen_insn2(vpmovmskb, Gd, Uqq)(env, s, arg1_r32, arg2);
+    tcg_gen_extu_i32_i64(arg1, arg1_r32);
+    tcg_temp_free_i32(arg1_r32);
+}
 
 DEF_GEN_INSN2_HELPER_DEP(movmskps, movmskps, Gd, Udq)
 GEN_INSN2(movmskps, Gq, Udq)
@@ -6049,27 +6062,35 @@ GEN_INSN2(vmovddup, Vqq, Wqq)
 DEF_GEN_INSN3_GVEC(paddb, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddb, Vdq, Vdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(vpaddb, Vdq, Hdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpaddb, Vqq, Hqq, Wqq, add, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddw, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(paddw, Vdq, Vdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(vpaddw, Vdq, Hdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpaddw, Vqq, Hqq, Wqq, add, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(paddd, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_32)
 DEF_GEN_INSN3_GVEC(paddd, Vdq, Vdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_GVEC(vpaddd, Vdq, Hdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(vpaddd, Vqq, Hqq, Wqq, add, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_GVEC(paddq, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(paddq, Vdq, Vdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(vpaddq, Vdq, Hdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vpaddq, Vqq, Hqq, Wqq, add, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(paddsb, Pq, Pq, Qq, ssadd, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddsb, Vdq, Vdq, Wdq, ssadd, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(vpaddsb, Vdq, Hdq, Wdq, ssadd, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpaddsb, Vqq, Hqq, Wqq, ssadd, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddsw, Pq, Pq, Qq, ssadd, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(paddsw, Vdq, Vdq, Wdq, ssadd, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(vpaddsw, Vdq, Hdq, Wdq, ssadd, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpaddsw, Vqq, Hqq, Wqq, ssadd, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(paddusb, Pq, Pq, Qq, usadd, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddusb, Vdq, Vdq, Wdq, usadd, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(vpaddusb, Vdq, Hdq, Wdq, usadd, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpaddusb, Vqq, Hqq, Wqq, usadd, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddusw, Pq, Pq, Qq, usadd, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(paddusw, Vdq, Vdq, Wdq, usadd, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(vpaddusw, Vdq, Hdq, Wdq, usadd, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpaddusw, Vqq, Hqq, Wqq, usadd, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_HELPER_EPP(addps, addps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vaddps, addps, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vaddps, addps, Vqq, Hqq, Wqq)
@@ -6083,12 +6104,15 @@ DEF_GEN_INSN3_HELPER_EPP(vaddsd, addsd, Vq, Hq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(phaddw, phaddw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(phaddw, phaddw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vphaddw, phaddw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vphaddw, phaddw_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(phaddd, phaddd_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(phaddd, phaddd_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vphaddd, phaddd_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vphaddd, phaddd_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(phaddsw, phaddsw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(phaddsw, phaddsw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vphaddsw, phaddsw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vphaddsw, phaddsw_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(haddps, haddps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vhaddps, haddps, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vhaddps, haddps, Vqq, Hqq, Wqq)
@@ -6099,27 +6123,35 @@ DEF_GEN_INSN3_HELPER_EPP(vhaddpd, haddpd, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_GVEC(psubb, Pq, Pq, Qq, sub, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubb, Vdq, Vdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(vpsubb, Vdq, Hdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpsubb, Vqq, Hqq, Wqq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubw, Pq, Pq, Qq, sub, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(psubw, Vdq, Vdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(vpsubw, Vdq, Hdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpsubw, Vqq, Hqq, Wqq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(psubd, Pq, Pq, Qq, sub, MM_OPRSZ, MM_MAXSZ, MO_32)
 DEF_GEN_INSN3_GVEC(psubd, Vdq, Vdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_GVEC(vpsubd, Vdq, Hdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(vpsubd, Vqq, Hqq, Wqq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_GVEC(psubq, Pq, Pq, Qq, sub, MM_OPRSZ, MM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(psubq, Vdq, Vdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(vpsubq, Vdq, Hdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vpsubq, Vqq, Hqq, Wqq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(psubsb, Pq, Pq, Qq, sssub, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubsb, Vdq, Vdq, Wdq, sssub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(vpsubsb, Vdq, Hdq, Wdq, sssub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpsubsb, Vqq, Hqq, Wqq, sssub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubsw, Pq, Pq, Qq, sssub, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(psubsw, Vdq, Vdq, Wdq, sssub, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(vpsubsw, Vdq, Hdq, Wdq, sssub, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpsubsw, Vqq, Hqq, Wqq, sssub, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(psubusb, Pq, Pq, Qq, ussub, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubusb, Vdq, Vdq, Wdq, ussub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(vpsubusb, Vdq, Hdq, Wdq, ussub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpsubusb, Vqq, Hqq, Wqq, ussub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubusw, Pq, Pq, Qq, ussub, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(psubusw, Vdq, Vdq, Wdq, ussub, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(vpsubusw, Vdq, Hdq, Wdq, ussub, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpsubusw, Vqq, Hqq, Wqq, ussub, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_HELPER_EPP(subps, subps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vsubps, subps, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vsubps, subps, Vqq, Hqq, Wqq)
@@ -6133,12 +6165,15 @@ DEF_GEN_INSN3_HELPER_EPP(vsubsd, subsd, Vq, Hq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(phsubw, phsubw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(phsubw, phsubw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vphsubw, phsubw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vphsubw, phsubw_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(phsubd, phsubd_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(phsubd, phsubd_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vphsubd, phsubd_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vphsubd, phsubd_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(phsubsw, phsubsw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(phsubsw, phsubsw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vphsubsw, phsubsw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vphsubsw, phsubsw_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(hsubps, hsubps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vhsubps, hsubps, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vhsubps, hsubps, Vqq, Hqq, Wqq)
@@ -6156,22 +6191,29 @@ DEF_GEN_INSN3_HELPER_EPP(vaddsubpd, addsubpd, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpmullw, pmullw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpmullw, pmullw_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(pmulld, pmulld_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpmulld, pmulld_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpmulld, pmulld_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhw, pmulhw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhw, pmulhw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpmulhw, pmulhw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpmulhw, pmulhw_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhuw, pmulhuw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhuw, pmulhuw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpmulhuw, pmulhuw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpmulhuw, pmulhuw_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(pmuldq, pmuldq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpmuldq, pmuldq_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpmuldq, pmuldq_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(pmuludq, pmuludq_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmuludq, pmuludq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpmuludq, pmuludq_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpmuludq, pmuludq_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhrsw, pmulhrsw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhrsw, pmulhrsw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpmulhrsw, pmulhrsw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpmulhrsw, pmulhrsw_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(mulps, mulps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vmulps, mulps, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vmulps, mulps, Vqq, Hqq, Wqq)
@@ -6185,9 +6227,11 @@ DEF_GEN_INSN3_HELPER_EPP(vmulsd, mulsd, Vq, Hq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(pmaddwd, pmaddwd_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmaddwd, pmaddwd_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpmaddwd, pmaddwd_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpmaddwd, pmaddwd_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(pmaddubsw, pmaddubsw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmaddubsw, pmaddubsw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpmaddubsw, pmaddubsw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpmaddubsw, pmaddubsw_xmm, Vqq, Hqq, Wqq)
 
 DEF_GEN_INSN3_HELPER_EPP(divps, divps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vdivps, divps, Vdq, Hdq, Wdq)
@@ -6224,17 +6268,23 @@ DEF_GEN_INSN3_HELPER_EPP(vrsqrtss, rsqrtss, Vd, Hd, Wd)
 DEF_GEN_INSN3_GVEC(pminub, Pq, Pq, Qq, umin, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(pminub, Vdq, Vdq, Wdq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(vpminub, Vdq, Hdq, Wdq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpminub, Vqq, Hqq, Wqq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(pminuw, Vdq, Vdq, Wdq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(vpminuw, Vdq, Hdq, Wdq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpminuw, Vqq, Hqq, Wqq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(pminud, Vdq, Vdq, Wdq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_GVEC(vpminud, Vdq, Hdq, Wdq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(vpminud, Vqq, Hqq, Wqq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_GVEC(pminsb, Vdq, Vdq, Wdq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(vpminsb, Vdq, Hdq, Wdq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpminsb, Vqq, Hqq, Wqq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(pminsw, Pq, Pq, Qq, smin, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(pminsw, Vdq, Vdq, Wdq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(vpminsw, Vdq, Hdq, Wdq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpminsw, Vqq, Hqq, Wqq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(pminsd, Vdq, Vdq, Wdq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_GVEC(vpminsd, Vdq, Hdq, Wdq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(vpminsd, Vqq, Hqq, Wqq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_HELPER_EPP(minps, minps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vminps, minps, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vminps, minps, Vqq, Hqq, Wqq)
@@ -6250,17 +6300,23 @@ DEF_GEN_INSN2_HELPER_EPP(vphminposuw, phminposuw_xmm, Vdq, Wdq)
 DEF_GEN_INSN3_GVEC(pmaxub, Pq, Pq, Qq, umax, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(pmaxub, Vdq, Vdq, Wdq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(vpmaxub, Vdq, Hdq, Wdq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpmaxub, Vqq, Hqq, Wqq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(pmaxuw, Vdq, Vdq, Wdq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(vpmaxuw, Vdq, Hdq, Wdq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpmaxuw, Vqq, Hqq, Wqq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(pmaxud, Vdq, Vdq, Wdq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_GVEC(vpmaxud, Vdq, Hdq, Wdq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(vpmaxud, Vqq, Hqq, Wqq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_GVEC(pmaxsb, Vdq, Vdq, Wdq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(vpmaxsb, Vdq, Hdq, Wdq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpmaxsb, Vqq, Hqq, Wqq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(pmaxsw, Pq, Pq, Qq, smax, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(pmaxsw, Vdq, Vdq, Wdq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(vpmaxsw, Vdq, Hdq, Wdq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpmaxsw, Vqq, Hqq, Wqq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(pmaxsd, Vdq, Vdq, Wdq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_GVEC(vpmaxsd, Vdq, Hdq, Wdq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(vpmaxsd, Vqq, Hqq, Wqq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_HELPER_EPP(maxps, maxps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vmaxps, maxps, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vmaxps, maxps, Vqq, Hqq, Wqq)
@@ -6274,32 +6330,42 @@ DEF_GEN_INSN3_HELPER_EPP(vmaxsd, maxsd, Vq, Hq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(pavgb, pavgb_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pavgb, pavgb_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpavgb, pavgb_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpavgb, pavgb_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(pavgw, pavgw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pavgw, pavgw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpavgw, pavgw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpavgw, pavgw_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(psadbw, psadbw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psadbw, psadbw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpsadbw, psadbw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsadbw, psadbw_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN4_HELPER_EPPI(mpsadbw, mpsadbw_xmm, Vdq, Vdq, Wdq, Ib)
 DEF_GEN_INSN4_HELPER_EPPI(vmpsadbw, mpsadbw_xmm, Vdq, Hdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(vmpsadbw, mpsadbw_xmm, Vqq, Hqq, Wqq, Ib)
 DEF_GEN_INSN2_HELPER_EPP(pabsb, pabsb_mmx, Pq, Qq)
 DEF_GEN_INSN2_HELPER_EPP(pabsb, pabsb_xmm, Vdq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(vpabsb, pabsb_xmm, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vpabsb, pabsb_xmm, Vqq, Wqq)
 DEF_GEN_INSN2_HELPER_EPP(pabsw, pabsw_mmx, Pq, Qq)
 DEF_GEN_INSN2_HELPER_EPP(pabsw, pabsw_xmm, Vdq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(vpabsw, pabsw_xmm, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vpabsw, pabsw_xmm, Vqq, Wqq)
 DEF_GEN_INSN2_HELPER_EPP(pabsd, pabsd_mmx, Pq, Qq)
 DEF_GEN_INSN2_HELPER_EPP(pabsd, pabsd_xmm, Vdq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(vpabsd, pabsd_xmm, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vpabsd, pabsd_xmm, Vqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(psignb, psignb_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psignb, psignb_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpsignb, psignb_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsignb, psignb_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(psignw, psignw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psignw, psignw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpsignw, psignw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsignw, psignw_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(psignd, psignd_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psignd, psignd_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpsignd, psignd_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsignd, psignd_xmm, Vqq, Hqq, Wqq)
 
 DEF_GEN_INSN4_HELPER_EPPI(dpps, dpps_xmm, Vdq, Vdq, Wdq, Ib)
 DEF_GEN_INSN4_HELPER_EPPI(vdpps, dpps_xmm, Vdq, Hdq, Wdq, Ib)
@@ -6335,25 +6401,33 @@ DEF_GEN_INSN4_HELPER_EPPI(vpclmulqdq, pclmulqdq_xmm, Vdq, Hdq, Wdq, Ib)
 DEF_GEN_INSN3_GVEC(pcmpeqb, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_8, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqb, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_8, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(vpcmpeqb, Vdq, Hdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_8, TCG_COND_EQ)
+DEF_GEN_INSN3_GVEC(vpcmpeqb, Vqq, Hqq, Wqq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_8, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqw, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_16, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqw, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_16, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(vpcmpeqw, Vdq, Hdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_16, TCG_COND_EQ)
+DEF_GEN_INSN3_GVEC(vpcmpeqw, Vqq, Hqq, Wqq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_16, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqd, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_32, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqd, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_32, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(vpcmpeqd, Vdq, Hdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_32, TCG_COND_EQ)
+DEF_GEN_INSN3_GVEC(vpcmpeqd, Vqq, Hqq, Wqq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_32, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqq, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_64, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(vpcmpeqq, Vdq, Hdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_64, TCG_COND_EQ)
+DEF_GEN_INSN3_GVEC(vpcmpeqq, Vqq, Hqq, Wqq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_64, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpgtb, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_8, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtb, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_8, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(vpcmpgtb, Vdq, Hdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_8, TCG_COND_GT)
+DEF_GEN_INSN3_GVEC(vpcmpgtb, Vqq, Hqq, Wqq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_8, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtw, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_16, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtw, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_16, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(vpcmpgtw, Vdq, Hdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_16, TCG_COND_GT)
+DEF_GEN_INSN3_GVEC(vpcmpgtw, Vqq, Hqq, Wqq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_16, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtd, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_32, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtd, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_32, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(vpcmpgtd, Vdq, Hdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_32, TCG_COND_GT)
+DEF_GEN_INSN3_GVEC(vpcmpgtd, Vqq, Hqq, Wqq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_32, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtq, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_64, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(vpcmpgtq, Vdq, Hdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_64, TCG_COND_GT)
+DEF_GEN_INSN3_GVEC(vpcmpgtq, Vqq, Hqq, Wqq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_64, TCG_COND_GT)
 
 DEF_GEN_INSN3_HELPER_EPPI(pcmpestrm, pcmpestrm_xmm, Vdq, Wdq, Ib)
 DEF_GEN_INSN3_HELPER_EPPI(vpcmpestrm, pcmpestrm_xmm, Vdq, Wdq, Ib)
@@ -6785,6 +6859,7 @@ DEF_GEN_INSN2_HELPER_EPP(vucomisd, ucomisd, Vq, Wq)
 DEF_GEN_INSN3_GVEC(pand, Pq, Pq, Qq, and, MM_OPRSZ, MM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(pand, Vdq, Vdq, Wdq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(vpand, Vdq, Hdq, Wdq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vpand, Vqq, Hqq, Wqq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(andps, Vdq, Vdq, Wdq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(vandps, Vdq, Hdq, Wdq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(vandps, Vqq, Hqq, Wqq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
@@ -6794,6 +6869,7 @@ DEF_GEN_INSN3_GVEC(vandpd, Vqq, Hqq, Wqq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(pandn, Pq, Pq, Qq, andn, MM_OPRSZ, MM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(pandn, Vdq, Vdq, Wdq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(vpandn, Vdq, Hdq, Wdq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vpandn, Vqq, Hqq, Wqq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(andnps, Vdq, Vdq, Wdq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(vandnps, Vdq, Hdq, Wdq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(vandnps, Vqq, Hqq, Wqq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
@@ -6803,6 +6879,7 @@ DEF_GEN_INSN3_GVEC(vandnpd, Vqq, Hqq, Wqq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(por, Pq, Pq, Qq, or, MM_OPRSZ, MM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(por, Vdq, Vdq, Wdq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(vpor, Vdq, Hdq, Wdq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vpor, Vqq, Hqq, Wqq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(orps, Vdq, Vdq, Wdq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(vorps, Vdq, Hdq, Wdq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(vorps, Vqq, Hqq, Wqq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
@@ -6812,6 +6889,7 @@ DEF_GEN_INSN3_GVEC(vorpd, Vqq, Hqq, Wqq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(pxor, Pq, Pq, Qq, xor, MM_OPRSZ, MM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(pxor, Vdq, Vdq, Wdq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(vpxor, Vdq, Hdq, Wdq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vpxor, Vqq, Hqq, Wqq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(xorps, Vdq, Vdq, Wdq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(vxorps, Vdq, Hdq, Wdq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(vxorps, Vqq, Hqq, Wqq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
@@ -6822,31 +6900,88 @@ DEF_GEN_INSN3_GVEC(vxorpd, Vqq, Hqq, Wqq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_HELPER_EPP(psllw, psllw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psllw, psllw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpsllw, psllw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsllw, psllw_xmm, Vqq, Hqq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pslld, pslld_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pslld, pslld_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpslld, pslld_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpslld, pslld_xmm, Vqq, Hqq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psllq, psllq_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psllq, psllq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpsllq, psllq_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsllq, psllq_xmm, Vqq, Hqq, Wdq)
+
+GEN_INSN3(vpsllvd, Vdq, Hdq, Wdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpsllvd, Vqq, Hqq, Wqq)
+{
+    /* XXX TODO implement this */
+}
+
+GEN_INSN3(vpsllvq, Vdq, Hdq, Wdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpsllvq, Vqq, Hqq, Wqq)
+{
+    /* XXX TODO implement this */
+}
+
 DEF_GEN_INSN3_HELPER_EPP(pslldq, pslldq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpslldq, pslldq_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpslldq, pslldq_xmm, Vqq, Hqq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psrlw, psrlw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psrlw, psrlw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpsrlw, psrlw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsrlw, psrlw_xmm, Vqq, Hqq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psrld, psrld_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psrld, psrld_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpsrld, psrld_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsrld, psrld_xmm, Vqq, Hqq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psrlq, psrlq_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psrlq, psrlq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpsrlq, psrlq_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsrlq, psrlq_xmm, Vqq, Hqq, Wdq)
+
+GEN_INSN3(vpsrlvd, Vdq, Hdq, Wdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpsrlvd, Vqq, Hqq, Wqq)
+{
+    /* XXX TODO implement this */
+}
+
+GEN_INSN3(vpsrlvq, Vdq, Hdq, Wdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpsrlvq, Vqq, Hqq, Wqq)
+{
+    /* XXX TODO implement this */
+}
+
 DEF_GEN_INSN3_HELPER_EPP(psrldq, psrldq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpsrldq, psrldq_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsrldq, psrldq_xmm, Vqq, Hqq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psraw, psraw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psraw, psraw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpsraw, psraw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsraw, psraw_xmm, Vqq, Hqq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psrad, psrad_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psrad, psrad_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpsrad, psrad_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsrad, psrad_xmm, Vqq, Hqq, Wdq)
+
+GEN_INSN3(vpsravd, Vdq, Hdq, Wdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpsravd, Vqq, Hqq, Wqq)
+{
+    /* XXX TODO implement this */
+}
 
 #define DEF_GEN_PSHIFT_IMM_MM(mnem, opT1, opT2)                         \
     GEN_INSN3(mnem, opT1, opT2, Ib)                                     \
@@ -6884,73 +7019,108 @@ DEF_GEN_INSN3_HELPER_EPP(vpsrad, psrad_xmm, Vdq, Hdq, Wdq)
         gen_insn2(movq, Vdq, Eq)(env, s, arg3_xmm, arg3_r64);           \
         gen_insn3(mnem, Vdq, Hdq, Wdq)(env, s, arg2, arg2, arg3_xmm);   \
     }
+#define DEF_GEN_VPSHIFT_IMM_YMM(mnem, opT1, opT2)                       \
+    GEN_INSN3(mnem, opT1, opT2, Ib)                                     \
+    {                                                                   \
+        const uint64_t arg3_ui64 = (uint8_t)arg3;                       \
+        const insnop_arg_t(Eq) arg3_r64 = s->tmp1_i64;                  \
+        const insnop_arg_t(Wdq) arg3_xmm =                              \
+            offsetof(CPUX86State, xmm_t0.ZMM_Q(0));                     \
+                                                                        \
+        tcg_gen_movi_i64(arg3_r64, arg3_ui64);                          \
+        gen_insn2(movq, Vdq, Eq)(env, s, arg3_xmm, arg3_r64);           \
+        gen_insn3(mnem, Vqq, Hqq, Wdq)(env, s, arg2, arg2, arg3_xmm);   \
+    }
 
 DEF_GEN_PSHIFT_IMM_MM(psllw, Nq, Nq)
 DEF_GEN_PSHIFT_IMM_XMM(psllw, Udq, Udq)
 DEF_GEN_VPSHIFT_IMM_XMM(vpsllw, Hdq, Udq)
+DEF_GEN_VPSHIFT_IMM_YMM(vpsllw, Hqq, Uqq)
 DEF_GEN_PSHIFT_IMM_MM(pslld, Nq, Nq)
 DEF_GEN_PSHIFT_IMM_XMM(pslld, Udq, Udq)
 DEF_GEN_VPSHIFT_IMM_XMM(vpslld, Hdq, Udq)
+DEF_GEN_VPSHIFT_IMM_YMM(vpslld, Hqq, Uqq)
 DEF_GEN_PSHIFT_IMM_MM(psllq, Nq, Nq)
 DEF_GEN_PSHIFT_IMM_XMM(psllq, Udq, Udq)
 DEF_GEN_VPSHIFT_IMM_XMM(vpsllq, Hdq, Udq)
+DEF_GEN_VPSHIFT_IMM_YMM(vpsllq, Hqq, Uqq)
 DEF_GEN_PSHIFT_IMM_XMM(pslldq, Udq, Udq)
 DEF_GEN_VPSHIFT_IMM_XMM(vpslldq, Hdq, Udq)
+DEF_GEN_VPSHIFT_IMM_YMM(vpslldq, Hqq, Uqq)
 DEF_GEN_PSHIFT_IMM_MM(psrlw, Nq, Nq)
 DEF_GEN_PSHIFT_IMM_XMM(psrlw, Udq, Udq)
 DEF_GEN_VPSHIFT_IMM_XMM(vpsrlw, Hdq, Udq)
+DEF_GEN_VPSHIFT_IMM_YMM(vpsrlw, Hqq, Uqq)
 DEF_GEN_PSHIFT_IMM_MM(psrld, Nq, Nq)
 DEF_GEN_PSHIFT_IMM_XMM(psrld, Udq, Udq)
 DEF_GEN_VPSHIFT_IMM_XMM(vpsrld, Hdq, Udq)
+DEF_GEN_VPSHIFT_IMM_YMM(vpsrld, Hqq, Uqq)
 DEF_GEN_PSHIFT_IMM_MM(psrlq, Nq, Nq)
 DEF_GEN_PSHIFT_IMM_XMM(psrlq, Udq, Udq)
 DEF_GEN_VPSHIFT_IMM_XMM(vpsrlq, Hdq, Udq)
+DEF_GEN_VPSHIFT_IMM_YMM(vpsrlq, Hqq, Uqq)
 DEF_GEN_PSHIFT_IMM_XMM(psrldq, Udq, Udq)
 DEF_GEN_VPSHIFT_IMM_XMM(vpsrldq, Hdq, Udq)
+DEF_GEN_VPSHIFT_IMM_YMM(vpsrldq, Hqq, Uqq)
 DEF_GEN_PSHIFT_IMM_MM(psraw, Nq, Nq)
 DEF_GEN_PSHIFT_IMM_XMM(psraw, Udq, Udq)
 DEF_GEN_VPSHIFT_IMM_XMM(vpsraw, Hdq, Udq)
+DEF_GEN_VPSHIFT_IMM_XMM(vpsraw, Hqq, Uqq)
 DEF_GEN_PSHIFT_IMM_MM(psrad, Nq, Nq)
 DEF_GEN_PSHIFT_IMM_XMM(psrad, Udq, Udq)
 DEF_GEN_VPSHIFT_IMM_XMM(vpsrad, Hdq, Udq)
+DEF_GEN_VPSHIFT_IMM_XMM(vpsrad, Hqq, Uqq)
 
 DEF_GEN_INSN4_HELPER_EPPI(palignr, palignr_mmx, Pq, Pq, Qq, Ib)
 DEF_GEN_INSN4_HELPER_EPPI(palignr, palignr_xmm, Vdq, Vdq, Wdq, Ib)
 DEF_GEN_INSN4_HELPER_EPPI(vpalignr, palignr_xmm, Vdq, Hdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(vpalignr, palignr_xmm, Vqq, Hqq, Wqq, Ib)
 
 DEF_GEN_INSN3_HELPER_EPP(packsswb, packsswb_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(packsswb, packsswb_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpacksswb, packsswb_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpacksswb, packsswb_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(packssdw, packssdw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(packssdw, packssdw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpackssdw, packssdw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpackssdw, packssdw_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(packuswb, packuswb_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(packuswb, packuswb_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpackuswb, packuswb_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpackuswb, packuswb_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(packusdw, packusdw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpackusdw, packusdw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpackusdw, packusdw_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(punpcklbw, punpcklbw_mmx, Pq, Pq, Qd)
 DEF_GEN_INSN3_HELPER_EPP(punpcklbw, punpcklbw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpunpcklbw, punpcklbw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpunpcklbw, punpcklbw_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(punpcklwd, punpcklwd_mmx, Pq, Pq, Qd)
 DEF_GEN_INSN3_HELPER_EPP(punpcklwd, punpcklwd_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpunpcklwd, punpcklwd_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpunpcklwd, punpcklwd_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(punpckldq, punpckldq_mmx, Pq, Pq, Qd)
 DEF_GEN_INSN3_HELPER_EPP(punpckldq, punpckldq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpunpckldq, punpckldq_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpunpckldq, punpckldq_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(punpcklqdq, punpcklqdq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpunpcklqdq, punpcklqdq_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpunpcklqdq, punpcklqdq_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhbw, punpckhbw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhbw, punpckhbw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpunpckhbw, punpckhbw_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpunpckhbw, punpckhbw_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhwd, punpckhwd_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhwd, punpckhwd_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpunpckhwd, punpckhwd_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpunpckhwd, punpckhwd_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhdq, punpckhdq_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhdq, punpckhdq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpunpckhdq, punpckhdq_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpunpckhdq, punpckhdq_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhqdq, punpckhqdq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpunpckhqdq, punpckhqdq_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpunpckhqdq, punpckhqdq_xmm, Vqq, Hqq, Wqq)
 
 DEF_GEN_INSN3_HELPER_EPP(unpcklps, punpckldq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vunpcklps, punpckldq_xmm, Vdq, Hdq, Wdq)
@@ -6968,13 +7138,17 @@ DEF_GEN_INSN3_HELPER_EPP(vunpckhpd, punpckhqdq_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(pshufb, pshufb_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pshufb, pshufb_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpshufb, pshufb_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpshufb, pshufb_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_PPI(pshufw, pshufw_mmx, Pq, Qq, Ib)
 DEF_GEN_INSN3_HELPER_PPI(pshuflw, pshuflw_xmm, Vdq, Wdq, Ib)
 DEF_GEN_INSN3_HELPER_PPI(vpshuflw, pshuflw_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_PPI(vpshuflw, pshuflw_xmm, Vqq, Wqq, Ib)
 DEF_GEN_INSN3_HELPER_PPI(pshufhw, pshufhw_xmm, Vdq, Wdq, Ib)
 DEF_GEN_INSN3_HELPER_PPI(vpshufhw, pshufhw_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_PPI(vpshufhw, pshufhw_xmm, Vqq, Wqq, Ib)
 DEF_GEN_INSN3_HELPER_PPI(pshufd, pshufd_xmm, Vdq, Wdq, Ib)
 DEF_GEN_INSN3_HELPER_PPI(vpshufd, pshufd_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_PPI(vpshufd, pshufd_xmm, Vqq, Wqq, Ib)
 DEF_GEN_INSN4_HELPER_PPI(shufps, shufps, Vdq, Vdq, Wdq, Ib)
 DEF_GEN_INSN4_HELPER_PPI(vshufps, shufps, Vdq, Hdq, Wdq, Ib)
 DEF_GEN_INSN4_HELPER_PPI(vshufps, shufps, Vqq, Hqq, Wqq, Ib)
@@ -7014,9 +7188,23 @@ GEN_INSN4(vpblendvb, Vdq, Hdq, Wdq, Ldq)
 {
     gen_insn3(pblendvb, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
 }
+GEN_INSN4(vpblendvb, Vqq, Hqq, Wqq, Lqq)
+{
+    gen_insn3(pblendvb, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+}
 
 DEF_GEN_INSN4_HELPER_EPPI(pblendw, pblendw_xmm, Vdq, Vdq, Wdq, Ib)
 DEF_GEN_INSN4_HELPER_EPPI(vpblendw, pblendw_xmm, Vdq, Hdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(vpblendw, pblendw_xmm, Vqq, Hqq, Wqq, Ib)
+
+GEN_INSN4(vpblendd, Vdq, Hdq, Wdq, Ib)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN4(vpblendd, Vqq, Hqq, Wqq, Ib)
+{
+    /* XXX TODO implement this */
+}
 
 GEN_INSN4(insertps, Vdq, Vdq, Wd, Ib)
 {
@@ -7100,6 +7288,10 @@ GEN_INSN4(vinsertf128, Vqq, Hqq, Wdq, Ib)
 {
     gen_insn2(movaps, Vdq, Wdq)(env, s, arg1, arg3);
 }
+GEN_INSN4(vinserti128, Vqq, Hqq, Wdq, Ib)
+{
+    gen_insn2(movaps, Vdq, Wdq)(env, s, arg1, arg3);
+}
 
 GEN_INSN3(extractps, Ed, Vdq, Ib)
 {
@@ -7178,42 +7370,106 @@ GEN_INSN3(vextractf128, Wdq, Vqq, Ib)
 {
     gen_insn2(movaps, Wdq, Vdq)(env, s, arg1, arg2);
 }
+GEN_INSN3(vextracti128, Wdq, Vqq, Ib)
+{
+    gen_insn2(movaps, Wdq, Vdq)(env, s, arg1, arg2);
+}
 
-GEN_INSN2(vbroadcastss, Vdq, Md)
+GEN_INSN2(vpbroadcastb, Vdq, Wb)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN2(vpbroadcastb, Vqq, Wb)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN2(vpbroadcastw, Vdq, Ww)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN2(vpbroadcastw, Vqq, Ww)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN2(vpbroadcastd, Vdq, Wd)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN2(vpbroadcastd, Vqq, Wd)
 {
+    /* XXX TODO implement this */
+}
+GEN_INSN2(vpbroadcastq, Vdq, Wq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN2(vpbroadcastq, Vqq, Wq)
+{
+    /* XXX TODO implement this */
+}
+
+GEN_INSN3(vbroadcastss, Vdq, Wd, modrm_mod)
+{
+    if (arg3 != 3 && !check_cpuid(env, s, CHECK_CPUID_AVX2)) {
+        gen_unknown_opcode(env, s);
+        return;
+    }
+
     const TCGv_i32 r32 = tcg_temp_new_i32();
-    insnop_ldst(tcg_i32, Md)(env, s, 0, r32, arg2);
-
-    tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(0)));
+    tcg_gen_ld_i32(r32, cpu_env, arg2 + offsetof(ZMMReg, ZMM_L(0)));
+    if (arg1 != arg2) {
+        tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(0)));
+    }
     tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(1)));
     tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(2)));
     tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(3)));
-
     tcg_temp_free_i32(r32);
 }
-GEN_INSN2(vbroadcastss, Vqq, Md)
+GEN_INSN3(vbroadcastss, Vqq, Wd, modrm_mod)
 {
-    gen_insn2(vbroadcastss, Vdq, Md)(env, s, arg1, arg2);
+    gen_insn3(vbroadcastss, Vdq, Wd, modrm_mod)(env, s, arg1, arg2, arg3);
 }
-GEN_INSN2(vbroadcastsd, Vqq, Mq)
+GEN_INSN3(vbroadcastsd, Vqq, Wq, modrm_mod)
 {
+    if (arg3 != 3 && !check_cpuid(env, s, CHECK_CPUID_AVX2)) {
+        gen_unknown_opcode(env, s);
+        return;
+    }
+
     const TCGv_i64 r64 = tcg_temp_new_i64();
-    insnop_ldst(tcg_i64, Mq)(env, s, 0, r64, arg2);
-
-    tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(0)));
+    tcg_gen_ld_i64(r64, cpu_env, arg2 + offsetof(ZMMReg, ZMM_Q(0)));
+    if (arg1 != arg2) {
+        tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(0)));
+    }
     tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(1)));
-
     tcg_temp_free_i64(r64);
 }
 GEN_INSN2(vbroadcastf128, Vqq, Mdq)
 {
     insnop_ldst(xmm, Mqq)(env, s, 0, arg1, arg2);
 }
+GEN_INSN2(vbroadcasti128, Vqq, Mdq)
+{
+    insnop_ldst(xmm, Mqq)(env, s, 0, arg1, arg2);
+}
 
 GEN_INSN4(vperm2f128, Vqq, Hqq, Wqq, Ib)
 {
     /* XXX TODO implement this */
 }
+GEN_INSN4(vperm2i128, Vqq, Hqq, Wqq, Ib)
+{
+    /* XXX TODO implement this */
+}
+
+GEN_INSN3(vpermd, Vqq, Hqq, Wqq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpermps, Vqq, Hqq, Wqq)
+{
+    /* XXX TODO implement this */
+}
 
 GEN_INSN3(vpermilps, Vdq, Hdq, Wdq)
 {
@@ -7249,30 +7505,119 @@ GEN_INSN3(vpermilpd, Vqq, Wqq, Ib)
     /* XXX TODO implement this */
 }
 
+GEN_INSN3(vpermq, Vqq, Wqq, Ib)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpermpd, Vqq, Wqq, Ib)
+{
+    /* XXX TODO implement this */
+}
+
+GEN_INSN5(vgatherdps, Vdq, Hdq, Vdq, MDdq, Hdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN5(vgatherdps, Vqq, Hqq, Vqq, MDqq, Hqq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN5(vgatherdpd, Vdq, Hdq, Vdq, MDdq, Hdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN5(vgatherdpd, Vqq, Hqq, Vqq, MDdq, Hqq)
+{
+    /* XXX TODO implement this */
+}
+
+GEN_INSN5(vgatherqps, Vdq, Hdq, Vdq, MQdq, Hdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN5(vgatherqps, Vdq, Hdq, Vdq, MQqq, Hdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN5(vgatherqpd, Vdq, Hdq, Vdq, MQdq, Hdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN5(vgatherqpd, Vqq, Hqq, Vqq, MQqq, Hqq)
+{
+    /* XXX TODO implement this */
+}
+
+GEN_INSN5(vpgatherdd, Vdq, Hdq, Vdq, MDdq, Hdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN5(vpgatherdd, Vqq, Hqq, Vqq, MDqq, Hqq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN5(vpgatherdq, Vdq, Hdq, Vdq, MDdq, Hdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN5(vpgatherdq, Vqq, Hqq, Vqq, MDdq, Hqq)
+{
+    /* XXX TODO implement this */
+}
+
+GEN_INSN5(vpgatherqd, Vdq, Hdq, Vdq, MQdq, Hdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN5(vpgatherqd, Vdq, Hdq, Vdq, MQqq, Hdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN5(vpgatherqq, Vdq, Hdq, Vdq, MQdq, Hdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN5(vpgatherqq, Vqq, Hqq, Vqq, MQqq, Hqq)
+{
+    /* XXX TODO implement this */
+}
+
 DEF_GEN_INSN2_HELPER_EPP(pmovsxbw, pmovsxbw_xmm, Vdq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(vpmovsxbw, pmovsxbw_xmm, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(vpmovsxbw, pmovsxbw_xmm, Vqq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(pmovsxbd, pmovsxbd_xmm, Vdq, Wd)
 DEF_GEN_INSN2_HELPER_EPP(vpmovsxbd, pmovsxbd_xmm, Vdq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(vpmovsxbd, pmovsxbd_xmm, Vqq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(pmovsxbq, pmovsxbq_xmm, Vdq, Ww)
 DEF_GEN_INSN2_HELPER_EPP(vpmovsxbq, pmovsxbq_xmm, Vdq, Ww)
+DEF_GEN_INSN2_HELPER_EPP(vpmovsxbq, pmovsxbq_xmm, Vqq, Wd)
 DEF_GEN_INSN2_HELPER_EPP(pmovsxwd, pmovsxwd_xmm, Vdq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(vpmovsxwd, pmovsxwd_xmm, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(vpmovsxwd, pmovsxwd_xmm, Vqq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(pmovsxwq, pmovsxwq_xmm, Vdq, Wd)
 DEF_GEN_INSN2_HELPER_EPP(vpmovsxwq, pmovsxwq_xmm, Vdq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(vpmovsxwq, pmovsxwq_xmm, Vqq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(pmovsxdq, pmovsxdq_xmm, Vdq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(vpmovsxdq, pmovsxdq_xmm, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(vpmovsxdq, pmovsxdq_xmm, Vqq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(pmovzxbw, pmovzxbw_xmm, Vdq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(vpmovzxbw, pmovzxbw_xmm, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(vpmovzxbw, pmovzxbw_xmm, Vqq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(pmovzxbd, pmovzxbd_xmm, Vdq, Wd)
 DEF_GEN_INSN2_HELPER_EPP(vpmovzxbd, pmovzxbd_xmm, Vdq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(vpmovzxbd, pmovzxbd_xmm, Vqq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(pmovzxbq, pmovzxbq_xmm, Vdq, Ww)
 DEF_GEN_INSN2_HELPER_EPP(vpmovzxbq, pmovzxbq_xmm, Vdq, Ww)
+DEF_GEN_INSN2_HELPER_EPP(vpmovzxbq, pmovzxbq_xmm, Vqq, Wd)
 DEF_GEN_INSN2_HELPER_EPP(pmovzxwd, pmovzxwd_xmm, Vdq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(vpmovzxwd, pmovzxwd_xmm, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(vpmovzxwd, pmovzxwd_xmm, Vqq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(pmovzxwq, pmovzxwq_xmm, Vdq, Wd)
 DEF_GEN_INSN2_HELPER_EPP(vpmovzxwq, pmovzxwq_xmm, Vdq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(vpmovzxwq, pmovzxwq_xmm, Vqq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(pmovzxdq, pmovzxdq_xmm, Vdq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(vpmovzxdq, pmovzxdq_xmm, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(vpmovzxdq, pmovzxdq_xmm, Vqq, Wdq)
 
 DEF_GEN_INSN2_HELPER_EPP(cvtpi2ps, cvtpi2ps, Vdq, Qq)
 DEF_GEN_INSN2_HELPER_EPD(cvtsi2ss, cvtsi2ss, Vd, Ed)
@@ -7405,6 +7750,40 @@ GEN_INSN3(vmaskmovpd, Mqq, Hqq, Vqq)
     /* XXX TODO implement this */
 }
 
+GEN_INSN3(vpmaskmovd, Vdq, Hdq, Mdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpmaskmovd, Mdq, Hdq, Vdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpmaskmovd, Vqq, Hqq, Mqq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpmaskmovd, Mqq, Hqq, Vqq)
+{
+    /* XXX TODO implement this */
+}
+
+GEN_INSN3(vpmaskmovq, Vdq, Hdq, Mdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpmaskmovq, Mdq, Hdq, Vdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpmaskmovq, Vqq, Hqq, Mqq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpmaskmovq, Mqq, Hqq, Vqq)
+{
+    /* XXX TODO implement this */
+}
+
 GEN_INSN2(movntps, Mdq, Vdq)
 {
     insnop_ldst(xmm, Mdq)(env, s, 1, arg2, arg1);
@@ -7465,6 +7844,10 @@ GEN_INSN2(vmovntdqa, Vdq, Mdq)
 {
     gen_insn2(movntdqa, Vdq, Mdq)(env, s, arg1, arg2);
 }
+GEN_INSN2(vmovntdqa, Vqq, Mqq)
+{
+    gen_insn2(movntdqa, Vdq, Mdq)(env, s, arg1, arg2);
+}
 
 GEN_INSN0(pause)
 {
-- 
2.20.1


