Received: from eggs.gnu.org ([2001:4830:134:3::10]:60438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dVgcb-0006ej-UG
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dVgca-0006im-Dd
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:05:45 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dVgca-0006hN-1L
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:05:44 -0400
Received: by mail-lf0-x242.google.com with SMTP id g21so6129441lfk.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 09:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <1499842423-21101-1-git-send-email-peterx@redhat.com>
	<1499842423-21101-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1499842423-21101-2-git-send-email-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 13 Jul 2017 16:05:32 +0000
Message-ID: <CAJ+F1CK6xti_5utnP+kb0dTEoT6m4DRCiumX-jhdvJ5SnZPmJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] qdev: provide DEFINE_PROP_INT64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Hi

On Wed, Jul 12, 2017 at 8:55 AM Peter Xu <peterx@redhat.com> wrote:

> We have merely all the stuff, but this one is missing. Add it in.
>
> Am going to use this new helper for MigrationParameters fields, since
> most of them are int64_t.
>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> CC: Peter Xu <peterx@redhat.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/core/qdev-properties.c    | 32 ++++++++++++++++++++++++++++++++
>  include/hw/qdev-properties.h |  3 +++
>  2 files changed, 35 insertions(+)
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index f11d578..70e14df 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -403,6 +403,31 @@ static void set_uint64(Object *obj, Visitor *v, cons=
t
> char *name,
>      visit_type_uint64(v, name, ptr, errp);
>  }
>
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
>  PropertyInfo qdev_prop_uint64 =3D {
>      .name  =3D "uint64",
>      .get   =3D get_uint64,
> @@ -410,6 +435,13 @@ PropertyInfo qdev_prop_uint64 =3D {
>      .set_default_value =3D set_default_value_uint,
>  };
>
> +PropertyInfo qdev_prop_int64 =3D {
> +    .name  =3D "int64",
> +    .get   =3D get_int64,
> +    .set   =3D set_int64,
> +    .set_default_value =3D set_default_value_int,
> +};
> +
>  /* --- string --- */
>
>  static void release_string(Object *obj, const char *name, void *opaque)
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 0604c33..2939614 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -13,6 +13,7 @@ extern PropertyInfo qdev_prop_uint16;
>  extern PropertyInfo qdev_prop_uint32;
>  extern PropertyInfo qdev_prop_int32;
>  extern PropertyInfo qdev_prop_uint64;
> +extern PropertyInfo qdev_prop_int64;
>  extern PropertyInfo qdev_prop_size;
>  extern PropertyInfo qdev_prop_string;
>  extern PropertyInfo qdev_prop_chr;
> @@ -127,6 +128,8 @@ extern PropertyInfo qdev_prop_arraylen;
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int32, int32_t)
>  #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
>      DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
> +#define DEFINE_PROP_INT64(_n, _s, _f, _d)                      \
> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_int64, int64_t)
>


Make it SIGNED, with that:

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>




>  #define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
>      DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
>  #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
