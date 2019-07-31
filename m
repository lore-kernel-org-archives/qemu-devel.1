Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF6BC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B27320C01
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYnOYtoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B27320C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrBP-0005eF-Pm
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40460)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8o-0002BZ-BL
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8k-0000oS-Pj
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:48 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33422)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsr8h-0000fL-FA
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:44 -0400
Received: by mail-wm1-x342.google.com with SMTP id h19so1627101wme.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7+yS4VWJqkSD6ydwUwgfwcLX4YEx0h4kZ8SydG4heHg=;
 b=FYnOYtoPUiiUca7fOl27hYNxq8Wo46wK804tILavsG/nyRwG9yH14HkIRo7o0nAjP8
 OFpIzOGZbDxLYoU9Em88BasJBHKQ+U17ImSewknxFCoSVpCf2470jnlC+gji93/NEHvb
 +oUZpHb5oLh+/VL16dcfs7ClOMz6VGaPc/ji9mDnShYwWrQniLKB9fxXKHJA80FMebxJ
 yEpImr9PGJezIgrp1q7HYIstxFddlqouHVWMEZOLkER3vbYLraIWzdQG4+K5RsV4CI0a
 08zEdLpjR4KHElNQvaHdLeBRAflVffgomF3onPleDBIPWHrSi27R4nuE6OcgUo1aS4oE
 +1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7+yS4VWJqkSD6ydwUwgfwcLX4YEx0h4kZ8SydG4heHg=;
 b=QpLStrB7osWIaa5oQzl7nXQul3EzvkzMV9nEZ5Qvj+OOk6+DtZ1LVR8//lyeyY7ogy
 qd1P08bFhbRphaQ+YaffuOq5xBq2pSS3WT6YZtDUbGp3ekXWchxN+6Ka3BWGdnxiH75J
 OAOjjjFwFCNHNZqV1F7SpeIDbnnGWC+rW3Nw/Btdww68liGWYaxGUJiHNHSpEPMoEC7/
 vrGuVqwO7ADossJMVqql/iOGv9RfLQJhCgqdu+yegn/HC/ucTmlvniOxdqHdEEfpyGyY
 OA3LSmuZFu/WZS0Kck2gSVEJeRRLSrr7bwZLK4C/qLkyquzkbB+vN1jMyrLsGKFunMMR
 yc3g==
X-Gm-Message-State: APjAAAV5LUdEZb4PwbbVEbvlttTFq66Ol+CnYycRX/ghmbVO771mRHQq
 IJRBp7YTB9L3RpJx7eVGOYojX41+bT4=
X-Google-Smtp-Source: APXvYqxdiYpHDGarcyUXg34qKcgsR48EbuNQv5IHt54VDfvrBrPboDt7Um3kTxUNCeGQaqrLW7ZDMg==
X-Received: by 2002:a1c:a019:: with SMTP id j25mr111967752wme.95.1564589248400; 
 Wed, 31 Jul 2019 09:07:28 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a81sm72210857wmh.3.2019.07.31.09.07.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:07:23 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8490F1FF9B;
 Wed, 31 Jul 2019 17:07:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:37 +0100
Message-Id: <20190731160719.11396-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v4 12/54] configure: add --enable-plugins (MOVE
 TO END)
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
Cc: bobby.prani@gmail.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds the basic boilerplate feature enable option for the build.
We shall expand it later.

XXX: currently this patch is included at the start of development to
aid with incremental building. It should be moved to the end once the
plugins are feature complete.

[AJB: split from larger patch]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configure b/configure
index 714e7fb6a1f..dbc78f21b0c 100755
--- a/configure
+++ b/configure
@@ -499,6 +499,7 @@ docker="no"
 debug_mutex="no"
 libpmem=""
 default_devices="yes"
+plugins="no"
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
 cross_cc_aarch64="aarch64-linux-gnu-gcc"
@@ -1543,6 +1544,10 @@ for opt do
   ;;
   --disable-libpmem) libpmem=no
   ;;
+  --enable-plugins) plugins="yes"
+  ;;
+  --disable-plugins) plugins="no"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1740,6 +1745,8 @@ Advanced options (experts only):
   --enable-profiler        profiler support
   --enable-debug-stack-usage
                            track the maximum stack usage of stacks created by qemu_alloc_stack
+  --enable-plugins
+                           enable plugins via shared library loading
 
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -6481,6 +6488,7 @@ echo "docker            $docker"
 echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
+echo "plugin support    $plugins"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -7307,6 +7315,11 @@ if test "$sheepdog" = "yes" ; then
   echo "CONFIG_SHEEPDOG=y" >> $config_host_mak
 fi
 
+if test "$plugins" = "yes" ; then
+    echo "CONFIG_PLUGIN=y" >> $config_host_mak
+    LIBS="-ldl $LIBS"
+fi
+
 if test "$tcg_interpreter" = "yes"; then
   QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
-- 
2.20.1


