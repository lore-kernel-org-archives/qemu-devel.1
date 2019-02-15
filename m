Received: from eggs.gnu.org ([209.51.188.92]:40496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gubFt-0007E3-8z
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gubDj-00020f-55
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:59:52 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gubDi-0001xu-OE
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:59:51 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so288240qtg.12
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 02:59:48 -0800 (PST)
MIME-Version: 1.0
References: <20190214201939.494-1-philmd@redhat.com>
	<20190214201939.494-3-philmd@redhat.com>
In-Reply-To: <20190214201939.494-3-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 15 Feb 2019 11:59:34 +0100
Message-ID: <CAMxuvawBXN3CwFhWwyUathUy-+SbURFAy_g8scf54UQx-j+84A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/9] ccid-card-passthru: Replace never
 trigger if statement by an assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Prasad J Pandit <pjp@fedoraproject.org>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Arash Tohidi Chafi <tohidi.arash@gmail.com>

Hi

On Thu, Feb 14, 2019 at 9:20 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The right side of the comparison is the return value of can_read():
> VSCARD_IN_SIZE - card->vscard_in_pos.
> Since the 'size' argument of chardev::read() is bound to
> what chardev::can_read() returns, this condition can never happen.

I think so too, because vscard_in_pos is unchanged between the 2
callbacks (or set to 0 in break event).

>
> Add an assertion, which will always fail if card->vscard_in_pos >=3D
> VSCARD_IN_SIZE), since size > 0.

If "size > VSCARD_IN_SIZE - card->vscard_in_pos" this is a chardev
bug. But which backend does that?

Iow, did we ever reach the "no room for data" error?

>
> This is a quick fix for CVE-2018-18438 "Integer overflow in
> ccid_card_vscard_read() allows memory corruption".

I have a hard time to find how that memory corruption can happen. It
would be a broken chardev (one calling qemu_chr_be_write() with a size
bigger than qemu_chr_be_can_write()). It would need to be fixed. But
which one does that?

>
> Fixes: CVE-2018-18438
> Reported-by: Arash Tohidi Chafi <tohidi.arash@gmail.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/usb/ccid-card-passthru.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index 8bb1314f49..1676b5fc05 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -264,24 +264,12 @@ static void ccid_card_vscard_handle_message(Passthr=
uState *card,
>      }
>  }
>
> -static void ccid_card_vscard_drop_connection(PassthruState *card)
> -{
> -    qemu_chr_fe_deinit(&card->cs, true);
> -    card->vscard_in_pos =3D card->vscard_in_hdr =3D 0;
> -}
> -
>  static void ccid_card_vscard_read(void *opaque, const uint8_t *buf, int =
size)
>  {
>      PassthruState *card =3D opaque;
>      VSCMsgHeader *hdr;
>
> -    if (card->vscard_in_pos + size > VSCARD_IN_SIZE) {
> -        error_report("no room for data: pos %u +  size %d > %" PRId64 ".=
"
> -                     " dropping connection.",
> -                     card->vscard_in_pos, size, VSCARD_IN_SIZE);
> -        ccid_card_vscard_drop_connection(card);
> -        return;
> -    }
> +    assert(size <=3D VSCARD_IN_SIZE - card->vscard_in_pos);
>      assert(card->vscard_in_hdr < VSCARD_IN_SIZE);
>      memcpy(card->vscard_in_data + card->vscard_in_pos, buf, size);
>      card->vscard_in_pos +=3D size;
> --
> 2.20.1
>
