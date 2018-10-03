Received: from eggs.gnu.org ([2001:4830:134:3::10]:39917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7gke-00044w-Cl
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 08:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7gkb-0007j8-6A
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 08:59:40 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:55900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7gka-0007iw-WA
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 08:59:37 -0400
Received: by mail-wm1-f54.google.com with SMTP id 206-v6so5636150wmb.5
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 05:59:36 -0700 (PDT)
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<20180907075948.26917-7-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ec937f8d-a243-98b5-e95e-5c23a07894a4@redhat.com>
Date: Wed, 3 Oct 2018 14:59:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180907075948.26917-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 06/12] qom/object: register 'type'
 property as class property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 07/09/2018 09:59, Marc-André Lureau wrote:
> Let's save a few byte in each object instance.
> 
> (Is this property really used anywhere? Only qom-get could read it)

Well, it's not really used but it's part of the external API.

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  qom/object.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index d8666de3f2..185d1dd9f8 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -2423,9 +2423,10 @@ void object_class_property_set_description(ObjectClass *klass,
>      op->description = g_strdup(description);
>  }
>  
> -static void object_instance_init(Object *obj)
> +static void object_class_init(ObjectClass *klass, void *data)
>  {
> -    object_property_add_str(obj, "type", qdev_get_type, NULL, NULL);
> +    object_class_property_add_str(klass, "type", qdev_get_type,
> +                                  NULL, &error_abort);
>  }
>  
>  static void register_types(void)
> @@ -2439,7 +2440,7 @@ static void register_types(void)
>      static TypeInfo object_info = {
>          .name = TYPE_OBJECT,
>          .instance_size = sizeof(Object),
> -        .instance_init = object_instance_init,
> +        .class_init = object_class_init,
>          .abstract = true,
>      };
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
