Received: from eggs.gnu.org ([209.51.188.92]:58648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1got78-00068t-UW
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:53:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1got77-0002kd-Ud
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:53:26 -0500
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:34135)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1got77-0002ik-NP
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:53:25 -0500
Received: from player699.ha.ovh.net (unknown [10.109.146.82])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 010464AABB
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 17:53:22 +0100 (CET)
Date: Wed, 30 Jan 2019 17:53:16 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190130175316.198597c9@bahia.lan>
In-Reply-To: <ff95d376-1253-a5eb-0a71-02b8b4b76013@redhat.com>
References: <20190130014216.98287-1-aik@ozlabs.ru>
	<20190130134303.754a43ab@bahia.lan>
	<ff95d376-1253-a5eb-0a71-02b8b4b76013@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu] spapr: Drop unused
 parameters from fdt building helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Wed, 30 Jan 2019 17:43:44 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Hi Alexey,
>=20
> On 1/30/19 1:43 PM, Greg Kurz wrote:
> > On Wed, 30 Jan 2019 12:42:16 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >  =20
> >> spapr_load_rtas() handles now RTAS address and size information in the=
 FDT
> >> so drop them from spapr_build_fdt().
> >>
> >> While we are here, fix a small typo.
> >>
> >> Fixes: 2cac78c12ade9 "pseries: Consolidate RTAS loading" =20
> >=20
> > One nit. The last rtas_* user in spapr_build_fdt() was removed by the
> > following hunk:
> >=20
> > @@ -949,12 +966,6 @@ static void *spapr_build_fdt(sPAPRMachineState *sp=
apr,
> >          }
> >      }
> > =20
> > -    /* RTAS */
> > -    ret =3D spapr_rtas_device_tree_setup(fdt, rtas_addr, rtas_size);
> > -    if (ret < 0) {
> > -        error_report("Couldn't set up RTAS device tree properties");
> > -    }
> > -
> >      /* cpus */
> >      spapr_populate_cpus_dt_node(fdt, spapr);
> > =20
> > from commit:
> >=20
> > 3f5dabceba24 "pseries: Consolidate construction of /rtas device tree no=
de" =20
>=20
> Can you (or David if he agrees) add a line about since when/why it is no
> more required?
>=20

Commit 3f5dabceba24 (first released in QEMU 2.10) simply moved the FDT code
for RTAS to some other function, leaving the rtas_addr and rtas_size argume=
nts
unused in spapr_build_fdt(). This patch is a trivial cleanup really.

> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >  =20
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru> =20
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> >> ---
> >>  hw/ppc/spapr.c | 8 +++-----
> >>  1 file changed, 3 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index a217c7f..fa12723 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -1225,9 +1225,7 @@ static void spapr_dt_hypervisor(sPAPRMachineStat=
e *spapr, void *fdt)
> >>      }
> >>  }
> >> =20
> >> -static void *spapr_build_fdt(sPAPRMachineState *spapr,
> >> -                             hwaddr rtas_addr,
> >> -                             hwaddr rtas_size)
> >> +static void *spapr_build_fdt(sPAPRMachineState *spapr)
> >>  {
> >>      MachineState *machine =3D MACHINE(spapr);
> >>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> >> @@ -1644,14 +1642,14 @@ static void spapr_machine_reset(void)
> >> =20
> >>      /*
> >>       * We place the device tree and RTAS just below either the top of=
 the RMA,
> >> -     * or just below 2GB, whichever is lowere, so that it can be
> >> +     * or just below 2GB, whichever is lower, so that it can be
> >>       * processed with 32-bit real mode code if necessary
> >>       */
> >>      rtas_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR);
> >>      rtas_addr =3D rtas_limit - RTAS_MAX_SIZE;
> >>      fdt_addr =3D rtas_addr - FDT_MAX_SIZE;
> >> =20
> >> -    fdt =3D spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
> >> +    fdt =3D spapr_build_fdt(spapr);
> >> =20
> >>      spapr_load_rtas(spapr, fdt, rtas_addr);
> >>   =20
> >=20
> >  =20
