Received: from eggs.gnu.org ([2001:4830:134:3::10]:42575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cgDR0-0001Jm-GL
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:37:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cgDQw-0004Cg-C0
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:37:02 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cgDQv-0004CT-OX
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:36:58 -0500
Received: by mail-lf0-x244.google.com with SMTP id z127so9580899lfa.2
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 08:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20170221104256.5153-1-pbonzini@redhat.com>
	<20170221104256.5153-2-pbonzini@redhat.com>
	<aa2a3bf2-3c72-7682-c950-be580f8f5dd3@redhat.com>
In-Reply-To: <aa2a3bf2-3c72-7682-c950-be580f8f5dd3@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Feb 2017 16:36:44 +0000
Message-ID: <CAJ+F1CLPGGmwnEzo9EJWu7MuuB5g7VCsVtL5sLWa_HE1O96oUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: den@openvz.org, anton.nefedov@virtuozzo.com

Hi

On Tue, Feb 21, 2017 at 4:17 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

>
>
> On 21/02/2017 11:42, Paolo Bonzini wrote:
> > The functions simplify the handling of QOM properties whose type
> > is a QAPI struct.  They go through a QObject just like the other
> > functions that access a QOM property through its C type.
> >
> > Like QAPI_CLONE, the functions are wrapped by macros that take a
> > QAPI type name and use it to build the name of a visitor function.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  include/qom/qom-qobject.h               |  68 ++++++++++++
> >  qom/qom-qobject.c                       |  49 +++++++++
> >  tests/Makefile.include                  |   2 +-
> >  tests/check-qom-proplist.c              | 185
> +++++++++++++++++++++++++++++++-
> >  tests/qapi-schema/qapi-schema-test.json |   8 ++
> >  5 files changed, 309 insertions(+), 3 deletions(-)
>
> Missing hunk:
>
> diff --git a/tests/qapi-schema/qapi-schema-test.out
> b/tests/qapi-schema/qapi-schema-test.out
> index bc8d496..d3a2990 100644
> --- a/tests/qapi-schema/qapi-schema-test.out
> +++ b/tests/qapi-schema/qapi-schema-test.out
> @@ -107,6 +107,9 @@ object UserDefOne
>      base UserDefZero
>      member string: str optional=3DFalse
>      member enum1: EnumOne optional=3DTrue
> +object UserDefOneMore
> +    base UserDefOne
> +    member boolean: bool optional=3DFalse
>  object UserDefOptions
>      member i64: intList optional=3DTrue
>      member u64: uint64List optional=3DTrue
> @@ -283,6 +286,9 @@ for testing override of default naming heuristic
>  doc symbol=3DUserDefOne expr=3D('struct', 'UserDefOne')
>      body=3D
>  for testing nested structs
> +doc symbol=3DUserDefOneMore expr=3D('struct', 'UserDefOneMore')
> +    body=3D
> +for testing nested structs
>  doc symbol=3DEnumOne expr=3D('enum', 'EnumOne')
>  doc symbol=3DUserDefZero expr=3D('struct', 'UserDefZero')
>  doc symbol=3DUserDefTwoDictDict expr=3D('struct', 'UserDefTwoDictDict')
>
> Paolo
>
> > diff --git a/include/qom/qom-qobject.h b/include/qom/qom-qobject.h
> > index 77cd717..ff1d307 100644
> > --- a/include/qom/qom-qobject.h
> > +++ b/include/qom/qom-qobject.h
> > @@ -39,4 +39,72 @@ struct QObject *object_property_get_qobject(Object
> *obj, const char *name,
> >  void object_property_set_qobject(Object *obj, struct QObject *qobj,
> >                                   const char *name, struct Error **errp=
);
> >
> > +/**
> > + * object_property_get_ptr:
> > + * @obj: the object
> > + * @ptr: The C struct that will be written to the property.
>

drop that line


> > + * @name: the name of the property
> > + * @visit_type: the visitor function for @ptr's type.
> > + * @errp: returns an error if this function fails
> > + *
> > + * Return: the value of an object's property, unmarshaled into a C
> object
> > + * through a QAPI type visitor, or NULL if an error occurs.
> > + */
> > +void *object_property_get_ptr(Object *obj, const char *name,
> > +                              void (*visit_type)(Visitor *, const char
> *,
> > +                                                 void **, Error **),
> > +                              Error **errp);
> > +
> > +/**
> > + * OBJECT_PROPERTY_GET_PTR:
> > + * @obj: the object
> > + * @ptr: The C struct that will be written to the property.
>

drop that line


> > + * @name: the name of the property
> > + * @type: the name of the C struct type pointed to by @ptr.
> > + * @errp: returns an error if this function fails
> > + *
> > + * Return: the value of an object's property, unmarshaled into a C
> object
> > + * through a QAPI type visitor, or NULL if an error occurs.
> > + */
> > +#define OBJECT_PROPERTY_GET_PTR(obj, name, type, errp)
>     \
> > +    ((type *)
>      \
> > +     object_property_get_ptr(obj, name,
>      \
> > +                             (void (*)(Visitor *, const char *,
> void**,     \
> > +                                       Error **))visit_type_ ## type,
>      \
> > +                             errp))
> > +
> > +/**
> > + * object_property_set_ptr:
> > + * @obj: the object
> > + * @ptr: The C struct that will be written to the property.
> > + * @name: the name of the property
> > + * @visit_type: the visitor function for @ptr's type.
> > + * @errp: returns an error if this function fails
> > + *
> > + * Sets an object's property to a C object's value, using a QAPI
> > + * type visitor to marshal the C struct into the object.
> > + */
> > +void object_property_set_ptr(Object *obj, void *ptr, const char *name,
> > +                             void (*visit_type)(Visitor *, const char =
*,
> > +                                                void **, Error **),
> > +                             Error **errp);
> > +
> > +/**
> > + * OBJECT_PROPERTY_SET_PTR:
> > + * @obj: the object
> > + * @ptr: The C struct that will be written to the property.
> > + * @name: the name of the property
> > + * @type: the name of the C struct type pointed to by @ptr.
> > + * @errp: returns an error if this function fails
> > + *
> > + * Sets an object's property to a C object's value, using a QAPI
> > + * type visitor to marshal the C struct into the object.
> > + */
> > +#define OBJECT_PROPERTY_SET_PTR(obj, ptr, name, type, errp)
>      \
> > +    object_property_set_ptr(obj, ptr + type_check(type, typeof(*ptr)),
>     \
> > +                            name,
>      \
> > +                            (void (*)(Visitor *, const char *, void**,
>     \
> > +                                      Error **))visit_type_ ## type,
>     \
> > +                            errp)
> > +
> >  #endif
> > diff --git a/qom/qom-qobject.c b/qom/qom-qobject.c
> > index 447e4a0..09a12e0 100644
> > --- a/qom/qom-qobject.c
> > +++ b/qom/qom-qobject.c
> > @@ -44,3 +44,52 @@ QObject *object_property_get_qobject(Object *obj,
> const char *name,
> >      visit_free(v);
> >      return ret;
> >  }
> > +
> > +void object_property_set_ptr(Object *obj, void *ptr, const char *name,
> > +                             void (*visit_type)(Visitor *, const char
> *, void **, Error **),
> > +                             Error **errp)
> > +{
> > +    Error *local_err =3D NULL;
> > +    QObject *ret =3D NULL;
> > +    Visitor *v;
> > +    v =3D qobject_output_visitor_new(&ret);
> > +    visit_type(v, name, &ptr, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        visit_free(v);
> > +        return;
> > +    }
> > +    visit_complete(v, &ret);
> > +    visit_free(v);
> > +
> > +    /* Do not use object_property_set_qobject until we switch it
> > +     * to use qobject_input_visitor_new in strict mode.  See the
> > +     * /qom/proplist/get-set-ptr/contravariant unit test.
> > +     */
> > +    v =3D qobject_input_visitor_new(ret, true);
> > +    object_property_set(obj, v, name, errp);
> > +    visit_free(v);
> > +    qobject_decref(ret);
> > +}
> > +
> > +void *object_property_get_ptr(Object *obj, const char *name,
> > +                              void (*visit_type)(Visitor *, const char
> *, void **, Error **),
> > +                              Error **errp)
> > +{
> > +    QObject *ret;
> > +    Visitor *v;
> > +    void *ptr =3D NULL;
> > +
> > +    ret =3D object_property_get_qobject(obj, name, errp);
> > +    if (!ret) {
> > +        return NULL;
> > +    }
> > +
> > +    /* Do not enable strict mode to allow passing covariant
> > +     * data types.
> > +     */
> > +    v =3D qobject_input_visitor_new(ret, false);
> > +    visit_type(v, name, &ptr, errp);
> > +    qobject_decref(ret);
>

visit_free(v) ?


> > +    return ptr;
> > +}
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 634394a..9de910b 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -515,7 +515,7 @@ tests/check-qfloat$(EXESUF): tests/check-qfloat.o
> $(test-util-obj-y)
> >  tests/check-qnull$(EXESUF): tests/check-qnull.o $(test-util-obj-y)
> >  tests/check-qjson$(EXESUF): tests/check-qjson.o $(test-util-obj-y)
> >  tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o
> $(test-qom-obj-y)
> > -tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o
> $(test-qom-obj-y)
> > +tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o
> $(test-qom-obj-y) $(test-qapi-obj-y)
> >
> >  tests/test-char$(EXESUF): tests/test-char.o qemu-timer.o \
> >       $(test-util-obj-y) $(qtest-obj-y) $(test-block-obj-y)
> $(chardev-obj-y)
> > diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
> > index a16cefc..e0ad880 100644
> > --- a/tests/check-qom-proplist.c
> > +++ b/tests/check-qom-proplist.c
> > @@ -22,8 +22,11 @@
> >
> >  #include "qapi/error.h"
> >  #include "qom/object.h"
> > +#include "qom/qom-qobject.h"
> >  #include "qemu/module.h"
> >
> > +#include "test-qapi-types.h"
> > +#include "test-qapi-visit.h"
> >
> >  #define TYPE_DUMMY "qemu-dummy"
> >
> > @@ -56,6 +59,8 @@ struct DummyObject {
> >      bool bv;
> >      DummyAnimal av;
> >      char *sv;
> > +
> > +    UserDefOne *qv;
> >  };
> >
> >  struct DummyObjectClass {
> > @@ -120,12 +125,42 @@ static char *dummy_get_sv(Object *obj,
> >
> >  static void dummy_init(Object *obj)
> >  {
> > +    DummyObject *dobj =3D DUMMY_OBJECT(obj);
> > +
> >      object_property_add_bool(obj, "bv",
> >                               dummy_get_bv,
> >                               dummy_set_bv,
> >                               NULL);
> > +    dobj->qv =3D g_new0(UserDefOne, 1);
> > +    dobj->qv->string =3D g_strdup("dummy string");
> > +}
> > +
> > +
> > +static void dummy_get_qv(Object *obj, Visitor *v, const char *name,
> > +                         void *opaque, Error **errp)
> > +{
> > +    DummyObject *dobj =3D DUMMY_OBJECT(obj);
> > +
> > +    visit_type_UserDefOne(v, name, &dobj->qv, errp);
> >  }
> >
> > +static void dummy_set_qv(Object *obj, Visitor *v, const char *name,
> > +                         void *opaque, Error **errp)
> > +{
> > +    DummyObject *dobj =3D DUMMY_OBJECT(obj);
> > +    UserDefOne *qv =3D NULL;
> > +    Error *local_err =3D NULL;
> > +
> > +    visit_type_UserDefOne(v, name, &qv, &local_err);
> > +    if (local_err) {
> > +        g_assert(qv =3D=3D NULL);
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    qapi_free_UserDefOne(dobj->qv);
> > +    dobj->qv =3D qv;
> > +}
> >
> >  static void dummy_class_init(ObjectClass *cls, void *data)
> >  {
> > @@ -143,6 +178,13 @@ static void dummy_class_init(ObjectClass *cls, voi=
d
> *data)
> >                                     dummy_get_av,
> >                                     dummy_set_av,
> >                                     NULL);
> > +    object_class_property_add(cls, "qv",
> > +                              "UserDefOne",
> > +                              dummy_get_qv,
> > +                              dummy_set_qv,
> > +                              NULL,
> > +                              NULL,
> > +                              NULL);
> >  }
> >
> >
> > @@ -151,9 +193,9 @@ static void dummy_finalize(Object *obj)
> >      DummyObject *dobj =3D DUMMY_OBJECT(obj);
> >
> >      g_free(dobj->sv);
> > +    qapi_free_UserDefOne(dobj->qv);
> >  }
> >
> > -
> >  static const TypeInfo dummy_info =3D {
> >      .name          =3D TYPE_DUMMY,
> >      .parent        =3D TYPE_OBJECT,
> > @@ -473,7 +515,8 @@ static void test_dummy_iterator(void)
> >
> >      ObjectProperty *prop;
> >      ObjectPropertyIterator iter;
> > -    bool seenbv =3D false, seensv =3D false, seenav =3D false, seentyp=
e;
> > +    bool seenbv =3D false, seensv =3D false, seenav =3D false;
> > +    bool seenqv =3D false, seentype =3D false;
> >
> >      object_property_iter_init(&iter, OBJECT(dobj));
> >      while ((prop =3D object_property_iter_next(&iter))) {
> > @@ -483,6 +526,8 @@ static void test_dummy_iterator(void)
> >              seensv =3D true;
> >          } else if (g_str_equal(prop->name, "av")) {
> >              seenav =3D true;
> > +        } else if (g_str_equal(prop->name, "qv")) {
> > +            seenqv =3D true;
> >          } else if (g_str_equal(prop->name, "type")) {
> >              /* This prop comes from the base Object class */
> >              seentype =3D true;
> > @@ -494,6 +539,7 @@ static void test_dummy_iterator(void)
> >      g_assert(seenbv);
> >      g_assert(seenav);
> >      g_assert(seensv);
> > +    g_assert(seenqv);
> >      g_assert(seentype);
> >
> >      object_unparent(OBJECT(dobj));
> > @@ -513,6 +559,137 @@ static void test_dummy_delchild(void)
> >      object_unparent(OBJECT(dev));
> >  }
> >
> > +static void test_dummy_get_set_ptr_struct(void)
> > +{
> > +    DummyObject *dobj =3D DUMMY_OBJECT(object_new(TYPE_DUMMY));
> > +    Error *local_err =3D NULL;
> > +    const char *s =3D "my other dummy string";
> > +    UserDefOne *ret;
> > +    UserDefOne val;
> > +
> > +    ret =3D OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
> > +                                  UserDefOne, &local_err);
> > +    g_assert(!local_err);
> > +
> > +    g_assert_cmpint(ret->integer, =3D=3D, 0);
> > +    g_assert_cmpstr(ret->string, =3D=3D, "dummy string");
> > +    g_assert(!ret->has_enum1);
> > +    qapi_free_UserDefOne(ret);
> > +
> > +    val.integer =3D 42;
> > +    val.string =3D g_strdup(s);
> > +    val.has_enum1 =3D true;
> > +    val.enum1 =3D ENUM_ONE_VALUE1;
> > +    OBJECT_PROPERTY_SET_PTR(OBJECT(dobj), &val, "qv",
> > +                            UserDefOne, &local_err);
> > +    g_assert(!local_err);
> > +
> > +    ret =3D OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
> > +                                  UserDefOne, &local_err);
> > +    g_assert(!local_err);
> > +
> > +    g_assert_cmpint(ret->integer, =3D=3D, val.integer);
> > +    g_assert_cmpstr(ret->string, =3D=3D, val.string);
> > +    g_assert(ret->has_enum1);
> > +    g_assert_cmpint(ret->enum1, =3D=3D, val.enum1);
> > +    g_free(val.string);
> > +    qapi_free_UserDefOne(ret);
> > +}
> > +
> > +static void test_dummy_get_set_ptr_contravariant(void)
> > +{
> > +    DummyObject *dobj =3D DUMMY_OBJECT(object_new(TYPE_DUMMY));
> > +    Error *local_err =3D NULL;
> > +    UserDefOneMore *ret;
> > +    UserDefOneMore val;
> > +
> > +    /* You cannot retrieve a contravariant (subclass) type... */
> > +    ret =3D OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
> > +                                  UserDefOneMore, &local_err);
> > +    g_assert(local_err);
> > +    g_assert(!ret);
> > +    error_free(local_err);
> > +    local_err =3D NULL;
> > +
> > +    /* And you cannot set one either.  */
> > +    val.integer =3D 42;
> > +    val.string =3D g_strdup("unused");
> > +    val.has_enum1 =3D false;
> > +    val.boolean =3D false;
> > +
> > +    OBJECT_PROPERTY_SET_PTR(OBJECT(dobj), &val, "qv",
> > +                            UserDefOneMore, &local_err);
> > +    g_assert(local_err);
> > +}
> > +
> > +static void test_dummy_get_set_ptr_covariant(void)
> > +{
> > +    DummyObject *dobj =3D DUMMY_OBJECT(object_new(TYPE_DUMMY));
> > +    Error *local_err =3D NULL;
> > +    UserDefZero *ret;
> > +    UserDefZero val;
> > +
> > +    /* You can retrieve a covariant (superclass) type... */
> > +    ret =3D OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
> > +                                  UserDefZero, &local_err);
> > +    g_assert(!local_err);
> > +
> > +    g_assert_cmpint(ret->integer, =3D=3D, 0);
> > +    qapi_free_UserDefZero(ret);
> > +
> > +    /* But you cannot set one.  */
> > +    val.integer =3D 42;
> > +    OBJECT_PROPERTY_SET_PTR(OBJECT(dobj), &val, "qv",
> > +                            UserDefZero, &local_err);
> > +    g_assert(local_err);
> > +    error_free(local_err);
> > +    local_err =3D NULL;
> > +
> > +    /* Test that the property has not been modified at all */
> > +    ret =3D OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
> > +                                  UserDefZero, &local_err);
> > +    g_assert(!local_err);
> > +
> > +    g_assert_cmpint(ret->integer, =3D=3D, 0);
> > +    qapi_free_UserDefZero(ret);
> > +}
> > +
> > +static void test_dummy_get_set_ptr_error(void)
> > +{
> > +    DummyObject *dobj =3D DUMMY_OBJECT(object_new(TYPE_DUMMY));
> > +    Error *local_err =3D NULL;
> > +    const char *s =3D "my other dummy string";
> > +    UserDefOne *ret;
> > +    UserDefOne val;
> > +
> > +    ret =3D OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "blah",
> > +                                  UserDefOne, &local_err);
> > +    g_assert(local_err);
> > +    g_assert(!ret);
> > +    error_free(local_err);
> > +    local_err =3D NULL;
> > +
> > +    val.integer =3D 42;
> > +    val.string =3D g_strdup(s);
> > +    val.has_enum1 =3D true;
> > +    val.enum1 =3D 100;
> > +    OBJECT_PROPERTY_SET_PTR(OBJECT(dobj), &val, "qv",
> > +                            UserDefOne, &local_err);
> > +    g_assert(local_err);
> > +    error_free(local_err);
> > +    local_err =3D NULL;
> > +
> > +    ret =3D OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
> > +                                  UserDefOne, &local_err);
> > +    g_assert(!local_err);
> > +
> > +    /* Test that the property has not been modified at all */
> > +    g_assert_cmpint(ret->integer, =3D=3D, 0);
> > +    g_assert_cmpstr(ret->string, =3D=3D, "dummy string");
> > +    g_assert(!ret->has_enum1);
> > +    qapi_free_UserDefOne(ret);
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >      g_test_init(&argc, &argv, NULL);
> > @@ -530,5 +707,9 @@ int main(int argc, char **argv)
> >      g_test_add_func("/qom/proplist/iterator", test_dummy_iterator);
> >      g_test_add_func("/qom/proplist/delchild", test_dummy_delchild);
> >
> > +    g_test_add_func("/qom/proplist/get-set-ptr/struct",
> test_dummy_get_set_ptr_struct);
> > +    g_test_add_func("/qom/proplist/get-set-ptr/error",
> test_dummy_get_set_ptr_error);
> > +    g_test_add_func("/qom/proplist/get-set-ptr/covariant",
> test_dummy_get_set_ptr_covariant);
> > +    g_test_add_func("/qom/proplist/get-set-ptr/contravariant",
> test_dummy_get_set_ptr_contravariant);
> >      return g_test_run();
> >  }
> > diff --git a/tests/qapi-schema/qapi-schema-test.json
> b/tests/qapi-schema/qapi-schema-test.json
> > index f4d8cc4..4e3f6ff 100644
> > --- a/tests/qapi-schema/qapi-schema-test.json
> > +++ b/tests/qapi-schema/qapi-schema-test.json
> > @@ -91,6 +91,14 @@
> >              '*enum1': 'EnumOne' } }   # intentional forward reference
> >
> >  ##
> > +# @UserDefOneMore:
> > +# for testing nested structs
> > +##
> > +{ 'struct': 'UserDefOneMore',
> > +  'base': 'UserDefOne',
> > +  'data': { 'boolean': 'bool' } }
> > +
> > +##
> >  # @EnumOne:
> >  ##
> >  { 'enum': 'EnumOne',
> >
>
> --
Marc-Andr=C3=A9 Lureau
