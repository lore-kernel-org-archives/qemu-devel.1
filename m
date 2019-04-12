Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AD4C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B38520818
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B38520818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35566 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvER-0000RM-L7
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:24:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEv6z-0002to-B3
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEv6t-0004dr-LT
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEv6t-0004cw-Ca
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B12123082EF1;
	Fri, 12 Apr 2019 12:16:46 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-27.ams2.redhat.com
	[10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 016F35D9CC;
	Fri, 12 Apr 2019 12:16:44 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Apr 2019 13:16:26 +0100
Message-Id: <20190412121626.19829-6-berrange@redhat.com>
In-Reply-To: <20190412121626.19829-1-berrange@redhat.com>
References: <20190412121626.19829-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Fri, 12 Apr 2019 12:16:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 5/5] qxl: avoid unaligned pointer
 reads/writes
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412121626.DiojtgoQrwN0aM590uLu0lo4pfzGoMyKjULP-CkzQTw@z>

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
---
 hw/display/qxl.c | 55 +++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index c8ce5781e0..5c38e6e906 100644
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
     if (ext.group_id =3D=3D MEMSLOT_GROUP_HOST) {
         /* host group -> vga mode update request */
@@ -792,16 +783,18 @@ static void interface_release_resource(QXLInstance =
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
2.20.1


