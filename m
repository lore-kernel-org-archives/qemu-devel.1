Received: from eggs.gnu.org ([2001:4830:134:3::10]:60842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erZcp-0003VO-LD
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:36:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erZco-0007kR-5b
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:36:43 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:32965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1erZcn-0007iN-Ic
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:36:42 -0500
Date: Fri, 2 Mar 2018 12:00:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180302010002.GB13135@umbus.fritz.box>
References: <20180301130939.15875-1-aik@ozlabs.ru>
	<20180301130939.15875-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
In-Reply-To: <20180301130939.15875-2-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v3 1/2] qmp: Merge ObjectPropertyInfo
 and DevicePropertyInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 12:09:38AM +1100, Alexey Kardashevskiy wrote:
> ObjectPropertyInfo is more generic and only missing @description.
> This adds a description to ObjectPropertyInfo and removes
> DevicePropertyInfo so the resulting ObjectPropertyInfo can be used
> elsewhere.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  qapi-schema.json | 23 +++++------------------
>  qdev-monitor.c   |  6 +++---
>  qmp.c            | 20 ++++++++++----------
>  3 files changed, 18 insertions(+), 31 deletions(-)
>=20
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 0262b9f..87327e5 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -1266,10 +1266,12 @@
>  #        3) A link type in the form 'link<subtype>' where subtype is a q=
dev
>  #           device type name.  Link properties form the device model gra=
ph.
>  #
> +# @description: if specified, the description of the property.
> +#
>  # Since: 1.2
>  ##
>  { 'struct': 'ObjectPropertyInfo',
> -  'data': { 'name': 'str', 'type': 'str' } }
> +  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
> =20
>  ##
>  # @qom-list:
> @@ -1425,34 +1427,19 @@
>    'returns': [ 'ObjectTypeInfo' ] }
> =20
>  ##
> -# @DevicePropertyInfo:
> -#
> -# Information about device properties.
> -#
> -# @name: the name of the property
> -# @type: the typename of the property
> -# @description: if specified, the description of the property.
> -#               (since 2.2)
> -#
> -# Since: 1.2
> -##
> -{ 'struct': 'DevicePropertyInfo',
> -  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
> -
> -##
>  # @device-list-properties:
>  #
>  # List properties associated with a device.
>  #
>  # @typename: the type name of a device
>  #
> -# Returns: a list of DevicePropertyInfo describing a devices properties
> +# Returns: a list of ObjectPropertyInfo describing a devices properties
>  #
>  # Since: 1.2
>  ##
>  { 'command': 'device-list-properties',
>    'data': { 'typename': 'str'},
> -  'returns': [ 'DevicePropertyInfo' ] }
> +  'returns': [ 'ObjectPropertyInfo' ] }
> =20
>  ##
>  # @xen-set-global-dirty-log:
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 8462381..ab9c46c 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -258,8 +258,8 @@ int qdev_device_help(QemuOpts *opts)
>  {
>      Error *local_err =3D NULL;
>      const char *driver;
> -    DevicePropertyInfoList *prop_list;
> -    DevicePropertyInfoList *prop;
> +    ObjectPropertyInfoList *prop_list;
> +    ObjectPropertyInfoList *prop;
> =20
>      driver =3D qemu_opt_get(opts, "driver");
>      if (driver && is_help_option(driver)) {
> @@ -295,7 +295,7 @@ int qdev_device_help(QemuOpts *opts)
>          }
>      }
> =20
> -    qapi_free_DevicePropertyInfoList(prop_list);
> +    qapi_free_ObjectPropertyInfoList(prop_list);
>      return 1;
> =20
>  error:
> diff --git a/qmp.c b/qmp.c
> index 793f6f3..8a74038 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -463,12 +463,12 @@ ObjectTypeInfoList *qmp_qom_list_types(bool has_imp=
lements,
>   *
>   * The caller must free the return value.
>   */
> -static DevicePropertyInfo *make_device_property_info(ObjectClass *klass,
> -                                                     const char *name,
> -                                                     const char *default=
_type,
> -                                                     const char *descrip=
tion)
> +static ObjectPropertyInfo *make_device_property_info(ObjectClass *klass,
> +                                                  const char *name,
> +                                                  const char *default_ty=
pe,
> +                                                  const char *descriptio=
n)
>  {
> -    DevicePropertyInfo *info;
> +    ObjectPropertyInfo *info;
>      Property *prop;
> =20
>      do {
> @@ -508,14 +508,14 @@ static DevicePropertyInfo *make_device_property_inf=
o(ObjectClass *klass,
>      return info;
>  }
> =20
> -DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
> -                                                   Error **errp)
> +ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
> +                                                Error **errp)
>  {
>      ObjectClass *klass;
>      Object *obj;
>      ObjectProperty *prop;
>      ObjectPropertyIterator iter;
> -    DevicePropertyInfoList *prop_list =3D NULL;
> +    ObjectPropertyInfoList *prop_list =3D NULL;
> =20
>      klass =3D object_class_by_name(typename);
>      if (klass =3D=3D NULL) {
> @@ -540,8 +540,8 @@ DevicePropertyInfoList *qmp_device_list_properties(co=
nst char *typename,
> =20
>      object_property_iter_init(&iter, obj);
>      while ((prop =3D object_property_iter_next(&iter))) {
> -        DevicePropertyInfo *info;
> -        DevicePropertyInfoList *entry;
> +        ObjectPropertyInfo *info;
> +        ObjectPropertyInfoList *entry;
> =20
>          /* Skip Object and DeviceState properties */
>          if (strcmp(prop->name, "type") =3D=3D 0 ||

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqYog8ACgkQbDjKyiDZ
s5IKcA/+JKWI7uE34Kqcolewr4yXMB1PXzCn9U8vczbQtftyFiSeqduD9NC51ZUb
Foh5gNI/iC73QptEyP3M0j1fF7eIkSsToyhttNlM8v0nqI2qWV9NJlPmuYP6Quhn
bkmlB2mUCLfdUGLmte3XKBrxDEH/yZu7xyJpr7CB/I97q6c824ozNQRhhshYtyVG
j+esJ/p/UQo8w9t6M6X0XGZse2Yq7aTmJVvB/jKpMwpppESmXeWWRXSTrfYAutNF
WpvrFDgYBMKaMbNpgiQERV52m7eapa5X8FGLziOSuLa3G+xxCK3apDGl9AmERw1W
LX3cx+JmUoskvWtKubDT5U50Xu3j4nrfYeC+tDPZHHFpbLvsAFndNf4YYqRkn3/1
qh1Di46AFtbjbxi1ayCUsIthiLxA6OvAcTcIr2TdPwVUYggg7LHSLtZso42Gh5K/
rKOovx2pYF2buS7c1AQNGQ94tG25/zmaRv6JyptfbTLdEFVAdsrXrQMSDAH/UY6I
eyIde0/uJy1n1gYYpb3jlciILwJCAG02+JhyeLrxZg5Z2mUDFP/xpSf7C0Kqjr/c
oYJSUIyUdf6c6/vUzJ1xjljMWL+9A7uEzTZz4yka+GXJi5zkZwVMDX5DKU52CGDq
lCgJN5HK0qJKjbpLzZLPmKFWCDaMOad6pKbJJGEIjmDg6Cot7eg=
=mRFP
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
