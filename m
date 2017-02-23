Received: from eggs.gnu.org ([2001:4830:134:3::10]:40564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjke-0003vx-Kj
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjkd-0005MM-ID
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:28 -0500
Date: Thu, 23 Feb 2017 13:29:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223022933.GW12577@umbus.fritz.box>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-9-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mz5eWKkhz39mMVQV"
Content-Disposition: inline
In-Reply-To: <1487252865-12064-9-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 08/22] ppc/xics: use the QOM interface
 to resend irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--mz5eWKkhz39mMVQV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2017 at 02:47:31PM +0100, C=E9dric Le Goater wrote:
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/xics.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 0ffdf09c5304..2decb921e4e3 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -229,16 +229,15 @@ static void icp_check_ipi(ICPState *ss)
>      qemu_irq_raise(ss->output);
>  }
> =20
> -static void icp_resend(ICPState *ss)
> +static void icp_resend(XICSInterface *xi, ICPState *ss)
>  {
> -    ICSState *ics;
> +    XICSInterfaceClass *xic =3D XICS_INTERFACE_GET_CLASS(xi);
> =20
>      if (ss->mfrr < CPPR(ss)) {
>          icp_check_ipi(ss);
>      }
> -    QLIST_FOREACH(ics, &ss->xics->ics, list) {
> -        ics_resend(ics);
> -    }
> +
> +    xic->ics_resend(xi);
>  }
> =20
>  void icp_set_cppr(ICPState *ss, uint8_t cppr)
> @@ -262,7 +261,7 @@ void icp_set_cppr(ICPState *ss, uint8_t cppr)
>          }
>      } else {
>          if (!XISR(ss)) {
> -            icp_resend(ss);
> +            icp_resend(XICS_INTERFACE(qdev_get_machine()), ss);

Here you're assuming that the machine is the implementor of the xics
interface, which is kinda ugly.  The ICP should have a pointer to the
xics interface, which will eventually replace the pointer to the
overall xics object it has now.

But I haven't read the rest of the series yet, maybe this is just
transitional.

>          }
>      }
>  }
> @@ -299,6 +298,8 @@ uint32_t icp_ipoll(ICPState *ss, uint32_t *mfrr)
> =20
>  void icp_eoi(ICPState *ss, uint32_t xirr)
>  {
> +    XICSInterface *xi =3D XICS_INTERFACE(qdev_get_machine());
> +    XICSInterfaceClass *xic =3D XICS_INTERFACE_GET_CLASS(xi);
>      ICSState *ics;
>      uint32_t irq;
> =20
> @@ -306,13 +307,13 @@ void icp_eoi(ICPState *ss, uint32_t xirr)
>      ss->xirr =3D (ss->xirr & ~CPPR_MASK) | (xirr & CPPR_MASK);
>      trace_xics_icp_eoi(ss->cs->cpu_index, xirr, ss->xirr);
>      irq =3D xirr & XISR_MASK;
> -    QLIST_FOREACH(ics, &ss->xics->ics, list) {
> -        if (ics_valid_irq(ics, irq)) {
> -            ics_eoi(ics, irq);
> -        }
> +
> +    ics =3D xic->ics_get(xi, irq);
> +    if (ics) {
> +        ics_eoi(ics, irq);
>      }
>      if (!XISR(ss)) {
> -        icp_resend(ss);
> +        icp_resend(xi, ss);
>      }
>  }
> =20
> @@ -592,10 +593,11 @@ static void ics_simple_reset(DeviceState *dev)
> =20
>  static int ics_simple_post_load(ICSState *ics, int version_id)
>  {
> +    XICSInterface *xi =3D XICS_INTERFACE(qdev_get_machine());
>      int i;
> =20
>      for (i =3D 0; i < ics->xics->nr_servers; i++) {
> -        icp_resend(&ics->xics->ss[i]);
> +        icp_resend(xi, &ics->xics->ss[i]);
>      }

This resend triggering needs to get moved to the xics interface
implementor - i.e. the machine.  It's actually already broken right
now, since it incorrectly relies on the ordering of the ics and icp
restore during migration.

>      return 0;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mz5eWKkhz39mMVQV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrkkNAAoJEGw4ysog2bOSAjUP/3RovH/6+ltxxG0tNn1FykJx
MdPLN5xduwaCUiNmS2EoHl5vxRjpq4QSGGWVDjxyREg0FLeWk7z3YtgSWqF2xN+o
gWnF6vjvfeN7WNBb2/ZDC8O7VJCVjNp6LuZ0clumr20gWFX4eggP0gzPqwBTknbM
yiLTvrwlTCgzDiMcKevsEARsA5nzGZW5e4jIV0jwdsQ0e4v9jEK5wgXrCaMghC8L
PAcBVciLhUofNTGfCJ7N/jjh0kxe5rlVf9klbe6TwdZ1HPkmCci62EJsKX4AwT9h
0BljcxnzVTH7kX+WAtHT30FJFXlw7cfckTIB+7HKlRXyr0/7oGleNBdwF8J+Xx+p
ItFYvyvENXtISQPD2enIH4gLbLMZbwytb4aVPi2XlNwJfl4LXOnsBlDPSfsY5NwU
fHZY+bsy+5HWzjJhw5Og+xWcQA225sgc5V4L6MdURNvAtyOGQ0VGspBBxYNlMOD8
MbEcX6F2mIJowyIVCMv3b84Ij8f7PEZejmvPY2nf/ma5QIF+fFJswd+eo3cq0mag
vHtOx+zK1jr4N9CrG5MXrJysZkhU5Xk/Aq2N/RXGjwfpiguvnmJtRDkjr3UZu8+N
ZXA7nPuHBEw0JB5GmwqSZ0yDwpj4Ua4bZEqXSH5knl3xVsfwySiyOCs0BaTXjCy7
U0UCDh7QG0VjDHI2tPF4
=0X17
-----END PGP SIGNATURE-----

--mz5eWKkhz39mMVQV--
