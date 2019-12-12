Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92BEC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F42227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+6PjBXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F42227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOx2-0005Md-1g
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz1-0004WP-EC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz0-00081K-70
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:19 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:40424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyz-00080Q-W7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:18 -0500
Received: by mail-wm1-x32e.google.com with SMTP id t14so2373539wmi.5
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+4dOxdROAj+zoDtcNkjhpKvAio7iw22WNxOkmH2Hvlc=;
 b=B+6PjBXSz+c32XTh+Aa2SyZ+aAM0yh1rTvxsTbzF6ZfiIHPntH5Om2q/YJg0psWP+b
 HJFTlQEkedClXY+8w2WuuWG/5x17L9XsHdnZX4AVwUrboJHVO19yvFAyLy6tntu1QqI2
 nnAcPAFhv6EJ0l7dpxxHCkrLYanXGC111LMZDxNkv5WNjOdF3YIoX62oOPlhEi5CI9CK
 19or0rinMasUBiD/7EbGjje4Jq8mR2+4q0SZ+z/9O0FOTrwnKvWfPqRqNhqWFgV9cp6U
 IC4luoVRkicOkJ5xqEO5suiuAkqB/vec21T2rJr4zE7WWT+Vj6JqFrqPvOu51ZDhMJO2
 9BwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+4dOxdROAj+zoDtcNkjhpKvAio7iw22WNxOkmH2Hvlc=;
 b=WQhYe1rok8l3ISJeVxCBau12aYYXslAtCUs8vKGjx2l35CQlrzu8TWFGHHOT3F+T/o
 D6ukdLryhEDdgd1P+o04saVPl1b5Z2uoL83wDlQT/XLsGcHuUDl0AM4vaVFqQG+YcBxd
 M049j+MSvNZF3uL55Ax8eWuUIfAeOogTJ67qtxGGBmoKtGnME0fv1QDUiJizeWHUd5mK
 jBmWjm8aj4L6u53Q+5X8kDQxPFfBPsRLAQgQDKM9dtIhYlq0RJpXC5UzRT1+RI3x6YA6
 1zT3Jk0jxVIEyBjs/Vtk86TCCQha2SbzgJEjFgIZBVgsh6VXm6GmcYMr0Lcsfy/sk7Rz
 M55w==
X-Gm-Message-State: APjAAAWdH+wKskStboH5j3yR5FbfcyaHDKa1igD/IgFP1JfqfcTQMJvz
 1CzkjdgDUK9ZiOOuRLEkHPLtuAmT
X-Google-Smtp-Source: APXvYqxqe3ECFnhKhELAJimx55RoJCoiIg5aJANYuiFKRzt5GDXbEvzaHuSf5rl2VwNYy+wfJY/WQA==
X-Received: by 2002:a05:600c:257:: with SMTP id
 23mr6431280wmj.123.1576155256775; 
 Thu, 12 Dec 2019 04:54:16 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 079/132] meson: convert hw/pci-bridge
Date: Thu, 12 Dec 2019 13:52:03 +0100
Message-Id: <1576155176-2464-80-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
 hw/Makefile.objs            |  1 -
 hw/meson.build              |  1 +
 hw/pci-bridge/Makefile.objs | 10 ----------
 hw/pci-bridge/meson.build   | 14 ++++++++++++++
 4 files changed, 15 insertions(+), 11 deletions(-)
 delete mode 100644 hw/pci-bridge/Makefile.objs
 create mode 100644 hw/pci-bridge/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 1f76ce1..8a56abf 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -23,7 +23,6 @@ devices-dirs-y += net/
 devices-dirs-y += rdma/
 devices-dirs-y += nvram/
 devices-dirs-y += pci/
-devices-dirs-$(CONFIG_PCI) += pci-bridge/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index b93a496..4d88cfa 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,5 +1,6 @@
 subdir('core')
 subdir('mem')
+subdir('pci-bridge')
 subdir('pci-host')
 subdir('pcmcia')
 subdir('scsi')
diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
deleted file mode 100644
index 47065f8..0000000
--- a/hw/pci-bridge/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-common-obj-y += pci_bridge_dev.o
-common-obj-$(CONFIG_PCIE_PORT) += pcie_root_port.o gen_pcie_root_port.o pcie_pci_bridge.o
-common-obj-$(CONFIG_PXB) += pci_expander_bridge.o
-common-obj-$(CONFIG_XIO3130) += xio3130_upstream.o xio3130_downstream.o
-common-obj-$(CONFIG_IOH3420) += ioh3420.o
-common-obj-$(CONFIG_I82801B11) += i82801b11.o
-# NewWorld PowerMac
-common-obj-$(CONFIG_DEC_PCI) += dec.o
-# Sun4u
-common-obj-$(CONFIG_SIMBA) += simba.o
diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
new file mode 100644
index 0000000..daab8ac
--- /dev/null
+++ b/hw/pci-bridge/meson.build
@@ -0,0 +1,14 @@
+pci_ss = ss.source_set()
+pci_ss.add(files('pci_bridge_dev.c'))
+pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('i82801b11.c'))
+pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))
+pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pcie_root_port.c', 'pcie_pci_bridge.c'))
+pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'))
+pci_ss.add(when: 'CONFIG_XIO3130', if_true: files('xio3130_upstream.c', 'xio3130_downstream.c'))
+
+# NewWorld PowerMac
+pci_ss.add(when: 'CONFIG_DEC_PCI', if_true: files('dec.c'))
+# Sun4u
+pci_ss.add(when: 'CONFIG_SIMBA', if_true: files('simba.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
-- 
1.8.3.1



