Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B491C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2952183E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pTYPNeW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2952183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53898 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqNq-0006a3-QZ
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55939)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkG-0000UQ-2Z
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkE-0002yH-UZ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40669)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpkE-0002wt-N4
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:06 -0400
Received: by mail-wm1-x341.google.com with SMTP id v19so3033807wmj.5
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8bC4Ua5+cmFCH7/z3JbOgJMbpPZnAdyKgQfwrXL9vnQ=;
 b=pTYPNeW88qhJChbZ2vWTHN6ODLLY+6x20uMSvv3RPXIUEJwMDOhLricPeOkm36L80T
 SGsemwdu8BZLJfvO6wnsKh8XnIeXDI+RK7h1Pk3PxseZFxJyepRr6TQ6aUeG03p7GK85
 051t8jdB2JzvdzRwsI67vl54dZMfOItxXHhRolXXDx1yvNfswIL/PbahTTa/jYGoEn1I
 7WvkU7hmELWdhX5RiGZBAoWLZAXZ8MQZNn2SkMXiPA6xrfvKkhovYBfUpyHJxWd6bDuR
 tZccAljadTN/U27FTYH01roEPQHeNA+B3BAas7us6mgFQzX+Wpr4zsuuqnltkYkyQdAN
 SF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8bC4Ua5+cmFCH7/z3JbOgJMbpPZnAdyKgQfwrXL9vnQ=;
 b=s2T6kK7RVCRALoByEAnPRk76QQuVH0nVOlq8IJOXpVMHOqbDq6uOC8f2QBzQ31ZSDn
 5298/Na6EuDBxQ2rKgGtX0eIzFEubOWf1a3Pxli55Dpo/Dr3Kzwge721K7yLKQabj9y0
 lMCcTr9b3tcFRyqQosRivNVPZh5Mze6A0dBkaVrN8SKy04mJk+qcXrzAVnd6JoThouDO
 O3YG6AodQjClADO3B50Iu8b+FD+8gIosMyNtyOBmxeRrdors0MFEyY7nYPAiq/PQoXfk
 YPWVcd7tGmNdE8t6djF8k5k8j4htyWAyFEBIjC9LXet6mGKc5wwjTuDtPgvOBVdX/Kml
 okdQ==
X-Gm-Message-State: APjAAAUmXDfckktkwrbNmMDpvVois3Kzj1dp0yk7noAAmOmTDQnjHZxk
 3adKv5hTP6NxE3D6M1Y5MkH7JOnQeuk=
X-Google-Smtp-Source: APXvYqxdaEDeW3Y8t0gEuaqlC2MeHYNd7b/kjp6EC2UQmCyiSQYj/MN5olV0B9/GDPxJz2yGuLPxCg==
X-Received: by 2002:a1c:be12:: with SMTP id o18mr8616695wmf.21.1560532325117; 
 Fri, 14 Jun 2019 10:12:05 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o13sm5231579wra.92.2019.06.14.10.12.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:12:02 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E989E1FF93;
 Fri, 14 Jun 2019 18:12:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:16 +0100
Message-Id: <20190614171200.21078-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v3 06/50] configure: add --enable-plugins (MOVE
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
index b091b82cb3..48f3263e55 100755
--- a/configure
+++ b/configure
@@ -493,6 +493,7 @@ docker="no"
 debug_mutex="no"
 libpmem=""
 default_devices="yes"
+plugins="no"
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
 cross_cc_aarch64="aarch64-linux-gnu-gcc"
@@ -1537,6 +1538,10 @@ for opt do
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
@@ -1734,6 +1739,8 @@ Advanced options (experts only):
   --enable-profiler        profiler support
   --enable-debug-stack-usage
                            track the maximum stack usage of stacks created by qemu_alloc_stack
+  --enable-plugins
+                           enable plugins via shared library loading
 
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -6479,6 +6486,7 @@ echo "docker            $docker"
 echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
+echo "plugin support    $plugins"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -7296,6 +7304,11 @@ if test "$sheepdog" = "yes" ; then
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


