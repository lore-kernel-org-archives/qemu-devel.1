Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD739C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 06:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF1A215A4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 06:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZalNwXMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF1A215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j90vq-0004aV-Fl
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 01:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j90vE-000456-06
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 01:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j90v9-0005zW-Pg
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 01:20:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39189
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j90v9-0005zM-Ah
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 01:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583216446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A/eOvcKb8JVz1ZcZ5FOMoLl1euHQOYoYPOIh0aBaWBY=;
 b=ZalNwXMJliBmThI6t/QNIKpyjI/gPBdh/Gh9U6auKr2K8DgUw+6IkwfpASNr26Q9X38idn
 h6UW9hlSZnkNEYVrTr09Ws/c5vk0pUnRAjKVOeSULbFIlUphvPmsLCRGGz6Ms/zg0m3/2r
 UgkT56cuI071rwZ+pzlc4Iwnx042+JI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-q28ttkMLOTeYZIpfM5O6dA-1; Tue, 03 Mar 2020 01:20:44 -0500
X-MC-Unique: q28ttkMLOTeYZIpfM5O6dA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FE2619067E0;
 Tue,  3 Mar 2020 06:20:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-150.ams2.redhat.com
 [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 862CC8C09A;
 Tue,  3 Mar 2020 06:20:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C061417535; Tue,  3 Mar 2020 07:20:39 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] bochs-display: add dummy mmio handler
Date: Tue,  3 Mar 2020 07:20:39 +0100
Message-Id: <20200303062039.26941-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Cc: Alistair Francis <alistair23@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/bochs-display.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 62085f9fc063..e93e838243b8 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -151,6 +151,26 @@ static const MemoryRegionOps bochs_display_qext_ops =
=3D {
     .endianness =3D DEVICE_LITTLE_ENDIAN,
 };
=20
+static uint64_t dummy_read(void *ptr, hwaddr addr, unsigned size)
+{
+    return -1;
+}
+
+static void dummy_write(void *ptr, hwaddr addr,
+                        uint64_t val, unsigned size)
+{
+}
+
+static const MemoryRegionOps dummy_ops =3D {
+    .read =3D dummy_read,
+    .write =3D dummy_write,
+    .valid.min_access_size =3D 1,
+    .valid.max_access_size =3D 4,
+    .impl.min_access_size =3D 1,
+    .impl.max_access_size =3D 1,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+};
+
 static int bochs_display_get_mode(BochsDisplayState *s,
                                    BochsDisplayMode *mode)
 {
@@ -284,8 +304,8 @@ static void bochs_display_realize(PCIDevice *dev, Error=
 **errp)
     memory_region_init_io(&s->qext, obj, &bochs_display_qext_ops, s,
                           "qemu extended regs", PCI_VGA_QEXT_SIZE);
=20
-    memory_region_init(&s->mmio, obj, "bochs-display-mmio",
-                       PCI_VGA_MMIO_SIZE);
+    memory_region_init_io(&s->mmio, obj, &dummy_ops, NULL,
+                          "bochs-display-mmio", PCI_VGA_MMIO_SIZE);
     memory_region_add_subregion(&s->mmio, PCI_VGA_BOCHS_OFFSET, &s->vbe);
     memory_region_add_subregion(&s->mmio, PCI_VGA_QEXT_OFFSET, &s->qext);
=20
--=20
2.18.2


