Received: from eggs.gnu.org ([209.51.188.92]:41010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gubGL-0007nt-2N
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gubGI-0005HC-Lp
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:02:32 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gubGI-000588-F6
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:02:30 -0500
Received: by mail-qt1-f194.google.com with SMTP id b8so10320064qtr.9
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 03:02:20 -0800 (PST)
MIME-Version: 1.0
References: <20190214201939.494-1-philmd@redhat.com>
	<20190214201939.494-2-philmd@redhat.com>
In-Reply-To: <20190214201939.494-2-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 15 Feb 2019 12:02:08 +0100
Message-ID: <CAMxuvawmOw09LTpTEhF1u=eF_Ja9Di=u7htkQ13O2e=XP6tD-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/9] ccid-card-passthru: Move assertion
 in read() to can_read()
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

On Thu, Feb 14, 2019 at 9:19 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> chardev::read() depends of what chardev::can_read() returns, move the
> assertion to can_read().
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Moving to can_read() makes sense, because nothing (except the chardev
BREAK event) should update vscard_in_pos between the can_read() and
read() callback.

Changing the condition from < to <=3D could use some explanation. The
can_read() callback should handle the case where the vscard_in buffer
is full (adding =3D is necessary). And the read() callback should not be
called with size =3D=3D 0, when card->vscard_in_pos =3D=3D VSCARD_IN_SIZE (=
no
data to read).

But it wouldn't harm to leave the existing assert().

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>





> ---
>  hw/usb/ccid-card-passthru.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index 0a6c657228..8bb1314f49 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -116,8 +116,8 @@ static int ccid_card_vscard_can_read(void *opaque)
>  {
>      PassthruState *card =3D opaque;
>
> -    return VSCARD_IN_SIZE >=3D card->vscard_in_pos ?
> -           VSCARD_IN_SIZE - card->vscard_in_pos : 0;
> +    assert(card->vscard_in_pos <=3D VSCARD_IN_SIZE);
> +    return VSCARD_IN_SIZE - card->vscard_in_pos;
>  }
>
>  static void ccid_card_vscard_handle_init(
> @@ -282,7 +282,6 @@ static void ccid_card_vscard_read(void *opaque, const=
 uint8_t *buf, int size)
>          ccid_card_vscard_drop_connection(card);
>          return;
>      }
> -    assert(card->vscard_in_pos < VSCARD_IN_SIZE);
>      assert(card->vscard_in_hdr < VSCARD_IN_SIZE);
>      memcpy(card->vscard_in_data + card->vscard_in_pos, buf, size);
>      card->vscard_in_pos +=3D size;
> --
> 2.20.1
>
