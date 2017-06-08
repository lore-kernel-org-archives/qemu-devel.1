Received: from eggs.gnu.org ([2001:4830:134:3::10]:49302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJ0vN-0006TU-L1
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJ0vJ-0007OL-4m
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:08:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJ0vI-0007O5-SC
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:08:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D32AC303129
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 17:08:39 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
	<20170607163635.17635-18-marcandre.lureau@redhat.com>
Date: Thu, 08 Jun 2017 19:08:35 +0200
In-Reply-To: <20170607163635.17635-18-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 7 Jun 2017
	20:36:09 +0400")
Message-ID: <87wp8m1k6k.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 17/43] qdev: avoid type casts between
 signed and unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Modify the unsigned type for various properties to use QNUM_U64, to
> avoid type casts.
>
> There are a few empty lines added to improve code reading/style.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/qdev-core.h       |  1 +
>  include/hw/qdev-properties.h | 29 ++++++++++++++++++++---------
>  hw/core/qdev-properties.c    | 23 ++++++++++++++---------
>  3 files changed, 35 insertions(+), 18 deletions(-)
>
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 784971b8d8..9d7c1c0e9b 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -228,6 +228,7 @@ struct Property {
>      uint8_t      bitnr;
>      union {
>          int64_t i;
> +        uint64_t u;
>      } defval;
>      int          arrayoffset;
>      PropertyInfo *arrayinfo;
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 34524d0bfe..1e5c928f32 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -37,6 +37,7 @@ extern PropertyInfo qdev_prop_arraylen;
>          .offset    =3D offsetof(_state, _field)                    \
>              + type_check(_type, typeof_field(_state, _field)),   \
>          }
> +
>  #define DEFINE_PROP_SIGNED(_name, _state, _field, _defval, _prop, _type)=
 { \
>          .name      =3D (_name),                                         =
  \
>          .info      =3D &(_prop),                                        =
  \
> @@ -44,21 +45,31 @@ extern PropertyInfo qdev_prop_arraylen;
>              + type_check(_type,typeof_field(_state, _field)),           \
>          .defval.i  =3D (_type)_defval,                                  =
  \
>          }
> +
>  #define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval) {  \
>          .name      =3D (_name),                                    \
>          .info      =3D &(qdev_prop_bit),                           \
>          .bitnr    =3D (_bit),                                      \
>          .offset    =3D offsetof(_state, _field)                    \
>              + type_check(uint32_t,typeof_field(_state, _field)), \
> -        .defval.i  =3D (bool)_defval,                              \
> +        .defval.u  =3D (bool)_defval,                              \
> +        }
> +
> +#define DEFINE_PROP_UNSIGNED(_name, _state, _field, _defval, _prop, _typ=
e) { \
> +        .name      =3D (_name),                                         =
  \
> +        .info      =3D &(_prop),                                        =
  \
> +        .offset    =3D offsetof(_state, _field)                         =
  \
> +            + type_check(_type, typeof_field(_state, _field)),          \
> +        .defval.u  =3D (_type)_defval,                                  =
  \
>          }
> +
>  #define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval) {       \
>          .name      =3D (_name),                                         =
  \
>          .info      =3D &(qdev_prop_bit64),                              =
  \
>          .bitnr    =3D (_bit),                                           =
  \
>          .offset    =3D offsetof(_state, _field)                         =
  \
>              + type_check(uint64_t, typeof_field(_state, _field)),       \
> -        .defval.i  =3D (bool)_defval,                                   =
  \
> +        .defval.u  =3D (bool)_defval,                                   =
  \
>          }
>=20=20
>  #define DEFINE_PROP_BOOL(_name, _state, _field, _defval) {       \
> @@ -66,7 +77,7 @@ extern PropertyInfo qdev_prop_arraylen;
>          .info      =3D &(qdev_prop_bool),                          \
>          .offset    =3D offsetof(_state, _field)                    \
>              + type_check(bool, typeof_field(_state, _field)),    \
> -        .defval.i  =3D (bool)_defval,                              \
> +        .defval.u    =3D (bool)_defval,                            \

Whitespace is off.

>          }
>=20=20
>  #define PROP_ARRAY_LEN_PREFIX "len-"
> @@ -107,17 +118,17 @@ extern PropertyInfo qdev_prop_arraylen;
>          }
>=20=20
>  #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
> -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
>  #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
> -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_uint16, uint16_t)
> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint16, uint16_t)
>  #define DEFINE_PROP_UINT32(_n, _s, _f, _d)                      \
> -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_uint32, uint32_t)
> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint32, uint32_t)
>  #define DEFINE_PROP_INT32(_n, _s, _f, _d)                      \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int32, int32_t)
>  #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
> -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
>  #define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
> -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
>  #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
>=20=20
> @@ -163,7 +174,7 @@ extern PropertyInfo qdev_prop_arraylen;
>  #define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
>  #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
> -    DEFINE_PROP_SIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
>  #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAdd=
ress)
>=20=20
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index f3f682c611..a8f09c13e2 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -71,7 +71,7 @@ static void set_enum(Object *obj, Visitor *v, const cha=
r *name, void *opaque,
>=20=20
>  static void set_default_value_enum(Object *obj, const Property *prop)
>  {
> -    object_property_set_str(obj, prop->info->enum_table[prop->defval.i],
> +    object_property_set_str(obj, prop->info->enum_table[prop->defval.u],
>                              prop->name, &error_abort);
>  }

You use DEFINE_PROP_SIGNED() for enums.  Shouldn't we stick to defval.i?

>=20=20
> @@ -128,7 +128,7 @@ static void prop_set_bit(Object *obj, Visitor *v, con=
st char *name,
>=20=20
>  static void set_default_value_bool(Object *obj, const Property *prop)
>  {
> -    object_property_set_bool(obj, prop->defval.i, prop->name, &error_abo=
rt);
> +    object_property_set_bool(obj, prop->defval.u, prop->name, &error_abo=
rt);
>  }
>=20=20
>  PropertyInfo qdev_prop_bit =3D {
> @@ -264,11 +264,16 @@ static void set_default_value_int(Object *obj, cons=
t Property *prop)
>      object_property_set_int(obj, prop->defval.i, prop->name, &error_abor=
t);
>  }
>=20=20
> +static void set_default_value_uint(Object *obj, const Property *prop)
> +{
> +    object_property_set_uint(obj, prop->defval.u, prop->name, &error_abo=
rt);
> +}
> +
>  PropertyInfo qdev_prop_uint8 =3D {
>      .name  =3D "uint8",
>      .get   =3D get_uint8,
>      .set   =3D set_uint8,
> -    .set_default_value =3D set_default_value_int,
> +    .set_default_value =3D set_default_value_uint,
>  };
>=20=20
>  /* --- 16bit integer --- */
> @@ -302,7 +307,7 @@ PropertyInfo qdev_prop_uint16 =3D {
>      .name  =3D "uint16",
>      .get   =3D get_uint16,
>      .set   =3D set_uint16,
> -    .set_default_value =3D set_default_value_int,
> +    .set_default_value =3D set_default_value_uint,
>  };
>=20=20
>  /* --- 32bit integer --- */
> @@ -361,7 +366,7 @@ PropertyInfo qdev_prop_uint32 =3D {
>      .name  =3D "uint32",
>      .get   =3D get_uint32,
>      .set   =3D set_uint32,
> -    .set_default_value =3D set_default_value_int,
> +    .set_default_value =3D set_default_value_uint,
>  };
>=20=20
>  PropertyInfo qdev_prop_int32 =3D {
> @@ -402,7 +407,7 @@ PropertyInfo qdev_prop_uint64 =3D {
>      .name  =3D "uint64",
>      .get   =3D get_uint64,
>      .set   =3D set_uint64,
> -    .set_default_value =3D set_default_value_int,
> +    .set_default_value =3D set_default_value_uint,
>  };
>=20=20
>  /* --- string --- */
> @@ -725,7 +730,7 @@ PropertyInfo qdev_prop_blocksize =3D {
>      .description =3D "A power of two between 512 and 32768",
>      .get   =3D get_uint16,
>      .set   =3D set_blocksize,
> -    .set_default_value =3D set_default_value_int,
> +    .set_default_value =3D set_default_value_uint,
>  };
>=20=20
>  /* --- pci host address --- */
> @@ -948,7 +953,7 @@ PropertyInfo qdev_prop_arraylen =3D {
>      .name =3D "uint32",
>      .get =3D get_uint32,
>      .set =3D set_prop_arraylen,
> -    .set_default_value =3D set_default_value_int,
> +    .set_default_value =3D set_default_value_uint,
>  };
>=20=20
>  /* --- public helpers --- */
> @@ -1185,5 +1190,5 @@ PropertyInfo qdev_prop_size =3D {
>      .name  =3D "size",
>      .get =3D get_size,
>      .set =3D set_size,
> -    .set_default_value =3D set_default_value_int,
> +    .set_default_value =3D set_default_value_uint,
>  };
