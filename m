Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B373C55194
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 00:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBBBA2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 00:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pr0BJzp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBBA2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSs6H-0007TQ-Th
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 20:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <masahiroy@kernel.org>) id 1jSs5U-0006Yp-3H
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 20:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <masahiroy@kernel.org>) id 1jSs5S-0008D5-Ms
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 20:57:31 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:35450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <masahiroy@kernel.org>)
 id 1jSs5R-0008Ck-CW
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 20:57:30 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net
 [126.90.202.47]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 03R0v6Ni032306;
 Mon, 27 Apr 2020 09:57:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 03R0v6Ni032306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1587949027;
 bh=BKsLxU/QJkgECr5tRUCCS/nKrrSsN52dKdzZeqHsdko=;
 h=From:To:Cc:Subject:Date:From;
 b=pr0BJzp5ASc0+QCNkNSiId54VMoUsY1BDZUJ6L8xPbs4UdAwNkC5lIx0VJsdssuch
 S7yOashRYu4C6Dzlfj0Yz5NpI8OsofHCLfWu3ENEdsoEJmRqhLD7QJXIugarfNzNRK
 8ej2gIVGK8Cryw9kelsEyslYXDCLuxrnaOVJVUU0ZvOXnq4zR01Wnr1whpyQIbmO9s
 s1ApnCU6cfbrrJzAbwvaNUr/MtMVyvNsRHZdsgwtqwmnSdTy2S93vqoxgWihU1hak5
 UW5DZeqW8UT/5ZnvQ/x3YEfKCBH/foY6F5d0yqbz/S9jRYKXiiAbCqhYklY2SwI1ku
 px8SYsfsMcX1g==
X-Nifty-SrcIP: [126.90.202.47]
From: Masahiro Yamada <masahiroy@kernel.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] qemu-option: pass NULL rather than 0 to the id of
 qemu_opts_set()
Date: Mon, 27 Apr 2020 09:57:04 +0900
Message-Id: <20200427005704.2475782-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=210.131.2.77;
 envelope-from=masahiroy@kernel.org; helo=conuserg-10.nifty.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 20:57:24
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Received-From: 210.131.2.77
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
Cc: Masahiro Yamada <masahiroy@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The second argument 'id' is a pointer. Pass NULL rather than 0.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 softmmu/vl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 32c0047889..afd2615fb3 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3059,19 +3059,19 @@ void qemu_init(int argc, char **argv, char **envp)
                 }
                 break;
             case QEMU_OPTION_kernel:
-                qemu_opts_set(qemu_find_opts("machine"), 0, "kernel", optarg,
+                qemu_opts_set(qemu_find_opts("machine"), NULL, "kernel", optarg,
                               &error_abort);
                 break;
             case QEMU_OPTION_initrd:
-                qemu_opts_set(qemu_find_opts("machine"), 0, "initrd", optarg,
+                qemu_opts_set(qemu_find_opts("machine"), NULL, "initrd", optarg,
                               &error_abort);
                 break;
             case QEMU_OPTION_append:
-                qemu_opts_set(qemu_find_opts("machine"), 0, "append", optarg,
+                qemu_opts_set(qemu_find_opts("machine"), NULL, "append", optarg,
                               &error_abort);
                 break;
             case QEMU_OPTION_dtb:
-                qemu_opts_set(qemu_find_opts("machine"), 0, "dtb", optarg,
+                qemu_opts_set(qemu_find_opts("machine"), NULL, "dtb", optarg,
                               &error_abort);
                 break;
             case QEMU_OPTION_cdrom:
@@ -3182,7 +3182,7 @@ void qemu_init(int argc, char **argv, char **envp)
                 }
                 break;
             case QEMU_OPTION_bios:
-                qemu_opts_set(qemu_find_opts("machine"), 0, "firmware", optarg,
+                qemu_opts_set(qemu_find_opts("machine"), NULL, "firmware", optarg,
                               &error_abort);
                 break;
             case QEMU_OPTION_singlestep:
-- 
2.25.1


