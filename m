Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E95EC2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E070F2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIIBTS+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E070F2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDqwt-0004Zu-JM
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 10:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jDpAT-0004Vf-1M
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jDpAR-0004oX-Ug
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:48:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46502
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jDpAR-0004j1-P4
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584362907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TlPyNwnohSBBRgqa9xzMvhZb4FmYT1Lu8PWrE8MRHfs=;
 b=AIIBTS+zThjmRug4b98dLI4Qo6FI640K1z2oPktv7a75Lq/hLOM+KXBkokBoz/ksvIOy89
 l4wyiebBX3H5QhwIp/RyapLaNDldkZp9PRLWyewVpgFU0dutI8CPTju3CecXCCXjo20UlN
 7mTkKc/Ndll6WsI5Z2pPtI+JuJ8fTOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171--V6Pol5KN_2LdFuHk7tbog-1; Mon, 16 Mar 2020 08:48:25 -0400
X-MC-Unique: -V6Pol5KN_2LdFuHk7tbog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DCF9800D4E;
 Mon, 16 Mar 2020 12:48:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-117.ams2.redhat.com
 [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F36B7388E;
 Mon, 16 Mar 2020 12:48:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 73F439D13; Mon, 16 Mar 2020 13:48:20 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] stdvga+bochs-display: add dummy mmio handler
Date: Mon, 16 Mar 2020 13:48:20 +0100
Message-Id: <20200316124820.22063-2-kraxel@redhat.com>
In-Reply-To: <20200316124820.22063-1-kraxel@redhat.com>
References: <20200316124820.22063-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Alistair Francis <alistair23@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The bochs-display mmio bar has some sub-regions with the actual hardware
registers.  What happens when the guest access something outside those
regions depends on the archirecture.  On x86 those reads succeed (and
return 0xff I think).  On risc-v qemu aborts.

This patch adds handlers for the parent region, to make the wanted
behavior explicit and to make things consistent across architectures.

v2:
 - use existing unassigned_io_ops.
 - also cover stdvga.

Cc: Alistair Francis <alistair23@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20200309100009.17624-1-kraxel@redhat.com
---
 hw/display/bochs-display.c | 4 ++--
 hw/display/vga-pci.c       | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 62085f9fc063..70eb619ef424 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -284,8 +284,8 @@ static void bochs_display_realize(PCIDevice *dev, Error=
 **errp)
     memory_region_init_io(&s->qext, obj, &bochs_display_qext_ops, s,
                           "qemu extended regs", PCI_VGA_QEXT_SIZE);
=20
-    memory_region_init(&s->mmio, obj, "bochs-display-mmio",
-                       PCI_VGA_MMIO_SIZE);
+    memory_region_init_io(&s->mmio, obj, &unassigned_io_ops, NULL,
+                          "bochs-display-mmio", PCI_VGA_MMIO_SIZE);
     memory_region_add_subregion(&s->mmio, PCI_VGA_BOCHS_OFFSET, &s->vbe);
     memory_region_add_subregion(&s->mmio, PCI_VGA_QEXT_OFFSET, &s->qext);
=20
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index b34632467399..6b9db86e363c 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -249,8 +249,8 @@ static void pci_std_vga_realize(PCIDevice *dev, Error *=
*errp)
=20
     /* mmio bar for vga register access */
     if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_MMIO)) {
-        memory_region_init(&d->mmio, NULL, "vga.mmio",
-                           PCI_VGA_MMIO_SIZE);
+        memory_region_init_io(&d->mmio, OBJECT(dev), &unassigned_io_ops, N=
ULL,
+                              "vga.mmio", PCI_VGA_MMIO_SIZE);
=20
         if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_QEXT)) {
             qext =3D true;
@@ -285,8 +285,8 @@ static void pci_secondary_vga_realize(PCIDevice *dev, E=
rror **errp)
     s->con =3D graphic_console_init(DEVICE(dev), 0, s->hw_ops, s);
=20
     /* mmio bar */
-    memory_region_init(&d->mmio, OBJECT(dev), "vga.mmio",
-                       PCI_VGA_MMIO_SIZE);
+    memory_region_init_io(&d->mmio, OBJECT(dev), &unassigned_io_ops, NULL,
+                          "vga.mmio", PCI_VGA_MMIO_SIZE);
=20
     if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_QEXT)) {
         qext =3D true;
--=20
2.18.2


