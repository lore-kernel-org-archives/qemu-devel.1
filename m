Received: from eggs.gnu.org ([2001:4830:134:3::10]:41406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dJGml-0008Fa-RE
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dJGmi-0003L8-Iv
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:04:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dJGmi-0003L2-AJ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:04:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45A5961B9F
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 10:04:51 +0000 (UTC)
Date: Fri, 9 Jun 2017 06:04:50 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1410212199.32019490.1497002690066.JavaMail.zimbra@redhat.com>
In-Reply-To: <87wp8m1k6k.fsf@dusky.pond.sub.org>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
	<20170607163635.17635-18-marcandre.lureau@redhat.com>
	<87wp8m1k6k.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

----- Original Message -----
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > Modify the unsigned type for various properties to use QNUM_U64, to
> > avoid type casts.
> >
> > There are a few empty lines added to improve code reading/style.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/hw/qdev-core.h       |  1 +
> >  include/hw/qdev-properties.h | 29 ++++++++++++++++++++---------
> >  hw/core/qdev-properties.c    | 23 ++++++++++++++---------
> >  3 files changed, 35 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> > index 784971b8d8..9d7c1c0e9b 100644
> > --- a/include/hw/qdev-core.h
> > +++ b/include/hw/qdev-core.h
> > @@ -228,6 +228,7 @@ struct Property {
> >      uint8_t      bitnr;
> >      union {
> >          int64_t i;
> > +        uint64_t u;
> >      } defval;
> >      int          arrayoffset;
> >      PropertyInfo *arrayinfo;
> > diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.=
h
> > index 34524d0bfe..1e5c928f32 100644
> > --- a/include/hw/qdev-properties.h
> > +++ b/include/hw/qdev-properties.h
> > @@ -37,6 +37,7 @@ extern PropertyInfo qdev_prop_arraylen;
> >          .offset    =3D offsetof(_state, _field)                    \
> >              + type_check(_type, typeof_field(_state, _field)),   \
> >          }
> > +
> >  #define DEFINE_PROP_SIGNED(_name, _state, _field, _defval, _prop, _typ=
e) {
> >  \
> >          .name      =3D (_name),                                       =
    \
> >          .info      =3D &(_prop),                                      =
    \
> > @@ -44,21 +45,31 @@ extern PropertyInfo qdev_prop_arraylen;
> >              + type_check(_type,typeof_field(_state, _field)),         =
  \
> >          .defval.i  =3D (_type)_defval,                                =
    \
> >          }
> > +
> >  #define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval) {  \
> >          .name      =3D (_name),                                    \
> >          .info      =3D &(qdev_prop_bit),                           \
> >          .bitnr    =3D (_bit),                                      \
> >          .offset    =3D offsetof(_state, _field)                    \
> >              + type_check(uint32_t,typeof_field(_state, _field)), \
> > -        .defval.i  =3D (bool)_defval,                              \
> > +        .defval.u  =3D (bool)_defval,                              \
> > +        }
> > +
> > +#define DEFINE_PROP_UNSIGNED(_name, _state, _field, _defval, _prop, _t=
ype)
> > { \
> > +        .name      =3D (_name),                                       =
    \
> > +        .info      =3D &(_prop),                                      =
    \
> > +        .offset    =3D offsetof(_state, _field)                       =
    \
> > +            + type_check(_type, typeof_field(_state, _field)),        =
  \
> > +        .defval.u  =3D (_type)_defval,                                =
    \
> >          }
> > +
> >  #define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval) {     =
  \
> >          .name      =3D (_name),                                       =
    \
> >          .info      =3D &(qdev_prop_bit64),                            =
    \
> >          .bitnr    =3D (_bit),                                         =
    \
> >          .offset    =3D offsetof(_state, _field)                       =
    \
> >              + type_check(uint64_t, typeof_field(_state, _field)),     =
  \
> > -        .defval.i  =3D (bool)_defval,                                 =
    \
> > +        .defval.u  =3D (bool)_defval,                                 =
    \
> >          }
> > =20
> >  #define DEFINE_PROP_BOOL(_name, _state, _field, _defval) {       \
> > @@ -66,7 +77,7 @@ extern PropertyInfo qdev_prop_arraylen;
> >          .info      =3D &(qdev_prop_bool),                          \
> >          .offset    =3D offsetof(_state, _field)                    \
> >              + type_check(bool, typeof_field(_state, _field)),    \
> > -        .defval.i  =3D (bool)_defval,                              \
> > +        .defval.u    =3D (bool)_defval,                            \
>=20
> Whitespace is off.
>=20
> >          }
> > =20
> >  #define PROP_ARRAY_LEN_PREFIX "len-"
> > @@ -107,17 +118,17 @@ extern PropertyInfo qdev_prop_arraylen;
> >          }
> > =20
> >  #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
> > -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
> > +    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
> >  #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
> > -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_uint16, uint16_t)
> > +    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint16, uint16_t)
> >  #define DEFINE_PROP_UINT32(_n, _s, _f, _d)                      \
> > -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_uint32, uint32_t)
> > +    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint32, uint32_t)
> >  #define DEFINE_PROP_INT32(_n, _s, _f, _d)                      \
> >      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int32, int32_t)
> >  #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
> > -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
> > +    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
> >  #define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
> > -    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
> > +    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
> >  #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
> >      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
> > =20
> > @@ -163,7 +174,7 @@ extern PropertyInfo qdev_prop_arraylen;
> >  #define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
> >      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
> >  #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
> > -    DEFINE_PROP_SIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
> > +    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
> >  #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
> >      DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr,
> >      PCIHostDeviceAddress)
> > =20
> > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > index f3f682c611..a8f09c13e2 100644
> > --- a/hw/core/qdev-properties.c
> > +++ b/hw/core/qdev-properties.c
> > @@ -71,7 +71,7 @@ static void set_enum(Object *obj, Visitor *v, const c=
har
> > *name, void *opaque,
> > =20
> >  static void set_default_value_enum(Object *obj, const Property *prop)
> >  {
> > -    object_property_set_str(obj, prop->info->enum_table[prop->defval.i=
],
> > +    object_property_set_str(obj, prop->info->enum_table[prop->defval.u=
],
> >                              prop->name, &error_abort);
> >  }
>=20
> You use DEFINE_PROP_SIGNED() for enums.  Shouldn't we stick to defval.i?

Yes, enum should be signed, please fix on commit (unless I have to resend).


>=20
> > =20
> > @@ -128,7 +128,7 @@ static void prop_set_bit(Object *obj, Visitor *v, c=
onst
> > char *name,
> > =20
> >  static void set_default_value_bool(Object *obj, const Property *prop)
> >  {
> > -    object_property_set_bool(obj, prop->defval.i, prop->name,
> > &error_abort);
> > +    object_property_set_bool(obj, prop->defval.u, prop->name,
> > &error_abort);
> >  }
> > =20
> >  PropertyInfo qdev_prop_bit =3D {
> > @@ -264,11 +264,16 @@ static void set_default_value_int(Object *obj, co=
nst
> > Property *prop)
> >      object_property_set_int(obj, prop->defval.i, prop->name,
> >      &error_abort);
> >  }
> > =20
> > +static void set_default_value_uint(Object *obj, const Property *prop)
> > +{
> > +    object_property_set_uint(obj, prop->defval.u, prop->name,
> > &error_abort);
> > +}
> > +
> >  PropertyInfo qdev_prop_uint8 =3D {
> >      .name  =3D "uint8",
> >      .get   =3D get_uint8,
> >      .set   =3D set_uint8,
> > -    .set_default_value =3D set_default_value_int,
> > +    .set_default_value =3D set_default_value_uint,
> >  };
> > =20
> >  /* --- 16bit integer --- */
> > @@ -302,7 +307,7 @@ PropertyInfo qdev_prop_uint16 =3D {
> >      .name  =3D "uint16",
> >      .get   =3D get_uint16,
> >      .set   =3D set_uint16,
> > -    .set_default_value =3D set_default_value_int,
> > +    .set_default_value =3D set_default_value_uint,
> >  };
> > =20
> >  /* --- 32bit integer --- */
> > @@ -361,7 +366,7 @@ PropertyInfo qdev_prop_uint32 =3D {
> >      .name  =3D "uint32",
> >      .get   =3D get_uint32,
> >      .set   =3D set_uint32,
> > -    .set_default_value =3D set_default_value_int,
> > +    .set_default_value =3D set_default_value_uint,
> >  };
> > =20
> >  PropertyInfo qdev_prop_int32 =3D {
> > @@ -402,7 +407,7 @@ PropertyInfo qdev_prop_uint64 =3D {
> >      .name  =3D "uint64",
> >      .get   =3D get_uint64,
> >      .set   =3D set_uint64,
> > -    .set_default_value =3D set_default_value_int,
> > +    .set_default_value =3D set_default_value_uint,
> >  };
> > =20
> >  /* --- string --- */
> > @@ -725,7 +730,7 @@ PropertyInfo qdev_prop_blocksize =3D {
> >      .description =3D "A power of two between 512 and 32768",
> >      .get   =3D get_uint16,
> >      .set   =3D set_blocksize,
> > -    .set_default_value =3D set_default_value_int,
> > +    .set_default_value =3D set_default_value_uint,
> >  };
> > =20
> >  /* --- pci host address --- */
> > @@ -948,7 +953,7 @@ PropertyInfo qdev_prop_arraylen =3D {
> >      .name =3D "uint32",
> >      .get =3D get_uint32,
> >      .set =3D set_prop_arraylen,
> > -    .set_default_value =3D set_default_value_int,
> > +    .set_default_value =3D set_default_value_uint,
> >  };
> > =20
> >  /* --- public helpers --- */
> > @@ -1185,5 +1190,5 @@ PropertyInfo qdev_prop_size =3D {
> >      .name  =3D "size",
> >      .get =3D get_size,
> >      .set =3D set_size,
> > -    .set_default_value =3D set_default_value_int,
> > +    .set_default_value =3D set_default_value_uint,
> >  };
>=20
