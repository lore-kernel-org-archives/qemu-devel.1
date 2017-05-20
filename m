Received: from eggs.gnu.org ([2001:4830:134:3::10]:39531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCNsN-00060p-EH
	for qemu-devel@nongnu.org; Sun, 21 May 2017 06:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCNsJ-0001NS-Em
	for qemu-devel@nongnu.org; Sun, 21 May 2017 06:14:15 -0400
Date: Sat, 20 May 2017 16:45:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170520064509.GD30246@umbus.fritz.box>
References: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
	<149518993198.24289.7946457258780782948.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Content-Disposition: inline
In-Reply-To: <149518993198.24289.7946457258780782948.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] spapr: fix error reporting in
 xics_system_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2017 at 12:32:12PM +0200, Greg Kurz wrote:
> If the user explicitely asked for kernel-irqchip support and "xics-kvm"
> initialization fails, we shouldn't fallback to emulated "xics" as we
> do now. It is also awkward to print an error message when we have an
> errp pointer argument.
>=20
> Let's use the errp argument to report the error and let the caller decide.
> This simplifies the code as we don't need a local Error * here.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Concept looks good, but..

> ---
> v2: - total rewrite
> ---
>  hw/ppc/spapr.c |   13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 91f7434861a8..75e298b4c6be 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -128,18 +128,14 @@ static void xics_system_init(MachineState *machine,=
 int nr_irqs, Error **errp)
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> =20
>      if (kvm_enabled()) {
> -        Error *err =3D NULL;
> -
>          if (machine_kernel_irqchip_allowed(machine) &&
>              !xics_kvm_init(spapr, errp)) {
>              spapr->icp_type =3D TYPE_KVM_ICP;
> -            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs=
, &err);
> +            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs=
, errp);

I believe there are reasons you're not supposed to just pass an errp
through to a subordinate function.  Instead you're supposed to have a
local Error * and use error_propagate().

>          }
>          if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
> -            error_reportf_err(err,
> -                              "kernel_irqchip requested but unavailable:=
 ");
> -        } else {
> -            error_free(err);
> +            error_prepend(errp, "kernel_irqchip requested but unavailabl=
e: ");
> +            return;
>          }
>      }
> =20
> @@ -147,6 +143,9 @@ static void xics_system_init(MachineState *machine, i=
nt nr_irqs, Error **errp)
>          xics_spapr_init(spapr);
>          spapr->icp_type =3D TYPE_ICP;
>          spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,=
 errp);
> +        if (!spapr->ics) {

It would also be more standard to check the returned error, rather
than the other result.

> +            return;
> +        }
>      }
>  }
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZH+X1AAoJEGw4ysog2bOSbhwP/0eCK3pQiJUo9TG6M1PEw4hx
4qYWYFz1WjswSTDR1ljQlh6wOj7kQLbw/zo7/WikYDbzm161B8ckIDbnnMhnvUVX
ZYUOIF4bPbtd8oVE5TTOsGM+Eo9PrsD91NqTWeGwo/rZmR5H1COCaiBVnUce0TY5
JZ4XcWyyl/9bjUdXwzyk9hGwNSm9ZNhjTMsWf7ZAQnnApzwNK/YD+0Fu5sI0C3Gs
bFGdv6SZLXdHguwAXGoWtIvDBLhELM345Wcuwbphgiq0j3M6lcUSYWTDeAq82XmX
39Jv50v54zm/d5+D16lW+SMCAh4uT6U7zYSaMAo7tRpuUBOwx+Arflc9ga/3L3EQ
V5glhKLSKLoXs+XSAOc+87l/tEpQttBbOU2alSBuq2GkG+O4ZqGhiPsje969FoEG
/ziuSFtXKyHKcE1RrxxP31SMJQZLq9veVkevoDRijl+cyVaZggfF8QROjTKL0/q5
foyUQQwNRLe9F8sisEq2o9K+UglwC7q/G/AyGbs608+2SMOp9ESsUOCJiN8X5VmR
BjdhM1scOZX4qUKL9wjVgug/U+TZJBVCNv2o7bsxbxE6Y3XRrNSQ8/Nb4PK8Xy0z
og/r1UKJYX+lzMt3J03vTUGv45VQWSB1vEvqOXDLbpfgL82QLE6B8VB7tsWm2lVX
SHfL8WFw6y9VNlYRWpoH
=5gRj
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
