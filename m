Received: from eggs.gnu.org ([2001:4830:134:3::10]:57673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ceLsZ-0001kz-8x
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ceLsW-0000Xq-FT
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:13:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ceLsW-0000Wv-7B
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:13:44 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 742868553C
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 13:13:44 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 16 Feb 2017 14:13:37 +0100
Message-Id: <1487250819-23764-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487250819-23764-1-git-send-email-kraxel@redhat.com>
References: <1487250819-23764-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] usb-ccid: better bulk_out error handling
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
---
 hw/usb/dev-smartcard-reader.c | 116 ++++++++++++++++++++++--------------------
 1 file changed, 61 insertions(+), 55 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 1325ea1..badcfcb 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1001,8 +1001,7 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
     CCID_Header *ccid_header;
 
     if (p->iov.size + s->bulk_out_pos > BULK_OUT_DATA_SIZE) {
-        p->status = USB_RET_STALL;
-        return;
+        goto err;
     }
     ccid_header = (CCID_Header *)s->bulk_out_data;
     usb_packet_copy(p, s->bulk_out_data + s->bulk_out_pos, p->iov.size);
@@ -1017,64 +1016,71 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
         DPRINTF(s, 1,
                 "%s: bad USB_TOKEN_OUT length, should be at least 10 bytes\n",
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
-            s->powered = true;
-            if (!ccid_card_inserted(s)) {
-                ccid_report_error_failed(s, ERROR_ICC_MUTE);
-            }
-            /* atr is written regardless of error. */
-            ccid_write_data_block_atr(s, ccid_header);
-            break;
-        case CCID_MESSAGE_TYPE_PC_to_RDR_IccPowerOff:
-            ccid_reset_error_status(s);
-            s->powered = false;
-            ccid_write_slot_status(s, ccid_header);
-            break;
-        case CCID_MESSAGE_TYPE_PC_to_RDR_XfrBlock:
-            ccid_on_apdu_from_guest(s, (CCID_XferBlock *)s->bulk_out_data);
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
+        s->powered = true;
+        if (!ccid_card_inserted(s)) {
+            ccid_report_error_failed(s, ERROR_ICC_MUTE);
+        }
+        /* atr is written regardless of error. */
+        ccid_write_data_block_atr(s, ccid_header);
+        break;
+    case CCID_MESSAGE_TYPE_PC_to_RDR_IccPowerOff:
+        ccid_reset_error_status(s);
+        s->powered = false;
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
     s->bulk_out_pos = 0;
+    return;
+
+err:
+    p->status = USB_RET_STALL;
+    s->bulk_out_pos = 0;
+    return;
 }
 
 static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p)
-- 
1.8.3.1
