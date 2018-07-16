Received: from eggs.gnu.org ([2001:4830:134:3::10]:40853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff0pj-0004AQ-Vb
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff0pg-0002O0-0I
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:34:24 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:43204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1ff0pf-0002NI-O0
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:34:19 -0400
Received: by mail-wr1-x432.google.com with SMTP id b15-v6so31382232wrv.10
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 03:34:19 -0700 (PDT)
References: <20180712194522.31063-1-ehabkost@redhat.com>
	<20180712194522.31063-3-ehabkost@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <8e3153c8-fae1-56d3-0070-4a311442aa80@gmail.com>
Date: Mon, 16 Jul 2018 13:34:16 +0300
MIME-Version: 1.0
In-Reply-To: <20180712194522.31063-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC 2/3] qdev: Document ownership rules of
 qbus_create*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>



On 07/12/2018 10:45 PM, Eduardo Habkost wrote:
> The ownership rules of those functions aren't trivial: the caller
> owns the new object if parent is NULL, otherwise ownership is
> transferred to the parent.  Clarify that on comments.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   include/hw/qdev-core.h | 24 ++++++++++++++++++++++++
>   hw/core/bus.c          |  5 +++++
>   2 files changed, 29 insertions(+)
>
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index f1fd0f8736..27d1ac3781 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -343,8 +343,32 @@ DeviceState *qdev_find_recursive(BusState *bus, const char *id);
>   typedef int (qbus_walkerfn)(BusState *bus, void *opaque);
>   typedef int (qdev_walkerfn)(DeviceState *dev, void *opaque);
>   
> +/**
> + * qbus_create_inplace:
> + * @bus: A pointer to the memory to be used for the bus object.
> + * @size: The maximum size available at @bus for the bus object.
> + * @typename: The name of the type of bus to instantiate.
> + * @parent: parent device
> + * @name: name for the new bus
> + *
> + * Creates bus in place.
> + *
> + * If @parent is not NULL the bus will be owned by @parent, otherwise
> + * the bus will be owned by the caller.
> + */
>   void qbus_create_inplace(void *bus, size_t size, const char *typename,
>                            DeviceState *parent, const char *name);
> +/**
> + * qbus_create:
> + * @typename: The name of the type of bus to instantiate.
> + * @parent: parent device
> + * @name: name for the new bus
> + *
> + * Creates bus object.
> + *
> + * If @parent is not NULL the returned object will be owned by @parent,
> + * otherwise it will be owned by the caller.
> + */
>   BusState *qbus_create(const char *typename, DeviceState *parent, const char *name);
>   /* Returns > 0 if either devfn or busfn skip walk somewhere in cursion,
>    *         < 0 if either devfn or busfn terminate walk somewhere in cursion,
> diff --git a/hw/core/bus.c b/hw/core/bus.c
> index 4651f24486..68a0d5b085 100644
> --- a/hw/core/bus.c
> +++ b/hw/core/bus.c
> @@ -74,6 +74,7 @@ int qbus_walk_children(BusState *bus,
>       return 0;
>   }
>   
> +/* If @parent is not NULL, ownership of @bus is transferred to @parent */
>   static void qbus_realize(BusState *bus, DeviceState *parent, const char *name)
>   {
>       const char *typename = object_get_typename(OBJECT(bus));
> @@ -102,6 +103,10 @@ static void qbus_realize(BusState *bus, DeviceState *parent, const char *name)
>           QLIST_INSERT_HEAD(&bus->parent->child_bus, bus, sibling);
>           bus->parent->num_child_bus++;
>           object_property_add_child(OBJECT(bus->parent), bus->name, OBJECT(bus), NULL);
> +        /*
> +         * object_property_add_child() takes a new reference, drop the
> +         * reference that was transferred to us.
> +         */
>           object_unref(OBJECT(bus));
>       } else if (bus != sysbus_get_default()) {
>           /* TODO: once all bus devices are qdevified,

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
