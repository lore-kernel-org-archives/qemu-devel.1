Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D00CC2BAEE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81FC20736
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="0k6iuWTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81FC20736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC4nj-0007bn-BV
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <basil@daynix.com>) id 1jC4mR-0005Pj-E0
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <basil@daynix.com>) id 1jC4mQ-0000HE-AL
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:04:27 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33473)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <basil@daynix.com>) id 1jC4mP-0000Ds-PP
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:04:26 -0400
Received: by mail-wr1-x443.google.com with SMTP id a25so3634296wrd.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 10:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YmXW/SP9doq5sjoE7E/52vrDte/Mf5r4HqcJtOH7zn4=;
 b=0k6iuWTgJ6/QSPwDmiLJbkthg8AqOt/otdbrLa/gV/AeNHY1NuSlnoz1a+BGHic18K
 tpE1zo0Yv+OxYl3olx74aDB5+ZvxhfdXp5DSJsYYrXdbWQkn3JCdYt97i0wMB+mgCk5f
 cMWi+nvPe29+yHBPJxd86uNHxrrU0sFCWdULZFSYFZHPNanle4+KylP2y7R+l5+MfobJ
 fCHj+uK6bmGDwIBIR5ri/PVYLgUzB8Lnel4CZ6QMbRiDQwuOT0IyHw3qier63EHdEIFL
 KCdXlSEB7Uu7agQia/bqVf6vTX1LJIG1EYiT9I3n8EIOIXTZbVHCymTVxK39FSpXeJnf
 I7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YmXW/SP9doq5sjoE7E/52vrDte/Mf5r4HqcJtOH7zn4=;
 b=eAOAnyv9+pBngzRooGUJK2VsZtYBx+orKgWX7AvRLhDj3XZlNmJ/NZn+1WkA+cKicx
 5m/P92vqhEKuE3V437f8OrJm9QblbHUft4FwKypyxZ4vfkTRRsA4EvUBce+wKeBEDcAI
 67ppviNC4tw2spXkU4J0YcSAmo1zxO8mVlDDzl7IF9ULk1SJPIgnh/dFiFYG1QHlqZVb
 V0VXmVzs2xW52SDndx/Km0NfBxlkvONLMp/OPjFtBN9bH5d0WRpUC8KmCpVEs/+0OGsH
 noG3KF4c0qzYpqt/nz7JXsMlHhmbQ2rRelOytXkkyR1p/MLE3ZhYOfNThs2AI0Yx37bO
 52Lw==
X-Gm-Message-State: ANhLgQ3iIpXKqy2qIRBfYyK5SnOkBN2RNwKBWXxrqgQaz5CSA0CJ3Ucd
 keUf2DmcJ6+LHvS7L+uB1UWC0eZCijw=
X-Google-Smtp-Source: ADFU+vtg/M/VE497TB0LrBcyuO23l+ry5KrFwnEGmLP2RbuDwL8/8gcH4A95HLGH7XpuB4Ha5brDaw==
X-Received: by 2002:adf:9b19:: with SMTP id b25mr5437781wrc.368.1583946264116; 
 Wed, 11 Mar 2020 10:04:24 -0700 (PDT)
Received: from localhost.localdomain (bzq-84-110-34-91.static-ip.bezeqint.net.
 [84.110.34.91])
 by smtp.gmail.com with ESMTPSA id o26sm8510925wmc.33.2020.03.11.10.04.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 11 Mar 2020 10:04:23 -0700 (PDT)
From: Basil Salman <basil@daynix.com>
To: qemu-devel@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: [PATCH v3 1/3] qga: Installer: Wait for installation to finish
Date: Wed, 11 Mar 2020 19:04:15 +0200
Message-Id: <20200311170417.13415-2-basil@daynix.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200311170417.13415-1-basil@daynix.com>
References: <20200311170417.13415-1-basil@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Yan Vugenfirer <yan@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Installation might fail if we don't wait for the provider
unregisteration process to finish.

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
Signed-off-by: Basil Salman <basil@daynix.com>
---
 qga/installer/qemu-ga.wxs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
index 64bf90bd85..f6781752e6 100644
--- a/qga/installer/qemu-ga.wxs
+++ b/qga/installer/qemu-ga.wxs
@@ -81,7 +81,7 @@
               Arguments="-d --retry-path"
               >
             </ServiceInstall>
-            <ServiceControl Id="StartService" Start="install" Stop="both" Remove="uninstall" Name="QEMU-GA" Wait="no" />
+            <ServiceControl Id="StartService" Start="install" Stop="both" Remove="uninstall" Name="QEMU-GA" Wait="yes" />
           </Component>
           <?ifdef var.InstallVss?>
           <Component Id="qga_vss_dll" Guid="{CB19C453-FABB-4BB1-ABAB-6B74F687BFBB}">
-- 
2.17.2


