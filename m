Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CEAC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 23:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23FB21D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 23:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZNPbvppH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23FB21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDGn2-0006tQ-P5
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 19:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDGku-0005Xr-0M
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 19:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDGkr-0002yC-3s
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 19:31:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDGkq-0002rY-Kx
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 19:31:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id n14so243520wrw.9
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 16:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jSCFOhECRftmmvA+lheNZeXhhJgeT4gP4yCV2T0qHzQ=;
 b=ZNPbvppH91Y+CfZxkum0TG+w1r5IKnBH+RVVhl1vo/EwaQ8UEubuIZBmEVXfEhMXwp
 Lp6gEOUjWwUWNFrD9Jn47LZ3MP3Ug1fswk0pgS8UoScsIGuCcUwjL0POpkzxc/XE5uL5
 D2xmv8ipN8lyKe/gv+mlCDKcmrsApUuiaz2WgUH8t6hBdTRnrW6XpoyErLLRl3zp3ZbN
 mg6+gJNSPOsuh9Xfv601Bmoduv6UHYNbKS5p2PvKGba8AIybHhClwblg214fXQyODn0T
 DA4jEcu5Uq7LZK1NHo51s5SXyQlB7Zg/LYRV8SP8h39siQ3bKF8m4SGnL84vS7Vf13H9
 KQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jSCFOhECRftmmvA+lheNZeXhhJgeT4gP4yCV2T0qHzQ=;
 b=ep8edSeQvXzxD/NPObnLF61V041zzxG20uMuRz+KL+lUdiQkiwVVCftmgsdFAmh1UX
 z6WvGB8RXMKokNCf9omqUEJRzdloOm49NHRdjtZexIu4puVXtRSvVEqmtkrKtI3NU9fu
 /tv+CbL8noE9dUWIyfxJrRhlkgC+g9nzvzrOzdvQDoJ5LJUlt+ivGQK2Q7rN9rSavMIz
 eUOWSezbY7ZZu50kBIy84J8g7RkJxwrMPA8okvJ95zJ5BQBPQPAlDV6pzkQk8zRfDvPy
 glSkgkwDwe2rhRZZWxF39jW55RSlM5bE6RoIZoKWohGPgXBNQ0MKJVggsWQp3N9pnfm5
 Ze+Q==
X-Gm-Message-State: APjAAAURphkyU38OgeD0ege8+oE0lWGtHNYxfoVvwDFT+pRDG5qiw6GC
 gmHntOer0zjYot/35w/B/Ty8jg==
X-Google-Smtp-Source: APXvYqxnBt1VFE+UIodNnJhN6MZLorcAkOoP9wvzAiN7iSdwTxye8EoiTX/N2btEZNoEpGACr3tQLA==
X-Received: by 2002:adf:e6c4:: with SMTP id y4mr515758wrm.238.1569454223405;
 Wed, 25 Sep 2019 16:30:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v8sm399828wra.79.2019.09.25.16.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 16:30:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 12F441FF87;
 Thu, 26 Sep 2019 00:30:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] configure: deprecate 32 bit build hosts
Date: Thu, 26 Sep 2019 00:30:13 +0100
Message-Id: <20190925233013.6449-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
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
Cc: qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-discuss@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 32 bit hosts are already a second class citizen especially with
support for running 64 bit guests under TCG. We are also limited by
testing as actual working 32 bit machines are getting quite rare in
developers personal menageries. For TCG supporting newer types like
Int128 is a lot harder with 32 bit calling conventions compared to
their larger bit sized cousins. Fundamentally address space is the
most useful thing for the translator to have even for a 32 bit guest a
32 bit host is quite constrained.

As far as I'm aware 32 bit KVM users are even less numerous. Even
ILP32 doesn't make much sense given the address space QEMU needs to
manage.

Lets mark these machines as deprecated so we can have the wailing and
gnashing of teeth now and look to actually dropping the support in a
couple of cycles.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index 542f6aea3f..776fd460b5 100755
--- a/configure
+++ b/configure
@@ -728,7 +728,7 @@ ARCH=
 # Normalise host CPU name and set ARCH.
 # Note that this case should only have supported host CPUs, not guests.
 case "$cpu" in
-  ppc|ppc64|s390|s390x|sparc64|x32|riscv32|riscv64)
+  ppc64|s390|s390x|sparc64|riscv64)
     supported_cpu="yes"
   ;;
   ppc64le)
@@ -737,7 +737,6 @@ case "$cpu" in
   ;;
   i386|i486|i586|i686|i86pc|BePC)
     cpu="i386"
-    supported_cpu="yes"
   ;;
   x86_64|amd64)
     cpu="x86_64"
@@ -745,19 +744,22 @@ case "$cpu" in
   ;;
   armv*b|armv*l|arm)
     cpu="arm"
-    supported_cpu="yes"
   ;;
   aarch64)
     cpu="aarch64"
     supported_cpu="yes"
   ;;
-  mips*)
+  mips64*)
     cpu="mips"
     supported_cpu="yes"
   ;;
+  mips*)
+    cpu="mips"
+  ;;
   sparc|sun4[cdmuv])
     cpu="sparc"
-    supported_cpu="yes"
+  ;;
+  x32|riscv32)
   ;;
   *)
     # This will result in either an error or falling back to TCI later
@@ -6438,12 +6440,12 @@ if test "$supported_cpu" = "no"; then
     echo "WARNING: SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RELEASES!"
     echo
     echo "CPU host architecture $cpu support is not currently maintained."
-    echo "The QEMU project intends to remove support for this host CPU in"
-    echo "a future release if nobody volunteers to maintain it and to"
-    echo "provide a build host for our continuous integration setup."
-    echo "configure has succeeded and you can continue to build, but"
-    echo "if you care about QEMU on this platform you should contact"
-    echo "us upstream at qemu-devel@nongnu.org."
+    echo "The QEMU project intends to remove support for all 32 bit host"
+    echo "CPUs in a future release. 64 bit hosts will need a volunteer"
+    echo "to maintain it and to provide a build host for our continuous"
+    echo "integration setup. configure has succeeded and you can continue"
+    echo "to build, but if you care about QEMU on this platform you"
+    echo "should contact us upstream at qemu-devel@nongnu.org."
 fi
 
 if test "$supported_os" = "no"; then
-- 
2.20.1


