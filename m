Received: from eggs.gnu.org ([2001:4830:134:3::10]:52645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDSbV-00076k-8Y
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDSbO-0003Zv-TA
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:29:17 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:60844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dDSbO-0003Z1-Js
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:29:10 -0400
Received: from player718.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id A50E988741
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 11:29:05 +0200 (CEST)
Date: Wed, 24 May 2017 11:28:57 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170524112857.31c3d8f9@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170524050754.GW30246@umbus.fritz.box>
References: <20170523111812.13469-1-lvivier@redhat.com>
	<20170523111812.13469-4-lvivier@redhat.com>
	<20170524050754.GW30246@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/5/fhNpKbb9btSHDsh5Mknbl";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/4] spapr: disable hotplugging
 without OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

--Sig_/5/fhNpKbb9btSHDsh5Mknbl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 24 May 2017 15:07:54 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, May 23, 2017 at 01:18:11PM +0200, Laurent Vivier wrote:
> > If the OS is not started, QEMU sends an event to the OS
> > that is lost and cannot be recovered. An unplug is not
> > able to restore QEMU in a coherent state.
> > So, while the OS is not started, disable CPU and memory hotplug.
> > We use option vector 6 to know if the OS is started
> >=20
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com> =20
>=20
> Urgh.. I'm not terribly confident that this is really correct.  As
> discussed on the previous patch, you're essentially using OV6 as a
> flag that CAS is complete.
>=20
> But while it undoubtedly makes the race window much smaller, I don't
> see that there's any guarantee the guest OS will really be able to
> handle hotplug events immediately after CAS.
>=20
> In particular if the CAS process completes partially but then needs to
> trigger a reboot, I think that would end up setting the ov6 variable,
> but the OS would definitely not be in a state to accept events.
>=20

We never have any guarantee that the OS will process an event that
we've sent actually (think of a kernel crash just after a successful
CAS negotiation for example, or any failure with the various guest
components involved in the process of hotplug).

> Mike, I really think we need some input from someone familiar with how
> these hotplug events are supposed to work.  What do we need to do to
> handle lost or stale events, such as those delivered when an OS is not
> booted.
>=20

AFAIK, in the PowerVM world, the HMC exposes a user configurable timeout.

https://www.ibm.com/support/knowledgecenter/POWER8/p8hat/p8hat_dlparprocpow=
eraddp6.htm

I'm not sure we can do anything better than being able to "cancel" a previo=
us
hotplug attempt if it takes too long, but I'm not necessarily the expert yo=
u're
looking for :)

> > ---
> >  hw/ppc/spapr.c | 22 +++++++++++++++++++---
> >  1 file changed, 19 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index eceb4cc..2e9320d 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2625,6 +2625,7 @@ out:
> >  static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceS=
tate *dev,
> >                                  Error **errp)
> >  {
> > +    sPAPRMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
> >      PCDIMMDevice *dimm =3D PC_DIMM(dev);
> >      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> >      MemoryRegion *mr =3D ddc->get_memory_region(dimm);
> > @@ -2645,6 +2646,13 @@ static void spapr_memory_pre_plug(HotplugHandler=
 *hotplug_dev, DeviceState *dev,
> >          goto out;
> >      }
> > =20
> > +    if (dev->hotplugged) {
> > +        if (!ms->os_name) {
> > +            error_setg(&local_err, "Memory hotplug not supported witho=
ut OS");
> > +            goto out;
> > +        }
> > +    }
> > +
> >  out:
> >      error_propagate(errp, local_err);
> >  }
> > @@ -2874,6 +2882,7 @@ static void spapr_core_pre_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
> >                                  Error **errp)
> >  {
> >      MachineState *machine =3D MACHINE(OBJECT(hotplug_dev));
> > +    sPAPRMachineState *ms =3D SPAPR_MACHINE(machine);
> >      MachineClass *mc =3D MACHINE_GET_CLASS(hotplug_dev);
> >      Error *local_err =3D NULL;
> >      CPUCore *cc =3D CPU_CORE(dev);
> > @@ -2884,9 +2893,16 @@ static void spapr_core_pre_plug(HotplugHandler *=
hotplug_dev, DeviceState *dev,
> >      int node_id;
> >      int index;
> > =20
> > -    if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
> > -        error_setg(&local_err, "CPU hotplug not supported for this mac=
hine");
> > -        goto out;
> > +    if (dev->hotplugged) {
> > +        if (!mc->has_hotpluggable_cpus) {
> > +            error_setg(&local_err,
> > +                       "CPU hotplug not supported for this machine");
> > +            goto out;
> > +        }
> > +        if (!ms->os_name) {
> > +            error_setg(&local_err, "CPU hotplug not supported without =
OS");
> > +            goto out;
> > +        }
> >      }
> > =20
> >      if (strcmp(base_core_type, type)) { =20
>=20


--Sig_/5/fhNpKbb9btSHDsh5Mknbl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlklUlkACgkQAvw66wEB28K6MwCaAhhlgj1/nSHQHHdmuY5ZkJws
U6kAoIH44uvbjitdAoWqauk/9+mFENFW
=YoJY
-----END PGP SIGNATURE-----

--Sig_/5/fhNpKbb9btSHDsh5Mknbl--
