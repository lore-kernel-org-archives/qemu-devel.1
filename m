Received: from eggs.gnu.org ([2001:4830:134:3::10]:48091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cv15u-0002mp-8F
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cv15t-0002J6-8P
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:28:26 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cv15s-0002Im-TM
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:28:25 -0400
Received: by mail-lf0-x241.google.com with SMTP id v2so12707260lfi.2
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 05:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20170403105238.23262-1-kraxel@redhat.com>
In-Reply-To: <20170403105238.23262-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 03 Apr 2017 12:28:12 +0000
Message-ID: <CAJ+F1CJTyHh77iUz1_zqj9i89US2Gff1NndP=Fn4Ck-nHLYAvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] usb-host: switch to LIBUSB_API_VERSION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

Hi

On Mon, Apr 3, 2017 at 12:53 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> libusbx doesn't exist any more, the fork got merged back to libusb.  So
> stop using LIBUSBX_API_VERSION and use LIBUSB_API_VERSION instead.  For
> backward compatibility alias LIBUSB_API_VERSION to LIBUSBX_API_VERSION
> in case we figure LIBUSB_API_VERSION isn't defined.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>

looks good

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  hw/usb/host-libusb.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index c9876a5..f9c8eaf 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -159,7 +159,10 @@ static void usb_host_attach_kernel(USBHostDevice *s)=
;
>  #define BULK_TIMEOUT         0        /* unlimited */
>  #define INTR_TIMEOUT         0        /* unlimited */
>
> -#if LIBUSBX_API_VERSION >=3D 0x01000103
> +#ifndef LIBUSB_API_VERSION
> +# define LIBUSB_API_VERSION LIBUSBX_API_VERSION
> +#endif
> +#if LIBUSB_API_VERSION >=3D 0x01000103
>  # define HAVE_STREAMS 1
>  #endif
>
> @@ -269,7 +272,7 @@ static int usb_host_get_port(libusb_device *dev, char
> *port, size_t len)
>      size_t off;
>      int rc, i;
>
> -#if LIBUSBX_API_VERSION >=3D 0x01000102
> +#if LIBUSB_API_VERSION >=3D 0x01000102
>      rc =3D libusb_get_port_numbers(dev, path, 7);
>  #else
>      rc =3D libusb_get_port_path(ctx, dev, path, 7);
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
