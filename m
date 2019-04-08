Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A05FC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 20:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEBA520880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 20:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBA520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58446 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDajj-0003je-Px
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 16:19:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDaiv-0003Sa-0Q
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDait-0006Tj-1m
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:18:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDair-0006Qo-0z
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:18:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4404308FBB4
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 20:12:09 +0000 (UTC)
Received: from localhost (unknown [10.36.112.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E0A1460472;
	Mon,  8 Apr 2019 20:12:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 22:12:03 +0200
Message-Id: <20190408201203.28924-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 08 Apr 2019 20:12:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] qxl: fix -Waddress-of-packed-member
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408201203.hMaPXwCEwcFkljSXkEZNX_DR5z03QyKT1POh3JAxrmY@z>

The GCC9 compiler complains about QXL code that takes the address of
members of the 'struct QXLReleaseRing' which is marked packed:

  CC      hw/display/qxl.o
/home/elmarco/src/qemu/hw/display/qxl.c: In function =E2=80=98init_qxl_ra=
m=E2=80=99:
/home/elmarco/src/qemu/hw/display/qxl.c:50:19: warning: taking address of=
 packed member of =E2=80=98struct QXLReleaseRing_ring_el=E2=80=99 may res=
ult in an unaligned pointer value [-Waddress-of-packed-member]
   50 |             ret =3D &(r)->items[prod].el;                        =
         \
      |                   ^~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qemu/hw/display/qxl.c:429:5: note: in expansion of macr=
o =E2=80=98SPICE_RING_PROD_ITEM=E2=80=99
  429 |     SPICE_RING_PROD_ITEM(d, &d->ram->release_ring, item);
      |     ^~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qemu/hw/display/qxl.c: In function =E2=80=98qxl_push_fr=
ee_res=E2=80=99:
/home/elmarco/src/qemu/hw/display/qxl.c:50:19: warning: taking address of=
 packed member of =E2=80=98struct QXLReleaseRing_ring_el=E2=80=99 may res=
ult in an unaligned pointer value [-Waddress-of-packed-member]
   50 |             ret =3D &(r)->items[prod].el;                        =
         \
      |                   ^~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qemu/hw/display/qxl.c:762:5: note: in expansion of macr=
o =E2=80=98SPICE_RING_PROD_ITEM=E2=80=99
  762 |     SPICE_RING_PROD_ITEM(d, ring, item);
      |     ^~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qemu/hw/display/qxl.c: In function =E2=80=98interface_r=
elease_resource=E2=80=99:
/home/elmarco/src/qemu/hw/display/qxl.c:50:19: warning: taking address of=
 packed member of =E2=80=98struct QXLReleaseRing_ring_el=E2=80=99 may res=
ult in an unaligned pointer value [-Waddress-of-packed-member]
   50 |             ret =3D &(r)->items[prod].el;                        =
         \
      |                   ^~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qemu/hw/display/qxl.c:795:5: note: in expansion of macr=
o =E2=80=98SPICE_RING_PROD_ITEM=E2=80=99
  795 |     SPICE_RING_PROD_ITEM(qxl, ring, item);
      |     ^~~~~~~~~~~~~~~~~~~~

Replace pointer usage by direct structure/array access instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/display/qxl.c | 83 +++++++++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 33 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index c8ce5781e0..12d83dd6f1 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -39,29 +39,49 @@
  * abort we just qxl_set_guest_bug and set the return to NULL. Still
  * it may happen as a result of emulator bug as well.
  */
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
+#define SPICE_RING_GET_CHECK(qxl, r, field) ({                          =
\
+    field =3D (r)->field & SPICE_RING_INDEX_MASK(r);                    =
  \
+    bool mismatch =3D field >=3D ARRAY_SIZE((r)->items);                =
    \
+    if (mismatch) {                                                     =
\
+        qxl_set_guest_bug(qxl, "SPICE_RING_GET %s indices mismatch "    =
\
+                          "%u >=3D %zu", stringify(field), field,       =
  \
+                          ARRAY_SIZE((r)->items));                      =
\
+    }                                                                   =
\
+    !mismatch;                                                          =
\
+})
+
+static inline uint64_t
+qxl_release_ring_get_prod(PCIQXLDevice *qxl)
+{
+    struct QXLReleaseRing *ring =3D &qxl->ram->release_ring;
+    uint32_t prod;
+    bool ok =3D SPICE_RING_GET_CHECK(qxl, ring, prod);
+    assert(ok);
+
+    return ring->items[prod].el;
+}
+
+static inline bool
+qxl_release_ring_set_prod(PCIQXLDevice *qxl, uint64_t val)
+{
+    struct QXLReleaseRing *ring =3D &qxl->ram->release_ring;
+    uint32_t prod;
+    bool ok =3D SPICE_RING_GET_CHECK(qxl, ring, prod);
+    if (ok) {
+        ring->items[prod].el =3D val;
     }
+    return ok;
+}
=20
 #undef SPICE_RING_CONS_ITEM
-#define SPICE_RING_CONS_ITEM(qxl, r, ret) {                             =
\
-        uint32_t cons =3D (r)->cons & SPICE_RING_INDEX_MASK(r);         =
  \
-        if (cons >=3D ARRAY_SIZE((r)->items)) {                         =
  \
-            qxl_set_guest_bug(qxl, "SPICE_RING_CONS_ITEM indices mismatc=
h " \
-                          "%u >=3D %zu", cons, ARRAY_SIZE((r)->items)); =
  \
-            ret =3D NULL;                                               =
  \
-        } else {                                                        =
\
-            ret =3D &(r)->items[cons].el;                               =
  \
-        }                                                               =
\
-    }
+#define SPICE_RING_CONS_ITEM(qxl, r, ret) {     \
+    uint32_t cons;                              \
+    if (!SPICE_RING_GET_CHECK(qxl, r, cons)) {  \
+        ret =3D NULL;                             \
+    } else {                                    \
+        ret =3D &(r)->items[cons].el;             \
+    }                                           \
+}
=20
 #undef ALIGN
 #define ALIGN(a, b) (((a) + ((b) - 1)) & ~((b) - 1))
@@ -414,7 +434,6 @@ static void init_qxl_rom(PCIQXLDevice *d)
 static void init_qxl_ram(PCIQXLDevice *d)
 {
     uint8_t *buf;
-    uint64_t *item;
=20
     buf =3D d->vga.vram_ptr;
     d->ram =3D (QXLRam *)(buf + le32_to_cpu(d->shadow_rom.ram_header_off=
set));
@@ -426,9 +445,9 @@ static void init_qxl_ram(PCIQXLDevice *d)
     SPICE_RING_INIT(&d->ram->cmd_ring);
     SPICE_RING_INIT(&d->ram->cursor_ring);
     SPICE_RING_INIT(&d->ram->release_ring);
-    SPICE_RING_PROD_ITEM(d, &d->ram->release_ring, item);
-    assert(item);
-    *item =3D 0;
+    if (!qxl_release_ring_set_prod(d, 0)) {
+        g_assert_not_reached();
+    }
     qxl_ring_set_dirty(d);
 }
=20
@@ -732,7 +751,6 @@ static int interface_req_cmd_notification(QXLInstance=
 *sin)
 static inline void qxl_push_free_res(PCIQXLDevice *d, int flush)
 {
     QXLReleaseRing *ring =3D &d->ram->release_ring;
-    uint64_t *item;
     int notify;
=20
 #define QXL_FREE_BUNCH_SIZE 32
@@ -759,11 +777,9 @@ static inline void qxl_push_free_res(PCIQXLDevice *d=
, int flush)
     if (notify) {
         qxl_send_events(d, QXL_INTERRUPT_DISPLAY);
     }
-    SPICE_RING_PROD_ITEM(d, ring, item);
-    if (!item) {
+    if (!qxl_release_ring_set_prod(d, 0)) {
         return;
     }
-    *item =3D 0;
     d->num_free_res =3D 0;
     d->last_release =3D NULL;
     qxl_ring_set_dirty(d);
@@ -775,7 +791,8 @@ static void interface_release_resource(QXLInstance *s=
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
@@ -792,16 +809,16 @@ static void interface_release_resource(QXLInstance =
*sin,
      * pci bar 0, $command.release_info
      */
     ring =3D &qxl->ram->release_ring;
-    SPICE_RING_PROD_ITEM(qxl, ring, item);
-    if (!item) {
+
+    if (!SPICE_RING_GET_CHECK(qxl, ring, prod)) {
         return;
     }
-    if (*item =3D=3D 0) {
+    if (qxl_release_ring_get_prod(qxl) =3D=3D 0) {
         /* stick head into the ring */
         id =3D ext.info->id;
         ext.info->next =3D 0;
         qxl_ram_set_dirty(qxl, &ext.info->next);
-        *item =3D id;
+        qxl_release_ring_set_prod(qxl, id);
         qxl_ring_set_dirty(qxl);
     } else {
         /* append item to the list */
--=20
2.21.0.196.g041f5ea1cf


