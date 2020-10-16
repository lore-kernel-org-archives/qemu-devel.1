Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4B4C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:50:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02A820FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hma8PFOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02A820FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTUo7-00078r-K4
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 14:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUga-0000Za-0j
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:40 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgK-00028p-6q
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:39 -0400
Received: by mail-pf1-x443.google.com with SMTP id j18so2007484pfa.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 11:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i9e477C0zg/4lfiSUJ/DUA8jokwPxP/mv4JJb8OtKrE=;
 b=Hma8PFOOUSyZuHGupLsrIDEd+B463Le1+wfEjBId3La0HB8rTbtco+wGlStXPPSrWy
 4YpSIo4loPpV3sYdU1aMzrzPrSoBni+Y6LgJ2TPUuWHtWB7z5KUnQB3cBbwlMrbXiBOU
 4K+aCBX2xaRm7h7p8vQWu7XWNTT7zcnVLgwi9bAGpjM0TS1L2xryVTw1U73LFBa68z0+
 dxlc7f3aKX4P2KO3P+2VdYyAxzMUAFr6LM7n5a9nyt730o0D0V4OysH1tBYvpiYD6VAQ
 FOSjMPRGlql9rBpUP5Asj396etEwM1uC6BnSSULk+RQaaOypM8KWBSqMkgZcdqvufwKU
 Dc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i9e477C0zg/4lfiSUJ/DUA8jokwPxP/mv4JJb8OtKrE=;
 b=d7mcTiIzFoedc9wzIpo0PA6uBEJ1QFeWgyHK5D9uBgZpCWoSjOI7FU7JsZnMPY0ygK
 J09T9RgagSSc16n3l/oxHvRfa4t6QkSVJNzpg+9iII5y0pRIpmWiz7qGsf7h2qK/IO8k
 WyTFgS7MZEmiSkxuqb1CI+xX0LDDYPzs+ubdby1nWMEEZU0emsF2fhgnD01S37PE7vGa
 0Pn8dymTv9n031k9nZpfFjxmlUaJcfMvxlVNPS5zIOlZWkrNmVuW3Ho8bwRlryYvXyC4
 /lT5aKg2EAHIlNG9Zekru5HGpSKNRGoaknxWuRVMV86uJqrLR+lToQ8M0MMfUvpzvBM2
 7qTg==
X-Gm-Message-State: AOAM532cERtd/LnWPjvLvKDmB7Lr3feJU6k8fmWWzs6XRBAaJBEZxQ9Z
 7FHa1as2YyKI+iz3TLRbeoiGeimzn3cncQ==
X-Google-Smtp-Source: ABdhPJy/jQqXXWiJw8kWMLzL2CeJGn48T2ImI9VpJn5CZW9UiLtxAu9Sl4lpMARtelG3fYP3t2Z7eA==
X-Received: by 2002:a63:140e:: with SMTP id u14mr4075116pgl.91.1602873741953; 
 Fri, 16 Oct 2020 11:42:21 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c15sm3426011pgg.77.2020.10.16.11.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 11:42:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 08/12] linux-user/elfload: Use Error for load_elf_image
Date: Fri, 16 Oct 2020 11:42:03 -0700
Message-Id: <20201016184207.786698-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016184207.786698-1-richard.henderson@linaro.org>
References: <20201016184207.786698-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a bit clearer than open-coding some of this
with a bare c string.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 107a628a9e..56fbda93d0 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -12,6 +12,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/units.h"
 #include "qemu/selfmap.h"
+#include "qapi/error.h"
 
 #ifdef _ARCH_PPC64
 #undef ARCH_DLINFO
@@ -2392,15 +2393,16 @@ static void load_elf_image(const char *image_name, int image_fd,
     struct elf_phdr *phdr;
     abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
     int i, retval;
-    const char *errmsg;
+    Error *err = NULL;
 
     /* First of all, some simple consistency checks */
-    errmsg = "Invalid ELF image for this architecture";
     if (!elf_check_ident(ehdr)) {
+        error_setg(&err, "Invalid ELF image for this architecture");
         goto exit_errmsg;
     }
     bswap_ehdr(ehdr);
     if (!elf_check_ehdr(ehdr)) {
+        error_setg(&err, "Invalid ELF image for this architecture");
         goto exit_errmsg;
     }
 
@@ -2444,13 +2446,11 @@ static void load_elf_image(const char *image_name, int image_fd,
             g_autofree char *interp_name = NULL;
 
             if (*pinterp_name) {
-                errmsg = "Multiple PT_INTERP entries";
+                error_setg(&err, "Multiple PT_INTERP entries");
                 goto exit_errmsg;
             }
+
             interp_name = g_malloc(eppnt->p_filesz);
-            if (!interp_name) {
-                goto exit_perror;
-            }
 
             if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
                 memcpy(interp_name, bprm_buf + eppnt->p_offset,
@@ -2459,11 +2459,11 @@ static void load_elf_image(const char *image_name, int image_fd,
                 retval = pread(image_fd, interp_name, eppnt->p_filesz,
                                eppnt->p_offset);
                 if (retval != eppnt->p_filesz) {
-                    goto exit_perror;
+                    goto exit_read;
                 }
             }
             if (interp_name[eppnt->p_filesz - 1] != 0) {
-                errmsg = "Invalid PT_INTERP entry";
+                error_setg(&err, "Invalid PT_INTERP entry");
                 goto exit_errmsg;
             }
             *pinterp_name = g_steal_pointer(&interp_name);
@@ -2520,7 +2520,7 @@ static void load_elf_image(const char *image_name, int image_fd,
                             (ehdr->e_type == ET_EXEC ? MAP_FIXED : 0),
                             -1, 0);
     if (load_addr == -1) {
-        goto exit_perror;
+        goto exit_mmap;
     }
     load_bias = load_addr - loaddr;
 
@@ -2587,7 +2587,7 @@ static void load_elf_image(const char *image_name, int image_fd,
                                     image_fd, eppnt->p_offset - vaddr_po);
 
                 if (error == -1) {
-                    goto exit_perror;
+                    goto exit_mmap;
                 }
             }
 
@@ -2623,7 +2623,7 @@ static void load_elf_image(const char *image_name, int image_fd,
         } else if (eppnt->p_type == PT_MIPS_ABIFLAGS) {
             Mips_elf_abiflags_v0 abiflags;
             if (eppnt->p_filesz < sizeof(Mips_elf_abiflags_v0)) {
-                errmsg = "Invalid PT_MIPS_ABIFLAGS entry";
+                error_setg(&err, "Invalid PT_MIPS_ABIFLAGS entry");
                 goto exit_errmsg;
             }
             if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
@@ -2633,7 +2633,7 @@ static void load_elf_image(const char *image_name, int image_fd,
                 retval = pread(image_fd, &abiflags, sizeof(Mips_elf_abiflags_v0),
                                eppnt->p_offset);
                 if (retval != sizeof(Mips_elf_abiflags_v0)) {
-                    goto exit_perror;
+                    goto exit_read;
                 }
             }
             bswap_mips_abiflags(&abiflags);
@@ -2658,13 +2658,16 @@ static void load_elf_image(const char *image_name, int image_fd,
 
  exit_read:
     if (retval >= 0) {
-        errmsg = "Incomplete read of file header";
-        goto exit_errmsg;
+        error_setg(&err, "Incomplete read of file header");
+    } else {
+        error_setg_errno(&err, errno, "Error reading file header");
     }
- exit_perror:
-    errmsg = strerror(errno);
+    goto exit_errmsg;
+ exit_mmap:
+    error_setg_errno(&err, errno, "Error mapping file");
+    goto exit_errmsg;
  exit_errmsg:
-    fprintf(stderr, "%s: %s\n", image_name, errmsg);
+    error_reportf_err(err, "%s: ", image_name);
     exit(-1);
 }
 
-- 
2.25.1


