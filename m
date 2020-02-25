Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2FAC35DF2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 06:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BFD221556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 06:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGBLby8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFD221556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6TGk-0004B6-8L
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 01:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j6TFl-0003Ig-Vf
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 00:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j6TFk-00009J-NP
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 00:59:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52851
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j6TFk-000094-J5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 00:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582610372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K4/aU3VUKizu3sH9DiMts25fFFuGSDG6AwVgPLEjEOU=;
 b=IGBLby8OwIZ3aKZVi++7s2326J5SsfY9C2YnnPlQRxKZiUgu7n+GRvVh6sUvkgEswKvyuk
 GzH91vgD3HP2LrPbOUWfsAnJh1Wde6Ua/6/63QhMqAYsAHeWQ9BsjDnuw+LlMlHx7LIehn
 ajyzrmv/s6UKg587lfEwl8YtwDhLEws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-GxckEK3kNYK0uFSjBvTprA-1; Tue, 25 Feb 2020 00:59:28 -0500
X-MC-Unique: GxckEK3kNYK0uFSjBvTprA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B5641857354;
 Tue, 25 Feb 2020 05:59:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-87.ams2.redhat.com
 [10.36.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 957641001DC2;
 Tue, 25 Feb 2020 05:59:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8E4839D25; Tue, 25 Feb 2020 06:59:20 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] qxl: drop shadow_rom
Date: Tue, 25 Feb 2020 06:59:20 +0100
Message-Id: <20200225055920.17261-3-kraxel@redhat.com>
In-Reply-To: <20200225055920.17261-1-kraxel@redhat.com>
References: <20200225055920.17261-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: sstabellini@kernel.org, pmatouse@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, mdroth@linux.vnet.ibm.com,
 ppandit@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that the rom bar is mapped read-only and the guest can't change
things under our feet we don't need the shadow rom any more.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/qxl.h |  2 +-
 hw/display/qxl.c | 25 +++++++++----------------
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index 707631a1f573..3aedc7db5da0 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -95,11 +95,11 @@ typedef struct PCIQXLDevice {
     uint32_t           vgamem_size;
=20
     /* rom pci bar */
-    QXLRom             shadow_rom;
     QXLRom             *rom;
     QXLModes           *modes;
     uint32_t           rom_size;
     MemoryRegion       rom_bar;
+    uint32_t           rom_mode;
 #if SPICE_SERVER_VERSION >=3D 0x000c06 /* release 0.12.6 */
     uint16_t           max_outputs;
 #endif
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 227da69a50d9..0502802688f9 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -391,7 +391,6 @@ static void init_qxl_rom(PCIQXLDevice *d)
             sizeof(rom->client_monitors_config));
     }
=20
-    d->shadow_rom =3D *rom;
     d->rom        =3D rom;
     d->modes      =3D modes;
 }
@@ -403,7 +402,7 @@ static void init_qxl_ram(PCIQXLDevice *d)
     QXLReleaseRing *ring;
=20
     buf =3D d->vga.vram_ptr;
-    d->ram =3D (QXLRam *)(buf + le32_to_cpu(d->shadow_rom.ram_header_offse=
t));
+    d->ram =3D (QXLRam *)(buf + le32_to_cpu(d->rom->ram_header_offset));
     d->ram->magic       =3D cpu_to_le32(QXL_RAM_MAGIC);
     d->ram->int_pending =3D cpu_to_le32(0);
     d->ram->int_mask    =3D cpu_to_le32(0);
@@ -446,7 +445,7 @@ static void qxl_ram_set_dirty(PCIQXLDevice *qxl, void *=
ptr)
 /* can be called from spice server thread context */
 static void qxl_ring_set_dirty(PCIQXLDevice *qxl)
 {
-    ram_addr_t addr =3D qxl->shadow_rom.ram_header_offset;
+    ram_addr_t addr =3D qxl->rom->ram_header_offset;
     ram_addr_t end  =3D qxl->vga.vram_size;
     qxl_set_dirty(&qxl->vga.vram, addr, end);
 }
@@ -529,7 +528,6 @@ static void interface_set_compression_level(QXLInstance=
 *sin, int level)
     PCIQXLDevice *qxl =3D container_of(sin, PCIQXLDevice, ssd.qxl);
=20
     trace_qxl_interface_set_compression_level(qxl->id, level);
-    qxl->shadow_rom.compression_level =3D cpu_to_le32(level);
     qxl->rom->compression_level =3D cpu_to_le32(level);
     qxl_rom_set_dirty(qxl);
 }
@@ -561,7 +559,7 @@ static void interface_get_init_info(QXLInstance *sin, Q=
XLDevInitInfo *info)
     info->num_memslots_groups =3D NUM_MEMSLOTS_GROUPS;
     info->internal_groupslot_id =3D 0;
     info->qxl_ram_size =3D
-        le32_to_cpu(qxl->shadow_rom.num_pages) << QXL_PAGE_BITS;
+        le32_to_cpu(qxl->rom->num_pages) << QXL_PAGE_BITS;
     info->n_surfaces =3D qxl->ssd.num_surfaces;
 }
=20
@@ -1035,9 +1033,6 @@ static void interface_set_client_capabilities(QXLInst=
ance *sin,
         return;
     }
=20
-    qxl->shadow_rom.client_present =3D client_present;
-    memcpy(qxl->shadow_rom.client_capabilities, caps,
-           sizeof(qxl->shadow_rom.client_capabilities));
     qxl->rom->client_present =3D client_present;
     memcpy(qxl->rom->client_capabilities, caps,
            sizeof(qxl->rom->client_capabilities));
@@ -1232,11 +1227,8 @@ static void qxl_check_state(PCIQXLDevice *d)
=20
 static void qxl_reset_state(PCIQXLDevice *d)
 {
-    QXLRom *rom =3D d->rom;
-
     qxl_check_state(d);
-    d->shadow_rom.update_id =3D cpu_to_le32(0);
-    *rom =3D d->shadow_rom;
+    d->rom->update_id =3D cpu_to_le32(0);
     qxl_rom_set_dirty(d);
     init_qxl_ram(d);
     d->num_free_res =3D 0;
@@ -1600,7 +1592,7 @@ static void qxl_set_mode(PCIQXLDevice *d, unsigned in=
t modenr, int loadvm)
         .format     =3D SPICE_SURFACE_FMT_32_xRGB,
         .flags      =3D loadvm ? QXL_SURF_FLAG_KEEP_DATA : 0,
         .mouse_mode =3D true,
-        .mem        =3D devmem + d->shadow_rom.draw_area_offset,
+        .mem        =3D devmem + d->rom->draw_area_offset,
     };
=20
     trace_qxl_set_mode(d->id, modenr, mode->x_res, mode->y_res, mode->bits=
,
@@ -1620,7 +1612,6 @@ static void qxl_set_mode(PCIQXLDevice *d, unsigned in=
t modenr, int loadvm)
     if (mode->bits =3D=3D 16) {
         d->cmdflags |=3D QXL_COMMAND_FLAG_COMPAT_16BPP;
     }
-    d->shadow_rom.mode =3D cpu_to_le32(modenr);
     d->rom->mode =3D cpu_to_le32(modenr);
     qxl_rom_set_dirty(d);
 }
@@ -2277,6 +2268,7 @@ static int qxl_pre_save(void *opaque)
         d->last_release_offset =3D (uint8_t *)d->last_release - ram_start;
     }
     assert(d->last_release_offset < d->vga.vram_size);
+    d->rom_mode =3D d->rom->mode;
=20
     return 0;
 }
@@ -2316,6 +2308,7 @@ static int qxl_post_load(void *opaque, int version)
     } else {
         d->last_release =3D (QXLReleaseInfo *)(ram_start + d->last_release=
_offset);
     }
+    d->rom->mode =3D d->rom_mode;
=20
     d->modes =3D (QXLModes*)((uint8_t*)d->rom + d->rom->modes_offset);
=20
@@ -2361,7 +2354,7 @@ static int qxl_post_load(void *opaque, int version)
     case QXL_MODE_COMPAT:
         /* note: no need to call qxl_create_memslots, qxl_set_mode
          * creates the mem slot. */
-        qxl_set_mode(d, d->shadow_rom.mode, 1);
+        qxl_set_mode(d, d->rom->mode, 1);
         break;
     }
     return 0;
@@ -2428,7 +2421,7 @@ static VMStateDescription qxl_vmstate =3D {
     .fields =3D (VMStateField[]) {
         VMSTATE_PCI_DEVICE(pci, PCIQXLDevice),
         VMSTATE_STRUCT(vga, PCIQXLDevice, 0, vmstate_vga_common, VGACommon=
State),
-        VMSTATE_UINT32(shadow_rom.mode, PCIQXLDevice),
+        VMSTATE_UINT32(rom_mode, PCIQXLDevice),
         VMSTATE_UINT32(num_free_res, PCIQXLDevice),
         VMSTATE_UINT32(last_release_offset, PCIQXLDevice),
         VMSTATE_UINT32(mode, PCIQXLDevice),
--=20
2.18.2


