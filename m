Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2772C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 07:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703C02071E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 07:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ZOxetxmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703C02071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieDg9-0003RH-Gq
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 02:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ieDfR-0002dV-1y
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:41:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ieDfO-0001CJ-6L
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:41:15 -0500
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:50032)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1ieDfN-0001BY-Et
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:41:14 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id CA0842E09A5;
 Mon,  9 Dec 2019 10:41:09 +0300 (MSK)
Received: from myt4-4db2488e778a.qloud-c.yandex.net
 (myt4-4db2488e778a.qloud-c.yandex.net [2a02:6b8:c00:884:0:640:4db2:488e])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 b8HKWnlVRO-f9mSDuuv; Mon, 09 Dec 2019 10:41:09 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1575877269; bh=bYDR1mzBxxvaAQmyGDZl3cZpnoKhPfpTrf6HPortYD8=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=ZOxetxmKPGKCLmbsBNmti+Vu5HTrdl9RoxTyHbmgkSvdw5zO7zI0dKKX6h6s1/Cub
 9WkN13X92VP2kXCujQmdEumUo7jhT8PZ8P1Pb9XjTBDP4J0JVchgLCa95TA+MWMmrp
 QOULx/0mTWcnL6egzwes0RyZSx4PMZsxsCO+riJc=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:2c54:c0fb:a18c:48a0])
 by myt4-4db2488e778a.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 dqiMOlYtgw-f9Yq5ZE4; Mon, 09 Dec 2019 10:41:09 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/1] migration: Remove vmstate_unregister_ram
Date: Mon,  9 Dec 2019 10:41:02 +0300
Message-Id: <20191209074102.5926-2-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209074102.5926-1-yury-kotov@yandex-team.ru>
References: <20191209074102.5926-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1a2d::193
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, yc-core@yandex-team.ru,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Disclaimer: This is just an RFC.
It's more an illustration-patch than real patch. And I didn't verify the
possible side effects!

Currently, it's possible to call this function during migration.
And so, to have a race condition between migration thread and main
thread.

It seems that all calls of this function are just before
MemoryRegion deletion. Thus, there is no effect of this function
actually.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 hw/block/pflash_cfi01.c     | 1 -
 hw/block/pflash_cfi02.c     | 1 -
 hw/mem/pc-dimm.c            | 5 -----
 hw/misc/ivshmem.c           | 2 --
 hw/pci/pci.c                | 1 -
 include/migration/vmstate.h | 1 -
 migration/savevm.c          | 6 ------
 7 files changed, 17 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 54e6ebd385..1d0cc9e576 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -763,7 +763,6 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
     if (pfl->blk) {
         if (!blk_check_size_and_read_all(pfl->blk, pfl->storage, total_l=
en,
                                          errp)) {
-            vmstate_unregister_ram(&pfl->mem, DEVICE(pfl));
             return;
         }
     }
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index c7d92c3e79..1abe1120bf 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -810,7 +810,6 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
     if (pfl->blk) {
         if (!blk_check_size_and_read_all(pfl->blk, pfl->storage,
                                          pfl->chip_len, errp)) {
-            vmstate_unregister_ram(&pfl->orig_mem, DEVICE(pfl));
             return;
         }
     }
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 99e2faf01b..f8cb5233ee 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -76,12 +76,7 @@ void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *ma=
chine, Error **errp)
=20
 void pc_dimm_unplug(PCDIMMDevice *dimm, MachineState *machine)
 {
-    PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *vmstate_mr =3D ddc->get_vmstate_memory_region(dimm,
-                                                              &error_abo=
rt);
-
     memory_device_unplug(MEMORY_DEVICE(dimm), machine);
-    vmstate_unregister_ram(vmstate_mr, DEVICE(dimm));
 }
=20
 static int pc_dimm_slot2bitmap(Object *obj, void *opaque)
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 5e3b05eae0..f31e313dec 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -973,8 +973,6 @@ static void ivshmem_exit(PCIDevice *dev)
             fd =3D memory_region_get_fd(s->ivshmem_bar2);
             close(fd);
         }
-
-        vmstate_unregister_ram(s->ivshmem_bar2, DEVICE(dev));
     }
=20
     if (s->hostmem) {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index cbc7a32568..8a719e2bfa 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2371,7 +2371,6 @@ static void pci_del_option_rom(PCIDevice *pdev)
     if (!pdev->has_rom)
         return;
=20
-    vmstate_unregister_ram(&pdev->rom, &pdev->qdev);
     pdev->has_rom =3D false;
 }
=20
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index ac4f46a67d..f298de44a7 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1176,7 +1176,6 @@ void vmstate_unregister(DeviceState *dev, const VMS=
tateDescription *vmsd,
=20
 struct MemoryRegion;
 void vmstate_register_ram(struct MemoryRegion *memory, DeviceState *dev)=
;
-void vmstate_unregister_ram(struct MemoryRegion *memory, DeviceState *de=
v);
 void vmstate_register_ram_global(struct MemoryRegion *memory);
=20
 bool vmstate_check_only_migratable(const VMStateDescription *vmsd);
diff --git a/migration/savevm.c b/migration/savevm.c
index a71b930b91..4b3a7b1b76 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2915,12 +2915,6 @@ void vmstate_register_ram(MemoryRegion *mr, Device=
State *dev)
     qemu_ram_set_migratable(mr->ram_block);
 }
=20
-void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
-{
-    qemu_ram_unset_idstr(mr->ram_block);
-    qemu_ram_unset_migratable(mr->ram_block);
-}
-
 void vmstate_register_ram_global(MemoryRegion *mr)
 {
     vmstate_register_ram(mr, NULL);
--=20
2.24.0


