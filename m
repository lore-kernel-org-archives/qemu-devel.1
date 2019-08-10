Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D2AC32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B850217F4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qW1G6qup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B850217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIx1-00018c-Ci
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34974)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIlC-0006fx-4f
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIlA-0004Zi-Nm
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:42 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39416)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIlA-0004Yj-Iw
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:40 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so134538234otq.6
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5KJp6fDGEapB7Oa0h5gCt36vaEKl48jVrNFLmkspytg=;
 b=qW1G6qupmBScX5o+Os1/qzWQBKa+apNYY2El1hoLsrqTQNsgHotSNXehy+5A0hVlJp
 1kn5MYY3V+1OBB5Hm7Ve0okJ7k0PR8lGAeYxqIfPeWJ3rh/Y9iVhgvbD21e6EYmaJuBG
 r3B4YxhMpkorBTjV+E4WF7UKck4y+NtpRVgnCGuC9voMzqy39b5qhU20bS+fUpSaOBR4
 XWOsUHaoyg4fP/U4b0XpiaR/eS92QaaWlYWCpSqVSDqkyuFaM2d3L5TZHRkXAy7sTV+z
 RUefzfP2PIVAqGzRrW7cwQHu8dG/8IDgkZRZCl4KhbPGcruERGC5FL2VNDG5N1tRWo/N
 U0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5KJp6fDGEapB7Oa0h5gCt36vaEKl48jVrNFLmkspytg=;
 b=twanELLfmkWVWbxziYTST8O6EmsisQDcZtPVV+bG0/fynQMg/6xCnDp3pYxUxp/Btj
 8tcXnlYVzmJ/6ZdLQkDw3fL6erDk0iaQl0JuAwHki5vZjFgHSK16v8HR4BZk5X0eTmn9
 /6kNlsvWnrA1wU+MJhOylHPPpFYR07mYNXFKizRZODClHoAtOk/FA9c25ENDVwjmvEwb
 Dg3ZDLTVvhns3drF0m4ve2VFBiUG7DMT6NskHR8IsHdMpvdJz8FOlSjZt9+FRdS65+Zg
 Th5L7p8BxhxMkZDqwiq0GZZoeQ0sTwzX3PW+fpBHK78k5gq/FuA6pWfAhMMj/YKSzRRz
 2aJg==
X-Gm-Message-State: APjAAAXNVM64ytci27aTFDRCh6A0IdEvjIzMRtLOGVKH0eoxZeuwC0mm
 Hu4B/F4cciaPfS9KVwKUepSE+IAt
X-Google-Smtp-Source: APXvYqwK03aD/obPTZ9gjDYdO/GFTZ1sZUH9uZ4xx10WJ7/UDTAb+rpC9opPKJkXZLfSPxNmWnXIhQ==
X-Received: by 2002:a9d:27c3:: with SMTP id c61mr19170013otb.291.1565410419789; 
 Fri, 09 Aug 2019 21:13:39 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:39 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:49 -0400
Message-Id: <20190810041255.6820-34-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: [Qemu-devel] [RFC PATCH v2 33/39] target/i386: introduce MMX
 instructions to insn.h
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

Add all MMX instruction entries to insn.h.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/insn.h | 131 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/target/i386/insn.h b/target/i386/insn.h
index 4b48c0c0e1..6506ff3137 100644
--- a/target/i386/insn.h
+++ b/target/i386/insn.h
@@ -66,6 +66,137 @@
 #   define INSN_GRP_END(grpname)
 #endif /* INSN_GRP_END */
 
+/* NP 0F 6E /r: MOVD mm,r/m32 */
+INSN_WR(movd, LEG(NP, 0F, 0), 0x6e, MMX, Pq, Ed)
+/* NP 0F 7E /r: MOVD r/m32,mm */
+INSN_WR(movd, LEG(NP, 0F, 0), 0x7e, MMX, Ed, Pq)
+/* NP REX.W + 0F 6E /r: MOVQ mm,r/m64 */
+INSN_WR(movq, LEG(NP, 0F, 1), 0x6e, MMX, Pq, Eq)
+/* NP REX.W + 0F 7E /r: MOVQ r/m64,mm */
+INSN_WR(movq, LEG(NP, 0F, 1), 0x7e, MMX, Eq, Pq)
+/* NP 0F 6F /r: MOVQ mm, mm/m64 */
+INSN_WR(movq, LEG(NP, 0F, 0), 0x6f, MMX, Pq, Qq)
+/* NP 0F 7F /r: MOVQ mm/m64, mm */
+INSN_WR(movq, LEG(NP, 0F, 0), 0x7f, MMX, Qq, Pq)
+/* NP 0F FC /r: PADDB mm, mm/m64 */
+INSN_WRR(paddb, LEG(NP, 0F, 0), 0xfc, MMX, Pq, Pq, Qq)
+/* NP 0F FD /r: PADDW mm, mm/m64 */
+INSN_WRR(paddw, LEG(NP, 0F, 0), 0xfd, MMX, Pq, Pq, Qq)
+/* NP 0F FE /r: PADDD mm, mm/m64 */
+INSN_WRR(paddd, LEG(NP, 0F, 0), 0xfe, MMX, Pq, Pq, Qq)
+/* NP 0F EC /r: PADDSB mm, mm/m64 */
+INSN_WRR(paddsb, LEG(NP, 0F, 0), 0xec, MMX, Pq, Pq, Qq)
+/* NP 0F ED /r: PADDSW mm, mm/m64 */
+INSN_WRR(paddsw, LEG(NP, 0F, 0), 0xed, MMX, Pq, Pq, Qq)
+/* NP 0F DC /r: PADDUSB mm,mm/m64 */
+INSN_WRR(paddusb, LEG(NP, 0F, 0), 0xdc, MMX, Pq, Pq, Qq)
+/* NP 0F DD /r: PADDUSW mm,mm/m64 */
+INSN_WRR(paddusw, LEG(NP, 0F, 0), 0xdd, MMX, Pq, Pq, Qq)
+/* NP 0F F8 /r: PSUBB mm, mm/m64 */
+INSN_WRR(psubb, LEG(NP, 0F, 0), 0xf8, MMX, Pq, Pq, Qq)
+/* NP 0F F9 /r: PSUBW mm, mm/m64 */
+INSN_WRR(psubw, LEG(NP, 0F, 0), 0xf9, MMX, Pq, Pq, Qq)
+/* NP 0F FA /r: PSUBD mm, mm/m64 */
+INSN_WRR(psubd, LEG(NP, 0F, 0), 0xfa, MMX, Pq, Pq, Qq)
+/* NP 0F E8 /r: PSUBSB mm, mm/m64 */
+INSN_WRR(psubsb, LEG(NP, 0F, 0), 0xe8, MMX, Pq, Pq, Qq)
+/* NP 0F E9 /r: PSUBSW mm, mm/m64 */
+INSN_WRR(psubsw, LEG(NP, 0F, 0), 0xe9, MMX, Pq, Pq, Qq)
+/* NP 0F D8 /r: PSUBUSB mm, mm/m64 */
+INSN_WRR(psubusb, LEG(NP, 0F, 0), 0xd8, MMX, Pq, Pq, Qq)
+/* NP 0F D9 /r: PSUBUSW mm, mm/m64 */
+INSN_WRR(psubusw, LEG(NP, 0F, 0), 0xd9, MMX, Pq, Pq, Qq)
+/* NP 0F D5 /r: PMULLW mm, mm/m64 */
+INSN_WRR(pmullw, LEG(NP, 0F, 0), 0xd5, MMX, Pq, Pq, Qq)
+/* NP 0F E5 /r: PMULHW mm, mm/m64 */
+INSN_WRR(pmulhw, LEG(NP, 0F, 0), 0xe5, MMX, Pq, Pq, Qq)
+/* NP 0F F5 /r: PMADDWD mm, mm/m64 */
+INSN_WRR(pmaddwd, LEG(NP, 0F, 0), 0xf5, MMX, Pq, Pq, Qq)
+/* NP 0F 74 /r: PCMPEQB mm,mm/m64 */
+INSN_WRR(pcmpeqb, LEG(NP, 0F, 0), 0x74, MMX, Pq, Pq, Qq)
+/* NP 0F 75 /r: PCMPEQW mm,mm/m64 */
+INSN_WRR(pcmpeqw, LEG(NP, 0F, 0), 0x75, MMX, Pq, Pq, Qq)
+/* NP 0F 76 /r: PCMPEQD mm,mm/m64 */
+INSN_WRR(pcmpeqd, LEG(NP, 0F, 0), 0x76, MMX, Pq, Pq, Qq)
+/* NP 0F 64 /r: PCMPGTB mm,mm/m64 */
+INSN_WRR(pcmpgtb, LEG(NP, 0F, 0), 0x64, MMX, Pq, Pq, Qq)
+/* NP 0F 65 /r: PCMPGTW mm,mm/m64 */
+INSN_WRR(pcmpgtw, LEG(NP, 0F, 0), 0x65, MMX, Pq, Pq, Qq)
+/* NP 0F 66 /r: PCMPGTD mm,mm/m64 */
+INSN_WRR(pcmpgtd, LEG(NP, 0F, 0), 0x66, MMX, Pq, Pq, Qq)
+/* NP 0F DB /r: PAND mm, mm/m64 */
+INSN_WRR(pand, LEG(NP, 0F, 0), 0xdb, MMX, Pq, Pq, Qq)
+/* NP 0F DF /r: PANDN mm, mm/m64 */
+INSN_WRR(pandn, LEG(NP, 0F, 0), 0xdf, MMX, Pq, Pq, Qq)
+/* NP 0F EB /r: POR mm, mm/m64 */
+INSN_WRR(por, LEG(NP, 0F, 0), 0xeb, MMX, Pq, Pq, Qq)
+/* NP 0F EF /r: PXOR mm, mm/m64 */
+INSN_WRR(pxor, LEG(NP, 0F, 0), 0xef, MMX, Pq, Pq, Qq)
+/* NP 0F F1 /r: PSLLW mm, mm/m64 */
+INSN_WRR(psllw, LEG(NP, 0F, 0), 0xf1, MMX, Pq, Pq, Qq)
+/* NP 0F F2 /r: PSLLD mm, mm/m64 */
+INSN_WRR(pslld, LEG(NP, 0F, 0), 0xf2, MMX, Pq, Pq, Qq)
+/* NP 0F F3 /r: PSLLQ mm, mm/m64 */
+INSN_WRR(psllq, LEG(NP, 0F, 0), 0xf3, MMX, Pq, Pq, Qq)
+/* NP 0F D1 /r: PSRLW mm, mm/m64 */
+INSN_WRR(psrlw, LEG(NP, 0F, 0), 0xd1, MMX, Pq, Pq, Qq)
+/* NP 0F D2 /r: PSRLD mm, mm/m64 */
+INSN_WRR(psrld, LEG(NP, 0F, 0), 0xd2, MMX, Pq, Pq, Qq)
+/* NP 0F D3 /r: PSRLQ mm, mm/m64 */
+INSN_WRR(psrlq, LEG(NP, 0F, 0), 0xd3, MMX, Pq, Pq, Qq)
+/* NP 0F E1 /r: PSRAW mm,mm/m64 */
+INSN_WRR(psraw, LEG(NP, 0F, 0), 0xe1, MMX, Pq, Pq, Qq)
+/* NP 0F E2 /r: PSRAD mm,mm/m64 */
+INSN_WRR(psrad, LEG(NP, 0F, 0), 0xe2, MMX, Pq, Pq, Qq)
+/* NP 0F 63 /r: PACKSSWB mm1, mm2/m64 */
+INSN_WRR(packsswb, LEG(NP, 0F, 0), 0x63, MMX, Pq, Pq, Qq)
+/* NP 0F 6B /r: PACKSSDW mm1, mm2/m64 */
+INSN_WRR(packssdw, LEG(NP, 0F, 0), 0x6b, MMX, Pq, Pq, Qq)
+/* NP 0F 67 /r: PACKUSWB mm, mm/m64 */
+INSN_WRR(packuswb, LEG(NP, 0F, 0), 0x67, MMX, Pq, Pq, Qq)
+/* NP 0F 68 /r: PUNPCKHBW mm, mm/m64 */
+INSN_WRR(punpckhbw, LEG(NP, 0F, 0), 0x68, MMX, Pq, Pq, Qq)
+/* NP 0F 69 /r: PUNPCKHWD mm, mm/m64 */
+INSN_WRR(punpckhwd, LEG(NP, 0F, 0), 0x69, MMX, Pq, Pq, Qq)
+/* NP 0F 6A /r: PUNPCKHDQ mm, mm/m64 */
+INSN_WRR(punpckhdq, LEG(NP, 0F, 0), 0x6a, MMX, Pq, Pq, Qq)
+/* NP 0F 60 /r: PUNPCKLBW mm, mm/m32 */
+INSN_WRR(punpcklbw, LEG(NP, 0F, 0), 0x60, MMX, Pq, Pq, Qd)
+/* NP 0F 61 /r: PUNPCKLWD mm, mm/m32 */
+INSN_WRR(punpcklwd, LEG(NP, 0F, 0), 0x61, MMX, Pq, Pq, Qd)
+/* NP 0F 62 /r: PUNPCKLDQ mm, mm/m32 */
+INSN_WRR(punpckldq, LEG(NP, 0F, 0), 0x62, MMX, Pq, Pq, Qd)
+/* NP 0F 77: EMMS */
+INSN(emms, LEG(NP, 0F, 0), 0x77, MMX)
+
+INSN_GRP(grp12_LEG_NP, LEG(NP, 0F, 0), 0x71)
+INSN_GRP_BEGIN(grp12_LEG_NP)
+    /* NP 0F 71 /6 ib: PSLLW mm1, imm8 */
+    INSN_GRPMEMB_WRR(grp12_LEG_NP, psllw, 6, MMX, Nq, Nq, Ib)
+    /* NP 0F 71 /2 ib: PSRLW mm, imm8 */
+    INSN_GRPMEMB_WRR(grp12_LEG_NP, psrlw, 2, MMX, Nq, Nq, Ib)
+    /* NP 0F 71 /4 ib: PSRAW mm,imm8 */
+    INSN_GRPMEMB_WRR(grp12_LEG_NP, psraw, 4, MMX, Nq, Nq, Ib)
+INSN_GRP_END(grp12_LEG_NP)
+
+INSN_GRP(grp13_LEG_NP, LEG(NP, 0F, 0), 0x72)
+INSN_GRP_BEGIN(grp13_LEG_NP)
+    /* NP 0F 72 /6 ib: PSLLD mm, imm8 */
+    INSN_GRPMEMB_WRR(grp13_LEG_NP, pslld, 6, MMX, Nq, Nq, Ib)
+    /* NP 0F 72 /2 ib: PSRLD mm, imm8 */
+    INSN_GRPMEMB_WRR(grp13_LEG_NP, psrld, 2, MMX, Nq, Nq, Ib)
+    /* NP 0F 72 /4 ib: PSRAD mm,imm8 */
+    INSN_GRPMEMB_WRR(grp13_LEG_NP, psrad, 4, MMX, Nq, Nq, Ib)
+INSN_GRP_END(grp13_LEG_NP)
+
+INSN_GRP(grp14_LEG_NP, LEG(NP, 0F, 0), 0x73)
+INSN_GRP_BEGIN(grp14_LEG_NP)
+    /* NP 0F 73 /6 ib: PSLLQ mm, imm8 */
+    INSN_GRPMEMB_WRR(grp14_LEG_NP, psllq, 6, MMX, Nq, Nq, Ib)
+    /* NP 0F 73 /2 ib: PSRLQ mm, imm8 */
+    INSN_GRPMEMB_WRR(grp14_LEG_NP, psrlq, 2, MMX, Nq, Nq, Ib)
+INSN_GRP_END(grp14_LEG_NP)
+
 #undef LEG
 #undef VEX
 #undef INSN
-- 
2.20.1


