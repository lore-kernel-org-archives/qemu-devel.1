Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60933C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB1A227BF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq5yCIOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB1A227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihZ8v-0001iK-7g
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY46-0007cF-0F
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY44-0004KI-Pi
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:29 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:56106)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY44-0004H4-Go
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:28 -0500
Received: by mail-wm1-x32b.google.com with SMTP id q9so1556643wmj.5
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=beFvSsXmScK7eTwdxPz2BvPM7K8KAbUI0Ch3SEZ3qI0=;
 b=aq5yCIOvPEMLaWeHwWf+h8E/rnUhq1Eavqa2FoN1GgFP/6clgkoKBC056Usfj95Oph
 nMIz6q7OOlNiFVbGaU+f1ft7pA6/EpPB0vLNqXQIFAMT4YxaT8S0FYr5jF9vIb9Vv9tD
 pdJfosrS5wvfBy5WTY/mRQTL8gdI/TbCJireBVYxRA6zRLZps4+LZSUSmsrp0QG42+9d
 oVfo51E4E1Rg2Xdey4zTX8Vxbhinf6azft0/U7seh8gmNsUWBG8KEKYqX9JaMEEnnqKQ
 eHDPhXnwYx84boaPOVRJRtRvtUrWb3zdiEpb6hkERrfE770BFsUJ57Jc8c4ov/LPaG5I
 iEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=beFvSsXmScK7eTwdxPz2BvPM7K8KAbUI0Ch3SEZ3qI0=;
 b=Fg+462++FSXw9VHaKKLR10i1aPniwpRJdAFF63eG6QGrGQOToiCgk4vjB/hofszZsx
 HyZxAPpYqf9tRujRgU4hqg/LeOZLHfrytNd8TpBodHTBMICMW/W3U0tPfcneR1QCudjE
 6VF2J9tNITEX6BnIqXfDRYQJXxhoxHZ97EsZOZOFZIL7VwBxbQhn1ROj9th8+fN/HvGN
 40q/6rkDvQT492lTOz2XDYen4e7mLQLoQtxuAz9MgjJlt7e/4eTVTAIyoCrJY5p9/PCf
 oCPktQwBO/GAB5bUtTCi9+WObchDJZ8yMCXIv/x0ghAG1WGa0u42cTu1YGwecbvRWA75
 CRJw==
X-Gm-Message-State: APjAAAVnnnV8mSXazPvA3/SsUTLba2mwG3k6FglzozM1cmAJj4IGHSOS
 P+MMjE1VocGTQEYyX/N6FZKXik4R
X-Google-Smtp-Source: APXvYqxWvSB7li+NvGovYJCdsD5PbgGzzcRUnocG4vwCp3qRqK/4bQeOUZkWlKuTHw5xYqyjaNpaUQ==
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr2849806wmb.174.1576670667380; 
 Wed, 18 Dec 2019 04:04:27 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 85/87] hw/pci: Remove the "command_serr_enable" property
Date: Wed, 18 Dec 2019 13:02:51 +0100
Message-Id: <1576670573-48048-86-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Now that the old pc-0.x machine types have been removed, this config
knob is not required anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191209125248.5849-4-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/pci/pci.c         | 6 +-----
 include/hw/pci/pci.h | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index cbc7a32..e3d31036 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -69,8 +69,6 @@ static Property pci_props[] = {
     DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
-    DEFINE_PROP_BIT("command_serr_enable", PCIDevice, cap_present,
-                    QEMU_PCI_CAP_SERR_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
                     QEMU_PCIE_LNKSTA_DLLLA_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-extcap-init", PCIDevice, cap_present,
@@ -751,9 +749,7 @@ static void pci_init_wmask(PCIDevice *dev)
     pci_set_word(dev->wmask + PCI_COMMAND,
                  PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
                  PCI_COMMAND_INTX_DISABLE);
-    if (dev->cap_present & QEMU_PCI_CAP_SERR) {
-        pci_word_test_and_set_mask(dev->wmask + PCI_COMMAND, PCI_COMMAND_SERR);
-    }
+    pci_word_test_and_set_mask(dev->wmask + PCI_COMMAND, PCI_COMMAND_SERR);
 
     memset(dev->wmask + PCI_CONFIG_HEADER_SIZE, 0xff,
            config_size - PCI_CONFIG_HEADER_SIZE);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index db75c6d..2acd832 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -174,7 +174,7 @@ enum {
 #define QEMU_PCI_CAP_MULTIFUNCTION_BITNR        3
     QEMU_PCI_CAP_MULTIFUNCTION = (1 << QEMU_PCI_CAP_MULTIFUNCTION_BITNR),
 
-    /* command register SERR bit enabled */
+    /* command register SERR bit enabled - unused since QEMU v5.0 */
 #define QEMU_PCI_CAP_SERR_BITNR 4
     QEMU_PCI_CAP_SERR = (1 << QEMU_PCI_CAP_SERR_BITNR),
     /* Standard hot plug controller. */
-- 
1.8.3.1



