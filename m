Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF06BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B896020786
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xen.org header.i=@xen.org header.b="FU0HNTN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B896020786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Lla-0003nQ-2M
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 05:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@xen.org>) id 1k0Lkt-0003N8-UL
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:18:39 -0400
Received: from mail.xenproject.org ([104.130.215.37]:57370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@xen.org>) id 1k0Lko-0000EV-Ke
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
 s=20200302mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sjv/L6hz1YrCvxTOhpyWiGw3pyQEgsy/LiJEyUnsD/U=; b=FU0HNTN1iUoJ8yy8ZzYwTC6Ap7
 8/izMpkwkHS/Ft1mujCVI/UNMGzrPP8FtbfQ78o312H8gUmgiScz0nFl8EOiYy2nueAS2V2bzPZhg
 KW6vUC45EVTYIwfgxrzXnXwG6kPbI2lNUMKoHHAoVs0oAusn5SFauRpixnrvxFsjKgTU=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.92)
 (envelope-from <paul@xen.org>)
 id 1k0Lkm-0003hk-5S; Tue, 28 Jul 2020 09:18:32 +0000
Received: from host86-143-223-30.range86-143.btcentralplus.com
 ([86.143.223.30] helo=u2f063a87eabd5f.home)
 by xenbits.xenproject.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <paul@xen.org>)
 id 1k0Lkl-0007du-SK; Tue, 28 Jul 2020 09:18:32 +0000
From: Paul Durrant <paul@xen.org>
To: qemu-devel@nongnu.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH] configure: define CONFIG_XEN when Xen is enabled
Date: Tue, 28 Jul 2020 10:18:28 +0100
Message-Id: <20200728091828.21702-1-paul@xen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.130.215.37; envelope-from=paul@xen.org;
 helo=mail.xenproject.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 05:18:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <pdurrant@amazon.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paul Durrant <pdurrant@amazon.com>

The recent commit da278d58a092 "accel: Move Xen accelerator code under
accel/xen/" introduced a subtle semantic change, making xen_enabled() always
return false unless CONFIG_XEN is defined prior to inclusion of sysemu/xen.h,
which appears to be the normal case. This causes various use-cases of QEMU
with Xen to break.

This patch makes sure that CONFIG_XEN is defined if --enable-xen is passed
to configure.

Fixes: da278d58a092 ("accel: Move Xen accelerator code under accel/xen/")
Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 2acc4d1465..f1b9d129fd 100755
--- a/configure
+++ b/configure
@@ -7434,6 +7434,7 @@ if test "$virglrenderer" = "yes" ; then
   echo "VIRGL_LIBS=$virgl_libs" >> $config_host_mak
 fi
 if test "$xen" = "yes" ; then
+  echo "CONFIG_XEN=y" >> $config_host_mak
   echo "CONFIG_XEN_BACKEND=y" >> $config_host_mak
   echo "CONFIG_XEN_CTRL_INTERFACE_VERSION=$xen_ctrl_version" >> $config_host_mak
 fi
-- 
2.20.1


