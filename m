Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD82CC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DFD821D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZ/lyYIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFD821D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8qpA-0002Ph-Lb
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 14:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56760)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3OV9dXgYKCmYcYERdMKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--yuanzi.bounces.google.com>)
 id 1j8qnU-0000zB-4K
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:32:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3OV9dXgYKCmYcYERdMKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--yuanzi.bounces.google.com>)
 id 1j8qnT-0006br-6a
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:32:12 -0500
Received: from mail-qv1-xf49.google.com ([2607:f8b0:4864:20::f49]:39448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3OV9dXgYKCmYcYERdMKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--yuanzi.bounces.google.com>)
 id 1j8qnT-0006bI-0l
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:32:11 -0500
Received: by mail-qv1-xf49.google.com with SMTP id f17so506645qvi.6
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 11:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=hlNAWP5jM40m2wMOQj0Q5tTaNJybDDFU+n7WZSCMPF0=;
 b=XZ/lyYIFFuX83TwZG+uZ9tvC4uGnPqlL01CdrpHS4N6O4aALUfN9ZHFuW0Zm0S2PPI
 ai7/OPdemhIcRujHYRNR3NnQRMah1uaNSjVZMRULTOVyfx9TVLX68dylCNDHtzcgikOt
 G8zA0m5K1qMb7tSr51jgfpHQzXSkC/Ln59TjoUUqld2G0sg/1kEfXpzAVnBOjEZZQPVk
 L4hIA4fPGeRdTl/ZtoU5v7dcQfq3y9y85vHFTWmH35fm8fxDI+z+JURXUMNa3qUCTii/
 AZzMquGn5q+R3DKbm72dyitVpJGZ2I7rZSvpKLvG+1/a1a6LK2Wh+t68VCmqAwH+XsMZ
 6BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=hlNAWP5jM40m2wMOQj0Q5tTaNJybDDFU+n7WZSCMPF0=;
 b=o60QVr6uVeNMLt3kczKUWvJASIIweA8sG/+r7ogqLpNRCtAz253bxuCCqHOEY87dm1
 J9PVduv1I77HK2Am/XAmHq4mgCmDTuhFOOZBpoSxK3xqT3p/fAyE8ksVHMw2gOT+B9+0
 2Md9VPp804mSSxzlSm/AzlclvI8WqtFBw2JMDlzj0aplHAW9OELTnB8isX220xuUojrP
 9YauLRjGx5YH+T//wL4D2+8nu2ssMpkJI3b3LK4VomGP4zejV05zRiRprtXGEcvwvl5n
 kECYAMAwLk8Zw1gJevY8aG46f6Mf3EEB0zrsvzkB9IeFMMr3JhpOC1MuhCHGhUWqKixI
 hoSA==
X-Gm-Message-State: ANhLgQ1MuHbT/Qbcwk8TZ6vnhdNMZ1VWz2ITDIqheVZMlW75H5H3eRo6
 F/pfZqymW6URnlwz3cc4BQMCWgvxtv3QuSXDQJN7THFXlOLKGFUaft32BXbpTJJeQf8bWO/6xhh
 +WlxIMwxkpC2BwOdQpV26ytJ6v1VR5zG+PfbIuZDX/mRrU5p1aat48nhbHXTO
X-Google-Smtp-Source: ADFU+vscas0Rfzg7id+RYhlB4QfVkcj26+NW8lyRQlGvmaXBqybMqwJhDCeKwGd/q8yHNhwwSIGq+pzLP8o=
X-Received: by 2002:a37:9b15:: with SMTP id d21mr781636qke.107.1583177529298; 
 Mon, 02 Mar 2020 11:32:09 -0800 (PST)
Date: Mon,  2 Mar 2020 11:31:53 -0800
Message-Id: <20200302193153.66415-1-yuanzi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2] linux-user: Add AT_EXECFN auxval
From: Lirong Yuan <yuanzi@google.com>
To: qemu-devel@nongnu.org, laurent@vivier.eu
Cc: qemu-trivial@nongnu.org, scw@google.com, jkz@google.com, 
 Lirong Yuan <yuanzi@google.com>, Riku Voipio <riku.voipio@iki.fi>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f49
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

This change adds the support for AT_EXECFN auxval.

Signed-off-by: Lirong Yuan <yuanzi@google.com>
---
Changelog since v1:
- remove implementation for AT_EXECFD auxval.

 linux-user/elfload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index db748c5877..8198be0446 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1573,7 +1573,7 @@ struct exec
                                  ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE-1))
 #define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE-1))
 
-#define DLINFO_ITEMS 15
+#define DLINFO_ITEMS 16
 
 static inline void memcpy_fromfs(void * to, const void * from, unsigned long n)
 {
@@ -2037,6 +2037,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     NEW_AUX_ENT(AT_CLKTCK, (abi_ulong) sysconf(_SC_CLK_TCK));
     NEW_AUX_ENT(AT_RANDOM, (abi_ulong) u_rand_bytes);
     NEW_AUX_ENT(AT_SECURE, (abi_ulong) qemu_getauxval(AT_SECURE));
+    NEW_AUX_ENT(AT_EXECFN, info->file_string);
 
 #ifdef ELF_HWCAP2
     NEW_AUX_ENT(AT_HWCAP2, (abi_ulong) ELF_HWCAP2);
-- 
2.25.0.265.gbab2e86ba0-goog


