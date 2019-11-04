Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DF6CA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A780520869
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIClDeFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A780520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRgJp-00081A-86
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 12:39:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iRgHn-0006Fl-RF
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:37:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iRgHm-000110-Pk
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:37:03 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37551)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iRgHm-00010R-Jk
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:37:02 -0500
Received: by mail-wm1-x342.google.com with SMTP id q130so16968423wme.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 09:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0T0SS4x7TjpY+2zkzV95ywVD8nqA26iLH449n9iQx28=;
 b=cIClDeFR75PK/+AB2MCb1zOJVLm/SGAtlZFOUuWLI5U3R1HneSBK2IvMLVpCQM7fg+
 bquwLJifdkGmYkCDyRjy8X2eHGUuHf1ZPvi+Tihc4ANxXFQHxfSrd8+e1U3KK853j7Kj
 vRSL+dU3Vbi4bpRZE8ysE7whwjLSUSgJ1QfkiiJIT7+2o3UUVrhm5kW1MXE/NL9c4utM
 fxHaTfswV+gzurTD7JzNfpMxTCk2vwBcC4cPVk0AUIOJhFk79Kq+AbGezgLkoWFJ4Rda
 N8BN8STKuMmZ7JoigruWl5MoTy8O9lc/rDDNstQ0pLxhpyS7XwNbNvw0/YzPn6RgB1Yl
 ckDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0T0SS4x7TjpY+2zkzV95ywVD8nqA26iLH449n9iQx28=;
 b=QsH/ZnMOmsXx5N6QJ7nB6DNAAa9NmZup1+LYmv3845o7zzHcBPAgXPh0ZTVxpi6aM9
 PA45sWj9Ra3tzvYiR64Yy8yuWwkNbsWRctJR0DkVdMoBsz9jylkYFCDUkSuK95pbsn8K
 kHX9KqhiJF6M5OZME+BLs7yIRK6E97/6bRhL3qN9nnABNuChMpmTxAb0aaRmp76cQjbN
 o+DosvwMYKDUStJ+JsVzHoG7dcpXPKUMP71wwtlyyITLctY+kXko9tsGFwJYsoPGAZZ5
 IgpYhZdRz1nTdZihK/ElF0LjZYG/NOdxeyksOMi0h9wniR8XqIpDhUwQQMylfTqJajzQ
 UNaw==
X-Gm-Message-State: APjAAAXp7BCYZvafcfkgLyR3GD/iT7cIcTU3H8TIbzbIkn2i3qAw5tuR
 pIcSCJwx7UJFLHxirgU6OrgWZQ==
X-Google-Smtp-Source: APXvYqyIJtzxzoXZGi2oae3QBDAXm+Pa3NOMHaz94hp6c5grdv92vsSOCbGbz54kdVQ6ltKLUsou3w==
X-Received: by 2002:a1c:750e:: with SMTP id o14mr209902wmc.35.1572889021299;
 Mon, 04 Nov 2019 09:37:01 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c15sm15499745wmb.45.2019.11.04.09.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 09:36:56 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E3C081FF90;
 Mon,  4 Nov 2019 17:36:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 3/6] tests/vm: use console_consume for netbsd
Date: Mon,  4 Nov 2019 17:36:51 +0000
Message-Id: <20191104173654.30125-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191104173654.30125-1-alex.bennee@linaro.org>
References: <20191104173654.30125-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, cota@braap.org,
 Gerd Hoffmann <kraxel@redhat.com>, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Use new helper to read all pending console output,
not just a single char.  Unblocks installer boot.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20191031085306.28888-4-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/netbsd | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 5e04dcd9b16..d1bccccfd01 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -93,7 +93,7 @@ class NetBSDVM(basevm.BaseVM):
         for char in list("5consdev com0\n"):
             time.sleep(0.2)
             self.console_send(char)
-            self.console_wait("")
+            self.console_consume()
         self.console_wait_send("> ", "boot\n")
 
         self.console_wait_send("Terminal type",            "xterm\n")
-- 
2.20.1


