Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AA2C388F2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 05:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA6F20897
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 05:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA6F20897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbdFF-0003Cf-Te
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 00:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbdDR-0001QR-Ir
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 00:26:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbdDP-0004u4-Hp
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 00:26:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id g12so4190464pgm.8
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 21:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=clC6oHTfnrMMN3FfznLE0Frgl/AYxxtTAqo83NQAGqs=;
 b=bKzkdDrWgEC+sR7IsuC0rgpuEet4Rckm72gwgNe9cea6hz3MQlMVeXXeAhmO+8D0A4
 ac+zfen8UxC8MBO78IEBD4tIoaldYRccV9edAqgN4lemL8SmuAy5r3aUWd70HBe/G2qz
 MpgBJokMcuckD++FLoiU45xkyibvkaEqoWbjyieGvswTp0XD4XyQuf8D6J4TLLG7QSbg
 ifBdlQmXrQFMQzfsgE1eHLMpkZoKxpb88qOHrDBN4lP5P3ZCD3QZotaJTc632PTvnxdB
 2nAaMQo2121RIFKfDNCm3T+7QmGEkXtWDTnx+q9dE/H959EZCXbYa5Zc92sWGYxKM+ti
 hetg==
X-Gm-Message-State: AOAM531iaYstr3JCI+RMvy+qQJ0a6p8HGpNtpGjTUtPwCu3pdti9OFtT
 sd+z0xvJTisVND4/IVxVouSp4PE3l1A=
X-Google-Smtp-Source: ABdhPJz/wWamFbuj+IHzGJzgkpgzzlj1eF0viciv3DQHjacfJ5ESOmQDRjNdXA1Iwpt4Zu/CO/BDrQ==
X-Received: by 2002:a63:ff4e:: with SMTP id s14mr8027436pgk.137.1604813170112; 
 Sat, 07 Nov 2020 21:26:10 -0800 (PST)
Received: from localhost.localdomain ([73.93.155.42])
 by smtp.gmail.com with ESMTPSA id hz18sm6994406pjb.13.2020.11.07.21.26.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 07 Nov 2020 21:26:09 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/7] configure: cross-compiling with empty cross_prefix
Date: Sat,  7 Nov 2020 21:26:00 -0800
Message-Id: <20201108052605.45840-3-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108052605.45840-1-j@getutm.app>
References: <20201108052605.45840-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.195;
 envelope-from=osy86github@gmail.com; helo=mail-pg1-f195.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 00:26:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The iOS toolchain does not use the host prefix naming convention. So we need
to enable cross-compile options while allowing the PREFIX to be blank.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 configure | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 97a879808d..fda7a875f7 100755
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
@@ -458,6 +459,7 @@ for opt do
   optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
   case "$opt" in
   --cross-prefix=*) cross_prefix="$optarg"
+                    cross_compile="yes"
   ;;
   --cc=*) CC="$optarg"
   ;;
@@ -1657,7 +1659,7 @@ $(echo Available targets: $default_target_list | \
   --target-list-exclude=LIST exclude a set of targets from the default target-list
 
 Advanced options (experts only):
-  --cross-prefix=PREFIX    use PREFIX for compile tools [$cross_prefix]
+  --cross-prefix=PREFIX    use PREFIX for compile tools, PREFIX can be blank [$cross_prefix]
   --cc=CC                  use C compiler CC [$cc]
   --iasl=IASL              use ACPI compiler IASL [$iasl]
   --host-cc=CC             use C compiler CC [$host_cc] for code run at
@@ -6933,7 +6935,7 @@ if has $sdl2_config; then
 fi
 echo "strip = [$(meson_quote $strip)]" >> $cross
 echo "windres = [$(meson_quote $windres)]" >> $cross
-if test -n "$cross_prefix"; then
+if test "$cross_compile" = "yes"; then
     cross_arg="--cross-file config-meson.cross"
     echo "[host_machine]" >> $cross
     if test "$mingw32" = "yes" ; then
-- 
2.28.0


