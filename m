Received: from eggs.gnu.org ([2001:4830:134:3::10]:60309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ffBar-0004aW-20
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 18:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ffBaq-0002wT-08
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 18:03:45 -0400
MIME-Version: 1.0
In-Reply-To: <1531745974-17187-8-git-send-email-thuth@redhat.com>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
	<1531745974-17187-8-git-send-email-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Jul 2018 15:03:11 -0700
Message-ID: <CAKmqyKMcjQdBAnfmKoOEXzNF66T1wHMWbjWwU+-Fw+Js5hF-Vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 07/17] hw/cpu/a9mpcore: Fix
 introspection problems with the "a9mpcore_priv" device
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
> Running QEMU with valgrind indicates a problem here:
>
> echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
>  "'arguments':{'typename':'a9mpcore_priv'}}" \
>  "{'execute': 'human-monitor-command', " \
>  "'arguments': {'command-line': 'info qtree'}}" | \
>  valgrind -q aarch64-softmmu/qemu-system-aarch64 -M none,accel=qtest -qmp stdio
> [...]
> ==30996== Invalid read of size 8
> ==30996==    at 0x6185DA: qdev_print (qdev-monitor.c:686)
> ==30996==    by 0x6185DA: qbus_print (qdev-monitor.c:719)
> ==30996==    by 0x452B38: handle_hmp_command (monitor.c:3446)
> [...]
>
> Use the new sysbus_init_child_obj() function to make sure that the objects
> are cleaned up correctly when the parent gets destroyed.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/cpu/a9mpcore.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
> index f17f292..a5b8678 100644
> --- a/hw/cpu/a9mpcore.c
> +++ b/hw/cpu/a9mpcore.c
> @@ -27,20 +27,18 @@ static void a9mp_priv_initfn(Object *obj)
>      memory_region_init(&s->container, obj, "a9mp-priv-container", 0x2000);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->container);
>
> -    object_initialize(&s->scu, sizeof(s->scu), TYPE_A9_SCU);
> -    qdev_set_parent_bus(DEVICE(&s->scu), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "scu", &s->scu, sizeof(s->scu), TYPE_A9_SCU);
>
> -    object_initialize(&s->gic, sizeof(s->gic), TYPE_ARM_GIC);
> -    qdev_set_parent_bus(DEVICE(&s->gic), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic), TYPE_ARM_GIC);
>
> -    object_initialize(&s->gtimer, sizeof(s->gtimer), TYPE_A9_GTIMER);
> -    qdev_set_parent_bus(DEVICE(&s->gtimer), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "gtimer", &s->gtimer, sizeof(s->gtimer),
> +                          TYPE_A9_GTIMER);
>
> -    object_initialize(&s->mptimer, sizeof(s->mptimer), TYPE_ARM_MPTIMER);
> -    qdev_set_parent_bus(DEVICE(&s->mptimer), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "mptimer", &s->mptimer, sizeof(s->mptimer),
> +                          TYPE_ARM_MPTIMER);
>
> -    object_initialize(&s->wdt, sizeof(s->wdt), TYPE_ARM_MPTIMER);
> -    qdev_set_parent_bus(DEVICE(&s->wdt), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "wdt", &s->wdt, sizeof(s->wdt),
> +                          TYPE_ARM_MPTIMER);
>  }
>
>  static void a9mp_priv_realize(DeviceState *dev, Error **errp)
> --
> 1.8.3.1
>
>
