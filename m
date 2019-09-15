Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DD2C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A896320692
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTnvNnPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A896320692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9cH4-0005QH-Ca
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 17:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9cF3-0003vE-Rv
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9cF2-00028q-Ue
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:39:33 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9cF2-000289-P2
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:39:32 -0400
Received: by mail-wm1-x342.google.com with SMTP id t3so8014746wmj.1
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5knZzttbV5D9tyvtvvdN9hizkz3Q/QJ53f4TPnLC7tg=;
 b=FTnvNnPa1OGkRrMoAzJ1On2S+oYrAw8k/g205O6VmLpOB/2zc1Dw9BRTCkDqEC3nDP
 IeIUQxaPOIbf+htYa7sLm54zuWQYIVd1rSBpQ1x5Cf7pvzIduLuhDyD90sM82OTRx/fG
 YEQ99OWLmRkxxjwVj2fzKub+HZZKY4vuv37j68TUpSG9wIwRIog3tXY4yzG5fkUq/SyD
 8MxQzdVjcF2Vxq2HrIsB+fXIr5UPiyz1x9yw1U5GJ0mO/PxPa7Y1MFW0Hzq6zw3ieAB7
 QqsaI9EEwSElNZu+gJ0sO0cTv6O0Rmy5SQb41rAa/ajbocCC4WrJCxodotmRBRFbBHv+
 /nGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5knZzttbV5D9tyvtvvdN9hizkz3Q/QJ53f4TPnLC7tg=;
 b=MOpdS4ZX7db5yo6EDP+AiDekrtdLgYhw390m+Nn5BGDfhpMaYyQ8in9R2/J5gzXmPJ
 z4aeUL2bgiu4c6rnhBhAggeUG9hoirpBguq5aXu6CCqt085XR+4p+6WGQuZ9JFZsp3Nq
 wPyfPDkkyH7BRnYGsWBcjdozMvr6BWLgz0LJTMgHjjmBxjjD4K/wlaskiebgtoCsk9kI
 SYXtWlGKtKeRb8e0bcp98S5y8rUpK2bfbH/nY8Wq1qNjQFnJKb7vr7XrpUw2WWOn4wEA
 iZsvD2+9B4LDqcWp1hn9Ylp6MYWjzAAerfK492JYtdyyQY1XgUvW+Vh/vvpdkVXxAZPc
 hDVw==
X-Gm-Message-State: APjAAAUzPi5B6VpP3+qaw5b3VUDgneL87FHLWX3/hJ2e1VH+MJhGrUTo
 PRtAJ/6Bj28ZmuVqBqnVvFEmUs01
X-Google-Smtp-Source: APXvYqwghxynsLPU2pRZ4v/0NN+XnuGNBkPsDrbAA0ua5aLeN2KXQJWaFNPNCd87dNbIckwJynlWKw==
X-Received: by 2002:a1c:4d0d:: with SMTP id o13mr6880971wmh.19.1568583570199; 
 Sun, 15 Sep 2019 14:39:30 -0700 (PDT)
Received: from localhost.localdomain (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id z1sm68738999wre.40.2019.09.15.14.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 14:39:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 23:39:18 +0200
Message-Id: <20190915213924.22223-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190915213924.22223-1-f4bug@amsat.org>
References: <20190915213924.22223-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v7 3/9] linux-user/strace: Improve
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
index 2cd6687cd9..fd5596a640 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1583,6 +1583,19 @@ print_futimesat(const struct syscallname *name,
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


