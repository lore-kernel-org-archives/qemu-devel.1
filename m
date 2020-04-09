Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D716C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591BD2074F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c1tIiXID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591BD2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMebe-00029E-Eq
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 17:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeWU-00025x-6o
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeWS-0005hh-Ah
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:42 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:34130)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jMeWS-0005h1-5I
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id c195so3416623wme.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 14:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BdeCn4+10IAGnxWmwrkvRB49uZrWTVunuxiT/Jj8P3k=;
 b=c1tIiXIDvJBh4Eg+6dYhPcprRYOKl0gTIA+tOK6kkmyV2UDcoPbXFzKujxwNqvvm7T
 dHOSaOHKMbicZu+Gaes1roDlsxRbG6gjBC/4IZfy3aQVrBpeK+/NvcIPo07bd5gAH4Q9
 F1sciZTvpgMMvuEi59jNbPl42CFaRf6z59Lo7LY7Eu6aGI9YWxI1Y5Pn5+Bq57F+QWRU
 XZ2YiDv1334obufMCg2uKXmRAaGl54ajveewnBeH7XB85HvzzX64rv4KEkIyTAvvSEEF
 fJ530c/YPRKtyLdvxnytz4mPX8x4/29eJzaNx9bfkVdbEusdohr7JLs6Ggqakg6S809N
 3fKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BdeCn4+10IAGnxWmwrkvRB49uZrWTVunuxiT/Jj8P3k=;
 b=e3jRnnzwvWnaW15tyaKIvTn3THdoWqiMEW6zvSKE7HYZf6nDyf67KO9A8VBGfif/dE
 Rtu/p3vdtkiqTwla+XBUI9O3QvO/dVF2HCTMQzAYe2+nRaL75ViZx1LATxQX+Bulabim
 5FtTT9raT2XopaY0JM9aqZDEM0tW4wHWm9e4Vjc+cbuStt3xcZx+KVRwigEKoSRthf/x
 8VRWnIu9vaAdOiAycukz2Ws2AOmXJZrlFp7Z/K2xydF8yk+XYYPg48Bsp3ARZiHXFZ5F
 MhHzctCtlipoFO306RHz8+jVcPDrIdFdrMMUhz9f82oqK4Yt3b6x8r4U/r8s5vDBgL5p
 VvVQ==
X-Gm-Message-State: AGi0PubNOB3IJUbZoKqPk7KmnVyxOcS6e/sJh0yPRt0iJjZfvK3OWXkG
 Undp2iW3GoCeO6Eiz6wW0T5G5A==
X-Google-Smtp-Source: APiQypKE5MeDGOqE7WkXJJeUEpYo+++z2drN5M0o5Q9fsI8ABvviper07GxK6+qMphcq8hR4A1smxw==
X-Received: by 2002:a1c:7415:: with SMTP id p21mr1720225wmc.93.1586466939240; 
 Thu, 09 Apr 2020 14:15:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s6sm5167430wmh.17.2020.04.09.14.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 14:15:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 967B61FF92;
 Thu,  9 Apr 2020 22:15:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 06/11] configure: redirect sphinx-build check to config.log
Date: Thu,  9 Apr 2020 22:15:24 +0100
Message-Id: <20200409211529.5269-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409211529.5269-1-alex.bennee@linaro.org>
References: <20200409211529.5269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Otherwise it's hard to debug whats going on.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 233c671aaa9..a207cce82bc 100755
--- a/configure
+++ b/configure
@@ -4936,7 +4936,7 @@ has_sphinx_build() {
     # sphinx-build doesn't exist at all or if it is too old.
     mkdir -p "$TMPDIR1/sphinx"
     touch "$TMPDIR1/sphinx/index.rst"
-    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
+    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >> config.log 2>&1
 }
 
 # Check if tools are available to build documentation.
-- 
2.20.1


