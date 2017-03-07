Received: from eggs.gnu.org ([2001:4830:134:3::10]:45801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1clWAy-0004Vq-CN
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 02:38:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1clWAt-0001tU-EL
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 02:38:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38625
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1clWAt-0001tM-7g
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 02:38:19 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v287XriC121429
	for <qemu-devel@nongnu.org>; Wed, 8 Mar 2017 02:38:17 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 292dfegh4w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 02:38:17 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 8 Mar 2017 02:38:16 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170306094349.GB11260@umbus.fritz.box>
References: <1488583977-32253-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<20170306041658.GH12030@umbus.fritz.box>
	<148877909465.3910.16372626632881517514@loki>
	<20170306094349.GB11260@umbus.fritz.box>
Date: Tue, 07 Mar 2017 08:32:12 -0600
Message-Id: <148889713226.3910.11623469069808308075@loki>
Subject: Re: [Qemu-devel] [PATCH v2] spapr_pci: allow control of BAR
 alignment through SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

Quoting David Gibson (2017-03-06 03:43:49)
> On Sun, Mar 05, 2017 at 11:44:54PM -0600, Michael Roth wrote:
> > Quoting David Gibson (2017-03-05 22:16:58)
> > > On Fri, Mar 03, 2017 at 05:32:57PM -0600, Michael Roth wrote:
> > > > In certain cases, such as PCI-passthrough with VFIO, we cannot offl=
oad
> > > > MMIO accesses to KVM unless the BAR alignment matches the host. This
> > > > patch, in conjunction with a separately submitted patch for SLOF
> > > > which allows for control of this via the device-tree, allows us to
> > > > set this alignment via QEMU.
> > > > =

> > > > Cc: qemu-ppc@nongnu.org
> > > > Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> > > > Cc: David Gibson <david@gibson.dropbear.id.au>
> > > > Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > > ---
> > > > v2:
> > > >   * Keep natural alignment as the default in SLOF, only set DT prop=
 if
> > > >     different alignment is specified by QEMU (David)
> > > =

> > > Unfortunately, this has missed the cutoff for qemu-2.9.  =

> > > =

> > > I'm afraid I'm still not entirely clear on the rationale here.
> > > =

> > > Why do we need a variable parameter based on the host page size?
> > > Couldn't we just have SLOF always align to something "big enough"
> > > (64kiB, IIUC)?
> > =

> > Is it okay for SLOF to assume 64K is sufficient? Since this is a
> > restriction/quirk on the QEMU/platform side it seems like it should be
> > controlled via the device tree.
> > =

> > That said, I can't think of any situation where we'd want something oth=
er
> > than 64K...
> =

> That was.. also my thinking.
> =

> > But even if we bake the 64k alignment into SLOF, shouldn't we still hav=
e a
> > way to switch it off for older machine types so assignments don't change
> > from one boot to the next?
> =

> Ah.. hmm.. good question.  I mean technically speaking you're not
> guaranteed stable BAR allocation from one boot to the next anyway.
> But as you mention below that doesn't necessarily mean it won't
> confuse guests.
> =

> > That could be a boolean option/property, but if
> > that at least is deemed necessary it might as well provide the requested
> > alignment as well to reduce assumptions on the SLOF side.
> > =

> > If neither of these is an issue it can be fixed within SLOF; just want
> > to make sure that's okay from a QEMU perspective. In theory guests
> > shouldn't care how BAR assignments are done, but they also aren't
> > supposed to care about things like enumeration order either...
> =

> Not sure what to do with this.  Well, we've missed qemu 2.9 anyway, so
> I guess we've got time to think about it.

I had a follow-up planned for 2.10 that moves BAR assignment to QEMU entire=
ly,
which would also let us fix the alignment for hotplugged devices. So at this
point it probably makes more sense to focus on that for 2.10. Will get those
posted soon.

> =

> > > > ---
> > > >  hw/ppc/spapr.c              |  7 ++++++-
> > > >  hw/ppc/spapr_pci.c          | 10 ++++++++++
> > > >  include/hw/pci-host/spapr.h |  1 +
> > > >  3 files changed, 17 insertions(+), 1 deletion(-)
> > > > =

> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index 14192ac..ef8df35 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -3166,7 +3166,12 @@ DEFINE_SPAPR_MACHINE(2_9, "2.9", true);
> > > >   * pseries-2.8
> > > >   */
> > > >  #define SPAPR_COMPAT_2_8                            \
> > > > -    HW_COMPAT_2_8
> > > > +    HW_COMPAT_2_8                                   \
> > > > +    {                                               \
> > > > +        .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,     \
> > > > +        .property =3D "mem_bar_min_align",            \
> > > > +        .value    =3D "0",                            \
> > > > +    },                                              \
> > > >  =

> > > >  static void spapr_machine_2_8_instance_options(MachineState *machi=
ne)
> > > >  {
> > > > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > > > index 919d3c2..485d32d 100644
> > > > --- a/hw/ppc/spapr_pci.c
> > > > +++ b/hw/ppc/spapr_pci.c
> > > > @@ -1664,6 +1664,10 @@ static void spapr_phb_realize(DeviceState *d=
ev, Error **errp)
> > > >          return;
> > > >      }
> > > >  =

> > > > +    if (sphb->mem_bar_min_align =3D=3D (uint64_t)-1) {
> > > > +        sphb->mem_bar_min_align =3D qemu_real_host_page_size;
> > > > +    }
> > > > +
> > > >      sphb->dtbusname =3D g_strdup_printf("pci@%" PRIx64, sphb->buid=
);
> > > >  =

> > > >      namebuf =3D alloca(strlen(sphb->dtbusname) + 32);
> > > > @@ -1858,6 +1862,8 @@ static Property spapr_phb_properties[] =3D {
> > > >      DEFINE_PROP_UINT32("numa_node", sPAPRPHBState, numa_node, -1),
> > > >      DEFINE_PROP_BOOL("pre-2.8-migration", sPAPRPHBState,
> > > >                       pre_2_8_migration, false),
> > > > +    DEFINE_PROP_UINT64("mem_bar_min_align", sPAPRPHBState, mem_bar=
_min_align,
> > > > +                       -1),
> > > >      DEFINE_PROP_END_OF_LIST(),
> > > >  };
> > > >  =

> > > > @@ -2228,6 +2234,10 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
> > > >      if (ret) {
> > > >          return ret;
> > > >      }
> > > > +    if (phb->mem_bar_min_align) {
> > > > +        _FDT(fdt_setprop_cell(fdt, bus_off, "qemu,mem-bar-min-alig=
n",
> > > > +                              phb->mem_bar_min_align));
> > > > +    }
> > > >  =

> > > >      return 0;
> > > >  }
> > > > diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spap=
r.h
> > > > index dfa7614..fa33346 100644
> > > > --- a/include/hw/pci-host/spapr.h
> > > > +++ b/include/hw/pci-host/spapr.h
> > > > @@ -79,6 +79,7 @@ struct sPAPRPHBState {
> > > >      uint64_t dma64_win_addr;
> > > >  =

> > > >      uint32_t numa_node;
> > > > +    uint64_t mem_bar_min_align;
> > > >  =

> > > >      /* Fields for migration compatibility hacks */
> > > >      bool pre_2_8_migration;
> > > =

> > =

> =

> -- =

> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _othe=
r_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
