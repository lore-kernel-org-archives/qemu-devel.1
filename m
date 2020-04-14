Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B781C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E3F2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IvmSZCaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E3F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jORqa-0007Rw-CI
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 16:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpN-0005t7-Ft
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpM-0005tB-5K
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:37 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53853)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jORpL-0005si-RP
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:36 -0400
Received: by mail-wm1-x341.google.com with SMTP id d77so14502776wmd.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 13:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LyYH1vUOROUp+ALOi+AoU+6fL4aHHF4lo5SZlCQc25A=;
 b=IvmSZCaf0yjtZb0gsBQFlbhTvILOEfY9/Da4cG8YJArjhfh8PFu+VvvGPNwWFmXngu
 nUAqz6JWGDzYetx0BdIs/hktD5qPK7yIJAPWw7Ym83EBvpgOBGH38W8400kKl46oFxud
 eJYdz5OGnaPSNiRcwtOVhH4VRa60dvbzommM1bJeEDfyfu7IMSTBmNKl+R0NSBesAo1/
 VgSjf+giw6lzor5Kl4UcXufBev1A9diGflZkZRMu4ujfcuoofgum6dCM6Cfj3jGXm3vN
 8C0fqeuBCWXqJQXnOeu3wRc04LkEY/eA83ae0z/xfFopbE3QuK+Ox6ylyPdcFNPx0zul
 Zy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LyYH1vUOROUp+ALOi+AoU+6fL4aHHF4lo5SZlCQc25A=;
 b=jcL7ZmFofyWNn+OwNkuFmqNW/sIXhSE93CAqrt4VPN/v9lcvjGslQzn8aqOQSehEd6
 38CT1N6REJkKJ7aiZqGlw0wqTU1gRmHkTfmWIShe3pt3a+89YUsi9kovpM8rIJ1Mclha
 inkCepg4DfL1kN8YHkGVT7dHUrHTYZFQeXkZqgcegjwLlJhYYHojxfR3kz8R1aFYIQuw
 ZvPJXlg3KyP+JyXssFuY0wLiEsG+2K8s3PapZSrAcswgjhqqj1YWwuEH0IdLHNyPSXiF
 iGld4r52mRTih8WxloO71b0xNjUJhHFyliwl8wmfExq3LJwtsC022QgMGtzbmD3nHr6k
 W1Vw==
X-Gm-Message-State: AGi0PuaFdMTYtkY8D83R83fKqBc2CExRANRW5WbDRcK73cYojPDqFHug
 44JBse8hnx+Y3zeKPFEtAEUDFQ==
X-Google-Smtp-Source: APiQypI01tCXhk3gNbophIDXmJ2bhrGBHZHya+6Zsexa8ww7+rizey/8n3ivJMuKt38628ELoCF1Ig==
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr1406655wmc.64.1586894794435; 
 Tue, 14 Apr 2020 13:06:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u30sm22636wru.13.2020.04.14.13.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 13:06:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AE2271FF8C;
 Tue, 14 Apr 2020 21:06:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 02/17] exec/cpu-all: Use bool for have_guest_base
Date: Tue, 14 Apr 2020 21:06:16 +0100
Message-Id: <20200414200631.12799-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414200631.12799-1-alex.bennee@linaro.org>
References: <20200414200631.12799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/exec/cpu-all.h | 2 +-
 bsd-user/main.c        | 4 ++--
 linux-user/main.c      | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 49384bb66a5..b4fb5832c4a 100644
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
index 770c2b267ad..aef5531628a 100644
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
index 1d20a83d4e8..90ad365b439 100644
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


