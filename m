Received: from eggs.gnu.org ([2001:4830:134:3::10]:39988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dUykn-0002Ox-SC
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dUykj-0002hw-Qu
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:15:17 -0400
Date: Tue, 11 Jul 2017 13:15:08 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1158652012.49603326.1499793308542.JavaMail.zimbra@redhat.com>
In-Reply-To: <1499788408-10096-3-git-send-email-peter.maydell@linaro.org>
References: <1499788408-10096-1-git-send-email-peter.maydell@linaro.org>
	<1499788408-10096-3-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] qdev: support properties which don't
 set a default value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Markus Armbruster <armbru@redhat.com>

Hi

----- Original Message -----
> In some situations it's useful to have a qdev property which doesn't
> automatically set its default value when qdev_property_add_static is
> called (for instance when the default value is not constant).
>=20
> Support this by adding a flag to the Property struct indicating
> whether to set the default value.  This replaces the existing test
> for whether the PorpertyInfo set_default_value function pointer is
> NULL, and we set the .set_default field to true for all those cases
> of struct Property which use a PropertyInfo with a non-NULL
> set_default_value, so behaviour remains the same as before.
>=20
> We define two new macros DEFINE_PROP_SIGNED_NODEFAULT and
> DEFINE_PROP_UNSIGNED_NODEFAULT, to cover the most plausible use cases
> of wanting to set an integer property with no default value.
>=20
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

minor comment below

> ---
> Since the previous patch fixed the only case that was
> using a default value but not explicitly setting .defval.[ui],
> this patch is a bit easier to review: .set_default =3D true
> is added in exactly the places that initialize .defval.[ui].
> ---
>  include/hw/qdev-core.h       |  1 +
>  include/hw/qdev-properties.h | 20 ++++++++++++++++++++
>  hw/core/qdev.c               |  2 +-
>  3 files changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 9d7c1c0..d110163 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -226,6 +226,7 @@ struct Property {
>      PropertyInfo *info;
>      ptrdiff_t    offset;
>      uint8_t      bitnr;
> +    bool         set_default;
>      union {
>          int64_t i;
>          uint64_t u;
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 36d040c..66816a5 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -43,15 +43,24 @@ extern PropertyInfo qdev_prop_arraylen;
>          .info      =3D &(_prop),                                        =
  \
>          .offset    =3D offsetof(_state, _field)                         =
  \
>              + type_check(_type,typeof_field(_state, _field)),           =
\
> +        .set_default =3D true,                                          =
  \
>          .defval.i  =3D (_type)_defval,                                  =
  \
>          }
> =20
> +#define DEFINE_PROP_SIGNED_NODEFAULT(_name, _state, _field, _prop, _type=
) {
> \
> +        .name      =3D (_name),                                         =
  \
> +        .info      =3D &(_prop),                                        =
  \
> +        .offset    =3D offsetof(_state, _field)                         =
  \
> +            + type_check(_type, typeof_field(_state, _field)),          =
\
> +        }
> +
>  #define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval) {  \
>          .name      =3D (_name),                                    \
>          .info      =3D &(qdev_prop_bit),                           \
>          .bitnr    =3D (_bit),                                      \
>          .offset    =3D offsetof(_state, _field)                    \
>              + type_check(uint32_t,typeof_field(_state, _field)), \
> +        .set_default =3D true,                                     \
>          .defval.u  =3D (bool)_defval,                              \
>          }
> =20
> @@ -60,15 +69,24 @@ extern PropertyInfo qdev_prop_arraylen;
>          .info      =3D &(_prop),                                        =
  \
>          .offset    =3D offsetof(_state, _field)                         =
  \
>              + type_check(_type, typeof_field(_state, _field)),          =
\
> +        .set_default =3D true,                                          =
  \
>          .defval.u  =3D (_type)_defval,                                  =
  \
>          }
> =20
> +#define DEFINE_PROP_UNSIGNED_NODEFAULT(_name, _state, _field, _prop, _ty=
pe)
> { \
> +        .name      =3D (_name),                                         =
  \
> +        .info      =3D &(_prop),                                        =
  \
> +        .offset    =3D offsetof(_state, _field)                         =
  \
> +            + type_check(_type, typeof_field(_state, _field)),          =
\
> +        }
> +
>  #define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval) {       =
\
>          .name      =3D (_name),                                         =
  \
>          .info      =3D &(qdev_prop_bit64),                              =
  \
>          .bitnr    =3D (_bit),                                           =
  \
>          .offset    =3D offsetof(_state, _field)                         =
  \
>              + type_check(uint64_t, typeof_field(_state, _field)),       =
\
> +        .set_default =3D true,                                          =
  \
>          .defval.u  =3D (bool)_defval,                                   =
  \
>          }
> =20
> @@ -77,6 +95,7 @@ extern PropertyInfo qdev_prop_arraylen;
>          .info      =3D &(qdev_prop_bool),                          \
>          .offset    =3D offsetof(_state, _field)                    \
>              + type_check(bool, typeof_field(_state, _field)),    \
> +        .set_default =3D true,                                     \
>          .defval.u    =3D (bool)_defval,                            \
>          }
> =20
> @@ -110,6 +129,7 @@ extern PropertyInfo qdev_prop_arraylen;
>                            _arrayfield, _arrayprop, _arraytype) {        =
\
>          .name =3D (PROP_ARRAY_LEN_PREFIX _name),                        =
  \
>          .info =3D &(qdev_prop_arraylen),                                =
  \
> +        .set_default =3D true,                                          =
  \
>          .defval.u =3D 0,                                                =
  \
>          .offset =3D offsetof(_state, _field)                            =
  \
>              + type_check(uint32_t, typeof_field(_state, _field)),       =
\
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 849952a..96965a7 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -793,7 +793,7 @@ void qdev_property_add_static(DeviceState *dev, Prope=
rty
> *prop,
>                                      prop->info->description,
>                                      &error_abort);
> =20
> -    if (prop->info->set_default_value) {
> +    if (prop->set_default) {

Not sure if it's worth to have an assert(prop->info->set_default_value), pr=
obably not necessary.

>          prop->info->set_default_value(obj, prop);
>      }
>  }
> --
> 2.7.4
>=20
>=20
