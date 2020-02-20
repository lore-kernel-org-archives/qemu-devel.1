Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8A3C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26234208C4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+e4Abv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26234208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4leE-0001MX-Ak
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lXJ-0005P2-EM
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lXH-0005Ij-QH
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52498
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lXH-0005I3-LY
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582203995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vu5bnXCWmoR0uDiabSQGY0CwtpVH4vjEupEa47euXok=;
 b=B+e4Abv//ugZdLn38Zqbu49kfI3GmQc/vdGlllKKIzcUl6wBkv0Wl/pcH73IVlaupm4qzw
 ufJcmdYRMlVkfwMaYinNt/J2hto8QV6N+iqmLSUEIcAtHzGWzz7E+7PIIa51YklWgv451p
 rSeo7ZP4O/pxvOzG7m6qR6WICjC8UXQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-sDINMfaHM7C8TOknOsZeOg-1; Thu, 20 Feb 2020 08:06:33 -0500
Received: by mail-wm1-f69.google.com with SMTP id o24so809972wmh.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/ld+m5dlIbdFkFHFURC0jskPtvz279hvl5fOCIwyBcI=;
 b=iz81IWHMbcQA15/B1SzdcmXuwIIaQN2xvWoMBFz05aODEJpswpX/hHRnvtETpV67dU
 9pP14VhSN0e70zWyrzIHSJtl00FySfU6/R5LQ5+vkDgzu3vPnbhSBZBwPgnVDM32W12b
 y7RrjyApRCi5yunILnK7EBZKHZwLSKT6MSlNYxltcIWLvH9NoceJTwB23LTSRDbWDqry
 5PUrJ/CBN9tXedGr8AO1lS2KIWFNTLqpvi7R6Xyxk7Q7M/Kfx7kvxfz0r1zIdvEHRfxy
 5xccO7CPvaFYeu3eItEoOSsaISlebkl0JKhSPPCaJoylXcInch/N4WWDsDir5x4igYQL
 OoNw==
X-Gm-Message-State: APjAAAVav1Kq6eTelMmzmjsFz9G1NXUbIFUgaRij6lS7BrGvkhCYFC/L
 5HWhnI5/8Oi0RB4LulpeHzfscY87IV9s1KA9/thLjSvLyUjKIjO/TjiMgLZn+DN+xh7mfvvsxXC
 gfcf3K7XbTSG1BOo=
X-Received: by 2002:adf:e781:: with SMTP id n1mr45109049wrm.56.1582203991748; 
 Thu, 20 Feb 2020 05:06:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqwouSCwy3rqeENoKe0gZr/3kvydEDFXzHky1eaSJGgeUp7K/B6TN0eEopUiJDH/U8pAJl2oNQ==
X-Received: by 2002:adf:e781:: with SMTP id n1mr45109010wrm.56.1582203991459; 
 Thu, 20 Feb 2020 05:06:31 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:06:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 10/20] Remove unnecessary cast when using the
 cpu_[physical]_memory API
Date: Thu, 20 Feb 2020 14:05:38 +0100
Message-Id: <20200220130548.29974-11-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220130548.29974-1-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: sDINMfaHM7C8TOknOsZeOg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit was produced with the included Coccinelle script
scripts/coccinelle/exec_rw_const.

Suggested-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 scripts/coccinelle/exec_rw_const.cocci | 10 ++++++++++
 hw/display/omap_lcdc.c                 | 10 +++++-----
 hw/dma/etraxfs_dma.c                   | 25 ++++++++++---------------
 hw/scsi/vmw_pvscsi.c                   |  8 +++-----
 target/i386/hax-all.c                  |  6 +++---
 5 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/ex=
ec_rw_const.cocci
index 5ed956a834..70cf52d58e 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -34,6 +34,16 @@ type T;
 + address_space_write_rom(E1, E2, E3, E4, E5)
 |
=20
+- cpu_physical_memory_rw(E1, (T *)E2, E3, E4)
++ cpu_physical_memory_rw(E1, E2, E3, E4)
+|
+- cpu_physical_memory_read(E1, (T *)E2, E3)
++ cpu_physical_memory_read(E1, E2, E3)
+|
+- cpu_physical_memory_write(E1, (T *)E2, E3)
++ cpu_physical_memory_write(E1, E2, E3)
+|
+
 - dma_memory_read(E1, E2, (T *)E3, E4)
 + dma_memory_read(E1, E2, E3, E4)
 |
diff --git a/hw/display/omap_lcdc.c b/hw/display/omap_lcdc.c
index 6ad13f2e9e..fa4a381db6 100644
--- a/hw/display/omap_lcdc.c
+++ b/hw/display/omap_lcdc.c
@@ -91,9 +91,9 @@ static void omap_update_display(void *opaque)
=20
     frame_offset =3D 0;
     if (omap_lcd->plm !=3D 2) {
-        cpu_physical_memory_read(omap_lcd->dma->phys_framebuffer[
-                                  omap_lcd->dma->current_frame],
-                                 (void *)omap_lcd->palette, 0x200);
+        cpu_physical_memory_read(
+                omap_lcd->dma->phys_framebuffer[omap_lcd->dma->current_fra=
me],
+                omap_lcd->palette, 0x200);
         switch (omap_lcd->palette[0] >> 12 & 7) {
         case 3 ... 7:
             frame_offset +=3D 0x200;
@@ -244,8 +244,8 @@ static void omap_lcd_update(struct omap_lcd_panel_s *s)=
 {
=20
     if (s->plm !=3D 2 && !s->palette_done) {
         cpu_physical_memory_read(
-            s->dma->phys_framebuffer[s->dma->current_frame],
-            (void *)s->palette, 0x200);
+                            s->dma->phys_framebuffer[s->dma->current_frame=
],
+                            s->palette, 0x200);
         s->palette_done =3D 1;
         omap_lcd_interrupts(s);
     }
diff --git a/hw/dma/etraxfs_dma.c b/hw/dma/etraxfs_dma.c
index 47e1c6df12..c4334e87bf 100644
--- a/hw/dma/etraxfs_dma.c
+++ b/hw/dma/etraxfs_dma.c
@@ -225,9 +225,8 @@ static void channel_load_g(struct fs_dma_ctrl *ctrl, in=
t c)
 =09hwaddr addr =3D channel_reg(ctrl, c, RW_GROUP);
=20
 =09/* Load and decode. FIXME: handle endianness.  */
-=09cpu_physical_memory_read (addr,=20
-=09=09=09=09  (void *) &ctrl->channels[c].current_g,=20
-=09=09=09=09  sizeof ctrl->channels[c].current_g);
+    cpu_physical_memory_read(addr, &ctrl->channels[c].current_g,
+                             sizeof(ctrl->channels[c].current_g));
 }
=20
 static void dump_c(int ch, struct dma_descr_context *c)
@@ -257,9 +256,8 @@ static void channel_load_c(struct fs_dma_ctrl *ctrl, in=
t c)
 =09hwaddr addr =3D channel_reg(ctrl, c, RW_GROUP_DOWN);
=20
 =09/* Load and decode. FIXME: handle endianness.  */
-=09cpu_physical_memory_read (addr,=20
-=09=09=09=09  (void *) &ctrl->channels[c].current_c,=20
-=09=09=09=09  sizeof ctrl->channels[c].current_c);
+    cpu_physical_memory_read(addr, &ctrl->channels[c].current_c,
+                             sizeof(ctrl->channels[c].current_c));
=20
 =09D(dump_c(c, &ctrl->channels[c].current_c));
 =09/* I guess this should update the current pos.  */
@@ -275,9 +273,8 @@ static void channel_load_d(struct fs_dma_ctrl *ctrl, in=
t c)
=20
 =09/* Load and decode. FIXME: handle endianness.  */
 =09D(printf("%s ch=3D%d addr=3D" TARGET_FMT_plx "\n", __func__, c, addr));
-=09cpu_physical_memory_read (addr,
-=09=09=09=09  (void *) &ctrl->channels[c].current_d,=20
-=09=09=09=09  sizeof ctrl->channels[c].current_d);
+    cpu_physical_memory_read(addr, &ctrl->channels[c].current_d,
+                             sizeof(ctrl->channels[c].current_d));
=20
 =09D(dump_d(c, &ctrl->channels[c].current_d));
 =09ctrl->channels[c].regs[RW_DATA] =3D addr;
@@ -290,9 +287,8 @@ static void channel_store_c(struct fs_dma_ctrl *ctrl, i=
nt c)
 =09/* Encode and store. FIXME: handle endianness.  */
 =09D(printf("%s ch=3D%d addr=3D" TARGET_FMT_plx "\n", __func__, c, addr));
 =09D(dump_d(c, &ctrl->channels[c].current_d));
-=09cpu_physical_memory_write (addr,
-=09=09=09=09  (void *) &ctrl->channels[c].current_c,
-=09=09=09=09  sizeof ctrl->channels[c].current_c);
+    cpu_physical_memory_write(addr, &ctrl->channels[c].current_c,
+                              sizeof(ctrl->channels[c].current_c));
 }
=20
 static void channel_store_d(struct fs_dma_ctrl *ctrl, int c)
@@ -301,9 +297,8 @@ static void channel_store_d(struct fs_dma_ctrl *ctrl, i=
nt c)
=20
 =09/* Encode and store. FIXME: handle endianness.  */
 =09D(printf("%s ch=3D%d addr=3D" TARGET_FMT_plx "\n", __func__, c, addr));
-=09cpu_physical_memory_write (addr,
-=09=09=09=09  (void *) &ctrl->channels[c].current_d,=20
-=09=09=09=09  sizeof ctrl->channels[c].current_d);
+    cpu_physical_memory_write(addr, &ctrl->channels[c].current_d,
+                              sizeof(ctrl->channels[c].current_d));
 }
=20
 static inline void channel_stop(struct fs_dma_ctrl *ctrl, int c)
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index e4ee2e6643..c91352cf46 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -404,8 +404,7 @@ pvscsi_cmp_ring_put(PVSCSIState *s, struct PVSCSIRingCm=
pDesc *cmp_desc)
=20
     cmp_descr_pa =3D pvscsi_ring_pop_cmp_descr(&s->rings);
     trace_pvscsi_cmp_ring_put(cmp_descr_pa);
-    cpu_physical_memory_write(cmp_descr_pa, (void *)cmp_desc,
-                              sizeof(*cmp_desc));
+    cpu_physical_memory_write(cmp_descr_pa, cmp_desc, sizeof(*cmp_desc));
 }
=20
 static void
@@ -415,8 +414,7 @@ pvscsi_msg_ring_put(PVSCSIState *s, struct PVSCSIRingMs=
gDesc *msg_desc)
=20
     msg_descr_pa =3D pvscsi_ring_pop_msg_descr(&s->rings);
     trace_pvscsi_msg_ring_put(msg_descr_pa);
-    cpu_physical_memory_write(msg_descr_pa, (void *)msg_desc,
-                              sizeof(*msg_desc));
+    cpu_physical_memory_write(msg_descr_pa, msg_desc, sizeof(*msg_desc));
 }
=20
 static void
@@ -491,7 +489,7 @@ pvscsi_get_next_sg_elem(PVSCSISGState *sg)
 {
     struct PVSCSISGElement elem;
=20
-    cpu_physical_memory_read(sg->elemAddr, (void *)&elem, sizeof(elem));
+    cpu_physical_memory_read(sg->elemAddr, &elem, sizeof(elem));
     if ((elem.flags & ~PVSCSI_KNOWN_FLAGS) !=3D 0) {
         /*
             * There is PVSCSI_SGE_FLAG_CHAIN_ELEMENT flag described in
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index a8b6e5aeb8..a9cc51e6ce 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -367,7 +367,7 @@ static int hax_accel_init(MachineState *ms)
 static int hax_handle_fastmmio(CPUArchState *env, struct hax_fastmmio *hft=
)
 {
     if (hft->direction < 2) {
-        cpu_physical_memory_rw(hft->gpa, (uint8_t *) &hft->value, hft->siz=
e,
+        cpu_physical_memory_rw(hft->gpa, &hft->value, hft->size,
                                hft->direction);
     } else {
         /*
@@ -376,8 +376,8 @@ static int hax_handle_fastmmio(CPUArchState *env, struc=
t hax_fastmmio *hft)
          *  hft->direction =3D=3D 2: gpa =3D=3D> gpa2
          */
         uint64_t value;
-        cpu_physical_memory_rw(hft->gpa, (uint8_t *) &value, hft->size, 0)=
;
-        cpu_physical_memory_rw(hft->gpa2, (uint8_t *) &value, hft->size, 1=
);
+        cpu_physical_memory_rw(hft->gpa, &value, hft->size, 0);
+        cpu_physical_memory_rw(hft->gpa2, &value, hft->size, 1);
     }
=20
     return 0;
--=20
2.21.1


