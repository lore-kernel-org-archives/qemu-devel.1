Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C3EC4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BDA21773
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BZpraDfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BDA21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhD39-0001P3-7x
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 09:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41175)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCy9-0007yq-Cy
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCy8-0003b3-0r
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:41 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52319)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhCy7-0003TW-Ji
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:39 -0400
Received: by mail-wm1-x344.google.com with SMTP id s3so11579319wms.2
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RrItPPBS9UjBeZEukcKAp5+okx0Y0meWpGahN0dzJrg=;
 b=BZpraDfyotkXrnQsOzsqHGnRGibzTzGiwTZUJQPr3N6dfn6XDsNEJaJaZ/4yDaXFnx
 VDThGNipvmL5f9Wfg0ZYGHqzeUg2gSqXBfS2qSDa8d93t7K4DMg70aWi9CJcpColcyZo
 DnJrY5/QGMNWWilKkakSMy+S9JwmPhNyuhEbQXwC+EwuluzZRtrpNuSIWfld+YIl/F/Q
 wySzSmNmqTjFYxItk7wcjN9cdvT7frLpaRiTvROwBZWd2dBVERee0xZpuqXX0Yh9CLzQ
 xmX+tB3j9t80I3aULxUm4p94RgfFxzxSGrrQ9+VX66+6Okvs5iThM0mlASZG691htRlh
 2APg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RrItPPBS9UjBeZEukcKAp5+okx0Y0meWpGahN0dzJrg=;
 b=Tt6uu5j999cs7fN9QlqZ1izeBEKl8Un1HE4FXuOZkFH//hwgKIeaq27a/8QO2Me0ts
 CD8S/WdW4/pjfidMPG+eBpNkkDKK0N6Yz+Mboo653BzHK7v+5hOl9YSMXZPyk1KqmhxL
 yvGmDxO62N9ONGDIQXiPwwBEiGnsMhpnXN/Y1WKKhpG3tz/nLMcx7QYmyPCWVfMKm2Tj
 SdaEnL4oDJTzfaNk4bQs+4IzUS/cQTPR2EtvFAnTEmzXXngymiIrMiFJ77TLSP99nRyC
 I1bxyQmLaD0y1SzacYjHAVcI8iMX8DQe19lM9beMoJA7ikrF9HSXCw99ckloWwlHI0gr
 7q8g==
X-Gm-Message-State: APjAAAUM4YxyaUtzVpcctu51SdKqHQM3e7lk/EbFT0Pf1HRERjO7ETNr
 k4Twzl+691soLKdNCsoPYiDxb9kq8pOMpQ==
X-Google-Smtp-Source: APXvYqyWrI58i1DcwVQdPhQJIrNN5lHQanaZMdVLHoFDzf3inUGBVadv1eqnqXfATSPu9bHfWbxp0A==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr9967351wmc.22.1561813231248; 
 Sat, 29 Jun 2019 06:00:31 -0700 (PDT)
Received: from localhost.localdomain (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id d10sm4937676wro.18.2019.06.29.06.00.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 29 Jun 2019 06:00:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 29 Jun 2019 15:00:13 +0200
Message-Id: <20190629130017.2973-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190629130017.2973-1-richard.henderson@linaro.org>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v6 12/16] tcg/ppc: Support vector dup2
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

This is only used for 32-bit hosts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.inc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index cb604b76a3..9a44670180 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -3105,6 +3105,14 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_dup2_vec:
+        assert(TCG_TARGET_REG_BITS == 32);
+        /* With inputs a1 = xLxx, a2 = xHxx  */
+        tcg_out32(s, VMRGHW | VRT(a0) | VRA(a2) | VRB(a1));  /* a0  = xxHL */
+        tcg_out_vsldoi(s, TCG_VEC_TMP1, a0, a0, 8);          /* tmp = HLxx */
+        tcg_out_vsldoi(s, a0, a0, TCG_VEC_TMP1, 8);          /* a0  = HLHL */
+        return;
+
     case INDEX_op_ppc_mrgh_vec:
         insn = mrgh_op[vece];
         break;
@@ -3483,6 +3491,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ppc_mulou_vec:
     case INDEX_op_ppc_pkum_vec:
     case INDEX_op_ppc_rotl_vec:
+    case INDEX_op_dup2_vec:
         return &v_v_v;
     case INDEX_op_not_vec:
     case INDEX_op_dup_vec:
-- 
2.17.1


