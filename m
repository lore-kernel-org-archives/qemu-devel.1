Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2105C35257
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 22:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC81A2065D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 22:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BP9MX9Oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC81A2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOTCF-0001pr-GR
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 18:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOT64-0002lC-LQ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 18:00:12 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOT62-0007Po-18
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 18:00:12 -0400
Received: by mail-ot1-x344.google.com with SMTP id g96so2861603otb.12
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 15:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UmXRKUbKgXmhfW+77FLjDFzejAZSQt8OzgtpBP6qGqY=;
 b=BP9MX9OcYQH2u/z17O9RrczsPMQ4PpIEB8DQmSSOx1zKmX/5WSpt/Ojh4Y3NO7nB63
 33789GG/tht7XCnfIGeByLbuMdrT0jiwA2xd00qJOXP2VQUAXV7xKu9++1L3v2JdnfnE
 BPDkUWSorIPaPcYfTEJKlTNuM9gMcekeOl2C81xfdF4GBjCfqnzx2mQsWMognZHs9XwS
 OnPkQbzqYhla/23ucPpCmhpTGeVY2NUfrqop1MWtEImjf0sdleiQcYcC6XKVpivs8agz
 YDUNJ3VR+QHNKJygy857y4Yvt0omcIFPZyXeigtJh6LLOJxkgrfjcMv86zT+MhrFEDSm
 fZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UmXRKUbKgXmhfW+77FLjDFzejAZSQt8OzgtpBP6qGqY=;
 b=oZ8FXl8qEq0TYQjYQrCCLulSpViGFKWYsXBSixhPQixsdmIDCPXab2MrzoHlDKLbo9
 zJGLKo29wdrKo5ybmt+X+RRFT8xn8SdHSLfp7TQJtEMfQ+NfOayCBvRTQqI0bjB+ouw/
 iVNejvU6P5YwCUbRvfVd/mV5GGiAnkFVtBDiX0aVkj3iGlaqvnh8bi91MVDpSzT393bW
 x45rlRX5EkMjZ1Z7lXfN/y9LX9gX0qwLU3RANG2b2LNF/hDW8yVk7puq6zZg7QXZXdIJ
 G1nVzFwwe2qHiPTYM+Gx7tZXiJ7rphoctgUe35wSYLMnzrrmnbP8j47+oUy81V18RkiP
 nVcg==
X-Gm-Message-State: AOAM532vfJB5yY+M6p2Ip79pjbwUp6pxL+rCd1K5k4lsT9mstm7pvJNl
 H1P/FFFi4N2G7YUuRonMeGijcZ4MRey5Dzgq
X-Google-Smtp-Source: ABdhPJxWQWgHqeHeLP9AZ7TlKphAE28bQei1LUV6m367BQpAYasGUBryOfDcMJHgROyhEPcNsD9ZpA==
X-Received: by 2002:a05:6830:1ac8:: with SMTP id
 r8mr3071904otc.70.1601676008387; 
 Fri, 02 Oct 2020 15:00:08 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id k10sm684268ots.60.2020.10.02.15.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 15:00:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 7/8] linux-user/elfload: Parse NT_GNU_PROPERTY_TYPE_0 notes
Date: Fri,  2 Oct 2020 16:59:54 -0500
Message-Id: <20201002215955.254866-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002215955.254866-1-richard.henderson@linaro.org>
References: <20201002215955.254866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For aarch64, this includes the GNU_PROPERTY_AARCH64_FEATURE_1_BTI bit,
which indicates that the image should be mapped with guarded pages.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v9: Only map the startup executable with BTI; anything else must be
    handled by the interpreter.
v10: Split out preparatory patches (pmm).
---
 linux-user/qemu.h    |  4 +++
 linux-user/elfload.c | 68 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 941ca99722..534753ca12 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -61,6 +61,10 @@ struct image_info {
         abi_ulong       interpreter_loadmap_addr;
         abi_ulong       interpreter_pt_dynamic_addr;
         struct image_info *other_info;
+
+        /* For target-specific processing of NT_GNU_PROPERTY_TYPE_0. */
+        uint32_t        note_flags;
+
 #ifdef TARGET_MIPS
         int             fp_abi;
         int             interp_fp_abi;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6b422990ff..3c6cbd35c3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2391,7 +2391,7 @@ static void load_elf_image(const char *image_name, int image_fd,
     struct elfhdr *ehdr = (struct elfhdr *)bprm_buf;
     struct elf_phdr *phdr;
     abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
-    int i, retval;
+    int i, retval, prot_exec;
     const char *errmsg;
 
     /* First of all, some simple consistency checks */
@@ -2467,6 +2467,50 @@ static void load_elf_image(const char *image_name, int image_fd,
                 goto exit_errmsg;
             }
             *pinterp_name = interp_name;
+        } else if (eppnt->p_type == PT_GNU_PROPERTY) {
+            /* Process NT_GNU_PROPERTY_TYPE_0. */
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
+#ifdef TARGET_AARCH64
+            if (note[4] == GNU_PROPERTY_AARCH64_FEATURE_1_AND &&
+                note[5] == 4) {
+                info->note_flags = note[6];
+            }
+#endif /* TARGET_AARCH64 */
         }
     }
 
@@ -2555,6 +2599,26 @@ static void load_elf_image(const char *image_name, int image_fd,
     info->brk = 0;
     info->elf_flags = ehdr->e_flags;
 
+    prot_exec = PROT_EXEC;
+#ifdef TARGET_AARCH64
+    /*
+     * If the BTI feature is present, this indicates that the executable
+     * pages of the startup binary should be mapped with PROT_BTI, so that
+     * branch targets are enforced.
+     *
+     * The startup binary is either the interpreter or the static executable.
+     * The interpreter is responsible for all pages of a dynamic executable.
+     *
+     * Elf notes are backward compatible to older cpus.
+     * Do not enable BTI unless it is supported.
+     */
+    if ((info->note_flags & GNU_PROPERTY_AARCH64_FEATURE_1_BTI)
+        && (pinterp_name == NULL || *pinterp_name == 0)
+        && cpu_isar_feature(aa64_bti, ARM_CPU(thread_cpu))) {
+        prot_exec |= TARGET_PROT_BTI;
+    }
+#endif
+
     for (i = 0; i < ehdr->e_phnum; i++) {
         struct elf_phdr *eppnt = phdr + i;
         if (eppnt->p_type == PT_LOAD) {
@@ -2568,7 +2632,7 @@ static void load_elf_image(const char *image_name, int image_fd,
                 elf_prot |= PROT_WRITE;
             }
             if (eppnt->p_flags & PF_X) {
-                elf_prot |= PROT_EXEC;
+                elf_prot |= prot_exec;
             }
 
             vaddr = load_bias + eppnt->p_vaddr;
-- 
2.25.1


