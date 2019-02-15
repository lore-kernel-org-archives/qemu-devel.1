Received: from eggs.gnu.org ([209.51.188.92]:45058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gubTM-00028X-Cd
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:16:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gubTL-00047e-Mb
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:16:00 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gubTL-00046J-FA
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:15:59 -0500
Received: by mail-qk1-f196.google.com with SMTP id u188so5429056qkh.8
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 03:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20190214201939.494-1-philmd@redhat.com>
	<20190214201939.494-4-philmd@redhat.com>
In-Reply-To: <20190214201939.494-4-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 15 Feb 2019 12:15:47 +0100
Message-ID: <CAMxuvazotQC+WOrpw=R69pmiMN_nq0cWqpXEtt2suXgiipxz_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/9] ccid-card-passthru: Assert on a
 stricter expression
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
>  hw/usb/ccid-card-passthru.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index 1676b5fc05..0c44b38fc2 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -270,7 +270,7 @@ static void ccid_card_vscard_read(void *opaque, const=
 uint8_t *buf, int size)
>      VSCMsgHeader *hdr;
>
>      assert(size <=3D VSCARD_IN_SIZE - card->vscard_in_pos);
> -    assert(card->vscard_in_hdr < VSCARD_IN_SIZE);
> +    assert(card->vscard_in_hdr < card->vscard_in_pos);


I think you need "<=3D".

card->vscard_in_hdr is updated in the loop and may reach card->vscard_in_po=
s:

    while ((card->vscard_in_pos - card->vscard_in_hdr >=3D sizeof(VSCMsgHea=
der))
         &&(card->vscard_in_pos - card->vscard_in_hdr >=3D
                                  sizeof(VSCMsgHeader) + ntohl(hdr->length)=
)) {
...
        card->vscard_in_hdr +=3D hdr->length + sizeof(VSCMsgHeader);
...
    }

if "hdr->length + sizeof(VSCMsgHeader)" =3D=3D "card->vscard_in_pos -
card->vscard_in_hdr", card->vscard_in_hdr =3D=3D card->vscard_in_pos after
the loop.


I think the existing assert() could also stay.

>      memcpy(card->vscard_in_data + card->vscard_in_pos, buf, size);
>      card->vscard_in_pos +=3D size;
>      hdr =3D (VSCMsgHeader *)(card->vscard_in_data + card->vscard_in_hdr)=
;
> --
> 2.20.1
>
