Received: from eggs.gnu.org ([2001:4830:134:3::10]:41662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gOt8u-0002F9-K8
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 18:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gOt8r-0002J8-Ft
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 18:39:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gOt8r-0002He-8L
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 18:39:45 -0500
Date: Mon, 19 Nov 2018 21:39:41 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181119233941.GP3807@habkost.net>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-23-maozhongyi@cmss.chinamobile.com>
	<20181119233139.GO3807@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119233139.GO3807@habkost.net>
Subject: Re: [Qemu-devel] [PATCH 22/22] core/sysbus: remove the
 SysBusDeviceClass::init path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, pbonzini@redhat.com, armbru@redhat.com, peter.maydell@linaro.org, richard.henderson@linaro.org, alistair.francis@wdc.com, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On Mon, Nov 19, 2018 at 09:31:39PM -0200, Eduardo Habkost wrote:
> On Mon, Nov 19, 2018 at 08:08:20PM +0800, Mao Zhongyi wrote:
> > Currently, all sysbus devices have been converted to realize(),
> > so remove this path.
> > 
> > Cc: ehabkost@redhat.com
> > Cc: thuth@redhat.com
> > Cc: pbonzini@redhat.com
> > Cc: armbru@redhat.com
> > Cc: peter.maydell@linaro.org
> > Cc: richard.henderson@linaro.org
> > Cc: alistair.francis@wdc.com
> > 
> > Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> > Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> > ---
> >  hw/core/sysbus.c    | 15 ---------------
> >  include/hw/sysbus.h |  3 ---
> >  2 files changed, 18 deletions(-)
> > 
> > diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> > index 7ac36ad3e7..030ad426c1 100644
> > --- a/hw/core/sysbus.c
> > +++ b/hw/core/sysbus.c
> > @@ -201,20 +201,6 @@ void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size)
> >      }
> >  }
> >  
> > -/* TODO remove once all sysbus devices have been converted to realize */
> > -static void sysbus_realize(DeviceState *dev, Error **errp)
> > -{
> > -    SysBusDevice *sd = SYS_BUS_DEVICE(dev);
> > -    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
> > -
> > -    if (!sbc->init) {
> > -        return;
> > -    }
> > -    if (sbc->init(sd) < 0) {
> > -        error_setg(errp, "Device initialization failed");
> > -    }
> > -}
> 
> Nice.  :)
> 
> 
> > -
> >  DeviceState *sysbus_create_varargs(const char *name,
> >                                     hwaddr addr, ...)
> >  {
> > @@ -327,7 +313,6 @@ MemoryRegion *sysbus_address_space(SysBusDevice *dev)
> >  static void sysbus_device_class_init(ObjectClass *klass, void *data)
> >  {
> >      DeviceClass *k = DEVICE_CLASS(klass);
> > -    k->realize = sysbus_realize;
> 
> Have you ensured this won't break any subclasses that
> saved the original realize function on a parent_realize field?
> Now they will have parent_realize set to NULL.
> 
> Most of them use device_class_set_parent_realize() to implement
> that.

Found one:

$ ./aarch64-softmmu/qemu-system-aarch64 -machine virt,iommu=smmuv3
Segmentation fault (core dumped)

(gdb) bt
#0  0x0000000000000000 in  ()
#1  0x000055555596eabe in smmu_base_realize (dev=0x555556ac0cb0, errp=0x7fffffffc450) at /home/ehabkost/rh/proj/virt/qemu/hw/arm/smmu-common.c:428
#2  0x0000555555970322 in smmu_realize (d=0x555556ac0cb0, errp=0x7fffffffc4c0) at /home/ehabkost/rh/proj/virt/qemu/hw/arm/smmuv3.c:1390
#3  0x0000555555ac8f00 in device_set_realized (obj=<optimized out>, value=<optimized out>, errp=0x7fffffffc5b0) at hw/core/qdev.c:826
#4  0x0000555555c424a7 in property_set_bool (obj=0x555556ac0cb0, v=<optimized out>, name=<optimized out>, opaque=0x555556a05b70, errp=0x7fffffffc5b0) at qom/object.c:1991
#5  0x0000555555c468df in object_property_set_qobject (obj=obj@entry=0x555556ac0cb0, value=value@entry=0x555556ac2520, name=name@entry=0x555555de03f9 "realized", errp=errp@entry=0x7fffffffc5b0) at qom/qom-qobject.c:27
#6  0x0000555555c44355 in object_property_set_bool (obj=0x555556ac0cb0, value=<optimized out>, name=0x555555de03f9 "realized", errp=0x7fffffffc5b0) at qom/object.c:1249
#7  0x0000555555ac7e22 in qdev_init_nofail (dev=dev@entry=0x555556ac0cb0) at hw/core/qdev.c:313
#8  0x000055555592ef97 in create_smmu (bus=0x5555569970a0, pic=0x7fffffffc900, vms=<optimized out>) at /home/ehabkost/rh/proj/virt/qemu/hw/arm/virt.c:1058
#9  0x000055555592ef97 in create_pcie (pic=0x7fffffffc900, vms=<optimized out>) at /home/ehabkost/rh/proj/virt/qemu/hw/arm/virt.c:1208
#10 0x000055555592ef97 in machvirt_init (machine=0x55555663e9c0) at /home/ehabkost/rh/proj/virt/qemu/hw/arm/virt.c:1549
#11 0x0000555555acf013 in machine_run_board_init (machine=0x55555663e9c0) at hw/core/machine.c:834
#12 0x000055555581dab8 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4518

> 
> >      k->bus_type = TYPE_SYSTEM_BUS;
> >      /*
> >       * device_add plugs devices into a suitable bus.  For "real" buses,
> > diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
> > index 0b59a3b8d6..1aedcf05c9 100644
> > --- a/include/hw/sysbus.h
> > +++ b/include/hw/sysbus.h
> > @@ -38,9 +38,6 @@ typedef struct SysBusDevice SysBusDevice;
> >  typedef struct SysBusDeviceClass {
> >      /*< private >*/
> >      DeviceClass parent_class;
> > -    /*< public >*/
> > -
> > -    int (*init)(SysBusDevice *dev);
> >  
> >      /*
> >       * Let the sysbus device format its own non-PIO, non-MMIO unit address.
> > -- 
> > 2.17.1
> > 
> > 
> > 
> 
> -- 
> Eduardo

-- 
Eduardo
