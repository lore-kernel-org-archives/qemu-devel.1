Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5298C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9592208CA
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rScZ2W9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9592208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43510 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbUbP-0008AX-LQ
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 14:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53674)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbSlF-0003uX-6S
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbSlD-0003HL-78
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbSl8-00025H-Sq
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id n9so21554809wru.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 09:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vi4fuS6trrxryGpXVQHQgicRuxlNLJ/gRR72lTmjq/A=;
 b=rScZ2W9YLKkFihqFm6aSR6MHhwsWKG3a37gRHHLVmhQHEveS32ARV/ikKswpYuKKlt
 A+CXDlcQgpn871h/qf2vl7uQXtUMgngRmdnLJnYE5jIPc1s7dAfFg+siI6SY5IV7JQvc
 Xn5SJnzsN+HoVI+FvfNQud7ByQqS9tgNod6xMHxzHHyYs+6q6DL3XEgJoNQPoGOq8ohT
 eFX5Ox7GDpJM8+Q7NQRXxc+SFf+8me5m65x8MhIpBFrEi998gj3Hdw3WzCZXnj6mQcks
 cyI4HImQze/Yh8tMh33t5IDuohomsO9DX/cbnyE3lDl3TAJThZu+lYow5GEfhWUMvdn1
 /Htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vi4fuS6trrxryGpXVQHQgicRuxlNLJ/gRR72lTmjq/A=;
 b=bEhVplDPvsDw0w7PMmOUV+iYRgFZdchyhNZ+omdm19gXUc8oxXWGYnAZMdMG+8OX4c
 mB+jwbtT4LXVPWM9tXMnI3xgJLIeBZv6PogHLPMQGFypJwwd5HeDJvsmfi6l1YiVrEZH
 45TqyT9Lr4RVM/fgSTksnlCUcT1J9u87n2Vag7O2PAq8gTLOj0OdCONJd1bld/LXmIPE
 MXfYifYeSxiQ+lZx+SRqQ61aA9ZiZ9LENfng1+svzqe06b8Ifi1WkP74dnax5e6zbTpy
 pOi0sSW7A1rLvVldBA1ynRqj73nvZOg2sHAp0ajgo7fa9aQhVakqx6U+zRPf9c8EQJXw
 KooQ==
X-Gm-Message-State: APjAAAUHDtZwzTIOmHUZy/TxRzKtwu+ZWX+pcQVAV9J2aMgB69qvNBH8
 TPvTEeWvoVCBzYNaSMiDzKgysWbdcIdijA==
X-Google-Smtp-Source: APXvYqxmBEVRIXFt8jji0O456JRNKT4j2O57MxWqCn2VVvZeZ64xFbxnj6kpCEwQfNxx5Yi8BWt/6w==
X-Received: by 2002:a5d:6b12:: with SMTP id v18mr61452916wrw.306.1560443962570; 
 Thu, 13 Jun 2019 09:39:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f197sm358747wme.39.2019.06.13.09.39.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 09:39:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 17:39:08 +0100
Message-Id: <20190613163917.28589-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613163917.28589-1-peter.maydell@linaro.org>
References: <20190613163917.28589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 03/12] target/arm: Stop using cpu_F0s for
 NEON_2RM_VABS_F
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

Where Neon instructions are floating point operations, we
mostly use the old VFP utility functions like gen_vfp_abs()
which work on the TCG globals cpu_F0s and cpu_F1s. The
Neon for-each-element loop conditionally loads the inputs
into either a plain old TCG temporary for most operations
or into cpu_F0s for float operations, and similarly stores
back either cpu_F0s or the temporary.

Switch NEON_2RM_VABS_F away from using cpu_F0s, and
update neon_2rm_is_float_op() accordingly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index c274c8b4602..a10fded1f39 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1374,14 +1374,6 @@ static TCGv_ptr get_fpstatus_ptr(int neon)
     return statusptr;
 }
 
-static inline void gen_vfp_abs(int dp)
-{
-    if (dp)
-        gen_helper_vfp_absd(cpu_F0d, cpu_F0d);
-    else
-        gen_helper_vfp_abss(cpu_F0s, cpu_F0s);
-}
-
 static inline void gen_vfp_neg(int dp)
 {
     if (dp)
@@ -4191,8 +4183,13 @@ static const uint8_t neon_3r_sizes[] = {
 
 static int neon_2rm_is_float_op(int op)
 {
-    /* Return true if this neon 2reg-misc op is float-to-float */
-    return (op == NEON_2RM_VABS_F || op == NEON_2RM_VNEG_F ||
+    /*
+     * Return true if this neon 2reg-misc op is float-to-float.
+     * This is not a property of the operation but of our code --
+     * what we are asking here is "does the code for this case in
+     * the Neon for-each-pass loop use cpu_F0s?".
+     */
+    return (op == NEON_2RM_VNEG_F ||
             (op >= NEON_2RM_VRINTN && op <= NEON_2RM_VRINTZ) ||
             op == NEON_2RM_VRINTM ||
             (op >= NEON_2RM_VRINTP && op <= NEON_2RM_VCVTMS) ||
@@ -6761,7 +6758,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             break;
                         }
                         case NEON_2RM_VABS_F:
-                            gen_vfp_abs(0);
+                            gen_helper_vfp_abss(tmp, tmp);
                             break;
                         case NEON_2RM_VNEG_F:
                             gen_vfp_neg(0);
-- 
2.20.1


