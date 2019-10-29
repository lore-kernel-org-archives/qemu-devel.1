Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F12DCA9EC0
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 00:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D541208C0
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 00:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D541208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPF5m-0000sk-4y
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 20:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevans@FreeBSD.org>) id 1iPF3M-00078y-Jy
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 20:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevans@FreeBSD.org>) id 1iPF3K-0001NC-LN
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 20:08:04 -0400
Received: from mx2.freebsd.org ([96.47.72.81]:61982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevans@FreeBSD.org>) id 1iPF3K-0001MX-HP
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 20:08:02 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client CN "mx1.freebsd.org",
 Issuer "Let's Encrypt Authority X3" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id E963689CA0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 00:08:00 +0000 (UTC)
 (envelope-from kevans@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org",
 Issuer "Let's Encrypt Authority X3" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 472Bk84dslz4g0l;
 Tue, 29 Oct 2019 00:08:00 +0000 (UTC)
 (envelope-from kevans@FreeBSD.org)
Received: from shiva.audeuro.com (unknown [209.182.120.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: kevans/mail)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 151C517EF6;
 Tue, 29 Oct 2019 00:07:59 +0000 (UTC)
 (envelope-from kevans@FreeBSD.org)
Date: Mon, 28 Oct 2019 19:07:57 -0500
From: Kyle Evans <kevans@FreeBSD.org>
To: qemu-devel@nongnu.org
Subject: safe_syscall design guidance
Message-ID: <20191029000757.r2ma5qt3zoic5ynd@shiva.audeuro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 96.47.72.81
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
Cc: kevans@FreeBSD.org, imp@FreeBSD.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

We're working on improving bsd-user in a local tree and rebasing forward
to get our work suitable for upstreaming. I'm porting the safe_syscall stuff
over to bsd-user, and would like to get some design guidance as it may best
be implemented with some refactoring of linux-user.

Below is an example of the refactoring my initial approach takes. I'm
omitting !x86_64 in this e-mail because it's all along the same lines and
only including the part relevant to linux-user. Effectively, linux-user/host
is moved to qemu-user/host along with ^/linux-user/safe-syscall.S.

Some bits specific to FreeBSD, also likely other *BSD but I've not yet
verified, are sprinkled throughout host/*/* parts; this is the main point I
suspect may be objectionable. FreeBSD indicates syscall error differently
than Linux, and *context bits are also different. Other OS-specific bits
for other arch are similar to the diff below.

A full version of this can be found in my tree, currently only available on
GitHub: https://github.com/kevans91/qemu-bsd-user/tree/safe_syscall -- this
is applied to our version, currently based on qemu 3.1.

Thoughts?

Thanks,

Kyle Evans
diff --git a/Makefile.target b/Makefile.target
index 61f28d3722..13b3b13706 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -113,7 +113,7 @@ obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 ifdef CONFIG_LINUX_USER
 
 QEMU_CFLAGS+=-I$(SRC_PATH)/linux-user/$(TARGET_ABI_DIR) \
-             -I$(SRC_PATH)/linux-user/host/$(ARCH) \
+             -I$(SRC_PATH)/qemu-user/host/$(ARCH) \
              -I$(SRC_PATH)/linux-user
 
 obj-y += linux-user/
@@ -128,6 +128,7 @@ ifdef CONFIG_BSD_USER
 
 QEMU_CFLAGS+=-I$(SRC_PATH)/bsd-user/$(TARGET_ABI_DIR) \
              -I$(SRC_PATH)/bsd-user/$(HOST_VARIANT_DIR) \
+             -I$(SRC_PATH)/qemu-user/host/$(ARCH) \
              -I$(SRC_PATH)/bsd-user \
              -D_WANT_SEMUN
 obj-y += bsd-user/
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 769b8d8336..6089fc3a06 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -1,6 +1,6 @@
 obj-y = main.o syscall.o strace.o mmap.o signal.o \
 	elfload.o linuxload.o uaccess.o uname.o \
-	safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
+	../qemu-user/safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
         $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o
 
 obj-$(TARGET_HAS_BFLT) += flatload.o
diff --git a/linux-user/host/x86_64/hostdep.h b/qemu-user/host/x86_64/hostdep.h
similarity index 78%
rename from linux-user/host/x86_64/hostdep.h
rename to qemu-user/host/x86_64/hostdep.h
index a4fefb5114..7aa233a116 100644
--- a/linux-user/host/x86_64/hostdep.h
+++ b/qemu-user/host/x86_64/hostdep.h
@@ -21,11 +21,17 @@
 extern char safe_syscall_start[];
 extern char safe_syscall_end[];
 
+#ifndef __FreeBSD__
+#define DEFINE_PCREG(puc)	&((ucontext_t *)(puc))->uc_mcontext.gregs[REG_RIP]
+#else
+typedef __register_t greg_t;
+#define DEFINE_PCREG(puc)   &((ucontext_t *)(puc))->uc_mcontext.mc_rip
+#endif
+
 /* Adjust the signal context to rewind out of safe-syscall if we're in it */
 static inline void rewind_if_in_safe_syscall(void *puc)
 {
-    ucontext_t *uc = puc;
-    greg_t *pcreg = &uc->uc_mcontext.gregs[REG_RIP];
+    greg_t *pcreg = DEFINE_PCREG(puc);
 
     if (*pcreg > (uintptr_t)safe_syscall_start
         && *pcreg < (uintptr_t)safe_syscall_end) {
diff --git a/linux-user/host/x86_64/safe-syscall.inc.S b/qemu-user/host/x86_64/safe-syscall.inc.S
similarity index 98%
rename from linux-user/host/x86_64/safe-syscall.inc.S
rename to qemu-user/host/x86_64/safe-syscall.inc.S
index f36992daa3..2b52e122d4 100644
--- a/linux-user/host/x86_64/safe-syscall.inc.S
+++ b/qemu-user/host/x86_64/safe-syscall.inc.S
@@ -72,6 +72,11 @@ safe_syscall_start:
         syscall
 safe_syscall_end:
         /* code path for having successfully executed the syscall */
+#ifdef __FreeBSD__
+        jnb 2f
+        neg	%rax
+2:
+#endif
         pop     %rbp
         .cfi_remember_state
         .cfi_def_cfa_offset 8
diff --git a/linux-user/safe-syscall.S b/qemu-user/safe-syscall.S
similarity index 100%
rename from linux-user/safe-syscall.S
rename to qemu-user/safe-syscall.S

