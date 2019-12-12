Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBA8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765082077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrylU0Mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765082077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOsB-0006aD-35
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:51:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz0-0004Ud-GH
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyz-000809-Cy
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:18 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyz-0007xD-5o
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:17 -0500
Received: by mail-wr1-x430.google.com with SMTP id c9so2604809wrw.8
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NZznVY2PNcm8/8th1seZakUGMQB4kApyVOseMDs6r+M=;
 b=YrylU0Mto+scss+HWbGPVSjD9Gk8rSfvjR9eX9K824j4nioz3js1OS2OY1bF0igTLb
 D7xj93ghUIxkc1uGC2E9JnxVotNC9gpcP024nsKtwcGscxRos3VPaO460F1OlZhBklMq
 MXgSX5zVZLqvvD/tMzErrXAAFauBMoIRb8NDDe9vVF8b6AyPpNS0tJ0jc6bMiVgCLlEk
 11KzItAInQWvkXE+KFBzcK8JyCRypue7Ygt1lfG1q0qkU6Edy5RUfU53wSgah884VEVX
 8Mv8FAfoGkUtfJVnO+2XumoudWiD2Z3KH3Q1gcm+fqcHjgZ2vbLoIuRoThX2Moq9M9Ba
 63gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NZznVY2PNcm8/8th1seZakUGMQB4kApyVOseMDs6r+M=;
 b=WUCVltmVa7H1LCLQFy7yLfgL0r8sWfKi/BNFuvioiPrjj1fdPrn3omwf4jRn5nC64G
 qpzovEnwtwRoY/Sd4oaPBu/IJJpxaGGZm8hp+Ss94aPgLQzRn+I+/bvJZF2dyvmmOwX8
 jaowiquvQJUQPp5ntZGTt7+QJcfrXIgVX+CHbPcG+gp1Rxpg0vCPsuzsuP4Px92KXAIy
 09Qv+XpX03v/vnI93TPqhS10dkMLNVh82IBJRj99p+lWgvKnhJtxn76PqCmbmJFTTV8y
 a9hbVuBYiZ41nViz0iH5jF21CX6SqTBQTboylS4Nlzp5pdEl6a02yvwZ4yRRUAJVC1b2
 Xiag==
X-Gm-Message-State: APjAAAUqYvkOIZDFDryUAm9A6n7s3Uf540J1pzXd+3wVPNDeZaw3Cw4P
 QvzEESZxtPKChq9LEP04v5wZiKbs
X-Google-Smtp-Source: APXvYqxxomIJkq60aa8Ya3e4qnvPcvzpGBdJRA7R6DYdloh6jQz4isAm8SkM2rTM0dO4Jtu1bSwIqQ==
X-Received: by 2002:adf:d848:: with SMTP id k8mr5983951wrl.328.1576155255004; 
 Thu, 12 Dec 2019 04:54:15 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 077/132] meson: convert hw/pcmcia
Date: Thu, 12 Dec 2019 13:52:01 +0100
Message-Id: <1576155176-2464-78-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs        | 1 -
 hw/meson.build          | 1 +
 hw/pcmcia/Makefile.objs | 2 --
 hw/pcmcia/meson.build   | 2 ++
 4 files changed, 3 insertions(+), 3 deletions(-)
 delete mode 100644 hw/pcmcia/Makefile.objs
 create mode 100644 hw/pcmcia/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 4670061..bfa305f 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -24,7 +24,6 @@ devices-dirs-y += rdma/
 devices-dirs-y += nvram/
 devices-dirs-y += pci/
 devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
-devices-dirs-y += pcmcia/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 37ff9ec..2356eda 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,5 +1,6 @@
 subdir('core')
 subdir('mem')
+subdir('pcmcia')
 subdir('scsi')
 subdir('sd')
 subdir('semihosting')
diff --git a/hw/pcmcia/Makefile.objs b/hw/pcmcia/Makefile.objs
deleted file mode 100644
index 4eac060..0000000
--- a/hw/pcmcia/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-common-obj-y += pcmcia.o
-obj-$(CONFIG_PXA2XX) += pxa2xx.o
diff --git a/hw/pcmcia/meson.build b/hw/pcmcia/meson.build
new file mode 100644
index 0000000..48ece81
--- /dev/null
+++ b/hw/pcmcia/meson.build
@@ -0,0 +1,2 @@
+softmmu_ss.add(files('pcmcia.c'))
+specific_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx.c'))
-- 
1.8.3.1



