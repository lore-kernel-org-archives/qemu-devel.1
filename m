Received: from eggs.gnu.org ([2001:4830:134:3::10]:35432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqGwY-0004cd-Gi
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqGwX-0001SV-OQ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:59:58 -0400
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
	<1531470464-21522-2-git-send-email-thuth@redhat.com>
	<20180713225718.GP914@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4551aa70-343e-1362-cfd3-d567c476d6fe@redhat.com>
Date: Thu, 16 Aug 2018 13:59:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180713225718.GP914@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/16] qom/object: Add a new function
 object_initialize_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, Markus Armbruster <armbru@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 07/14/2018 12:57 AM, Eduardo Habkost wrote:
> On Fri, Jul 13, 2018 at 10:27:29AM +0200, Thomas Huth wrote:
>> A lot of code is using the object_initialize() function followed by a call
>> to object_property_add_child() to add the newly initialized object as a child
>> of the current object. Both functions increase the reference counter of the
>> new object, but many spots that call these two functions then forget to drop
>> one of the superfluous references. So the newly created object is often not
>> cleaned up correctly when the parent is destroyed. In the worst case, this
>> can cause crashes, e.g. because device objects are not correctly removed from
>> their parent_bus.
>>
>> Since this is a common pattern between many code spots, let's introdcue a
>> new function that takes care of calling all three required initialization
>> functions, first object_initialize(), then object_property_add_child() and
>> finally object_unref().
>>
>> And while we're at object.h, also fix some copy-n-paste errors in the
>> comments there ("to store the area" --> "to store the error").
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Potential candidates for using the new function, found using the
> following Coccinelle patch:
> 
> @@
> expression child, size, type, parent, errp, propname;
> @@
> -object_initialize(child, size, type);
> -object_property_add_child(
> +object_initialize_child(
>                            parent, propname, 
> -                          OBJECT(child),
> +                          child, size, type,
>                            errp);
> 
> Some of them (very few) already call object_unref() and need to
> be fixed manually.
> 
> Most of the remaining ~50 object_initialize() callers are also
> candidates, even if they don't call object_property_add_child()
> today.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Care to turn this into a proper patch, now that we left the freeze period?

> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index d4e4d98b59..acf7b4e40e 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2232,8 +2232,8 @@ void virtio_instance_init_common(Object *proxy_obj, void *data,
>  {
>      DeviceState *vdev = data;
>  
> -    object_initialize(vdev, vdev_size, vdev_name);
> -    object_property_add_child(proxy_obj, "virtio-backend", OBJECT(vdev), NULL);
> +    object_initialize_child(proxy_obj, "virtio-backend",  vdev, vdev_size,
> +                            vdev_name, NULL);
>      object_unref(OBJECT(vdev));
>      qdev_alias_all_properties(vdev, proxy_obj);
>  }
> diff --git a/qom/object.c b/qom/object.c
> index 7be7638db1..91ff795b38 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -396,8 +396,7 @@ void object_initialize_child(Object *parentobj, const char *propname,
>                               void *childobj, size_t size, const char *type,
>                               Error **errp)
>  {
> -    object_initialize(childobj, size, type);
> -    object_property_add_child(parentobj, propname, OBJECT(childobj), errp);
> +    object_initialize_child(parentobj, propname,  childobj, size, type, errp);
>      /*
>       * Since object_property_add_child added a reference to the child object,
>       * we can drop the reference added by object_initialize(), so the child

At least these two hunks need manual adjustment.

 Thomas
