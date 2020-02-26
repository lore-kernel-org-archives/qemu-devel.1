Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7244DC4BA0A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C61E21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XpREKRW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C61E21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rOz-000428-9j
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rIJ-0000ou-Dd
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rII-0002nJ-Dy
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:47 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:56020)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6rII-0002mH-7l
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:46 -0500
Received: by mail-wm1-x333.google.com with SMTP id q9so1780394wmj.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 23:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mn3tZc+6oKOSCrxCoePvIC2GrhQUWPNKBtpwoHXLA0s=;
 b=XpREKRW0Di0Rk/yV8URDk3aU1r91fPOfch/W/YTPH4sbpSQSMmcpzUwl3EYc9366ab
 HpayAecNgnu3yEn5qWNxI/NADPtl8APRhuZ7GAU1jEt+syCWZlGwpA1ZE0VCtX53GcpT
 9YG4QsPo94C17IPfI9GOKP26FTMkraFqvoTGqzr6kA6eJ7QnZtz5DaJIBYrUptS3foaO
 lII68SQhTbWWgtkTQ2P2nLxtuN1nOYHsAB9GojL9dUgVCCOFkg2F0RWBoOzjVn6hfnI7
 0jNrgVg3bdLNbeAYuQ/9tPy4Iy8+5OJt6W4swEM5ubZ8xkKXlt+qyjE8PKXlndzS55uy
 Kvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mn3tZc+6oKOSCrxCoePvIC2GrhQUWPNKBtpwoHXLA0s=;
 b=rke4X5nTJinT74U4IjktE9BG+soE3GZCrRyYnCL77XbeQZEQNnI7Z9K//+vOmicPUE
 JnstvrloRARtjiDNwAFoEgEXZkuGyEDazSBpZ/hxCtoJQXlRGWFHzS7Gq9l24wCTHKWD
 5F+TMrTC8cFzXxGITmyGEPQwMenuc05ltN614qAQFy76jcWIC4j2ZeJhC2qj4i/t96aq
 I6+dDPmBixW3k6LLRh1SisZNpJhkXH4EPJXfNHCSMpxR/JQRROcToqkU/sNDYAlhDIC9
 /gXHGP1cJ4xZv1Jcv8/ZMWtDLFeVFuEyx+raUEqdvfHBpgbhRg97AhKbRvhL+2Iq55DD
 ffDg==
X-Gm-Message-State: APjAAAUlMchar2BcWQ1JntSG7wshIGGCxVcyFiovVso5mYII/xhCSia0
 T6aRfBI1+XM+8pcS1IaKjSV1uYlNMng=
X-Google-Smtp-Source: APXvYqx0KEL1bkJ2q9MoIP9AmNBGSb71aIj1DchaMxAHQH7Z2sQxp3HNZO+x3Jttb/6vDS6Zwd6B6w==
X-Received: by 2002:a05:600c:414f:: with SMTP id
 h15mr215761wmm.130.1582702785249; 
 Tue, 25 Feb 2020 23:39:45 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w1sm1782448wmc.11.2020.02.25.23.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 23:39:38 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 254741FF9A;
 Wed, 26 Feb 2020 07:39:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 10/19] docs/devel: document query handle lifetimes
Date: Wed, 26 Feb 2020 07:39:20 +0000
Message-Id: <20200226073929.28237-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226073929.28237-1-alex.bennee@linaro.org>
References: <20200226073929.28237-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

I forgot to document the lifetime of handles in the developer
documentation. Do so now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
Message-Id: <20200225124710.14152-11-alex.bennee@linaro.org>

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index 718eef00f22..a05990906cc 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -51,8 +51,17 @@ about how QEMU's translation works to the plugins. While there are
 conceptions such as translation time and translation blocks the
 details are opaque to plugins. The plugin is able to query select
 details of instructions and system configuration only through the
-exported *qemu_plugin* functions. The types used to describe
-instructions and events are opaque to the plugins themselves.
+exported *qemu_plugin* functions.
+
+Query Handle Lifetime
+---------------------
+
+Each callback provides an opaque anonymous information handle which
+can usually be further queried to find out information about a
+translation, instruction or operation. The handles themselves are only
+valid during the lifetime of the callback so it is important that any
+information that is needed is extracted during the callback and saved
+by the plugin.
 
 Usage
 =====
-- 
2.20.1


