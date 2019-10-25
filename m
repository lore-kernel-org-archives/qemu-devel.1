Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5188CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A224D20867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F8cuiAAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A224D20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtOo-0001nv-01
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDw-00037t-Mz
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDv-0008Oj-LK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:24 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:34127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtDv-0008OO-EU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:23 -0400
Received: by mail-wr1-x42a.google.com with SMTP id t16so935524wrr.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kn+bIv7NEtU84TBVO2Hwfc6C0EcPLqpDAq6Bnw3x5TY=;
 b=F8cuiAAKLYadLgs+9qvTXeOTNyVqqKnarEldfKF09/+wzGF/4Mb4dKJhwP4xIfGjky
 jH9ZVXR2iOT7eupmV4SmpQVx3lzV376Sv7eF5/vulgMHR3O8kIQqam1uRZ7I67SHcBOz
 8mYEReEn5UtdJ7NPcw09shfxacvhYYXLq0HPo7sMZSbYahc9DeHNx8JpYA61fSBoxj22
 XDpVr7Q4VDco41m63NfM+Xj5ewYxssqg/4b2aIqOsogvwSB/x6rDzkcGYBWE4f8a8HWS
 En8+a5rw7kEy86yUEi3P7vIiQmt09tm7/HdVFuLmJKC4qSMuubnlS+oLqI9UR/Abm+JL
 zk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kn+bIv7NEtU84TBVO2Hwfc6C0EcPLqpDAq6Bnw3x5TY=;
 b=cuWr0Hv09C3HLRWvC9g2KCW4h+WEAKNn6F5EOj6RskUsF2YqXrSgfS0hvA1wJvNvof
 WWxN54eWd0Sus6YIV+CHlWPmw5r+chZL7I11l2miqDB3xlZKUXD0mNMOmKNZp3TVutcA
 AkExyLt2GFyeumsqbuxKdU2tteE/bRD13Kz1N5+t8AAxEGDoQ8koDcUTKG+nYxNo8ghc
 9SrG4toAfNY7llPbwWKAx/Vsv9OjgilUr5sUgib+NBRyHxl065B5LFAKZEJVQVvgTZ3V
 tnyWvGvDJ7P+cjFAOyyTCRItkM2pazsx0qmw/mmf4amEWPCa9s7Y3XE2fM+vzMShdlA0
 cMpw==
X-Gm-Message-State: APjAAAV+5KxBFuM8kZFQbUzPjP5KuHdXojzdcwpYRh4yndNGbIradc7Z
 bIzJuIk+3tlVPdF8pG7A9CKilQ==
X-Google-Smtp-Source: APXvYqzV1QIf5fMZ1AqAVpBdRf6EJ9QAxoCHAonRR+6gzKgKwhkGnU45i+buBmzl3CCJOE+UMAdq6A==
X-Received: by 2002:a5d:638f:: with SMTP id p15mr1346951wru.150.1571985442269; 
 Thu, 24 Oct 2019 23:37:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o4sm1324890wre.91.2019.10.24.23.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:18 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6E0BB1FF98;
 Fri, 25 Oct 2019 07:37:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 08/73] cirrus.yml: add latest Xcode build target
Date: Fri, 25 Oct 2019 07:36:08 +0100
Message-Id: <20191025063713.23374-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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


