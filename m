Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D911C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF5720830
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FI7uP5I3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF5720830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9ruK-0002O7-QK
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnM-0004Ro-IQ
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnJ-0006wF-Un
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:00 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51323)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i9rnJ-0006vK-N8
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:15:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id 7so10363060wme.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yIjqE3N6eSZNfzCdyh3+uQKud53B4e3Qu5WNOWAkg2U=;
 b=FI7uP5I3r/O4vIdyj5lxWSCJONj5vFeUZpRbFdEIDXU7IqTRuD/Pa2XvZjpGa1rnE0
 ygxMj+LaPFC73LaHF44dWHpV0VmZTCtMhxGQUeXW2wEFU81gh5DC4mgkop+t9k7EnZWc
 AqzMQUKXPmnSOnWPGL5EAkiDiM+3rxePO42528SiXJe/e8pgo01ANz8CAU4G354eNPFi
 PEHounEUwnlSDOgQ+58y2RO6lLiQ//G5wpzB7mXVt2S/tSvNNM2ZcIgsVqf+r//GkGRA
 hB5uTGu2/xNB9tyxFFnNPt7+Bpj58t0QWlDoHLCoRUgHXb3oR6w4xbYqTUUXiK5ZvFGG
 MejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yIjqE3N6eSZNfzCdyh3+uQKud53B4e3Qu5WNOWAkg2U=;
 b=N3jYDPkjqwCX549gTIzou8YLDe7kUgDRykCvuTUfjqlIKYbS+dG2B15uHjx2a/dP9v
 CZhjD746GJ48ZMgJLR8XNbbV1PZnCsC0jhukVCqC5Auvp0UKC2yz6aQFA7aPFmm9n0Uq
 Dzaa5/CpK78DPoS7aaZO2ROXx3x6ejwEqJZe5UZlf/De05sle0QZpF5aHvhqvvX3SlBz
 L2BDn48f19N2f09BIp9+xc6ZGscE7czOvJIH9yaZrSa9S6dKpsn9n0diWtTVHXhvRq+1
 rFNhayEGQa63JRKJ/TiRDUDHaIfF9nITaGdChliXZBEvzMeu7noc90F4PQ/ur+62W8M+
 bUBA==
X-Gm-Message-State: APjAAAXPzzwoeB6PMcfgL0YswZAuM0yaOXUxih1ElOTfvWsl0ccxBYhF
 yt5JRzuj2we048fDBFHtdF139w==
X-Google-Smtp-Source: APXvYqwhSbt37KGJoxGgGS/0t9N2/7BcUCfvfap3uG1/+J/XQxIgl2soGD+qLYdjk5g2MIHlHTw7nA==
X-Received: by 2002:a7b:c108:: with SMTP id w8mr2915539wmi.8.1568643355519;
 Mon, 16 Sep 2019 07:15:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s9sm15185884wme.36.2019.09.16.07.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 07:15:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:15:36 +0100
Message-Id: <20190916141544.17540-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916141544.17540-1-peter.maydell@linaro.org>
References: <20190916141544.17540-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v2 07/15] target/arm/arm-semi: Factor out
 implementation of SYS_CLOSE
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

Currently for the semihosting calls which take a file descriptor
(SYS_CLOSE, SYS_WRITE, SYS_READ, SYS_ISTTY, SYS_SEEK, SYS_FLEN)
we have effectively two implementations, one for real host files
and one for when we indirect via the gdbstub. We want to add a
third one to deal with the magic :semihosting-features file.

Instead of having a three-way if statement in each of these
cases, factor out the implementation of the calls to separate
functions which we dispatch to via function pointers selected
via the GuestFDType for the guest fd.

In this commit, we set up the framework for the dispatch,
and convert the SYS_CLOSE call to use it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-semi.c | 44 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 02cd673d47d..e5f1e2aaaf2 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -109,6 +109,7 @@ static int open_modeflags[12] = {
 typedef enum GuestFDType {
     GuestFDUnused = 0,
     GuestFDHost = 1,
+    GuestFDGDB = 2,
 } GuestFDType;
 
 /*
@@ -172,14 +173,14 @@ static GuestFD *do_get_guestfd(int guestfd)
 /*
  * Associate the specified guest fd (which must have been
  * allocated via alloc_fd() and not previously used) with
- * the specified host fd.
+ * the specified host/gdb fd.
  */
 static void associate_guestfd(int guestfd, int hostfd)
 {
     GuestFD *gf = do_get_guestfd(guestfd);
 
     assert(gf);
-    gf->type = GuestFDHost;
+    gf->type = use_gdb_syscalls() ? GuestFDGDB : GuestFDHost;
     gf->hostfd = hostfd;
 }
 
@@ -376,6 +377,39 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_syscall_complete_cb cb,
     return is_a64(env) ? env->xregs[0] : env->regs[0];
 }
 
+/*
+ * Types for functions implementing various semihosting calls
+ * for specific types of guest file descriptor. These must all
+ * do the work and return the required return value for the guest,
+ * setting the guest errno if appropriate.
+ */
+typedef uint32_t sys_closefn(ARMCPU *cpu, GuestFD *gf);
+
+static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
+{
+    CPUARMState *env = &cpu->env;
+
+    return set_swi_errno(env, close(gf->hostfd));
+}
+
+static uint32_t gdb_closefn(ARMCPU *cpu, GuestFD *gf)
+{
+    return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
+}
+
+typedef struct GuestFDFunctions {
+    sys_closefn *closefn;
+} GuestFDFunctions;
+
+static const GuestFDFunctions guestfd_fns[] = {
+    [GuestFDHost] = {
+        .closefn = host_closefn,
+    },
+    [GuestFDGDB] = {
+        .closefn = gdb_closefn,
+    },
+};
+
 /* Read the input value from the argument block; fail the semihosting
  * call if the memory read fails.
  */
@@ -485,11 +519,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return set_swi_errno(env, -1);
         }
 
-        if (use_gdb_syscalls()) {
-            ret = arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
-        } else {
-            ret = set_swi_errno(env, close(gf->hostfd));
-        }
+        ret = guestfd_fns[gf->type].closefn(cpu, gf);
         dealloc_guestfd(arg0);
         return ret;
     case TARGET_SYS_WRITEC:
-- 
2.20.1


