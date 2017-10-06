Received: from eggs.gnu.org ([2001:4830:134:3::10]:51184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e0P0E-000471-Vz
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e0P09-0006mL-Tp
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:33:07 -0400
Date: Fri, 6 Oct 2017 11:32:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171006113258.6f350f59@nial.brq.redhat.com>
In-Reply-To: <20171006084634.GA10961@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-23-git-send-email-imammedo@redhat.com>
	<20171006084634.GA10961@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/23] ppc: pnv: drop
 PnvChipClass::cpu_model field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?UTF-8?B?SGVy?= =?UTF-8?B?dsOp?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>

On Fri, 6 Oct 2017 19:46:34 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Oct 05, 2017 at 06:24:49PM +0200, Igor Mammedov wrote:
> > deduce core type directly from chip type instead of
> > maintaining type mapping in PnvChipClass::cpu_model.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/hw/ppc/pnv.h      |  1 -
> >  include/hw/ppc/pnv_core.h |  1 -
> >  hw/ppc/pnv.c              | 25 +++++++++++++------------
> >  hw/ppc/pnv_core.c         |  5 -----
> >  4 files changed, 13 insertions(+), 19 deletions(-)
> > 
> > diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> > index d82eee1..20244da 100644
> > --- a/include/hw/ppc/pnv.h
> > +++ b/include/hw/ppc/pnv.h
> > @@ -69,7 +69,6 @@ typedef struct PnvChipClass {
> >      SysBusDeviceClass parent_class;
> >  
> >      /*< public >*/
> > -    const char *cpu_model;
> >      PnvChipType  chip_type;
> >      uint64_t     chip_cfam_id;
> >      uint64_t     cores_mask;
> > diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> > index a336a1f..e337af7 100644
> > --- a/include/hw/ppc/pnv_core.h
> > +++ b/include/hw/ppc/pnv_core.h
> > @@ -46,6 +46,5 @@ typedef struct PnvCoreClass {
> >  
> >  #define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
> >  #define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
> > -extern char *pnv_core_typename(const char *model);
> >  
> >  #endif /* _PPC_PNV_CORE_H */
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 9c5eb7c..ab7083b 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -55,6 +55,16 @@
> >  #define KERNEL_LOAD_ADDR        0x20000000
> >  #define INITRD_LOAD_ADDR        0x40000000
> >  
> > +static const char *pvn_chip_core_typename(const PnvChip *o)  
> 
> s/pvn/pnv/ again.
copypast bites again :/,
I'll fix it up on respin

> 
> > +{
> > +    const char *chip_type = object_class_get_name(object_get_class(OBJECT(o)));
> > +    int len = strlen(chip_type) - strlen(PNV_CHIP_TYPE_SUFFIX);
> > +    char *s = g_strdup_printf(PNV_CORE_TYPE_NAME("%.*s"), len, chip_type);
> > +    const char *core_type = object_class_get_name(object_class_by_name(s));
> > +    g_free(s);
> > +    return core_type;
> > +}
> > +
> >  /*
> >   * On Power Systems E880 (POWER8), the max cpus (threads) should be :
> >   *     4 * 4 sockets * 12 cores * 8 threads = 1536
> > @@ -270,8 +280,7 @@ static int pnv_chip_lpc_offset(PnvChip *chip, void *fdt)
> >  
> >  static void powernv_populate_chip(PnvChip *chip, void *fdt)
> >  {
> > -    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
> > -    char *typename = pnv_core_typename(pcc->cpu_model);
> > +    const char *typename = pvn_chip_core_typename(chip);
> >      size_t typesize = object_type_get_instance_size(typename);
> >      int i;
> >  
> > @@ -301,7 +310,6 @@ static void powernv_populate_chip(PnvChip *chip, void *fdt)
> >          powernv_populate_memory_node(fdt, chip->chip_id, chip->ram_start,
> >                                       chip->ram_size);
> >      }
> > -    g_free(typename);
> >  }
> >  
> >  static void powernv_populate_rtc(ISADevice *d, void *fdt, int lpc_off)
> > @@ -713,7 +721,6 @@ static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
> >      DeviceClass *dc = DEVICE_CLASS(klass);
> >      PnvChipClass *k = PNV_CHIP_CLASS(klass);
> >  
> > -    k->cpu_model = "power8e_v2.1";
> >      k->chip_type = PNV_CHIP_POWER8E;
> >      k->chip_cfam_id = 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
> >      k->cores_mask = POWER8E_CORE_MASK;
> > @@ -735,7 +742,6 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
> >      DeviceClass *dc = DEVICE_CLASS(klass);
> >      PnvChipClass *k = PNV_CHIP_CLASS(klass);
> >  
> > -    k->cpu_model = "power8_v2.0";
> >      k->chip_type = PNV_CHIP_POWER8;
> >      k->chip_cfam_id = 0x220ea04980000000ull; /* P8 Venice DD2.0 */
> >      k->cores_mask = POWER8_CORE_MASK;
> > @@ -757,7 +763,6 @@ static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
> >      DeviceClass *dc = DEVICE_CLASS(klass);
> >      PnvChipClass *k = PNV_CHIP_CLASS(klass);
> >  
> > -    k->cpu_model = "power8nvl_v1.0";
> >      k->chip_type = PNV_CHIP_POWER8NVL;
> >      k->chip_cfam_id = 0x120d304980000000ull;  /* P8 Naples DD1.0 */
> >      k->cores_mask = POWER8_CORE_MASK;
> > @@ -779,7 +784,6 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
> >      DeviceClass *dc = DEVICE_CLASS(klass);
> >      PnvChipClass *k = PNV_CHIP_CLASS(klass);
> >  
> > -    k->cpu_model = "power9_v1.0";
> >      k->chip_type = PNV_CHIP_POWER9;
> >      k->chip_cfam_id = 0x100d104980000000ull; /* P9 Nimbus DD1.0 */
> >      k->cores_mask = POWER9_CORE_MASK;
> > @@ -854,7 +858,7 @@ static void pnv_chip_init(Object *obj)
> >  static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
> >  {
> >      PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
> > -    char *typename = pnv_core_typename(pcc->cpu_model);
> > +    const char *typename = pvn_chip_core_typename(chip);
> >      size_t typesize = object_type_get_instance_size(typename);
> >      int i, j;
> >      char *name;
> > @@ -879,8 +883,6 @@ static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
> >              memory_region_add_subregion(&chip->icp_mmio, pir << 12, &icp->mmio);
> >          }
> >      }
> > -
> > -    g_free(typename);
> >  }
> >  
> >  static void pnv_chip_realize(DeviceState *dev, Error **errp)
> > @@ -888,7 +890,7 @@ static void pnv_chip_realize(DeviceState *dev, Error **errp)
> >      PnvChip *chip = PNV_CHIP(dev);
> >      Error *error = NULL;
> >      PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
> > -    char *typename = pnv_core_typename(pcc->cpu_model);
> > +    const char *typename = pvn_chip_core_typename(chip);
> >      size_t typesize = object_type_get_instance_size(typename);
> >      int i, core_hwid;
> >  
> > @@ -947,7 +949,6 @@ static void pnv_chip_realize(DeviceState *dev, Error **errp)
> >                                  &PNV_CORE(pnv_core)->xscom_regs);
> >          i++;
> >      }
> > -    g_free(typename);
> >  
> >      /* Create LPC controller */
> >      object_property_set_bool(OBJECT(&chip->lpc), true, "realized",
> > diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> > index 000c87e..621b69e 100644
> > --- a/hw/ppc/pnv_core.c
> > +++ b/hw/ppc/pnv_core.c
> > @@ -246,9 +246,4 @@ static const TypeInfo pnv_core_infos[] = {
> >      DEFINE_PNV_CORE_TYPE("power9_v1.0"),
> >  };
> >  
> > -char *pnv_core_typename(const char *model)
> > -{
> > -    return g_strdup_printf(PNV_CORE_TYPE_NAME("%s"), model);
> > -}
> > -
> >  DEFINE_TYPES(pnv_core_infos)  
> 
