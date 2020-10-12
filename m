Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CACC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A6F20870
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A6F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8jr-00005H-Tq
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 21:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kS7Gd-0001md-Bh
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 19:30:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kS7GC-00060x-Kf
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 19:30:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id h6so15997551pgk.4
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 16:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eIy9eojQ+A3Gbcofa/FLlYhzE10ebVrgvbdbxHUT22Q=;
 b=X5hX1vOf33Z27/I9kuGjY21+o2M8188oRd5DWE/gwdL5e/JEZFNBfX8A4gRLf2I8ai
 6Ji941rbZbL2YKJ4We9QjKXjO7n6qNckUAO2jkqKExmaDVcJ/pn7rJM/mscM4v07JDd0
 pTf+JTsyJELwL0ztdxKPWnUTGDwGC39T8yVYb9c8x7CA5iSUpjc6LprNY4JCahQhp7fr
 MZQ7LGNDcSL5Q/4pNNaAP8L44HCJYl6NEmYceSAn2WZ/A5RHKihrY6h1VjvWkWcQgde0
 2k27LMyWm0J54fiNpXaSTzVssviXNj3vitcmXXOF6cIWBVkUfTKyQ2UYVamuzWaaGDP7
 K7Tw==
X-Gm-Message-State: AOAM530BfyXQsvVf1TgTgbpMbNwtlDBrofy6sldqT1hWsj8gIn/c6Pdj
 3nGQQwYGsND4Gkq3v8JXwilCz9xFfJg=
X-Google-Smtp-Source: ABdhPJwxtrbn7XnIFTlIVFzSGROUJA5QKE2FIv30edAU/w28J6yiaEZ9emmdF6b4ZgE9g9woUkJl/Q==
X-Received: by 2002:a17:90a:c68d:: with SMTP id
 n13mr22236747pjt.94.1602545383213; 
 Mon, 12 Oct 2020 16:29:43 -0700 (PDT)
Received: from localhost.localdomain ([73.93.152.174])
 by smtp.gmail.com with ESMTPSA id f21sm8088315pfk.169.2020.10.12.16.29.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Oct 2020 16:29:42 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/10] configure: cross-compiling without cross_prefix
Date: Mon, 12 Oct 2020 16:29:31 -0700
Message-Id: <20201012232939.48481-3-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012232939.48481-1-j@getutm.app>
References: <20201012232939.48481-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.196; envelope-from=osy86dev@gmail.com;
 helo=mail-pg1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 19:29:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 Oct 2020 20:56:29 -0400
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
Cc: Joelle van Dyne <j@getutm.app>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: osy <osy86@users.noreply.github.com>

The iOS toolchain does not use the host prefix naming convention. We add a
new option `--enable-cross-compile` that forces cross-compile even without
a cross_prefix.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 configure | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 3c63879750..46d5db63e8 100755
--- a/configure
+++ b/configure
@@ -234,6 +234,7 @@ cpu=""
 iasl="iasl"
 interp_prefix="/usr/gnemul/qemu-%M"
 static="no"
+cross_compile="no"
 cross_prefix=""
 audio_drv_list=""
 block_drv_rw_whitelist=""
@@ -456,6 +457,11 @@ for opt do
   optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
   case "$opt" in
   --cross-prefix=*) cross_prefix="$optarg"
+                    cross_compile="yes"
+  ;;
+  --enable-cross-compile) cross_compile="yes"
+  ;;
+  --disable-cross-compile) cross_compile="no"
   ;;
   --cc=*) CC="$optarg"
   ;;
@@ -878,6 +884,10 @@ for opt do
   ;;
   --cross-prefix=*)
   ;;
+  --enable-cross-compile)
+  ;;
+  --disable-cross-compile)
+  ;;
   --cc=*)
   ;;
   --host-cc=*) host_cc="$optarg"
@@ -1687,6 +1697,7 @@ Advanced options (experts only):
   --efi-aarch64=PATH       PATH of efi file to use for aarch64 VMs.
   --with-suffix=SUFFIX     suffix for QEMU data inside datadir/libdir/sysconfdir/docdir [$qemu_suffix]
   --with-pkgversion=VERS   use specified string as sub-version of the package
+  --enable-cross-compile   enable cross compiling (set automatically if $cross_prefix is set)
   --enable-debug           enable common debug build options
   --enable-sanitizers      enable default sanitizers
   --enable-tsan            enable thread sanitizer
@@ -7164,7 +7175,7 @@ if has $sdl2_config; then
 fi
 echo "strip = [$(meson_quote $strip)]" >> $cross
 echo "windres = [$(meson_quote $windres)]" >> $cross
-if test -n "$cross_prefix"; then
+if test "$cross_compile" = "yes"; then
     cross_arg="--cross-file config-meson.cross"
     echo "[host_machine]" >> $cross
     if test "$mingw32" = "yes" ; then
-- 
2.24.3 (Apple Git-128)


