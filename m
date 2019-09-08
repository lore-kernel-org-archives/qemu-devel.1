Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A0BC4332F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56FD21734
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtCUmK4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56FD21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6qY3-0007N9-Ro
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 02:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUN-0002sJ-K2
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUM-0002Tx-ER
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:55 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55295)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUM-0002TM-7z
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:54 -0400
Received: by mail-wm1-x342.google.com with SMTP id k2so10292375wmj.4
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 23:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BJIzbQfX7Qshpa375lFrVbD2cYPQAWdO4ETlc0n+5+0=;
 b=FtCUmK4uBd9gRjhauIen6xjX+YtWczC/JCSn3g/lAKO9vuhnQKCJ0NHakFGQafw6Yj
 U2ITX2g3e1LrDjjrzT/zxZ5sKU+fPdp0DhhUtqWP3xOpMJA5jiz/Ao3XdRr/Rwj7oxIN
 j+jjf67c78eefIbdRpgZq1SqIuUrrVYVMrCuM0y6Lq9JzJubeJaX/GR8iHe0XmbaPYiK
 1DiRw+hS1bJufwMbqn08u9c9Xl4xFGYY1COyRgpIYLeVZsKyCYByHWFJbEIf7MwSxWeX
 RgMbPYlLyMIYIw8ULb/HXZAsD4l74IEdQ4Q4cSCvY/Lj/CgssObBhl5X/nEsx2J35SLY
 2upQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BJIzbQfX7Qshpa375lFrVbD2cYPQAWdO4ETlc0n+5+0=;
 b=OPw0glMfnR3YMdvX2XgksozhALc929zO0yjkj+/3ODWR5cxT1BSbIEaxVPoL2A1r6R
 c6RXa7Ay1ltrCijIEKu+NgNfwc8W3vb+IUI9Y3sR6P0d66B9q/H0o17vXaRKdOOs1tki
 fxoBFI6Jyq1N/ieTe6OTHNydta+EUzD7oo0OHZ8YpOzoUULGMgTBGt3gxn6uZF6XukfC
 qehpnxBNweuiGjCQsqaGtn1r8J0Q4yIZt/xbarXHbkPROc1HQ1maqsicB+sxRKghxG3D
 q2Oqm9seE6yC0eXEgY/dPaWyYp5j+5Dm1wexG6sNW5lBErBd6Qq/qP+OTBGFgxNaHqgH
 k0iA==
X-Gm-Message-State: APjAAAXT5qBbw4vot3LP7FBhL8AcPuAv3vE8ZJLBWCqmEgJTwXt+BBaw
 UYE0mlautN+u1OTyfcnEpQ0PXiKN
X-Google-Smtp-Source: APXvYqyAoovqFgd7oHBx9w2nv031JAJ7SB6b3Qnk39jehDYpbalDVR7+FXX6WGRpnUspqf00qiujXg==
X-Received: by 2002:a1c:a003:: with SMTP id j3mr13639825wme.42.1567923353102; 
 Sat, 07 Sep 2019 23:15:53 -0700 (PDT)
Received: from localhost.localdomain
 (251.red-88-10-102.dynamicip.rima-tde.net. [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id g201sm15616552wmg.34.2019.09.07.23.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2019 23:15:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 08:15:42 +0200
Message-Id: <20190908061543.25136-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908061543.25136-1-f4bug@amsat.org>
References: <20190908061543.25136-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v6 7/8] linux-user/strace: Improve bind() output
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
---
v6: use TARGET_NR_socketcall || TARGET_NR_bind (lvivier)
---
 linux-user/strace.c    | 15 ++++++++++++++-
 linux-user/strace.list |  2 +-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 8a1df12e67..a1e971ac8a 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1708,7 +1708,7 @@ print_socket(const struct syscallname *name,
 
 #endif
 
-#if defined(TARGET_NR_socketcall)
+#if defined(TARGET_NR_socketcall) || defined(TARGET_NR_bind)
 
 static void print_sockfd(abi_long sockfd, int last)
 {
@@ -2055,6 +2055,19 @@ print_socketcall(const struct syscallname *name,
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
2.20.1


