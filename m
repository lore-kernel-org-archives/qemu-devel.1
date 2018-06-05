Received: from eggs.gnu.org ([2001:4830:134:3::10]:33624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQ8Hn-0002uS-A3
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQ8Hk-00025C-0d
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:29:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57716 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQ8Hj-00023f-QF
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:29:47 -0400
Date: Tue, 5 Jun 2018 10:29:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180605092937.GK32286@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180605091508.14129-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180605091508.14129-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qdev: Use "string" for QOM string
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On Tue, Jun 05, 2018 at 07:15:08PM +1000, Alexey Kardashevskiy wrote:
> For QOM properties QEMU uses "string", for example:
> 
> {"execute": "qom-list", "arguments": {"path": "/machine"}}
> [{'return': [{'type': 'string', 'name': 'append'},  {'type': 'string', 'name': 'kernel'}]
> 
> However for the device properties copied from DEVICE_CLASS(class)->props,
> "str" is used for a type (vnet0 is "-device virtio-net-pci,id=vnet0"):
> 
> {"execute": "qom-list", "arguments": {"path": "/machine/peripheral/vnet0"}}
> ret=[{'return': [{'name': 'tx', 'type': 'str'}]
> 
> This changes string type when adding them to QOM property list so
> we get one string type in QMP.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> Not a huge improvement and might actually break something but since
> I got that far I decided to post this anyway :)
> 
> The alternatives are: 1) do nothing 2) do this:
> 
>  const PropertyInfo qdev_prop_string = {
> -    .name  = "str",
> +    .name  = "string",
>      .release = release_string,
>      .get   = get_string,
>      .set   = set_string,
>  };

As further points of reference:

 - object_property_add_str & object_class_property_add_str
   both use "string".
   
 - QAPI schema uses "str"

So the inconsistency is even bigger than just qdev. I'm inclined
to say "QAPI schema" is the canonical source of truth, and so
every use of "string" should change to "str".

CC'd Markus for 2nd opinion.

> 
> 
> ---
>  hw/core/qdev.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index f6f9247..2895693 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -687,7 +687,7 @@ static void qdev_property_add_legacy(DeviceState *dev, Property *prop,
>      }
>  
>      name = g_strdup_printf("legacy-%s", prop->name);
> -    object_property_add(OBJECT(dev), name, "str",
> +    object_property_add(OBJECT(dev), name, "string",
>                          prop->info->print ? qdev_get_legacy_property : prop->info->get,
>                          NULL,
>                          NULL,
> @@ -711,6 +711,7 @@ void qdev_property_add_static(DeviceState *dev, Property *prop,
>  {
>      Error *local_err = NULL;
>      Object *obj = OBJECT(dev);
> +    const char *proptype;
>  
>      if (prop->info->create) {
>          prop->info->create(obj, prop, &local_err);
> @@ -723,7 +724,11 @@ void qdev_property_add_static(DeviceState *dev, Property *prop,
>          if (!prop->info->get && !prop->info->set) {
>              return;
>          }
> -        object_property_add(obj, prop->name, prop->info->name,
> +        proptype = prop->info->name;
> +        if (0 == strncmp(proptype, "str", 3)) {
> +            proptype = "string";
> +        }
> +        object_property_add(obj, prop->name, proptype,
>                              prop->info->get, prop->info->set,
>                              prop->info->release,
>                              prop, &local_err);
> -- 
> 2.11.0
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
