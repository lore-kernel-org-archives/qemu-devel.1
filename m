Received: from eggs.gnu.org ([2001:4830:134:3::10]:41189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch6Z8-0004jX-QT
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 22:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch6Z7-0000MS-Ml
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 22:29:06 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:45189)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ch6Z6-0000I2-KE
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 22:29:05 -0500
Date: Fri, 24 Feb 2017 14:28:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170224032829.GP17615@umbus.fritz.box>
References: <3d5e7b5e-4501-86b7-093d-47fb09af585e@redhat.com>
	<CAFEAcA9gcArSqhbRi6-YdR=5eE9dtq66C7N0qTbCuBiY_Zr+tA@mail.gmail.com>
	<41630a89-e645-7d7e-b7c2-356fd6dcadee@redhat.com>
	<CAFEAcA_Mh9ZrJeu4f==ko1k2yLkfPe2AwNbUHcxkmS6Lzuvk0Q@mail.gmail.com>
	<2565ef99-9c16-e836-08c6-0915f5d4b0f8@redhat.com>
	<CAFEAcA_BgiXrjW9aRNFkXEEjS+kjibJ_UisJtiLgrPh=0re5qA@mail.gmail.com>
	<c76578aa-ec76-f904-b0fc-72676e4ce515@redhat.com>
	<CAFEAcA_waGB88XyzGxFbE_OyLAPnY70aEVQYzbS0k3KR+FF9DA@mail.gmail.com>
	<dac5dcb6-7beb-1c33-0a4e-b7977fce69b6@redhat.com>
	<df4e14ad-acd9-151e-f4a1-9cab24063b83@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WOTjKnJ88wpJKlWH"
Content-Disposition: inline
In-Reply-To: <df4e14ad-acd9-151e-f4a1-9cab24063b83@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] memory: make ram device read/write endian
 sensitive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, zhong@linux.vnet.ibm.com, Paul Mackerras <paulus@samba.org>


--WOTjKnJ88wpJKlWH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 01:14:09AM +0800, Yongji Xie wrote:
> on 2017/2/24 0:15, Paolo Bonzini wrote:
>=20
> >=20
> > On 23/02/2017 17:08, Peter Maydell wrote:
> > > On 23 February 2017 at 15:58, Paolo Bonzini <pbonzini@redhat.com> wro=
te:
> > > > However, DEVICE_NATIVE_ENDIAN would have to be paired with tswap, w=
hich
> > > > the current code does not do, hence the bug.  To have no swap at al=
l,
> > > > you'd need DEVICE_HOST_ENDIAN.
> > > Yes, I agree that the current ramdevice code has this bug (and
> > > that we can fix it by any of the various options).
> > Good. :)
> >=20
> > > > > AIUI what we want for this VFIO case is "when the guest does
> > > > > a 32-bit write of 0x12345678 then the bytes are 0x12 0x34 0x56 0x=
78
> > > > > regardless of whether TARGET_BIG_ENDIAN or not".
> > > > No, I don't think so.  This is not specific to VFIO.  You can do it=
 with
> > > > any device, albeit VFIO is currently the only one using ramd region=
s.
> > > The commit message in the patch that started this thread off
> > > says specifically that "VFIO PCI device is little endian".
> > > Is that wrong?
> > Yes, I think it's a red herring.  Hence my initial confusion, when I
> > asked "would Yongji's patch just work if it used DEVICE_BIG_ENDIAN and
> > beNN_to_cpu/cpu_to_beNN".
> >=20
>=20
> Thank you for the great discussion. I have a better understanding of the
> endianness now.:-)
>=20
> And for the commit message, I was wrong to assume the same endianness
> as vfio. That's my fault. This bug should happen when target and host
> endianness are different regardless of the device endianness.
>=20
> To fix it, introducing DEVICE_HOST_ENDIAN for the ram device seems to be
> more reasonable than other ways. I think I'll update the patch with this
> way.

I think this is basically the right approach, with the only caveat
being whether we want to call it "host endian" or something else.

> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index bd15853..eef74df 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -36,6 +36,12 @@ enum device_endian {
>      DEVICE_LITTLE_ENDIAN,
>  };
>=20
> +#if defined(HOST_WORDS_BIGENDIAN)
> +#define DEVICE_HOST_ENDIAN DEVICE_BIG_ENDIAN
> +#else
> +#define DEVICE_HOST_ENDIAN DEVICE_LITTLE_ENDIAN
> +#endif
> +
>  /* address in the RAM (different from a physical address) */
>  #if defined(CONFIG_XEN_BACKEND)
>  typedef uint64_t ram_addr_t;
> diff --git a/memory.c b/memory.c
> index ed8b5aa..17cfada 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1180,7 +1180,7 @@ static void memory_region_ram_device_write(void
> *opaque, hwaddr addr,
>  static const MemoryRegionOps ram_device_mem_ops =3D {
>      .read =3D memory_region_ram_device_read,
>      .write =3D memory_region_ram_device_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_HOST_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 1,
>          .max_access_size =3D 8,
>=20
> Thanks,
> Yongji
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WOTjKnJ88wpJKlWH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYr6hdAAoJEGw4ysog2bOSWXcP/jqo8KAuzlQ7taEBgSgblpwJ
s6xn7W4wrtxvxmBX+YfO5kQUihhIS8EpmVqbF77QLyPQxqnHcy+utViAYzbHOBQl
rzAbQKGYurku8axmb9Y6BfLIgpVALn4jljrNElc27pNKAYZ/5XpAzLY48PyuCp+B
h5IDfVcCCMpF3x7712mGJXWzYMho0UuKMblhs29ClP45tsU3nGS6TGpPWzotGTfH
6odcbd4f2CB9BNR838UOSaZpv7binTMFH8dqUBpu+3pe9s/zt82KK0Z8Y/AmRRXZ
s+5UEbcjJhTBKdFW+FBiQiJhrdyp2YmpPfVfqNqSbXgk7KyfvvxQAci04NIg2lhk
CtrpdnPsz2qhHsDo3EFuNhCtkZIYl7onxZsGsV5rmj7CEY80aWqfyu1T86dMkkJi
nFWAkmwz84Ym1rGtgxBB3ABYqrqMd+qICzBgwvPlxr6y24E+1U5dkfk5NLF3eNJ4
gJx7NNg3lszTmsFvuMpOY4BgIES9F1cnV1l12r1YYuH/D5GkcRg+MWkRzkfJrhkL
e3/yXufkrM7khj5g8eFPwWGVaZkDoqjuhJarC4eTNw9VSyRxjym/f5pewt2adfHj
0zaFyp0wKpmr2SUya+flEQIhphvy9mtLH7vZDJkA5ivw3XQPdTukGiFsIwuUBsXG
2lb9BAPDI0LewYlJPOQ2
=KbkD
-----END PGP SIGNATURE-----

--WOTjKnJ88wpJKlWH--
