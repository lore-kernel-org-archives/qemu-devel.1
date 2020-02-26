Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD36C4BA13
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1482B21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJ07rjUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1482B21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ybn-000637-7u
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 10:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6yaq-0005Tv-03
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:27:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6yao-0001Om-Hv
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:27:23 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6yao-0001L6-9V
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:27:22 -0500
Received: by mail-wr1-x443.google.com with SMTP id e8so3555224wrm.5
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 07:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dv7Dxwk2EOL91ONyIJ37RrEIbEVFccpjybkrT6dJ72Y=;
 b=UJ07rjUFRGvGcyMu9AQxaPZ1BnIJpc2ZfcjNIZ0pHVPxQbfD9tLLi1XbZ6lUahctkl
 TFlEdUmrQ9TYpqfgHYO8Z8LJitQE/+M8PrNJO3t1W8oZnPq/AQRIBHSgWoFXbUc5p18R
 bLIyQlrr7IHVkyTKjiuNwIyCwGJ1FM7Ve8g/0EQk9MS35KxeIJBDTRX9mlv9iq4qcDgO
 KYtX1hl2fwmvzbYdHb/TdEgnIlSGhbjMS0Mt0h+9Q41Rg0zUsVBT7rYIB2j11l4vMPfA
 fVD3aZOGM68WvCxe28xCzH776XkC2gvh4tqxPmKHAhESOw/Q4LQLv/IXvrHmjCInPUmG
 v7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dv7Dxwk2EOL91ONyIJ37RrEIbEVFccpjybkrT6dJ72Y=;
 b=QBdw+YQLeh6ZE64X6g6c2wh1BXPPFpDsII8oUS41NCCwrB7G2SZ0G64Kv2SQHlbFkM
 oE6+wVQHwBgn0fVRPTuF+qv9kvfIJL/A3CkLoHNGutNIq6Qgyql809WiREIW7eaqIEaS
 VWEKXpoWAw0qab+SD1jzJ4jlX+giYrqdwDRkLO718Xfxa76qLDBLQuAMyOpb+6dlJ1hk
 NBDoAJzgM94VzlPHmFET1qT3TpE9GDmt1uNU2dsYUSCz17rzott74zC87VKTn3s4FSAT
 rLlsCiLTQWr5am1XdG2fvKPbIZb2SRvx/PQ2MR2NfqGS1ukHC2b6sf0rYAuUH38VKyyo
 sawg==
X-Gm-Message-State: APjAAAVQlM9YWxrQl9vAaoGNB+G0pIH2Uada7Kn5BocW1pYdVfrbCTdd
 sies7ZEnpwroFOi80N18p1VslQ==
X-Google-Smtp-Source: APXvYqwpkVY/FUk3n9JcVqzz8llkdGMlQq6CLJtDAnfzqseq9kGjNJ9LCJCN94rLH7GcpjTC+kJEzA==
X-Received: by 2002:adf:b19e:: with SMTP id q30mr325777wra.163.1582730840869; 
 Wed, 26 Feb 2020 07:27:20 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j12sm3697753wrt.35.2020.02.26.07.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 07:27:19 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ACD9C1FF87;
 Wed, 26 Feb 2020 15:27:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] accel/tcg: remove link between guest ram and TCG cache size
Date: Wed, 26 Feb 2020 15:27:10 +0000
Message-Id: <20200226152710.31751-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
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
Cc: f4bug@amsat.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Basing the TB cache size on the ram_size was always a little heuristic
and was broken by a1b18df9a4 which caused ram_size not to be fully
realised at the time we initialise the TCG translation cache.

At the same time the default code generation size seems mainly set to
deal with the fact we use a static code buffer for CONFIG_USER to
avoid mmap allocation problems on constrained systems. So we:

  - only use a static code buffer on 32 bit systems
  - up the default buffer size for bigger systems
  - ignore the ram_size and just go with the default
  - document the fact tb-size is ignored for 32 bit linux-user

The could potentially slow down softmmu emulation on 32 bit systems
with lots (3gb?) of spare memory. Those users can still manually up
the tb-size via the command line if they do in fact exist.

Fixes: a1b18df9a4
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>
---
 accel/tcg/translate-all.c | 23 ++++++++++-------------
 qemu-options.hx           |  3 ++-
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index a08ab11f657..cdfa2db7c56 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -891,11 +891,12 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
     }
 }
 
-#if defined(CONFIG_USER_ONLY)
-/* Currently it is not recommended to allocate big chunks of data in
-   user mode. It will change when a dedicated libc will be used.  */
-/* ??? 64-bit hosts ought to have no problem mmaping data outside the
-   region in which the guest needs to run.  Revisit this.  */
+#if defined(CONFIG_USER_ONLY) && TCG_TARGET_REG_BITS == 32
+/*
+ * For user mode on smaller 32 bit systems we may run into trouble
+ * allocating big chunks of data in the right place. On these systems
+ * we utilise a static code generation buffer directly in the binary.
+ */
 #define USE_STATIC_CODE_GEN_BUFFER
 #endif
 
@@ -927,7 +928,11 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
 # define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 #endif
 
+#if TCG_TARGET_REG_BITS == 32
 #define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32u * 1024 * 1024)
+#else
+#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (2ul * 1024 * 1024 * 1024)
+#endif
 
 #define DEFAULT_CODE_GEN_BUFFER_SIZE \
   (DEFAULT_CODE_GEN_BUFFER_SIZE_1 < MAX_CODE_GEN_BUFFER_SIZE \
@@ -937,15 +942,7 @@ static inline size_t size_code_gen_buffer(size_t tb_size)
 {
     /* Size the buffer.  */
     if (tb_size == 0) {
-#ifdef USE_STATIC_CODE_GEN_BUFFER
         tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
-#else
-        /* ??? Needs adjustments.  */
-        /* ??? If we relax the requirement that CONFIG_USER_ONLY use the
-           static buffer, we could size this on RESERVED_VA, on the text
-           segment size of the executable, or continue to use the default.  */
-        tb_size = (unsigned long)(ram_size / 4);
-#endif
     }
     if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
         tb_size = MIN_CODE_GEN_BUFFER_SIZE;
diff --git a/qemu-options.hx b/qemu-options.hx
index ac315c1ac45..0a4bbdb8eb9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -139,7 +139,8 @@ irqchip completely is not recommended except for debugging purposes.
 @item kvm-shadow-mem=size
 Defines the size of the KVM shadow MMU.
 @item tb-size=@var{n}
-Controls the size (in MiB) of the TCG translation block cache.
+Controls the size (in MiB) of the TCG translation block cache. It has no effect on
+32 bit linux-user binaries.
 @item thread=single|multi
 Controls number of TCG threads. When the TCG is multi-threaded there will be one
 thread per vCPU therefor taking advantage of additional host cores. The default
-- 
2.20.1


