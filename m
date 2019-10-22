Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C72CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D722184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A58/CEve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D722184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMznv-000585-Bm
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 15:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzej-0002Sz-7Z
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzeg-0005Nk-3L
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:20 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39075)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMzef-0005MW-T5
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:18 -0400
Received: by mail-wm1-x343.google.com with SMTP id r141so7653783wme.4
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 12:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t90FRs36jykQWIQiuf5k/HIsomfoZi6hqWnwwcBmJOI=;
 b=A58/CEve1bOsXJfvmqX9zNw9jJj517JTAESaQ4S/vEklYwUiYxyQP6LfbnCKAOvPru
 mXu9Borla2VdiPFSC3x7TsoEpp5vKk/NQ3xnACRtBe1x4CyF74uWak8cOjQricciBEP3
 liwvVbj6v4w2qyQJnSilInNZXXiojIjieic5W3ZeEkp1l5puWPY9jDK+nZxXN652EctG
 7AEN1KxV8u2gUxvLFNB2VW8cwNIkd+BNPDpNzNxf3APBD/hmG5MyIQOcKD6z3k6anAMA
 aMMjOFMLrwnR7dk2/KJIKOX8cJKaQFZhl35PHARSTjghwsF1rz+JZpAiQrMkzxN5ugkq
 OYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t90FRs36jykQWIQiuf5k/HIsomfoZi6hqWnwwcBmJOI=;
 b=AYhIRFU3wnl/9IPXQtoclKCzaMerqeBVWhAn4z53to+hH7TJspmLMyOZD5xKCdKmHx
 e0SXG14UH2zI4WUbn0iaGg/euHgzCfU//mTalHFs0ZxBetnveYpTfwI0nJuWpCclPb5O
 1PF64oWs5TshBVtk2V8L5hMy2QDLb3UsdCYCimdEkwS/Q1LEBrRWsBJhU682Esw7vugt
 nLV+uEGsgoXlAT1N1AbkXHR+zx+Snkj4XtYCJTXVxHboRAOz9WlonZLZEODR/cLI1QM1
 n6KPrkTTKKK5F+xZcVXeg4DNo/yialW5c646vMUwhK9i8xNZ+9xyAkJ55b5nXpE5kp95
 Vzmw==
X-Gm-Message-State: APjAAAUqSF2C0p1vkpVtLzxugr6/s+Y0pB5KCsrTN+E2Vf5gTs6A5QKy
 J5HHSCtzDhx+6Y+IK1TAIf2RSQ==
X-Google-Smtp-Source: APXvYqz5zbEshz26wnbOF01rWBN7Td4KpTklmBs2WepRM+KMGxcq2vzT6N8PmS9A+F+E3GIs73B2Fg==
X-Received: by 2002:a7b:c041:: with SMTP id u1mr4305307wmc.88.1571771836688;
 Tue, 22 Oct 2019 12:17:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o4sm30892371wre.91.2019.10.22.12.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 12:17:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6BE051FF9D;
 Tue, 22 Oct 2019 20:17:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 13/19] travis.yml: cache the clang sanitizer build
Date: Tue, 22 Oct 2019 20:16:58 +0100
Message-Id: <20191022191704.6134-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022191704.6134-1-alex.bennee@linaro.org>
References: <20191022191704.6134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hopefully we'll see the same benefits as the other builds.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index da6a2063fca..c43597f1331 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -189,6 +189,7 @@ matrix:
 
     - env:
         - CONFIG="--target-list=${MAIN_SOFTMMU_TARGETS} "
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-sanitize"
       compiler: clang
       before_script:
         - ./configure ${CONFIG} --extra-cflags="-fsanitize=undefined -Werror" || { cat config.log && exit 1; }
-- 
2.20.1


