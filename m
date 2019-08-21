Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FCDC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BEB422D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2fsKVxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEB422D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0V2V-0001BG-2p
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URI-0001AG-Hr
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URF-0007S0-HQ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:26 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:32970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URF-0007Re-DQ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:25 -0400
Received: by mail-yb1-xb44.google.com with SMTP id b16so1356989ybq.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gYuBNOkKKJStCysNXLLG2nufiXX8kYlFxubPjNYQr7Q=;
 b=H2fsKVxSTX6vSTFGqie94brcD8woNBB0D51JK6oOKe8L8MtaKHc22VmJt+kfkyizrw
 0ewynb0hOTQUqRvkQI68wGa8Tz16eVyfiGzFvHMApSesWxP3JWdo9FZA1W7tDYecKA6U
 d9Fy0qeOpb5qJEaVRb4RqibPly/tTfmLCW7gAdXzGD7ECt7NEfMAk4xEqEXESzfXFDhx
 Y18gY/KG5wsyIUxf5PAXDNlUysPNt+3Mx4kBM362S/Vds3iJptyMti9F16z8r9n4oShz
 wdB4ZvLM94krvbKfnEzurE2QT+BioQsuYoQ+ZBSvg7aCe42jbx3BPTRMKD6/JB3upFNQ
 K8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gYuBNOkKKJStCysNXLLG2nufiXX8kYlFxubPjNYQr7Q=;
 b=OD13PfVzgJ4KtaQY9oeldmsfX/zGAHVmHzcAiEAoNzzgyLSox8GwKhgy7RthWYAjfl
 cS0qrEgTp1WyWiBMybWkeDQI22loJp7wm7uB4oiqRoVnHE/csN8/sE0LXDU4/nCUY41g
 rRGWM+g+/hZlHujjLZlTnrcHkVrqeoh6n5dqQKruiDnsA15I1hwC9U4kEOV724wls3ak
 DOelNA5GUrgrjM2zXO3igigBd6yKYsclSUd3H+EhSMECIpZz9nPGM3wPEZOmms9EqdWi
 ia8iKviIcdPTEIqemHiApmZ8p9bsO3IRfG0i0noTTTndv/xXh6p/n51pUaH/Ib3uc1tA
 DcnA==
X-Gm-Message-State: APjAAAVWDhqvV22M+XERKLAvJo2M6nLYEaIm4VWzGGfBcTzOZHz5S06c
 drDgqv8/8H93yCHCShxm6hX4a5Wr
X-Google-Smtp-Source: APXvYqzIQWTBU4QWQHj0lqWtoYPnrdqpFjl4gu3/aeIduRuINP1DiQDcPlYMtTqfQouGUREDB5GQSg==
X-Received: by 2002:a25:e806:: with SMTP id k6mr25957365ybd.74.1566408624792; 
 Wed, 21 Aug 2019 10:30:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:24 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:00 -0400
Message-Id: <20190821172951.15333-25-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RFC PATCH v4 24/75] target/i386: introduce operand
 for direct-only r/m field
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

Many operands can only decode successfully if the ModR/M byte has the
direct form (i.e. MOD=3). Capture this common aspect by introducing a
special direct-only r/m field operand.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index b3b316d389..886f64a58f 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4853,6 +4853,43 @@ INSNOP_FINALIZE(modrm_rm)
 {
 }
 
+/*
+ * modrm_rm_direct
+ *
+ * Equivalent of modrm_rm, but only decodes successfully if
+ * the ModR/M byte has the direct form (i.e. MOD=3).
+ */
+typedef insnop_arg_t(modrm_rm) insnop_arg_t(modrm_rm_direct);
+typedef struct {
+    insnop_ctxt_t(modrm_rm) rm;
+} insnop_ctxt_t(modrm_rm_direct);
+
+INSNOP_INIT(modrm_rm_direct)
+{
+    bool ret;
+    insnop_ctxt_t(modrm_mod) modctxt;
+
+    ret = insnop_init(modrm_mod)(&modctxt, env, s, modrm, 0);
+    if (ret) {
+        const int mod = insnop_prepare(modrm_mod)(&modctxt, env, s, modrm, 0);
+        if (mod == 3) {
+            ret = insnop_init(modrm_rm)(&ctxt->rm, env, s, modrm, is_write);
+        } else {
+            ret = false;
+        }
+        insnop_finalize(modrm_mod)(&modctxt, env, s, modrm, 0, mod);
+    }
+    return ret;
+}
+INSNOP_PREPARE(modrm_rm_direct)
+{
+    return insnop_prepare(modrm_rm)(&ctxt->rm, env, s, modrm, is_write);
+}
+INSNOP_FINALIZE(modrm_rm_direct)
+{
+    insnop_finalize(modrm_rm)(&ctxt->rm, env, s, modrm, is_write, arg);
+}
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


