Received: from eggs.gnu.org ([2001:4830:134:3::10]:47576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe5Ro-0005Ya-Ru
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 17:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe5Ro-0004Ur-1k
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 17:17:52 -0400
Date: Fri, 13 Jul 2018 18:17:40 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180713211740.GT31657@localhost.localdomain>
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
	<1531470464-21522-3-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531470464-21522-3-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/16] hw/core/sysbus: Add a function
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
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Fri, Jul 13, 2018 at 10:27:30AM +0200, Thomas Huth wrote:
> A lot of functions are initializing an object and attach it immediately
> afterwards to the system bus. Provide a common function for this, which
> also uses object_initialize_child() to make sure that the reference
> counter is correctly initialized to 1 afterwards.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/core/sysbus.c    | 8 ++++++++
>  include/hw/sysbus.h | 3 +++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index ecfb0cf..e2436ce 100644
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
> +                            &error_abort);
> +    qdev_set_parent_bus(DEVICE(child), sysbus_get_default());
> +}
> +
>  static void sysbus_register_types(void)
>  {
>      type_register_static(&system_bus_info);
> diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
> index e88bb6d..e405232 100644
> --- a/include/hw/sysbus.h
> +++ b/include/hw/sysbus.h
> @@ -96,6 +96,9 @@ void sysbus_add_io(SysBusDevice *dev, hwaddr addr,
>                     MemoryRegion *mem);
>  MemoryRegion *sysbus_address_space(SysBusDevice *dev);
>  
> +void sysbus_init_child_obj(Object *parent, const char *childname, void *child,
> +                           size_t childsize, const char *childtype);
> +

Documentation about the reference ownership rules would be nice,
but I don't think this should block the bug fixes.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
