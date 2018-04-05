Received: from eggs.gnu.org ([2001:4830:134:3::10]:47768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f47ei-0001Vx-3M
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f47ea-0001jq-5P
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:22:32 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f47ea-0001jg-0D
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:22:24 -0400
Received: by mail-qt0-x241.google.com with SMTP id l18so27538975qtj.1
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 09:22:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1522920750-11020-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8a8d49e3-478f-0d9d-80d1-f11101fd18bb@amsat.org>
Date: Thu, 5 Apr 2018 13:22:20 -0300
MIME-Version: 1.0
In-Reply-To: <1522920750-11020-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/sparc64/sun4u: Fix introspection by
 converting prom instance_init to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>

On 04/05/2018 06:32 AM, Thomas Huth wrote:
> The instance_init function of devices should always succeed to be able
> to introspect the device. However, the instance_init function of the
> "openprom" device can currently fail, for example like this:
> 
> $ echo "{'execute':'qmp_capabilities'}"\
>        "{'execute':'device-list-properties',"\
>        " 'arguments':{'typename':'openprom'}}" \
>        | sparc64-softmmu/qemu-system-sparc64 -M sun4v,accel=qtest -qmp stdio
> {"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
>  "package": "build-all"}, "capabilities": []}}
> {"return": {}}
> RAMBlock "sun4u.prom" already registered, abort!
> Aborted (core dumped)
> 
> This should not happen. Fix this problem by moving the affected code from
> instance_init into a realize function instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/sparc64/sun4u.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 2044a52..d62f5a2 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -425,13 +425,19 @@ static void prom_init(hwaddr addr, const char *bios_name)
>      }
>  }
>  
> -static void prom_init1(Object *obj)
> +static void prom_realize(DeviceState *ds, Error **errp)
>  {
> -    PROMState *s = OPENPROM(obj);
> -    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
> +    PROMState *s = OPENPROM(ds);
> +    SysBusDevice *dev = SYS_BUS_DEVICE(ds);
> +    Error *local_err = NULL;
> +
> +    memory_region_init_ram_nomigrate(&s->prom, OBJECT(ds), "sun4u.prom",
> +                                     PROM_SIZE_MAX, &local_err);

This looks the memory_region_init_ram() pattern...

> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
>  
> -    memory_region_init_ram_nomigrate(&s->prom, obj, "sun4u.prom", PROM_SIZE_MAX,
> -                           &error_fatal);
>      vmstate_register_ram_global(&s->prom);

...    ^

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      memory_region_set_readonly(&s->prom, true);
>      sysbus_init_mmio(dev, &s->prom);
> @@ -446,6 +452,7 @@ static void prom_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      dc->props = prom_properties;
> +    dc->realize = prom_realize;
>  }
>  
>  static const TypeInfo prom_info = {
> @@ -453,7 +460,6 @@ static const TypeInfo prom_info = {
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(PROMState),
>      .class_init    = prom_class_init,
> -    .instance_init = prom_init1,
>  };
>  
>  
> 
