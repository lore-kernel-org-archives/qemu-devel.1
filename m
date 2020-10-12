Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32344C43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A7C218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A7C218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8f2-0004Kn-R1
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 20:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kS7Gd-0001mc-Bx; Mon, 12 Oct 2020 19:30:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kS7GB-00060t-WA; Mon, 12 Oct 2020 19:30:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id g29so16026524pgl.2;
 Mon, 12 Oct 2020 16:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8NpxZ4sG3TMSoSeEr8UVCiKc9XMWaUFFs7rNquz3/8U=;
 b=UnQmZ5t2FyYKZRckwNTMS47ZB2dOC5ABZoqM/mECeozVOePqf2TlzZpLieUZMPCpGH
 R2+TMdEpkD2eKojLMsw8wcVNOSP+mfjaoG5LXXrCCebPWv82KtDBTYG0quVv+QMf0xzP
 v99NuyJYj38tHebGbRTl+BVSS/sgrNuW3UfbmaFS88gVg5q/aKYrel8o7sWwResymTvX
 2x+PZBJhfsBo5HdT1pBvSVMUciSLJvsIcdiqeDw0ZgDLCn1kn+ia8adn0G4Lx7eBFWgP
 xIUQtkt8/lsIcbiW2MMS08/N0+gPd0fnVaJuZTRx9wK1RgguHa2rAbAjAdgX3ruK0qmo
 ySoA==
X-Gm-Message-State: AOAM533s5kqOCEyne5XrKqhJNaqBHfQ5vIyr1Ewjd4yIH7TaQtoRQhbg
 pw6+dNPZRCz+zaxsGkiUMbRNxxunxsE=
X-Google-Smtp-Source: ABdhPJz2ImXbIL67Up/8Ki1mhu+FKxK2zseyNUdIb15khotMyPuO89jTXcQiSFeFyibcu6KB1vBcOA==
X-Received: by 2002:a63:370f:: with SMTP id e15mr13713559pga.124.1602545382283; 
 Mon, 12 Oct 2020 16:29:42 -0700 (PDT)
Received: from localhost.localdomain ([73.93.152.174])
 by smtp.gmail.com with ESMTPSA id f21sm8088315pfk.169.2020.10.12.16.29.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Oct 2020 16:29:41 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/10] configure: option to disable host block devices
Date: Mon, 12 Oct 2020 16:29:30 -0700
Message-Id: <20201012232939.48481-2-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012232939.48481-1-j@getutm.app>
References: <20201012232939.48481-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.194; envelope-from=osy86dev@gmail.com;
 helo=mail-pg1-f194.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 19:29:42
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
Cc: Kevin Wolf <kwolf@redhat.com>, Joelle van Dyne <j@getutm.app>,
 "open list:raw" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: osy <osy86@users.noreply.github.com>

Some hosts (iOS) have a sandboxed filesystem and do not provide low-level
APIs for interfacing with host block devices.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 block/file-posix.c | 8 +++++++-
 configure          | 4 ++++
 meson.build        | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index c63926d592..52f7c20525 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -41,7 +41,7 @@
 #include "scsi/pr-manager.h"
 #include "scsi/constants.h"
 
-#if defined(__APPLE__) && (__MACH__)
+#if defined(CONFIG_HOST_BLOCK_DEVICE) && defined(__APPLE__) && (__MACH__)
 #include <paths.h>
 #include <sys/param.h>
 #include <IOKit/IOKitLib.h>
@@ -3247,6 +3247,8 @@ BlockDriver bdrv_file = {
 /***********************************************/
 /* host device */
 
+#if defined(CONFIG_HOST_BLOCK_DEVICE)
+
 #if defined(__APPLE__) && defined(__MACH__)
 static kern_return_t GetBSDPath(io_iterator_t mediaIterator, char *bsdPath,
                                 CFIndex maxPathSize, int flags);
@@ -3872,6 +3874,8 @@ static BlockDriver bdrv_host_cdrom = {
 };
 #endif /* __FreeBSD__ */
 
+#endif /* CONFIG_HOST_BLOCK_DEVICE */
+
 static void bdrv_file_init(void)
 {
     /*
@@ -3879,6 +3883,7 @@ static void bdrv_file_init(void)
      * registered last will get probed first.
      */
     bdrv_register(&bdrv_file);
+#if defined(CONFIG_HOST_BLOCK_DEVICE)
     bdrv_register(&bdrv_host_device);
 #ifdef __linux__
     bdrv_register(&bdrv_host_cdrom);
@@ -3886,6 +3891,7 @@ static void bdrv_file_init(void)
 #if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
     bdrv_register(&bdrv_host_cdrom);
 #endif
+#endif /* CONFIG_HOST_BLOCK_DEVICE */
 }
 
 block_init(bdrv_file_init);
diff --git a/configure b/configure
index b553288c5e..3c63879750 100755
--- a/configure
+++ b/configure
@@ -446,6 +446,7 @@ meson=""
 ninja=""
 skip_meson=no
 gettext=""
+host_block_device_support="yes"
 
 bogus_os="no"
 malloc_trim="auto"
@@ -6098,6 +6099,9 @@ if test "$default_devices" = "yes" ; then
 else
   echo "CONFIG_MINIKCONF_MODE=--allnoconfig" >> $config_host_mak
 fi
+if test "$host_block_device_support" = "yes" ; then
+  echo "CONFIG_HOST_BLOCK_DEVICE=y" >> $config_host_mak
+fi
 if test "$debug_tcg" = "yes" ; then
   echo "CONFIG_DEBUG_TCG=y" >> $config_host_mak
 fi
diff --git a/meson.build b/meson.build
index 17c89c87c6..5d3a47784b 100644
--- a/meson.build
+++ b/meson.build
@@ -1947,6 +1947,7 @@ summary_info += {'vvfat support':     config_host.has_key('CONFIG_VVFAT')}
 summary_info += {'qed support':       config_host.has_key('CONFIG_QED')}
 summary_info += {'parallels support': config_host.has_key('CONFIG_PARALLELS')}
 summary_info += {'sheepdog support':  config_host.has_key('CONFIG_SHEEPDOG')}
+summary_info += {'host block dev support': config_host.has_key('CONFIG_HOST_BLOCK_DEVICE')}
 summary_info += {'capstone':          capstone_opt == 'disabled' ? false : capstone_opt}
 summary_info += {'libpmem support':   config_host.has_key('CONFIG_LIBPMEM')}
 summary_info += {'libdaxctl support': config_host.has_key('CONFIG_LIBDAXCTL')}
-- 
2.24.3 (Apple Git-128)


