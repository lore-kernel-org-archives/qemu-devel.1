Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A12FC43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C4120673
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIoEbvCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C4120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56624 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hafGI-0003Mo-58
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39731)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQS-0007hk-UW
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQM-0007tr-4C
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:48 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haeQL-0007fp-Ma
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:41 -0400
Received: by mail-wr1-x443.google.com with SMTP id e16so12522063wrn.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fcAWsgac4JAw4zukSEhib/ItxuFypx2icjrecghPreY=;
 b=MIoEbvCMPWqqtTv1HZ0nqexfsLD4r4Jb0vCP59Di1EUIV9ad7p/cK5L6A7+vlMe+Rt
 sEOCVhlI2gaA2kQT3NbCT3IbQMJ19DdBF4fOMk8BYyH8YbmIZP0t9kgzU0mf5RSNwv5N
 zycJUYvjtwaeEtQN1eY8T00W2vvQ6kJe9ShS2jhBk+WJuGEjPgPdqHpFK+LHQ9bMHur+
 CqvD5o6Vu9+r8OlVntXNMjWVzdrgFtGD2P7RpCHq8wQarrWfx1AmGOYiPGIn5sbDw3n7
 SAYxpRqOq4eeE3dgpfIllTsK+gX6Z2yPMRsXIA7iQvaDC3wemI2AMu0gL43P29o6slWo
 nm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fcAWsgac4JAw4zukSEhib/ItxuFypx2icjrecghPreY=;
 b=LHlPoHS6/MDSr+LOV4+gtUSi9aszXEMV1m0oNqmhYNo6wqo6EIr4JdfM1dvBlgkxrD
 8GWZTRmzzcrpVSLnGhxAhhPigYo9pLQnzPkiD3DUhV0SHwMDpJBud9S7kLq6eLz6BrEL
 NUxfKq7ihnrRzQecC68k0tBojOxqT48dJJaPKbz/tANhmLCuxyPm1JO8T8qtjMd81x6m
 CcoKJdcaor28jYwLdk2GjxbgsLKetju6nXZo+2/0DEpFlHwNOvBJzBnE113I57ZVluG9
 dJdg8wxt+udJRTInkKdXVLaJ/h1nNpKhxceWuQ0NeIiLujAsRJBvXuGdX9MqU9MVktKW
 YpTw==
X-Gm-Message-State: APjAAAWsQrM0w2H/FxbmL4fkAoX9h+2/izHIxVtBmUlmJN5e86aWISEU
 Kx1DSCRfeZ2Vq/Vxjqp2LTKtVg==
X-Google-Smtp-Source: APXvYqzb9d0Wlu/ikpICmV50eInnLx3m5Yh5kWdxz7wresN5kDGeHSNVsn8C4t4w1lHw2HifDamMgg==
X-Received: by 2002:adf:de90:: with SMTP id w16mr17413792wrl.217.1560250466360; 
 Tue, 11 Jun 2019 03:54:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.54.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:54:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:39 +0100
Message-Id: <20190611105351.9871-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v2 30/42] target/arm: Convert VNEG to decodetree
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VNEG instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 10 ++++++++++
 target/arm/translate.c         |  6 +-----
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index d0282f1f921..6e06b2a130a 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1898,3 +1898,13 @@ static bool trans_VABS_dp(DisasContext *s, arg_VABS_dp *a)
 {
     return do_vfp_2op_dp(s, gen_helper_vfp_absd, a->vd, a->vm);
 }
+
+static bool trans_VNEG_sp(DisasContext *s, arg_VNEG_sp *a)
+{
+    return do_vfp_2op_sp(s, gen_helper_vfp_negs, a->vd, a->vm);
+}
+
+static bool trans_VNEG_dp(DisasContext *s, arg_VNEG_dp *a)
+{
+    return do_vfp_2op_dp(s, gen_helper_vfp_negd, a->vd, a->vm);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index dc9076a60a3..b0eecb6ca8f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3098,7 +3098,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 1:
+                case 1 ... 2:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3112,7 +3112,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
                 case 0x00: /* vmov */
-                case 0x02: /* vneg */
                 case 0x03: /* vsqrt */
                     break;
 
@@ -3291,9 +3290,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     case 0: /* cpy */
                         /* no-op */
                         break;
-                    case 2: /* neg */
-                        gen_vfp_neg(dp);
-                        break;
                     case 3: /* sqrt */
                         gen_vfp_sqrt(dp);
                         break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 7035861c270..79e41963be4 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -161,3 +161,8 @@ VABS_sp      ---- 1110 1.11 0000 .... 1010 11.0 .... \
              vd=%vd_sp vm=%vm_sp
 VABS_dp      ---- 1110 1.11 0000 .... 1011 11.0 .... \
              vd=%vd_dp vm=%vm_dp
+
+VNEG_sp      ---- 1110 1.11 0001 .... 1010 01.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VNEG_dp      ---- 1110 1.11 0001 .... 1011 01.0 .... \
+             vd=%vd_dp vm=%vm_dp
-- 
2.20.1


