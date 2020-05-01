Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2BEC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F1120836
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QCBzWTKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F1120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUXAp-00005G-0B
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUX7M-0004rv-1A
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUX6M-0007qX-7Q
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:58:19 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUX6L-0007nv-Pl
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:57:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id u16so6573200wmc.5
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 07:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rec4lCI7C2I9ftVXhw3jnhwwniJ/OyIiNlpjw4I33hQ=;
 b=QCBzWTKIZ6i1bqEUk+0sAgo+cfTpLNxKV3RzrG+1hwaJXmxcirgXUoE+RwsLgTHHgw
 jEKvHtZPIbyFLMXu2Wgdm5pAJPLvp8CuAS51BI4OWqcECJEI7ab50iriC5iBaM5IQVxi
 oLQvvaxh4xcNKgEhFUghRmSZUUkezF7Rfv9EK+4IujEWt8yFy93eY/EPvt5ZY8qrJpL5
 A12BmGdnRoA/3xmzTwkb/NHWdpRPUnEbcF4UEky+cayhthHayWGraIYAhuW+eC1JBTqR
 rurZ5RW7VmXApbl/+KjnrrDnICO1FT0tge8XueNq95J0SKitSHZN8Rc3MgpYydikvdrf
 NX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rec4lCI7C2I9ftVXhw3jnhwwniJ/OyIiNlpjw4I33hQ=;
 b=XwaX8y6XWKsYQm+gQceT5qj/b2GYdL/4vuGlMZ0PufOhc/GkBjeTyam9fK19czEWsj
 LHTS9ONOxinQ5JjernsUiehWFNzFI9cQTAcSZlb4Dx8XVkGaxCQaSux1tEDsaPPAS3wx
 lzMryblT13h/G4suZ9PNm07tdqnGhLpG1Ji/Sp9CGizLA2JoBJpPGsOOKMhrVTLkjBgz
 JwKfF/lhX38jDbNv015ykFjl0tc4xGGJVLouHReDp073axGrA9x1q+xD/CdwMZFCUk6g
 LL+GTtltC7HY5tpnnKzaCtKBodN1ssXh8Aaj864TPbT+pPgqOFT7pqPeZ/e7n/1SnEHJ
 S1uA==
X-Gm-Message-State: AGi0PuYNBzSZPqYKoGPpME9Py1hP0rcvSqqPNbA7GZrYjRa/dXUBR6De
 LK06cdTgY5V9EWXFhkzFRthkaQ==
X-Google-Smtp-Source: APiQypKiOZjO2OZxQQ0eX+zopzygmB7gNx/d7cXGxg5GN6KkiOT5GXmEjaoOiunsl6k+tp2zZ3qDsw==
X-Received: by 2002:a1c:2392:: with SMTP id j140mr4339640wmj.136.1588345036002; 
 Fri, 01 May 2020 07:57:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s24sm4421887wmj.28.2020.05.01.07.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 07:57:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 41F371FF8C;
 Fri,  1 May 2020 15:57:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 2/7] exec/cpu-all: Use bool for have_guest_base
Date: Fri,  1 May 2020 15:57:07 +0100
Message-Id: <20200501145713.19822-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501145713.19822-1-alex.bennee@linaro.org>
References: <20200501145713.19822-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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
 riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
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
---
 include/exec/cpu-all.h | 2 +-
 bsd-user/main.c        | 4 ++--
 linux-user/main.c      | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 49384bb66a..b4fb5832c4 100644
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
index 770c2b267a..aef5531628 100644
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
index 1d20a83d4e..90ad365b43 100644
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


