Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED030CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED0321D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gmr3uEsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED0321D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO5fd-0005J7-9N
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 15:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Og-0008CG-VJ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Of-00037s-QB
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:18 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:40931)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO5Of-000379-KK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:17 -0400
Received: by mail-wr1-x42d.google.com with SMTP id o28so3617075wro.7
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 12:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kn+bIv7NEtU84TBVO2Hwfc6C0EcPLqpDAq6Bnw3x5TY=;
 b=Gmr3uEsnV0Baz7fw65+QppaUpw8PEFHyJt+Dt4nK1RPKg3okO2AQbfmEX0zn9XTCNv
 SxPCXBtWcqKFglfIVcX65BfI2RtI05HvKhGDGAegy4xRjDR7iYQ4/IYfidhXXch4QGPk
 J7Iv/sTJo+G9YKbnFfTvP2c9YXJwYEBGd9o3FiexIJ950+lhoC0sP51FCEw/4GSWc2JW
 +jK6j5wi4XE/yNMPMGatlssnLCEQGY0kfxcdtrn18p4qXBU9CyUGmSXMa2NPTXo27RT5
 1CPH6Q/zpnapu1ETqixu5ozxMTwDbzakSwyw1KbnMm3M5azCJ8RtLt4HPeh8BgNFMwa7
 43gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kn+bIv7NEtU84TBVO2Hwfc6C0EcPLqpDAq6Bnw3x5TY=;
 b=cxf3n/pVVcG2ZaXBmFr1I+kt0rSeRFJ2ympe6/AS0jeW5kVXF0xo7xs/uf8wDHALnk
 LsD1ADxIK4NNZ+o/1+GBxH7OIZLkGC1zPuckXQfpYTXLou1e41pnq6mjP8GxBREkOwjp
 CFQMxBIKAle9bbMXxqHhhQ5mhvzZiH7fY3rTycl1u+2KS2qhXffpPlDf9jVDGeAM5RPx
 cMWNI7oVIIrXBh9UExZgHpV2bXvEeZnvf5g16/crFWLeC4HvyKoOqhQt0ax4vKovFh9b
 wkoX6/3LewKEuEljgO+P/CHC0vG8wDwWd48GmpxN1scVyAlUd9wrT/pu+sYjS2jRfiI5
 LDPQ==
X-Gm-Message-State: APjAAAWTWHyzOwDRMPFm9zhbG+bR+FpkpxwxvMmjK4sohensVWGkXadI
 MUj42e1ktnUbsCjL2K6Hweg3Uw==
X-Google-Smtp-Source: APXvYqwUR9iXXOywO9OeQyJRGyu0+iYLIoLB3cemnt+cTKyvt1pGTgBs28GymGkoE78dAhNyhiZpXQ==
X-Received: by 2002:a05:6000:12cd:: with SMTP id
 l13mr4453458wrx.181.1572032236489; 
 Fri, 25 Oct 2019 12:37:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 79sm4128264wmb.7.2019.10.25.12.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 12:37:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 296F31FF98;
 Fri, 25 Oct 2019 20:37:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v3 08/15] cirrus.yml: add latest Xcode build target
Date: Fri, 25 Oct 2019 20:37:02 +0100
Message-Id: <20191025193709.28783-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025193709.28783-1-alex.bennee@linaro.org>
References: <20191025193709.28783-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CirrusCI provides a mojave-xcode alias for the latest Xcode available.
Let's use it to make sure we track the latest releases.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.cirrus.yml b/.cirrus.yml
index 8326a3a4b16..27efc48619b 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -25,3 +25,14 @@ macos_task:
     - ./configure --python=/usr/local/bin/python3 || { cat config.log; exit 1; }
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
+    - ./configure --cc=clang || { cat config.log; exit 1; }
+    - gmake -j$(sysctl -n hw.ncpu)
+    - gmake check -j$(sysctl -n hw.ncpu)
-- 
2.20.1


