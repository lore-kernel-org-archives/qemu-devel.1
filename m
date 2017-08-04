Received: from eggs.gnu.org ([2001:4830:134:3::10]:39333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ddSM5-0005RX-6E
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 22:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ddSM2-0004gw-FB
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 22:28:49 -0400
Date: Fri, 4 Aug 2017 12:21:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170804022151.GD6553@umbus.fritz.box>
References: <cover.1501740002.git.sam.bobroff@au1.ibm.com>
	<31205fa54bd9761aee5fb3a6724c98f7e9e86240.1501740002.git.sam.bobroff@au1.ibm.com>
	<20170803151504.6d5cacac@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
In-Reply-To: <20170803151504.6d5cacac@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/4] e500: Use cpu_index instead
 of vcpu_dt_id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Sam Bobroff <sam.bobroff@au1.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2017 at 03:15:04PM +0200, Greg Kurz wrote:
> On Thu, 3 Aug 2017 16:28:36 +1000
> Sam Bobroff <sam.bobroff@au1.ibm.com> wrote:
>=20
> > The e500 platform code uses the function ppc_get_vcpu_dt_id() but that
> > function is actually specific to SPAPR machines, not PPC CPUs, and
> > will always return the cpu_index in this context.
> >=20
>=20
> ie, e500 compatible CPUs don't support SMT ? Then maybe the e500 machine
> should ensure smp_threads =3D=3D 1, but this can done in a followup patch.

Uh.. sort of, it's really more about the host than guest restrictions.

I've rewritten the commit message to give a bit more context.

> > Simply use the cpu_index instead (which is 'i' in this context
> > because qemu_get_cpu(i) returns the cpu with cpu_index =3D=3D i).
> >=20
> > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11

>=20
> > ---
> >  hw/ppc/e500.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> > index 62f1857206..2a6d34ceb1 100644
> > --- a/hw/ppc/e500.c
> > +++ b/hw/ppc/e500.c
> > @@ -382,7 +382,6 @@ static int ppce500_load_device_tree(MachineState *m=
achine,
> >         the first node as boot node and be happy */
> >      for (i =3D smp_cpus - 1; i >=3D 0; i--) {
> >          CPUState *cpu;
> > -        PowerPCCPU *pcpu;
> >          char cpu_name[128];
> >          uint64_t cpu_release_addr =3D params->spin_base + (i * 0x20);
> > =20
> > @@ -391,16 +390,13 @@ static int ppce500_load_device_tree(MachineState =
*machine,
> >              continue;
> >          }
> >          env =3D cpu->env_ptr;
> > -        pcpu =3D POWERPC_CPU(cpu);
> > =20
> > -        snprintf(cpu_name, sizeof(cpu_name), "/cpus/PowerPC,8544@%x",
> > -                 ppc_get_vcpu_dt_id(pcpu));
> > +        snprintf(cpu_name, sizeof(cpu_name), "/cpus/PowerPC,8544@%x", =
i);
> >          qemu_fdt_add_subnode(fdt, cpu_name);
> >          qemu_fdt_setprop_cell(fdt, cpu_name, "clock-frequency", clock_=
freq);
> >          qemu_fdt_setprop_cell(fdt, cpu_name, "timebase-frequency", tb_=
freq);
> >          qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
> > -        qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
> > -                              ppc_get_vcpu_dt_id(pcpu));
> > +        qemu_fdt_setprop_cell(fdt, cpu_name, "reg", i);
> >          qemu_fdt_setprop_cell(fdt, cpu_name, "d-cache-line-size",
> >                                env->dcache_line_size);
> >          qemu_fdt_setprop_cell(fdt, cpu_name, "i-cache-line-size",
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmD2j8ACgkQbDjKyiDZ
s5Ikyw/+Om5OqTwu9ZlYxegUOJXvfCGrsMd+albk0CItSCil5oqxo8csGAnE1AfR
O7ZICgWTuHewoXTOEdSgh4OYna+MVZDjpRkn3wxdSsP3rGXwilN5uMSKC5+Za7gb
OtjH0Cy4xsGyIPc6FMADuZJjebyM+I5QjsYqyi+VCoiygUQ8qrTsDxEzRXw8oZXC
M5aLjYJuQLGknQkd8AGXrPOVk76zK0M3+Yjst+92Lz1A690X6UpLyBPLqjvv1TS1
v/2bQlyrBN3/Di5xELYMACHbOJDrm9DcvwCym1nlA8sfcu8i78DToU6uIT8S5L1O
NvOEr7RMs3r0Ibc8CHPXnPLQxCFu/Oa7zeP4H1u5Ydf6ZslZpgt25blvhVYzFFcr
p0BLhJ1yOfe/zaUVxcbgReSFwZk/nReYQqrLpSP7Q4J1CcbAQ/lKkPRquVLLQYoQ
UWYMGH4vBRK2k6weHTuXihMDs9ayWXyeMFbqL/WZqCe0FLK3xP0k4bGF5mQpkaCA
A3SChpLZnQVwJEJnnPTsf4nQuXsAqT8ETIVgIL/Sf6n42uVY6o+jF2dQvlN4qhQo
nw17g8HwS55IuF4f/MIls2ebY/04m4VTz69qOza/siAloc5u7A3hP4DMCmB7t45n
rfjbBnIFMknb57d+ALLTO/quY3UZKBM+S4AkO+r68XovtDPQPUE=
=SZHT
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
