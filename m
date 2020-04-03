Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E8AC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970C320719
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yK80QjmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970C320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKRkr-0004yA-PX
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 15:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjQ-0003FP-DZ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjP-000200-1X
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:11:56 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40096)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jKRjO-0001xC-LH
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:11:54 -0400
Received: by mail-wr1-x443.google.com with SMTP id s8so7674625wrt.7
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 12:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+bAv2HPSumCjz45QTmpT65MHVnN93v/+fTRM89VHFyg=;
 b=yK80QjmIo8e7BiILucvoVLSRw1slFmjM0ixIcZ1APs/uqRY1aqhiIjg1U8HKCBlk7a
 2SIfRuEu55FGF5MgvxJdWuuLJ7U8mdmhVf+SJgcHlCLwNbiJQKusN1oKNZozSEFpm7OA
 tojXMZHU1vFnykDXF4MsGdJ/spSGRTUNAJJo7YaXf3JIFOdXDx6VMFdy7jq5rG+rqqyv
 GAwNglWd16vbNHK/Hsbn72X/+fC4611gFwfZC+9ifN2OzQLX1Tco8ChwoO6LTe5FlWat
 /Ukg+bnbKvUKSOA/XowjHPyhLyU0ErtjiCXwNgg5AsEBtnKUMwOelX54exmmrrmCsorU
 QkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+bAv2HPSumCjz45QTmpT65MHVnN93v/+fTRM89VHFyg=;
 b=XG/9lN/z+LMxCfP0FrGXiUdr3HrvdZjyiiH9F13PYQ4QQO8QznfwKb3yVg/gw1+oRC
 LY6DvyoKwAKX1dAopmxPphyLs559bDkUCmFqvanWbuPylfG6Td4ACalAH1yuXgFmvFO4
 w7jBFlm+AlCz9XLJjgawWIwEEKkN4Uty+i3zxDmTa367H/QmEP2UH7yK32J8KOFJxhtv
 Y2ipsg9uPgPeWtW54chLZFiKy4R2yIgbXcn9qHQoMuejQ+c2KrZxhInsEUPlWyyopsTB
 QpFT1JlXbrhCvwlk8pG9Nl0+64ugWRFEGsyNKtAkli4I9UjIx/h/imdt35tSZuC5zA7I
 TYiA==
X-Gm-Message-State: AGi0PuZ3upSxrZvULtcbQ6TYojMjjSeEGVx9Nt4blmuxZW6vVqJWQD6E
 yI08xAM2hRYXeBFvO3tIoyBa/w==
X-Google-Smtp-Source: APiQypJYjV20SZh9EMjLxEqPuCNt7HlmEncehjl71E+cn4bsKm5PrVAjGU2YcKF8Szt6pXqYtj/XCQ==
X-Received: by 2002:adf:e90b:: with SMTP id f11mr10454150wrm.65.1585941113556; 
 Fri, 03 Apr 2020 12:11:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r5sm12481552wmr.15.2020.04.03.12.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 12:11:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AE1E41FF87;
 Fri,  3 Apr 2020 20:11:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 01/12] elf-ops: bail out if we have no function symbols
Date: Fri,  3 Apr 2020 20:11:39 +0100
Message-Id: <20200403191150.863-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200403191150.863-1-alex.bennee@linaro.org>
References: <20200403191150.863-1-alex.bennee@linaro.org>
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's perfectly possible to have no function symbols in your elf file
and if we do the undefined behaviour sanitizer rightly complains about
us passing NULL to qsort. Check nsyms before we go ahead.

While we are at it lets drop the unchecked return value and cleanup
the fail leg by use of g_autoptr.

Another fix was proposed 101 weeks ago in:
Message-Id: 20180421232120.22208-1-f4bug@amsat.org

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/elf_ops.h | 48 +++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index a1411bfcab6..e0bb47bb678 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -104,19 +104,21 @@ static int glue(symcmp, SZ)(const void *s0, const void *s1)
         : ((sym0->st_value > sym1->st_value) ? 1 : 0);
 }
 
-static int glue(load_symbols, SZ)(struct elfhdr *ehdr, int fd, int must_swab,
-                                  int clear_lsb, symbol_fn_t sym_cb)
+static void glue(load_symbols, SZ)(struct elfhdr *ehdr, int fd, int must_swab,
+                                   int clear_lsb, symbol_fn_t sym_cb)
 {
-    struct elf_shdr *symtab, *strtab, *shdr_table = NULL;
-    struct elf_sym *syms = NULL;
+    struct elf_shdr *symtab, *strtab;
+    g_autofree struct elf_shdr *shdr_table = NULL;
+    g_autofree struct elf_sym *syms = NULL;
+    g_autofree char *str = NULL;
     struct syminfo *s;
     int nsyms, i;
-    char *str = NULL;
 
     shdr_table = load_at(fd, ehdr->e_shoff,
                          sizeof(struct elf_shdr) * ehdr->e_shnum);
-    if (!shdr_table)
-        return -1;
+    if (!shdr_table) {
+        return ;
+    }
 
     if (must_swab) {
         for (i = 0; i < ehdr->e_shnum; i++) {
@@ -125,23 +127,25 @@ static int glue(load_symbols, SZ)(struct elfhdr *ehdr, int fd, int must_swab,
     }
 
     symtab = glue(find_section, SZ)(shdr_table, ehdr->e_shnum, SHT_SYMTAB);
-    if (!symtab)
-        goto fail;
+    if (!symtab) {
+        return;
+    }
     syms = load_at(fd, symtab->sh_offset, symtab->sh_size);
-    if (!syms)
-        goto fail;
+    if (!syms) {
+        return;
+    }
 
     nsyms = symtab->sh_size / sizeof(struct elf_sym);
 
     /* String table */
     if (symtab->sh_link >= ehdr->e_shnum) {
-        goto fail;
+        return;
     }
     strtab = &shdr_table[symtab->sh_link];
 
     str = load_at(fd, strtab->sh_offset, strtab->sh_size);
     if (!str) {
-        goto fail;
+        return;
     }
 
     i = 0;
@@ -170,8 +174,13 @@ static int glue(load_symbols, SZ)(struct elfhdr *ehdr, int fd, int must_swab,
         }
         i++;
     }
-    syms = g_realloc(syms, nsyms * sizeof(*syms));
 
+    /* check we have symbols left */
+    if (nsyms == 0) {
+        return;
+    }
+
+    syms = g_realloc(syms, nsyms * sizeof(*syms));
     qsort(syms, nsyms, sizeof(*syms), glue(symcmp, SZ));
     for (i = 0; i < nsyms - 1; i++) {
         if (syms[i].st_size == 0) {
@@ -182,18 +191,11 @@ static int glue(load_symbols, SZ)(struct elfhdr *ehdr, int fd, int must_swab,
     /* Commit */
     s = g_malloc0(sizeof(*s));
     s->lookup_symbol = glue(lookup_symbol, SZ);
-    glue(s->disas_symtab.elf, SZ) = syms;
+    glue(s->disas_symtab.elf, SZ) = g_steal_pointer(&syms);
     s->disas_num_syms = nsyms;
-    s->disas_strtab = str;
+    s->disas_strtab = g_steal_pointer(&str);
     s->next = syminfos;
     syminfos = s;
-    g_free(shdr_table);
-    return 0;
- fail:
-    g_free(syms);
-    g_free(str);
-    g_free(shdr_table);
-    return -1;
 }
 
 static int glue(elf_reloc, SZ)(struct elfhdr *ehdr, int fd, int must_swab,
-- 
2.20.1


