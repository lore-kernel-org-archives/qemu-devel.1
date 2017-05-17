Received: from eggs.gnu.org ([2001:4830:134:3::10]:52107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAoKr-000082-Fn
	for qemu-devel@nongnu.org; Tue, 16 May 2017 22:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAoKo-0003Ye-AL
	for qemu-devel@nongnu.org; Tue, 16 May 2017 22:05:09 -0400
Date: Wed, 17 May 2017 11:41:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170517014104.GA15596@umbus.fritz.box>
References: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
	<20170505204746.14116-5-danielhb@linux.vnet.ibm.com>
	<20170512061224.GH12908@umbus.fritz.box>
	<8ee42025-7ba2-1b30-fff1-47f9df699052@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <8ee42025-7ba2-1b30-fff1-47f9df699052@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v9 4/6] hw/ppc/spapr.c: migrate
 pending_dimm_unplugs of spapr state
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


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2017 at 04:54:57PM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 05/12/2017 03:12 AM, David Gibson wrote:
> > On Fri, May 05, 2017 at 05:47:44PM -0300, Daniel Henrique Barboza wrote:
> > > To allow for a DIMM unplug event to resume its work if a migration
> > > occurs in the middle of it, this patch migrates the non-empty
> > > pending_dimm_unplugs QTAILQ that stores the DIMM information
> > > that the spapr_lmb_release() callback uses.
> > >=20
> > > It was considered an apprach where the DIMM states would be restored
> > > on the post-_load after a migration. The problem is that there is
> > > no way of knowing, from the sPAPRMachineState, if a given DIMM is goi=
ng
> > > through an unplug process and the callback needs the updated DIMM Sta=
te.
> > >=20
> > > We could migrate a flag indicating that there is an unplug event going
> > > on for a certain DIMM, fetching this information from the start of the
> > > spapr_del_lmbs call. But this would also require a scan on post_load =
to
> > > figure out how many nr_lmbs are left. At this point we can just
> > > migrate the nr_lmbs information as well, given that it is being calcu=
lated
> > > at spapr_del_lmbs already, and spare a scanning/discovery in the
> > > post-load. All that we need is inside the sPAPRDIMMState structure
> > > that is added to the pending_dimm_unplugs queue at the start of the
> > > spapr_del_lmbs, so it's convenient to just migrated this queue it if =
it's
> > > not empty.
> > >=20
> > > Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > NACK.
> >=20
> > As I believe I suggested previously, you can reconstruct this state on
> > the receiving side by doing a full scan of the DIMM and LMB DRC states.
>=20
> Just had an idea that I think it's in the line of what you're suggesting.
> Given
> that the information we need is only created in the spapr_del_lmbs
> (as per patch 1), we can use the absence of this information in the
> release callback as a sort of a flag, an indication that a migration got
> in the way and we need to reconstruct the nr_lmbs states again, using
> the same scanning function I've used in v8.
>=20
> The flow would be like this (considering the changes in the
> previous 3 patches so far):
>=20
> ------------
>=20
> /* Callback to be called during DRC release. */
> void spapr_lmb_release(DeviceState *dev)
> {
>      HotplugHandler *hotplug_ctrl;
>=20
>      uint64_t addr =3D spapr_dimm_get_address(PC_DIMM(dev));
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      sPAPRDIMMState *ds =3D spapr_pending_dimm_unplugs_find(spapr, addr);
>=20
>     // no DIMM state found in spapr - re-create it to find out how may LM=
Bs
> are left
>     if (ds =3D=3D NULL) {
>         uint32 nr_lmbs  =3D ***call_scanning_LMB_DRCs_function(dev)***
>         // recreate the sPAPRDIMMState element and add it back to spapr
>     }
>=20
>     ( resume callback as usual )
>=20
> -----------

Yes, the above seems like a reasonable plan.

> Is this approach be adequate? Another alternative would be to use another
> way of detecting if an LMB unplug is happening and, if positive, do the s=
ame
> process in the post_load(). In this case I'll need to take a look in the
> code and
> see how we can detect an ongoing unplug besides what I've said above.

You could, but I think the lazy approach above is preferable.

>=20
> Thanks,
>=20
>=20
> Daniel
>=20
> >=20
> > > ---
> > >   hw/ppc/spapr.c | 31 +++++++++++++++++++++++++++++++
> > >   1 file changed, 31 insertions(+)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index e190eb9..30f0b7b 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1437,6 +1437,36 @@ static bool version_before_3(void *opaque, int=
 version_id)
> > >       return version_id < 3;
> > >   }
> > > +static bool spapr_pending_dimm_unplugs_needed(void *opaque)
> > > +{
> > > +    sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
> > > +    return !QTAILQ_EMPTY(&spapr->pending_dimm_unplugs);
> > > +}
> > > +
> > > +static const VMStateDescription vmstate_spapr_dimmstate =3D {
> > > +    .name =3D "spapr_dimm_state",
> > > +    .version_id =3D 1,
> > > +    .minimum_version_id =3D 1,
> > > +    .fields =3D (VMStateField[]) {
> > > +        VMSTATE_UINT64(addr, sPAPRDIMMState),
> > > +        VMSTATE_UINT32(nr_lmbs, sPAPRDIMMState),
> > > +        VMSTATE_END_OF_LIST()
> > > +    },
> > > +};
> > > +
> > > +static const VMStateDescription vmstate_spapr_pending_dimm_unplugs =
=3D {
> > > +    .name =3D "spapr_pending_dimm_unplugs",
> > > +    .version_id =3D 1,
> > > +    .minimum_version_id =3D 1,
> > > +    .needed =3D spapr_pending_dimm_unplugs_needed,
> > > +    .fields =3D (VMStateField[]) {
> > > +        VMSTATE_QTAILQ_V(pending_dimm_unplugs, sPAPRMachineState, 1,
> > > +                         vmstate_spapr_dimmstate, sPAPRDIMMState,
> > > +                         next),
> > > +        VMSTATE_END_OF_LIST()
> > > +    },
> > > +};
> > > +
> > >   static bool spapr_ov5_cas_needed(void *opaque)
> > >   {
> > >       sPAPRMachineState *spapr =3D opaque;
> > > @@ -1535,6 +1565,7 @@ static const VMStateDescription vmstate_spapr =
=3D {
> > >       .subsections =3D (const VMStateDescription*[]) {
> > >           &vmstate_spapr_ov5_cas,
> > >           &vmstate_spapr_patb_entry,
> > > +        &vmstate_spapr_pending_dimm_unplugs,
> > >           NULL
> > >       }
> > >   };
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZG6owAAoJEGw4ysog2bOSf0MQANhZ/IoGAUQaLiIkW1aTiqRr
mvnTmc7jNkkam9WyN6kmOBXDYTldulX7GIZLnf9HcHzjphHz2vW2HX6+xeRMj3Ec
t7zz30hR/iD9Nor2z+2GhqZBkQcAz35MCVVZ8hg/ftxPsZBnLhsAUjMGzouxtokw
ZpXjlZFY/uTKIit43CFw8nvTCigs6FwsWHr++0yqGb+uLSLDwiGkAI+7oPX4F7EI
4yV7Jc2WmxJCbTau+j0ty7G3LXnxwcTwsmGiykS9ZaRp6FiMQfsRPdyPQvcmImYv
PpliYCODijAkhUWt34uM8Q/zDgCaps9kszF+jfEJalAVS4tooYyv7tTG+gA+KatE
9G8Tcf2NGnqSyDyArL8HPvMI6FHOqJkQqYLIqf235lGWABLO76nyhp0TSGe2wZS0
dnNFYyPgn8TtTzZcogc72YGKHBdVx1/cgFpiJ+GOp/vpCHKBYtOkDvz0Z/Czbav5
tIU+3kq7AUSb5xL2Muugw9W4KiNvGblgE5BmZe1V3j/nnzeR52fUnxPc8T+TTK5h
LUj+aTyZ/EK8ddbdn0e3Ywph0MrMP1E/0kCK7iMnng6rYZfbR7tqS8SoIHuvcKLG
ZcDEBc5TADmTe2+jGDycegCBixqx3sU8sMEyhG8DM34nksebx4KyhSJ3LFdie2vr
kZK7CReC3iZFWgNF1iZN
=dMQN
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
