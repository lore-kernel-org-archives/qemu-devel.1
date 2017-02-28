Received: from eggs.gnu.org ([2001:4830:134:3::10]:41009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciVqr-0000bE-K1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciVqq-0006La-FU
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:41:13 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:40597)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ciVqq-0006HR-1h
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:41:12 -0500
Date: Tue, 28 Feb 2017 11:41:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170228004101.GG17615@umbus.fritz.box>
References: <1488171164-28319-1-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3LkAFa4R1oQZ/xxz"
Content-Disposition: inline
In-Reply-To: <1488171164-28319-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] memory: Introduce DEVICE_HOST_ENDIAN
 for ram device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, qemu-devel@nongnu.org, alex.williamson@redhat.com, aik@ozlabs.ru, peter.maydell@linaro.org, paulus@samba.org, mdroth@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com


--3LkAFa4R1oQZ/xxz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2017 at 12:52:44PM +0800, Yongji Xie wrote:
> At the moment ram device's memory regions are DEVICE_NATIVE_ENDIAN. It's
> incorrect. This memory region is backed by a MMIO area in host, so the
> uint64_t data that MemoryRegionOps read from/write to this area should be
> host-endian rather than target-endian. Hence, current code does not work
> when target and host endianness are different which is the most common ca=
se
> on PPC64. To fix it, this introduces DEVICE_HOST_ENDIAN for the ram devic=
e.
>=20
> This has been tested on PPC64 BE/LE host/guest in all possible combinatio=
ns
> including TCG.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

The effect of the patch is certainly correct.  I remain a little
concerned that the name "host endian" might cause more confusion than
it resolves, but a better term isn't immediately obvious to me.

> ---
>  include/exec/cpu-common.h |    6 ++++++
>  memory.c                  |    2 +-
>  2 files changed, 7 insertions(+), 1 deletions(-)
>=20
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index bd15853..eef74df 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -36,6 +36,12 @@ enum device_endian {
>      DEVICE_LITTLE_ENDIAN,
>  };
> =20
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
> @@ -1180,7 +1180,7 @@ static void memory_region_ram_device_write(void *op=
aque, hwaddr addr,
>  static const MemoryRegionOps ram_device_mem_ops =3D {
>      .read =3D memory_region_ram_device_read,
>      .write =3D memory_region_ram_device_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_HOST_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 1,
>          .max_access_size =3D 8,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3LkAFa4R1oQZ/xxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYtMcdAAoJEGw4ysog2bOSCQsP/3UX1GVZUxARAmL9d6fZ0xnp
Xa2yGxw8r5irHK9gtOAtXaUV644Tg5gLx2GYzErP3QYiSC53LAmhg/Ns+LNfqcEC
mAsatihUiAbCoTGOeFSiVJ9Ql/s+DGLr90SObTXvl0u1PcI52MIY3T45DgZjjQ+9
Bf28wGcj/02xELWWyrEI6AxuaYVH4IUsOrm2oNmOp7qcrrpVM0KlLlz1x/mj0ibr
aVz21TniQIh0ji4sY+Nzxbqvc6FvjyfgeCCDSP6DX6T72EvDFpmCSF5qMZkIRyHB
bBVi2iNAIYq+mb3JWk8fF6x89wYkP7kLk0ZJfXCSVzmO+kvjh1WzOVQLAEtUKHqb
yYItD1svosgMLIjAjA4Dgil21PUPed1FAksVzgyZptG5MPC/sUNJnp7phq2E7F3f
9jCJZTevBu8klGkv2txE7I62svItqZu8k/3ocGvGtznDhBrZt2aDyeujSBprFVI1
jvWGUfix3WS7pR9faJLxSTpGyzH1y6+sM7xATn+lpgVdnI23SQpmJ9AKD6TO64SD
zMoy3Pp/DayQpws6zDQICRweixsLWtKCzYZhV/hCYfsm8E7eHns7lVyDJdkDlNKE
vEYEvNpmICi+x5ahvKoNoMVFuIYA2bDyGBghHP56y3Z8ZkGiHkkVElz/sSmtelF4
LrYJaRxuUKwKga2QyGr+
=7anB
-----END PGP SIGNATURE-----

--3LkAFa4R1oQZ/xxz--
