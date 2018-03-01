Received: from eggs.gnu.org ([2001:4830:134:3::10]:54320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erFR7-0001S0-PH
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 23:03:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erFR4-00049c-Po
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 23:03:17 -0500
Received: from ozlabs.org ([103.22.144.67]:52685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1erFR4-00043z-6f
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 23:03:14 -0500
Date: Thu, 1 Mar 2018 14:59:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180301035910.GC2264@umbus.fritz.box>
References: <20180226082259.40293-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <20180226082259.40293-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v2] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 07:22:59PM +1100, Alexey Kardashevskiy wrote:
> There is already 'device-list-properties' which does most of the job,
> however it does not handle everything returned by qom-list-types such
> as machines as they inherit directly from TYPE_OBJECT and not TYPE_DEVICE.
> It does not handle abstract classes either.
>=20
> This adds a new qom-list-properties command which prints properties
> of a specific class and its instance. It is pretty much a simplified copy
> of the device-list-properties handler.
>=20
> Since it creates an object instance, device properties should appear
> in the output as they are copied to QOM properties at the instance_init
> hook.
>=20
> This adds a object_class_property_iter_init() helper to allow class
> properties enumeration uses it in the new QMP command to allow properties
> listing for abstract classes.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * added abstract classes support, now things like "pci-device" or
> "spapr-machine" show properties, previously these would produce
> an "abstract class" error
> ---
>  qapi-schema.json     | 29 +++++++++++++++++++++++++++++
>  include/qom/object.h | 16 ++++++++++++++++
>  qmp.c                | 49 ++++++++++++++++++++++++++++++++++++++++++++++=
+++
>  qom/object.c         |  7 +++++++
>  4 files changed, 101 insertions(+)
>=20
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 0262b9f..fa5f189 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -1455,6 +1455,35 @@
>    'returns': [ 'DevicePropertyInfo' ] }
> =20
>  ##
> +# @QOMPropertyInfo:
> +#
> +# Information about object properties.
> +#
> +# @name: the name of the property
> +# @type: the typename of the property
> +# @description: if specified, the description of the property.
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'QOMPropertyInfo',
> +  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }

So, this has identical contents to DevicePropertyInfo, and is very
similar to ObjectPropertyInfo.  Is there any way we could consolidate
those types?

> +##
> +# @qom-list-properties:
> +#
> +# List properties associated with a QOM object.
> +#
> +# @typename: the type name of an object
> +#
> +# Returns: a list of QOMPropertyInfo describing object properties
> +#
> +# Since: 2.12
> +##
> +{ 'command': 'qom-list-properties',
> +  'data': { 'typename': 'str'},
> +  'returns': [ 'QOMPropertyInfo' ] }
> +
> +##
>  # @xen-set-global-dirty-log:
>  #
>  # Enable or disable the global dirty log mode.
> diff --git a/include/qom/object.h b/include/qom/object.h
> index dc73d59..ef07d78 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1017,6 +1017,22 @@ void object_property_iter_init(ObjectPropertyItera=
tor *iter,
>                                 Object *obj);
> =20
>  /**
> + * object_class_property_iter_init:
> + * @klass: the class
> + *
> + * Initializes an iterator for traversing all properties
> + * registered against an object class and all parent classes.
> + *
> + * It is forbidden to modify the property list while iterating,
> + * whether removing or adding properties.
> + *
> + * This can be used on abstract classes as it does not create a temporary
> + * instance.
> + */
> +void object_class_property_iter_init(ObjectPropertyIterator *iter,
> +                                     ObjectClass *klass);
> +
> +/**
>   * object_property_iter_next:
>   * @iter: the iterator instance
>   *
> diff --git a/qmp.c b/qmp.c
> index 793f6f3..151d3d7 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -576,6 +576,55 @@ DevicePropertyInfoList *qmp_device_list_properties(c=
onst char *typename,
>      return prop_list;
>  }
> =20
> +QOMPropertyInfoList *qmp_qom_list_properties(const char *typename,
> +                                             Error **errp)
> +{
> +    ObjectClass *klass;
> +    Object *obj =3D NULL;
> +    ObjectProperty *prop;
> +    ObjectPropertyIterator iter;
> +    QOMPropertyInfoList *prop_list =3D NULL;
> +
> +    klass =3D object_class_by_name(typename);
> +    if (klass =3D=3D NULL) {
> +        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
> +                  "Class '%s' not found", typename);
> +        return NULL;
> +    }
> +
> +    klass =3D object_class_dynamic_cast(klass, TYPE_OBJECT);
> +    if (klass =3D=3D NULL) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename", TYPE_=
OBJECT);
> +        return NULL;
> +    }
> +
> +    if (object_class_is_abstract(klass)) {
> +        object_class_property_iter_init(&iter, klass);

I like the idea of adding abstract classes in principle, but I'm a
little concerned about the effect of this in practice, because it only
lists class properties.

Although nearly all properties in qemu *should* be class properties,
they're nearly all defined as instance properties in practice.  AFAICT
this is just because most people didn't get the memo on class
properties and how to use them.

Just listing class properties in general might be ok - it would
encourage people to move things to class properties if they should
be.  However listing class properties in some cases and all properties
in other sounds like a recipe for confusion.

> +    } else {
> +        obj =3D object_new(typename);
> +        object_property_iter_init(&iter, obj);
> +    }
> +    while ((prop =3D object_property_iter_next(&iter))) {
> +        QOMPropertyInfo *info;
> +        QOMPropertyInfoList *entry;
> +
> +        info =3D g_malloc0(sizeof(*info));
> +        info->name =3D g_strdup(prop->name);
> +        info->type =3D g_strdup(prop->type);
> +        info->has_description =3D !!prop->description;
> +        info->description =3D g_strdup(prop->description);
> +
> +        entry =3D g_malloc0(sizeof(*entry));
> +        entry->value =3D info;
> +        entry->next =3D prop_list;
> +        prop_list =3D entry;
> +    }
> +
> +    object_unref(obj);
> +
> +    return prop_list;
> +}
> +
>  CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
>  {
>      return arch_query_cpu_definitions(errp);
> diff --git a/qom/object.c b/qom/object.c
> index 5dcee46..e7978bd 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1037,6 +1037,13 @@ ObjectProperty *object_property_iter_next(ObjectPr=
opertyIterator *iter)
>      return val;
>  }
> =20
> +void object_class_property_iter_init(ObjectPropertyIterator *iter,
> +                                     ObjectClass *klass)
> +{
> +    g_hash_table_iter_init(&iter->iter, klass->properties);
> +    iter->nextclass =3D klass;
> +}
> +
>  ObjectProperty *object_class_property_find(ObjectClass *klass, const cha=
r *name,
>                                             Error **errp)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqXeo4ACgkQbDjKyiDZ
s5LFNQ//aqN0hsqX5nIhelwFSZ51Ixja5ZNwk0sjKHiBbhngyIlw2/OccOJIm1LL
f/DnltVFlZP+LAiokStULiDne2VOSpJLcSqgLK5KLBeD4eQM3yp2muUS3l5SK7jZ
5QejjNAchxYd1cGGaNXZGdxz6nfwzCrrY4gmZRB1/C/89pPXvhD4XN8mKRt8zWgJ
7tQg35ytOrVLAiGpBYBCrZMKuFNHlQzKWb/bvrMOYw2uvIuY7bjyU7i1/5sxZIoz
zSiHvkiX70SaDKF0St08/UPQvk5mU3Xja4nICYVG7qCpkSCKFXTrgnEkeMRpTcWy
TRDwPhD6u33w2HZXlM9WZ4HFW+vqxG/34zG3J/QHhxEzNoQS8ykdGWFNmYqDxLcE
E6eO9rVS7nxn2SR03LgYYyHOe4ALzd/+luayPBmYMtQXtGlcF7ePuPG9Z/skdwSD
6U27TLzcXxizG4C0xGxY8+lqwqstwnyA/j3+WuUjzew6zM+BQPTsObivqEdhFh7v
/EMlsGxZ6jFTAGIIi5VeB6ONSr4WcexQX7nFNYJZ2nTsHFF+/kPcYKA1a9jo/zvX
5BJvsSbVkUMf6GWCz/8L+olBZ+BsVNxrQA8088hmucwqZ4yeU2oLBp+IOF01R2Zi
4tM/o5+59iqKoUq7x+xwFRN+IlY0cjgBDQfTqLp66KY8vvymwh4=
=8S9l
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
