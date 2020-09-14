Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75FCC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 00:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415E821D1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 00:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZfVnAuEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415E821D1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHc4f-00051M-F1
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 20:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHbwh-0002rR-Jh
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 20:02:11 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHbwf-0004Cv-Jq
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 20:02:11 -0400
Received: by mail-pg1-x543.google.com with SMTP id t14so10060415pgl.10
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 17:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FHMdFNxA5DgdfHwVaO5Ocox79qcbsSZjeiufIYJ4nxY=;
 b=ZfVnAuEZNFZuQPDiVwW+EdPFbdJntGLKtnjL4Pmw7INWhZy67p0KuaF6q61TALlmIB
 /jw1W32K042JP20cA0R5GagqbHh/NE5pbEpNdRfP7yi90VCqa7NGXvRWudcLuUozBY/l
 QGNxZY7G5XVOxOIlUpe0caDrVDT2YxqGOFZ1zlKykDBC4HhiY6wpoa+9bu5q7lNmwCaj
 ckOjUnifKTjV3f+y2vaIpLDs75IRc26Dl6FbKdD2zZ7bTxa+cWKct1nBXPdRq0iXZv/A
 6472h1zZDUx04Ur4WiZwPbTLddbZpnv1vdNkE3xsFhmPyNjF8q+k6hZXHzXsMKHxjbUL
 0CIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FHMdFNxA5DgdfHwVaO5Ocox79qcbsSZjeiufIYJ4nxY=;
 b=feEokkIZ+XS8g2h40LkuuKC61EWpDblh9lapi1fpOHOo2fRQsZlTZ68La013F8fz67
 LzZSC2W5D5Kf7jWyWiEJTTxbcWbS3GFyRMaKui7Uhe5NUGnkZsJ3drD4tDYDtTQgZBXP
 i3JP3uuvN7km8D7QMjWpjYZ4lJrrM6l5Q+byH083J1Ebv1Yre4qZ3RvD1vNOManKtrpR
 Bp2FYKP7cnBzkubV19W2i1kbcgXdYUb5q1/LnYLeCJxXEeFv3Jk6T//uC99KghKCdaV9
 MqNr0avyIXjuK+SZXPexNaq/AbzcGc8pVpDk/USLITtDF4BbP1BUt2wJ7PHVu3+E8NIE
 JvPg==
X-Gm-Message-State: AOAM533LV/x4sJB3tpImI8I08VDzHg1AkpXW+kmKRxTux21pLPme9q3N
 PFuY2o6ofmYjut3V8wypJsPMQ0CKgCXeog==
X-Google-Smtp-Source: ABdhPJz+7uo7MnBvnN7Om2YH7E+7o8KpLOK+urcSXOJOLEd9cYl2lyv4TFytPHEJXvyY2OQ2akZDBA==
X-Received: by 2002:a17:902:8e86:b029:d1:9be4:b49d with SMTP id
 bg6-20020a1709028e86b02900d19be4b49dmr11920941plb.22.1600041727906; 
 Sun, 13 Sep 2020 17:02:07 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 31sm6538252pgs.59.2020.09.13.17.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 17:02:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/11] disas/capstone: Add skipdata hook for s390x
Date: Sun, 13 Sep 2020 17:01:52 -0700
Message-Id: <20200914000153.1725632-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914000153.1725632-1-richard.henderson@linaro.org>
References: <20200914000153.1725632-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: luoyonggang@gmail.com, alex.bennee@linaro.org, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is always possible to tell the length of an insn, even if the
actual insn is unknown.  Skip the correct number of bytes, so that
we stay in sync with the instruction stream.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/capstone.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/disas/capstone.c b/disas/capstone.c
index b48f83958d..0a9ef9c892 100644
--- a/disas/capstone.c
+++ b/disas/capstone.c
@@ -16,6 +16,39 @@
  */
 static __thread cs_insn *cap_insn;
 
+/*
+ * The capstone library always skips 2 bytes for S390X.
+ * This is less than ideal, since we can tell from the first two bits
+ * the size of the insn and thus stay in sync with the insn stream.
+ */
+static size_t CAPSTONE_API
+cap_skipdata_s390x_cb(const uint8_t *code, size_t code_size,
+                      size_t offset, void *user_data)
+{
+    size_t ilen;
+
+    /* See get_ilen() in target/s390x/internal.h.  */
+    switch (code[offset] >> 6) {
+    case 0:
+        ilen = 2;
+        break;
+    case 1:
+    case 2:
+        ilen = 4;
+        break;
+    default:
+        ilen = 6;
+        break;
+    }
+
+    return ilen;
+}
+
+static const cs_opt_skipdata cap_skipdata_s390x = {
+    .mnemonic = ".byte",
+    .callback = cap_skipdata_s390x_cb
+};
+
 /*
  * Initialize the Capstone library.
  *
@@ -42,13 +75,20 @@ static cs_err cap_disas_start(disassemble_info *info, csh *handle)
     /* "Disassemble" unknown insns as ".byte W,X,Y,Z".  */
     cs_option(*handle, CS_OPT_SKIPDATA, CS_OPT_ON);
 
-    if (info->cap_arch == CS_ARCH_X86) {
+    switch (info->cap_arch) {
+    case CS_ARCH_SYSZ:
+        cs_option(*handle, CS_OPT_SKIPDATA_SETUP,
+                  (uintptr_t)&cap_skipdata_s390x);
+        break;
+
+    case CS_ARCH_X86:
         /*
          * We don't care about errors (if for some reason the library
          * is compiled without AT&T syntax); the user will just have
          * to deal with the Intel syntax.
          */
         cs_option(*handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
+        break;
     }
 
     /* Allocate temp space for cs_disasm_iter.  */
-- 
2.25.1


