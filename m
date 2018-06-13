Received: from eggs.gnu.org ([2001:4830:134:3::10]:49874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT8SD-0005wY-KC
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT8SC-0000WN-Kt
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:17:01 -0400
References: <20180612104430.25745-1-kraxel@redhat.com>
	<20180612104430.25745-7-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <69ff0c99-803c-ff9f-737e-dbf0ae1019a6@redhat.com>
Date: Wed, 13 Jun 2018 18:16:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180612104430.25745-7-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 6/8] usb-ccid: fix bus leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Zhang Chen <zhangckid@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 12/06/2018 12:44, Gerd Hoffmann wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> qbus_create_inplace() creates a new reference in realize(), it must be
> released in unrealize().
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-id: 20180531195119.22021-4-marcandre.lureau@redhat.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Nope, that's only happening because patch 3 was wrong---and if we did
keep patch 3, you would have to do it in all devices that produce buses;
not just this one.

Paolo

> ---
>  hw/usb/dev-smartcard-reader.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reade=
r.c
> index 2131e33d27..f7c91230d5 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -1147,6 +1147,7 @@ static void ccid_unrealize(USBDevice *dev, Error =
**errp)
>      USBCCIDState *s =3D USB_CCID_DEV(dev);
> =20
>      ccid_bulk_in_clear(s);
> +    object_unref(OBJECT(&s->bus));
>  }
> =20
>  static void ccid_flush_pending_answers(USBCCIDState *s)
>=20
