Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEB6C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F9D720674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ml3q88ml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9D720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvFB-0004uB-DJ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDups-0001JF-FT
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDupr-0008OJ-9I
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39251)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDupr-0008Mh-4r
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PnTiznQbcjSITmlrC8f0MwivspPIOZv0h5wAVkTgkTc=;
 b=Ml3q88mlKS3Df5R1wT1AsPJL+LVBkjN3Ihfdc8dKXk514k7PDhIMJrUmoGcTN/U2FgMXtq
 3q1iAQp/AwpWNh0bl+ADLMEo1EwmJXUZyW44A1uUsD8reEpmU/Ml5CR9oOOSA9V1QNnfo1
 UFP+xhlR/sUDf1wRNLKl52aDByk2Yiw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-mpECr7nXNgK8D7A29tNcCA-1; Mon, 16 Mar 2020 14:51:33 -0400
X-MC-Unique: mpECr7nXNgK8D7A29tNcCA-1
Received: by mail-wr1-f72.google.com with SMTP id w11so9465380wrp.20
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=04xeP5EixbpWsJm6lJ8qB4mcyVbq8ONy8Rtl0nbrdFA=;
 b=eMyw0lYrE+rb87OccotAxpkC2bFhd1PffR3lf4PhDnjjN8aNOd8vkrCPg74/c3kqPZ
 gZvff+2gPk3YyaWRHfqqmgkJvrrwU+fC9M7ic3ehNhZWACa7xMyIOTmlOFUGQ+d4heOj
 zWQ+M3+2SNtEXRAFwM5x16Zt4aekG1RZk0oLb3Inw9EGYx+Fkf1tH8Ka0ZFYOooWNVwX
 x6PTAd6GlKVaDYf04roMkrs3G5gITqgEbeupY8dg+T2RRq+Fzj9F/UMDPiLApxhZdE/l
 sHeKZ1l9p324tMNbzE4IVq1ogkzNfgTiZ5LmVYesBGUkmMDCuXlzq1D6PQOEZKXpOxTG
 grLA==
X-Gm-Message-State: ANhLgQ2xPFcIhUYNYVEQE7jZdA4R3BvJgoYGZ8H+YV7byb31kpGs7Bty
 X7KzE6rguU546IKVN0AFw2YF0ryCLXRKL8VKYGsvXEpmsDEhqjABiEFZLkS0oLjtopPiKLLZMij
 kFLtKAFoZ4EVXuGw=
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr525852wmh.17.1584384691714;
 Mon, 16 Mar 2020 11:51:31 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs5XMd9dWXI5/5mbyYuh2ZFc0lUCEk7bLwWAUlQSiKmR6i7d0sJHuxSLYEAXyyiuMXUqIb20g==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr525833wmh.17.1584384691447;
 Mon, 16 Mar 2020 11:51:31 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id b4sm747590wmj.12.2020.03.16.11.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:51:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 16/25] scripts/cocci: Patch to let devices own their
 MemoryRegions
Date: Mon, 16 Mar 2020 19:49:57 +0100
Message-Id: <20200316185006.576-17-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316185006.576-1-philmd@redhat.com>
References: <20200316185006.576-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a device creates a MemoryRegion without setting its ownership,
the MemoryRegion is added to the machine "/unattached" container in
the QOM tree.

Example with the Samsung SMDKC210 board:

  $ arm-softmmu/qemu-system-arm -M smdkc210 -S -monitor stdio
  (qemu) info qom-tree
  /machine (smdkc210-machine)
    /unattached (container)
      /io[0] (qemu:memory-region)
      /exynos4210.dram0[0] (qemu:memory-region)
      /exynos4210.irom[0] (qemu:memory-region)
      /exynos4210.iram[0] (qemu:memory-region)
      /exynos4210.chipid[0] (qemu:memory-region)
      ...
      /device[26] (exynos4210.uart)
        /exynos4210.uart[0] (qemu:memory-region)
    /soc (exynos4210)
      ^
       \__ [*]

The irom/iram/chipid regions should go under 'soc' at [*].

Add a semantic patch to let the device own the memory region.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .../memory-region-housekeeping.cocci          | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/scripts/coccinelle/memory-region-housekeeping.cocci b/scripts/=
coccinelle/memory-region-housekeeping.cocci
index 5e6b31d8ba..c768d8140a 100644
--- a/scripts/coccinelle/memory-region-housekeeping.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -101,3 +101,59 @@ expression ERRP;
 +memory_region_init_rom_device(MR, NULL, OPS, OPAQUE, NAME, SIZE, ERRP);
  ...
 -vmstate_register_ram_global(MR);
+
+
+// Device is owner
+@@
+typedef DeviceState;
+identifier device_fn, dev, obj;
+expression E1, E2, E3, E4, E5;
+@@
+static void device_fn(DeviceState *dev, ...)
+{
+  ...
+  Object *obj =3D OBJECT(dev);
+  <+...
+(
+- memory_region_init(E1, NULL, E2, E3);
++ memory_region_init(E1, obj, E2, E3);
+|
+- memory_region_init_io(E1, NULL, E2, E3, E4, E5);
++ memory_region_init_io(E1, obj, E2, E3, E4, E5);
+|
+- memory_region_init_alias(E1, NULL, E2, E3, E4, E5);
++ memory_region_init_alias(E1, obj, E2, E3, E4, E5);
+|
+- memory_region_init_rom(E1, NULL, E2, E3, E4);
++ memory_region_init_rom(E1, obj, E2, E3, E4);
+|
+- memory_region_init_ram_shared_nomigrate(E1, NULL, E2, E3, E4, E5);
++ memory_region_init_ram_shared_nomigrate(E1, obj, E2, E3, E4, E5);
+)
+  ...+>
+}
+@@
+identifier device_fn, dev;
+expression E1, E2, E3, E4, E5;
+@@
+static void device_fn(DeviceState *dev, ...)
+{
+  <+...
+(
+- memory_region_init(E1, NULL, E2, E3);
++ memory_region_init(E1, OBJECT(dev), E2, E3);
+|
+- memory_region_init_io(E1, NULL, E2, E3, E4, E5);
++ memory_region_init_io(E1, OBJECT(dev), E2, E3, E4, E5);
+|
+- memory_region_init_alias(E1, NULL, E2, E3, E4, E5);
++ memory_region_init_alias(E1, OBJECT(dev), E2, E3, E4, E5);
+|
+- memory_region_init_rom(E1, NULL, E2, E3, E4);
++ memory_region_init_rom(E1, OBJECT(dev), E2, E3, E4);
+|
+- memory_region_init_ram_shared_nomigrate(E1, NULL, E2, E3, E4, E5);
++ memory_region_init_ram_shared_nomigrate(E1, OBJECT(dev), E2, E3, E4, E5)=
;
+)
+  ...+>
+}
--=20
2.21.1


