Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93081C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5964920989
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5964920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42171 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNvSp-0008NR-QI
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 04:28:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hNvKU-0000lD-2Y
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hNvKS-0008Ff-Uh
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:20:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>)
	id 1hNvKM-0008AC-HF; Tue, 07 May 2019 04:19:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ABBC630821A3;
	Tue,  7 May 2019 08:19:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C451F277A5;
	Tue,  7 May 2019 08:19:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id A9B73A1E8; Tue,  7 May 2019 10:19:46 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 10:19:44 +0200
Message-Id: <20190507081946.19264-7-kraxel@redhat.com>
In-Reply-To: <20190507081946.19264-1-kraxel@redhat.com>
References: <20190507081946.19264-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 07 May 2019 08:19:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 6/8] qxl: avoid unaligned pointer reads/writes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The SPICE_RING_PROD_ITEM() macro is initializing a local
'uint64_t *' variable to point to the 'el' field inside
the QXLReleaseRing struct. This uint64_t field is not
guaranteed aligned as the struct is packed.

Code should not take the address of fields within a
packed struct. Changing the SPICE_RING_PROD_ITEM()
macro to avoid taking the address of the field is
impractical. It is clearer to just remove the macro
and inline its functionality in the three call sites
that need it.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20190412121626.19829-6-berrange@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/qxl.c | 55 +++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 632923add239..3880a7410b73 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -33,24 +33,6 @@
=20
 #include "qxl.h"
=20
-/*
- * NOTE: SPICE_RING_PROD_ITEM accesses memory on the pci bar and as
- * such can be changed by the guest, so to avoid a guest trigerrable
- * abort we just qxl_set_guest_bug and set the return to NULL. Still
- * it may happen as a result of emulator bug as well.
- */
-#undef SPICE_RING_PROD_ITEM
-#define SPICE_RING_PROD_ITEM(qxl, r, ret) {                             =
\
-        uint32_t prod =3D (r)->prod & SPICE_RING_INDEX_MASK(r);         =
  \
-        if (prod >=3D ARRAY_SIZE((r)->items)) {                         =
  \
-            qxl_set_guest_bug(qxl, "SPICE_RING_PROD_ITEM indices mismatc=
h " \
-                          "%u >=3D %zu", prod, ARRAY_SIZE((r)->items)); =
  \
-            ret =3D NULL;                                               =
  \
-        } else {                                                        =
\
-            ret =3D &(r)->items[prod].el;                               =
  \
-        }                                                               =
\
-    }
-
 #undef SPICE_RING_CONS_ITEM
 #define SPICE_RING_CONS_ITEM(qxl, r, ret) {                             =
\
         uint32_t cons =3D (r)->cons & SPICE_RING_INDEX_MASK(r);         =
  \
@@ -414,7 +396,8 @@ static void init_qxl_rom(PCIQXLDevice *d)
 static void init_qxl_ram(PCIQXLDevice *d)
 {
     uint8_t *buf;
-    uint64_t *item;
+    uint32_t prod;
+    QXLReleaseRing *ring;
=20
     buf =3D d->vga.vram_ptr;
     d->ram =3D (QXLRam *)(buf + le32_to_cpu(d->shadow_rom.ram_header_off=
set));
@@ -426,9 +409,12 @@ static void init_qxl_ram(PCIQXLDevice *d)
     SPICE_RING_INIT(&d->ram->cmd_ring);
     SPICE_RING_INIT(&d->ram->cursor_ring);
     SPICE_RING_INIT(&d->ram->release_ring);
-    SPICE_RING_PROD_ITEM(d, &d->ram->release_ring, item);
-    assert(item);
-    *item =3D 0;
+
+    ring =3D &d->ram->release_ring;
+    prod =3D ring->prod & SPICE_RING_INDEX_MASK(ring);
+    assert(prod < ARRAY_SIZE(ring->items));
+    ring->items[prod].el =3D 0;
+
     qxl_ring_set_dirty(d);
 }
=20
@@ -732,7 +718,7 @@ static int interface_req_cmd_notification(QXLInstance=
 *sin)
 static inline void qxl_push_free_res(PCIQXLDevice *d, int flush)
 {
     QXLReleaseRing *ring =3D &d->ram->release_ring;
-    uint64_t *item;
+    uint32_t prod;
     int notify;
=20
 #define QXL_FREE_BUNCH_SIZE 32
@@ -759,11 +745,15 @@ static inline void qxl_push_free_res(PCIQXLDevice *=
d, int flush)
     if (notify) {
         qxl_send_events(d, QXL_INTERRUPT_DISPLAY);
     }
-    SPICE_RING_PROD_ITEM(d, ring, item);
-    if (!item) {
+
+    ring =3D &d->ram->release_ring;
+    prod =3D ring->prod & SPICE_RING_INDEX_MASK(ring);
+    if (prod >=3D ARRAY_SIZE(ring->items)) {
+        qxl_set_guest_bug(d, "SPICE_RING_PROD_ITEM indices mismatch "
+                          "%u >=3D %zu", prod, ARRAY_SIZE(ring->items));
         return;
     }
-    *item =3D 0;
+    ring->items[prod].el =3D 0;
     d->num_free_res =3D 0;
     d->last_release =3D NULL;
     qxl_ring_set_dirty(d);
@@ -775,7 +765,8 @@ static void interface_release_resource(QXLInstance *s=
in,
 {
     PCIQXLDevice *qxl =3D container_of(sin, PCIQXLDevice, ssd.qxl);
     QXLReleaseRing *ring;
-    uint64_t *item, id;
+    uint32_t prod;
+    uint64_t id;
=20
     if (!ext.info) {
         return;
@@ -795,16 +786,18 @@ static void interface_release_resource(QXLInstance =
*sin,
      * pci bar 0, $command.release_info
      */
     ring =3D &qxl->ram->release_ring;
-    SPICE_RING_PROD_ITEM(qxl, ring, item);
-    if (!item) {
+    prod =3D ring->prod & SPICE_RING_INDEX_MASK(ring);
+    if (prod >=3D ARRAY_SIZE(ring->items)) {
+        qxl_set_guest_bug(qxl, "SPICE_RING_PROD_ITEM indices mismatch "
+                          "%u >=3D %zu", prod, ARRAY_SIZE(ring->items));
         return;
     }
-    if (*item =3D=3D 0) {
+    if (ring->items[prod].el =3D=3D 0) {
         /* stick head into the ring */
         id =3D ext.info->id;
         ext.info->next =3D 0;
         qxl_ram_set_dirty(qxl, &ext.info->next);
-        *item =3D id;
+        ring->items[prod].el =3D id;
         qxl_ring_set_dirty(qxl);
     } else {
         /* append item to the list */
--=20
2.18.1


