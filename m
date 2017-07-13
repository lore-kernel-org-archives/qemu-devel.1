Received: from eggs.gnu.org ([2001:4830:134:3::10]:54859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVSDh-0001q4-M8
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 20:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVSDe-0003vg-Id
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 20:43:05 -0400
Date: Thu, 13 Jul 2017 10:30:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170713003054.GP4083@umbus.fritz.box>
References: <20170712055317.26225-1-david@gibson.dropbear.id.au>
	<20170712055317.26225-4-david@gibson.dropbear.id.au>
	<20170712120451.198aef60@bahia.lan>
	<20170712123148.3b4bc4f2@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kynn+LdAwU9N+JqL"
Content-Disposition: inline
In-Reply-To: <20170712123148.3b4bc4f2@bahia.lan>
Subject: Re: [Qemu-devel] [PATCHv2 3/8] spapr: Simplify unplug path
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


--Kynn+LdAwU9N+JqL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 12:31:48PM +0200, Greg Kurz wrote:
> On Wed, 12 Jul 2017 12:04:51 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Wed, 12 Jul 2017 15:53:12 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > spapr_lmb_release() and spapr_core_release() call hotplug_handler_unp=
lug()
> > > which after a bunch of indirection calls spapr_memory_unplug() or
> > > spapr_core_unplug().  But we already know which is the appropriate th=
ing
> > > to call here, so we can just fold it directly into the release functi=
on.
> > >=20
> > > Once that's done, there's no need for an hc->unplug method in the spa=
pr
> > > machine at all: since we also have an hc->unplug_request method, the
> > > hotplug core will never use ->unplug.
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > --- =20
> >=20
> > Nice cleanup :)
> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >=20
> > >  hw/ppc/spapr.c | 54 ++++++++----------------------------------------=
------
> > >  1 file changed, 8 insertions(+), 46 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 2a059d5..ff2aa6b 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2818,6 +2818,9 @@ void spapr_lmb_release(DeviceState *dev)
> > >  {
> > >      HotplugHandler *hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
> > >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(hotplug_ctrl);
>=20
> BTW, maybe you can also drop the hotplug_ctrl variable since it only has
> one trivial user.

Good idea, done.

>=20
> > > +    PCDIMMDevice *dimm =3D PC_DIMM(dev);
> > > +    PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> > > +    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
> > >      sPAPRDIMMState *ds =3D spapr_pending_dimm_unplugs_find(spapr, PC=
_DIMM(dev));
> > > =20
> > >      /* This information will get lost if a migration occurs
> > > @@ -2838,18 +2841,7 @@ void spapr_lmb_release(DeviceState *dev)
> > >       * Now that all the LMBs have been removed by the guest, call the
> > >       * pc-dimm unplug handler to cleanup up the pc-dimm device.
> > >       */
> > > -    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
> > > -}
> > > -
> > > -static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceS=
tate *dev,
> > > -                                Error **errp)
> > > -{
> > > -    sPAPRMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
> > > -    PCDIMMDevice *dimm =3D PC_DIMM(dev);
> > > -    PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> > > -    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
> > > -
> > > -    pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
> > > +    pc_dimm_memory_unplug(dev, &spapr->hotplug_memory, mr);
> > >      object_unparent(OBJECT(dev));
> > >  }
> > > =20
> > > @@ -2918,10 +2910,11 @@ static void *spapr_populate_hotplug_cpu_dt(CP=
UState *cs, int *fdt_offset,
> > >      return fdt;
> > >  }
> > > =20
> > > -static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceSta=
te *dev,
> > > -                              Error **errp)
> > > +/* Callback to be called during DRC release. */
> > > +void spapr_core_release(DeviceState *dev)
> > >  {
> > > -    MachineState *ms =3D MACHINE(qdev_get_machine());
> > > +    HotplugHandler *hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
> > > +    MachineState *ms =3D MACHINE(hotplug_ctrl);
>=20
> Same here.
>=20
> > >      sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(ms);
> > >      CPUCore *cc =3D CPU_CORE(dev);
> > >      CPUArchId *core_slot =3D spapr_find_cpu_slot(ms, cc->core_id, NU=
LL);
> > > @@ -2945,15 +2938,6 @@ static void spapr_core_unplug(HotplugHandler *=
hotplug_dev, DeviceState *dev,
> > >      object_unparent(OBJECT(dev));
> > >  }
> > > =20
> > > -/* Callback to be called during DRC release. */
> > > -void spapr_core_release(DeviceState *dev)
> > > -{
> > > -    HotplugHandler *hotplug_ctrl;
> > > -
> > > -    hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
> > > -    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
> > > -}
> > > -
> > >  static
> > >  void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceSt=
ate *dev,
> > >                                 Error **errp)
> > > @@ -3159,27 +3143,6 @@ static void spapr_machine_device_plug(HotplugH=
andler *hotplug_dev,
> > >      }
> > >  }
> > > =20
> > > -static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
> > > -                                      DeviceState *dev, Error **errp)
> > > -{
> > > -    sPAPRMachineState *sms =3D SPAPR_MACHINE(qdev_get_machine());
> > > -    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
> > > -
> > > -    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > > -        if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
> > > -            spapr_memory_unplug(hotplug_dev, dev, errp);
> > > -        } else {
> > > -            error_setg(errp, "Memory hot unplug not supported for th=
is guest");
> > > -        }
> > > -    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)=
) {
> > > -        if (!mc->has_hotpluggable_cpus) {
> > > -            error_setg(errp, "CPU hot unplug not supported on this m=
achine");
> > > -            return;
> > > -        }
> > > -        spapr_core_unplug(hotplug_dev, dev, errp);
> > > -    }
> > > -}
> > > -
> > >  static void spapr_machine_device_unplug_request(HotplugHandler *hotp=
lug_dev,
> > >                                                  DeviceState *dev, Er=
ror **errp)
> > >  {
> > > @@ -3397,7 +3360,6 @@ static void spapr_machine_class_init(ObjectClas=
s *oc, void *data)
> > >      mc->get_hotplug_handler =3D spapr_get_hotplug_handler;
> > >      hc->pre_plug =3D spapr_machine_device_pre_plug;
> > >      hc->plug =3D spapr_machine_device_plug;
> > > -    hc->unplug =3D spapr_machine_device_unplug;
> > >      mc->cpu_index_to_instance_props =3D spapr_cpu_index_to_props;
> > >      mc->possible_cpu_arch_ids =3D spapr_possible_cpu_arch_ids;
> > >      hc->unplug_request =3D spapr_machine_device_unplug_request; =20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Kynn+LdAwU9N+JqL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZZr89AAoJEGw4ysog2bOSoiYP/jnbu0AAvW0xhYFIBmqGI85c
pCgrTRGNxPqcmr1tgwtXh9amj1wecqCfLXhO68DNRFWyPfnB8uIfzLl177GTdBz4
Gs5zfZJ6Xox9CZhm3UxV4VF6IBOGgrAaatJ4WHKWsxSog2G9PNgL2nfbmvlmhSp4
ckqEgxBtZrULIiDx/OiRo10BQ1bwaEha1HtNQfwtnl1gJxYO0aMkecITJ2hcOYT7
kxn0wHjKfoACp+QrYh5H3zaypKpKu0iMIUeBYaGD6F2vVrQSYzPaoqEEN83HLErR
4+JsJ0GNfn+s9RDp/QKp2lXJYBWwIF5qY/DE3FN0kIN/YHNguhl8XBEGpUAPLmNy
kEq6l0Ege0Sc4UK1ks1cXTkxeySxDSsV0a+13jyp0SApAyUBpiS55rn2WQP/sJpM
DOXV+mdVgEtZfDA4jmdyI3DjZL7gKdVGuiaodceeSySG3r7imlAZtdy6PXlh0Wtq
TEqt2RDzQgy+8paJu+4+J3a5eju+Oz6RYwk+mp1V7Ak0dC52P8gqOclOyBiFFD5U
Q9sinNWmFApSWLrIF/mYzi4y6Je2V5W607kH4uEKqDDn/vkzr390IZ5SkwgwQK/J
x9umtTGQuj8RZuLfBuTacJYePn+shrmNinsDzH8AqyI7H7+RSzIYKZL+eGazASWA
tAL8vK93+myp5a/aMGg+
=ZH85
-----END PGP SIGNATURE-----

--Kynn+LdAwU9N+JqL--
