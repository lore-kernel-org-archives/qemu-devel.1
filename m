Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D4BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409BE22365
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oe5fUASk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409BE22365
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNni-00066v-CZ
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 06:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iXNgX-000702-Md
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iXNgW-0006w0-KF
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:09 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:55350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iXNgW-0006tP-Dy
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:08 -0500
Received: by mail-wm1-x329.google.com with SMTP id b11so6474129wmb.5
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oWcIQ/2bWz6obkCCFTgR8jDb7UZS56VNJ8y1/fSAgYM=;
 b=Oe5fUASkYLzvvtdtEtmJbLRU+Ym8z48MF65yA0mvfud5gYE46G3mPC5T/5DBFH6GrJ
 aNWmTdUOFpoDR7RVY36Jlhhq+MMM2gN1vyL6pJm5dsCuWkMr6ubWXrmCKyZv1SL1Jd4S
 +pPUYCjkOnxCDFOctffRdhL4FuQpo/DbNpsGUyBDMppaFwCbubCfX7l/sDidzlw/nVtn
 5E4oztFYHKn/IA/q+aant9okp39c/o0HNX7RLDjeB33DDARD/RuUKRexPSZ2IBLXWZZ2
 nU9/SpNLphOei6Wu10UIoJr1d42LmVD6M7X7Bz12Vu1Tk5E6dGKEHJDJBl0PIxr1SyD6
 Osig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oWcIQ/2bWz6obkCCFTgR8jDb7UZS56VNJ8y1/fSAgYM=;
 b=IwlJDs40shifc3IZ33NilcdyUOu+F6gYW0yzJgEwxM863Txk2u6d+7eVYrq3iLnKdr
 yXiz61L2q3GG7iNzkYRwiCi40e7PA4vcnwW79p3SDK0z29KtmswLk5Q+LIrdDWpQrvLc
 E0AQ85WfEjgkukxr4IGpLxfJwVp9rQqcqjT6nWBVXzlyMnFdF9r7DtzY5T6V+1W1EP3T
 pntfZ6xeJCEyjK9wlrz+5iVfmY3khiMccu6JwA9QbZS+CvaKoSng+Ur5M8qtSQdV2bps
 hArPIsTk3EHidLWaGAjBAX6QorpDhHlzVbd/s2JT4sY2doJDWKQNBUfGqLBQGEOAdGSG
 v44w==
X-Gm-Message-State: APjAAAXsn/V11KCeFzx6hUUY5zwnifpSolr2KkHAuIxU4ez60Mo99DjX
 qEB1D5BxVGqPFklyKxfg8vTaIQ==
X-Google-Smtp-Source: APXvYqwV9aIVVfqf3DQPUQ+/OdJhLqs9w+WIxyLdFYj1tJC9ku+bzwDIHZ6P4xdUiBII9ysjuJ7ylw==
X-Received: by 2002:a05:600c:22cb:: with SMTP id
 11mr2428072wmg.117.1574247487115; 
 Wed, 20 Nov 2019 02:58:07 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j63sm6434509wmj.46.2019.11.20.02.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 02:58:02 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 83A921FF90;
 Wed, 20 Nov 2019 10:58:01 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 3/5] docs/devel: update tcg-plugins.rst with API versioning
 details
Date: Wed, 20 Nov 2019 10:57:59 +0000
Message-Id: <20191120105801.2735-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191120105801.2735-1-alex.bennee@linaro.org>
References: <20191120105801.2735-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
 qemu-devel@nongnu.org, Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While we are at it fix up the quoted code sections with the inline ::
approach.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index b18fb6729e3..718eef00f22 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -25,6 +25,23 @@ process. However the project reserves the right to change or break the
 API should it need to do so. The best way to avoid this is to submit
 your plugin upstream so they can be updated if/when the API changes.
 
+API versioning
+--------------
+
+All plugins need to declare a symbol which exports the plugin API
+version they were built against. This can be done simply by::
+
+  QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+The core code will refuse to load a plugin that doesn't export a
+`qemu_plugin_version` symbol or if plugin version is outside of QEMU's
+supported range of API versions.
+
+Additionally the `qemu_info_t` structure which is passed to the
+`qemu_plugin_install` method of a plugin will detail the minimum and
+current API versions supported by QEMU. The API version will be
+incremented if new APIs are added. The minimum API version will be
+incremented if existing APIs are changed or removed.
 
 Exposure of QEMU internals
 --------------------------
@@ -40,16 +57,14 @@ instructions and events are opaque to the plugins themselves.
 Usage
 =====
 
-The QEMU binary needs to be compiled for plugin support:
+The QEMU binary needs to be compiled for plugin support::
 
-::
-    configure --enable-plugins
+  configure --enable-plugins
 
 Once built a program can be run with multiple plugins loaded each with
-their own arguments:
+their own arguments::
 
-::
-    $QEMU $OTHER_QEMU_ARGS \
+  $QEMU $OTHER_QEMU_ARGS \
       -plugin tests/plugin/libhowvec.so,arg=inline,arg=hint \
       -plugin tests/plugin/libhotblocks.so
 
-- 
2.20.1


