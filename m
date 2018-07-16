Received: from eggs.gnu.org ([2001:4830:134:3::10]:58619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ffBT7-0000tw-OM
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ffBT6-0007yG-Rw
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:55:45 -0400
MIME-Version: 1.0
In-Reply-To: <1531745974-17187-6-git-send-email-thuth@redhat.com>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
	<1531745974-17187-6-git-send-email-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Jul 2018 14:55:12 -0700
Message-ID: <CAKmqyKP8PbUzt9+MUCPvnum0=HatEiMd-6fwtXLv23M99G4KmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 05/17] hw/cpu/a15mpcore: Fix
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Alistair Francis <alistair@alistair23.me>, Markus Armbruster <armbru@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

On Mon, Jul 16, 2018 at 5:59 AM, Thomas Huth <thuth@redhat.com> wrote:
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
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
>  }
>
>  static void a15mp_priv_realize(DeviceState *dev, Error **errp)
> --
> 1.8.3.1
>
>
