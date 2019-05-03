Received: from eggs.gnu.org ([209.51.188.92]:53592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hMXbi-000777-Ez
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hMXbe-0006zC-NT
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:48:06 -0400
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Date: Fri, 3 May 2019 12:47:50 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F1B09C7@lhreml524-mbs.china.huawei.com>
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
	<20190409102935.28292-5-shameerali.kolothum.thodi@huawei.com>
	<20190502181929.0bad1fb5@Igors-MacBook-Pro>
In-Reply-To: <20190502181929.0bad1fb5@Igors-MacBook-Pro>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 4/8] hw/arm/virt: Add memory hotplug
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>, "xuwei (O)" <xuwei5@huawei.com>, "lersek@redhat.com" <lersek@redhat.com>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, Linuxarm <linuxarm@huawei.com>



> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: 02 May 2019 17:19
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org;
> shannon.zhaosl@gmail.com; sameo@linux.intel.com;
> sebastien.boeuf@intel.com; xuwei (O) <xuwei5@huawei.com>;
> lersek@redhat.com; ard.biesheuvel@linaro.org; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [PATCH v4 4/8] hw/arm/virt: Add memory hotplug framework
>=20
> On Tue, 9 Apr 2019 11:29:31 +0100
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
>=20
> > From: Eric Auger <eric.auger@redhat.com>
> >
> > This patch adds the memory hot-plug/hot-unplug infrastructure
> > in machvirt. The device memory is not yet exposed to the Guest
> > either though DT or ACPI and hence both cold/hot plug of memory
> s/though/through/

Sure.

> > is explicitly disabled for now.
> >
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  default-configs/arm-softmmu.mak |  3 +++
> >  hw/arm/virt.c                   | 45
> ++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 47 insertions(+), 1 deletion(-)
> >
> > diff --git a/default-configs/arm-softmmu.mak
> b/default-configs/arm-softmmu.mak
> > index 613d19a..9f4b803 100644
> > --- a/default-configs/arm-softmmu.mak
> > +++ b/default-configs/arm-softmmu.mak
> > @@ -160,3 +160,6 @@ CONFIG_MUSICPAL=3Dy
> >
> >  # for realview and versatilepb
> >  CONFIG_LSI_SCSI_PCI=3Dy
> > +
> > +CONFIG_MEM_DEVICE=3Dy
> > +CONFIG_DIMM=3Dy
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index ce2664a..da516b3 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -61,6 +61,8 @@
> >  #include "hw/arm/smmuv3.h"
> >  #include "hw/acpi/acpi.h"
> >  #include "target/arm/internals.h"
> > +#include "hw/mem/pc-dimm.h"
> > +#include "hw/mem/nvdimm.h"
> >
> >  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
> >      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> > @@ -1806,6 +1808,34 @@ static const CPUArchIdList
> *virt_possible_cpu_arch_ids(MachineState *ms)
> >      return ms->possible_cpus;
> >  }
> >
> > +static void virt_memory_pre_plug(HotplugHandler *hotplug_dev,
> DeviceState *dev,
> > +                                 Error **errp)
> > +{
> > +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > +        error_setg(errp, "memory cold/hot plug is not yet supported");
> > +        return;
> > +    }
> add comment here why it's needed.

Ok.

>=20
> > +
> > +    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL,
> errp);
> maybe before calling this there probably should be check if acpi is enabl=
ed.
>=20
> not sure if arm/virt board honors -no-acpi CLI option.

Ok. I will check this

Thanks,
Shameer
=20
> > +}
> > +
> > +static void virt_memory_plug(HotplugHandler *hotplug_dev,
> > +                             DeviceState *dev, Error **errp)
> > +{
> > +    VirtMachineState *vms =3D VIRT_MACHINE(hotplug_dev);
> > +
> > +    pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), NULL);
> > +
> > +}
> > +
> > +static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_de=
v,
> > +                                            DeviceState *dev,
> Error **errp)
> > +{
> > +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > +        virt_memory_pre_plug(hotplug_dev, dev, errp);
> > +    }
> > +}
> > +
> >  static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
> >                                          DeviceState *dev, Error
> **errp)
> >  {
> > @@ -1817,12 +1847,23 @@ static void
> virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
> >                                       SYS_BUS_DEVICE(dev));
> >          }
> >      }
> > +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > +        virt_memory_plug(hotplug_dev, dev, errp);
> > +    }
> > +}
> > +
> > +static void virt_machine_device_unplug_request_cb(HotplugHandler
> *hotplug_dev,
> > +                                          DeviceState *dev, Error
> **errp)
> > +{
> > +    error_setg(errp, "device unplug request for unsupported device"
> > +               " type: %s", object_get_typename(OBJECT(dev)));
> >  }
> >
> >  static HotplugHandler *virt_machine_get_hotplug_handler(MachineState
> *machine,
> >
> DeviceState *dev)
> >  {
> > -    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
> > +    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE) ||
> > +       (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM))) {
> >          return HOTPLUG_HANDLER(machine);
> >      }
> >
> > @@ -1886,7 +1927,9 @@ static void virt_machine_class_init(ObjectClass
> *oc, void *data)
> >      mc->kvm_type =3D virt_kvm_type;
> >      assert(!mc->get_hotplug_handler);
> >      mc->get_hotplug_handler =3D virt_machine_get_hotplug_handler;
> > +    hc->pre_plug =3D virt_machine_device_pre_plug_cb;
> >      hc->plug =3D virt_machine_device_plug_cb;
> > +    hc->unplug_request =3D virt_machine_device_unplug_request_cb;
> >  }
> >
> >  static void virt_instance_init(Object *obj)
