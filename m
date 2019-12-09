Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCD6C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 12:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167342077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 12:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bokS/HZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167342077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieIaw-00089P-4y
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 07:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ieIXK-0004SC-Nd
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 07:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ieIXJ-0003RQ-Lj
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 07:53:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45135
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ieIXJ-0003Qj-Hs
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 07:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575895993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2RFpp2s3aGUqR+t/+bn3Wx2jxQlWsovaH14QFwEROH8=;
 b=bokS/HZT+ZqzV9B22vktj2mA23mGLz8v0TIn70kYARfDfTR65SvJC9Kjrl0F3OpLiIxvKQ
 DOFUoR9IB1QXDwV+zsv6uF0biVMZ9WIAqqhE229bJYz/v8b26ho4EFaB/zBEWklurzvGh2
 9RjBDnMvnjGhlBrgiHdcul5jh8C0GUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-3EEiVgXYN_S2cTVyvVwVhw-1; Mon, 09 Dec 2019 07:53:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06202477;
 Mon,  9 Dec 2019 12:53:05 +0000 (UTC)
Received: from thuth.com (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FC496E3FD;
 Mon,  9 Dec 2019 12:53:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 4/4] hw/display: Remove "rombar" hack from vga-pci and
 vmware_vga
Date: Mon,  9 Dec 2019 13:52:48 +0100
Message-Id: <20191209125248.5849-5-thuth@redhat.com>
In-Reply-To: <20191209125248.5849-1-thuth@redhat.com>
References: <20191209125248.5849-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 3EEiVgXYN_S2cTVyvVwVhw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that the old pc-0.x machine types have been removed, we do not need
the old "rombar" hacks anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/display/vga-pci.c    | 5 -----
 hw/display/vga.c        | 4 +---
 hw/display/vmware_vga.c | 5 -----
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index a27b88122d..cfe095713e 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -264,11 +264,6 @@ static void pci_std_vga_realize(PCIDevice *dev, Error =
**errp)
=20
         pci_register_bar(&d->dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mm=
io);
     }
-
-    if (!dev->rom_bar) {
-        /* compatibility with pc-0.13 and older */
-        vga_init_vbe(s, OBJECT(dev), pci_address_space(dev));
-    }
 }
=20
 static void pci_std_vga_init(Object *obj)
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 82ebe53610..636586a476 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2304,9 +2304,7 @@ void vga_init(VGACommonState *s, Object *obj, MemoryR=
egion *address_space,
=20
 void vga_init_vbe(VGACommonState *s, Object *obj, MemoryRegion *system_mem=
ory)
 {
-    /* With pc-0.12 and below we map both the PCI BAR and the fixed VBE re=
gion,
-     * so use an alias to avoid double-mapping the same region.
-     */
+    /* Use an alias to avoid double-mapping the same region */
     memory_region_init_alias(&s->vram_vbe, obj, "vram.vbe",
                              &s->vram, 0, memory_region_size(&s->vram));
     /* XXX: use optimized standard vga accesses */
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 23dc8910cc..ead754eccf 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1312,11 +1312,6 @@ static void pci_vmsvga_realize(PCIDevice *dev, Error=
 **errp)
                      &s->chip.vga.vram);
     pci_register_bar(dev, 2, PCI_BASE_ADDRESS_MEM_PREFETCH,
                      &s->chip.fifo_ram);
-
-    if (!dev->rom_bar) {
-        /* compatibility with pc-0.13 and older */
-        vga_init_vbe(&s->chip.vga, OBJECT(dev), pci_address_space(dev));
-    }
 }
=20
 static Property vga_vmware_properties[] =3D {
--=20
2.18.1


