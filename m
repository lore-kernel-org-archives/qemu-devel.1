Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226E5C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF292089C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJKnFce9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF292089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3JG-00081L-G6
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qI-0004X4-WD
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qG-0007fx-P0
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qG-0007eK-IR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id r5so20331761wrm.12
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5ohawpNw7FOSifxHQ0WSHjghmndfNAKI8xtNIQ3mnWg=;
 b=YJKnFce974WKIM12C9wR5UhHOBZhyv2LukU2+KABcQHbJhEFpB8e2X5BXiYtwQUQ+h
 KJaNFsF1u7vPteoYZoNWe7oK1VmTtMLun5tKgR+Gy288lzu/sx9iXh+b7VMu25qTpGmM
 qMmMAL/HJq+9Faasbrcomgc6Wsfz8sPWa4ylm0aareltHOyzRduWVXOMENVZ1HsZO6lk
 JC30xs2uF14oIYtcqQ5yRviW4W5vgELW1m3vw92hthoeQhtDEy49dLK/HNTFoS2BYMU8
 ETZH9E5PLLcVGxPrfDoozxqU+Ec7daKEz0NryMLA4xryGe3Ena52uPX55meZ9UjsWpZX
 OIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5ohawpNw7FOSifxHQ0WSHjghmndfNAKI8xtNIQ3mnWg=;
 b=XPPwb73L/TrxB4ngGs/SAKjMIP1VWWph9fLBaczgL5OyDC6pKHpBysiWg9P/32Knjk
 DJnIzyoZt66VsLChmWRV/5OsBO4CJi9jOtAbdfA1EwazibMPxI1jFAj3NmP0NYiqPtz2
 aJkRmJpcYybXWJbQ/Fycj2WggPCPwBsU3wByMka2ZXpiIUSb9G2Dw7X/mCQeqmUckhCz
 D1y4I8IQxTBqxEc+dJZbwkgdnUGLuS+zYyx3oyKpfS5xrORyZ7E6jiU+car1+AV4wYc0
 /gloZ+iua9sNEp1BCDCyAY9iw2Y+dgcjdJvBh8yz2bbZlWMh5LIaZIWiD9TTiUJC/4Ac
 kN+w==
X-Gm-Message-State: APjAAAXhibkfAj+cnQyCDrnp3kEaWaXB16CGtysOXHM1pv8E9WagdFH8
 EMMFuBkRdLUE4u2GzOcZ+I9bpqItStUx+w==
X-Google-Smtp-Source: APXvYqzYTDvziKNxNi/sQHQiCmbaGjekSusYEYmrS1WNA0w24s4b/+G3jMGzOyyakxMJzcPN8TtWig==
X-Received: by 2002:a5d:558b:: with SMTP id i11mr14749983wrv.166.1571069102405; 
 Mon, 14 Oct 2019 09:05:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/68] target/arm/arm-semi: Factor out implementation of
 SYS_CLOSE
Date: Mon, 14 Oct 2019 17:03:27 +0100
Message-Id: <20191014160404.19553-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190916141544.17540-8-peter.maydell@linaro.org
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


