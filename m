Received: from eggs.gnu.org ([2001:4830:134:3::10]:58250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ffBRi-0008MT-Jn
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ffBRh-0006fN-Bk
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:54:18 -0400
MIME-Version: 1.0
In-Reply-To: <1531745974-17187-3-git-send-email-thuth@redhat.com>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
	<1531745974-17187-3-git-send-email-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Jul 2018 14:53:44 -0700
Message-ID: <CAKmqyKPz-PCmPcd2xtRe+1Oi-FHxSKEdMN8qnskMXd-JvV5+jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 02/17] hw/core/sysbus: Add a function
 for creating and attaching an object
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
> A lot of functions are initializing an object and attach it immediately
> afterwards to the system bus. Provide a common function for this, which
> also uses object_initialize_child() to make sure that the reference
> counter is correctly initialized to 1 afterwards.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/core/sysbus.c    |  8 ++++++++
>  include/hw/sysbus.h | 17 +++++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index ecfb0cf..3c8e53b 100644
> --- a/hw/core/sysbus.c
> +++ b/hw/core/sysbus.c
> @@ -376,6 +376,14 @@ BusState *sysbus_get_default(void)
>      return main_system_bus;
>  }
>
> +void sysbus_init_child_obj(Object *parent, const char *childname, void *child,
> +                           size_t childsize, const char *childtype)
> +{
> +    object_initialize_child(parent, childname, child, childsize, childtype,
> +                            &error_abort, NULL);
> +    qdev_set_parent_bus(DEVICE(child), sysbus_get_default());
> +}
> +
>  static void sysbus_register_types(void)
>  {
>      type_register_static(&system_bus_info);
> diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
> index e88bb6d..0b59a3b 100644
> --- a/include/hw/sysbus.h
> +++ b/include/hw/sysbus.h
> @@ -96,6 +96,23 @@ void sysbus_add_io(SysBusDevice *dev, hwaddr addr,
>                     MemoryRegion *mem);
>  MemoryRegion *sysbus_address_space(SysBusDevice *dev);
>
> +/**
> + * sysbus_init_child_obj:
> + * @parent: The parent object
> + * @childname: Used as name of the "child<>" property in the parent
> + * @child: A pointer to the memory to be used for the object.
> + * @childsize: The maximum size available at @child for the object.
> + * @childtype: The name of the type of the object to instantiate.
> + *
> + * This function will initialize an object and attach it to the main system
> + * bus. The memory for the object should have already been allocated. The
> + * object will then be added as child to the given parent. The returned object
> + * has a reference count of 1 (for the "child<...>" property from the parent),
> + * so the object will be finalized automatically when the parent gets removed.
> + */
> +void sysbus_init_child_obj(Object *parent, const char *childname, void *child,
> +                           size_t childsize, const char *childtype);
> +
>  /* Call func for every dynamically created sysbus device in the system */
>  void foreach_dynamic_sysbus_device(FindSysbusDeviceFunc *func, void *opaque);
>
> --
> 1.8.3.1
>
>
