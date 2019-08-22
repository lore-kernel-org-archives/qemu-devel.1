Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DB3C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 19:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433DD233A2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 19:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="abEnu8Ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433DD233A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0sLS-0006rQ-3o
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 15:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0sJ6-0005Ps-9o
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0sJ5-0004Q2-3O
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:59:36 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0sJ4-0004PB-Gm
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:59:34 -0400
Received: by mail-pf1-x442.google.com with SMTP id f17so4559603pfn.6
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JEmEzPFUR0isRb5JQ5Z7wSqHYLVLETQrUR8Yc9g4NhM=;
 b=abEnu8CkM/9kBWuTfT9N7ZLJPePRAqPsXyr3fG9kz5XWj6F33cXwt8kaf+k5b8yx/g
 V/bu2G08j5BX/U9GkdzUKamffjAdOB92eL5pW/gyPjmYzUkTgGxKqDsotWuSxyw/tPEB
 6QbHHzqpzzEMob27e3qTMIqufm9y2znOHnlISWdin1LTuqcgnNjtZyGc/gUhoYp68KtL
 BtdP4k2pIJR5Cw287fskR+AjvdWYEBKAW3gVEKbf+SvNhI210rVFJnyCBbqp2vmHMnZG
 CWn5s9Xx5kk50xuRxQI1nXw///uP5szjMX3VIKyRRRkQMVu0kR4uJMxloVGqPtc2o1f+
 k5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JEmEzPFUR0isRb5JQ5Z7wSqHYLVLETQrUR8Yc9g4NhM=;
 b=ll8qJ56VSN9W2FCb5x5yPd0e7yQMLsoKUpR+J2uzhc1ckvCMGKRfjzMpK26uJzglot
 pqQDZHPN5oAqYk2QAqkjCkg0jnk9jX9a1jfFUyw8tP/NLeba4bxyW515kpwKJmQ2/Jij
 gsKi3t/aoZkb+49c0Tl+ZgoNk4ChrGbBINHh/MeSRlSgEVQjuJeIZQJibDL+PMNKug3Y
 NCjaC6o4l2ymDiXd+2/C0W9QXki4TiDyTSQBtZwiZ53j0j20ASJQoLFMKxZrxpc1t8VK
 Yg+ErWXf621UbYEG/GrbCT+wa2nMTSaz8DSK0s5yl/lp61JCagAn7JKceGusarBosvZ5
 FHUQ==
X-Gm-Message-State: APjAAAVHZtrN6isIIQWgaRR+IkEh5muqh+G/sVCtY1hbopo7IccjPMCr
 KfuLNcrDMtwwWz6wkf8q90fHy8gVjsc=
X-Google-Smtp-Source: APXvYqwavJBOjWP/EV4LuDA1nZQNXi56nZQoLFd4TgdI7DhhfKlhThe/X4fcAymZkiE59Xe6DZy7hA==
X-Received: by 2002:a63:4e05:: with SMTP id c5mr597564pgb.396.1566500372874;
 Thu, 22 Aug 2019 11:59:32 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z14sm287172pjr.23.2019.08.22.11.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2019 11:59:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 11:59:28 -0700
Message-Id: <20190822185929.16891-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822185929.16891-1-richard.henderson@linaro.org>
References: <20190822185929.16891-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 1/2] linux-user: Pass CPUState to
 MAX_RESERVED_VA
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
Cc: peter.maydell@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Turn the scalar macro into a functional macro.  Move the creation
of the cpu up a bit within main() so that we can pass it to the
invocation of MAX_RESERVED_VA.  Delay the validation of the -R
parameter until MAX_RESERVED_VA is computed.

So far no changes to any of the MAX_RESERVED_VA macros to actually
use the cpu in any way, but ARM will need it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/target_cpu.h |  2 +-
 linux-user/main.c           | 43 +++++++++++++++++++++----------------
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
index 8a3764919a..279ea532d5 100644
--- a/linux-user/arm/target_cpu.h
+++ b/linux-user/arm/target_cpu.h
@@ -21,7 +21,7 @@
 
 /* We need to be able to map the commpage.
    See validate_guest_space in linux-user/elfload.c.  */
-#define MAX_RESERVED_VA  0xffff0000ul
+#define MAX_RESERVED_VA(CPU)  0xffff0000ul
 
 static inline void cpu_clone_regs(CPUARMState *env, target_ulong newsp)
 {
diff --git a/linux-user/main.c b/linux-user/main.c
index 47917bbb20..35da3bf14c 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -78,12 +78,12 @@ int have_guest_base;
       (TARGET_LONG_BITS == 32 || defined(TARGET_ABI32))
 /* There are a number of places where we assign reserved_va to a variable
    of type abi_ulong and expect it to fit.  Avoid the last page.  */
-#   define MAX_RESERVED_VA  (0xfffffffful & TARGET_PAGE_MASK)
+#   define MAX_RESERVED_VA(CPU)  (0xfffffffful & TARGET_PAGE_MASK)
 #  else
-#   define MAX_RESERVED_VA  (1ul << TARGET_VIRT_ADDR_SPACE_BITS)
+#   define MAX_RESERVED_VA(CPU)  (1ul << TARGET_VIRT_ADDR_SPACE_BITS)
 #  endif
 # else
-#  define MAX_RESERVED_VA  0
+#  define MAX_RESERVED_VA(CPU)  0
 # endif
 #endif
 
@@ -357,8 +357,7 @@ static void handle_arg_reserved_va(const char *arg)
         unsigned long unshifted = reserved_va;
         p++;
         reserved_va <<= shift;
-        if (reserved_va >> shift != unshifted
-            || (MAX_RESERVED_VA && reserved_va > MAX_RESERVED_VA)) {
+        if (reserved_va >> shift != unshifted) {
             fprintf(stderr, "Reserved virtual address too big\n");
             exit(EXIT_FAILURE);
         }
@@ -607,6 +606,7 @@ int main(int argc, char **argv, char **envp)
     int i;
     int ret;
     int execfd;
+    unsigned long max_reserved_va;
 
     error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
@@ -672,24 +672,31 @@ int main(int argc, char **argv, char **envp)
     /* init tcg before creating CPUs and to get qemu_host_page_size */
     tcg_exec_init(0);
 
-    /* Reserving *too* much vm space via mmap can run into problems
-       with rlimits, oom due to page table creation, etc.  We will still try it,
-       if directed by the command-line option, but not by default.  */
-    if (HOST_LONG_BITS == 64 &&
-        TARGET_VIRT_ADDR_SPACE_BITS <= 32 &&
-        reserved_va == 0) {
-        /* reserved_va must be aligned with the host page size
-         * as it is used with mmap()
-         */
-        reserved_va = MAX_RESERVED_VA & qemu_host_page_mask;
-    }
-
     cpu = cpu_create(cpu_type);
     env = cpu->env_ptr;
     cpu_reset(cpu);
-
     thread_cpu = cpu;
 
+    /*
+     * Reserving too much vm space via mmap can run into problems
+     * with rlimits, oom due to page table creation, etc.  We will
+     * still try it, if directed by the command-line option, but
+     * not by default.
+     */
+    max_reserved_va = MAX_RESERVED_VA(cpu);
+    if (reserved_va != 0) {
+        if (max_reserved_va && reserved_va > max_reserved_va) {
+            fprintf(stderr, "Reserved virtual address too big\n");
+            exit(EXIT_FAILURE);
+        }
+    } else if (HOST_LONG_BITS == 64 && TARGET_VIRT_ADDR_SPACE_BITS <= 32) {
+        /*
+         * reserved_va must be aligned with the host page size
+         * as it is used with mmap()
+         */
+        reserved_va = max_reserved_va & qemu_host_page_mask;
+    }
+
     if (getenv("QEMU_STRACE")) {
         do_strace = 1;
     }
-- 
2.17.1


