Received: from eggs.gnu.org ([209.51.188.92]:33387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gyc6i-0001Lw-CZ
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:45:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gyc6h-0000pX-Ak
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:45:12 -0500
MIME-Version: 1.0
References: <20190225183757.27378-1-armbru@redhat.com>
	<20190225183757.27378-3-armbru@redhat.com>
In-Reply-To: <20190225183757.27378-3-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 26 Feb 2019 13:44:38 +0100
Message-ID: <CAJ+F1CLGQyFet0_7dOTFEr7QbRWj5seyo4L6Yfi37W5pZtUq3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>

Hi

On Mon, Feb 25, 2019 at 7:46 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> See the previous commit for rationale.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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
> -    object_compat_props[1] =3D compat_props;
> -}
> -
> -/*
> - * Set accelerator's global property defaults to @compat_props.
> - * May be called at most once.
> - */
> -void object_set_accelerator_compat_props(GPtrArray *compat_props)
> -{
> -    assert(!object_compat_props[0]);
> -    object_compat_props[0] =3D compat_props;
> -}
> -
> -void object_apply_compat_props(Object *obj)
> -{
> -    int i;
> -
> -    for (i =3D 0; i < ARRAY_SIZE(object_compat_props); i++) {
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
>
>  /**
>   * object_set_props:
> diff --git a/qom/object.c b/qom/object.c
> index b8c732063b..adb9b7fe91 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -408,6 +408,45 @@ void object_apply_global_props(Object *obj, const GP=
trArray *props, Error **errp
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
> +    object_compat_props[1] =3D compat_props;
> +}
> +
> +/*
> + * Set accelerator's global property defaults to @compat_props.
> + * May be called at most once.
> + */
> +void object_set_accelerator_compat_props(GPtrArray *compat_props)
> +{
> +    assert(!object_compat_props[0]);
> +    object_compat_props[0] =3D compat_props;
> +}
> +
> +void object_apply_compat_props(Object *obj)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(object_compat_props); i++) {
> +        object_apply_global_props(obj, object_compat_props[i],
> +                                  &error_abort);
> +    }
> +}
> +
>  static void object_initialize_with_type(void *data, size_t size, TypeImp=
l *type)
>  {
>      Object *obj =3D data;
> --
> 2.17.2
>
>


--=20
Marc-Andr=C3=A9 Lureau
