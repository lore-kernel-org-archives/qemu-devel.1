Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49960C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1449E2465E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZmFWH30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1449E2465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtSz-00073J-T6
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNO-0006kt-8Q
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNN-0000QR-0p
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:50 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:35830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtNM-0000Ca-Ms
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:48 -0500
Received: by mail-wm1-x330.google.com with SMTP id p17so5127426wmb.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O/LDCXsheLvMycNdYAZzehR+/HRrv8aczpwXJp22nJc=;
 b=eZmFWH30IrBfN1MziG/qW+3RWVe/g4NkTMXUkb1xBkeBUAsVgVtaLQEqrrVG8h/PRr
 rm2YilrGBrpZyXdJTihaipMzia76CJq9TNHxjE3KCI84vTseTO9b3tkuLKRlXGpIR99q
 h2D+RCFDQlak7QTY8nGqQr34sbEtl3+vzsz7SPC0Mwgy81n5j1x+HU/d8O7xlMlk2VOF
 jbE11X4kWWLZgvKY28x3OCnbU0gtm3OH9MCVG5Zu7Q/WSzU0V8ATfm10qD4HRomf8KOW
 NZjcfYn9I7e6WB80wR6RtRsc149SFkHREVrjdSvtpb1i/0d0YACRWMwgpuexzKzKCCy8
 pEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O/LDCXsheLvMycNdYAZzehR+/HRrv8aczpwXJp22nJc=;
 b=MFL5t2Wex4HOLaRxlCl7zoeD478zISbnII6tgLbuwWwQ3iLdP0GOKo37rL+Hc4IhRH
 UvJA0f5NReo3QJN+PE4XtMNnAR+Ym1nt86IU4DAAXCU0bd8chWDR13buqUo/P4TkZZmy
 DqEDE7iLfpT1VQASPewXyrpxFpaAEzt9EQoBDMHfxOkhWinSgJU5mNcc/9ke70AJUjgu
 2q9Xx55XnDf4R5bz6xAs7dCbulfMRgVlqSR253Kw3v+HCLl8TA7rWnY9EAQGIyXbX1NZ
 JACPlGs9E79poGbm5mmdJJ29FrlRCYoQ9YQjDBqS0ojeb0o9ukhpCy2QK3UmtJd+WADr
 qP5A==
X-Gm-Message-State: APjAAAUJr5/3SgHa/LvLacrA4JSFlQrj6vTgJE/+k8Cnc5guiZQw4iw9
 qkeRyA9In6BpD3ZVCM0k7AA0G3eXse0=
X-Google-Smtp-Source: APXvYqzKjjJ2emoTnzoQp+IXOCjSFM9eHe6pucfG8fE4hDgwdmAZXjfSWQUMGUsAHH1rBWvowCqP9g==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr9248520wma.24.1576752586289; 
 Thu, 19 Dec 2019 02:49:46 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e6sm5932997wru.44.2019.12.19.02.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:49:41 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 179341FF96;
 Thu, 19 Dec 2019 10:49:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 07/25] tests/hd-geo-test: Skip test when images can not be
 created
Date: Thu, 19 Dec 2019 10:49:16 +0000
Message-Id: <20191219104934.866-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

In certain environments like restricted containers, we can not create
huge test images. To be able to use "make check" in such container
environments, too, let's skip the hd-geo-test instead of failing when
the test images could not be created.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191204154618.23560-5-thuth@redhat.com>

diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
index 7e86c5416cc..a2498005440 100644
--- a/tests/hd-geo-test.c
+++ b/tests/hd-geo-test.c
@@ -34,8 +34,13 @@ static char *create_test_img(int secs)
     fd = mkstemp(template);
     g_assert(fd >= 0);
     ret = ftruncate(fd, (off_t)secs * 512);
-    g_assert(ret == 0);
     close(fd);
+
+    if (ret) {
+        free(template);
+        template = NULL;
+    }
+
     return template;
 }
 
@@ -934,6 +939,10 @@ int main(int argc, char **argv)
     for (i = 0; i < backend_last; i++) {
         if (img_secs[i] >= 0) {
             img_file_name[i] = create_test_img(img_secs[i]);
+            if (!img_file_name[i]) {
+                g_test_message("Could not create test images.");
+                goto test_add_done;
+            }
         } else {
             img_file_name[i] = NULL;
         }
@@ -965,6 +974,7 @@ int main(int argc, char **argv)
                        "skipping hd-geo/override/* tests");
     }
 
+test_add_done:
     ret = g_test_run();
 
     for (i = 0; i < backend_last; i++) {
-- 
2.20.1


