Received: from eggs.gnu.org ([2001:4830:134:3::10]:34304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGO97-0004Uh-FK
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGO94-0000nS-7T
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:20:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dGO93-0000mX-Vy
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:20:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCECFC04B930
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 11:20:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-6-marcandre.lureau@redhat.com>
Date: Thu, 01 Jun 2017 13:19:56 +0200
In-Reply-To: <20170531135709.345-6-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 31 May 2017 17:56:29 +0400")
Message-ID: <878tlct0o3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/45] qdev: remove PropertyInfo.qtype
 field
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

> Remove dependency on qapi qtype, replace a field by a few PropertyInfo
> callbacks to set the default value type (introduced in commit 4f2d3d7).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/qdev-core.h       |  2 +-
>  include/hw/qdev-properties.h |  5 -----
>  hw/core/qdev-properties.c    | 35 ++++++++++++++++++++++++++++++++++-
>  hw/core/qdev.c               | 13 ++-----------
>  4 files changed, 37 insertions(+), 18 deletions(-)
>
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index e69489ec6c..9523339762 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -226,7 +226,6 @@ struct Property {
>      PropertyInfo *info;
>      ptrdiff_t    offset;
>      uint8_t      bitnr;
> -    QType        qtype;
>      int64_t      defval;
>      int          arrayoffset;
>      PropertyInfo *arrayinfo;
> @@ -238,6 +237,7 @@ struct PropertyInfo {
>      const char *description;
>      const char * const *enum_table;
>      int (*print)(DeviceState *dev, Property *prop, char *dest, size_t le=
n);
> +    void (*set_default_value)(Object *obj, const Property *prop);
>      ObjectPropertyAccessor *get;
>      ObjectPropertyAccessor *set;
>      ObjectPropertyRelease *release;
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index d206fc93dd..85e68998a9 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -42,7 +42,6 @@ extern PropertyInfo qdev_prop_arraylen;
>          .info      =3D &(_prop),                                        =
  \
>          .offset    =3D offsetof(_state, _field)                         =
  \
>              + type_check(_type,typeof_field(_state, _field)),           \
> -        .qtype     =3D QTYPE_QINT,                                      =
  \
>          .defval    =3D (_type)_defval,                                  =
  \
>          }
>  #define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval) {  \
> @@ -51,7 +50,6 @@ extern PropertyInfo qdev_prop_arraylen;
>          .bitnr    =3D (_bit),                                      \
>          .offset    =3D offsetof(_state, _field)                    \
>              + type_check(uint32_t,typeof_field(_state, _field)), \
> -        .qtype     =3D QTYPE_QBOOL,                                \
>          .defval    =3D (bool)_defval,                              \
>          }
>  #define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval) {       \
> @@ -60,7 +58,6 @@ extern PropertyInfo qdev_prop_arraylen;
>          .bitnr    =3D (_bit),                                           =
  \
>          .offset    =3D offsetof(_state, _field)                         =
  \
>              + type_check(uint64_t, typeof_field(_state, _field)),       \
> -        .qtype     =3D QTYPE_QBOOL,                                     =
  \
>          .defval    =3D (bool)_defval,                                   =
  \
>          }
>=20=20
> @@ -69,7 +66,6 @@ extern PropertyInfo qdev_prop_arraylen;
>          .info      =3D &(qdev_prop_bool),                          \
>          .offset    =3D offsetof(_state, _field)                    \
>              + type_check(bool, typeof_field(_state, _field)),    \
> -        .qtype     =3D QTYPE_QBOOL,                                \
>          .defval    =3D (bool)_defval,                              \
>          }
>=20=20
> @@ -105,7 +101,6 @@ extern PropertyInfo qdev_prop_arraylen;
>          .info =3D &(qdev_prop_arraylen),                                =
  \
>          .offset =3D offsetof(_state, _field)                            =
  \
>              + type_check(uint32_t, typeof_field(_state, _field)),       \
> -        .qtype =3D QTYPE_QINT,                                          =
  \
>          .arrayinfo =3D &(_arrayprop),                                   =
  \
>          .arrayfieldsize =3D sizeof(_arraytype),                         =
  \
>          .arrayoffset =3D offsetof(_state, _arrayfield),                 =
  \
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index fa3617db2d..482efb2683 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -69,6 +69,12 @@ static void set_enum(Object *obj, Visitor *v, const ch=
ar *name, void *opaque,
>      visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
>  }
>=20=20
> +static void set_default_value_enum(Object *obj, const Property *prop)
> +{
> +    object_property_set_str(obj, prop->info->enum_table[prop->defval],
> +                            prop->name, &error_abort);
> +}
> +
>  /* Bit */
>=20=20
>  static uint32_t qdev_get_prop_mask(Property *prop)
> @@ -120,11 +126,17 @@ static void prop_set_bit(Object *obj, Visitor *v, c=
onst char *name,
>      bit_prop_set(dev, prop, value);
>  }
>=20=20
> +static void set_default_value_bool(Object *obj, const Property *prop)
> +{
> +    object_property_set_bool(obj, prop->defval, prop->name, &error_abort=
);
> +}
> +
>  PropertyInfo qdev_prop_bit =3D {
>      .name  =3D "bool",
>      .description =3D "on/off",
>      .get   =3D prop_get_bit,
>      .set   =3D prop_set_bit,
> +    .set_default_value =3D set_default_value_bool,
>  };
>=20=20
>  /* Bit64 */
> @@ -183,6 +195,7 @@ PropertyInfo qdev_prop_bit64 =3D {
>      .description =3D "on/off",
>      .get   =3D prop_get_bit64,
>      .set   =3D prop_set_bit64,
> +    .set_default_value =3D set_default_value_bool,
>  };
>=20=20
>  /* --- bool --- */
> @@ -216,6 +229,7 @@ PropertyInfo qdev_prop_bool =3D {
>      .name  =3D "bool",
>      .get   =3D get_bool,
>      .set   =3D set_bool,
> +    .set_default_value =3D set_default_value_bool,
>  };
>=20=20
>  /* --- 8bit integer --- */
> @@ -245,10 +259,16 @@ static void set_uint8(Object *obj, Visitor *v, cons=
t char *name, void *opaque,
>      visit_type_uint8(v, name, ptr, errp);
>  }
>=20=20
> +static void set_default_value_int(Object *obj, const Property *prop)
> +{
> +    object_property_set_int(obj, prop->defval, prop->name, &error_abort);
> +}
> +
>  PropertyInfo qdev_prop_uint8 =3D {
>      .name  =3D "uint8",
>      .get   =3D get_uint8,
>      .set   =3D set_uint8,
> +    .set_default_value =3D set_default_value_int,
>  };
>=20=20
>  /* --- 16bit integer --- */
> @@ -282,6 +302,7 @@ PropertyInfo qdev_prop_uint16 =3D {
>      .name  =3D "uint16",
>      .get   =3D get_uint16,
>      .set   =3D set_uint16,
> +    .set_default_value =3D set_default_value_int,
>  };
>=20=20
>  /* --- 32bit integer --- */
> @@ -340,12 +361,14 @@ PropertyInfo qdev_prop_uint32 =3D {
>      .name  =3D "uint32",
>      .get   =3D get_uint32,
>      .set   =3D set_uint32,
> +    .set_default_value =3D set_default_value_int,
>  };
>=20=20
>  PropertyInfo qdev_prop_int32 =3D {
>      .name  =3D "int32",
>      .get   =3D get_int32,
>      .set   =3D set_int32,
> +    .set_default_value =3D set_default_value_int,
>  };
>=20=20
>  /* --- 64bit integer --- */
> @@ -379,6 +402,7 @@ PropertyInfo qdev_prop_uint64 =3D {
>      .name  =3D "uint64",
>      .get   =3D get_uint64,
>      .set   =3D set_uint64,
> +    .set_default_value =3D set_default_value_int,
>  };
>=20=20
>  /* --- string --- */
> @@ -526,6 +550,7 @@ PropertyInfo qdev_prop_on_off_auto =3D {
>      .enum_table =3D OnOffAuto_lookup,
>      .get =3D get_enum,
>      .set =3D set_enum,
> +    .set_default_value =3D set_default_value_enum,
>  };
>=20=20
>  /* --- lost tick policy --- */
> @@ -537,6 +562,7 @@ PropertyInfo qdev_prop_losttickpolicy =3D {
>      .enum_table  =3D LostTickPolicy_lookup,
>      .get   =3D get_enum,
>      .set   =3D set_enum,
> +    .set_default_value =3D set_default_value_enum,
>  };
>=20=20
>  /* --- Block device error handling policy --- */
> @@ -550,6 +576,7 @@ PropertyInfo qdev_prop_blockdev_on_error =3D {
>      .enum_table =3D BlockdevOnError_lookup,
>      .get =3D get_enum,
>      .set =3D set_enum,
> +    .set_default_value =3D set_default_value_enum,
>  };
>=20=20
>  /* --- BIOS CHS translation */
> @@ -563,6 +590,7 @@ PropertyInfo qdev_prop_bios_chs_trans =3D {
>      .enum_table =3D BiosAtaTranslation_lookup,
>      .get =3D get_enum,
>      .set =3D set_enum,
> +    .set_default_value =3D set_default_value_enum,
>  };
>=20=20
>  /* --- FDC default drive types */
> @@ -573,7 +601,8 @@ PropertyInfo qdev_prop_fdc_drive_type =3D {
>                     "144/288/120/none/auto",
>      .enum_table =3D FloppyDriveType_lookup,
>      .get =3D get_enum,
> -    .set =3D set_enum
> +    .set =3D set_enum,
> +    .set_default_value =3D set_default_value_enum,
>  };
>=20=20
>  /* --- pci address --- */
> @@ -648,6 +677,7 @@ PropertyInfo qdev_prop_pci_devfn =3D {
>      .print =3D print_pci_devfn,
>      .get   =3D get_int32,
>      .set   =3D set_pci_devfn,
> +    .set_default_value =3D set_default_value_int,
>  };
>=20=20
>  /* --- blocksize --- */
> @@ -695,6 +725,7 @@ PropertyInfo qdev_prop_blocksize =3D {
>      .description =3D "A power of two between 512 and 32768",
>      .get   =3D get_uint16,
>      .set   =3D set_blocksize,
> +    .set_default_value =3D set_default_value_int,
>  };
>=20=20
>  /* --- pci host address --- */
> @@ -917,6 +948,7 @@ PropertyInfo qdev_prop_arraylen =3D {
>      .name =3D "uint32",
>      .get =3D get_uint32,
>      .set =3D set_prop_arraylen,
> +    .set_default_value =3D set_default_value_int,
>  };
>=20=20
>  /* --- public helpers --- */
> @@ -1153,4 +1185,5 @@ PropertyInfo qdev_prop_size =3D {
>      .name  =3D "size",
>      .get =3D get_size,
>      .set =3D set_size,
> +    .set_default_value =3D set_default_value_int,
>  };
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 71ff95fd71..6674e11840 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -794,17 +794,8 @@ void qdev_property_add_static(DeviceState *dev, Prop=
erty *prop,
>                                      prop->info->description,
>                                      &error_abort);
>=20=20
> -    if (prop->qtype =3D=3D QTYPE_NONE) {
> -        return;
> -    }
> -
> -    if (prop->qtype =3D=3D QTYPE_QBOOL) {
> -        object_property_set_bool(obj, prop->defval, prop->name, &error_a=
bort);
> -    } else if (prop->info->enum_table) {
> -        object_property_set_str(obj, prop->info->enum_table[prop->defval=
],
> -                                prop->name, &error_abort);
> -    } else if (prop->qtype =3D=3D QTYPE_QINT) {
> -        object_property_set_int(obj, prop->defval, prop->name, &error_ab=
ort);
> +    if (prop->info->set_default_value) {
> +        prop->info->set_default_value(obj, prop);
>      }
>  }

Lovely cleanup.

The interesting part is the move of the bits controlling use of ->defval
from Property member .qtype (set only by DEFINE_PROP_foo() macros) to
its PropertyInfo method .info->set_default_value().  No functional
change if (1) we preserve existing use of ->defval and (2) we don't add
new uses of ->defval, or at least not uses that matter.

Direction (1) is obvious for DEFINE_PROP_BIT(), DEFINE_PROP_BIT64(),
DEFINE_PROP_BOOL().  They set .info to &qdev_prop_bit, &qdev_prop_bit64,
&qdev_prop_bool, respectively.  These all get .set_default_value =3D
set_default_value_bool, which preserves the effect of .qtype =3D
QTYPE_BOOL.  Good.

DEFINE_PROP_DEFAULT() sets .info to point to its argument _prop.  The
following arguments occur:

* In include/hw/qdev-properties.h: qdev_prop_uint8, qdev_prop_uint16,
  qdev_prop_uint32, qdev_prop_int32, qdev_prop_uint64, qdev_prop_size,
  qdev_prop_pci_devfn, qdev_prop_on_off_auto, qdev_prop_losttickpolicy,
  qdev_prop_blockdev_on_error, qdev_prop_bios_chs_trans,
  qdev_prop_blocksize

* In hw/block/fdc.c: qdev_prop_fdc_drive_type

* In hw/net/e1000e.c: local copies of qdev_prop_uint8, qdev_prop_uint16.

To preserve the effect of .qtype =3D QTYPE_QINT, these PropertyInfo need
.set_default_value =3D set_default_value_int or .set_default_value =3D
set_default_value_enum, depending on .enum_table.  They get it.  Good.

DEFINE_PROP_ARRAY() sets .info to &qdev_prop_arraylen.  Needs and gets
.set_default_value =3D set_default_value_int.  Good.

DEFINE_PROP_ARRAY() also takes a PropertyInfo argument, but it's not
relevant here, as the .qtype you remove doesn't apply to it.  I'm
mentioning this, because it confused me briefly.

Direction (2) isn't as visible in the patch.  For each PropertyInfo you
change, we need to find and check stores into .info not wrapped in the
DEFINE_PROP_foo() macros you change.

I can't find any.  Good.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
