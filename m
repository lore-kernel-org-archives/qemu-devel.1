Received: from eggs.gnu.org ([209.51.188.92]:50728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLlmD-0006x5-8D
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLlm8-0007fF-LX
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:43:44 -0400
Date: Wed, 1 May 2019 10:43:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190501094331.GP29808@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<ff51c73e3095fa503d14aafece54f8565fe99900.1556666645.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff51c73e3095fa503d14aafece54f8565fe99900.1556666645.git.alistair.francis@wdc.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/5] hw/usb/hcd-xhci: Fix GCC 9 build
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alistair23@gmail.com" <alistair23@gmail.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

On Tue, Apr 30, 2019 at 11:28:31PM +0000, Alistair Francis wrote:
> Fix this build warning with GCC 9 on Fedora 30:
> hw/usb/hcd-xhci.c:3339:66: error: =E2=80=98%d=E2=80=99 directive output=
 may be truncated writing between 1 and 10 bytes into a region of size 5 =
[-Werror=3Dformat-truncation=3D]
>  3339 |             snprintf(port->name, sizeof(port->name), "usb2 port=
 #%d", i+1);
>       |                                                                =
  ^~
> hw/usb/hcd-xhci.c:3339:54: note: directive argument in the range [1, 21=
47483647]
>  3339 |             snprintf(port->name, sizeof(port->name), "usb2 port=
 #%d", i+1);
>       |                                                      ^~~~~~~~~~=
~~~~~
> In file included from /usr/include/stdio.h:867,
>                  from /home/alistair/qemu/include/qemu/osdep.h:99,
>                  from hw/usb/hcd-xhci.c:21:
> /usr/include/bits/stdio2.h:67:10: note: =E2=80=98__builtin___snprintf_c=
hk=E2=80=99 output between 13 and 22 bytes into a destination of size 16
>    67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVE=
L - 1,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
>    68 |        __bos (__s), __fmt, __va_arg_pack ());
>       |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/usb/hcd-xhci.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index ec28bee319..2b061772b2 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -3322,6 +3322,7 @@ static void usb_xhci_init(XHCIState *xhci)
>      usb_bus_new(&xhci->bus, sizeof(xhci->bus), &xhci_bus_ops, dev);
> =20
>      for (i =3D 0; i < usbports; i++) {
> +        g_assert(i < MAX(MAXPORTS_2, MAXPORTS_3));
>          speedmask =3D 0;
>          if (i < xhci->numports_2) {
>              if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {

I proposed a slightly different fix here:

  https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg02125.html

but both have the same effect


  Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
