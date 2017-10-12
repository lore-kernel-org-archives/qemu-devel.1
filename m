Received: from eggs.gnu.org ([2001:4830:134:3::10]:41864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e2bZT-0006BA-S5
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 07:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e2bZQ-0005Nl-JX
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 07:22:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e2bZQ-0005Fs-BC
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 07:22:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 664E0C04AC4A
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 11:22:30 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 12 Oct 2017 13:21:57 +0200
Message-Id: <20171012112157.15647-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] usb-ccid: remove needless migration state code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This code appears to be unused since its introduction. It should be
safe to remove from VMState.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
index 0c77d2a41d..d23a4d7f7d 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -270,11 +270,6 @@ typedef struct BulkIn {
     uint32_t pos;
 } BulkIn;
=20
-enum {
-    MIGRATION_NONE,
-    MIGRATION_MIGRATED,
-};
-
 typedef struct CCIDBus {
     BusState qbus;
 } CCIDBus;
@@ -306,9 +301,6 @@ typedef struct USBCCIDState {
     CCID_ProtocolDataStructure abProtocolDataStructure;
     uint32_t ulProtocolDataStructureSize;
     uint32_t state_vmstate;
-    uint32_t migration_target_ip;
-    uint16_t migration_target_port;
-    uint8_t  migration_state;
     uint8_t  bmSlotICCState;
     uint8_t  powered;
     uint8_t  notify_slot_change;
@@ -1243,9 +1235,6 @@ int ccid_card_ccid_attach(CCIDCardState *card)
     USBCCIDState *s =3D USB_CCID_DEV(dev);
=20
     DPRINTF(s, 1, "CCID Attach\n");
-    if (s->migration_state =3D=3D MIGRATION_MIGRATED) {
-        s->migration_state =3D MIGRATION_NONE;
-    }
     return 0;
 }
=20
@@ -1341,9 +1330,6 @@ static void ccid_realize(USBDevice *dev, Error **er=
rp)
     s->intr =3D usb_ep_get(dev, USB_TOKEN_IN, CCID_INT_IN_EP);
     s->bulk =3D usb_ep_get(dev, USB_TOKEN_IN, CCID_BULK_IN_EP);
     s->card =3D NULL;
-    s->migration_state =3D MIGRATION_NONE;
-    s->migration_target_ip =3D 0;
-    s->migration_target_port =3D 0;
     s->dev.speed =3D USB_SPEED_FULL;
     s->dev.speedmask =3D USB_SPEED_MASK_FULL;
     s->notify_slot_change =3D false;
@@ -1379,13 +1365,6 @@ static int ccid_pre_save(void *opaque)
     USBCCIDState *s =3D opaque;
=20
     s->state_vmstate =3D s->dev.state;
-    if (s->dev.attached) {
-        /*
-         * Migrating an open device, ignore reconnection CHR_EVENT to av=
oid an
-         * erroneous detach.
-         */
-        s->migration_state =3D MIGRATION_MIGRATED;
-    }
=20
     return 0;
 }
@@ -1452,7 +1431,6 @@ static VMStateDescription ccid_vmstate =3D {
         VMSTATE_STRUCT_ARRAY(pending_answers, USBCCIDState,
                         PENDING_ANSWERS_NUM, 1, answer_vmstate, Answer),
         VMSTATE_UINT32(pending_answers_num, USBCCIDState),
-        VMSTATE_UINT8(migration_state, USBCCIDState),
         VMSTATE_UINT32(state_vmstate, USBCCIDState),
         VMSTATE_END_OF_LIST()
     }
--=20
2.15.0.rc0.40.gaefcc5f6f
