Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076A2C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C488B20705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzJ6+Sno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C488B20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAfc-0000gW-Sm
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWT-0003u4-FO
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWS-0004Ng-97
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:17 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:40110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWS-0004NA-2w
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:16 -0500
Received: by mail-wr1-x436.google.com with SMTP id c14so3181103wrn.7
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9GhguyiRSp1UcskdHA85/bdqym1ln7bK2buwf0+ga1w=;
 b=hzJ6+SnoW8lY+KSRvWNZCNWAbSdcsOezhsQq2198AlMqgAZla4Bt/MIdGHCOQTz1A2
 m/Hza6D03uwL2fbuWVhiKNt8DYRcAzUYy1MVRw+h8LBatdjCOQos1nxiioUKiaIs0bDv
 Uu3FqUSZKoJJYgEVi7jJunHbfsLds4mS7sGz4ffxO75eDDGQB9+I3TfVJiJoyf3fc/zw
 sTWL9JIZ9pmuX5OcW0vGbilM+RYz9f30/4mnZGSJxBIzmdTNsAt0+9hrYL9t6irjoV/6
 BpXZk95S8NDzAEIcotuXULSiOXXS0sbsBC3JsYKec35b4LoygSBEly9xP4GFBRJc4tpn
 xRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9GhguyiRSp1UcskdHA85/bdqym1ln7bK2buwf0+ga1w=;
 b=Gj/9u6E6wCq+tuiPu224qs1qL8x/YNDl7PRIKl8PWlhsYkNhKtJdSi9qhulc004ns0
 oRwGejGbOmlqbRGxb+6aa8OnIS2bUCMdFiigOtOfyw65+VkIPLrkuMI4Gss4ha6NBrjP
 H3YN2uPV6eMLz7bhGLOyxRUya8DqPC4iC9XqjRM5eIqBSV/nicVDHXQ4qlu7J48uNKgN
 eD9/jdn7aNXaeEqbDg3ek2L+V848A6BB3Xq8zq4q66XxP8zHq/MqBjY3swJMp6xLw/BV
 zDyvucxmXZPWolVnJjE5F8n4MbtQh6GKDviJRytBvJuCorMpo/Rt0cS9PW/XrtY5eUkN
 vmUA==
X-Gm-Message-State: APjAAAXXkk+kdQ/j041gUPzUGoS1yOQd0YtNYqG7jAvoBerm2wbQCTxJ
 5wRycrjankJfnkyIbp7ieDObJPLE
X-Google-Smtp-Source: APXvYqyDm34vOXvc+akpMSr15Evynypkz7uCAE8C7iekYLeoRDPYbeG05gIZDLm21wz7iZRSrF8SCQ==
X-Received: by 2002:adf:e887:: with SMTP id d7mr4195010wrm.162.1578486794301; 
 Wed, 08 Jan 2020 04:33:14 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/38] hw/ppc/Kconfig: Only select FDT helper for machines
 using it
Date: Wed,  8 Jan 2020 13:32:34 +0100
Message-Id: <1578486775-52247-18-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Not all machines use the ppc_create_page_sizes_prop() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191231183216.6781-12-philmd@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/Kconfig       | 10 ++++++++++
 hw/ppc/Makefile.objs |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index e4ca920..8e62d8f 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -10,6 +10,7 @@ config PSERIES
     select XICS_SPAPR
     select XIVE_SPAPR
     select MSI_NONBROKEN
+    select FDT_PPC
 
 config SPAPR_RNG
     bool
@@ -26,6 +27,7 @@ config POWERNV
     select MC146818RTC
     select XICS
     select XIVE
+    select FDT_PPC
 
 config PPC405
     bool
@@ -42,6 +44,7 @@ config PPC440
     select PCI_EXPRESS
     select PPC4XX
     select SERIAL
+    select FDT_PPC
 
 config PPC4XX
     bool
@@ -60,6 +63,7 @@ config SAM460EX
     select SMBUS_EEPROM
     select USB_EHCI_SYSBUS
     select USB_OHCI
+    select FDT_PPC
 
 config PREP
     bool
@@ -110,6 +114,7 @@ config E500
     select PPCE500_PCI
     select SERIAL
     select MPC_I2C
+    select FDT_PPC
 
 config VIRTEX
     bool
@@ -118,6 +123,7 @@ config VIRTEX
     select SERIAL
     select XILINX
     select XILINX_ETHLITE
+    select FDT_PPC
 
 config XIVE
     bool
@@ -134,5 +140,9 @@ config XIVE_KVM
     default y
     depends on XIVE_SPAPR && KVM
 
+# Only used by 64-bit targets
 config FW_CFG_PPC
     bool
+
+config FDT_PPC
+    bool
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 5c46c68..a4bac57 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -1,5 +1,6 @@
 # shared objects
-obj-y += ppc.o ppc_booke.o fdt.o
+obj-y += ppc.o ppc_booke.o
+obj-$(CONFIG_FDT_PPC) += fdt.o
 obj-$(CONFIG_FW_CFG_PPC) += fw_cfg.o
 # IBM pSeries (sPAPR)
 obj-$(CONFIG_PSERIES) += spapr.o spapr_caps.o spapr_vio.o spapr_events.o
-- 
1.8.3.1



