Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E9AC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 20:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948CD206D9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 20:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDKB71U5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948CD206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYFSZ-0003fQ-PM
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 16:55:35 -0400
Received: from [2001:470:142:3::10] (port=35518 helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYFQg-0001QJ-25
 for qemu-devel@nongnu.org; Mon, 11 May 2020 16:53:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55754
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYFQC-0005NE-8B
 for qemu-devel@nongnu.org; Mon, 11 May 2020 16:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589230373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ApfKdlbM1fYSPPea3LqjcLYgAh8qqScfosbbY+F3O8c=;
 b=aDKB71U5kDVXXM0UdUi0aMu2UtDHZZbG88eAqXS62499VFCeA7hOMRl/0Ik60FY1MJJMt+
 ZaPzMAULEO2XVggIMEldATmPx+Fp4f/hiAi0oh4/xzyfm6GVCTqdC11aCGb4X+gM6DsyWy
 lnz8wiwynr2fVJcGRe6jdPhvsoIuxUc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-rcIrXFoXNNOvJICt_lSucg-1; Mon, 11 May 2020 16:52:51 -0400
X-MC-Unique: rcIrXFoXNNOvJICt_lSucg-1
Received: by mail-wm1-f70.google.com with SMTP id k17so1144207wmi.4
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 13:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ApfKdlbM1fYSPPea3LqjcLYgAh8qqScfosbbY+F3O8c=;
 b=HAp2Z8vTKVOoJfZh1s/ndpLUZppNVT4h808cjkD3zMwdtw4NCR/M5XbOWlWeuswcO/
 D4gCsBFtzsa7ice4jAhjlfN4sbnX/o9G72mFY4BGhF5+d1Yo8Ogiz0/m9DdJGfYeZ3BJ
 3NsOtYOkoHydHOeBQP5n+KSsvAY8EUJ8uZ0GHtm4MM79xc8Q6MgHJJCg+n7bWIBh2OkH
 gG1kpMpA4duYlnJBTe9XCKTC88VdvHFmHpqoJ5KDWaeBV4xbXMwygLJ5fsQOWPC4E93y
 fb8thG/gOns/dBTDjkhqKFr5P4nMpb5G6jfbbD/D2dRxioZElSl0hrHqSD8UygOFGSpp
 9hUg==
X-Gm-Message-State: AGi0PuZeWsL7mNyRkjPkwLCPf4MtHF4OjZLyHUnwFTvIVkpVMKutAUkX
 /jDxzFbDLtsiJaM071JYLi53Y9BTZHfH/P/wpt04OlKpnWTQUBVPAYFNlFpBaO08acRL1SqMoQf
 ZByVRVGYmfp1FgYI=
X-Received: by 2002:a05:600c:2284:: with SMTP id
 4mr31952890wmf.97.1589230370232; 
 Mon, 11 May 2020 13:52:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypLxklPLpuZTPVF0u2g4c+16ffWLe2GRQPom07O+sxDhg3Ms4hzoQL1zsAT6ViIYBBObWOom9w==
X-Received: by 2002:a05:600c:2284:: with SMTP id
 4mr31952847wmf.97.1589230369854; 
 Mon, 11 May 2020 13:52:49 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id k5sm18146092wrx.16.2020.05.11.13.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 13:52:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw: Use QEMU_IS_ALIGNED() on parallel flash block size
Date: Mon, 11 May 2020 22:52:46 +0200
Message-Id: <20200511205246.24621-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 T_DKIM_INVALID=0.01, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-arm@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <leif@nuviainc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the QEMU_IS_ALIGNED() macro to verify the flash block size
is properly aligned. It is quicker to process when reviewing.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/sbsa-ref.c       | 2 +-
 hw/arm/virt.c           | 2 +-
 hw/block/pflash_cfi01.c | 2 +-
 hw/block/pflash_cfi02.c | 2 +-
 hw/i386/pc_sysfw.c      | 2 +-
 hw/riscv/virt.c         | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 8409ba853d..b379e4a76a 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -241,7 +241,7 @@ static void sbsa_flash_map1(PFlashCFI01 *flash,
 {
     DeviceState *dev = DEVICE(flash);
 
-    assert(size % SBSA_FLASH_SECTOR_SIZE == 0);
+    assert(QEMU_IS_ALIGNED(size, SBSA_FLASH_SECTOR_SIZE));
     assert(size / SBSA_FLASH_SECTOR_SIZE <= UINT32_MAX);
     qdev_prop_set_uint32(dev, "num-blocks", size / SBSA_FLASH_SECTOR_SIZE);
     qdev_init_nofail(dev);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 634db0cfe9..0a99fddb3d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -978,7 +978,7 @@ static void virt_flash_map1(PFlashCFI01 *flash,
 {
     DeviceState *dev = DEVICE(flash);
 
-    assert(size % VIRT_FLASH_SECTOR_SIZE == 0);
+    assert(QEMU_IS_ALIGNED(size, VIRT_FLASH_SECTOR_SIZE));
     assert(size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
     qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZE);
     qdev_init_nofail(dev);
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index f586bac269..11922c0f96 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -964,7 +964,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
     if (blk) {
         qdev_prop_set_drive(dev, "drive", blk, &error_abort);
     }
-    assert(size % sector_len == 0);
+    assert(QEMU_IS_ALIGNED(size, sector_len));
     qdev_prop_set_uint32(dev, "num-blocks", size / sector_len);
     qdev_prop_set_uint64(dev, "sector-length", sector_len);
     qdev_prop_set_uint8(dev, "width", bank_width);
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index c6b6f2d082..895f7daee3 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -1003,7 +1003,7 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
     if (blk) {
         qdev_prop_set_drive(dev, "drive", blk, &error_abort);
     }
-    assert(size % sector_len == 0);
+    assert(QEMU_IS_ALIGNED(size, sector_len));
     qdev_prop_set_uint32(dev, "num-blocks", size / sector_len);
     qdev_prop_set_uint32(dev, "sector-length", sector_len);
     qdev_prop_set_uint8(dev, "width", width);
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index f5f3f466b0..fad41f0e73 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -168,7 +168,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
                          blk_name(blk), strerror(-size));
             exit(1);
         }
-        if (size == 0 || size % FLASH_SECTOR_SIZE != 0) {
+        if (size == 0 || !QEMU_IS_ALIGNED(size, FLASH_SECTOR_SIZE)) {
             error_report("system firmware block device %s has invalid size "
                          "%" PRId64,
                          blk_name(blk), size);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index daae3ebdbb..71481d59c2 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -112,7 +112,7 @@ static void virt_flash_map1(PFlashCFI01 *flash,
 {
     DeviceState *dev = DEVICE(flash);
 
-    assert(size % VIRT_FLASH_SECTOR_SIZE == 0);
+    assert(QEMU_IS_ALIGNED(size, VIRT_FLASH_SECTOR_SIZE));
     assert(size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
     qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZE);
     qdev_init_nofail(dev);
-- 
2.21.3


