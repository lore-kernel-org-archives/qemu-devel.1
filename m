Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4476C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 837E121721
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LenmuXzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837E121721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41480 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdgeL-0007wM-NV
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53896)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRX-000643-Ct
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRW-0008TA-4x
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:27 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:37569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hdgRV-0008SS-Uh
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:26 -0400
Received: by mail-wm1-x32e.google.com with SMTP id f17so709071wme.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=agoXBU9KBwBvYhLupQKySupZDhJoyEvavC+P1ObpTUI=;
 b=LenmuXzHbJZYCZiqMPSJt1R8ChPKFru3KZsS+sKjyzc0whAIF7NtQ3dwN1K7zsOICy
 w1bT48CttJsIQ3R1T6LUolybx5swIE8PX3E6+9JwbQsXgnfHmrU6sVIXvU2y1a1dRHSg
 PMp3RjeG0arjOQ0UDXfOC9pK7Jr4ZRrs+YHw7Gh0+OLsyHQ7V+5bujLHWA35Yqn2j5Io
 3UViTwYtLu+QoKM3OJnsrNPxwbVFaOfaTx0WkWLaxKfW5aEn7jZ7iMBCLrEfZIsfEyib
 tYsGL61+v6lAae6lRTEyVeV1UxF+U0IS2dXheFWhEfHgjVpfP31EmPk/JqocV9P3qj8q
 Luog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=agoXBU9KBwBvYhLupQKySupZDhJoyEvavC+P1ObpTUI=;
 b=A4n3vvL3rDavPvKnl4hAf2VfiLDROsTupNKRQtN4sZk7xuxKGbv/y8TyjwCj31uS6x
 gBclMIdLO25PRcZs9Z4C3WjXdOUJ5WN57AW5AkMFZ05WsyqnSEf/uZcEYcb6gql+5TBl
 XeVZ4J5Vw7JthARs/9BtrjJXUHL+cpAYEGDLkKqslkBhpbDdM2UATyrQxbqDNO+8LIqT
 l0V84W4THk/agL1KNi28cRHaUwV5CwqQ/B9zkLfTOqIhijVr459bm17lqRmQ67FbZle1
 +PQXnGZ8FCh87/jdPftUvKVVMw8tfMJzZ2Q/WnUiTqtHvRE5t3ixy7V/wNRv81lKlpzv
 kHTw==
X-Gm-Message-State: APjAAAXR9DgYZjCpLy1bhNN374XFOa+UbMm+i8+38qHCLf22kDWZ4eaI
 UHc3fen5+DiYOzr51wkm9uTw6Q==
X-Google-Smtp-Source: APXvYqxQ70p/1m+zJpeYg7P6rt3DFikl+48jWNv3BPQdT/1S4OtgjAvVbT3Sfh+Ri+jAWmTRZcH46g==
X-Received: by 2002:a1c:5453:: with SMTP id p19mr8935717wmi.148.1560973224759; 
 Wed, 19 Jun 2019 12:40:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id r2sm3356988wma.26.2019.06.19.12.40.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 12:40:22 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B86581FF90;
 Wed, 19 Jun 2019 20:40:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 20:40:07 +0100
Message-Id: <20190619194021.8240-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619194021.8240-1-alex.bennee@linaro.org>
References: <20190619194021.8240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PATCH  v1 03/17] tests/vm: pin ubuntu.i386 image
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
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cleber Rosa <crosa@redhat.com>

It's a good practice to always have the same components used in tests.
According to:

   https://cloud-images.ubuntu.com/releases/16.04/

New images are released from time to time, and the "release/"
directory points to the latest release.  Let's pin to the latest
available version, and while at it, set a hash for verification.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20190613130718.3763-4-crosa@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/ubuntu.i386 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 12867b193f..7017e6d388 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -61,7 +61,9 @@ class UbuntuX86VM(basevm.BaseVM):
         return os.path.join(cidir, "cloud-init.iso")
 
     def build_image(self, img):
-        cimg = self._download_with_cache("https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-i386-disk1.img")
+        cimg = self._download_with_cache(
+            "https://cloud-images.ubuntu.com/releases/16.04/release-20190605/ubuntu-16.04-server-cloudimg-i386-disk1.img",
+            sha256sum="e30091144c73483822b7c27193e9d47346dd1064229da577c3fedcf943f7cfcc")
         img_tmp = img + ".tmp"
         subprocess.check_call(["cp", "-f", cimg, img_tmp])
         subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
-- 
2.20.1


