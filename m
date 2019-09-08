Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E89C433EF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24DE3214DB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMdtP91J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24DE3214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6qW3-0004WU-Nb
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 02:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUJ-0002mg-GL
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUI-0002Rc-8T
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:35481)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUI-0002RB-0y
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id g7so10456731wrx.2
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 23:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ROk+o+HMT2cJouWNGOdWm5hzjL4fVvXqBE3i+COSN4Q=;
 b=kMdtP91JJGuUnYjZ1/7dM+wJ+zyHn0D9Jc+ASUYtPTuUpnSH1rQpxy1TPsNU3jGrVT
 751GuuNTiINALoCtBthrEylePpn0Icc67y9WJbGiyzKNBNEDBOIyO6dWqFRC1wspQzK+
 C0m8iIZuVbJvF6ubKqkjT6DzmsB2+G+pVv796tbeHeh1CIFLqWIadtfTHgMuz7ZiZ2ii
 NIkwG750BjdnRGnAS9u2DZn1MnyoeoEPyCaZ4t8PaCvo1RuV1poNGGXyDi3le3fcTmyR
 /Rhxadw0WFdB0YSgy7M1F+742X4wnNjylSYoUxZy+LfMapGTtjh/01sfgQuepUTKKhPp
 Y2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ROk+o+HMT2cJouWNGOdWm5hzjL4fVvXqBE3i+COSN4Q=;
 b=GJUkB8xDxg8d2mIwt7ciXjr+nbjW+X2b75qaigwNkTejn5bikCUXoZcwFzhWNoA6Go
 J8fnuox0Pdufx8GwL5uPuA8Z10omF0j6B3sT3aznNgSLIwf4ruPBAAm6IWh5M3pX45kY
 XoEu9B1kke4w9YPrHiAR2IRRCWN53EyDfZm8Ah9OlpoufFb53LkmnLdJuyuB09B24XL6
 RVF4PL8kFQ4A/KI4bnfzuDgGUB3Y+oKm66TGw1SYjJ8an6RLb+Lwug7TzU4z8q6pJV7l
 Q2sUIOv4kfd1ajAPalYXwPH50aCbFEW4LdXeANhL9C5yEmIqtpblbkZNZtbdMn6SSaoi
 uCXA==
X-Gm-Message-State: APjAAAXhBudoR4N8O5q/rIsIaUTTQ3RKspXyf+kOlBd9JgfanCGH9yrI
 1ApjHMFRdGhWGLgNKUWDi3JdDF8z
X-Google-Smtp-Source: APXvYqyKwf9yNjn4CCdaKuNXsaFzZYUqMW/mMRrI0YIkv9ISAFFbPikqZgHZc7U1A5E6CiW/rgmydQ==
X-Received: by 2002:adf:e603:: with SMTP id p3mr13362404wrm.102.1567923348898; 
 Sat, 07 Sep 2019 23:15:48 -0700 (PDT)
Received: from localhost.localdomain
 (251.red-88-10-102.dynamicip.rima-tde.net. [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id g201sm15616552wmg.34.2019.09.07.23.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2019 23:15:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 08:15:38 +0200
Message-Id: <20190908061543.25136-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908061543.25136-1-f4bug@amsat.org>
References: <20190908061543.25136-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: [Qemu-devel] [PATCH v6 3/8] linux-user/strace: Improve
 settimeofday()
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-By: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 13 +++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 5ee9d62c25..dcf843b360 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1584,6 +1584,19 @@ print_futimesat(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_settimeofday
+static void
+print_settimeofday(const struct syscallname *name,
+                abi_long arg0, abi_long arg1, abi_long arg2,
+                abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_timeval(arg0, 0);
+    print_timezone(arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_link
 static void
 print_link(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 63a946642d..1ff9168369 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1345,7 +1345,7 @@
 { TARGET_NR_set_tid_address, "set_tid_address" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_settimeofday
-{ TARGET_NR_settimeofday, "settimeofday" , NULL, NULL, NULL },
+{ TARGET_NR_settimeofday, "settimeofday" , NULL, print_settimeofday, NULL },
 #endif
 #ifdef TARGET_NR_setuid
 { TARGET_NR_setuid, "setuid" , NULL, NULL, NULL },
-- 
2.20.1


