Received: from eggs.gnu.org ([2001:4830:134:3::10]:42206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7hQ-00035N-PV
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7hM-0004SI-OQ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:26:40 -0400
Date: Thu, 3 May 2018 16:23:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503062318.GV13229@umbus.fritz.box>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-3-david@gibson.dropbear.id.au>
	<20180420142523.515f0058@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4HoONH8zr3Mj5MZN"
Content-Disposition: inline
In-Reply-To: <20180420142523.515f0058@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH for-2.13 02/10] spapr: Remove support for
 PowerPC 970 with pseries machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: benh@kernel.crashing.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--4HoONH8zr3Mj5MZN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 02:25:23PM +0200, Greg Kurz wrote:
> On Tue, 17 Apr 2018 17:17:14 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Current POWER cpus allow for a VRMA, a special mapping which describes a
> > guest's view of memory when in real mode (MMU off, from the guest's poi=
nt
> > of view).  Older cpus didn't have that which meant that to support a gu=
est
> > a special host-contiguous region of memory was needed to give the guest=
 its
> > Real Mode Area (RMA).
> >=20
> > This was useful in the early days of KVM on Power to allow it to be tes=
ted
> > on PowerPC 970 chips as used in Macintosh G5 machines.  Now, however, t=
hose
> > machines are so old as to be irrelevant, and the host kernel has long s=
ince
> > dropped support for this mode.  It hasn't been tested in ages either.
> >=20
> > So, to simplify the code, drop the support from qemu as well.
> >=20
> > As well as the code for handling contiguous RMAs, we can remove some
> > code to set the HIOR register, which existed on 970 but not on the
> > current and supported CPUs.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> Regardless of the discussion on the deprecation process, just
> a cosmetic remark...
>=20
> >  hw/ppc/spapr.c          | 61 +++++++++++++++--------------------------=
--------
> >  hw/ppc/spapr_cpu_core.c |  2 --
> >  target/ppc/kvm.c        | 36 -----------------------------
> >  target/ppc/kvm_ppc.h    |  6 -----
> >  4 files changed, 19 insertions(+), 86 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 81b50af3b5..fbb2c6752c 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2376,9 +2376,6 @@ static void spapr_machine_init(MachineState *mach=
ine)
> >      int i;
> >      MemoryRegion *sysmem =3D get_system_memory();
> >      MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> > -    MemoryRegion *rma_region;
> > -    void *rma =3D NULL;
> > -    hwaddr rma_alloc_size;
> >      hwaddr node0_size =3D spapr_node0_size(machine);
> >      long load_limit, fw_size;
> >      char *filename;
> > @@ -2417,40 +2414,28 @@ static void spapr_machine_init(MachineState *ma=
chine)
> >          exit(1);
> >      }
> > =20
> > -    /* Allocate RMA if necessary */
> > -    rma_alloc_size =3D kvmppc_alloc_rma(&rma);
> > +    spapr->rma_size =3D node0_size;
> > =20
> > -    if (rma_alloc_size =3D=3D -1) {
> > -        error_report("Unable to create RMA");
> > -        exit(1);
> > +    /* With KVM, we don't actually know whether KVM supports an
> > +     * unbounded RMA (PR KVM) or is limited by the hash table size (HV
> > +     * KVM using VRMA), so we always assume the latter
> > +     *
> > +     * In that case, we also limit the initial allocations for RTAS
> > +     * etc... to 256M since we have no way to know what the VRMA size
> > +     * is going to be as it depends on the size of the hash table
> > +     * isn't determined yet.
>=20
> ... maybe s/isn't/which isn't/ while at it ?

Thanks, I've made that change.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4HoONH8zr3Mj5MZN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqqtQACgkQbDjKyiDZ
s5LUwg/8CznJuyCIUNP07tAgALbFhsV0gRJsv9OlIrna176qXEXrujpOzaDomzMs
zEHacWNMkvq0eJbcLiP4Sphbh5OzpNv1Z4C4TekNYG4J4z9WTuzM30ooUJN08V/w
UqRWmj2S6EE48Ram1lj3LDjPMmXWFPUV2prxCxlPGLjMjU+wpFGvfatnK8iPwTsg
Cbu+iWDA335rNPwaPpd0c0T34VT2Ra/+wE9W+Xrg5YZyOLuz4zivwTXbKKS6osPY
cR4EG7PqJk606audU66iK3GvIWItmFuBVf3XEe8vOmlQTkM+Rf6XBRomLo7ee9nb
Yi0Pha6ym5+vnFNyvyjuz5IS56bWoHv7oY01N+X54Pu0HDvzboXxNW12Aqd+/p1l
5algZR7CQPJvwlSwXauK9xzQxOPWXLymLc2zGdMcPn/nnRMHMt/Cuxlqqc2zTart
BSL+MDR9oKjjiZTgr9d3g3ZucIAp96ZvbGS0rShnOJVjVc8oRgC8lcuehPZ+IZsj
pc69ORuwFvmQkWQpDsGNxvg3dEWHTvjw1JrErGqummkYzQ2xJcX3+fpH8xnIiJvK
UqWCMhTnnjWzFWPnJAhsjNNT4F7BEE5Gppsrx6LNZekATAAwASWvTBwYilwmVxHk
cZctHB8SKI2UjNhtn9Ke+ThNuOiY0LQrJ9JtNekCutJ0d+hQtgU=
=Koyn
-----END PGP SIGNATURE-----

--4HoONH8zr3Mj5MZN--
