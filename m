Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBA3C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 653462082F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yUZ23rKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653462082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Na0-0002my-KK
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NTY-0002To-3P
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NTW-0002Yc-KK
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:00:51 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NTW-0002WQ-BJ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:00:50 -0500
Received: by mail-wr1-x441.google.com with SMTP id m16so8737636wrx.11
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 15:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=780TgO1890Xq9etwy5Wkm9rG0nDBsWFiY9YYDt6ZXB0=;
 b=yUZ23rKNfHcb/7+jje5nJei7gtfYWb9MwbECCovDifWWM1ElS1b8RSoEX8aYqYYcfS
 wg5VEE5nN0RzGsitWjPpJ8Gf0kyhRYjG0c+snGdKBMDFUjeMybPHAhIbgYT7Kv/Ylctn
 DxCqfh+ITlOfZ2e+6Jo8dsHAWerimBI66k4tb2BbetiaXmnHqCb5/r0SUgO3VcxX1oG+
 hdfIseZjPHsX1mI61kIUihGcuhQflj9aC+twGJbZgmUnLr4QQSYUNzKHl1PM1hGNVC/n
 qIgHdffQDrvnC4Z2h+YM9PWpqayrkOYTDpCmPIitTts6hSCot0pr9YIBY8X+3LK5JW82
 Hlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=780TgO1890Xq9etwy5Wkm9rG0nDBsWFiY9YYDt6ZXB0=;
 b=GWqMCSkaHM1B3VLbw8Tf6TIkWhiQRPcW/P0tt6+5hwFCObxKNMBfCW8zArr9gGLiKJ
 2GAdRTEeV73HdTyJTTPXMHf6BcmxzDtvG9Pw1piP+l8nKz3YKgd9vYGKqXbVazLclcwE
 2XcPt2gZMzVaqTc+eZ8dKGIBjHlnfo3p+oC9MADfHQUnhaLBGxKMLiacEy2gI/ZcesMy
 u3oU2hZ23jCfT8X2Aw0jSnHHjT5a2QKW+1+GwRo2clcKCz21b/YTT/UlWubwUxC7d3DX
 sm/MhUVwlZxginORHPUizqLm92JAop9qRO4l//CSKZw6vlAgn/mCsz044AtEY6wZW3jt
 r5pA==
X-Gm-Message-State: APjAAAUVKfzGIeUvneWcUYqqC5m4/MnYXpd0HFrcCSvyMVo8Xbp8DoZE
 Y29ebvnbfHfHlMUu1fm1j0gSuQ==
X-Google-Smtp-Source: APXvYqytrUaEPTqgIHaJh5Yp21xAKlW8FM8L/ZeVEfLmRIPBS1Rjv6NZsskn6ffp3uDk2DDrPC1hrw==
X-Received: by 2002:adf:f401:: with SMTP id g1mr23420846wro.129.1581634849229; 
 Thu, 13 Feb 2020 15:00:49 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b10sm4571268wrt.90.2020.02.13.15.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 15:00:45 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0D7FB1FFA5;
 Thu, 13 Feb 2020 22:51:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 16/19] tests/tcg: give debug builds a little bit longer
Date: Thu, 13 Feb 2020 22:51:06 +0000
Message-Id: <20200213225109.13120-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When combined with heavy plugins we occasionally hit the timeouts.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile.target | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 3c7421a356e..b3cff3cad1a 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -79,7 +79,7 @@ QEMU_OPTS=
 
 # If TCG debugging is enabled things are a lot slower
 ifeq ($(CONFIG_DEBUG_TCG),y)
-TIMEOUT=45
+TIMEOUT=60
 else
 TIMEOUT=15
 endif
@@ -137,7 +137,7 @@ PLUGINS=$(notdir $(wildcard $(PLUGIN_DIR)/*.so))
 $(foreach p,$(PLUGINS), \
 	$(foreach t,$(TESTS),\
 		$(eval run-plugin-$(t)-with-$(p): $t $p) \
-		$(eval run-plugin-$(t)-with-$(p): TIMEOUT=30) \
+		$(eval run-plugin-$(t)-with-$(p): TIMEOUT=60) \
 		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
 endif
 
-- 
2.20.1


