Received: from eggs.gnu.org ([2001:4830:134:3::10]:46659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gS3BX-00074u-Be
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:59:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gS3BQ-0003q4-2p
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:59:33 -0500
Received: from 7.mo3.mail-out.ovh.net ([46.105.57.200]:40774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gS3BP-0003ZP-Pe
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:59:27 -0500
Received: from player718.ha.ovh.net (unknown [10.109.143.246])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id AC0B61EB379
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 17:59:18 +0100 (CET)
Date: Wed, 28 Nov 2018 17:59:10 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181128175910.4831a578@bahia.lan>
In-Reply-To: <128a0c2a-2f7e-55cf-1216-80266ac8a8a9@kaod.org>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-13-clg@kaod.org>
	<20181128025714.GW2251@umbus.fritz.box>
	<20181128103551.42397998@bahia.lan>
	<128a0c2a-2f7e-55cf-1216-80266ac8a8a9@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5 12/36] spapr: initialize VSMT
 before initializing the IRQ backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Wed, 28 Nov 2018 17:50:21 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 11/28/18 10:35 AM, Greg Kurz wrote:
> > On Wed, 28 Nov 2018 13:57:14 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> >> On Fri, Nov 16, 2018 at 11:57:05AM +0100, C=C3=A9dric Le Goater wrote:=
 =20
> >>> We will need to use xics_max_server_number() to create the sPAPRXive
> >>> object modeling the interrupt controller of the machine which is
> >>> created before the CPUs.
> >>>
> >>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>   =20
> >>
> >> My only concern here is that this moves the spapr_set_vsmt_mode()
> >> before some of the sanity checks in spapr_init_cpus().  Are we certain
> >> there are no edge cases that could cause badness?
> >> =20
> >=20
> > The early checks in spapr_init_cpus() filter out topologies that would
> > result in partially filled cores. They're only related to the rest of
> > the code that creates the boot CPUs. Before commit 1a5008fc17,
> > spapr_set_vsmt_mode() was even being called before spapr_init_cpus().
> > The rationale to move it there was to ensure it is called before the
> > first user of spapr->vsmt, which happens to be a call to
> > xics_max_server_number().
> >=20
> > Now that xics_max_server_number() needs to be called even earlier, I th=
ink a
> > better change is to have xics_max_server_number() to call spapr_set_vsm=
t_mode()
> > if spapr->vsmt isn't set. =20
>=20
> That 'smt' routine is black magic to me and I would not dare touching it.
>=20

I don't suggest to change it, just to ensure it gets called before spapr->v=
smt
gets used. But don't worry, I'll have a deeper look and send a patch :)

> C.
> =20
> >  =20
> >>> ---
> >>>  hw/ppc/spapr.c | 10 +++++-----
> >>>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>> index 7afd1a175bf2..50cb9f9f4a02 100644
> >>> --- a/hw/ppc/spapr.c
> >>> +++ b/hw/ppc/spapr.c
> >>> @@ -2466,11 +2466,6 @@ static void spapr_init_cpus(sPAPRMachineState =
*spapr)
> >>>          boot_cores_nr =3D possible_cpus->len;
> >>>      }
> >>> =20
> >>> -    /* VSMT must be set in order to be able to compute VCPU ids, ie =
to
> >>> -     * call xics_max_server_number() or spapr_vcpu_id().
> >>> -     */
> >>> -    spapr_set_vsmt_mode(spapr, &error_fatal);
> >>> -
> >>>      if (smc->pre_2_10_has_unused_icps) {
> >>>          int i;
> >>> =20
> >>> @@ -2593,6 +2588,11 @@ static void spapr_machine_init(MachineState *m=
achine)
> >>>      /* Setup a load limit for the ramdisk leaving room for SLOF and =
FDT */
> >>>      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
> >>> =20
> >>> +    /* VSMT must be set in order to be able to compute VCPU ids, ie =
to
> >>> +     * call xics_max_server_number() or spapr_vcpu_id().
> >>> +     */
> >>> +    spapr_set_vsmt_mode(spapr, &error_fatal);
> >>> +
> >>>      /* Set up Interrupt Controller before we create the VCPUs */
> >>>      smc->irq->init(spapr, &error_fatal);
> >>>     =20
> >> =20
> >  =20
>=20
