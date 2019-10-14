Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1BEC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0F620854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+Nd8Ids"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0F620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJxxe-0000jZ-AR
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 06:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvI-0007JK-1V
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvG-0005xY-EU
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:55 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:39513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvG-0005w6-37
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:54 -0400
Received: by mail-wr1-x432.google.com with SMTP id r3so19147619wrj.6
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UcgZ75XfpbxdYj2yixtrchwplPEwAU4Z4rGYEtqlY+4=;
 b=i+Nd8IdscLjxymcwkshtSmFKmSaCGVo3fxpTzgcHRj3XAEygeEY5Be+yOEZt/ojjCj
 +QuKy1oqjw2Ye9FyDjLRo0fRujypeGiS0DFhurE+trzpeLz5tg6jSKoGXFajeNWKJaau
 IpOkkufVesz29fPVIaAk4yTJSHSvR+doBfT2XpazeyQ8hbHqVpNJzklDfcGPbbHAIrMW
 7MsBfS7B1OX2m3U+ZIAqlbRE3rAd8ALY+iieaD52pb51InP6LCrmz7b+0FTu3Y3hDdAD
 NfisLZaXY8WWqreZave2D/+rdfBQOxM2TxxtBz73xfyyCbmPNaZDVpmfWAW4Fe04zbjU
 8Ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UcgZ75XfpbxdYj2yixtrchwplPEwAU4Z4rGYEtqlY+4=;
 b=uNuLx9gNngWVxK6AknQ67sxJvARcO1Q74eO2TTRzRP7HGrH7DSa1evAJVFaYHbOj8G
 8a+sZxfq1/R4g3UVGiCnExtO5TdZQy9UnEwtzTQ4ecmpOZkYXmCd8ygYD0dXFg+U09sa
 PIsz1ggfXBqA7AZQ64Z5qSrME6kTJAlD4imU0eWKwO3fZwAuUTTbxzIm+px+PEQyflY0
 njSLyWXFRBWcE3lnUFN6RFSpyDbAJ+TXCKSOdAXRgrbE26qO9CQqCcqY+/yXBeCByKvo
 Xn+b1wqmz959b2LUzagbtoVZz9yyKs/HJ2TaeY/ad65/1wTRFFiFNboIWQ/yLIuFjKHZ
 M1og==
X-Gm-Message-State: APjAAAX2r7y6PqQ9rURdDslYDO1maddV1dOQkHke548zd2pua1LT5by+
 VtT957apsZd9eiLWqUTIa6cvbg==
X-Google-Smtp-Source: APXvYqzZ1Ug+GAxlk5baA6E06VWSqN3esgeSd01WbNPdzIknyOw10+w3xV8iWp2UCSu+gRYcAQ9zpw==
X-Received: by 2002:adf:ed43:: with SMTP id u3mr25121113wro.236.1571050193003; 
 Mon, 14 Oct 2019 03:49:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a18sm24852464wrs.27.2019.10.14.03.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:49:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4B5F41FF93;
 Mon, 14 Oct 2019 11:49:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 06/55] configure: add --enable-plugins (MOVE TO END)
Date: Mon, 14 Oct 2019 11:48:59 +0100
Message-Id: <20191014104948.4291-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configure b/configure
index 08ca4bcb46..485a9837c9 100755
--- a/configure
+++ b/configure
@@ -497,6 +497,7 @@ libxml2=""
 debug_mutex="no"
 libpmem=""
 default_devices="yes"
+plugins="no"
 
 supported_cpu="no"
 supported_os="no"
@@ -1524,6 +1525,10 @@ for opt do
   ;;
   --disable-xkbcommon) xkbcommon=no
   ;;
+  --enable-plugins) plugins="yes"
+  ;;
+  --disable-plugins) plugins="no"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1705,6 +1710,8 @@ Advanced options (experts only):
   --enable-profiler        profiler support
   --enable-debug-stack-usage
                            track the maximum stack usage of stacks created by qemu_alloc_stack
+  --enable-plugins
+                           enable plugins via shared library loading
 
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -6429,6 +6436,7 @@ echo "capstone          $capstone"
 echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
+echo "plugin support    $plugins"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -7256,6 +7264,11 @@ if test "$sheepdog" = "yes" ; then
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


