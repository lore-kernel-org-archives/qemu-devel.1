Received: from eggs.gnu.org ([209.51.188.92]:51931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gubu0-0006xn-6x
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gubtu-0000iC-Bj
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:43:28 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gubts-0000cG-GZ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:43:24 -0500
Received: by mail-qt1-f196.google.com with SMTP id v10so10468436qtp.8
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 03:43:23 -0800 (PST)
MIME-Version: 1.0
References: <20190214201939.494-1-philmd@redhat.com>
	<20190214201939.494-5-philmd@redhat.com>
In-Reply-To: <20190214201939.494-5-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 15 Feb 2019 12:43:12 +0100
Message-ID: <CAMxuvazqxBh5Ma7BrisUQdFrm-hF3tvr9O9=zNBZbE2inc0bHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/9] ccid-card-passthru: Let the
 chardev::read() be more generic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Prasad J Pandit <pjp@fedoraproject.org>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Thu, Feb 14, 2019 at 9:20 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/usb/ccid-card-passthru.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index 0c44b38fc2..ba7c285ded 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -285,8 +285,14 @@ static void ccid_card_vscard_read(void *opaque, cons=
t uint8_t *buf, int size)
>          card->vscard_in_hdr +=3D hdr->length + sizeof(VSCMsgHeader);
>          hdr =3D (VSCMsgHeader *)(card->vscard_in_data + card->vscard_in_=
hdr);
>      }
> -    if (card->vscard_in_hdr =3D=3D card->vscard_in_pos) {
> -        card->vscard_in_pos =3D card->vscard_in_hdr =3D 0;

Interesting, it looks like we could end in a blocking condition today.

card->vscard_in_pos - card->vscard_in_hdr could not have enough room
to process an incoming message. After filling the buffer, it would
stop reading.

> +
> +    /* Drop any messages that were fully processed.  */
> +    if (card->vscard_in_hdr > 0) {
> +        memmove(card->vscard_in_data,
> +                card->vscard_in_data + card->vscard_in_hdr,
> +                card->vscard_in_pos - card->vscard_in_hdr);
> +        card->vscard_in_pos -=3D card->vscard_in_hdr;
> +        card->vscard_in_hdr =3D 0;
>      }
>  }

At least, by moving data around, this would leave always enough space
for the header to be fully read.

But I think we should add a condition like
card->vscard_in_hdr + hdr->length + sizeof(VSCMsgHeader) <=3D
VSCARD_IN_SIZE, to make sure the incoming message fits in the
vscard_in_data buffer, else disconnect?

>
> --
> 2.20.1
>
