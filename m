Received: from eggs.gnu.org ([2001:4830:134:3::10]:34544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dal6S-0001tF-3J
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dal6O-0007yi-RN
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:53:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dal6O-0007yN-Gx
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:53:28 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6RFrKUZ053145
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 11:53:27 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2byg509vtt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 11:53:24 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 27 Jul 2017 09:52:39 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170726163227.3d6647a4@bahia.lan>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100568549.27487.11903027800624299907.stgit@bahia>
	<0d1e2a57-14cb-4c4d-d8f7-915cd94c2eba@ozlabs.ru>
	<20170726163227.3d6647a4@bahia.lan>
Date: Thu, 27 Jul 2017 10:52:32 -0500
Message-Id: <150117075295.26979.13464389338949102104@loki>
Subject: Re: [Qemu-devel] [Qemu-ppc] [for-2.11 PATCH 16/26] spapr: enable
 PHB hotplug for pseries-2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

Quoting Greg Kurz (2017-07-26 09:32:27)
> On Wed, 26 Jul 2017 14:42:23 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> =

> > On 26/07/17 04:01, Greg Kurz wrote:
> > > From: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > =

> > > The 'dr_phb_enabled' field of that class can be set as
> > > part of machine-specific init code, and is then propagated
> > > to sPAPREnvironment to conditionally enable creation of DRC
> > > objects and device-tree description to facilitate hotplug
> > > of PHBs.
> > > =

> > > Since we can't migrate this state to older machine types,
> > > default the option to true and disable it for older machine
> > > types.
> > > =

> > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > > Changes since RFC:
> > > - rebased against ppc-for-2.10
> > > - updated changelog and title
> > > - set default to true and disable for 2.10 and older
> > > ---
> > >  hw/ppc/spapr.c         |    6 ++++++
> > >  include/hw/ppc/spapr.h |    3 +++
> > >  2 files changed, 9 insertions(+)
> > > =

> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 277daa4f9645..8dc505343c0f 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2382,6 +2382,8 @@ static void ppc_spapr_init(MachineState *machin=
e)
> > >      /* We always have at least the nvram device on VIO */
> > >      spapr_create_nvram(spapr);
> > >  =

> > > +    spapr->dr_phb_enabled =3D smc->dr_phb_enabled;
> > > +
> > >      /* Set up PCI */
> > >      spapr_pci_rtas_init();
> > >  =

> > > @@ -3482,6 +3484,7 @@ static void spapr_machine_class_init(ObjectClas=
s *oc, void *data)
> > >       * in which LMBs are represented and hot-added
> > >       */
> > >      mc->numa_mem_align_shift =3D 28;
> > > +    smc->dr_phb_enabled =3D true;
> > >  }
> > >  =

> > >  static const TypeInfo spapr_machine_info =3D {
> > > @@ -3558,8 +3561,11 @@ static void spapr_machine_2_10_instance_option=
s(MachineState *machine)
> > >  =

> > >  static void spapr_machine_2_10_class_options(MachineClass *mc)
> > >  {
> > > +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > > +
> > >      spapr_machine_2_11_class_options(mc);
> > >      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_10);
> > > +    smc->dr_phb_enabled =3D false;
> > >  }
> > >  =

> > >  DEFINE_SPAPR_MACHINE(2_10, "2.10", false);
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index 2a303a705c17..8004d9c2ab2c 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -59,6 +59,7 @@ struct sPAPRMachineClass {
> > >  =

> > >      /*< public >*/
> > >      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of=
 LMBs */
> > > +    bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of=
 PHBs */
> > >      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
> > >      const char *tcg_default_cpu; /* which (TCG) CPU to simulate by d=
efault */
> > >      bool pre_2_10_has_unused_icps;
> > > @@ -122,6 +123,8 @@ struct sPAPRMachineState {
> > >       * occurs during the unplug process. */
> > >      QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
> > >  =

> > > +    bool dr_phb_enabled; /* hotplug / dynamic-reconfiguration of PHB=
s */  =

> > =

> > The one in the class seems sufficient unless we are going to allow
> > disabling this via the command line.
> > =

> =

> I kept the original patch but you're right indeed. I don't see why
> someone would want to disable this from the cmdline, so I guess I
> should just drop the per-instance flag.
> =

> Mike, any thoughts ?

Not sure why I did it like that originally, and can't think of a good reason
we'd want to disable it specifically either, so I agree we should probably
just drop it.

> =

> > =

> > =

> > > +
> > >      /*< public >*/
> > >      char *kvm_type;
> > >      MemoryHotplugState hotplug_memory;
> > > =

> > >   =

> > =

> > =

>=20
