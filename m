Received: from eggs.gnu.org ([2001:4830:134:3::10]:56845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dY85u-0004OG-Sg
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dY85s-0005xJ-Qu
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:50:06 -0400
Received: from mail-lf0-x22d.google.com ([2a00:1450:4010:c07::22d]:36770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dY85s-0005vg-DP
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:50:04 -0400
Received: by mail-lf0-x22d.google.com with SMTP id d78so10080985lfg.3
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 02:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <1500541371-24788-1-git-send-email-sf@sfritsch.de>
	<1500541371-24788-9-git-send-email-sf@sfritsch.de>
In-Reply-To: <1500541371-24788-9-git-send-email-sf@sfritsch.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 20 Jul 2017 09:49:52 +0000
Message-ID: <CAJ+F1C+F2kKjQWT=tcRBbiYCfb+6FMWmBMOih8XiiB+C2Ov0FA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 8/8] usb-ccid: Reduce logging at level
 WARN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Fritsch <sf@sfritsch.de>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Thu, Jul 20, 2017 at 11:04 AM Stefan Fritsch <sf@sfritsch.de> wrote:

> From: Stefan Fritsch <stefan_fritsch@genua.de>
>
> Change all DPRINTF()s using (1 =3D=3D WARN) to use symbolic
> constants. Most of these DPRINTFs are now only logging at higher log
> levels.
>
> This allows to use ccid's debug level 1 =3D=3D WARN in normal operation.
>
> Signed-off-by: Stefan Fritsch <stefan_fritsch@genua.de>
> ---
>  hw/usb/dev-smartcard-reader.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
> index 72324e8313..fcc3ac1338 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -669,7 +669,7 @@ static void ccid_handle_reset(USBDevice *dev)
>  {
>      USBCCIDState *s =3D USB_CCID_DEV(dev);
>
> -    DPRINTF(s, 1, "Reset\n");
> +    DPRINTF(s, D_VERBOSE, "Reset\n");
>
>      ccid_reset(s);
>  }
> @@ -713,7 +713,7 @@ static void ccid_handle_control(USBDevice *dev,
> USBPacket *p, int request,
>      USBCCIDState *s =3D USB_CCID_DEV(dev);
>      int ret;
>
> -    DPRINTF(s, 1, "%s: got control %s (%x), value %x\n", __func__,
> +    DPRINTF(s, D_TRACE, "%s: got control %s (%x), value %x\n", __func__,
>              ccid_control_to_str(s, request), request, value);
>      ret =3D usb_desc_handle_control(dev, p, request, value, index, lengt=
h,
> data);
>      if (ret >=3D 0) {
> @@ -723,19 +723,20 @@ static void ccid_handle_control(USBDevice *dev,
> USBPacket *p, int request,
>      switch (request) {
>          /* Class specific requests.  */
>      case ClassInterfaceOutRequest | CCID_CONTROL_ABORT:
> -        DPRINTF(s, 1, "ccid_control abort UNIMPLEMENTED\n");
> +        DPRINTF(s, D_INFO, "ccid_control abort UNIMPLEMENTED\n");
>          p->status =3D USB_RET_STALL;
>          break;
>      case ClassInterfaceRequest | CCID_CONTROL_GET_CLOCK_FREQUENCIES:
> -        DPRINTF(s, 1, "ccid_control get clock frequencies
> UNIMPLEMENTED\n");
> +        DPRINTF(s, D_INFO,
> +                "ccid_control get clock frequencies UNIMPLEMENTED\n");
>          p->status =3D USB_RET_STALL;
>          break;
>      case ClassInterfaceRequest | CCID_CONTROL_GET_DATA_RATES:
> -        DPRINTF(s, 1, "ccid_control get data rates UNIMPLEMENTED\n");
> +        DPRINTF(s, D_INFO, "ccid_control get data rates UNIMPLEMENTED\n"=
);
>          p->status =3D USB_RET_STALL;
>          break;
>

WARN was quite appropriate for unimplemented code reached, no?


>      default:
> -        DPRINTF(s, 1, "got unsupported/bogus control %x, value %x\n",
> +        DPRINTF(s, D_INFO, "got unsupported/bogus control %x, value %x\n=
",
>                  request, value);
>

I would also keep it at WARN here,  (as the unhandled case in
ccid_handle_bulk_out)

         p->status =3D USB_RET_STALL;
>          break;
> @@ -1020,13 +1021,13 @@ static void ccid_on_apdu_from_guest(USBCCIDState
> *s, CCID_XferBlock *recv)
>      uint32_t len;
>
>      if (ccid_card_status(s) !=3D ICC_STATUS_PRESENT_ACTIVE) {
> -        DPRINTF(s, 1,
> +        DPRINTF(s, D_INFO,
>                  "usb-ccid: not sending apdu to client, no card
> connected\n");
>          ccid_write_data_block_error(s, recv->hdr.bSlot, recv->hdr.bSeq);
>          return;
>      }
>      len =3D le32_to_cpu(recv->hdr.dwLength);
> -    DPRINTF(s, 1, "%s: seq %d, len %d\n", __func__,
> +    DPRINTF(s, D_TRACE, "%s: seq %d, len %d\n", __func__,
>                  recv->hdr.bSeq, len);
>      if (le16_to_cpu(recv->wLevelParameter)) {
>          DPRINTF(s, D_WARN, "Unsupported non-zero level Parameter %x\n",
> @@ -1087,7 +1088,7 @@ static void ccid_handle_bulk_out(USBCCIDState *s,
> USBPacket *p)
>          return;
>      }
>      if (s->bulk_out_pos - 10 !=3D ccid_header->dwLength) {
> -        DPRINTF(s, 1,
> +        DPRINTF(s, D_WARN,
>                  "usb-ccid: bulk_in: message size mismatch (got %d,
> expected %d)\n",
>                  s->bulk_out_pos - 10, ccid_header->dwLength);
>          goto err;
> @@ -1101,7 +1102,7 @@ static void ccid_handle_bulk_out(USBCCIDState *s,
> USBPacket *p)
>          ccid_write_slot_status(s, ccid_header);
>          break;
>      case CCID_MESSAGE_TYPE_PC_to_RDR_IccPowerOn:
> -        DPRINTF(s, 1, "%s: PowerOn: %d\n", __func__,
> +        DPRINTF(s, D_VERBOSE, "%s: PowerOn: %d\n", __func__,
>                  ((CCID_IccPowerOn *)(ccid_header))->bPowerSelect);
>          s->powered =3D true;
>          if (!ccid_card_inserted(s)) {
> @@ -1137,7 +1138,7 @@ static void ccid_handle_bulk_out(USBCCIDState *s,
> USBPacket *p)
>          ccid_write_slot_status(s, ccid_header);
>          break;
>      default:
> -        DPRINTF(s, 1,
> +        DPRINTF(s, D_WARN,
>                  "handle_data: ERROR: unhandled message type %Xh\n",
>                  ccid_header->bMessageType);
>
         /*
> @@ -1229,13 +1230,13 @@ static void ccid_handle_data(USBDevice *dev,
> USBPacket *p)
>              }
>              break;
>          default:
> -            DPRINTF(s, 1, "Bad endpoint\n");
> +            DPRINTF(s, D_INFO, "Bad endpoint\n");
>              p->status =3D USB_RET_STALL;
>              break;
>          }
>          break;
>      default:
> -        DPRINTF(s, 1, "Bad token\n");
> +        DPRINTF(s, D_INFO, "Bad token\n");
>          p->status =3D USB_RET_STALL;
>          break;
>      }
> @@ -1285,7 +1286,7 @@ void ccid_card_send_apdu_to_guest(CCIDCardState
> *card,
>      Answer *answer;
>
>      if (!ccid_has_pending_answers(s)) {
> -        DPRINTF(s, 1, "CCID ERROR: got an APDU without pending
> answers\n");
> +        DPRINTF(s, D_WARN, "CCID ERROR: got an APDU without pending
> answers\n");
>          return;
>      }
>      s->bmCommandStatus =3D COMMAND_STATUS_NO_ERROR;
> @@ -1295,7 +1296,7 @@ void ccid_card_send_apdu_to_guest(CCIDCardState
> *card,
>          ccid_report_error_failed(s, ERROR_HW_ERROR);
>          return;
>      }
> -    DPRINTF(s, 1, "APDU returned to guest %d (answer seq %d, slot %d)\n"=
,
> +    DPRINTF(s, D_TRACE, "APDU returned to guest %d (answer seq %d, slot
> %d)\n",
>          len, answer->seq, answer->slot);
>      ccid_write_data_block_answer(s, apdu, len);
>  }
> @@ -1317,7 +1318,7 @@ int ccid_card_ccid_attach(CCIDCardState *card)
>      USBDevice *dev =3D USB_DEVICE(qdev->parent_bus->parent);
>      USBCCIDState *s =3D USB_CCID_DEV(dev);
>
> -    DPRINTF(s, 1, "CCID Attach\n");
> +    DPRINTF(s, D_VERBOSE, "CCID Attach\n");
>      if (s->migration_state =3D=3D MIGRATION_MIGRATED) {
>          s->migration_state =3D MIGRATION_NONE;
>      }
> @@ -1330,7 +1331,7 @@ void ccid_card_ccid_detach(CCIDCardState *card)
>      USBDevice *dev =3D USB_DEVICE(qdev->parent_bus->parent);
>      USBCCIDState *s =3D USB_CCID_DEV(dev);
>
> -    DPRINTF(s, 1, "CCID Detach\n");
> +    DPRINTF(s, D_VERBOSE, "CCID Detach\n");
>      if (ccid_card_inserted(s)) {
>          ccid_on_slot_change(s, false);
>      }
> @@ -1345,7 +1346,7 @@ void ccid_card_card_error(CCIDCardState *card,
> uint64_t error)
>
>      s->bmCommandStatus =3D COMMAND_STATUS_FAILED;
>      s->last_answer_error =3D error;
> -    DPRINTF(s, 1, "VSC_Error: %" PRIX64 "\n", s->last_answer_error);
> +    DPRINTF(s, D_INFO, "VSC_Error: %" PRIX64 "\n", s->last_answer_error)=
;
>

I'd keep WARN here too


>      /* TODO: these errors should be more verbose and propagated to the
> guest.*/
>      /*
>       * We flush all pending answers on CardRemove message in
> ccid-card-passthru,
> --
>
--=20
Marc-Andr=C3=A9 Lureau
