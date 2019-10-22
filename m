Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81358CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 442F92184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cqXXCneC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442F92184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMzov-0006a1-VB
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 15:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzef-0002Qe-K1
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzee-0005LM-9h
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMzee-0005Ic-1t
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:16 -0400
Received: by mail-wr1-x444.google.com with SMTP id l10so18906543wrb.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 12:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fIE39M6WEo2MphCpMZQ+O6lu2X6W83TgfKFvtWGX81M=;
 b=cqXXCneChwyWhXlxhUI8C2VEEOG1YqIwBNmaXA1tcYRrHgpeOol9i0RpBBCk1TMr0N
 0VOAYlATli0SDqBQ8HdH3Oka0PaX8zCAXMJpfyOJW8izsDH/bC6GTweK034N7TZmKvV6
 vsMVzw0VJHcCDy0eHEhq1zDgexVpnhBzhf2+M3GTvdyNdwDNAVynJ1XDYlf8UCZq3XqG
 kyfx87Nh3chKNeRn09B6PNUSZtuhiT7+e68eNSLznUgfXidZf/DOCGOGGqVPKaJE7xLY
 a7C6sMjHawJ6vzwb0xOyz7aS4u3IzYxPlxUt5gCSLpJZir9Zb0C1VS/sbGdilJZf8w3l
 wHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fIE39M6WEo2MphCpMZQ+O6lu2X6W83TgfKFvtWGX81M=;
 b=f4fmkH93Bdi4i1/7gG/tEYxPscMaQrMvG9mlBlUctErqb1c2q+16mh98kK4YKdMPVJ
 xZnfZ42R2kJTfaThS41+T69qqrnrlQl8Qqwv2Z1Rya3qTZ46HnTcRKLal5SyJ8aoy/59
 HoWo2pxPtX2n12bCsqpOosxjsVFUlnP9tCPnSpvJkSW7yz1TKpjFDhiUO8aAhUfTPvMq
 /ZjEK5kX17sCiEmL2MXTMQ6hG/gftz45K6cZghSOJ9NVnGuhmeu6GrRtpWyVQz2kw6u3
 NY25z5/RM9zp8xi6MsmSnxWd1yJZewr0zA5wO//8ZSAFQU2F4WKjUk69PnOeLaMsR8xD
 PlwQ==
X-Gm-Message-State: APjAAAWulofCFWKbyK9Tmp5/smXmovd8hN3xRCk/GE0Gukn/SL7x+DFM
 r7dl6yKCtCubAKEsSPdX5BxhKQ==
X-Google-Smtp-Source: APXvYqxQTR/rXZUYxMM8zI9wy8RH7IJnEBbxQJ47Q8wHhXRUr6HsLojQZi4JeuYAftACiz6m5F1bJA==
X-Received: by 2002:a5d:5227:: with SMTP id i7mr4756741wra.39.1571771834059;
 Tue, 22 Oct 2019 12:17:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o4sm30892303wre.91.2019.10.22.12.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 12:17:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0B3F71FF99;
 Tue, 22 Oct 2019 20:17:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 09/19] cirrus.yml: add latest Xcode build target
Date: Tue, 22 Oct 2019 20:16:54 +0100
Message-Id: <20191022191704.6134-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022191704.6134-1-alex.bennee@linaro.org>
References: <20191022191704.6134-1-alex.bennee@linaro.org>
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
 richard.henderson@linaro.org, f4bug@amsat.org, Ed Maste <emaste@freebsd.org>,
 cota@braap.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, Li-Wen Hsu <lwhsu@freebsd.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CirrusCI provides a mojave-xcode alias for the latest Xcode available.
Let's use it to make sure we track the latest releases.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .cirrus.yml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/.cirrus.yml b/.cirrus.yml
index 4b042c0e12c..59146a89c83 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -26,3 +26,14 @@ macos_task:
     - ./configure --python=/usr/local/bin/python3 --target-list=${MACOS_ARCHES} || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake check -j$(sysctl -n hw.ncpu)
+
+macos_xcode_task:
+  osx_instance:
+    # this is an alias for the latest Xcode
+    image: mojave-xcode
+  install_script:
+    - brew install pkg-config gnu-sed glib pixman make sdl2
+  script:
+    - ./configure --cc=clang --target-list=${MACOS_ARCHES} || { cat config.log; exit 1; }
+    - gmake -j$(sysctl -n hw.ncpu)
+    - gmake check -j$(sysctl -n hw.ncpu)
-- 
2.20.1


