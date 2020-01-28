Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B11AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF97F20674
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhVK05bS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF97F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVs4-0003au-Ve
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7I-0002ow-DQ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7D-0006uX-04
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:33 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:37441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7C-0006sT-Q7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:30 -0500
Received: by mail-wr1-x430.google.com with SMTP id w15so17145827wru.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A0fvcs5YMBCnnsJ4rLOXPoeTTIZG7UPPjHO3H69y3E4=;
 b=DhVK05bS6P2fhEGt9bUYbN02RawxSHwl1uYil2kEjaqnKIKg6tKZDa6zuNaJlFyTWH
 fAr4qZjDJeHvTJLOV1LvVhoSSCR5ZTUBDH5W6I946VFWkb3g5J85KRrXCsazNboqOCN9
 Pjgg9Yc17UUNNZH0GOs1dJHQelUh1ogbq9dJ165SnG4Ahf+UlFm2mOSMRyMhRk1MS37W
 GYXkuA0pNqbXwLRiO/XUfMMSVpe4HeKSvTKVWtoxHVX28EyNVpiIC5DBUwWjxkA5G85+
 thxBQx2AEO59JKmzH2rnRo072Grzo2+lzoRsgZnDare2JWGU9F/w15oaiiG+Tf/11V8f
 +wIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=A0fvcs5YMBCnnsJ4rLOXPoeTTIZG7UPPjHO3H69y3E4=;
 b=CPBclEfJ7UMVELPWbUEkqSgT0AAC7/RDPeIoWmD3fKPjERyLGA9QCLi6QSQCI43pER
 juO+CJgHsmqJJJEJXLRrsPBLw7ta7qHJuPqj/TKV2G3KGWy3pNXQJwDn1VqfyFfU4Sex
 eLr0QGgfqc89EfEQ3K88fJgXUpiq87NV3JbcXz5G1Gb+zLUPkucmr28dYwAz3R/BIf7P
 keWt5U22KAvcNZUgti0x5p0RceQrav85HNsNswSRhjjsWCewrBnbmVOKH5zKB8IW8krM
 YB1+ArgL6s/C8FA8S9s/HdjYW1AT/fU/M4gks0JuZseQgTI/Eo/IJG5jOSzcua2CbWoy
 uPtQ==
X-Gm-Message-State: APjAAAUOmKRbEm+wWysSH2+VHL9pNZOldM5/F03p6WsSSOnzXsuKxfqW
 yH+f+iStj7309j6wZQa0/bvI6Xa8
X-Google-Smtp-Source: APXvYqzQRweXX0s03wq+ZvBRY5FCSDXToVbIHAq/SkB1V46xYmvhCRfnMmymb3SuD3DBc6UiOjtXZw==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr31852647wrm.210.1580234248752; 
 Tue, 28 Jan 2020 09:57:28 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 094/142] meson: convert hw/ipmi
Date: Tue, 28 Jan 2020 18:52:54 +0100
Message-Id: <20200128175342.9066-95-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs      |  1 -
 hw/ipmi/Makefile.objs |  8 --------
 hw/ipmi/meson.build   | 11 +++++++++++
 hw/meson.build        |  1 +
 4 files changed, 12 insertions(+), 9 deletions(-)
 delete mode 100644 hw/ipmi/Makefile.objs
 create mode 100644 hw/ipmi/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index e5f4308436..a2744ad4b9 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -15,7 +15,6 @@ devices-dirs-y += ide/
 devices-dirs-y += input/
 devices-dirs-y += intc/
 devices-dirs-$(CONFIG_IPACK) += ipack/
-devices-dirs-$(CONFIG_IPMI) += ipmi/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/ipmi/Makefile.objs b/hw/ipmi/Makefile.objs
deleted file mode 100644
index 3cca10bc50..0000000000
--- a/hw/ipmi/Makefile.objs
+++ /dev/null
@@ -1,8 +0,0 @@
-common-obj-$(CONFIG_IPMI) += ipmi.o ipmi_kcs.o ipmi_bt.o
-common-obj-$(CONFIG_IPMI_LOCAL) += ipmi_bmc_sim.o
-common-obj-$(CONFIG_IPMI_EXTERN) += ipmi_bmc_extern.o
-common-obj-$(CONFIG_ISA_IPMI_KCS) += isa_ipmi_kcs.o
-common-obj-$(CONFIG_PCI_IPMI_KCS) += pci_ipmi_kcs.o
-common-obj-$(CONFIG_ISA_IPMI_BT) += isa_ipmi_bt.o
-common-obj-$(CONFIG_PCI_IPMI_BT) += pci_ipmi_bt.o
-common-obj-$(CONFIG_IPMI_SSIF) += smbus_ipmi.o
diff --git a/hw/ipmi/meson.build b/hw/ipmi/meson.build
new file mode 100644
index 0000000000..9622ea2a2c
--- /dev/null
+++ b/hw/ipmi/meson.build
@@ -0,0 +1,11 @@
+ipmi_ss = ss.source_set()
+ipmi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c', 'ipmi_kcs.c', 'ipmi_bt.c'))
+ipmi_ss.add(when: 'CONFIG_IPMI_LOCAL', if_true: files('ipmi_bmc_sim.c'))
+ipmi_ss.add(when: 'CONFIG_IPMI_EXTERN', if_true: files('ipmi_bmc_extern.c'))
+ipmi_ss.add(when: 'CONFIG_ISA_IPMI_KCS', if_true: files('isa_ipmi_kcs.c'))
+ipmi_ss.add(when: 'CONFIG_PCI_IPMI_KCS', if_true: files('pci_ipmi_kcs.c'))
+ipmi_ss.add(when: 'CONFIG_ISA_IPMI_BT', if_true: files('isa_ipmi_bt.c'))
+ipmi_ss.add(when: 'CONFIG_PCI_IPMI_BT', if_true: files('pci_ipmi_bt.c'))
+ipmi_ss.add(when: 'CONFIG_IPMI_SSIF', if_true: files('smbus_ipmi.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_IPMI', if_true: ipmi_ss)
diff --git a/hw/meson.build b/hw/meson.build
index 86598544e6..9796f95e5c 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('ipmi')
 subdir('isa')
 subdir('mem')
 subdir('misc')
-- 
2.21.0



