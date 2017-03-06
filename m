Received: from eggs.gnu.org ([2001:4830:134:3::10]:57819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckpC2-0007yV-DP
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckpBz-0002Uq-AA
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:44:38 -0500
Date: Mon, 6 Mar 2017 20:43:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170306094349.GB11260@umbus.fritz.box>
References: <1488583977-32253-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<20170306041658.GH12030@umbus.fritz.box>
	<148877909465.3910.16372626632881517514@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <148877909465.3910.16372626632881517514@loki>
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
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 05, 2017 at 11:44:54PM -0600, Michael Roth wrote:
> Quoting David Gibson (2017-03-05 22:16:58)
> > On Fri, Mar 03, 2017 at 05:32:57PM -0600, Michael Roth wrote:
> > > In certain cases, such as PCI-passthrough with VFIO, we cannot offload
> > > MMIO accesses to KVM unless the BAR alignment matches the host. This
> > > patch, in conjunction with a separately submitted patch for SLOF
> > > which allows for control of this via the device-tree, allows us to
> > > set this alignment via QEMU.
> > >=20
> > > Cc: qemu-ppc@nongnu.org
> > > Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> > > Cc: David Gibson <david@gibson.dropbear.id.au>
> > > Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > ---
> > > v2:
> > >   * Keep natural alignment as the default in SLOF, only set DT prop if
> > >     different alignment is specified by QEMU (David)
> >=20
> > Unfortunately, this has missed the cutoff for qemu-2.9. =20
> >=20
> > I'm afraid I'm still not entirely clear on the rationale here.
> >=20
> > Why do we need a variable parameter based on the host page size?
> > Couldn't we just have SLOF always align to something "big enough"
> > (64kiB, IIUC)?
>=20
> Is it okay for SLOF to assume 64K is sufficient? Since this is a
> restriction/quirk on the QEMU/platform side it seems like it should be
> controlled via the device tree.
>=20
> That said, I can't think of any situation where we'd want something other
> than 64K...

That was.. also my thinking.

> But even if we bake the 64k alignment into SLOF, shouldn't we still have a
> way to switch it off for older machine types so assignments don't change
> from one boot to the next?

Ah.. hmm.. good question.  I mean technically speaking you're not
guaranteed stable BAR allocation from one boot to the next anyway.
But as you mention below that doesn't necessarily mean it won't
confuse guests.

> That could be a boolean option/property, but if
> that at least is deemed necessary it might as well provide the requested
> alignment as well to reduce assumptions on the SLOF side.
>=20
> If neither of these is an issue it can be fixed within SLOF; just want
> to make sure that's okay from a QEMU perspective. In theory guests
> shouldn't care how BAR assignments are done, but they also aren't
> supposed to care about things like enumeration order either...

Not sure what to do with this.  Well, we've missed qemu 2.9 anyway, so
I guess we've got time to think about it.

> > > ---
> > >  hw/ppc/spapr.c              |  7 ++++++-
> > >  hw/ppc/spapr_pci.c          | 10 ++++++++++
> > >  include/hw/pci-host/spapr.h |  1 +
> > >  3 files changed, 17 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 14192ac..ef8df35 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -3166,7 +3166,12 @@ DEFINE_SPAPR_MACHINE(2_9, "2.9", true);
> > >   * pseries-2.8
> > >   */
> > >  #define SPAPR_COMPAT_2_8                            \
> > > -    HW_COMPAT_2_8
> > > +    HW_COMPAT_2_8                                   \
> > > +    {                                               \
> > > +        .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,     \
> > > +        .property =3D "mem_bar_min_align",            \
> > > +        .value    =3D "0",                            \
> > > +    },                                              \
> > > =20
> > >  static void spapr_machine_2_8_instance_options(MachineState *machine)
> > >  {
> > > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > > index 919d3c2..485d32d 100644
> > > --- a/hw/ppc/spapr_pci.c
> > > +++ b/hw/ppc/spapr_pci.c
> > > @@ -1664,6 +1664,10 @@ static void spapr_phb_realize(DeviceState *dev=
, Error **errp)
> > >          return;
> > >      }
> > > =20
> > > +    if (sphb->mem_bar_min_align =3D=3D (uint64_t)-1) {
> > > +        sphb->mem_bar_min_align =3D qemu_real_host_page_size;
> > > +    }
> > > +
> > >      sphb->dtbusname =3D g_strdup_printf("pci@%" PRIx64, sphb->buid);
> > > =20
> > >      namebuf =3D alloca(strlen(sphb->dtbusname) + 32);
> > > @@ -1858,6 +1862,8 @@ static Property spapr_phb_properties[] =3D {
> > >      DEFINE_PROP_UINT32("numa_node", sPAPRPHBState, numa_node, -1),
> > >      DEFINE_PROP_BOOL("pre-2.8-migration", sPAPRPHBState,
> > >                       pre_2_8_migration, false),
> > > +    DEFINE_PROP_UINT64("mem_bar_min_align", sPAPRPHBState, mem_bar_m=
in_align,
> > > +                       -1),
> > >      DEFINE_PROP_END_OF_LIST(),
> > >  };
> > > =20
> > > @@ -2228,6 +2234,10 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
> > >      if (ret) {
> > >          return ret;
> > >      }
> > > +    if (phb->mem_bar_min_align) {
> > > +        _FDT(fdt_setprop_cell(fdt, bus_off, "qemu,mem-bar-min-align",
> > > +                              phb->mem_bar_min_align));
> > > +    }
> > > =20
> > >      return 0;
> > >  }
> > > diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> > > index dfa7614..fa33346 100644
> > > --- a/include/hw/pci-host/spapr.h
> > > +++ b/include/hw/pci-host/spapr.h
> > > @@ -79,6 +79,7 @@ struct sPAPRPHBState {
> > >      uint64_t dma64_win_addr;
> > > =20
> > >      uint32_t numa_node;
> > > +    uint64_t mem_bar_min_align;
> > > =20
> > >      /* Fields for migration compatibility hacks */
> > >      bool pre_2_8_migration;
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYvS9TAAoJEGw4ysog2bOS5TMP/irpA/2uXkCc5FkU4PWjzIBi
xCKl0v+4bPfxYciV174CzM9P6v5G6XPecMAsSInfkLD7Q9/ytYWaAR/Aw7hXJ3hK
HWJG/MaHLE+cjlKcbm4nE1sKwHInD4FCgMDgQ90o4okYrgakjhZcmTB9/YbYNzP+
J7+UkBdZ9rxYa4Z8WtQ0zPbyTNYDS49IyjK9zzm+OWkr07FRvLGrqnsB5ls2KQ3s
7rk8Wk5AmD8a+9eTMrvoLsPY0meUsVTO/CBUKuTc+Q9f2V0hBS4rfs3dc6jmcSyH
5raLK8etWEPYl7b6sJ+M89s/uRHOBcqgRrfDr5QCU4Upf+JwLBLwnqdqYPh0aBgM
nSmzEXbuMK3H4oeGOe1anXvY3cQ+kgzE+Ujj01bzCM2Elc3r1re7vMy8acGCz6MZ
2bBZm/ian7L3t/I3VA8lYaR+iTyAu05rZvNMMCejRvrqstpp2CppYOouxh3sQKPT
Jkn3cDkoDzxfol703+zFbf8e2sS8h8O5cS9940w3ROTUNCHHiF6mO51TW+obLGpy
BeW1lpMYiwyyh6BKXsa1zYtbU/ZqvFLxxQqx+qefNpxfc64DuxthSl/hrxPFJUHz
yAIiUO8GoW2+iZaJ2TplBHYdWpeQBksq4OrEQBn/oYDZl2OitjNbMfkd4Wst54Nn
2IGvzrJuatnsKEyGm2Dr
=tMBR
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
