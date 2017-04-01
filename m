Received: from eggs.gnu.org ([2001:4830:134:3::10]:43231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cuKMy-0002K2-2M
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cuKMt-0000MU-0U
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:51:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cuKMs-0000LJ-NX
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:51:06 -0400
References: <CA+KKJYBN3Gu5jzToi61Qf2Un7jOTzB0HcfREnniUQhTe9B=GGg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4a433007-eced-0128-f6c9-adffa2d88a9e@redhat.com>
Date: Sat, 1 Apr 2017 09:51:03 -0500
MIME-Version: 1.0
In-Reply-To: <CA+KKJYBN3Gu5jzToi61Qf2Un7jOTzB0HcfREnniUQhTe9B=GGg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="stpv6UHqAftlW4tnKEqG05b0FtNAjGRuV"
Subject: Re: [Qemu-devel] [PATCH 02/43] arm: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Danil Antonov <g.danil.anto@gmail.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, balrogg@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--stpv6UHqAftlW4tnKEqG05b0FtNAjGRuV
From: Eric Blake <eblake@redhat.com>
To: Danil Antonov <g.danil.anto@gmail.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, balrogg@gmail.com
Message-ID: <4a433007-eced-0128-f6c9-adffa2d88a9e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/43] arm: made printf always compile in
 debug output
References: <CA+KKJYBN3Gu5jzToi61Qf2Un7jOTzB0HcfREnniUQhTe9B=GGg@mail.gmail.com>
In-Reply-To: <CA+KKJYBN3Gu5jzToi61Qf2Un7jOTzB0HcfREnniUQhTe9B=GGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/01/2017 08:32 AM, Danil Antonov wrote:
>>From 1671b92e5a4a59d5e38ce754d1d0dde2401c8236 Mon Sep 17 00:00:00 2001
> From: Danil Antonov <g.danil.anto@gmail.com>
> Date: Wed, 29 Mar 2017 02:09:33 +0300
> Subject: [PATCH 02/43] arm: made printf always compile in debug output
>=20
> Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
> This will ensure that printf function will always compile even if debug=

> output is turned off and, in turn, will prevent bitrot of the format
> strings.

Again, prefer present tense over past tense in the commit message.

>=20
> Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
> ---
>  hw/arm/strongarm.c | 17 +++++++++++------
>  hw/arm/z2.c        | 16 ++++++++++------
>  2 files changed, 21 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> index 3311cc3..88368ac 100644
> --- a/hw/arm/strongarm.c
> +++ b/hw/arm/strongarm.c
> @@ -59,11 +59,16 @@
>   - Enhance UART with modem signals
>   */
>=20
> -#ifdef DEBUG
> -# define DPRINTF(format, ...) printf(format , ## __VA_ARGS__)
> -#else
> -# define DPRINTF(format, ...) do { } while (0)
> -#endif
> +#ifndef DEBUG
> +#define DEBUG 0
> +#endif
> +
> +#define DPRINTF(fmt, ...)                         \
> +    do {                                          \
> +        if (DEBUG) {                              \
> +            fprintf(stderr, fmt, ## __VA_ARGS__); \

Again, changing from stdout to stderr should be mentioned as intentional
in the commit message.

Note that your change breaks the case of someone that used to do:

make CFLAGS=3D-DDEBUG=3D

because now it results in 'if ()' which is not valid syntax; likewise
for someone that used to do CFLAGS=3D-DDEBUG=3Dyes.  (Or put another way,=
 as
written, your patch forces someone to use -DDEBUG=3D0 or -DDEBUG=3D1).  A=

safer way is to make the 'if' condition a separate variable than the
command-line trigger, as in the following, so that regardless of what
DEBUG is defined to (including the empty string), you are only using
DEBUG in the preprocessor, while the if conditional is under your
complete control:

#ifdef DEBUG
# define DEBUG_PRINT 1
#else
# define DEBUG_PRINT 0
#endif

#definde DPRINTF()... if (DEBUG_PRINT)

> @@ -1022,7 +1027,7 @@ static void
> strongarm_uart_update_parameters(StrongARMUARTState
> *s)
>      s->char_transmit_time =3D  (NANOSECONDS_PER_SECOND / speed) * fram=
e_size;
>      qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
>=20
> -    DPRINTF(stderr, "%s speed=3D%d parity=3D%c data=3D%d stop=3D%d\n",=

> s->chr->label,

Oh gross - the old code couldn't even compile correctly when DEBUG was
defined (since printf(stderr) tries to treat the stderr pointer as a
format string)!  This is a definite cleanup, and an argument that your
switch from stdout to stderr is correct.


> +++ b/hw/arm/z2.c
> @@ -27,12 +27,16 @@
>  #include "exec/address-spaces.h"
>  #include "sysemu/qtest.h"
>=20
> -#ifdef DEBUG_Z2
> -#define DPRINTF(fmt, ...) \
> -        printf(fmt, ## __VA_ARGS__)
> -#else
> -#define DPRINTF(fmt, ...)
> -#endif
> +#ifndef DEBUG_Z2
> +#define DEBUG_Z2 0
> +#endif
> +
> +#define DPRINTF(fmt, ...)                                \
> +    do {                                                 \
> +        if (DEBUG_Z2) {                                  \

Again, it's best to separate your conditional to be something completely
under you control, while still allowing the command line freedom to
define DEBUG_Z2 to anything (whether an empty string or a non-numeric
value).

These types of comments probably apply throughout your entire series, so
it may be better if I wait for a v2 before reviewing too many more.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--stpv6UHqAftlW4tnKEqG05b0FtNAjGRuV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY375XAAoJEKeha0olJ0NqsuEH+gJEVYlfiY+6kOI1jHjxw7gy
0ewe7L1MW4PqlNEqa3B62S8bItqQXe8Z0XRPa1nxcj2LrWPSV7pzIz5g6w3K3C+F
ouooWSHtKgFVFUBhM1KcoscEfSsADmR7DpezpxSF7dZPq83Dr7nIxqF4YtoOWjFy
/mPpMAABn+SsWrytAItvMBVkT08cbtO95DRTao1VUUywscfK2Fj43RgbvtagsZBQ
06L8mapAszXVZi/CydhId38aLuWJ4Fkty9vud4tzZr/we2QLKzgYZ7UC1c1901+/
jjdGInNvbdWSrP0vt2gnxi3+DmGMd4huf3A3xwZRqIueEY/PY+20JBtC1t5InxU=
=uZCi
-----END PGP SIGNATURE-----

--stpv6UHqAftlW4tnKEqG05b0FtNAjGRuV--
