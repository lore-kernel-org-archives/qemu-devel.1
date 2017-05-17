Received: from eggs.gnu.org ([2001:4830:134:3::10]:52105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAoKr-00007z-F9
	for qemu-devel@nongnu.org; Tue, 16 May 2017 22:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAoKo-0003Yj-B2
	for qemu-devel@nongnu.org; Tue, 16 May 2017 22:05:09 -0400
Date: Wed, 17 May 2017 11:42:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170517014258.GB15596@umbus.fritz.box>
References: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
	<20170505204746.14116-4-danielhb@linux.vnet.ibm.com>
	<20170512061128.GG12908@umbus.fritz.box>
	<14ee61c8-b94c-9029-5c2b-0cba869f7972@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <14ee61c8-b94c-9029-5c2b-0cba869f7972@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v9 3/6] hw/ppc: migrating the
 DRC state of hotplugged devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2017 at 10:46:23AM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 05/12/2017 03:11 AM, David Gibson wrote:
> > On Fri, May 05, 2017 at 05:47:43PM -0300, Daniel Henrique Barboza wrote:
> > > In pseries, a firmware abstraction called Dynamic Reconfiguration
> > > Connector (DRC) is used to assign a particular dynamic resource
> > > to the guest and provide an interface to manage configuration/removal
> > > of the resource associated with it. In other words, DRC is the
> > > 'plugged state' of a device.
> > >=20
> > > Before this patch, DRC wasn't being migrated. This causes
> > > post-migration problems due to DRC state mismatch between source and
> > > target. The DRC state of a device X in the source might
> > > change, while in the target the DRC state of X is still fresh. When
> > > migrating the guest, X will not have the same hotplugged state as it
> > > did in the source. This means that we can't hot unplug X in the
> > > target after migration is completed because its DRC state is not cons=
istent.
> > > https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1677552 is one
> > > bug that is caused by this DRC state mismatch between source and
> > > target.
> > >=20
> > > To migrate the DRC state, we defined the VMStateDescription struct for
> > > spapr_drc to enable the transmission of spapr_drc state in migration.
> > > Not all the elements in the DRC state are migrated - only those
> > > that can be modified by guest actions or device add/remove
> > > operations:
> > >=20
> > > - 'isolation_state', 'allocation_state' and 'indicator_state'
> > > are involved in the DR state transition diagram from
> > > PAPR+ 2.7, 13.4;
> > >=20
> > > - 'configured', 'signalled', 'awaiting_release' and 'awaiting_allocat=
ion'
> > > are needed in attaching and detaching devices;
> > >=20
> > > - 'indicator_state' provides users with hardware state information.
> > >=20
> > > These are the DRC elements that are migrated.
> > >=20
> > > In this patch the DRC state is migrated for PCI, LMB and CPU
> > > connector types. At this moment there is no support to migrate
> > > DRC for the PHB (PCI Host Bridge) type.
> > >=20
> > > In the 'realize' function the DRC is registered using vmstate_registe=
r,
> > > similar to what hw/ppc/spapr_iommu.c does in 'spapr_tce_table_realize=
'.
> > > This approach works because  DRCs are bus-less and do not sit
> > > on a BusClass that implements bc->get_dev_path, so as a fallback the
> > > VMSD gets identified via "spapr_drc"/get_index(drc).
> > >=20
> > > Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > > ---
> > >   hw/ppc/spapr_drc.c | 61 +++++++++++++++++++++++++++++++++++++++++++=
+++++++++++
> > >   1 file changed, 61 insertions(+)
> > >=20
> > > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > > index 1c72160..926b945 100644
> > > --- a/hw/ppc/spapr_drc.c
> > > +++ b/hw/ppc/spapr_drc.c
> > > @@ -519,6 +519,65 @@ static void reset(DeviceState *d)
> > >       }
> > >   }
> > > +static bool spapr_drc_needed(void *opaque)
> > > +{
> > > +    sPAPRDRConnector *drc =3D (sPAPRDRConnector *)opaque;
> > > +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc=
);
> > > +    bool rc =3D false;
> > > +    sPAPRDREntitySense value;
> > Blank line after the declarations, please.
> >=20
> > > +    drck->entity_sense(drc, &value);
> > > +    /* If no dev is plugged in there is no need to migrate the DRC s=
tate */
> > > +    if (value !=3D SPAPR_DR_ENTITY_SENSE_PRESENT) {
> > > +        return false;
> > > +    }
> > > +
> > > +    /*
> > > +     * If there is dev plugged in, we need to migrate the DRC state =
when
> > > +     * it is different from cold-plugged state
> > > +     */
> > > +    switch (drc->type) {
> > > +
> > No blank line here please.
> >=20
> > > +    case SPAPR_DR_CONNECTOR_TYPE_PCI:
> > > +        rc =3D !((drc->isolation_state =3D=3D SPAPR_DR_ISOLATION_STA=
TE_UNISOLATED) &&
> > > +               (drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STA=
TE_USABLE) &&
> > > +               drc->configured && drc->signalled && !drc->awaiting_r=
elease);
> > You don't do any more manipulation of the rc value, so you might as
> > well just 'return' directly here.
> >=20
> >=20
> > > +        break;
> > > +
> > > +    case SPAPR_DR_CONNECTOR_TYPE_LMB:
> > > +        rc =3D !((drc->isolation_state =3D=3D SPAPR_DR_ISOLATION_STA=
TE_ISOLATED) &&
> > > +               (drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STA=
TE_UNUSABLE) &&
> > > +               drc->configured && drc->signalled && !drc->awaiting_r=
elease);
> > > +        break;
> > > +
> > > +    case SPAPR_DR_CONNECTOR_TYPE_CPU:
> > > +        rc =3D !((drc->isolation_state =3D=3D SPAPR_DR_ISOLATION_STA=
TE_ISOLATED) &&
> > > +               (drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STA=
TE_UNUSABLE) &&
> > > +                drc->configured && drc->signalled && !drc->awaiting_=
release);
> > > +        break;
> > > +
> > > +    default:
> > > +        ;
> > This should probably assert().
> >=20
> > > +    }
> > > +    return rc;
> > > +}
> > > +
> > > +static const VMStateDescription vmstate_spapr_drc =3D {
> > > +    .name =3D "spapr_drc",
> > > +    .version_id =3D 1,
> > > +    .minimum_version_id =3D 1,
> > > +    .needed =3D spapr_drc_needed,
> > > +    .fields  =3D (VMStateField []) {
> > > +        VMSTATE_UINT32(isolation_state, sPAPRDRConnector),
> > > +        VMSTATE_UINT32(allocation_state, sPAPRDRConnector),
> > > +        VMSTATE_UINT32(indicator_state, sPAPRDRConnector),
> > > +        VMSTATE_BOOL(configured, sPAPRDRConnector),
> > > +        VMSTATE_BOOL(awaiting_release, sPAPRDRConnector),
> > > +        VMSTATE_BOOL(awaiting_allocation, sPAPRDRConnector),
> > > +        VMSTATE_BOOL(signalled, sPAPRDRConnector),
> > Hrm.  I'm happy translation the 3 state integers, since their meaning
> > is in the PAPR spec.  The others are qemu local information, so it's
> > not as clear that they'll have a stable meaning.  Are you absolutely
> > sure you need all of them?
>=20
> The first time I saw this code (originally from Jianjun) I've tried to
> simplify/cut
> some of these values in the hope that they could be deduced later in the
> post_load. Unfortunately I've reached the same conclusion as him: these q=
emu
> state information isn't easily deduced in the post_load stage today and
> removing
> any of them from migration will break the unplug process afterwards.

Ok.

> This doesn't mean that we can't simplify it in the future though. I have
> some ideas
> of how we can simplify the DRC code (splitting the logic into LogicalDRC =
and
> PhysicalDRC
> for example) that can help simplify all this DRC logic altogether.

Ok.  I like that idea in principle, but bear in mind that refactoring
the data in the DRC is likely to mean a bunch of complicated
compatibility code to handle migrations.

> I'm also
> thinking about
> adding unit tests for this DRC code too - it would help us to make a
> redesign without
> worrying too much about unintended bugs.

That sounds great.
>=20
>=20
> Daniel
>=20
> >=20
> > > +        VMSTATE_END_OF_LIST()
> > > +    }
> > > +};
> > > +
> > >   static void realize(DeviceState *d, Error **errp)
> > >   {
> > >       sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
> > > @@ -547,6 +606,8 @@ static void realize(DeviceState *d, Error **errp)
> > >           object_unref(OBJECT(drc));
> > >       }
> > >       g_free(child_name);
> > > +    vmstate_register(DEVICE(drc), drck->get_index(drc), &vmstate_spa=
pr_drc,
> > > +                     drc);
> > >       trace_spapr_drc_realize_complete(drck->get_index(drc));
> > >   }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZG6qiAAoJEGw4ysog2bOSLg8P/3pHeou3Zqs7f503vgNRfcm6
uydIi9GETXxEwIXa1KWcvNwmE2JnN3u+SJoW6slqfzMGSJTVny8GLdnqSHOl8Nn7
WAf+y2D0cL832KJTY0LnxlZiYuhjj1aPVVT4LUUT/0wp2Ihz+b1gZVjEaxpVQt/W
j6uKbiGnAjp2ncppus/tSjEvmQvwhReJgovAwOeIHW5u8TvwXun7Cp3HJL2W6Lc4
GUOvcB6YzhI616VOQyvk3vaoFPODCmvBMGqZinQ7TpmPk6Inur93Puqr1vjc3B7w
l9F075XTJ/mGuQelHgOhjyaHXdtHgdKumHS+LY3LLqz14tujH/lHJM3+iE9ScxMD
BPNy5dOhS/YoeW1uJqhQTezvKkP4BkAEoAoDYwrQfqCF99iv41ibcFGLLTvhutsT
gCDmtFbuZD2BzrgPiwbVsQiUEpYrGZ6nnAda2sN49EVmQToqs87nGKrFG14pCosz
/CbYW22yUFwZRlsdWbolds2ykwxLjXoAZ8NA6KNMiKLXGe91ufdsy3lR1rqr31WC
NtUxutc7loBLbkfhb3NNHZn6jvGPIzjH92r+XiQfWxj7kHRPHbVQLgGDRwv7Lu8d
r1Bc1eQLZpe58eiEbQsLrnRUDrCitRCuVV+my45oUFFPMMposwInroUgoXGPmz6+
MhgDlGdxsmJYRt/D/KTS
=6S9b
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
