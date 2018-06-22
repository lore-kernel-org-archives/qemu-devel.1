Received: from eggs.gnu.org ([2001:4830:134:3::10]:53443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWF3N-0003Qw-D6
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 01:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWF3J-0005UC-H0
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 01:56:13 -0400
Date: Fri, 22 Jun 2018 15:03:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180622050334.GG612@umbus.fritz.box>
References: <1529642871-14214-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Content-Disposition: inline
In-Reply-To: <1529642871-14214-1-git-send-email-linux@roeck-us.net>
Subject: Re: [Qemu-devel] [PATCH] ppc: Fix sam460ex devicetree when booting
 the Linux kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Balaton, can you review this please.

On Thu, Jun 21, 2018 at 09:47:51PM -0700, Guenter Roeck wrote:
> sam4660ex (or at least this emulation) does not support the "ibm,cpm" pow=
er
> management. As a result, Linux crashes when trying to access it. Remove
> its devicetree node. Also, if/when we boot the Linux kernel directly,
> u-boot will not fix up serial frequencies in the devicetree file, and
> serial port initialization will fail. Add plausible frequency values to t=
he
> first serial port to be able to use it. Disable the second serial port
> since it is not available on the board.  Also set valid values for the
> other clock nodes otherwise set by u-boot.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/ppc/sam460ex.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index bdc53d2..045a255 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -308,6 +308,24 @@ static int sam460ex_load_device_tree(hwaddr addr,
>      qemu_fdt_setprop_cell(fdt, "/cpus/cpu@0", "timebase-frequency",
>                                tb_freq);
> =20
> +    /* Remove cpm node (not emulated) */
> +    qemu_fdt_nop_node(fdt, "/cpm");
> +    /* set serial port clock and speed */
> +    qemu_fdt_setprop_cell(fdt, "/plb/opb/serial@ef600300", "clock-freque=
ncy",
> +                              50000000);
> +    qemu_fdt_setprop_cell(fdt, "/plb/opb/serial@ef600300", "current-spee=
d",
> +                              38400);
> +    /* disable second serial port */
> +    qemu_fdt_setprop_string(fdt, "/plb/opb/serial@ef600400", "status",
> +                              "disabled");
> +    /* some more clocks */
> +    qemu_fdt_setprop_cell(fdt, "/plb", "clock-frequency",
> +                              50000000);
> +    qemu_fdt_setprop_cell(fdt, "/plb/opb", "clock-frequency",
> +                              50000000);
> +    qemu_fdt_setprop_cell(fdt, "/plb/opb/ebc", "clock-frequency",
> +                              50000000);
> +
>      rom_add_blob_fixed(BINARY_DEVICE_TREE_FILE, fdt, fdt_size, addr);
>      g_free(fdt);
>      ret =3D fdt_size;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlssgyMACgkQbDjKyiDZ
s5LFog/7Bw0OJwAWRjjh0X99HbXGSOpGYHLTKuWvnTVbhZ/VkQNIDpHoiQFHzwvz
ZyFLpEiXjnEyfcD7Rt7sZX1zrQkFDOyfKUnBFANsUp4zQZtYUvtbvoefsEKQ9cuj
zbInyyaZfEcSKMMeCSaZe6CdykCMrYAXErRGx/SDybnjGu9usojuE5KDPNFZnw4g
TqxALnupCM2ikjICDUKe+D7RI7h+1gFBqgpRLgEWnSmZSF9uOcwXCHaIi3Y694V/
H3uMgWY3hnada5vwYfwC1qtVHI1sfdtKjs+9RJnih3UxWF7Jdf7QFKTqRs2ANFxU
TkNrgi/6/TE2NHlfeGY5Cvo1w6GQLyk117s55zrDkxbPgJrifzAdItlNJcfnw2/m
lKUFl13HO8Ea0DBLSyrOXx9IjTMwvUtov+XBJGf8p20eOf/mozX9/JTA9je/J/xe
EJ05ebrEUMMpw2oEVDWfEqxopnXM1BjGhszzdVga74qaozdvX2tHa1GLmzL15ies
JGtMgtsu16NqkEsVrA22Vp4nFUGine5hHfzh+jUnD24ySeYBZOliFhsNJ9Lj8509
5pTxWrFt2qHARv4o8EG256xZkAoFt7QOCLM6dX+sas6LmjM/qb4xcPPu3X2haD05
6cUh7LE3nJCxXAJQJKEpZbDNEHfRCsU7jWoEFGk2K0aSExWvKW8=
=zWWa
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
