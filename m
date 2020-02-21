Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC76EC35666
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 20:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83972072C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 20:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tKADRVyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83972072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Eve-000344-Vv
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 15:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52701)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3jT1QXgYKCkI2yer3mksskpi.gsquiqy-hiziprsrkry.svk@flex--yuanzi.bounces.google.com>)
 id 1j5Ev2-0002ej-DN
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 15:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3jT1QXgYKCkI2yer3mksskpi.gsquiqy-hiziprsrkry.svk@flex--yuanzi.bounces.google.com>)
 id 1j5Ev1-0001tC-EV
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 15:29:04 -0500
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a]:57030)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3jT1QXgYKCkI2yer3mksskpi.gsquiqy-hiziprsrkry.svk@flex--yuanzi.bounces.google.com>)
 id 1j5Ev1-0001qy-9g
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 15:29:03 -0500
Received: by mail-pl1-x64a.google.com with SMTP id 91so1753467plf.23
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 12:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=vmCGU9QmZGdVmAO0sJELwZM+WuL2wGHuNd0ACEynasA=;
 b=tKADRVynkJZ6Nwr9JX4SPWXXm+gRY6eeDKHardg/N+ZHAJDyvZwK2DmcB17XfEeQ12
 N/wo7Fj6wKEHgfx/mCP2HjGQu+1CYbIeeWq/l9vKZSEm7JpT2EivSVKITB4o1ftZ9kXj
 gxwIzHjfPuc6xMuRacCab0M5dhk+nYdLSiXH8q46Q5gj/DDO4v+YlSWNSeEHFCUZ61q8
 aCg+sL1nPY8PnfsD6pz74y5bysx1dacir4EnV1VGa+aEcYieyv2mXyCOEXhEug2G/eCE
 PnHF2yigVDK2xBl1OR0AQkEnHafB83xQ2ssHzoMAelIzu2r7TT48IkEO9Dc1bnssgeJ+
 XvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=vmCGU9QmZGdVmAO0sJELwZM+WuL2wGHuNd0ACEynasA=;
 b=CDCQ1dTZWC7R2irSPC0fRnb2d9FuW7nl3KxX+78Hc6NjC6tpACMihN3hrKGAOjLC8h
 cBvkYpyckiy99eRriNoGCYqvGQMasTax9GAS8xIirswrc8+dE+sS642GkMv6ZaZGq56A
 Tdi+Kxf+LYfY/1LJytqevkHBVyu38h8V52ewPDPicPyccnEk6LGzw/c89+8JtSjWmlZm
 TeolAsVmCtFVfbb/0ui2NXtZStVAcrG4sbosCVBNSd0LlRsKqb02mirj4dfER1PRY+H+
 mkve5KlI6I5OzQCK81+Te3J+ZdJ/UDN08tfjYsi+PDLSH+qsOqBr7gORjjpFjk8xxVEz
 6CFA==
X-Gm-Message-State: APjAAAWa2BYl5FL0IORAsLKyCxZV1hcFxbZka4D3ttlCPr269A95XUPx
 v6rKqDGmXA3nj0VDSTC4SD4TACC5QH9emhBd/FicDRgb0vJr2JVdI0doLRzLIBtykanHNhQTF3o
 gkiZkCByDj1R8MyZUfrW8AEjMhtiE5S7qhJSpSYL4aOZxKVuONPDYOG97dcIQ
X-Google-Smtp-Source: APXvYqzjKiIZCAUDVef4jNgzi8UvFJRgtdkSwcXyEl699oJxpYvbxv8mTqf50+TkHnYIE9ejQVwd+y+RAh8=
X-Received: by 2002:a63:2842:: with SMTP id o63mr41124550pgo.317.1582316941485; 
 Fri, 21 Feb 2020 12:29:01 -0800 (PST)
Date: Fri, 21 Feb 2020 12:28:57 -0800
Message-Id: <20200221202857.126170-1-yuanzi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] linux-user: Add AT_EXECFN and AT_EXECFD auxval
From: Lirong Yuan <yuanzi@google.com>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Lirong Yuan <yuanzi@google.com>, Riku Voipio <riku.voipio@iki.fi>, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::64a
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

This change adds the support for AT_EXECFN and AT_EXECFD auxval.

Signed-off-by: Lirong Yuan <yuanzi@google.com>
---
 linux-user/elfload.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f3080a1635..7e0f3042f1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1568,7 +1568,7 @@ struct exec
                                  ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE-1))
 #define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE-1))
 
-#define DLINFO_ITEMS 15
+#define DLINFO_ITEMS 17
 
 static inline void memcpy_fromfs(void * to, const void * from, unsigned long n)
 {
@@ -1888,11 +1888,14 @@ static abi_ulong loader_build_fdpic_loadmap(struct image_info *info, abi_ulong s
     return sp;
 }
 
-static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
+static abi_ulong create_elf_tables(struct linux_binprm *bprm,
                                    struct elfhdr *exec,
                                    struct image_info *info,
                                    struct image_info *interp_info)
 {
+    abi_ulong p = bprm->p;
+    int argc = bprm->argc;
+    int envc = bprm->envc;
     abi_ulong sp;
     abi_ulong u_argc, u_argv, u_envp, u_auxv;
     int size;
@@ -2032,6 +2035,8 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     NEW_AUX_ENT(AT_CLKTCK, (abi_ulong) sysconf(_SC_CLK_TCK));
     NEW_AUX_ENT(AT_RANDOM, (abi_ulong) u_rand_bytes);
     NEW_AUX_ENT(AT_SECURE, (abi_ulong) qemu_getauxval(AT_SECURE));
+    NEW_AUX_ENT(AT_EXECFN, info->file_string);
+    NEW_AUX_ENT(AT_EXECFD, bprm->fd);
 
 #ifdef ELF_HWCAP2
     NEW_AUX_ENT(AT_HWCAP2, (abi_ulong) ELF_HWCAP2);
@@ -2870,8 +2875,8 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
 #endif
     }
 
-    bprm->p = create_elf_tables(bprm->p, bprm->argc, bprm->envc, &elf_ex,
-                                info, (elf_interpreter ? &interp_info : NULL));
+    bprm->p = create_elf_tables(bprm, &elf_ex, info,
+                                (elf_interpreter ? &interp_info : NULL));
     info->start_stack = bprm->p;
 
     /* If we have an interpreter, set that as the program's entry point.
-- 
2.25.0.265.gbab2e86ba0-goog


