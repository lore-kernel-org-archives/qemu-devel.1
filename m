Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDB9CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:54:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277B7206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk8w9heP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277B7206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMWGG-0002Jd-RK
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBb-0005Vf-O7
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBZ-0003Bx-F9
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43419)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBY-0003AH-H8
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:17 -0400
Received: by mail-wr1-x441.google.com with SMTP id c2so8366713wrr.10
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 04:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7PzhWDBr2TcCErcmKtgx3wheeZHdViTC2eISH3wD2UY=;
 b=dk8w9hePxNkOKwNpLUhu6Towyzx2uLJfblQUVXUARx7NMmTDwkm++HEiRpPdDRzRJI
 nN3mErDQsO+gYGhWXJ3bkNJf5L+a5HaAWI9BIPcR6tBecuBxm5kcc4XYWKGZhzgxW57M
 SLL2ohdfoZK8NIC6drmN2jEYv1IK91AxP57Oj1Kt6NZLxe4wFa5v621oyisalKwaXO4A
 +HVj1f94ydYTS6H/+YLmhAidxB7u1I41TqR8azBS2j0WuKVB8o/lGF9WY4IUT6IeMmZ3
 YJ8uv9lpde+Wd7V7950dRrUneOwRdrflN4ttFQTB9+csF/kzV4NpjxYw5z3a/w5lP8NZ
 KMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7PzhWDBr2TcCErcmKtgx3wheeZHdViTC2eISH3wD2UY=;
 b=QWir43sCpKP80SHOYfA3YWWWvGF7E6W86ZcDyZo4OrUUxljNbbcg1malgbZe3DQBR3
 KUAe5Daaq3qj7L+/KsNomoE7NAInDd4X+WwwR37TgJgD43KIdmkcR+ycXeca0h1/wQ6h
 g2hqsa3f9fX93hb8GcDLSC5daAxuF1xGpTRY0YgN+MjQxd8sa2L1fqp3FqPqWExyP6//
 o1kaZo+RMFy9huLh/sRZg/AAL1tLg9LQz1luRHJZ8lgJFgd9UVULEQKL9Kj8RiQgdEV4
 9QRvs77lONzwX/mP5giNaVIwtKsS8p82JiwUMvnBIXmFH+o8COhL6wcucHA8Hy5m13nT
 cWSQ==
X-Gm-Message-State: APjAAAXYCAlgBy76+20bGWPwlfUrR4iMo9HqWMEtBZ49s/MfxDAlWaDc
 uDyaEhFxGIZgLJxVkE8Ag5wWlN/m
X-Google-Smtp-Source: APXvYqziiHIr8QyYjiYEWS+bR7m1eROI0BOYgDA0cPB70Ywo+HVr8tgMhlvdLGNpJ4z4VvtSARw/Zg==
X-Received: by 2002:adf:91e1:: with SMTP id 88mr7748134wri.16.1571658551794;
 Mon, 21 Oct 2019 04:49:11 -0700 (PDT)
Received: from localhost.localdomain
 (129.red-83-57-174.dynamicip.rima-tde.net. [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id x5sm17156137wrt.75.2019.10.21.04.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 04:49:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 7/9] linux-user/strace: Improve bind() output
Date: Mon, 21 Oct 2019 13:48:55 +0200
Message-Id: <20191021114857.20538-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021114857.20538-1-f4bug@amsat.org>
References: <20191021114857.20538-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tested-By: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v6: use TARGET_NR_socketcall || TARGET_NR_bind (lvivier)
---
 linux-user/strace.c    | 15 ++++++++++++++-
 linux-user/strace.list |  2 +-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 0ce2b658a5..cd92c77d33 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1707,7 +1707,7 @@ print_socket(const struct syscallname *name,
 
 #endif
 
-#if defined(TARGET_NR_socketcall)
+#if defined(TARGET_NR_socketcall) || defined(TARGET_NR_bind)
 
 static void print_sockfd(abi_long sockfd, int last)
 {
@@ -2054,6 +2054,19 @@ print_socketcall(const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_bind)
+static void
+print_bind(const struct syscallname *name,
+           abi_long arg0, abi_long arg1, abi_long arg2,
+           abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_sockfd(arg0, 0);
+    print_sockaddr(arg1, arg2, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) || \
     defined(TARGET_NR_lstat) || defined(TARGET_NR_lstat64)
 static void
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 1ff9168369..957aa720af 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -41,7 +41,7 @@
 { TARGET_NR_bdflush, "bdflush" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_bind
-{ TARGET_NR_bind, "bind" , NULL, NULL, NULL },
+{ TARGET_NR_bind, "bind" , NULL, print_bind, NULL },
 #endif
 #ifdef TARGET_NR_bpf
 { TARGET_NR_bpf, "bpf" , NULL, NULL, NULL },
-- 
2.21.0


