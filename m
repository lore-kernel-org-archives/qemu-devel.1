Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CCAC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E1D2075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHI2qAKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E1D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50060 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYd8Y-00060D-Rp
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 17:07:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYcyP-0006Ot-3e
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYcyL-0000N2-8q
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:57:27 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYcyI-00005E-4K
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:57:23 -0400
Received: by mail-ot1-x341.google.com with SMTP id 107so2060207otj.8
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 13:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=jLJZRLTAFOL7hrqtZKjJ5DWxzgzN1ppLIoLLfp8TQiM=;
	b=nHI2qAKF8DVhaGVta3M8y934YeYSfHsN6rW2M4NWEqfw/rOXiJHAanGayDqYpgaJjg
	HxkPybsYI3s+FTHw7lI5YqsKIOnYC+HAO0qhnuc9WtZjwxGoIj9yy1+MB9bjHurIHXIi
	wk5BNxiNgLTpvrWq9bsKaz1p7A0pvIsU5Bd5+rZGGwhlLKctP7664+bEIK6FEX/PD0ZM
	2pL/ek67fogTVm9CDhX4hzbZdZqzy4sXJYUdrNJeBROdGpUtIuNrruGp15DBmJm7UqPf
	lGqsZIYCkbHOIdoUd0i1+RqxT0O9VgMjOLs2P1I13srZl2VASGbeMgfzG/tY85+zstIK
	qS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=jLJZRLTAFOL7hrqtZKjJ5DWxzgzN1ppLIoLLfp8TQiM=;
	b=sdrm3Tx4oGn5zKBVS5w6/7avDkOX8qdYjGl8/idt+CpDr6QGgfYJ1y2uEQlZWbsEUO
	haeBl0femjht5Y+1asKJ2P6sIhDC7nIn+XBIjbxZ4YnE4a6nn7lOl2LQoKj9KCegVE1K
	htLHZJ8q4mFqxfPBGheHojRg0tB3sCGsF5962UR3dxKEpESRgyXihGpJPD8WDfWhXNBJ
	zVYnz+O7iXFDsR9AkhT/iqEk4LZ1ufT9XIE411suy9XvSL8vaxwwUhTzuIcU+Fjh0IYA
	e4UDgo9TfmXsXo/wk+bvd6Z+Na8bWKJPgJVz70zsrClaiDInAV1w6wdn+2RsbXNl50Xk
	Fe7Q==
X-Gm-Message-State: APjAAAXoNxbjGt+D6hVT+XlZFLLFSETn33n2GBodlm0f521VhHjswWb0
	rJntqoVHTm9Tgj+j1CXAetdPQQI2V99Tyg==
X-Google-Smtp-Source: APXvYqzPHMhHLYrh2ztWxc8CLuO9imbOQ8AkvPiVPRaq3o1KkaFWCtFPaYA42jrQX83XDvxpUleMrg==
X-Received: by 2002:a9d:2f69:: with SMTP id h96mr11289872otb.366.1559768239896;
	Wed, 05 Jun 2019 13:57:19 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id f5sm7414155otl.51.2019.06.05.13.57.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 13:57:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 15:57:05 -0500
Message-Id: <20190605205706.569-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605205706.569-1-richard.henderson@linaro.org>
References: <20190605205706.569-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: [Qemu-devel] [PATCH v6 5/6] linux-user: Parse
 NT_GNU_PROPERTY_TYPE_0 notes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For aarch64, this includes the GNU_PROPERTY_AARCH64_FEATURE_1_BTI bit,
which indicates that the image should be mapped with guarded pages.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 83 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 8 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a57b7049dd..1a12c60a33 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2253,7 +2253,7 @@ static void load_elf_image(const char *image_name, int image_fd,
     struct elfhdr *ehdr = (struct elfhdr *)bprm_buf;
     struct elf_phdr *phdr;
     abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
-    int i, retval;
+    int i, retval, prot_exec = PROT_EXEC;
     const char *errmsg;
 
     /* First of all, some simple consistency checks */
@@ -2288,17 +2288,78 @@ static void load_elf_image(const char *image_name, int image_fd,
     loaddr = -1, hiaddr = 0;
     info->alignment = 0;
     for (i = 0; i < ehdr->e_phnum; ++i) {
-        if (phdr[i].p_type == PT_LOAD) {
-            abi_ulong a = phdr[i].p_vaddr - phdr[i].p_offset;
+        struct elf_phdr *eppnt = phdr + i;
+
+        if (eppnt->p_type == PT_LOAD) {
+            abi_ulong a = eppnt->p_vaddr - eppnt->p_offset;
             if (a < loaddr) {
                 loaddr = a;
             }
-            a = phdr[i].p_vaddr + phdr[i].p_memsz;
+            a = eppnt->p_vaddr + eppnt->p_memsz;
             if (a > hiaddr) {
                 hiaddr = a;
             }
             ++info->nsegs;
-            info->alignment |= phdr[i].p_align;
+            info->alignment |= eppnt->p_align;
+        } else if (eppnt->p_type == PT_NOTE) {
+#ifdef TARGET_AARCH64
+            /*
+             * Process NT_GNU_PROPERTY_TYPE_0.
+             *
+             * TODO: The only item that is AArch64 specific is the
+             * GNU_PROPERTY_AARCH64_FEATURE_1_AND processing at the end.
+             * If we were to ever process GNU_PROPERTY_X86_*, all of the
+             * code through checking the gnu0 magic number is sharable.
+             * But for now, since this *is* only used by AArch64, don't
+             * process the note elsewhere.
+             */
+            const uint32_t gnu0_magic = const_le32('G' | 'N' << 8 | 'U' << 16);
+            uint32_t note[7];
+
+            /*
+             * The note contents are 7 words, but depending on LP64 vs ILP32
+             * there may be an 8th padding word at the end.  Check for and
+             * read the minimum size.  Further checks below will validate
+             * that the sizes of everything involved are as we expect.
+             */
+            if (eppnt->p_filesz < sizeof(note)) {
+                continue;
+            }
+            if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
+                memcpy(note, bprm_buf + eppnt->p_offset, sizeof(note));
+            } else {
+                retval = pread(image_fd, note, sizeof(note), eppnt->p_offset);
+                if (retval != sizeof(note)) {
+                    goto exit_perror;
+                }
+            }
+#ifdef BSWAP_NEEDED
+            for (i = 0; i < ARRAY_SIZE(note); ++i) {
+                bswap32s(note + i);
+            }
+#endif
+            /*
+             * Check that this is a NT_GNU_PROPERTY_TYPE_0 note.
+             * Again, descsz includes padding.  Full size validation
+             * awaits checking the final payload.
+             */
+            if (note[0] != 4 ||                       /* namesz */
+                note[1] < 12 ||                       /* descsz */
+                note[2] != NT_GNU_PROPERTY_TYPE_0 ||  /* type */
+                note[3] != gnu0_magic) {              /* name */
+                continue;
+            }
+            /*
+             * Check for the BTI feature.  If present, this indicates
+             * that all the executable pages of the binary should be
+             * mapped with PROT_BTI, so that branch targets are enforced.
+             */
+            if (note[4] == GNU_PROPERTY_AARCH64_FEATURE_1_AND &&
+                note[5] == 4 &&
+                (note[6] & GNU_PROPERTY_AARCH64_FEATURE_1_BTI)) {
+                prot_exec |= TARGET_PROT_BTI;
+            }
+#endif /* TARGET_AARCH64 */
         }
     }
 
@@ -2358,9 +2419,15 @@ static void load_elf_image(const char *image_name, int image_fd,
             abi_ulong vaddr, vaddr_po, vaddr_ps, vaddr_ef, vaddr_em, vaddr_len;
             int elf_prot = 0;
 
-            if (eppnt->p_flags & PF_R) elf_prot =  PROT_READ;
-            if (eppnt->p_flags & PF_W) elf_prot |= PROT_WRITE;
-            if (eppnt->p_flags & PF_X) elf_prot |= PROT_EXEC;
+            if (eppnt->p_flags & PF_R) {
+                elf_prot |= PROT_READ;
+            }
+            if (eppnt->p_flags & PF_W) {
+                elf_prot |= PROT_WRITE;
+            }
+            if (eppnt->p_flags & PF_X) {
+                elf_prot |= prot_exec;
+            }
 
             vaddr = load_bias + eppnt->p_vaddr;
             vaddr_po = TARGET_ELF_PAGEOFFSET(vaddr);
-- 
2.17.1


