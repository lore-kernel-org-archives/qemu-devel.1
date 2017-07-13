Received: from eggs.gnu.org ([2001:4830:134:3::10]:60732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVSPv-0000Yz-4I
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 20:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVSPr-0002q8-3a
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 20:55:43 -0400
Date: Thu, 13 Jul 2017 10:53:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170713005338.GQ4083@umbus.fritz.box>
References: <20170712055317.26225-1-david@gibson.dropbear.id.au>
	<20170712055317.26225-5-david@gibson.dropbear.id.au>
	<20170712134715.46aec1e0@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FcSpk3Icpd/Pbul4"
Content-Disposition: inline
In-Reply-To: <20170712134715.46aec1e0@bahia.lan>
Subject: Re: [Qemu-devel] [PATCHv2 4/8] spapr: Refactor spapr_drc_detach()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: mdroth@linux.vnet.ibm.com, danielhb@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, sjitindarsingh@gmail.com, bharata@linux.vnet.ibm.com


--FcSpk3Icpd/Pbul4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 01:47:15PM +0200, Greg Kurz wrote:
> On Wed, 12 Jul 2017 15:53:13 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > This function has two unused parameters - remove them.
> >=20
> > It also sets awaiting_release on all paths, except one.  On that path
> > setting it is harmless, since it will be immediately cleared by
> > spapr_drc_release().  So factor it out of the if statements.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> Patch 3 drops the hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort)
> lines that could be called below spapr_drc_detach(), but we still have:
>=20
> spapr_drc_detach()
>  spapr_drc_release()
>   object_property_del(OBJECT(drc), "device", NULL);
>                                               ^^
> Should this be &error_abort or should we pass an Error ** down to here ?
> (which, would require to add an errp argument to both spapr_drc_release()
>  and spapr_drc_reset())
>=20
> I would favor &error_abort since a failure in object_property_del() would
> mean we're calling spapr_drc_detach() on a DRC that wasn't attached to a
> device... ie, a bug. In this case:

Done, although as a separate patch, since it's not really tied to the
changes here.

>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> >  hw/ppc/spapr.c             | 11 +++--------
> >  hw/ppc/spapr_drc.c         | 12 ++++++------
> >  hw/ppc/spapr_pci.c         |  7 +------
> >  include/hw/ppc/spapr_drc.h |  2 +-
> >  4 files changed, 11 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index ff2aa6b..5c528e2 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2654,7 +2654,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint=
64_t addr_start, uint64_t size,
> >                  addr -=3D SPAPR_MEMORY_BLOCK_SIZE;
> >                  drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
> >                                        addr / SPAPR_MEMORY_BLOCK_SIZE);
> > -                spapr_drc_detach(drc, dev, NULL);
> > +                spapr_drc_detach(drc);
> >              }
> >              g_free(fdt);
> >              error_propagate(errp, local_err);
> > @@ -2877,7 +2877,7 @@ static void spapr_memory_unplug_request(HotplugHa=
ndler *hotplug_dev,
> >                                addr / SPAPR_MEMORY_BLOCK_SIZE);
> >          g_assert(drc);
> > =20
> > -        spapr_drc_detach(drc, dev, errp);
> > +        spapr_drc_detach(drc);
> >          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
> >      }
> > =20
> > @@ -2944,7 +2944,6 @@ void spapr_core_unplug_request(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
> >  {
> >      int index;
> >      sPAPRDRConnector *drc;
> > -    Error *local_err =3D NULL;
> >      CPUCore *cc =3D CPU_CORE(dev);
> >      int smt =3D kvmppc_smt_threads();
> > =20
> > @@ -2961,11 +2960,7 @@ void spapr_core_unplug_request(HotplugHandler *h=
otplug_dev, DeviceState *dev,
> >      drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * smt);
> >      g_assert(drc);
> > =20
> > -    spapr_drc_detach(drc, dev, &local_err);
> > -    if (local_err) {
> > -        error_propagate(errp, local_err);
> > -        return;
> > -    }
> > +    spapr_drc_detach(drc);
> > =20
> >      spapr_hotplug_req_remove_by_index(drc);
> >  }
> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index 89ba3d6..08fc715 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -70,7 +70,7 @@ static uint32_t drc_isolate_physical(sPAPRDRConnector=
 *drc)
> >          uint32_t drc_index =3D spapr_drc_index(drc);
> >          if (drc->configured) {
> >              trace_spapr_drc_set_isolation_state_finalizing(drc_index);
> > -            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
> > +            spapr_drc_detach(drc);
> >          } else {
> >              trace_spapr_drc_set_isolation_state_deferring(drc_index);
> >          }
> > @@ -134,7 +134,7 @@ static uint32_t drc_isolate_logical(sPAPRDRConnecto=
r *drc)
> >          uint32_t drc_index =3D spapr_drc_index(drc);
> >          if (drc->configured) {
> >              trace_spapr_drc_set_isolation_state_finalizing(drc_index);
> > -            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
> > +            spapr_drc_detach(drc);
> >          } else {
> >              trace_spapr_drc_set_isolation_state_deferring(drc_index);
> >          }
> > @@ -187,7 +187,7 @@ static uint32_t drc_set_unusable(sPAPRDRConnector *=
drc)
> >      if (drc->awaiting_release) {
> >          uint32_t drc_index =3D spapr_drc_index(drc);
> >          trace_spapr_drc_set_allocation_state_finalizing(drc_index);
> > -        spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
> > +        spapr_drc_detach(drc);
> >      }
> > =20
> >      return RTAS_OUT_SUCCESS;
> > @@ -371,20 +371,20 @@ static void spapr_drc_release(sPAPRDRConnector *d=
rc)
> >      drc->dev =3D NULL;
> >  }
> > =20
> > -void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **e=
rrp)
> > +void spapr_drc_detach(sPAPRDRConnector *drc)
> >  {
> >      trace_spapr_drc_detach(spapr_drc_index(drc));
> > =20
> > +    drc->awaiting_release =3D true;
> > +
> >      if (drc->isolation_state !=3D SPAPR_DR_ISOLATION_STATE_ISOLATED) {
> >          trace_spapr_drc_awaiting_isolated(spapr_drc_index(drc));
> > -        drc->awaiting_release =3D true;
> >          return;
> >      }
> > =20
> >      if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI &&
> >          drc->allocation_state !=3D SPAPR_DR_ALLOCATION_STATE_UNUSABLE)=
 {
> >          trace_spapr_drc_awaiting_unusable(spapr_drc_index(drc));
> > -        drc->awaiting_release =3D true;
> >          return;
> >      }
> > =20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 1e84c55..092a2f5 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1478,7 +1478,6 @@ static void spapr_pci_unplug_request(HotplugHandl=
er *plug_handler,
> >      PCIDevice *pdev =3D PCI_DEVICE(plugged_dev);
> >      sPAPRDRConnectorClass *drck;
> >      sPAPRDRConnector *drc =3D spapr_phb_get_pci_drc(phb, pdev);
> > -    Error *local_err =3D NULL;
> > =20
> >      if (!phb->dr_enabled) {
> >          error_setg(errp, QERR_BUS_NO_HOTPLUG,
> > @@ -1516,11 +1515,7 @@ static void spapr_pci_unplug_request(HotplugHand=
ler *plug_handler,
> >              }
> >          }
> > =20
> > -        spapr_drc_detach(drc, DEVICE(pdev), &local_err);
> > -        if (local_err) {
> > -            error_propagate(errp, local_err);
> > -            return;
> > -        }
> > +        spapr_drc_detach(drc);
> > =20
> >          /* if this isn't func 0, defer unplug event. otherwise signal =
removal
> >           * for all present functions
> > diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> > index 18a196e..fc8b721 100644
> > --- a/include/hw/ppc/spapr_drc.h
> > +++ b/include/hw/ppc/spapr_drc.h
> > @@ -242,6 +242,6 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset=
, Object *owner,
> > =20
> >  void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
> >                        int fdt_start_offset, Error **errp);
> > -void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **e=
rrp);
> > +void spapr_drc_detach(sPAPRDRConnector *drc);
> > =20
> >  #endif /* HW_SPAPR_DRC_H */
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FcSpk3Icpd/Pbul4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZZsSOAAoJEGw4ysog2bOSuAAQAJuJG37+bUflfog0XpdRcpWc
Ghk0Grv640yoSs7/TJw+l+9GcVLxKB+E52ZbCJYYrHiO8k1awut6bAS0u+kVttPa
A1tVosSqBWnwAWswE/b/jXO0+Qpb4GGKLeGTKQHBY0Oo3uInElQC7psnGVe7XRJg
sCbsevzxEx2lKzTPUf2Ps1CV8EMRrVXwPt5Ebdj40RWrFDiFCmW6I/BYiqCLWrIQ
c9eGNQmwaqfo2fzW+zj74AkNlPsJDVsP5f0Hj4Oi9i8K1FryZWIw0YGYhLMjq8+m
+oTpvPSeGIAdixYr9bPH6l+GqlP8itUgA/li3QcMQb5mei/evereMb9oM7ickS7y
TXPZNc1h197P/AP13+BsSrgWWqf6LwCpH7LJ7BWN1wP+HQ+Sc1rW/zo6awhIGJCZ
+BCGYq0FQkCPXirQAnqkTneNL+OwNkqNZwwXqxORA5FlF6Z69jah6YDgaeE6ZXR8
tttpEV6CJlxsI6tnJMX0wP3pNy0ruMc8KBXgVDX9mlUXs928wb1rr2QUksI0HTR6
ytnVkxMQaYgQcwsOERSVFOVWExXKKcaTVBDuQINpjVxE6xK2b/HsFtPU/TXdg6RN
odXDKGr2fnmyLBkJSjKIPLssUQDS+985gi3QF2WnEJ7EMBR+ldL70utyYn9VvyQD
IO+yQLMlicQb1DEmtKVR
=fLEb
-----END PGP SIGNATURE-----

--FcSpk3Icpd/Pbul4--
