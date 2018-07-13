Received: from eggs.gnu.org ([2001:4830:134:3::10]:53289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe5v7-0003UA-E2
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 17:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe5v6-0006MG-HA
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 17:48:09 -0400
Date: Fri, 13 Jul 2018 18:48:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180713214801.GX31657@localhost.localdomain>
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
	<1531470464-21522-6-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531470464-21522-6-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/16] hw/cpu/a15mpcore: Fix
 introspection problem with the a15mpcore_priv device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Fri, Jul 13, 2018 at 10:27:33AM +0200, Thomas Huth wrote:
> There is a memory management problem when introspecting the a15mpcore_priv
> device. It can be seen with valgrind when running QEMU like this:
> 
> echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
>  "'arguments':{'typename':'a15mpcore_priv'}}"\
>  "{'execute': 'human-monitor-command', " \
>  "'arguments': {'command-line': 'info qtree'}}"  | \
>  valgrind -q aarch64-softmmu/qemu-system-aarch64 -M none,accel=qtest -qmp stdio
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2},
>  "package": "build-all"}, "capabilities": []}}
> {"return": {}}
> {"return": [{"name": "num-cpu", "type": "uint32"}, {"name": "num-irq",
>  "type": "uint32"}, {"name": "a15mp-priv-container[0]", "type":
>   "child<qemu:memory-region>"}]}
> ==24978== Invalid read of size 8
> ==24978==    at 0x618EBA: qdev_print (qdev-monitor.c:686)
> ==24978==    by 0x618EBA: qbus_print (qdev-monitor.c:719)
> [...]
> 
> Use the new sysbus_init_child_obj() function to make sure that we get
> the reference counting of the child objects right.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/cpu/a15mpcore.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
> index bc05152..43c1079 100644
> --- a/hw/cpu/a15mpcore.c
> +++ b/hw/cpu/a15mpcore.c
> @@ -35,15 +35,13 @@ static void a15mp_priv_initfn(Object *obj)
>  {
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>      A15MPPrivState *s = A15MPCORE_PRIV(obj);
> -    DeviceState *gicdev;
>  
>      memory_region_init(&s->container, obj, "a15mp-priv-container", 0x8000);
>      sysbus_init_mmio(sbd, &s->container);
>  
> -    object_initialize(&s->gic, sizeof(s->gic), gic_class_name());
> -    gicdev = DEVICE(&s->gic);
> -    qdev_set_parent_bus(gicdev, sysbus_get_default());
> -    qdev_prop_set_uint32(gicdev, "revision", 2);
> +    sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
> +                          gic_class_name());
> +    qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);

I assume qdev_set_parent_bus() won't trigger any code that looks
at "revision", so the prop_set/set_parent_bus ordering change
won't matter.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
