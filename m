Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF1AC4363D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8711A20774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbfDIMgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8711A20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPSA1-00064k-Hc
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPS6q-00025v-0l
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:09:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPS6n-0002AL-7e
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601910540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FW9/z9xnsQp6byUMgIfF420Uf0QHqfOugK8Uwn8x5AA=;
 b=MbfDIMgg+FfQRPn63aoG6L4zt95+XTzE+LwD13pxUPTqxm46UF6IV3mAgkGEJlT48HSFOI
 VEGvSwJz2V8AIIZqvhLUNURj2e08YG3Io9YchuMaB7BfNdcDx0RuCON7Jsl9CD5mb+C19l
 QOCXvqQZMpDXixpZZXnZWVmUGLrky2g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-s195m9ehO0SZV8-jMZIbGw-1; Mon, 05 Oct 2020 11:08:59 -0400
X-MC-Unique: s195m9ehO0SZV8-jMZIbGw-1
Received: by mail-wr1-f70.google.com with SMTP id t17so810975wrm.13
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 08:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FW9/z9xnsQp6byUMgIfF420Uf0QHqfOugK8Uwn8x5AA=;
 b=PnoIWJgZ577gKgHnqhdkLkdqIfKgTsIJxe/UFp3EHOb6CGW2kC//q+U8ckyjj9cVqa
 G/KS8tLBr3zoYaofkMV7W3D0tsL7I2e0zxlSuxncSuG7yICEOAFnARUuCrjR+hOKQ9aU
 uVpEDAkwJmSd1U6iYAHJ9aK3GWzfKTcOP3EtuSY/vZIuVm8KcPil/VzE71jS+/2l4aoH
 GFL8I6XdKT2RLKeytfqYpE7cvjTSRxmgQZlvaU09bEJ4w/e/sL5dg8EtH8s9PaDPmJlV
 cdwZChvF8G+wU3MOXjdOBxx9i6o1NGAnIk4vQK0fNrN5wQ7G8TbpEPzglpvmAhvaDnRa
 cxwg==
X-Gm-Message-State: AOAM531n+Eztc5jgGvT8rmWIO4/6eQPnUI79Yx0GfJDfYvX0dt2nY8Ll
 emwWCAKjK2ynr8HvdPKBc3S/jEXN3svjEhTDAdUiNbt2gfEyePW4UO4hpChNRIyJIkHl5TX2OiZ
 KinZPD1pe2uaVWNo=
X-Received: by 2002:adf:9e41:: with SMTP id v1mr19822308wre.60.1601910537810; 
 Mon, 05 Oct 2020 08:08:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGIi2hLtDU5sE/lKZtt78sgqSmDQFjmwagqL3if2eDIl13t/KUm46vbx3m/qs86rlIi80nrA==
X-Received: by 2002:adf:9e41:: with SMTP id v1mr19822284wre.60.1601910537624; 
 Mon, 05 Oct 2020 08:08:57 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id o4sm272983wrv.86.2020.10.05.08.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 08:08:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/4] hw/ppc: Rename FDT_PPC as FDT
Date: Mon,  5 Oct 2020 17:08:43 +0200
Message-Id: <20201005150845.2124381-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005150845.2124381-1-philmd@redhat.com>
References: <20201005150845.2124381-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the generic FDT symbol.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/ppc/Kconfig     | 15 ++++++---------
 hw/ppc/meson.build |  2 +-
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index dd86e664d2..e6b8957964 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -10,7 +10,7 @@ config PSERIES
     select XICS_SPAPR
     select XIVE_SPAPR
     select MSI_NONBROKEN
-    select FDT_PPC
+    select FDT
     select CHRP_NVRAM
 
 config SPAPR_RNG
@@ -28,7 +28,7 @@ config POWERNV
     select MC146818RTC
     select XICS
     select XIVE
-    select FDT_PPC
+    select FDT
     select PCI_EXPRESS
     select MSI_NONBROKEN
 
@@ -47,7 +47,7 @@ config PPC440
     select PCI_EXPRESS
     select PPC4XX
     select SERIAL
-    select FDT_PPC
+    select FDT
 
 config PPC4XX
     bool
@@ -66,7 +66,7 @@ config SAM460EX
     select SMBUS_EEPROM
     select USB_EHCI_SYSBUS
     select USB_OHCI
-    select FDT_PPC
+    select FDT
 
 config PREP
     bool
@@ -117,7 +117,7 @@ config E500
     select PPCE500_PCI
     select SERIAL
     select MPC_I2C
-    select FDT_PPC
+    select FDT
 
 config VIRTEX
     bool
@@ -126,7 +126,7 @@ config VIRTEX
     select SERIAL
     select XILINX
     select XILINX_ETHLITE
-    select FDT_PPC
+    select FDT
 
 config XIVE
     bool
@@ -146,6 +146,3 @@ config XIVE_KVM
 # Only used by 64-bit targets
 config FW_CFG_PPC
     bool
-
-config FDT_PPC
-    bool
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index ffa2ec37fa..613a635bc4 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -3,7 +3,7 @@ ppc_ss.add(files(
   'ppc.c',
   'ppc_booke.c',
 ))
-ppc_ss.add(when: 'CONFIG_FDT_PPC', if_true: [files(
+ppc_ss.add(when: 'CONFIG_FDT', if_true: [files(
   'fdt.c',
 ), fdt])
 ppc_ss.add(when: 'CONFIG_FW_CFG_PPC', if_true: files('fw_cfg.c'))
-- 
2.26.2


