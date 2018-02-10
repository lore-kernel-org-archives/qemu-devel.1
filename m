Received: from eggs.gnu.org ([2001:4830:134:3::10]:45860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekPXP-0006ir-Td
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekPXK-0001Ds-Rd
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:25:31 -0500
Date: Sat, 10 Feb 2018 18:18:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180210071813.GL11634@umbus.fritz.box>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
	<20180209185142.17151-2-mark.cave-ayland@ilande.co.uk>
	<bb007cd9-8733-f8ee-2529-438a27c5b973@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8SdtHY/0P4yzaavF"
Content-Disposition: inline
In-Reply-To: <bb007cd9-8733-f8ee-2529-438a27c5b973@amsat.org>
Subject: Re: [Qemu-devel] [PATCHv2 01/12] cuda: do not use old_mmio accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com


--8SdtHY/0P4yzaavF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 05:05:23PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Mark,
>=20
> On 02/09/2018 03:51 PM, Mark Cave-Ayland wrote:
> > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > ---
> >  hw/misc/macio/cuda.c | 40 ++++++++--------------------------------
> >  1 file changed, 8 insertions(+), 32 deletions(-)
> >=20
> > diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> > index 008d8bd4d5..6631017ca2 100644
> > --- a/hw/misc/macio/cuda.c
> > +++ b/hw/misc/macio/cuda.c
> > @@ -275,7 +275,7 @@ static void cuda_delay_set_sr_int(CUDAState *s)
> >      timer_mod(s->sr_delay_timer, expire);
> >  }
> > =20
> > -static uint32_t cuda_readb(void *opaque, hwaddr addr)
> > +static uint64_t cuda_read(void *opaque, hwaddr addr, unsigned size)
> >  {
> >      CUDAState *s =3D opaque;
> >      uint32_t val;
> > @@ -350,7 +350,7 @@ static uint32_t cuda_readb(void *opaque, hwaddr add=
r)
> >      return val;
> >  }
> > =20
> > -static void cuda_writeb(void *opaque, hwaddr addr, uint32_t val)
> > +static void cuda_write(void *opaque, hwaddr addr, uint64_t val, unsign=
ed size)
> >  {
> >      CUDAState *s =3D opaque;
> > =20
> > @@ -780,38 +780,14 @@ static void cuda_receive_packet_from_host(CUDASta=
te *s,
> >      }
> >  }
> > =20
> > -static void cuda_writew (void *opaque, hwaddr addr, uint32_t value)
> > -{
> > -}
> > -
> > -static void cuda_writel (void *opaque, hwaddr addr, uint32_t value)
> > -{
> > -}
> > -
> > -static uint32_t cuda_readw (void *opaque, hwaddr addr)
> > -{
> > -    return 0;
> > -}
> > -
> > -static uint32_t cuda_readl (void *opaque, hwaddr addr)
> > -{
> > -    return 0;
> > -}
> > -
> >  static const MemoryRegionOps cuda_ops =3D {
> > -    .old_mmio =3D {
> > -        .write =3D {
> > -            cuda_writeb,
> > -            cuda_writew,
> > -            cuda_writel,
> > -        },
> > -        .read =3D {
> > -            cuda_readb,
> > -            cuda_readw,
> > -            cuda_readl,
> > -        },
> > +    .read =3D cuda_read,
> > +    .write =3D cuda_write,
> > +    .endianness =3D DEVICE_BIG_ENDIAN,
> > +    .valid =3D {
>=20
> This change the device behavior, previously 16/32bit access were
> ignored, now they are illegal.

This change looks correct to me.  As you note >1 byte accesses were
previously ignored - not broken or handled in any other way.  That
means there's no possibility using >1byte accesses could ever
accomplish, so it reads to me as being invalid.  I'd say the fact that
it previously didn't generate some sort of error is the bug.

> Using ".impl" instead also change the behavior, since 16/32bits access
> would be processed (as 2x or 4x 8bit access).
>=20
> A comment "this change is safe because ..." would reassure me ;)
>=20
> > +        .min_access_size =3D 1,
> > +        .max_access_size =3D 1,
> >      },
> > -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> >  };
> > =20
> >  static bool cuda_timer_exist(void *opaque, int version_id)
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8SdtHY/0P4yzaavF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp+nLMACgkQbDjKyiDZ
s5KS3Q//QrZZn78av6dSNgWuR9zPljt6gK+dxbuzqlGLGjjbGGaE3A0ZC1Drb2Z1
xzZKLrmmhXtuaV2844ehUmdzCSTJ9iobHZjwa134OZwq/ZiZLoPHVRqK5WMhHdvV
jEIN4Ocfj4NHHmqZ17aqPM0jEkDLsC6IRyz+3lHZtoVpF8suXJW7+KS/6q8BGvEQ
ypDgkZEi4L6xDnHJZCLyaIAF/tSLiGHocdIC4L3cQx3duPd/OY0Kpe+YDt6NZ0OT
KMT+cKVyPqkt0v6NtKnhlLxXbRLHWh5AAuXG8pLbTG/+iLDTdc+6Rb9eB10YqW5j
YOOrhikHW6UqzXwXu/zDvurG4S4X9dSoW/khmsrqK/6yvXNn6dwcPo5pkHgUPdDX
RpZuxmTkM0wyOdv+gX483Qjjg3UViKb+azKgQLiNIVGGJhENovuh8mCN1X36TZHz
i4E729ucXoQfN8Vx0VtJ2dm9lCYrkFdjBELrPLt6PTx2lRl9C2s4ut/XX9cXv23T
vPqUXtsMQqJDXIXuwIEM6cqQn9yXWbp8KJppkTPiKntiwI+RuS9kN9ZxvY0/ADV+
Xyq/tYj8lTFo+qOFywCLbkVUHg7i2XmKNg9aTXDRDZOTpYSUmP9gyEO31aHqLfmr
0hzkqs/r5hqTrjoISKEyZE1MBiCJepSEaVtC8kbHuhILSSnc+10=
=00AX
-----END PGP SIGNATURE-----

--8SdtHY/0P4yzaavF--
