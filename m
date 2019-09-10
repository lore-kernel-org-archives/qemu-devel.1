Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2EBC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E0121479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pun+1zY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E0121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7haC-00025b-2d
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 10:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNm-0005RB-Ve
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNl-00050Z-QG
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7hNl-000506-Jl
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:37 -0400
Received: by mail-wr1-x444.google.com with SMTP id t16so20832403wra.6
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=zlo9vQHXYMdSRYQxbnaGFzeWoJMkmJsq2rf4IJ1ziW4=;
 b=pun+1zY5WhN2o0gSnE577xUfjuVDwQhUVEkMW8GsvWdeh82xhKthM9G80PRZ0dZJMB
 GP3hgPkZvtMQujx48UjpE+VuU1MaxhtDM0V7KqsxgDIe3S4hvscuuRMG82ZI/l2UUnM7
 ibzTgjoZtriyYo89qDZ4faNq6B20UfYbFYUH2PdZIv4IHQpRAlMSorG0jxSsqhogCkgy
 28gtcUnYN6Apll4DQ8kPb6TqVLwRTC85fMQ8JESNfN7yhJMB9gwDyG+hJ1UKlPRXYPrx
 qoMxWzBQB2dSAHvbSKTvpbDta9Xt9beJN2pHPI0vEb2cVavqGbQCoo+4Vh00N6Lct+vX
 cxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zlo9vQHXYMdSRYQxbnaGFzeWoJMkmJsq2rf4IJ1ziW4=;
 b=otDDvNiGuv2mXidwiNuqrsdt6GdXIp9BSbRvNmYXHtq/f6oQJ3ijfJenYCSnv49ln8
 qyBJJh+KRA2GdiIbPIiBLKw/bZ8SoxUDJhfdcVMPeMbfhBXq0gkcL8V3jJJPJ/DAn4Xx
 cVoA1oGDKp7GFjVgqQYN+bqz+a/MHLcNOmjxeLpfdBA+a57vF/THAX8Adp0dLdRaPH1X
 4gmVIbjtprQ3fOnElpsHNmmEpiHcdQGwDCIeb4GOVPxhnui073RK/5YeglVMhXfA6IP0
 MdhPhGdHUrUo0upduGaKyaN3YwCe1ytCu+GvAbLwFuuj7rB56M576fDtqW3q5X1Dq40a
 lJ0A==
X-Gm-Message-State: APjAAAUGEtn74mtrQXkvb3HFs2ryS7edFWcn0HJXoQuZm/oaDuWWWjuD
 NYT9CFWMV87dc6I7gEB57HQidanLITRdqw==
X-Google-Smtp-Source: APXvYqx/HE1bCksu4ZOMV0myleKiDhQNvoIpA4CoALL5D9erjf+wDxA7j1W9ZJpPAadQdy4/y36B6A==
X-Received: by 2002:a05:6000:142:: with SMTP id
 r2mr3251793wrx.212.1568126676765; 
 Tue, 10 Sep 2019 07:44:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a192sm5703814wma.1.2019.09.10.07.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 07:44:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 15:44:20 +0100
Message-Id: <20190910144428.32597-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910144428.32597-1-peter.maydell@linaro.org>
References: <20190910144428.32597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 05/13] target/arm/arm-semi: Factor out
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
 target/arm/arm-semi.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index ce3ba554bef..f3e0bf77cd3 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -116,6 +116,7 @@ static int open_modeflags[12] = {
 typedef enum GuestFDType {
     GuestFDUnused = 0,
     GuestFDHost = 1,
+    GuestFDGDB = 2,
 } GuestFDType;
 
 /*
@@ -179,14 +180,14 @@ static GuestFD *do_get_guestfd(int guestfd)
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
 
@@ -337,6 +338,37 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_syscall_complete_cb cb,
     return is_a64(env) ? env->xregs[0] : env->regs[0];
 }
 
+/*
+ * Types for functions implementing various semihosting calls
+ * for specific types of guest file descriptor. These must all
+ * do the work and return the required return value for the guest,
+ * setting the guest errno if appropriate.
+ */
+typedef uint32_t sys_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf);
+
+static uint32_t host_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
+{
+    return set_swi_errno(ts, close(gf->hostfd));
+}
+
+static uint32_t gdb_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
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
@@ -452,11 +484,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return set_swi_errno(ts, -1);
         }
 
-        if (use_gdb_syscalls()) {
-            ret = arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
-        } else {
-            ret = set_swi_errno(ts, close(gf->hostfd));
-        }
+        ret = guestfd_fns[gf->type].closefn(ts, cpu, gf);
         dealloc_guestfd(arg0);
         return ret;
     case TARGET_SYS_WRITEC:
-- 
2.20.1


