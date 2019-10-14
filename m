Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422AEC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC64207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hy0HiJRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC64207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK0ux-0004Ps-Q0
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK0sR-0002V6-HD
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK0sQ-0007Cd-DB
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:59:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK0sQ-0007Bn-7a
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:59:10 -0400
Received: by mail-wm1-x335.google.com with SMTP id p7so17410064wmp.4
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O/zigszXN5tTv1Zklo4agwD/1f+VgMlyRCwif56R1fw=;
 b=hy0HiJRQfw49x/T4g6gi4zbPGuqXDxsJCZmnKIZA7M2UjVMd+R7gWvNnnDW/xTJcHa
 zSt81/gBais/Tidh00TZ4oSMtraXULVAUjtaGX/2aQ+bqUCUApzD+84rmILQ4wXNb9yc
 AtJmulRrSNxcfL/XdAzRORWGftDFRJPDBUk8A0R01puNdRP9K+knGDXwDp7LLC4/Shd8
 R5/uwTKIlap49LG5S/F96gjlzBO+i1WqyR7uy8byHC8E3snG8vbFk+KrQOyIql5UaqKW
 z+YtNFCfdEuWClnnRj/5vf3TSMigOjsSoWsAobDg9d1lPqxp2CpjAydn1ZrdLgmo/WNI
 4IgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O/zigszXN5tTv1Zklo4agwD/1f+VgMlyRCwif56R1fw=;
 b=iiNpB6KftVo7zRVBOfn4zDn7RNUWTz1zZ5kk9qbBJNYgZN05ka7UtIlTbrllyDuOE1
 egOn5zyuEC3TpVe6hKxd63+ojla1YiINv2r69z5O3gt6fKaM6s2KaqnTNyFU0yH6P8h+
 MMUzBRbfLod+hHcUzQJmwpkbp3vf44Sf26d7cBWOZR/iG6yJzAo7DYx0Exs7XQbsaWwY
 kDaR7RsN6Z5lmERynBWq5NDF+UrRF2Ke6E0f7AJi/ErfTTOIa9hCIOI1RFOFq+EbBr08
 tDCppdSFj3kle7zG6RvVPBVVoD3lP5H2KGO7c7OHP4vC+VcZo5ICH5OhQj1KsmotVwOi
 6L0Q==
X-Gm-Message-State: APjAAAUl/39PTKWsCZMVMMHz25lACKXN2Rhnzk0hoJ2tPwMio6WbI0p4
 UY8beyyg6u32rotKpdml3nw1kg==
X-Google-Smtp-Source: APXvYqwhqkG/CocpQ/1ntFZjqaB3OhcS3s2ybDizT6/3tpJIFOaTKhyVZl7Oh+T/7OTWXHDI4f5Mjg==
X-Received: by 2002:a1c:48d6:: with SMTP id v205mr14542958wma.35.1571061549001; 
 Mon, 14 Oct 2019 06:59:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e18sm25457129wrv.63.2019.10.14.06.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 06:59:07 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 753D11FF90;
 Mon, 14 Oct 2019 14:59:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 3/5] contrib/gitdm: add Andrey to the individual group
Date: Mon, 14 Oct 2019 14:59:03 +0100
Message-Id: <20191014135905.24364-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014135905.24364-1-alex.bennee@linaro.org>
References: <20191014135905.24364-1-alex.bennee@linaro.org>
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 dirty.ice.hu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Please confirm this is the correct section for you.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 contrib/gitdm/group-map-individuals | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index 301071b98b..624e27fc83 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -18,3 +18,4 @@ e.emanuelegiuseppe@gmail.com
 dirty.ice.hu@gmail.com
 liq3ea@163.com
 liq3ea@gmail.com
+andrew.smirnov@gmail.com
-- 
2.20.1


