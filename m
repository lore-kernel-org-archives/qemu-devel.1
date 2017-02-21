Received: from eggs.gnu.org ([2001:4830:134:3::10]:59398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgCov-0005DY-UL
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:57:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgCos-00017F-F4
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:57:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgCos-00016q-5o
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:57:38 -0500
References: <20170221104256.5153-1-pbonzini@redhat.com>
	<20170221104256.5153-2-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <48da68cf-67bf-1be8-206e-f082fbd024fc@redhat.com>
Date: Tue, 21 Feb 2017 09:57:34 -0600
MIME-Version: 1.0
In-Reply-To: <20170221104256.5153-2-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nqxfnt3QhmWOjcoBDsJbAo3h1FX4AIeLW"
Subject: Re: [Qemu-devel] [PATCH 1/3] qom-qobject: introduce
 object_property_{g, s}et_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: anton.nefedov@virtuozzo.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nqxfnt3QhmWOjcoBDsJbAo3h1FX4AIeLW
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: anton.nefedov@virtuozzo.com, den@openvz.org
Message-ID: <48da68cf-67bf-1be8-206e-f082fbd024fc@redhat.com>
Subject: Re: [PATCH 1/3] qom-qobject: introduce object_property_{g,s}et_ptr
References: <20170221104256.5153-1-pbonzini@redhat.com>
 <20170221104256.5153-2-pbonzini@redhat.com>
In-Reply-To: <20170221104256.5153-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 04:42 AM, Paolo Bonzini wrote:
> The functions simplify the handling of QOM properties whose type
> is a QAPI struct.  They go through a QObject just like the other
> functions that access a QOM property through its C type.
>=20
> Like QAPI_CLONE, the functions are wrapped by macros that take a
> QAPI type name and use it to build the name of a visitor function.

I'm glad I got QAPI_CLONE working - it has proven to be a nice source of
inspiration for further cleanups.

>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qom/qom-qobject.h               |  68 ++++++++++++
>  qom/qom-qobject.c                       |  49 +++++++++
>  tests/Makefile.include                  |   2 +-
>  tests/check-qom-proplist.c              | 185 ++++++++++++++++++++++++=
+++++++-
>  tests/qapi-schema/qapi-schema-test.json |   8 ++
>  5 files changed, 309 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/qom/qom-qobject.h b/include/qom/qom-qobject.h
> index 77cd717..ff1d307 100644
> --- a/include/qom/qom-qobject.h
> +++ b/include/qom/qom-qobject.h
> @@ -39,4 +39,72 @@ struct QObject *object_property_get_qobject(Object *=
obj, const char *name,
>  void object_property_set_qobject(Object *obj, struct QObject *qobj,
>                                   const char *name, struct Error **errp=
);
> =20
> +/**
> + * object_property_get_ptr:
> + * @obj: the object
> + * @ptr: The C struct that will be written to the property.

Maybe: The C struct that will be set to the property's value

Except there is no ptr parameter in this function signature.
Copy-and-paste leftover?

> + * @name: the name of the property

Inconsistent use of trailing '.'

> + * @visit_type: the visitor function for @ptr's type.

Since there is no @ptr, this needs a touchup.

> + * @errp: returns an error if this function fails
> + *
> + * Return: the value of an object's property, unmarshaled into a C obj=
ect
> + * through a QAPI type visitor, or NULL if an error occurs.
> + */
> +void *object_property_get_ptr(Object *obj, const char *name,
> +                              void (*visit_type)(Visitor *, const char=
 *,
> +                                                 void **, Error **),
> +                              Error **errp);
> +
> +/**
> + * OBJECT_PROPERTY_GET_PTR:
> + * @obj: the object
> + * @ptr: The C struct that will be written to the property.

Again, no ptr parameter.

> + * @name: the name of the property
> + * @type: the name of the C struct type pointed to by @ptr.

and again

> + * @errp: returns an error if this function fails
> + *
> + * Return: the value of an object's property, unmarshaled into a C obj=
ect
> + * through a QAPI type visitor, or NULL if an error occurs.
> + */
> +#define OBJECT_PROPERTY_GET_PTR(obj, name, type, errp)                =
      \
> +    ((type *)                                                         =
      \
> +     object_property_get_ptr(obj, name,                               =
      \
> +                             (void (*)(Visitor *, const char *, void**=
,     \
> +                                       Error **))visit_type_ ## type, =
      \

Is it worth a typedef somewhere to make it easier to cast between
visitor functions?

> +                             errp))
> +
> +/**
> + * object_property_set_ptr:
> + * @obj: the object
> + * @ptr: The C struct that will be written to the property.
> + * @name: the name of the property
> + * @visit_type: the visitor function for @ptr's type.

It's a bit weird to separate 'ptr' and 'visit_type' by another
parameter, since they are so integrally related; can we reorder the
parameters to put 'name' before 'ptr', or does that look inconsistent
compared to other existing property manipulations?

> + * @errp: returns an error if this function fails
> + *
> + * Sets an object's property to a C object's value, using a QAPI
> + * type visitor to marshal the C struct into the object.
> + */
> +void object_property_set_ptr(Object *obj, void *ptr, const char *name,=

> +                             void (*visit_type)(Visitor *, const char =
*,
> +                                                void **, Error **),
> +                             Error **errp);
> +
> +/**
> + * OBJECT_PROPERTY_SET_PTR:
> + * @obj: the object
> + * @ptr: The C struct that will be written to the property.
> + * @name: the name of the property
> + * @type: the name of the C struct type pointed to by @ptr.

Same ordering question, same trailing '.' observation

> + * @errp: returns an error if this function fails
> + *
> + * Sets an object's property to a C object's value, using a QAPI
> + * type visitor to marshal the C struct into the object.
> + */
> +#define OBJECT_PROPERTY_SET_PTR(obj, ptr, name, type, errp)           =
      \
> +    object_property_set_ptr(obj, ptr + type_check(type, typeof(*ptr)),=
      \
> +                            name,                                     =
      \
> +                            (void (*)(Visitor *, const char *, void**,=
      \
> +                                      Error **))visit_type_ ## type,  =
      \

and the typedef'd function pointer may again come in handy.

> +                            errp)
> +
>  #endif
> diff --git a/qom/qom-qobject.c b/qom/qom-qobject.c
> index 447e4a0..09a12e0 100644
> --- a/qom/qom-qobject.c
> +++ b/qom/qom-qobject.c
> @@ -44,3 +44,52 @@ QObject *object_property_get_qobject(Object *obj, co=
nst char *name,
>      visit_free(v);
>      return ret;
>  }
> +
> +void object_property_set_ptr(Object *obj, void *ptr, const char *name,=

> +                             void (*visit_type)(Visitor *, const char =
*, void **, Error **),

Long line; you wrapped it in the .h, so you could do so here, too.

> +                             Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    QObject *ret =3D NULL;
> +    Visitor *v;
> +    v =3D qobject_output_visitor_new(&ret);
> +    visit_type(v, name, &ptr, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        visit_free(v);
> +        return;
> +    }
> +    visit_complete(v, &ret);
> +    visit_free(v);
> +
> +    /* Do not use object_property_set_qobject until we switch it
> +     * to use qobject_input_visitor_new in strict mode.  See the
> +     * /qom/proplist/get-set-ptr/contravariant unit test.

Interesting observation (and useful comment). I wonder how far we are
from killing off non-strict mode, but that's an independent question not
for this series.

> +     */
> +    v =3D qobject_input_visitor_new(ret, true);
> +    object_property_set(obj, v, name, errp);
> +    visit_free(v);
> +    qobject_decref(ret);
> +}
> +
> +void *object_property_get_ptr(Object *obj, const char *name,
> +                              void (*visit_type)(Visitor *, const char=
 *, void **, Error **),
> +                              Error **errp)
> +{
> +    QObject *ret;
> +    Visitor *v;
> +    void *ptr =3D NULL;
> +
> +    ret =3D object_property_get_qobject(obj, name, errp);
> +    if (!ret) {
> +        return NULL;
> +    }
> +
> +    /* Do not enable strict mode to allow passing covariant
> +     * data types.
> +     */
> +    v =3D qobject_input_visitor_new(ret, false);
> +    visit_type(v, name, &ptr, errp);
> +    qobject_decref(ret);
> +    return ptr;
> +}

> +++ b/tests/check-qom-proplist.c

> +
> +static void test_dummy_get_set_ptr_contravariant(void)
> +{
> +    DummyObject *dobj =3D DUMMY_OBJECT(object_new(TYPE_DUMMY));
> +    Error *local_err =3D NULL;
> +    UserDefOneMore *ret;
> +    UserDefOneMore val;
> +
> +    /* You cannot retrieve a contravariant (subclass) type... */
> +    ret =3D OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
> +                                  UserDefOneMore, &local_err);
> +    g_assert(local_err);
> +    g_assert(!ret);
> +    error_free(local_err);

Markus just posted a cleanup patch that uses error_free_or_abort()
instead of multiple lines.

This check makes sense (we can't populate userDefOneMore, because it has
a mandatory field in the subtype that was not stored in the property).

> +    local_err =3D NULL;
> +
> +    /* And you cannot set one either.  */
> +    val.integer =3D 42;
> +    val.string =3D g_strdup("unused");
> +    val.has_enum1 =3D false;
> +    val.boolean =3D false;
> +
> +    OBJECT_PROPERTY_SET_PTR(OBJECT(dobj), &val, "qv",
> +                            UserDefOneMore, &local_err);
> +    g_assert(local_err);

Leaks local_err; use error_free_or_abort().

Makes sense, because the subtype has an extra field that isn't supported
by the property.

> +}
> +
> +static void test_dummy_get_set_ptr_covariant(void)
> +{
> +    DummyObject *dobj =3D DUMMY_OBJECT(object_new(TYPE_DUMMY));
> +    Error *local_err =3D NULL;
> +    UserDefZero *ret;
> +    UserDefZero val;
> +
> +    /* You can retrieve a covariant (superclass) type... */
> +    ret =3D OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
> +                                  UserDefZero, &local_err);
> +    g_assert(!local_err);
> +
> +    g_assert_cmpint(ret->integer, =3D=3D, 0);
> +    qapi_free_UserDefZero(ret);

You coded a non-strict visitor above to allow this to happen, but is it
really what we want?  It basically means we are grabbing the property
fields we care about, while ignoring the rest of the property.  I guess
it may be okay.

> +
> +    /* But you cannot set one.  */
> +    val.integer =3D 42;
> +    OBJECT_PROPERTY_SET_PTR(OBJECT(dobj), &val, "qv",
> +                            UserDefZero, &local_err);
> +    g_assert(local_err);
> +    error_free(local_err);
> +    local_err =3D NULL;

Makes sense that we cannot set something that does not have enough
fields present to match what the property is expecting.

> +
> +    /* Test that the property has not been modified at all */
> +    ret =3D OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
> +                                  UserDefZero, &local_err);
> +    g_assert(!local_err);
> +
> +    g_assert_cmpint(ret->integer, =3D=3D, 0);
> +    qapi_free_UserDefZero(ret);
> +}
> +
> +++ b/tests/qapi-schema/qapi-schema-test.json
> @@ -91,6 +91,14 @@
>              '*enum1': 'EnumOne' } }   # intentional forward reference
> =20
>  ##
> +# @UserDefOneMore:
> +# for testing nested structs

Is nested the right word here?

> +##
> +{ 'struct': 'UserDefOneMore',
> +  'base': 'UserDefOne',
> +  'data': { 'boolean': 'bool' } }
> +
> +##
>  # @EnumOne:
>  ##
>  { 'enum': 'EnumOne',
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--nqxfnt3QhmWOjcoBDsJbAo3h1FX4AIeLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrGNuAAoJEKeha0olJ0Nq9VUH/3yUH7yDgrJk3RQWchgCxBon
sP61AYhfx9nfNyV56hK1ygArxIV+6m8QMWoFiifwlruBFe4T0UqLFir06Hzlc1yR
tqzrRnOkjOGH/yXMaeDTPFxoHTFzg2rSHx85bWMwnjqibp5jT+Fj7sWEpum8VSe9
ejvJo6CduDF6RZnY4lnpC4p3Iqlv5HTR6UfLKLKv/xYXgjPK3Y6ZbjOeq2vjcDq3
LTPbau+VUJU44P9gsaS8LEZloXQXy60Xiej9jBEPP1wU9L/SdFgRkRVnXUcvNzNI
XRgQiLjMWgWPSi+LOexOj/LJf8QFFGS4lIEoiy8Glnp1EvjbL8FgVllJmfo4N5M=
=/RDN
-----END PGP SIGNATURE-----

--nqxfnt3QhmWOjcoBDsJbAo3h1FX4AIeLW--
