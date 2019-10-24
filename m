Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37E1CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916AF20684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tEZmI5sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916AF20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNaIi-00067T-QO
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGT-0001wP-Pg
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGS-000423-Jw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:45 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39862)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNaGR-00040X-Ux
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:44 -0400
Received: by mail-wr1-x444.google.com with SMTP id a11so9342889wra.6
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jH/0ruA5i4owuXTx/HGX42cpo0SMXjcQEx9rET5hw4Q=;
 b=tEZmI5sqPZqBsazIg5xNlNI4dBNWKcGctCEK/DqFDkcYJjS7HFnOCJbeCrBTp6UXuT
 MSuAZQCEeol+GI9WtWrgnu+oLzqqnHLsvRWzeoHPFRRba28mZnK0CMWJbgHfgNMEZ0tQ
 Pe5WYYg3zlYdQJlc48PPq5mskUlbXg7RbvtfzHVuC1M03ZAJE+4ZwprlC5HlfBrXXT4t
 jwC9ylfyawmDg1nxoXADTG/v6tO9+aWwf6wfERL1UahIz17qSQzFSGZIpoSmodCrrdkl
 DeNpHBt4e9Equ4C0YZSJDSq6hdTzfEXk+n0O9ztXmWpnAKhdXphk4ItScKrU+g3DUiZ/
 tfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jH/0ruA5i4owuXTx/HGX42cpo0SMXjcQEx9rET5hw4Q=;
 b=ELgU3wQ+3n8PzqoCgoTOXhnNWLI3RiO/x2b1I/LtXZrVZHO3WVp6ePlMsL8dEn0p8I
 pUO1ORCHFuzo5KQkReVYtWZiKL5JHgvzRQML5sJFDQfnXxLQadpLcMi5Z7xaLqqx2ktd
 npiXArdWAvXDwCFftUDNjS38xf2lk2Dum8zAnuARFQJdgj54pq64XKbWojlCHpN4LJvq
 2d76LNATAJ9oZn4IirjnYt9I15Tly7PkJOXQyoLaxnJCH+mFmroH1xS5hFZTULNNafWQ
 PW2wBZdZzO7h+YWYkOKwDu9cq5ogQkoIrItU5uh3ql73wlPZaubQ+BeczOifw0UJmNxl
 NysQ==
X-Gm-Message-State: APjAAAWv1cB3v9g9m/OBEdENfLd7oq8ruvLTSVdamOWh/culgxs7WLrV
 8SuhfcZYcJcclZ2hFerHdvCQ2g==
X-Google-Smtp-Source: APXvYqyNeeW+ybSh+QyJtWm07THxz9mYVU5/MAvZAZtgv6bM1cvjLNO+KlijL3mSnXHkUPegUW+Cig==
X-Received: by 2002:a05:6000:34f:: with SMTP id
 e15mr3414260wre.232.1571912561947; 
 Thu, 24 Oct 2019 03:22:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r27sm41534849wrc.55.2019.10.24.03.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 03:22:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 681641FF8C;
 Thu, 24 Oct 2019 11:22:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/17] travis.yml: reduce scope of the --enable-debug build
Date: Thu, 24 Oct 2019 11:22:24 +0100
Message-Id: <20191024102240.2778-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024102240.2778-1-alex.bennee@linaro.org>
References: <20191024102240.2778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

Adding debug makes things run a bit slower so lets not hammer all the
targets.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2
  - drop superfluous --enable-debug-tcg in configure string
---
 .travis.yml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index d0b9e099b9c..7d90b87540f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -124,12 +124,13 @@ matrix:
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
+    # --enable-debug implies --enable-debug-tcg, also runs quite a bit slower
     - env:
-        - CONFIG="--enable-debug --enable-debug-tcg --disable-user"
+        - CONFIG="--enable-debug --target-list=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug"
 
 
-    # TCG debug can be run just on it's own and is mostly agnostic to user/softmmu distinctions
+    # TCG debug can be run just on its own and is mostly agnostic to user/softmmu distinctions
     - env:
         - CONFIG="--enable-debug-tcg --disable-system"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug"
-- 
2.20.1


