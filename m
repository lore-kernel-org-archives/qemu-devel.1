Received: from eggs.gnu.org ([209.51.188.92]:39491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0pxq-0007TL-EF
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:57:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0pxp-0006Xe-CK
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:57:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0pxp-0006WD-4C
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:57:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id z84so5198760wmg.4
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 07:57:13 -0800 (PST)
References: <20190225183757.27378-1-armbru@redhat.com>
	<20190225183757.27378-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <47968abb-fc4e-4546-3cb5-339da5f7a268@redhat.com>
Date: Mon, 4 Mar 2019 16:57:10 +0100
MIME-Version: 1.0
In-Reply-To: <20190225183757.27378-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 2/6] qom: Move compat_props machinery
 from qdev to QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On 2/25/19 7:37 PM, Markus Armbruster wrote:
> See the previous commit for rationale.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/core/qdev.c         | 39 ---------------------------------------
>  include/hw/qdev-core.h |  4 ----
>  include/qom/object.h   |  3 +++
>  qom/object.c           | 39 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 42 insertions(+), 43 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 1a86c7990a..25dffad3ed 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -970,45 +970,6 @@ static void device_initfn(Object *obj)
>      QLIST_INIT(&dev->gpios);
>  }
>  
> -/*
> - * Global property defaults
> - * Slot 0: accelerator's global property defaults
> - * Slot 1: machine's global property defaults
> - * Each is a GPtrArray of of GlobalProperty.
> - * Applied in order, later entries override earlier ones.
> - */
> -static GPtrArray *object_compat_props[2];
> -
> -/*
> - * Set machine's global property defaults to @compat_props.
> - * May be called at most once.
> - */
> -void object_set_machine_compat_props(GPtrArray *compat_props)
> -{
> -    assert(!object_compat_props[1]);
> -    object_compat_props[1] = compat_props;
> -}
> -
> -/*
> - * Set accelerator's global property defaults to @compat_props.
> - * May be called at most once.
> - */
> -void object_set_accelerator_compat_props(GPtrArray *compat_props)
> -{
> -    assert(!object_compat_props[0]);
> -    object_compat_props[0] = compat_props;
> -}
> -
> -void object_apply_compat_props(Object *obj)
> -{
> -    int i;
> -
> -    for (i = 0; i < ARRAY_SIZE(object_compat_props); i++) {
> -        object_apply_global_props(obj, object_compat_props[i],
> -                                  &error_abort);
> -    }
> -}
> -
>  static void device_post_init(Object *obj)
>  {
>      /*
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index bced1f2666..f2f0006234 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -418,10 +418,6 @@ const char *qdev_fw_name(DeviceState *dev);
>  
>  Object *qdev_get_machine(void);
>  
> -void object_set_machine_compat_props(GPtrArray *compat_props);
> -void object_set_accelerator_compat_props(GPtrArray *compat_props);
> -void object_apply_compat_props(Object *obj);
> -
>  /* FIXME: make this a link<> */
>  void qdev_set_parent_bus(DeviceState *dev, BusState *bus);
>  
> diff --git a/include/qom/object.h b/include/qom/object.h
> index e0262962b5..288cdddf44 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -677,6 +677,9 @@ Object *object_new_with_propv(const char *typename,
>  
>  void object_apply_global_props(Object *obj, const GPtrArray *props,
>                                 Error **errp);
> +void object_set_machine_compat_props(GPtrArray *compat_props);
> +void object_set_accelerator_compat_props(GPtrArray *compat_props);
> +void object_apply_compat_props(Object *obj);

Documentation comments are in .c, OK :(

>  
>  /**
>   * object_set_props:
> diff --git a/qom/object.c b/qom/object.c
> index b8c732063b..adb9b7fe91 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -408,6 +408,45 @@ void object_apply_global_props(Object *obj, const GPtrArray *props, Error **errp
>      }
>  }
>  
> +/*
> + * Global property defaults
> + * Slot 0: accelerator's global property defaults
> + * Slot 1: machine's global property defaults
> + * Each is a GPtrArray of of GlobalProperty.
> + * Applied in order, later entries override earlier ones.
> + */
> +static GPtrArray *object_compat_props[2];
> +
> +/*
> + * Set machine's global property defaults to @compat_props.
> + * May be called at most once.
> + */
> +void object_set_machine_compat_props(GPtrArray *compat_props)
> +{
> +    assert(!object_compat_props[1]);
> +    object_compat_props[1] = compat_props;
> +}
> +
> +/*
> + * Set accelerator's global property defaults to @compat_props.
> + * May be called at most once.
> + */
> +void object_set_accelerator_compat_props(GPtrArray *compat_props)
> +{
> +    assert(!object_compat_props[0]);
> +    object_compat_props[0] = compat_props;
> +}
> +

Can you add a comment for this one too? (no need to respin)

> +void object_apply_compat_props(Object *obj)
> +{
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(object_compat_props); i++) {
> +        object_apply_global_props(obj, object_compat_props[i],
> +                                  &error_abort);
> +    }
> +}
> +
>  static void object_initialize_with_type(void *data, size_t size, TypeImpl *type)
>  {
>      Object *obj = data;
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
