Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C65C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A274F21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nodDSSyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A274F21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOv6-0002WX-B0
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz2-0004YN-CC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz1-00082s-4z
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:20 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNz0-00081X-Ud
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:19 -0500
Received: by mail-wr1-x441.google.com with SMTP id b6so2661985wrq.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7II7HXD2dCRyEaFrPk3gzA1HlPJFN/y0B2bCD8zF+hQ=;
 b=nodDSSyAAf9Gf/5/eQmt6w8OXZq77kqROWaOVOQa8n0/nbO1csHPcW5m27DoxAacqj
 DLtwTQXsPYlOrQp8HXgMbeluGz3WxjODbeIiNMX9vY4LcI+lq/jE+Q58PedaS9nJz0KU
 I6LRU9k3TbSncBSVieLbNxnSrSXJ4EE2TttddCHFpG1x55PrNpsaLZX906xvK5D1/82Z
 PofI1KpDarHcs1mzuSdjfcZg2eNXMC5KyYmLZAxnOS57R0QS1RZf6hm6wPK2q+y6qicB
 m7yq2MrBsXEHZV74M5jvc+OUThKg90mKyxFdsVayKkw+B4mY1yHrZg+NgH+0GWfoMpJR
 mI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7II7HXD2dCRyEaFrPk3gzA1HlPJFN/y0B2bCD8zF+hQ=;
 b=T7QLx7GHzmUHHPZ6HFEDUFbVRtNNmnDMoDJTO8jKnykDhA8naBYtL0CRsp7+VBEPJb
 CbVqcrUkN+UwzehwdJJiXEelQSH1H1ykxhQ3F9NRR4ddVPWvtjz9f3XKBfA735qFCmH0
 QrdTkom+lpx5pVJXIu2fBpNHTFgqyd3+qIX1gGigW77vczlP3ajw/X7SnPeu42Ow8xGK
 nQBL/612Z1QRYdLNmJGt9hOgKoIreQSqzIkTnlQ6pWBk6EoddIq3Lq2w/3ao/abjRIEr
 yWrdzMEmUCnXwDjAQ3sQ90F5wyT+wa8WBH7DNG/7uhCruaueMnl3LxyOgFrVUpnOYiJM
 E73A==
X-Gm-Message-State: APjAAAXVF9Yw72HqY6ipaa0fQvMVoagzegBTRHZEvw06FBy0AKrZZZa/
 A04NibtSkiysuByGQRcKaMmTgk/Z
X-Google-Smtp-Source: APXvYqwwjd0rMZqpzjIS1x4vvjQGINspR4hli4t9X/d/605b7nPkt0cvtc4AcY7ExpOUjcTlRtSSOA==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr6171543wrv.198.1576155257766; 
 Thu, 12 Dec 2019 04:54:17 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 080/132] meson: convert hw/pci
Date: Thu, 12 Dec 2019 13:52:04 +0100
Message-Id: <1576155176-2464-81-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 hw/Makefile.objs     |  1 -
 hw/meson.build       |  1 +
 hw/pci/Makefile.objs | 14 --------------
 hw/pci/meson.build   | 19 +++++++++++++++++++
 4 files changed, 20 insertions(+), 15 deletions(-)
 delete mode 100644 hw/pci/Makefile.objs
 create mode 100644 hw/pci/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 8a56abf..512d10d 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -22,7 +22,6 @@ devices-dirs-y += misc/
 devices-dirs-y += net/
 devices-dirs-y += rdma/
 devices-dirs-y += nvram/
-devices-dirs-y += pci/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 4d88cfa..1fd9eb5 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,5 +1,6 @@
 subdir('core')
 subdir('mem')
+subdir('pci')
 subdir('pci-bridge')
 subdir('pci-host')
 subdir('pcmcia')
diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
deleted file mode 100644
index c78f2fb..0000000
--- a/hw/pci/Makefile.objs
+++ /dev/null
@@ -1,14 +0,0 @@
-common-obj-$(CONFIG_PCI) += pci.o pci_bridge.o
-common-obj-$(CONFIG_PCI) += msix.o msi.o
-common-obj-$(CONFIG_PCI) += shpc.o
-common-obj-$(CONFIG_PCI) += slotid_cap.o
-common-obj-$(CONFIG_PCI) += pci_host.o
-
-# The functions in these modules can be used by devices too.  Since we
-# allow plugging PCIe devices into PCI buses, include them even if
-# CONFIG_PCI_EXPRESS=n.
-common-obj-$(CONFIG_PCI) += pcie.o pcie_aer.o
-common-obj-$(CONFIG_PCI_EXPRESS) += pcie_port.o pcie_host.o
-
-common-obj-$(call lnot,$(CONFIG_PCI)) += pci-stub.o
-common-obj-$(CONFIG_ALL) += pci-stub.o
diff --git a/hw/pci/meson.build b/hw/pci/meson.build
new file mode 100644
index 0000000..5c4bbac
--- /dev/null
+++ b/hw/pci/meson.build
@@ -0,0 +1,19 @@
+pci_ss = ss.source_set()
+pci_ss.add(files(
+  'msi.c',
+  'msix.c',
+  'pci.c',
+  'pci_bridge.c',
+  'pci_host.c',
+  'shpc.c',
+  'slotid_cap.c'
+))
+# The functions in these modules can be used by devices too.  Since we
+# allow plugging PCIe devices into PCI buses, include them even if
+# CONFIG_PCI_EXPRESS=n.
+pci_ss.add(files('pcie.c', 'pcie_aer.c'))
+softmmu_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
+softmmu_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
+
+softmmu_ss.add(when: 'CONFIG_PCI', if_false: files('pci-stub.c'))
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('pci-stub.c'))
-- 
1.8.3.1



