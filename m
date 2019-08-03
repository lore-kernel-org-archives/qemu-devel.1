Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977B3C433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 21:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5706A21726
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 21:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="atruJesB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5706A21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hu1IN-0005sO-N6
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 17:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52055)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hu1GL-00017A-Q8
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 17:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hu1GK-0005Th-3V
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 17:08:25 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hu1GJ-0005Nn-SA
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 17:08:24 -0400
Received: by mail-pg1-x541.google.com with SMTP id i18so37754443pgl.11
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 14:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ijiZOLpvZs8wYEcrSua+yyDmUDcG7PPSoeYhYrFW+FU=;
 b=atruJesBQmmDOSQE6mv5huwgbTxeK5blO5CxhiFkeECgtegRHtIof0HSIT75p79my0
 fTm2VLv8gh382rxTvg4qrtlzfwT6xOMv+1fqVP6G1MnRfxmlVKftdZs8nZWZlYmkJT74
 Xt+2AW2z+c0gIexCFZmxsnJCf2YCazy+9i/iKOW0hYS5X08DPCL35nvsNa0f6e4PZqZt
 /Zo/WpB3UoIH4VZW/TGQOEW8CeDUHwyexDGb/4JLybW1btrMyIbmasPzs9JgxnmtEfQp
 uVaJh3bUqOellP+u2P+xfZVqXAuGUaDzhs0QIZDmsAFboxClIqpdLKkaeKbJc4h1zatd
 yfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ijiZOLpvZs8wYEcrSua+yyDmUDcG7PPSoeYhYrFW+FU=;
 b=aPUurZg+uC3raIGFd6xzuBPQNz2eTPN+SE52vDUDGlC9HP+yvVTh5aMefMQ3G92aaV
 GFBH28YUT4oICwHJ6M6QvoxRVDZMl4buCI5k9VFspnYcShXBXEhnwZ7VzGeRKeBfoeiz
 HDgvFOIMarmRhVlGn3xMGxMWSMb0AtzmUNOyc2k38bDd7xKrNeThcJrCWzKK+l+B9r2g
 bfRteYumCoAHD5CIMLnlDNis5x1xwxP/8r9806A/XPUt2zvMZIe9pV8YGX9j6d3mdgCQ
 Iw/mEuQ1HtnjI7rtDl8153PcjotZkL7Rxi7DgoWE5WfLQ5QX+iwig82SOW+uO3hJk/vg
 ZBgA==
X-Gm-Message-State: APjAAAXpgcb6Wu+Q8GDISPvTBmF7NVglUJIC/lmzO2K6kOnhOhYKIInK
 bo5rCwMa+Td9bDIG2BrlKESxJdnK1Iw=
X-Google-Smtp-Source: APXvYqyD30GknKiPzRFZVc8ceTZZnxa3eNkZs1R4sQV5ft0Le2oVvqbhlZk/SmKWxG0YptgkEkMN6g==
X-Received: by 2002:a62:be04:: with SMTP id l4mr63898674pff.77.1564866493177; 
 Sat, 03 Aug 2019 14:08:13 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id x25sm110129644pfa.90.2019.08.03.14.08.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 14:08:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 14:08:02 -0700
Message-Id: <20190803210803.5701-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803210803.5701-1-richard.henderson@linaro.org>
References: <20190803210803.5701-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v7 5/6] linux-user: Parse
 NT_GNU_PROPERTY_TYPE_0 notes
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
 Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For aarch64, this includes the GNU_PROPERTY_AARCH64_FEATURE_1_BTI bit,
which indicates that the image should be mapped with guarded pages.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 94 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 86 insertions(+), 8 deletions(-)
---

Note: The behaviour here when GNU_PROPERTY_AARCH64_FEATURE_1_BTI
is present differs from Dave's v1 patch set, in which the kernel
refuses to load the binary if the host does not support BTI.

However, I feel that's not the best way to introduce a feature
that adds security and is otherwise designed to be backward
compatible to such hosts.  We should want entire distributions
to be built indicating compatibility with BTI via this markup.

I included this rationale in my review of Dave's patch set.


r~


diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index bd43c4817d..d18e7dd313 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2289,7 +2289,7 @@ static void load_elf_image(const char *image_name, int image_fd,
     struct elfhdr *ehdr = (struct elfhdr *)bprm_buf;
     struct elf_phdr *phdr;
     abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
-    int i, retval;
+    int i, retval, prot_exec = PROT_EXEC;
     const char *errmsg;
 
     /* First of all, some simple consistency checks */
@@ -2324,17 +2324,89 @@ static void load_elf_image(const char *image_name, int image_fd,
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
+        } else if (eppnt->p_type == PT_GNU_PROPERTY) {
+#ifdef TARGET_AARCH64
+            /*
+             * Process NT_GNU_PROPERTY_TYPE_0.
+             *
+             * TODO: For AArch64, the PT_GNU_PROPERTY is authoritative:
+             * it is present if and only if NT_GNU_PROPERTY_TYPE_0 is.
+             * That may or may not be true for other architectures.
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
+                /*
+                 * Elf notes are backward compatible to older cpus.
+                 * Do not enable unless it is supported.
+                 */
+                ARMCPU *cpu = ARM_CPU(thread_cpu);
+                if (cpu_isar_feature(aa64_bti, cpu)) {
+                    prot_exec |= TARGET_PROT_BTI;
+                }
+            }
+#endif /* TARGET_AARCH64 */
         }
     }
 
@@ -2394,9 +2466,15 @@ static void load_elf_image(const char *image_name, int image_fd,
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


