Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF806C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:54:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB11021655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzTL0E44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB11021655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOur-00029e-LN
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz9-0004jc-6j
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz7-0008Dx-RM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:26 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:54271)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNz7-0008CZ-LI
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:25 -0500
Received: by mail-wm1-x332.google.com with SMTP id n9so2247557wmd.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mIHTX7legXEXhs75BG7UWtqDcO3CsnRpJQifiPnqN+k=;
 b=GzTL0E44NM2N7k9frPRuj5emf2qdY04f2vaJ81C360ha3zM/Sx6qhfuQKSuhX5rz4w
 WEhokNh08q5DrlKVJ9hAzIOTFiVRvAVhr/6gP/cJdz66gEJCBj+yMLYKmd8+ttHmf6U4
 vwaUtbpoQq5zUl2mSorAgqyjhl6YZ1SdBjJlLnzUpuG2sRh9Alvnzc5Ks6uEEIAeumNm
 M/6azy/aq22UpIixpnZEkfm9LNyq8mj90RbrgYdp9WMGuQK1wxij3fq90prPB+TQd7fL
 JtAJUDbjBABtTePrbLWpZxt06AnEsQ7oyB13dN7aa6ZuOLwT0kbIBkfWhkvq65/Ne/09
 vWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mIHTX7legXEXhs75BG7UWtqDcO3CsnRpJQifiPnqN+k=;
 b=LKzyNTZ/MeyvSqXy6EtXyRyQLMzoVhQ3xqQ1jpwwSqZT+5jm/J0joAQK9ZRvV4lWro
 ZYvJqqTk96h1arVZF7sHWFh9z0E1xWcSmtzROIRwtBsTebdHXyOSXW1dZ/Mpga+VT/Xw
 1yqrObDQnevoOnS1oTKFFOwP50AkOXsLD7gY+wq+3BiSubAkW5ZeoJHKPHyKsytI0u35
 kASvelUe/UYk8wNFqgUIfLBaUU3hpZgHlsahEZCvorxDAo/AJm67jSfm3byHDXPqOUCI
 EmXPqhTWil5NvWjXf53h/5+YYKOxGx7PyMBbm4cWqoYUVCQnWJCK3M5uXwcQuajxMLsw
 zYYA==
X-Gm-Message-State: APjAAAUxupbbnndlpci4Qok5f588PFSy3cl20lGD7yZMgjkr3Y1BqYWf
 APXUBYXxXtOJMVLVqw2NsyGPmjjD
X-Google-Smtp-Source: APXvYqzc1hphTsqVlJkfWiwuFSg5u2ilzMWsOFesuNoELxQhGz/Ib953XGjlego4WIIA8jxbw5+16w==
X-Received: by 2002:a7b:c004:: with SMTP id c4mr6318668wmb.45.1576155264406;
 Thu, 12 Dec 2019 04:54:24 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 087/132] meson: convert hw/ipack
Date: Thu, 12 Dec 2019 13:52:11 +0100
Message-Id: <1576155176-2464-88-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
 hw/Makefile.objs       | 1 -
 hw/ipack/Makefile.objs | 2 --
 hw/ipack/meson.build   | 1 +
 hw/meson.build         | 1 +
 4 files changed, 2 insertions(+), 3 deletions(-)
 delete mode 100644 hw/ipack/Makefile.objs
 create mode 100644 hw/ipack/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 7d85aba..8697b42 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -15,7 +15,6 @@ devices-dirs-$(CONFIG_I2C) += i2c/
 devices-dirs-y += ide/
 devices-dirs-y += input/
 devices-dirs-y += intc/
-devices-dirs-$(CONFIG_IPACK) += ipack/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/ipack/Makefile.objs b/hw/ipack/Makefile.objs
deleted file mode 100644
index 8b9bdcb..0000000
--- a/hw/ipack/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-common-obj-$(CONFIG_IPACK) += ipack.o
-common-obj-$(CONFIG_IPACK) += tpci200.o
diff --git a/hw/ipack/meson.build b/hw/ipack/meson.build
new file mode 100644
index 0000000..3f8138b
--- /dev/null
+++ b/hw/ipack/meson.build
@@ -0,0 +1 @@
+softmmu_ss.add(when: 'CONFIG_IPACK', if_true: files('ipack.c', 'tpci200.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 276f9ed..3e3f090 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('ipack')
 subdir('ipmi')
 subdir('isa')
 subdir('mem')
-- 
1.8.3.1



