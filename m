Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4328CC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C2132067D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYBVWT0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2132067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9s8I-0008Qr-Up
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnR-0004ZX-6O
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnP-0006zT-DJ
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:05 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i9rnO-0006yR-Pj
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id i1so38500257wro.4
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PhdxBnvi4pU80xrRijWpk4YE0MSvzzAfF5L37d1esIU=;
 b=ZYBVWT0oCbR554Mraq3xgsjVLom0X451QtcoUP0V55L8vYofSszxGYuG4cN6IjvMyY
 vjaXDVWCNcNOPwtvDFkRikje0q4JzvmbTlgbB7+XDo1XT6ZfzvMWnmJ0BJ5wGMMR9OsV
 gfvf6Ver1OKOTntV186Mo8XeRm1eGP4VTjcKXxywbAiETEXS5RsE0pN4lz72yfNgij3/
 jrE2GKbZuUPujd6CIxyuQduog1ABVhMOop8n2kyAMx2ylQW73fmzMod25q60wGi97PtI
 iFz4abOaTUr4+WbtJYyF+0v6G8ggwSEPC+2Wg5a4btvSTjXUWmcKl40lHRL3pJqeEeKz
 GD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PhdxBnvi4pU80xrRijWpk4YE0MSvzzAfF5L37d1esIU=;
 b=al9Z34HNMtaIRhQUEuBGbAVPl7O3qWwAk/s5aLKsNv+jrjTW0Eah7z8CBlWvrB0pxg
 pnRg/3XCa9IGjx5ow96TIMNltUmvrVNysw9eO2IdnVRpqrq6o1lMrmxl+en5g/5WdfR1
 Mhs6w3ROxwXfijFjKNkmzKhg6gLS+G5SNFYrI0olcbNBnAxz97y7vh3bwyyrAyWBWSlx
 B7UKDfM8VG2mcn+/faGRW8SvPDI14fjWR+WO9cRLRYK6u9sr0WYmILEn9xhXKXT2UpTd
 noD5KC84/jWMYt/AyLcnhDU1qRW5aQjHaVv64w3Pg9U5aJQvHWoli2mihnNs2M8mCvPi
 2Ntg==
X-Gm-Message-State: APjAAAU60GR50bMDalVz7U/6J9kDrrRT5/G2HAzy0J+yVqZsEiLlJ+JG
 SCEh4mWNkDZLlnbSiORyjzLK9g==
X-Google-Smtp-Source: APXvYqxfpfRFab2EHZqCExuA9zAr3DA1LIcKc07IjxrItyWn7ekDJEY4dFVB/YCycqtFLUgcJjbzAQ==
X-Received: by 2002:adf:ed88:: with SMTP id c8mr7303871wro.329.1568643361657; 
 Mon, 16 Sep 2019 07:16:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s9sm15185884wme.36.2019.09.16.07.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 07:16:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:15:41 +0100
Message-Id: <20190916141544.17540-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916141544.17540-1-peter.maydell@linaro.org>
References: <20190916141544.17540-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v2 12/15] target/arm/arm-semi: Factor out
 implementation of SYS_FLEN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Factor out the implementation of SYS_FLEN via the new
function tables.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-semi.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index b5e1d73eb80..87c911f0187 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -391,6 +391,7 @@ typedef uint32_t sys_readfn(ARMCPU *cpu, GuestFD *gf,
 typedef uint32_t sys_isattyfn(ARMCPU *cpu, GuestFD *gf);
 typedef uint32_t sys_seekfn(ARMCPU *cpu, GuestFD *gf,
                             target_ulong offset);
+typedef uint32_t sys_flenfn(ARMCPU *cpu, GuestFD *gf);
 
 static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
 {
@@ -454,6 +455,17 @@ static uint32_t host_seekfn(ARMCPU *cpu, GuestFD *gf, target_ulong offset)
     return 0;
 }
 
+static uint32_t host_flenfn(ARMCPU *cpu, GuestFD *gf)
+{
+    CPUARMState *env = &cpu->env;
+    struct stat buf;
+    uint32_t ret = set_swi_errno(env, fstat(gf->hostfd, &buf));
+    if (ret == (uint32_t)-1) {
+        return -1;
+    }
+    return buf.st_size;
+}
+
 static uint32_t gdb_closefn(ARMCPU *cpu, GuestFD *gf)
 {
     return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
@@ -486,12 +498,19 @@ static uint32_t gdb_seekfn(ARMCPU *cpu, GuestFD *gf, target_ulong offset)
                            gf->hostfd, offset);
 }
 
+static uint32_t gdb_flenfn(ARMCPU *cpu, GuestFD *gf)
+{
+    return arm_gdb_syscall(cpu, arm_semi_flen_cb, "fstat,%x,%x",
+                           gf->hostfd, arm_flen_buf(cpu));
+}
+
 typedef struct GuestFDFunctions {
     sys_closefn *closefn;
     sys_writefn *writefn;
     sys_readfn *readfn;
     sys_isattyfn *isattyfn;
     sys_seekfn *seekfn;
+    sys_flenfn *flenfn;
 } GuestFDFunctions;
 
 static const GuestFDFunctions guestfd_fns[] = {
@@ -501,6 +520,7 @@ static const GuestFDFunctions guestfd_fns[] = {
         .readfn = host_readfn,
         .isattyfn = host_isattyfn,
         .seekfn = host_seekfn,
+        .flenfn = host_flenfn,
     },
     [GuestFDGDB] = {
         .closefn = gdb_closefn,
@@ -508,6 +528,7 @@ static const GuestFDFunctions guestfd_fns[] = {
         .readfn = gdb_readfn,
         .isattyfn = gdb_isattyfn,
         .seekfn = gdb_seekfn,
+        .flenfn = gdb_flenfn,
     },
 };
 
@@ -687,16 +708,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return set_swi_errno(env, -1);
         }
 
-        if (use_gdb_syscalls()) {
-            return arm_gdb_syscall(cpu, arm_semi_flen_cb, "fstat,%x,%x",
-                                   gf->hostfd, arm_flen_buf(cpu));
-        } else {
-            struct stat buf;
-            ret = set_swi_errno(env, fstat(gf->hostfd, &buf));
-            if (ret == (uint32_t)-1)
-                return -1;
-            return buf.st_size;
-        }
+        return guestfd_fns[gf->type].flenfn(cpu, gf);
     case TARGET_SYS_TMPNAM:
         qemu_log_mask(LOG_UNIMP, "%s: SYS_TMPNAM not implemented", __func__);
         return -1;
-- 
2.20.1


