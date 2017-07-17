Received: from eggs.gnu.org ([2001:4830:134:3::10]:33959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dX1QM-0001yz-7s
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dX1QH-0004M5-BX
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:30:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dX1QG-0004Ll-PX
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:30:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDEC14E4D9
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 08:30:31 +0000 (UTC)
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
	<1500279971-13875-2-git-send-email-peterx@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <9c2107c2-4d97-6c8f-a223-21170c540887@redhat.com>
Date: Mon, 17 Jul 2017 11:30:22 +0300
MIME-Version: 1.0
In-Reply-To: <1500279971-13875-2-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/11] qdev: provide DEFINE_PROP_INT64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 17/07/2017 11:26, Peter Xu wrote:
> We have merely all the stuff, but this one is missing. Add it in.
>=20
> Am going to use this new helper for MigrationParameters fields, since
> most of them are int64_t.
>=20
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> CC: Peter Xu <peterx@redhat.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/core/qdev-properties.c    | 32 ++++++++++++++++++++++++++++++++
>   include/hw/qdev-properties.h |  3 +++
>   2 files changed, 35 insertions(+)
>=20
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index dcecdf0..c1d4e54 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -404,6 +404,31 @@ static void set_uint64(Object *obj, Visitor *v, co=
nst char *name,
>       visit_type_uint64(v, name, ptr, errp);
>   }
>  =20
> +static void get_int64(Object *obj, Visitor *v, const char *name,
> +                      void *opaque, Error **errp)
> +{
> +    DeviceState *dev =3D DEVICE(obj);
> +    Property *prop =3D opaque;
> +    int64_t *ptr =3D qdev_get_prop_ptr(dev, prop);
> +
> +    visit_type_int64(v, name, ptr, errp);
> +}
> +
> +static void set_int64(Object *obj, Visitor *v, const char *name,
> +                      void *opaque, Error **errp)
> +{
> +    DeviceState *dev =3D DEVICE(obj);
> +    Property *prop =3D opaque;
> +    int64_t *ptr =3D qdev_get_prop_ptr(dev, prop);
> +
> +    if (dev->realized) {
> +        qdev_prop_set_after_realize(dev, name, errp);
> +        return;
> +    }
> +
> +    visit_type_int64(v, name, ptr, errp);
> +}
> +
>   const PropertyInfo qdev_prop_uint64 =3D {
>       .name  =3D "uint64",
>       .get   =3D get_uint64,
> @@ -411,6 +436,13 @@ const PropertyInfo qdev_prop_uint64 =3D {
>       .set_default_value =3D set_default_value_uint,
>   };
>  =20
> +const PropertyInfo qdev_prop_int64 =3D {
> +    .name  =3D "int64",
> +    .get   =3D get_int64,
> +    .set   =3D set_int64,
> +    .set_default_value =3D set_default_value_int,
> +};
> +
>   /* --- string --- */
>  =20
>   static void release_string(Object *obj, const char *name, void *opaqu=
e)
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.=
h
> index f6692d5..30af33b 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -13,6 +13,7 @@ extern const PropertyInfo qdev_prop_uint16;
>   extern const PropertyInfo qdev_prop_uint32;
>   extern const PropertyInfo qdev_prop_int32;
>   extern const PropertyInfo qdev_prop_uint64;
> +extern const PropertyInfo qdev_prop_int64;
>   extern const PropertyInfo qdev_prop_size;
>   extern const PropertyInfo qdev_prop_string;
>   extern const PropertyInfo qdev_prop_chr;
> @@ -136,6 +137,8 @@ extern const PropertyInfo qdev_prop_link;
>       DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int32, int32_t)
>   #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
>       DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
> +#define DEFINE_PROP_INT64(_n, _s, _f, _d)                      \
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int64, int64_t)
>   #define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
>       DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
>   #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
>=20


Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
