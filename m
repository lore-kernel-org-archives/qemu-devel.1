Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF77C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3632064A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMi08feM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3632064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aT8-0005zK-SO
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcY-0005bS-C0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcW-0007H6-67
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:29 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6ZcV-0007GX-1U
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:27 -0500
Received: by mail-wm1-x343.google.com with SMTP id t79so1366696wmt.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4d2JrUPmJz37MvIYKDE4vOLfs/ja0Fe0BZeISYiAcVI=;
 b=eMi08feMDeth2FqrHF+Dl21qn7NuBH3xvfxYDGp11sliJn4P91PYlp5bZhvTfWv/yy
 Z9Qog5qlf9Ewqmdl/JxGBhBGqEwnh2SwCWwQK586MMSDhnVzS8jhAlqgrrUbxfa84JBJ
 8zSknaIh6BluoanrXGckIewg3KTDasBmdhaob8jYDnQeObylmuHkQEB4P3DzdzeZCE7S
 uTUAiXoVluYzGZYo8xEG6Avylyj04lsMy6DtdNdsIRlIuxURs3eSANIMgTox1Iv/XY1Y
 CheiRAkaMAsbH6BnHMoY0af4lyMEvOgSZIzH7Q96OXGJJuJTWi1DusZm1ul9KNkxmwQV
 E88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4d2JrUPmJz37MvIYKDE4vOLfs/ja0Fe0BZeISYiAcVI=;
 b=gZlgeopA93lIbbS91StA6yWLv/fr+sKB2ExbIvmizsfJpO2fv+CMSe8DEajoQ0Borl
 VKgzQE/K4lagyBNtKJYly3TSqzKJXd9Oh2ZNyV5UNAMku8toWluo9i/JEWNrIHHPor2r
 FYnjOpjO9L6HKJI23TsssbfzCBPsVzVn49tumi/0AQTGuuUi4Ld/RD7Z37sM/ZnIZhuC
 SGpV4aZfcS/kf0L1HIG2yAF8jj1N3sfPMTHhUVmiadnhY8P98NHjb8SzMXjn3Q5EzF/d
 sYOirWzxMH5kJb8UoNTiJvX411kkUykaHciJQPwOsnh7tpV5PFT2Hma5sYzd9JTqp0wb
 TIjw==
X-Gm-Message-State: APjAAAX3tuddXaeXfdd9lG+iWtZ86K8E8nfzKLFnzHVviRdQ95cEwg7h
 RC70W5vyPt9z8cYjnYIcAs7/hg==
X-Google-Smtp-Source: APXvYqwgQ3EnUxEyvQZ7AAHSU8d4YpzqQSSShaVIKpEj7chIY2dC4Y0VNuf4iY2MR2uvf+LzDMILoQ==
X-Received: by 2002:a7b:ce18:: with SMTP id m24mr5214555wmc.123.1582634845862; 
 Tue, 25 Feb 2020 04:47:25 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s1sm23459047wro.66.2020.02.25.04.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:47:20 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2BB131FF9A;
 Tue, 25 Feb 2020 12:47:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 10/19] docs/devel: document query handle lifetimes
Date: Tue, 25 Feb 2020 12:47:01 +0000
Message-Id: <20200225124710.14152-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225124710.14152-1-alex.bennee@linaro.org>
References: <20200225124710.14152-1-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I forgot to document the lifetime of handles in the developer
documentation. Do so now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
---
 docs/devel/tcg-plugins.rst | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

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


