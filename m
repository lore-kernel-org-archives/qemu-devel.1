Received: from eggs.gnu.org ([2001:4830:134:3::10]:51865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dNaa3-0001RM-AL
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dNaZw-000712-Re
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:01:39 -0400
Date: Wed, 21 Jun 2017 15:24:55 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170621072455.GA12089@umbus>
References: <20170608050930.2613-1-david@gibson.dropbear.id.au>
	<20170608050930.2613-5-david@gibson.dropbear.id.au>
	<20170620082328.GA15438@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20170620082328.GA15438@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 4/6] spapr: Make DRC reset force DRC into
 known state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: mdroth@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2017 at 01:53:28PM +0530, Bharata B Rao wrote:
> On Thu, Jun 08, 2017 at 03:09:28PM +1000, David Gibson wrote:
> > The reset handler for DRCs attempts several state transitions which are
> > subject to various checks and restrictions.  But at reset time we know
> > there is no guest, so we can ignore most of the usual sequencing rules =
and
> > just set the DRC back to a known state.  In fact, it's safer to do so.
> >=20
> > The existing code also has several redundant checks for
> > drc->awaiting_release inside a block which has already tested that.  Th=
is
> > patch removes those and sets the DRC to a fixed initial state based only
> > on whether a device is currently plugged or not.
> >=20
> > With DRCs correctly reset to a state based on device presence, we don't
> > need to force state transitions as cold plugged devices are processed.
> > This allows us to remove all the callers of the set_*_state() methods f=
rom
> > outside spapr_drc.c.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c     | 15 ---------------
> >  hw/ppc/spapr_drc.c | 28 ++++++++--------------------
> >  2 files changed, 8 insertions(+), 35 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 01dda9e..c988e38 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2545,12 +2545,6 @@ static void spapr_add_lmbs(DeviceState *dev, uin=
t64_t addr_start, uint64_t size,
> >=20
> >          spapr_drc_attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, =
errp);
> >          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
> > -        if (!dev->hotplugged) {
> > -            sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLA=
SS(drc);
> > -            /* guests expect coldplugged LMBs to be pre-allocated */
> > -            drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_=
USABLE);
> > -            drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UN=
ISOLATED);
> > -        }
> >      }
> >      /* send hotplug notification to the
> >       * guest only in case of hotplugged memory
> > @@ -2901,15 +2895,6 @@ static void spapr_core_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
> >           * of hotplugged CPUs.
> >           */
> >          spapr_hotplug_req_add_by_index(drc);
> > -    } else {
> > -        /*
> > -         * Set the right DRC states for cold plugged CPU.
> > -         */
> > -        if (drc) {
> > -            sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLA=
SS(drc);
> > -            drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_=
USABLE);
> > -            drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UN=
ISOLATED);
>=20
> So here you are removing the initial state setting for cold plugged CPUs =
and ...
>=20
> > -        }
> >      }
> >      core_slot->cpu =3D OBJECT(dev);
> >  }
> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index dc4ac77..7e17f34 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -393,7 +393,6 @@ static bool release_pending(sPAPRDRConnector *drc)
> >  static void reset(DeviceState *d)
> >  {
> >      sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
> > -    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> >=20
> >      trace_spapr_drc_reset(spapr_drc_index(drc));
> >=20
> > @@ -401,28 +400,17 @@ static void reset(DeviceState *d)
> >      drc->ccs =3D NULL;
> >=20
> >      /* immediately upon reset we can safely assume DRCs whose devices
> > -     * are pending removal can be safely removed, and that they will
> > -     * subsequently be left in an ISOLATED state. move the DRC to this
> > -     * state in these cases (which will in turn complete any pending
> > -     * device removals)
> > +     * are pending removal can be safely removed.
> >       */
> >      if (drc->awaiting_release) {
> > -        drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_ISOLAT=
ED);
> > -        /* generally this should also finalize the removal, but if the=
 device
> > -         * hasn't yet been configured we normally defer removal under =
the
> > -         * assumption that this transition is taking place as part of =
device
> > -         * configuration. so check if we're still waiting after this, =
and
> > -         * force removal if we are
> > -         */
> > -        if (drc->awaiting_release) {
> > -            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
> > -        }
> > +        spapr_drc_release(drc);
> > +    }
> >=20
> > -        /* non-PCI devices may be awaiting a transition to UNUSABLE */
> > -        if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI &&
> > -            drc->awaiting_release) {
> > -            drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_=
UNUSABLE);
> > -        }
> > +    drc->isolation_state =3D drc->dev ? SPAPR_DR_ISOLATION_STATE_UNISO=
LATED
> > +        : SPAPR_DR_ISOLATION_STATE_ISOLATED;
> > +    if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> > +        drc->allocation_state =3D drc->dev ? SPAPR_DR_ALLOCATION_STATE=
_USABLE
> > +            : SPAPR_DR_ALLOCATION_STATE_UNUSABLE;
> >      }
>=20
> ... adding it via reset. However you are setting drc->isolation_state and
> drc->allocation_state directly rather than going via
> drck->set_isolation_state() and drck->set_allocation_state() routines.

Yes, this is deliberate.  At reset we *should not* be performing the
same checks on transitions that we do at other times.  It is not only
easier, but also safer to set the new state directly.

> This results in awaiting_allocation not geting cleared for cold plugged
> CPUs. So the effect after this commit is that we can't remove the
> CPUs that are specified on cmdline using -device.

Ok, so I should be clearing awaiting_allocation as well (I have
another patch to post soon which gets rid of awaiting_allocation, but
we do want to avoid breaking bisect where possible).

I will fold a change to do that into ppc-for-2.10.

> The following fixes the issue for me:
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index fd9e07d..da6979a 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -450,13 +450,13 @@ static void reset(DeviceState *d)
>          /* A device present at reset is coldplugged */
>          drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_UNISOLATED;
>          if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> -            drc->allocation_state =3D SPAPR_DR_ALLOCATION_STATE_USABLE;
> +            drc_set_usable(drc);
>          }
>      } else {
>          /* Otherwise device is absent, but might be hotplugged */
>          drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_ISOLATED;
>          if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> -            drc->allocation_state =3D SPAPR_DR_ALLOCATION_STATE_UNUSABLE;
> +            drc_set_unusable(drc);
>          }
>      }
>  }
>=20
> However I thought this will restore the previous behaviour completely:
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index fd9e07d..b7726ef 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -433,6 +433,7 @@ static bool release_pending(sPAPRDRConnector *drc)
>  static void reset(DeviceState *d)
>  {
>      sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
> +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> =20
>      trace_spapr_drc_reset(spapr_drc_index(drc));
> =20
> @@ -448,15 +449,15 @@ static void reset(DeviceState *d)
> =20
>      if (drc->dev) {
>          /* A device present at reset is coldplugged */
> -        drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_UNISOLATED;
> +        drck->unisolate(drc);
>          if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> -            drc->allocation_state =3D SPAPR_DR_ALLOCATION_STATE_USABLE;
> +            drc_set_usable(drc);
>          }
>      } else {
>          /* Otherwise device is absent, but might be hotplugged */
> -        drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_ISOLATED;
> +        drck->isolate(drc);
>          if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> -            drc->allocation_state =3D SPAPR_DR_ALLOCATION_STATE_UNUSABLE;
> +            drc_set_unusable(drc);
>          }
>      }
>  }

As noted above using the normal state transition functions misses the
point of this patch.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZSh9FAAoJEGw4ysog2bOSLb8QANShAdlyCeC1Zadd0KjZVYPh
iVgZwxioPd4kL6PBjVlpNyoInRT8IAP4Neeq6Y6QgZ/Ru+n6U4bypt/77Q+Yofu8
a73GKSa/dZE/KeoXjLy9ukLk80etX7/TgWoy6ZvICG7YDj+DZ2mooJ/gr3CQeyp9
KthNOGcVOVbMyrg+JU7TPSNMxz6bSoQ2D74dpQ8X26hZNoJxC2KoDTLf1tww9U5X
el2K0qao39L4/0ej2hGH3DJ8L2CDtdiu92Q29gRiPJhUvIlgyPENQfM3wR/MLYmq
FDUukU5JbOR2RTOe7aa8pOTy4qyyeOgBNz9QDUyMEW4sMxKPTEl8pJCByL20RRJ7
R+4zy9aLHJwzlsoSTjBYwZ9+oHCEATdmw9TR391W5o9mlDcB4hk2i24pK32ooV8D
anOoAL+fdLhDkUIf/GeajPcDIA3ytyNHQH5xCSK6ZRD05Nhyo5FHSImUo+jHBjWZ
Jr4lymci45v8E9IZmZMR3K29U5lZg3WGgIFHwtzK/YsSbTS2k+C1UjGpiZNw4+cN
mlXvJ5a4K2QW6yJ/nfT2hX5GeTD1Q4SuM3TBfaVp4mJAICy7APFgjspiDfxq+gTF
C4lX9inUydl4f4zPcMehSrO0EtLT6ObS60KhrYJfpAjcA78tpHfLXhDLxwLW6T6V
cf30Hmh45sUb9ZCiKs4Y
=yGxx
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
