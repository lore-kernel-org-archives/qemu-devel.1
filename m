Received: from eggs.gnu.org ([2001:4830:134:3::10]:42078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfBbE-0004pF-DL
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfBbD-0005Qc-71
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:59:36 -0400
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-5-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <484521bc-66a2-593a-a9c8-f71956d531e7@redhat.com>
Date: Tue, 8 Aug 2017 15:59:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170808183306.27474-5-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C5Vvr1Nh7xCf54gDoArV7BemSifT8nUIc"
Subject: Re: [Qemu-devel] [PATCH 4/9] ATAPI: Replace DEBUG_IDE_ATAPI with
 tracing events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C5Vvr1Nh7xCf54gDoArV7BemSifT8nUIc
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <484521bc-66a2-593a-a9c8-f71956d531e7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/9] ATAPI: Replace DEBUG_IDE_ATAPI with
 tracing events
References: <20170808183306.27474-1-jsnow@redhat.com>
 <20170808183306.27474-5-jsnow@redhat.com>
In-Reply-To: <20170808183306.27474-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 01:33 PM, John Snow wrote:
> Goodbye, printfs.
> Hello, fancy printfs.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  hw/ide/atapi.c            | 64 +++++++++++++++++----------------------=
--------
>  hw/ide/trace-events       | 19 ++++++++++++++
>  include/hw/ide/internal.h |  1 -
>  3 files changed, 42 insertions(+), 42 deletions(-)

> @@ -1330,16 +1310,18 @@ void ide_atapi_cmd(IDEState *s)
>      uint8_t *buf =3D s->io_buffer;
>      const struct AtapiCmd *cmd =3D &atapi_cmd_table[s->io_buffer[0]];
> =20
> -#ifdef DEBUG_IDE_ATAPI
> -    {
> +    trace_ide_atapi_cmd(s, s->io_buffer[0]);
> +
> +    if (TRACE_IDE_ATAPI_CMD_PACKET_ENABLED) {
> +        /* Each pretty-printed byte needs two bytes and a space; */
> +        char *ppacket =3D g_malloc(ATAPI_PACKET_SIZE * 3 + 1);

Nice use of an extra conditional to make a pretty trace without the
overhead when tracing is off.  (Oh yeah, you asked me on IRC how to do
it, and I pointed to commit bd6952a3 as the example)


> +++ b/hw/ide/trace-events
> @@ -6,6 +6,10 @@ ide_ioport_read(uint32_t addr, const char *reg, uint32=
_t val, void *bus, void *s
>  ide_ioport_write(uint32_t addr, const char *reg, uint32_t val, void *b=
us, void *s) "IDE PIO wr @ 0x%"PRIx32" (%s); val 0x%02"PRIx32"; bus %p ID=
EState %p"

Wouldn't it be nice if our trace generator would let us line-wrap?

> +# Warning: Verbose

Cute.  Should you also add it to the ide_data_* traces, per the commit
message in 3/9?

> +ide_atapi_cmd_packet(void *s, uint16_t limit, const char *packet) "IDE=
State: %p; limit=3D0x%x packet: %s"
> \ No newline at end of file

Umm, that should be fixed (I know that 'diff' uses both / and \ to
differentiate whether it was the pre- or post-patch version that had the
issue, but never remember which is which - so the fix may be in an
earlier patch).  Also fix the trace-events rebase for 3/9; with that,
you can add

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--C5Vvr1Nh7xCf54gDoArV7BemSifT8nUIc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmKJi4ACgkQp6FrSiUn
Q2oZKwf/QkviEj9SSW/jathQWVPj45qazyzooP9A/ncFBrsdnGkFhnkOQVzpRphs
WyLKmfRfSx0MIr3OY8Xi6mSyDcFZ/83+WveC0ks0Hz/HMY+yxmh4aWG31IcsPOY8
VOZnVWfF/Ls9spRHCBMX4zJns7c2Uw8VCxMtRmDjJ0CYOMmQLwSrY7w7qsuCFVYD
ZLx4xmGfS1u8OFUt7VFzjHFl+4NBPv5yPzrT/9G4B7G2HKJgBvedO1Xx9L6+qajn
cYDjP8BL50UZmnKH2sN8TLiL3MpmL2fVVBxVNn4Flv3m06Cxd2ft8AU1CupViTfP
FIut4gmoRODHRvohhY2nIQnbgefuFA==
=oEU4
-----END PGP SIGNATURE-----

--C5Vvr1Nh7xCf54gDoArV7BemSifT8nUIc--
