Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD50C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C7662051A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QMUQxSP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7662051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPnH-0006Ls-IK
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jGPjZ-0000vW-9a
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jGPjY-0002SC-7x
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:25 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:39704)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jGPjY-0002Rt-1u
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:24 -0400
Received: by mail-wr1-x42c.google.com with SMTP id p10so5412847wrt.6
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 09:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B6Cb7slCEdWoBAd5Has3ct+kMqek/eNqCVLXoAvsZ6M=;
 b=QMUQxSP1lGsY5JR+R2zFZvtr0BT8yIU1XiKrNxtuZ86JYAtkAZxQParrCOX7esYBP+
 SOWfdfemEtVNuP+R/ueJ+pLT4ZVOjedidQMnhc5l8HcHiZY5c5q//kb68aad/YDCrjdE
 Ayo2U+0ar2affRuy3RFdLnXMhp/tkV2iMseF85/MDlLCLzswHaR+BE4znXjkXiAk0oNj
 0Plj1NIoBmMYSxZgkf9mzp+CIclgze2nmeL5yA7vrceTjkBYwZXkf/BwqkAl3uQVPh/n
 FihS8VyHtupgUZ5/JcAMcysqMhkFte4im1JzuCSRDAy5siLl9sf+iqhAdL/THMpnc3tx
 pLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B6Cb7slCEdWoBAd5Has3ct+kMqek/eNqCVLXoAvsZ6M=;
 b=nFDO5Bruc4vd5RFq2aj2NaEQgCTBdEkqFsMlIEJs5OrpPcdNxzVBKsngSR2bbZk2Ci
 V3HPB1Nc5U3Is3092BQJq+5EqiPygVrhy5i32vCwTD/Vlu2YS5EUn5/z+X/UxpXgkgsg
 YNO1BwLurlFgTfVg+ER+X6SGWHvSwxj98btzVfI3p74uKn2FQ4afwq9cw7AeUoddZfC9
 BR5h/vk7OPj2+kWQfALbRjWt42EPvKRzsmQBQZ1WyvzGW+iEHQ4JX5/EcmpVubWmjAJt
 czYq0G1vYkqAeDuU8OBNFr/QAzbUJWrCv8mwQzQVFXY53tIuzrvPOND+FDcEBbwy0vgg
 +3Iw==
X-Gm-Message-State: ANhLgQ0GDNPjqx08UlIiztpmJiGxid/FDJ33FwCwfrv+iT9cH7KJ7/9c
 dtdy+LszGw0lug3qCGulcyJE3w==
X-Google-Smtp-Source: ADFU+vsUN+PlbFKx1Hsm25tzZ9nVygtSCVMVTuhr0N6HR0G/HDq1JniSpsKrcWm9d7Z/4LWOh8E0dg==
X-Received: by 2002:adf:a2d8:: with SMTP id t24mr27297625wra.366.1584980123083; 
 Mon, 23 Mar 2020 09:15:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g2sm25320882wrs.42.2020.03.23.09.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 09:15:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4574C1FF8F;
 Mon, 23 Mar 2020 16:15:15 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 03/11] tests/vm: update FreeBSD to 12.1
Date: Mon, 23 Mar 2020 16:15:06 +0000
Message-Id: <20200323161514.23952-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323161514.23952-1-alex.bennee@linaro.org>
References: <20200323161514.23952-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200310083218.26355-4-kraxel@redhat.com>
---
 tests/vm/freebsd | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 58166766d91..298967fe9cf 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -24,8 +24,8 @@ class FreeBSDVM(basevm.BaseVM):
     name = "freebsd"
     arch = "x86_64"
 
-    link = "https://download.freebsd.org/ftp/releases/ISO-IMAGES/12.0/FreeBSD-12.0-RELEASE-amd64-disc1.iso.xz"
-    csum = "1d40015bea89d05b8bd13e2ed80c40b522a9ec1abd8e7c8b80954fb485fb99db"
+    link = "https://download.freebsd.org/ftp/releases/ISO-IMAGES/12.1/FreeBSD-12.1-RELEASE-amd64-disc1.iso.xz"
+    csum = "7394c3f60a1e236e7bd3a05809cf43ae39a3b8e5d42d782004cf2f26b1cfcd88"
     size = "20G"
     pkgs = [
         # build tools
-- 
2.20.1


