Received: from eggs.gnu.org ([2001:4830:134:3::10]:59327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg4gd-0002z9-PA
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg4gb-00088D-1j
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg4ga-00087U-Oi
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:32 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02EF54E02B
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 07:16:33 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 08:16:23 +0100
Message-Id: <1487661385-7720-10-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
References: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/11] usb-ccid: better bulk_out error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Add err goto label where we can jump to from all error conditions.
STALL request on all errors.  Reset position on all errors.

Normal request processing is not in a else branch any more, so this code
is reintended, there are no code changes in that part of the code
though.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 1487250819-23764-2-git-send-email-kraxel@redhat.com
---
 hw/usb/dev-smartcard-reader.c | 116 ++++++++++++++++++++++--------------=
------
 1 file changed, 61 insertions(+), 55 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
index 1325ea1..badcfcb 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1001,8 +1001,7 @@ static void ccid_handle_bulk_out(USBCCIDState *s, U=
SBPacket *p)
     CCID_Header *ccid_header;
=20
     if (p->iov.size + s->bulk_out_pos > BULK_OUT_DATA_SIZE) {
-        p->status =3D USB_RET_STALL;
-        return;
+        goto err;
     }
     ccid_header =3D (CCID_Header *)s->bulk_out_data;
     usb_packet_copy(p, s->bulk_out_data + s->bulk_out_pos, p->iov.size);
@@ -1017,64 +1016,71 @@ static void ccid_handle_bulk_out(USBCCIDState *s,=
 USBPacket *p)
         DPRINTF(s, 1,
                 "%s: bad USB_TOKEN_OUT length, should be at least 10 byt=
es\n",
                 __func__);
-    } else {
-        DPRINTF(s, D_MORE_INFO, "%s %x %s\n", __func__,
-                ccid_header->bMessageType,
-                ccid_message_type_to_str(ccid_header->bMessageType));
-        switch (ccid_header->bMessageType) {
-        case CCID_MESSAGE_TYPE_PC_to_RDR_GetSlotStatus:
-            ccid_write_slot_status(s, ccid_header);
-            break;
-        case CCID_MESSAGE_TYPE_PC_to_RDR_IccPowerOn:
-            DPRINTF(s, 1, "%s: PowerOn: %d\n", __func__,
+        goto err;
+    }
+
+    DPRINTF(s, D_MORE_INFO, "%s %x %s\n", __func__,
+            ccid_header->bMessageType,
+            ccid_message_type_to_str(ccid_header->bMessageType));
+    switch (ccid_header->bMessageType) {
+    case CCID_MESSAGE_TYPE_PC_to_RDR_GetSlotStatus:
+        ccid_write_slot_status(s, ccid_header);
+        break;
+    case CCID_MESSAGE_TYPE_PC_to_RDR_IccPowerOn:
+        DPRINTF(s, 1, "%s: PowerOn: %d\n", __func__,
                 ((CCID_IccPowerOn *)(ccid_header))->bPowerSelect);
-            s->powered =3D true;
-            if (!ccid_card_inserted(s)) {
-                ccid_report_error_failed(s, ERROR_ICC_MUTE);
-            }
-            /* atr is written regardless of error. */
-            ccid_write_data_block_atr(s, ccid_header);
-            break;
-        case CCID_MESSAGE_TYPE_PC_to_RDR_IccPowerOff:
-            ccid_reset_error_status(s);
-            s->powered =3D false;
-            ccid_write_slot_status(s, ccid_header);
-            break;
-        case CCID_MESSAGE_TYPE_PC_to_RDR_XfrBlock:
-            ccid_on_apdu_from_guest(s, (CCID_XferBlock *)s->bulk_out_dat=
a);
-            break;
-        case CCID_MESSAGE_TYPE_PC_to_RDR_SetParameters:
-            ccid_reset_error_status(s);
-            ccid_set_parameters(s, ccid_header);
-            ccid_write_parameters(s, ccid_header);
-            break;
-        case CCID_MESSAGE_TYPE_PC_to_RDR_ResetParameters:
-            ccid_reset_error_status(s);
-            ccid_reset_parameters(s);
-            ccid_write_parameters(s, ccid_header);
-            break;
-        case CCID_MESSAGE_TYPE_PC_to_RDR_GetParameters:
-            ccid_reset_error_status(s);
-            ccid_write_parameters(s, ccid_header);
-            break;
-        case CCID_MESSAGE_TYPE_PC_to_RDR_Mechanical:
-            ccid_report_error_failed(s, 0);
-            ccid_write_slot_status(s, ccid_header);
-            break;
-        default:
-            DPRINTF(s, 1,
+        s->powered =3D true;
+        if (!ccid_card_inserted(s)) {
+            ccid_report_error_failed(s, ERROR_ICC_MUTE);
+        }
+        /* atr is written regardless of error. */
+        ccid_write_data_block_atr(s, ccid_header);
+        break;
+    case CCID_MESSAGE_TYPE_PC_to_RDR_IccPowerOff:
+        ccid_reset_error_status(s);
+        s->powered =3D false;
+        ccid_write_slot_status(s, ccid_header);
+        break;
+    case CCID_MESSAGE_TYPE_PC_to_RDR_XfrBlock:
+        ccid_on_apdu_from_guest(s, (CCID_XferBlock *)s->bulk_out_data);
+        break;
+    case CCID_MESSAGE_TYPE_PC_to_RDR_SetParameters:
+        ccid_reset_error_status(s);
+        ccid_set_parameters(s, ccid_header);
+        ccid_write_parameters(s, ccid_header);
+        break;
+    case CCID_MESSAGE_TYPE_PC_to_RDR_ResetParameters:
+        ccid_reset_error_status(s);
+        ccid_reset_parameters(s);
+        ccid_write_parameters(s, ccid_header);
+        break;
+    case CCID_MESSAGE_TYPE_PC_to_RDR_GetParameters:
+        ccid_reset_error_status(s);
+        ccid_write_parameters(s, ccid_header);
+        break;
+    case CCID_MESSAGE_TYPE_PC_to_RDR_Mechanical:
+        ccid_report_error_failed(s, 0);
+        ccid_write_slot_status(s, ccid_header);
+        break;
+    default:
+        DPRINTF(s, 1,
                 "handle_data: ERROR: unhandled message type %Xh\n",
                 ccid_header->bMessageType);
-            /*
-             * The caller is expecting the device to respond, tell it we
-             * don't support the operation.
-             */
-            ccid_report_error_failed(s, ERROR_CMD_NOT_SUPPORTED);
-            ccid_write_slot_status(s, ccid_header);
-            break;
-        }
+        /*
+         * The caller is expecting the device to respond, tell it we
+         * don't support the operation.
+         */
+        ccid_report_error_failed(s, ERROR_CMD_NOT_SUPPORTED);
+        ccid_write_slot_status(s, ccid_header);
+        break;
     }
     s->bulk_out_pos =3D 0;
+    return;
+
+err:
+    p->status =3D USB_RET_STALL;
+    s->bulk_out_pos =3D 0;
+    return;
 }
=20
 static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p)
--=20
1.8.3.1
