Received: from eggs.gnu.org ([2001:4830:134:3::10]:49080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkqqo-0003st-TG
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkqqj-0001b4-BD
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:03:06 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:37868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dkqqj-0001aK-5G
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:03:01 -0400
Received: by mail-ua0-x243.google.com with SMTP id j17so988596uae.4
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 05:03:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503564371-26090-15-git-send-email-armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
	<1503564371-26090-15-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 24 Aug 2017 14:02:59 +0200
Message-ID: <CAJ+F1C+XOVKBgGY0hm7h=gOvt+Laa4dGX5pegWrhDG7xYd1P_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 14/16] qapi: Convert indirect uses of
 FOO_lookup[...] to qapi_enum_lookup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Thu, Aug 24, 2017 at 10:46 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/core/qdev-properties.c | 7 +++++--
>  qapi/qapi-visit-core.c    | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 078fc5d..7512bd4 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -72,7 +72,9 @@ static void set_enum(Object *obj, Visitor *v, const cha=
r *name, void *opaque,
>
>  static void set_default_value_enum(Object *obj, const Property *prop)
>  {
> -    object_property_set_str(obj, prop->info->enum_table[prop->defval.i],
> +    object_property_set_str(obj,
> +                            qapi_enum_lookup(prop->info->enum_table,
> +                                             prop->defval.i),
>                              prop->name, &error_abort);
>  }
>
> @@ -1095,7 +1097,8 @@ void qdev_prop_set_enum(DeviceState *dev, const cha=
r *name, int value)
>      Property *prop;
>
>      prop =3D qdev_prop_find(dev, name);
> -    object_property_set_str(OBJECT(dev), prop->info->enum_table[value],
> +    object_property_set_str(OBJECT(dev),
> +                            qapi_enum_lookup(prop->info->enum_table, val=
ue),
>                              name, &error_abort);
>  }
>
> diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
> index f285879..30dc85b 100644
> --- a/qapi/qapi-visit-core.c
> +++ b/qapi/qapi-visit-core.c
> @@ -345,7 +345,7 @@ static void output_type_enum(Visitor *v, const char *=
name, int *obj,
>          return;
>      }
>
> -    enum_str =3D (char *)strings[value];
> +    enum_str =3D (char *)qapi_enum_lookup(strings, value);
>      visit_type_str(v, name, &enum_str, errp);
>  }
>
> --
> 2.7.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
