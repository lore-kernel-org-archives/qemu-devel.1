Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8371EC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 524B124656
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gu/AyKWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524B124656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aQp-0001hr-GZ
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcJ-0005IK-Dd
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcI-0007Av-Er
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:15 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37650)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6ZcI-0007AQ-8A
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:14 -0500
Received: by mail-wm1-x344.google.com with SMTP id a6so3025472wme.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GlBEWrYmHPRFA8Vm86nN9N2GJk+iLZ3w8i1wPytFKGY=;
 b=Gu/AyKWJ2BHrNn9WhmPHTtWPKNEeUMzz4BiqBu6KeoGWPKpmz/Odi5KicyQNh0M5Mp
 w5GSChKDdBRu1aOU1AgAuXFHqzCul2a1ia3LCqW9TIXmYjdyVtKMN9IkgEY3tZuH82n/
 lXEj+tahoF8cSFxf7fj6IFu3Z1xB7ejmGR/zPkQJGjJO6v/lajm8p5clP8hL7gc1H3oj
 9O5KHW1AzeZoHmaky1akFdLhvaKpGOBuY/HXYs4Rctzey7aMz3BiXZQmhEM0dere9HBK
 MayXo+S4V+FR5gqeg3XGPHwci11WUlitriRs1z/ppw9Az17kXT51adtMgQqON2/Txroj
 0GEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GlBEWrYmHPRFA8Vm86nN9N2GJk+iLZ3w8i1wPytFKGY=;
 b=IoZIw97qXTPIetnLuGPHJzO50S75/RPy1JPoffCflfKww/D6MqstYtISb7isTmZzzD
 GHVhzpltk2LYrkrw1XcBP0jkoGNIgWqqZ6raCVWyPGt0/4Pdn3me390HuYwPKqbWJyCx
 LJkdfcERK9S6zGakbF20Ha3TQbTplfoiOddXiVvVDty38YHlDHeI2Oc0bzm1G4qe22Ty
 dvUki/AsnElwZ8RzuQeNT+CsCTzFmscqyf6cVLC0xUvXYU8lY2Ga/AobPTF6OES9zlLg
 IGxif5+mNShL0qLAlrjR9Rssrh9rKPlaOddp3kj/2jhyA1EiDgJTb7YjKUNgnqwhC00Q
 oEJg==
X-Gm-Message-State: APjAAAVTYWF+gPoDEXDTTTx8GLqeL80gNJJjHq+LHSShvaBPdxhLIPym
 wrDbojWXadHNd07Y76y77r2Ubg==
X-Google-Smtp-Source: APXvYqwGmM5Llnn5brJee38dKonnmBgO1xcAXEc0daVSl9jdI5XHV9NcXPlRXB88FMQAZw2FSX2yQQ==
X-Received: by 2002:a7b:c088:: with SMTP id r8mr5237126wmh.18.1582634833064;
 Tue, 25 Feb 2020 04:47:13 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b10sm23808009wrt.90.2020.02.25.04.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:47:10 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5BF491FF8C;
 Tue, 25 Feb 2020 12:47:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/19] tests/tcg: include a skip runner for pauth3 with
 plugins
Date: Tue, 25 Feb 2020 12:46:52 +0000
Message-Id: <20200225124710.14152-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225124710.14152-1-alex.bennee@linaro.org>
References: <20200225124710.14152-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, robert.foley@linaro.org, pbonzini@redhat.com,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we have plugins enabled we still need to have built the test to be
able to run it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index d2299b98b76..71f72cfbe34 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -70,4 +70,6 @@ pauth-3:
 	$(call skip-test, "BUILD of $@", "missing compiler support")
 run-pauth-3:
 	$(call skip-test, "RUN of pauth-3", "not built")
+run-plugin-pauth-3-with-%:
+	$(call skip-test, "RUN of pauth-3 ($*)", "not built")
 endif
-- 
2.20.1


