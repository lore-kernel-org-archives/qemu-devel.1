Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F20C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1FE2224FE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OuZkGTKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FE2224FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2SP-0005Xr-Iw
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2B7-0004sj-2N
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2B5-0005kn-Sk
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:52 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37455)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF2B5-0005kc-NX
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:51 -0400
Received: by mail-pl1-x642.google.com with SMTP id u20so4337804plq.4
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xEcXFFwqOctiA3QPkHa6PrMKHQqTuGEioojAtcvmLA0=;
 b=OuZkGTKWyp9AxznhZKDAIfj+uzC3CaNCFQaYXUFw4p1gbfEri1swMY4pwSQyiZ74Ee
 DQ7DAgWiOCy2mMIqv1pFGNr/coK2RDm7A7L7DCtVd1fv1iJThGt34QEDoMDVxD9BnWZH
 TzrdUhWyS6nEJsh9hzPQRyQwsAKA2Vhz/+lkZZ/uueREEpG6duMDlWv/wElASeJ2PGga
 Ru2jh0ujzvOk3VZAKjrBBQzId/Fywi9KFQ0/cS6Yhj8EbmwXUcwIi1Ecy3BiszXjHYnU
 Qt2iFIga279q1rn9o3SP7THld1vyL2xUE7XyytgzZiICgM2saD7ApXjDLro/PnhCWFAs
 72ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xEcXFFwqOctiA3QPkHa6PrMKHQqTuGEioojAtcvmLA0=;
 b=HObqNzeLEll+jqt0kI8Ghk3p7nZxmX1aukE2cZWqJI+L7GAerA0asUqaSYDnWoqBzZ
 krRrAMVFYWdQppssSh89s6y+F3/FL4LNFwTOD98YQ0R7N9fzEiDkZSuJBmj2bRafAKhz
 Y9b5iroZJldLh4HYtxGZtxCMox0rYElvdFpEJ2v/9FQ1rhci4H/biYp7Pnjt9VlSu04i
 dM7iADZyvQZme8F+0ksngnGbVacssMOE3rsxRpgnbeXDeYDlK4smOWLkxEqMvYal+Ri5
 Syi2AErteFbmdvrI82VOswdoe5BmP1FjxW2lzWzUPUOGzRr+Ob1pXivBanxV8PV2x1Y3
 DWfg==
X-Gm-Message-State: APjAAAUDKWkQKWMwRU25sJDk02C6trwKag/h61mhWXl4x2eIrDF3Wwbj
 2oiAJwyU/kJAdW1kvAQenbkiYy+eIJ8=
X-Google-Smtp-Source: APXvYqzm+dLGm04PhZP90PUOe1RlbNFmTnkOVLuOR4o+mgXkM6dyAVsoYAy56Epw+4GmBpEYL8VQaA==
X-Received: by 2002:a17:902:b110:: with SMTP id
 q16mr21893813plr.262.1569874910293; 
 Mon, 30 Sep 2019 13:21:50 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r28sm15336802pfg.62.2019.09.30.13.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:21:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 18/22] tcg/ppc: Update vector support for v2.07 VSX
Date: Mon, 30 Sep 2019 13:21:21 -0700
Message-Id: <20190930202125.21064-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190930202125.21064-1-richard.henderson@linaro.org>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These new instructions are conditional only on MSR.VSX and
are thus part of the VSX instruction set, and not Altivec.
This includes double-word loads and stores.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index bc3a669cb4..6321e0767f 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -470,10 +470,12 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define LVEWX      XO31(71)
 #define LXSDX      (XO31(588) | 1)  /* v2.06, force tx=1 */
 #define LXVDSX     (XO31(332) | 1)  /* v2.06, force tx=1 */
+#define LXSIWZX    (XO31(12) | 1)   /* v2.07, force tx=1 */
 
 #define STVX       XO31(231)
 #define STVEWX     XO31(199)
 #define STXSDX     (XO31(716) | 1)  /* v2.06, force sx=1 */
+#define STXSIWX    (XO31(140) | 1)  /* v2.07, force sx=1 */
 
 #define VADDSBS    VX4(768)
 #define VADDUBS    VX4(512)
@@ -1156,6 +1158,10 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
             tcg_out_mem_long(s, LWZ, LWZX, ret, base, offset);
             break;
         }
+        if (have_isa_2_07 && have_vsx) {
+            tcg_out_mem_long(s, 0, LXSIWZX, ret, base, offset);
+            break;
+        }
         tcg_debug_assert((offset & 3) == 0);
         tcg_out_mem_long(s, 0, LVEWX, ret, base, offset);
         shift = (offset - 4) & 0xc;
@@ -1203,6 +1209,11 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
             tcg_out_mem_long(s, STW, STWX, arg, base, offset);
             break;
         }
+        if (have_isa_2_07 && have_vsx) {
+            tcg_out_mem_long(s, 0, STXSIWX, arg, base, offset);
+            break;
+        }
+        assert((offset & 3) == 0);
         tcg_debug_assert((offset & 3) == 0);
         shift = (offset - 4) & 0xc;
         if (shift) {
-- 
2.17.1


