Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC029C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DBE20671
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3qgQf+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DBE20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbcV-0007Op-M7
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZbZN-0002Bq-21
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:44:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:56104)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZbZM-0000xZ-5H
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:44:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id f13so2567051wmc.5
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 07:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Tj9rf4j5C/bY0s30aa+ssWmiD9kTfC6nQrJXTkeJFZM=;
 b=e3qgQf+bgeq+F1siSNKcaP1T/CJZqYLzjpzrWH+kitXz51bSYaaN0xOFYEzD1ZZNn3
 v7ZRa+qpGWPqbgp6ksLGfHOhotq5k91SSQ5jcSTXIeEYlZ+IeWomk3OGpOeVZh/gp0dn
 BH2B/iVonzfylzBssmPanpMNkL1fr/yYGozcwfDE4J125NQ5gKRxryt/wqm9+Cq65mxN
 WEfcXB+CIpHb/+9biZFG/YWbJEJv0HzjAJSfK1Bt1DgffUCQjUPB0hUC275jP8wHcjat
 x8YP/7X+q6s9kJ/QxCAkZa/q+olVjzXqRRnSo+zm7eqno2PbwpOr3V0Sn6MgrTFglNzn
 Yd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tj9rf4j5C/bY0s30aa+ssWmiD9kTfC6nQrJXTkeJFZM=;
 b=mSbz7VpqARSz0RUoU23DlHUdJmCMk+vLe9ErbXdTRtmZC5ChEzC6lvODbbI3kLkdCM
 5P8IB4g0mJmTWjj+j6Zkg2VUB6GFvfOg3sZnj/+2r7OfSIx0YKj7Vhz1HfY5h9aHQOLs
 VR6GaOCi6iZsTWg8nx0d1UxbrI27j8viPBhfsKLoJrnTHwqaGTAOdiB1cUULMEjNWG0u
 mZVYto1UQ7RLDoNvYaA3zQjVI2XraWV7iOofOvMLHIQ9fEUBxrlfiiTwEyf3F11r2Vun
 8n0IDrG4QWgIjwV9a1MOEj400pMJdZRDH4fA/TxZs5vgLfegJjKkCA+NB37chDVarr4V
 DDXw==
X-Gm-Message-State: AOAM530mGjdrLTJsCoCIxgOSMJ7riEyVUoOyqDx+x4/ncM+r/xgF3T5G
 cTxP+uapdr80wIFdBn2tx9W36g==
X-Google-Smtp-Source: ABdhPJw0Lcuz+wu/1Mb1f00AKjvtwk9BjaToE9cZeWY2vPA+CVEiBy2azLDGmkp6XkLDtZXYrPYeKw==
X-Received: by 2002:a05:600c:20c6:: with SMTP id
 y6mr4280915wmm.131.1589553850852; 
 Fri, 15 May 2020 07:44:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 77sm4266900wrc.6.2020.05.15.07.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 07:44:06 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 847271FF90;
 Fri, 15 May 2020 15:44:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 04/13] exec/cpu-all: Use bool for have_guest_base
Date: Fri, 15 May 2020 15:43:56 +0100
Message-Id: <20200515144405.20580-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515144405.20580-1-alex.bennee@linaro.org>
References: <20200515144405.20580-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200513175134.19619-6-alex.bennee@linaro.org>

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 43ddcf024c6..0895a57881a 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -159,7 +159,7 @@ static inline void tswap64s(uint64_t *s)
  * This allows the guest address space to be offset to a convenient location.
  */
 extern unsigned long guest_base;
-extern int have_guest_base;
+extern bool have_guest_base;
 extern unsigned long reserved_va;
 
 #if HOST_LONG_BITS <= TARGET_VIRT_ADDR_SPACE_BITS
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 28f122b80e6..0bfe46cff93 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -42,7 +42,7 @@
 int singlestep;
 unsigned long mmap_min_addr;
 unsigned long guest_base;
-int have_guest_base;
+bool have_guest_base;
 unsigned long reserved_va;
 
 static const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
@@ -828,7 +828,7 @@ int main(int argc, char **argv)
             }
         } else if (!strcmp(r, "B")) {
            guest_base = strtol(argv[optind++], NULL, 0);
-           have_guest_base = 1;
+           have_guest_base = true;
         } else if (!strcmp(r, "drop-ld-preload")) {
             (void) envlist_unsetenv(envlist, "LD_PRELOAD");
         } else if (!strcmp(r, "bsd")) {
diff --git a/linux-user/main.c b/linux-user/main.c
index e18c1fb9523..3597e99bb10 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -59,7 +59,7 @@ static const char *cpu_type;
 static const char *seed_optarg;
 unsigned long mmap_min_addr;
 unsigned long guest_base;
-int have_guest_base;
+bool have_guest_base;
 
 /*
  * Used to implement backwards-compatibility for the `-strace`, and
@@ -334,7 +334,7 @@ static void handle_arg_cpu(const char *arg)
 static void handle_arg_guest_base(const char *arg)
 {
     guest_base = strtol(arg, NULL, 0);
-    have_guest_base = 1;
+    have_guest_base = true;
 }
 
 static void handle_arg_reserved_va(const char *arg)
-- 
2.20.1


