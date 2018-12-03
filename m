Received: from eggs.gnu.org ([2001:4830:134:3::10]:56131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gTmJO-0004uf-IA
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 06:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gTmJN-0006Ya-N8
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 06:22:50 -0500
Date: Mon, 3 Dec 2018 12:22:33 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181203112233.j2xjnrezrapgqm2b@kamzik.brq.redhat.com>
References: <1543865209-50994-1-git-send-email-peng.hao2@zte.com.cn>
	<1543865209-50994-7-git-send-email-peng.hao2@zte.com.cn>
	<20181203111836.qqfzcfwazk2g6kvr@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203111836.qqfzcfwazk2g6kvr@kamzik.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH V11 6/8] hw/arm/virt: add configure
 interface for pvpanic-mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: peter.maydell@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org

On Mon, Dec 03, 2018 at 12:18:36PM +0100, Andrew Jones wrote:
> On Tue, Dec 04, 2018 at 03:26:47AM +0800, Peng Hao wrote:
> > Add configure interface for pvpanic-mmio device in virt machine.
> > 
> > Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> > ---
> >  hw/arm/virt.c         | 23 +++++++++++++++++++++++
> >  include/hw/arm/virt.h |  1 +
> >  2 files changed, 24 insertions(+)
> > 
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index a4541fa..fdd3f20 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -1655,6 +1655,20 @@ static void virt_set_its(Object *obj, bool value, Error **errp)
> >      vms->its = value;
> >  }
> >  
> > +static bool virt_get_pvpanic(Object *obj, Error **errp)
> > +{
> > +    VirtMachineState *vms = VIRT_MACHINE(obj);
> > +
> > +    return vms->pvpanic;
> > +}
> > +
> > +static void virt_set_pvpanic(Object *obj, bool value, Error **errp)
> > +{
> > +    VirtMachineState *vms = VIRT_MACHINE(obj);
> > +
> > +    vms->pvpanic = value;
> > +}
> > +
> >  static char *virt_get_gic_version(Object *obj, Error **errp)
> >  {
> >      VirtMachineState *vms = VIRT_MACHINE(obj);
> > @@ -1884,6 +1898,15 @@ static void virt_3_1_instance_init(Object *obj)
> >                                      "Valid values are none and smmuv3",
> >                                      NULL);
> >  
> > +    /* Default disallows pvpanic-mmio instantiation */
> > +    vms->pvpanic = false;
> > +    object_property_add_bool(obj, "pvpanic", virt_get_pvpanic,
> > +                             virt_set_pvpanic, NULL);
> > +    object_property_set_description(obj, "pvpanic",
> > +                                    "Set on/off to enable/disable "
> > +                                    "PVPANIC MMIO device",
> > +                                    NULL);
> > +
> >      vms->memmap = a15memmap;
> >      vms->irqmap = a15irqmap;
> >  }
> > diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> > index 937c124..7d6d1c0 100644
> > --- a/include/hw/arm/virt.h
> > +++ b/include/hw/arm/virt.h
> > @@ -113,6 +113,7 @@ typedef struct {
> >      bool highmem;
> >      bool highmem_ecam;
> >      bool its;
> > +    bool pvpanic;
> 
> This hunk should be squashed into 4/8 and the respective hunks of 7/8
> should be squashed into 4/8 and 5/8.
>

With the above changes

Reviewed-by: Andrew Jones <drjones@redhat.com>
