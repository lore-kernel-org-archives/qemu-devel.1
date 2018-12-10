Received: from eggs.gnu.org ([2001:4830:134:3::10]:34271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWOgb-0004i3-8o
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWOgW-0000gC-MP
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:45:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32775)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gWOgW-0000Zw-9p
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:45:32 -0500
Date: Mon, 10 Dec 2018 17:45:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181210174522.04b21215@Igors-MacBook-Pro.local>
In-Reply-To: <20181204142023.15982-8-marcandre.lureau@redhat.com>
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
	<20181204142023.15982-8-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v5 07/19] hw: apply accel compat
 properties without touching globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Andreas =?UTF-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>

On Tue,  4 Dec 2018 18:20:11 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Instead of registering compat properties as globals, let's keep them
> in their own array, to avoid mixing with user globals.
>=20
> Introduce object_apply_global_props() function, to apply compatibility
> properties from a GPtrArray.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/qdev-core.h | 10 ++++++++++
>  include/qom/object.h   |  3 +++
>  include/sysemu/accel.h |  4 +---
>  accel/accel.c          | 12 ------------
>  hw/core/qdev.c         |  9 +++++++++
>  hw/xen/xen-common.c    |  9 ++++++---
>  qom/object.c           | 25 +++++++++++++++++++++++++
>  vl.c                   |  1 -
>  8 files changed, 54 insertions(+), 19 deletions(-)
>=20
[...]
> diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> index 6ec14c73ca..4532aa8632 100644
> --- a/hw/xen/xen-common.c
> +++ b/hw/xen/xen-common.c
> @@ -174,18 +174,21 @@ static GlobalProperty xen_compat_props[] =3D {
>          .driver =3D "migration",
>          .property =3D "send-section-footer",
>          .value =3D "off",
> -    },
> -    { /* end of list */ },
> +    }
>  };
> =20
>  static void xen_accel_class_init(ObjectClass *oc, void *data)
>  {
>      AccelClass *ac =3D ACCEL_CLASS(oc);
> +
>      ac->name =3D "Xen";
>      ac->init_machine =3D xen_init;
>      ac->setup_post =3D xen_setup_post;
>      ac->allowed =3D &xen_allowed;
> -    ac->global_props =3D xen_compat_props;
> +    ac->compat_props =3D g_ptr_array_new();
where is matching free for that?

> +
> +    compat_props_add(ac->compat_props,
> +                     xen_compat_props, G_N_ELEMENTS(xen_compat_props));
>  }
> =20
>  #define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
> diff --git a/qom/object.c b/qom/object.c
> index 17921c0a71..dbdab0aead 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -370,6 +370,31 @@ static void object_post_init_with_type(Object *obj, =
TypeImpl *ti)
>      }
>  }
> =20
> +void object_apply_global_props(Object *obj, const GPtrArray *props, Erro=
r **errp)
> +{
> +    Error *err =3D NULL;
> +    int i;
> +
> +    if (!props) {
> +        return;
> +    }
> +
> +    for (i =3D 0; i < props->len; i++) {
> +        GlobalProperty *p =3D g_ptr_array_index(props, i);
> +
> +        if (object_dynamic_cast(obj, p->driver) =3D=3D NULL) {
> +            continue;
> +        }
> +        p->used =3D true;
> +        object_property_parse(obj, p->value, p->property, &err);
> +        if (err !=3D NULL) {
> +            error_prepend(&err, "can't apply global %s.%s=3D%s: ",
> +                          p->driver, p->property, p->value);
> +            error_propagate(errp, err);
> +        }
> +    }
> +}
> +
>  static void object_initialize_with_type(void *data, size_t size, TypeImp=
l *type)
>  {
>      Object *obj =3D data;
> diff --git a/vl.c b/vl.c
> index a5ae5f23d2..88ba658572 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2968,7 +2968,6 @@ static void user_register_global_props(void)
>   */
>  static void register_global_properties(MachineState *ms)
>  {
> -    accel_register_compat_props(ms->accelerator);
>      machine_register_compat_props(ms);
>      user_register_global_props();
>  }
