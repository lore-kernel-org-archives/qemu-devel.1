Received: from eggs.gnu.org ([209.51.188.92]:48742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gwpUD-0006aD-Bh
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:38:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gwpUC-000084-9A
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:38:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59649)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gwpUC-00006F-0i
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:38:04 -0500
Date: Thu, 21 Feb 2019 15:37:53 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190221153753.48b40fd0@redhat.com>
In-Reply-To: <a9b921ba-0486-860a-02cf-6598466857aa@redhat.com>
References: <20190219060719.8211-1-richardw.yang@linux.intel.com>
	<20190219060719.8211-3-richardw.yang@linux.intel.com>
	<a9b921ba-0486-860a-02cf-6598466857aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] pc-dimm: remove realize callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, mst@redhat.com

On Tue, 19 Feb 2019 13:36:57 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 2/19/19 7:07 AM, Wei Yang wrote:
> > PCDIMM's realize callback is introduced to do proper setup for NVDIMM.
> >=20
> > Currently the NVDIMM setup task is nvdimm_prepare_memory_region(), which
> > is done in pre_plug stage. This means related task has already been done
> > at realize point.
> >=20
> > This patch remove PCDIMM realize callback.

pre_plug is machine helper and that it calls nvdimm_prepare_memory_region()
indirectly is just of side effect of current nvdimm impl. Another machine
might choose to implement it's own pre_plug to use with nvdimms, in which
case it might not call the function before realize, hence this patch makes
nvdimm device model incomplete and less robust.

Pls drop this patch

> > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> > ---
> >  hw/acpi/memory_hotplug.c |  1 -
> >  hw/mem/nvdimm.c          | 11 -----------
> >  hw/mem/pc-dimm.c         |  5 -----
> >  include/hw/mem/pc-dimm.h |  3 ---
> >  4 files changed, 20 deletions(-)
> >=20
> > diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> > index b19673d337..cb5284d36f 100644
> > --- a/hw/acpi/memory_hotplug.c
> > +++ b/hw/acpi/memory_hotplug.c
> > @@ -264,7 +264,6 @@ void acpi_memory_plug_cb(HotplugHandler *hotplug_de=
v, MemHotplugState *mem_st,
> >                           DeviceState *dev, Error **errp)
> >  {
> >      MemStatus *mdev;
> > -    DeviceClass *dc =3D DEVICE_GET_CLASS(dev); =20
>=20
> OK now I see the leftover of patch #1.
>=20
> > =20
> >      mdev =3D acpi_memory_slot_status(mem_st, dev, errp);
> >      if (!mdev) {
> > diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> > index bf2adf5e16..8f69576926 100644
> > --- a/hw/mem/nvdimm.c
> > +++ b/hw/mem/nvdimm.c
> > @@ -136,15 +136,6 @@ static MemoryRegion *nvdimm_md_get_memory_region(M=
emoryDeviceState *md,
> >      return nvdimm->nvdimm_mr;
> >  }
> > =20
> > -static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
> > -{
> > -    NVDIMMDevice *nvdimm =3D NVDIMM(dimm);
> > -
> > -    if (!nvdimm->nvdimm_mr) {
> > -        nvdimm_prepare_memory_region(nvdimm, errp);
> > -    }
> > -}
> > -
> >  /*
> >   * the caller should check the input parameters before calling
> >   * label read/write functions.
> > @@ -192,12 +183,10 @@ static Property nvdimm_properties[] =3D {
> > =20
> >  static void nvdimm_class_init(ObjectClass *oc, void *data)
> >  {
> > -    PCDIMMDeviceClass *ddc =3D PC_DIMM_CLASS(oc);
> >      MemoryDeviceClass *mdc =3D MEMORY_DEVICE_CLASS(oc);
> >      NVDIMMClass *nvc =3D NVDIMM_CLASS(oc);
> >      DeviceClass *dc =3D DEVICE_CLASS(oc);
> > =20
> > -    ddc->realize =3D nvdimm_realize;
> >      mdc->get_memory_region =3D nvdimm_md_get_memory_region;
> >      dc->props =3D nvdimm_properties;
> >   =20
>=20
> I'd split your patch in 2:
> - the previous part, cleaning NVDIMM,
> - the part below, doing "git revert 9f318f8f7e6" and improving the
> commit description.
>=20
> > diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> > index 152400b1fc..5832c0ba92 100644
> > --- a/hw/mem/pc-dimm.c
> > +++ b/hw/mem/pc-dimm.c
> > @@ -159,7 +159,6 @@ static void pc_dimm_init(Object *obj)
> >  static void pc_dimm_realize(DeviceState *dev, Error **errp)
> >  {
> >      PCDIMMDevice *dimm =3D PC_DIMM(dev);
> > -    PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> > =20
> >      if (!dimm->hostmem) {
> >          error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property is not se=
t");
> > @@ -178,10 +177,6 @@ static void pc_dimm_realize(DeviceState *dev, Erro=
r **errp)
> >          return;
> >      }
> > =20
> > -    if (ddc->realize) {
> > -        ddc->realize(dimm, errp);
> > -    }
> > -
> >      host_memory_backend_set_mapped(dimm->hostmem, true);
> >  }
> > =20
> > diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> > index 01436b9f50..d18f8246b7 100644
> > --- a/include/hw/mem/pc-dimm.h
> > +++ b/include/hw/mem/pc-dimm.h
> > @@ -59,8 +59,6 @@ typedef struct PCDIMMDevice {
> > =20
> >  /**
> >   * PCDIMMDeviceClass:
> > - * @realize: called after common dimm is realized so that the dimm bas=
ed
> > - * devices get the chance to do specified operations.
> >   * @get_vmstate_memory_region: returns #MemoryRegion which indicates t=
he
> >   * memory of @dimm should be kept during live migration. Will not fail
> >   * after the device was realized.
> > @@ -70,7 +68,6 @@ typedef struct PCDIMMDeviceClass {
> >      DeviceClass parent_class;
> > =20
> >      /* public */
> > -    void (*realize)(PCDIMMDevice *dimm, Error **errp);
> >      MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm,
> >                                                 Error **errp);
> >  } PCDIMMDeviceClass;
> >  =20
