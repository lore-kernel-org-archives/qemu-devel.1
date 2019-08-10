Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EC0C32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B58217F4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGpsfdaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B58217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwJ0C-00069s-5K
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35047)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIlI-00070M-FK
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIlH-0004mq-Cy
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:48 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIlH-0004mR-8k
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:47 -0400
Received: by mail-ot1-x342.google.com with SMTP id l15so140516469otn.9
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ORYsNUP5X43haVcteZ8oI+Qz8mSDMdaq3Ei5edtuVYc=;
 b=fGpsfdaT1g3KyZeMeRpQetLL0l6QOz7CIyvX2laGsVcrebhBfVo3uzfqgTnt8t89Sp
 rpI9YRqOY9daKcm5qsZDA/11+ZuxRNsrjb/Uxxyxv5L6Bw5/nrpk3SgjCnn2/c0izLny
 nsx4Fm9TEHPvzrLH2O8JuTeYXuXcDd3ZnSn9L1zibemPZR8l7dIHhfgEE/y+kacmz338
 nFUYOv48u+luG+GGA/LWj5Qmy+cX655LBXgDpH1+OuqkFcIYKSZt9IA4eJr08MthlJzP
 sJaIV63sl1vN0CXDdVFb486xIMBGwEZtDEauiu1se4hEETM+XxMynWVTTWC0rKuDZdLM
 4C2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ORYsNUP5X43haVcteZ8oI+Qz8mSDMdaq3Ei5edtuVYc=;
 b=dSlAvPesS3aulBF0eGkAFkdVxIKkGybtFxlBlbtB2YxBHkCCQNMDRQvoGYppQRTas4
 hWtcGUmZqOQnc3eI9X1Zh2LLKabPQmcaNM3AfN4yxZthSQwA51z32Xz//A8ydlCdEeyT
 KmYxQx6hXb6YMeRjjbZfpnGDp7VgVO4sFv/8XdXrNB/oNefVG8ECbqD9OV0PItenQuLK
 mkhMHrimw26VD6Z1gMS5M7U1kukBalFlHusKLvpwJxKSRtFYA1kCI3GSlg6J+pbq79Vl
 Anvwuvf6He6LB1wZRYM9YOfgtBfiz+ogvHxZ/Y5g2IAtbbbLgulXpeeOoqja7ixeoEmE
 eo/Q==
X-Gm-Message-State: APjAAAV3l3NwBwfnC8tbrHzsEYYS4PmNDUSjIS+YtCnYOL3cYSEzX3iC
 x1GK1RY9aaKIO+y8LmSGGFXI8x7O
X-Google-Smtp-Source: APXvYqwFERvERI/w9s8gv5shlP8dL9u5BRd7WsJO0yTVozHqvubZtGAu2P++XRHR/0KP2sOmFYm4UA==
X-Received: by 2002:a9d:7741:: with SMTP id t1mr10594402otl.178.1565410426557; 
 Fri, 09 Aug 2019 21:13:46 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:46 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:55 -0400
Message-Id: <20190810041255.6820-40-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: [Qemu-devel] [RFC PATCH v2 39/39] target/i386: introduce
 memory-pointer operand read/write workarounds
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

The memory-pointer operand has a known limitation (see the commit
introducing M* operands for details); the workaround involves
declaring write-memory operands as read-memory instead.

Note: This changeset is intended for development only and shall not be
included in the final patch series.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/insn.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/i386/insn.h b/target/i386/insn.h
index 6e0c75b9f7..b61a4182f6 100644
--- a/target/i386/insn.h
+++ b/target/i386/insn.h
@@ -94,12 +94,14 @@ INSN_WR(movss, LEG(F3, 0F, 0), 0x11, SSE, Wd, Vd)
 /* NP 0F 12 /r: MOVLPS xmm1, m64 */
 INSN_WR(movhlps, LEG(NP, 0F, 0), 0x12, SSE, Vq, UdqMq)
 /* 0F 13 /r: MOVLPS m64, xmm1 */
-INSN_WR(movlps, LEG(NP, 0F, 0), 0x13, SSE, Mq, Vq)
+/* FIXME this is hacked, should be INSN_WR */
+INSN_RR(movlps, LEG(NP, 0F, 0), 0x13, SSE, Mq, Vq)
 /* NP 0F 16 /r: MOVLHPS xmm1, xmm2 */
 /* NP 0F 16 /r: MOVHPS xmm1, m64 */
 INSN_WRR(movlhps, LEG(NP, 0F, 0), 0x16, SSE, Vdq, Vq, UqMq)
 /* NP 0F 17 /r: MOVHPS m64, xmm1 */
-INSN_WR(movhps, LEG(NP, 0F, 0), 0x17, SSE, Mq, Vdq)
+/* FIXME this is hacked, should be INSN_WR */
+INSN_RR(movhps, LEG(NP, 0F, 0), 0x17, SSE, Mq, Vdq)
 /* NP 0F D7 /r: PMOVMSKB r32, mm */
 INSN_WR(pmovmskb, LEG(NP, 0F, 0), 0xd7, SSE, Gd, Nq)
 /* NP REX.W 0F D7 /r: PMOVMSKB r64, mm */
@@ -299,9 +301,11 @@ INSN_WR(cvttss2si, LEG(F3, 0F, 1), 0x2c, SSE, Gq, Wd)
 /* NP 0F F7 /r: MASKMOVQ mm1, mm2 */
 INSN_RR(maskmovq, LEG(NP, 0F, 0), 0xf7, SSE, Pq, Nq)
 /* NP 0F 2B /r: MOVNTPS m128, xmm1 */
-INSN_WR(movntps, LEG(NP, 0F, 0), 0x2b, SSE, Mdq, Vdq)
+/* FIXME this is hacked, should be INSN_WR */
+INSN_RR(movntps, LEG(NP, 0F, 0), 0x2b, SSE, Mdq, Vdq)
 /* NP 0F E7 /r: MOVNTQ m64, mm */
-INSN_WR(movntq, LEG(NP, 0F, 0), 0xe7, SSE, Mq, Pq)
+/* FIXME this is hacked, should be INSN_WR */
+INSN_RR(movntq, LEG(NP, 0F, 0), 0xe7, SSE, Mq, Pq)
 /* NP 0F 77: EMMS */
 INSN(emms, LEG(NP, 0F, 0), 0x77, MMX)
 
@@ -340,7 +344,8 @@ INSN_GRP_BEGIN(grp15_LEG_NP)
     /* NP 0F AE /2: LDMXCSR m32 */
     INSN_GRPMEMB_R(grp15_LEG_NP, ldmxcsr, 2, SSE, Md)
     /* NP 0F AE /3: STMXCSR m32 */
-    INSN_GRPMEMB_W(grp15_LEG_NP, stmxcsr, 3, SSE, Md)
+    /* FIXME this is hacked, should be INSN_GRPMEMB_W */
+    INSN_GRPMEMB_R(grp15_LEG_NP, stmxcsr, 3, SSE, Md)
 INSN_GRP_END(grp15_LEG_NP)
 
 INSN_GRP(grp16_LEG_NP, LEG(NP, 0F, 0), 0x18)
-- 
2.20.1


