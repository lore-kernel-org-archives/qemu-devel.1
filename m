Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B0DC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84CE120753
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZ9x65bB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CE120753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMeZs-0007DK-K4
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 17:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeWN-00020d-FZ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeWM-0005cE-B8
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46568)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jMeWM-0005bp-5V
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id f13so7119339wrm.13
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L3oo5e13KKY97yaceKpUyQX6w7q5mwKsED5f0rgFBwI=;
 b=EZ9x65bBr9LDMxcvIuXSUbh89pfWZKhTgBH478avcUIAU1K6WbB8Dn0AWPoHlx2Nxo
 aQP+qZrjNSOYdgdGuN8422Uvpnc8ApzX9nPonIU7S+JpRWFHxgXMSBblHNmE79hpW1CY
 FVzbQ+LuFzgo1LlLoKW+EAWa4++8sguttc98lfFSQbjt796IuX6soG9WkhtWiswu53IV
 qawawKKfX+g3Q0aKtT8ievfa+v3KYFYb/LC9jWvt+ANsKIG6ckYX59aQM/b3DesJVXcL
 sAqPNFEpCqZO9mSKz74vXPlwmcWTxulJk9i5IaBjKRIDcaI+dUNG96oBdLFfAYFXSlnr
 L0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L3oo5e13KKY97yaceKpUyQX6w7q5mwKsED5f0rgFBwI=;
 b=Slh69rrLFQXZEbfAXfvNnT5MJi3HZMficzW+m3U15w6Md11vbvLMZIhw2lUxnweHsz
 fqcysS1gC/SLz/OeZwovVe7a18yIdvSK1HO0koI5hiLRG66oLMzVgyiyEEpL1p8c60H5
 laPEU/7ym7+lkfwZZB22Sj3FmwI9QzXVUEec+iathd39ml9DOidyEQ/7wGIyu2k+Q4Xk
 Nj7j9vykdjvvHx8Q8ZhGQrkwgeyJNzYrYmwROLLHiP082e+CB7ehff+ML9mIwl0gjMZi
 VtVhvetrXot6Rz7hs6sT4ic45+fOpzsQj0OEPcHHcLFy8+F+xJyKP/ZnNe4tFEEkrnwH
 tEkQ==
X-Gm-Message-State: AGi0PuZ6w7qSpKUQp3FNyjQ2gH0zBUhSfT1vhFvk6tFPArXLNAhdqIfg
 HIkyAjSpjmu4jPY3PuJrNpz2og==
X-Google-Smtp-Source: APiQypLYk8uO/rPDuKym2dArtQVJkBj8wQaIq0uyyIY6pD+Ipk3+NAFl3LuFjzU2PFXpMlaBTUY5kA==
X-Received: by 2002:adf:afe4:: with SMTP id y36mr1103433wrd.205.1586466932969; 
 Thu, 09 Apr 2020 14:15:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i8sm44602522wrb.41.2020.04.09.14.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 14:15:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 391D11FF8C;
 Thu,  9 Apr 2020 22:15:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 02/11] exec/cpu-all: Use bool for have_guest_base
Date: Thu,  9 Apr 2020 22:15:20 +0100
Message-Id: <20200409211529.5269-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409211529.5269-1-alex.bennee@linaro.org>
References: <20200409211529.5269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
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


