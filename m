Received: from eggs.gnu.org ([2001:4830:134:3::10]:37779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPUNE-0007di-39
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:16:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPUN9-0003fq-Oa
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:16:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPUN9-0003fi-F8
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:15:55 -0500
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
	<1483692945-9866-2-git-send-email-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e1b2f938-781d-5ae5-bb08-81084386d3e4@redhat.com>
Date: Fri, 6 Jan 2017 07:15:52 -0600
MIME-Version: 1.0
In-Reply-To: <1483692945-9866-2-git-send-email-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xh460jGPqvLiVhQ1sSXs5oi9HTUx0fqsc"
Subject: Re: [Qemu-devel] [PATCH 01/17] Add wctablet device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: avg.tolik@gmail.com, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xh460jGPqvLiVhQ1sSXs5oi9HTUx0fqsc
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: avg.tolik@gmail.com, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <e1b2f938-781d-5ae5-bb08-81084386d3e4@redhat.com>
Subject: Re: [PATCH 01/17] Add wctablet device
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
 <1483692945-9866-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-2-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/06/2017 02:55 AM, Gerd Hoffmann wrote:
> From: Anatoli Huseu1 <avg.tolik@gmail.com>
>=20
> [ kraxel: adapt to chardev changes ]

More chardev changes are in the pipeline, thanks to:
https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg00606.html

Will be some interesting merge conflicts to resolve between these two.

I see that this code does not match our current style very well, and
that later patches in the series aim to clean that up. Please point it
out in the commit message that this was done intentionally, or else
squash the cleanups directly into this patch.

>=20
> Signed-off-by: Anatoli Huseu1 <avg.tolik@gmail.com>
> ---
>  backends/Makefile.objs   |   2 +-
>  backends/wctablet.c      | 347 +++++++++++++++++++++++++++++++++++++++=
++++++++
>  docs/qdev-device-use.txt |   2 +-
>  qapi-schema.json         |   1 +
>  qemu-char.c              |   1 +
>  5 files changed, 351 insertions(+), 2 deletions(-)
>  create mode 100644 backends/wctablet.c
>=20

> +++ b/backends/wctablet.c
> @@ -0,0 +1,347 @@
> +/*
> + * QEMU Wacome serial tablet emulation
> + *
> + * Copyright (c) 2008 Lubomir Rintel

Wow, that's a long time for this code to be waiting.


> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/time.h>
> +#include <time.h>

Please don't include system headers until after osdep.h has been
included; and some (all?) of these headers are already covered by osdep.h=
=2E

> +
> +#include "qemu/osdep.h"

See HACKING for rationale why this should be first.

> +#include "qemu-common.h"
> +#include "sysemu/char.h"
> +#include "ui/console.h"
> +#include "ui/input.h"
> +
> +
> +#define DEBUG_WCTABLET_MOUSE
> +
> +#ifdef DEBUG_WCTABLET_MOUSE
> +#define DPRINTF(fmt, ...) \
> +do { fprintf(stderr, fmt , ## __VA_ARGS__); } while (0)

No space after fmt

> +#else
> +#define DPRINTF(fmt, ...) \
> +do {} while (0)

Eww. This is prone to bitrot. If we stick with prints instead of trace
points, please rewrite it in a form that lets the compiler always
validate the arguments:

#ifdef DEBUG_WCTABLET_MOUSE
# define DEBUG_PRINT 1
#else
# define DEBUG_PRINT 0
#endif
#define DPRINTF(fmt, ...) \
  do { \
    if (DEBUG_PRINT) { \
      fprintf(stderr, fmt, ## __VA_ARGS__); \
    } \
  while (0)


> +
> +// Avaliable commands

s/Avaliable/Available/
Prefer C89 /* */ comments. Has this passed our scripts/checkpatch.pl?

> +uint8_t wctablet_commands[WC_COMMANDS_COUNT][7] =3D {

const?

> +    {0x0a, 0x53, 0x50, 0x0a, 0},                // \nSP\n

Again, comment style.

> +    {0x7e, 0x23, 0},                            // ~#
> +    {0x0a, 0x54, 0x45, 0x0a, 0},                // \nTE\n
> +    {0x52, 0x45, 0x0a, 0},                      // RE\n
> +    {0x41, 0x53, 0x31, 0x0a, 0},                // AS1\n
> +    {0x49, 0x43, 0x31, 0x0a, 0},                // IC1\n
> +    {0x4f, 0x43, 0x31, 0x0a, 0},                // OC1\n
> +    {0x49, 0x54, 0x88, 0x88, 0},                // IT3\r
> +    {0x53, 0x55, 0x88, 0x88, 0},                // SU3\n
> +    {0x50, 0x48, 0x31, 0x0a, 0},                // PH1\n
> +    {0x0d, 0x53, 0x54, 0x0d, 0},                // \rST\n
> +    {0x0d, 0x53, 0x50, 0x0d, 0},                // \rSP\r
> +    {0x54, 0x45, 0x0d, 0},                      // TE\r
> +    {0x53, 0x50, 0x88, 0},                      // SP\n
> +    {0x23, 0x41, 0x4c, 0x31, 0x0d, 0},          // #AL1\r
> +    {0x53, 0x54, 0x88, 0},                      // ST\n
> +    {0x0d, 0x54, 0x53, 0x88, 0xd, 0},           // \rTS&\r
> +    {0x0d, 0x0a, 0x53, 0x50, 0x0d, 0x0a, 0},    // \r\nSP\r\n
> +    {0x7e, 0x23, 0x0d, 0}                       // ~#\r
> +};
> +
> +// Char strings with avaliable commands

s/avaliable/available/, and comment style (I'll quit pointing that out)

> +char wctablet_commands_names[WC_COMMANDS_COUNT][12] =3D {

const?

> +// This structure is used to save private info for Wacom Tablet.
> +typedef struct {
> +    struct QEMUTimer *transmit_timer;
> +    /* QEMU timer */
> +    uint64_t transmit_time;
> +    /* time to transmit a char in ticks */
> +    uint8_t query[100];

Magic number?


> +static void wctablet_event(void *opaque, int x,
> +                           int y, int dz, int buttons_state)
> +{
> +    CharDriverState *chr =3D (CharDriverState *) opaque;
> +    TabletState *tablet =3D (TabletState *) chr->opaque;
> +    uint8_t codes[8] =3D { 0xe0, 0, 0, 0, 0, 0, 0 };
> +    // uint8_t codes[8] =3D { 0xa0, 0x0e, 0x06, 0x00, 0x13, 0x3b, 0x00=
 };
> +    // uint8_t codes[8] =3D { 0xe0, 0x05, 0x6a, 0x00, 0x06, 0x64, 0x40=
 };
> +    // uint8_t codes[8] =3D { 0xa0, 0x1c, 0x29, 0x00, 0x19, 0x1c, 0x00=
 };

Why the dead-code comments?

> +static void wctablet_handler(void *opaque)
> +{
> +    CharDriverState *chr =3D (CharDriverState *) opaque;
> +    TabletState *tablet =3D (TabletState *) chr->opaque;
> +    int len, canWrite; // , i;

and again

> +
> +    canWrite =3D qemu_chr_be_can_write(chr);
> +    len =3D canWrite;
> +    if (len > tablet->outlen) {
> +        len =3D tablet->outlen;
> +    }
> +
> +    if (len) {
> +        // DPRINTF("-------- Write %2d: ", canWrite);
> +        // for (i =3D 0; i < len; i++) {
> +        //     DPRINTF(" %02x", tablet->outbuf[i]);
> +        // }
> +        // DPRINTF("\n");

and again

> +++ b/qapi-schema.json
> @@ -3879,6 +3879,7 @@
>                                         'null'   : 'ChardevCommon',
>                                         'mux'    : 'ChardevMux',
>                                         'msmouse': 'ChardevCommon',
> +                                       'wctablet' : 'ChardevCommon',

Missing documentation with a Since 2.9 tag.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--xh460jGPqvLiVhQ1sSXs5oi9HTUx0fqsc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb5iIAAoJEKeha0olJ0NqoB4IAKLi2JiR7LRj2LPbMQ3qGRfb
siZVOYELcYccuPqcZEXMNmuBIR0HudpmHn1G8EFOoZ8Rj1nF89XNdsFmKnr6xN/T
oDfmC8fPwkVDZjAjzZ71gJnjkgEypMy2aRuLzvFi1uuImhh7sDAaUtjJ7bom3eQK
528YuOCiWsAXAn/itKFMmS/TupXNGMQE/mW22Z+X8A7JhAQ4VOhm3pjfNm4/fQCz
2khgkK0jqije7oRmL72tpn9T91CUprcp9NsJvllJWOWfxBOz871KPsHx5tb5t8eG
+bouQujysC8dzwzujiqdo6ppreQZMMFaKSUrBph2rX3QDv9wQf8EHvhJ7M3Fe1c=
=+lwL
-----END PGP SIGNATURE-----

--xh460jGPqvLiVhQ1sSXs5oi9HTUx0fqsc--
