Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C65CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B43F20867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hyVfbRSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B43F20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuB8-0002lf-FB
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWc-0003UK-9R
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWa-0007jj-4r
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:42 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:41127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtWZ-0007ig-V9
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:40 -0400
Received: by mail-wr1-x429.google.com with SMTP id p4so953216wrm.8
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DFJwHA2AP1ezAjJK1JlPulxO+eNr4yTHxJXk/vo/FGk=;
 b=hyVfbRSFVyqFWE/FQax+KcYI51JMsQYvlHCrNR0WO5xsiJQ4Pkg8YWEAn/CATSJ8w9
 7nGgWbkWdEW5fSh8IDF+nosMuZB2yF/SCSXQE8Te5YLyoaa8nVeiELGl8mcv2cgtIlCt
 +qLZbE987GwchvLsSmstRIGTsbv/nJ+csZLd/mi6dcb40DITJN/Qe6EH0PnhIm7KCXlL
 9bzSEORD2D75PZUG4d1etQH4Wu9nVfAkgBHmgKGeybEUMIo9cwyAQPEweTtkCTygKSIw
 97DAsdR/HaLS7t3hS8SIQ0wnXNc4sUAu+Yt8/vVImF4rqnq/+6Vccs2uufEW55RJA0a0
 sWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DFJwHA2AP1ezAjJK1JlPulxO+eNr4yTHxJXk/vo/FGk=;
 b=S2QXcr/VCqOGOb6KYpjSyy0OVtA8wlh31KPbevQsVyx/UK8+p/YF1Q1Dpb0/YdKnlm
 15jcoX+YXumLJFa+EGa1zRu2E7+4XL9VvBx40nLZZE2KOjmlBIY/Yc/3M+c21dxGN3Wn
 rXpB3z5aUwuFNwfyd/iY8FjK29vVfCsmsspl2dOTUsdpfW4B0IieESIRD9CejwnI4aCk
 DSGhBLiIWjz86Z74+ZQK5otiIxZrzxO2F7wJxOkgynK/I2Y7yb66ci0UDodOQy7FLtQk
 y0J06MAm401uFD3s/R+kQT9cRElL8dEK0DorcduOuy/lTkuRLOCURHkpcKRGi6T9nHc6
 WYLg==
X-Gm-Message-State: APjAAAXQ5JQ1lh1PipPPN2hXjTrOujksjWQM2XU86by302yCoiNkEM3M
 zFhNtxTf/E9vLABiN2x4Z1LlIQ==
X-Google-Smtp-Source: APXvYqwHlDdWm4o2NHKtJK4SXe1ZW+RwLXIvBVV+/A1Fh5l9D1C9lIc8hjd6kk6ycrUL/VkXclkvTw==
X-Received: by 2002:a05:6000:4c:: with SMTP id
 k12mr1446329wrx.100.1571986598867; 
 Thu, 24 Oct 2019 23:56:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o187sm5777083wmo.3.2019.10.24.23.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:56:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4B9F71FFBE;
 Fri, 25 Oct 2019 07:37:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 37/73] plugin-gen: add plugin_insn_append
Date: Fri, 25 Oct 2019 07:36:37 +0100
Message-Id: <20191025063713.23374-38-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

By adding it to plugin-gen's header file, we can export is as
an inline, since tcg.h is included in the header (we need tcg_ctx).

Signed-off-by: Emilio G. Cota <cota@braap.org>
[AJB: use g_byte_array]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
index de519883b16..4834a9e2f40 100644
--- a/include/exec/plugin-gen.h
+++ b/include/exec/plugin-gen.h
@@ -27,6 +27,17 @@ void plugin_gen_insn_end(void);
 void plugin_gen_disable_mem_helpers(void);
 void plugin_gen_empty_mem_callback(TCGv addr, uint32_t info);
 
+static inline void plugin_insn_append(const void *from, size_t size)
+{
+    struct qemu_plugin_insn *insn = tcg_ctx->plugin_insn;
+
+    if (insn == NULL) {
+        return;
+    }
+
+    insn->data = g_byte_array_append(insn->data, from, size);
+}
+
 #else /* !CONFIG_PLUGIN */
 
 static inline
@@ -51,6 +62,9 @@ static inline void plugin_gen_disable_mem_helpers(void)
 static inline void plugin_gen_empty_mem_callback(TCGv addr, uint32_t info)
 { }
 
+static inline void plugin_insn_append(const void *from, size_t size)
+{ }
+
 #endif /* CONFIG_PLUGIN */
 
 #endif /* QEMU_PLUGIN_GEN_H */
-- 
2.20.1


