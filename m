Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D967C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:44:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBECB20637
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n45C3qev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBECB20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZZb-0007fq-1M
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:44:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0L-0003hK-Fa
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0G-0003YG-FA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:01 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:35978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0G-0003Wz-85
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:56 -0500
Received: by mail-wm1-x334.google.com with SMTP id p17so2908786wma.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0qB5VNErbwXYjey+BfcoROqwOhQuwSAxSuLQbmDV+GY=;
 b=n45C3qev3c+V+JNlR5WH11Vi5ldhxbXMuw/SZ/IcjyrihczvsTD5qhCuA7LkW+6JR8
 1I7Ogu0ng1sKLCI7q9Kfyt4Z4217Tkwnp8dlDoIAnl9ToHgGhphtMR/LrxsSemhdqKXf
 H6PmZv7OZzmpwKB9Je6JsjG1iI1omRXGlXFDAw8F7oXgQB6rRx1JjspM06Sg7TOj0uk/
 a8AzizjEcoqKUeXXB7uDk4VpINXJhyi1UQZw9Fyocsp/mx+895rvfdyIxETWeta123El
 g+1zF3hYwfjlq71B3p9K0mQNmRcBVh4ovbzBLKI0SUfKYf6skBtSTzcFO+cw6RaMFfOQ
 swzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0qB5VNErbwXYjey+BfcoROqwOhQuwSAxSuLQbmDV+GY=;
 b=Bidilz15VUrgB7/RLTUeAcjx5yptr2wGV2FjIVdRz6KfJBCGvoZm4P7FFq7DRKCn89
 GIq9nSTIWtaVtjvz2iaSkHdPvldLA8z0qYUE6KWoxzebXe6Gjd5UjvYSXuEzT31qLL4r
 F8VoBjcopPYsIYL95Wp4fkKFmRcbyKGS4oBU+udNvRigTGEumdZOOzpjizBcvcM8SeFE
 dMjfqBqbVdpgxF3pd8mCCpUeRHCY/AqylIXcIi0ylRoN3Zi9pR963y/LYKb500aHMDTL
 JCcfzjL0SdEtZh3OLKKm3d+80z67wyaleywmr6CGCgyxTVL+dxzqn9aSq4HhfW64RFYc
 VDXg==
X-Gm-Message-State: APjAAAVZjpTr6Q4pV30BdYG7qxiLFhzBcxQHrp/U4oPYchQAWv+372F+
 JWDoXM+j1WgCH6ADE70xkzRAxq2/
X-Google-Smtp-Source: APXvYqzrrANnYGOFA0RTy9CnmfDeunXOFTUqVbldY/YOf8WjdQG6eqeWSzsy4Kq9VNfNZdPD6A1KPQ==
X-Received: by 2002:a1c:f60e:: with SMTP id w14mr4986915wmc.188.1582632473776; 
 Tue, 25 Feb 2020 04:07:53 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 120/136] scripts/cocci: Patch to let devices own their
 MemoryRegions
Date: Tue, 25 Feb 2020 13:07:18 +0100
Message-Id: <1582632454-16491-18-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-23-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 .../coccinelle/memory-region-housekeeping.cocci    | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/scripts/coccinelle/memory-region-housekeeping.cocci b/scripts/coccinelle/memory-region-housekeeping.cocci
index 5e6b31d..c768d81 100644
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
+  Object *obj = OBJECT(dev);
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
++ memory_region_init_ram_shared_nomigrate(E1, OBJECT(dev), E2, E3, E4, E5);
+)
+  ...+>
+}
-- 
1.8.3.1



