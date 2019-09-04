Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E737FC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFBEE20828
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7dw+B7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBEE20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5ciZ-0001yI-8w
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3s-0000ri-N2
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3r-0003Rv-Hv
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:28 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:34895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5c3r-0003RJ-BO
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id n10so249307wmj.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=64G7UeLsDjFeeVvbu2xeSpSIwcgh91d94iOUcw83/Pc=;
 b=D7dw+B7KLFIq8rn6jnBco3oBLHw178Vp4XZ3U+rRQCCnwbc2ZJKUBSMOYyKuuj0idp
 O3XL8XDVpXkat7YP0L3fBZD7VpK/oCTDox3PJhgqH+5PXKbbG3PkI5THlH6TqqUEnFya
 QC88DkkRpnP3QswojcLMkydDrwgrYRdtYhUO38j57BTmmdCcJ754zg6/C122DZoY31mz
 bfRVy0QUsmU+XocWit4ek5qkk+444HnYxNtqVV3jeAnsuCX2qdogP3Y/QlREjwNayz7J
 PQgtVUxz1fS5mS7u9JJ60MzlWJdW7Qifsc0egLzgwCCf2Lbjuy4/lJvdpm2eO218Fkbz
 MYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=64G7UeLsDjFeeVvbu2xeSpSIwcgh91d94iOUcw83/Pc=;
 b=IXLhknhWZC/d1aK/gL1CI/6MantQNY9L1Z3TE2dzvmbtU2p5rmRFt0ODtsb7oLNS0/
 ws2iwQcjk+39Kl7WgWVnwz6W89VCxaVvbfRLZQ9e+ZLV6BMMw7Eb6ctAe32EIrNbxuEx
 cRe4jB3+0JZ9uIR6W9BDQppA4G/xwe67NO5QaDTciahyrx7fhNGKAcNILZa71GhADXUB
 g1FWi/fPkq+AO1gHR/CG7vY+kH8eqRJbKNWsBwrfg7+5KOhiEPqFaTc2o9E4wTZM0Rcq
 PSQO73CiwNniSi0+efQMnfJn7UVqxJheFgK7A5jGJz7bwQ8AnwanBftl3hmJzIVgQcw3
 XKtA==
X-Gm-Message-State: APjAAAWH4veiw42wC3sHv+llF1YAZyx2ez5v9q2xdrqwZZQJPLv7oo6Y
 L58gyF2Pv4tCXLa+Ci5mi8Qwew==
X-Google-Smtp-Source: APXvYqyS/s3YHmaX07MnQv0KEvXMNQvGtmfiAcKvDaPTbmHDhhKHy0rYPJc0YY/9RL/6wRwWWo1ffg==
X-Received: by 2002:a1c:d183:: with SMTP id i125mr134216wmg.1.1567629566291;
 Wed, 04 Sep 2019 13:39:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v11sm39505228wrv.54.2019.09.04.13.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:39:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6CFCF1FFBA;
 Wed,  4 Sep 2019 21:30:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:30:04 +0100
Message-Id: <20190904203013.9028-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PATCH  v1 33/42] .travis.yml: Cache Avocado cache
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Avocado tests download artifacts from various sources.
These sources sometime have network issues resulting in build
failures. Cache Avocado cache to reduce build failure.

See https://docs.travis-ci.com/user/caching/#arbitrary-directories

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .travis.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index d51125c9569..8d2e89da533 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -9,6 +9,8 @@ cache:
   timeout: 1200
   ccache: true
   pip: true
+  directories:
+  - $HOME/avocado/data/cache
 
 
 addons:
-- 
2.20.1


