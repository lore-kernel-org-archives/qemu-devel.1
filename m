Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2756FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 01:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D9A222C3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 01:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D9A222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUKEv-0005pp-Pp
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 21:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kUK99-0000PZ-IL
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 21:39:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kUK97-0008Li-W7
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 21:39:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id x13so5042596pfa.9
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2020 18:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eIy9eojQ+A3Gbcofa/FLlYhzE10ebVrgvbdbxHUT22Q=;
 b=dZpFqb3BvoSVpfK3AQF2nuyxjfM+I+EKHEmNyITJEPiAx/owKg9LoFD7RgShKRWBNq
 BqOf3dsPtxW40fGBCsBjVo7GU4B2XxI//DnVlybyg0lgZCM2VQ3+v722bwlbM3+DXsjJ
 61ZZGJ6nuOs9qaa2QUWLbBXcG9bIpnIjmFlJx57GRuMIM+q8eBK3SpxvU8Vnt2WuHu+Q
 pE/gDM920QmSVlH0syJGwKiFWzYJQNFIL15qiVvyjzzjsPJImSgi54LtGzjX+16H01qE
 vmrQjvvRAZon4gMfwBZ4ii/Pp1Lm8h++oV9ygIXp+2KQnUaHmb3TkK1S1iEKPMbTVT8l
 O2iw==
X-Gm-Message-State: AOAM53300k/swEwe7q40/yPtE07H+IoT+IJMsG0BJ2diTCvhZNeEx6Iq
 vjPJ2WrPR8WABJsnJprLwNTYIUH63R4=
X-Google-Smtp-Source: ABdhPJzB3ii7YBgX/7FzFTPNg3wupwqxX9f0P9tns1iklPQbI8U93J0oZd3TE3BTA0RX7RmVs/YhNQ==
X-Received: by 2002:a63:4742:: with SMTP id w2mr12369412pgk.258.1603071572575; 
 Sun, 18 Oct 2020 18:39:32 -0700 (PDT)
Received: from localhost.localdomain ([73.93.155.115])
 by smtp.gmail.com with ESMTPSA id p8sm2446607pgs.34.2020.10.18.18.39.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Oct 2020 18:39:32 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/9] configure: cross-compiling without cross_prefix
Date: Sun, 18 Oct 2020 18:39:21 -0700
Message-Id: <20201019013928.72770-3-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019013928.72770-1-j@getutm.app>
References: <20201019013928.72770-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.210.194;
 envelope-from=osy86github@gmail.com; helo=mail-pf1-f194.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 21:39:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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


