Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E599C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A3B420820
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vwPTnu9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3B420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4jav-00039h-Mp
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 06:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSk-0004ee-4f
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSj-0004H8-54
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:30 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:43182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i4jSi-0004GX-VY
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:29 -0400
Received: by mail-wr1-x42a.google.com with SMTP id y8so13402030wrn.10
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 03:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/C/Ddn3mzT9qM5IiqGCuDyOeIZFrxvHB/E14ISaKzjU=;
 b=vwPTnu9BizIjGlbw0n4zUppDhI11vtld+pCm4A1iH7TfhT/xTLj8gZTBkBsIYJ+55/
 5pa4h2M6W5D9JJJyFqzcC/7AVubADNg1HpDSNYeTq16x5RWvdjBEex2bhnmGK9Fc1icG
 D9o8gJzMjHBiXiCa1ON1nzGLPkLvwdz8KJqvJHN7bVZp58uMZMNKMOD8bmMS+h9n4khg
 CH0TOl7whO3k5tIi4NcXaLBxAuV+AHcKLN6p5IhJaHeQb3fRaUz7u6H4xqfpH4z+/oJa
 QukA1L3faVJdqPaXYOqrNYsmT+DsCFhgI6sN01mPq3S5eKxzF9YLRrW8kUoDJrqbsZPM
 RypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/C/Ddn3mzT9qM5IiqGCuDyOeIZFrxvHB/E14ISaKzjU=;
 b=lPhY5HOlNZV5QAovR2B2gdnnV8UVsoE9jYTqC0p3RYNJaF0ZaYNhDBv5ZEKfm4ZVes
 JxXi6ka6x0M11fHx4re8Kc+Hlya9TOvuyYJES+SoxtXTWHKoBhENfJvb7TXq0cSjOnfl
 J0P//SzSzztIJxLEpQ1YkUpquUXOOdxhdDABz1ME8agSgdLBQYnSLXrL88G00MOgPaFP
 MdtNNapyqE/irj8yQGK7w/+QV24FIs1Jt8pBgAqPaUUziDbJiN+IqefvkFwMAmSFM3TG
 bedUiRz/2tw2fRCWimMZrwNzoVLKWRmiPdBbM3LCAdzyLzY2f6mfOVKyrzO6/pX4V+Ii
 D4rg==
X-Gm-Message-State: APjAAAWEKLZcDK+TcwtYNkVA853b1TQUJemUenyLdOOM6eWv54SxcssD
 ahz1O5bU6KZx+hjcyvD+j4UopA==
X-Google-Smtp-Source: APXvYqxUQ4NW67ovWg8n8nBv7RCfAhWuighFCz43rKRjqgW/m2g+rR3Tsb6hQTvlZfg6O/NlS7tFTw==
X-Received: by 2002:a5d:4448:: with SMTP id x8mr30583454wrr.119.1567419687831; 
 Mon, 02 Sep 2019 03:21:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o3sm16292947wrv.90.2019.09.02.03.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 03:21:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B6C961FF93;
 Mon,  2 Sep 2019 11:21:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon,  2 Sep 2019 11:21:16 +0100
Message-Id: <20190902102122.1128-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902102122.1128-1-alex.bennee@linaro.org>
References: <20190902102122.1128-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PULL 06/12] mailmap: Update philmd email address
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Use the email address where I spend most of my time.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20190822230916.576-3-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.mailmap b/.mailmap
index e1fdc88d25d..e68ddd26e67 100644
--- a/.mailmap
+++ b/.mailmap
@@ -32,6 +32,7 @@ Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@imgtec.com>
 Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
 Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
 Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
+Philippe Mathieu-Daudé <philmd@redhat.com> <f4bug@amsat.org>
 Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 
 # Also list preferred name forms where people have changed their
-- 
2.20.1


