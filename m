Received: from eggs.gnu.org ([2001:4830:134:3::10]:49920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chHGp-0003Tx-Cw
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chHGm-00017M-8y
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:54:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1chHGl-00016x-VX
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:54:52 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D84EC4E4D1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 14:54:51 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170222180423.26571-1-pbonzini@redhat.com>
	<20170222180423.26571-2-pbonzini@redhat.com>
Date: Fri, 24 Feb 2017 15:54:48 +0100
In-Reply-To: <20170222180423.26571-2-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Wed, 22 Feb 2017 19:04:21 +0100")
Message-ID: <87d1e7abbb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

Paolo Bonzini <pbonzini@redhat.com> writes:

> The functions simplify the handling of QOM properties whose type
> is a QAPI struct.  They go through a QObject just like the other
> functions that access a QOM property through its C type.
>
> Like QAPI_CLONE, the functions are wrapped by macros that take a
> QAPI type name and use it to build the name of a visitor function.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qom/qom-qobject.h               |  68 +++++++++++-
>  qom/qom-qobject.c                       |  52 ++++++++++
>  tests/Makefile.include                  |   2 +-
>  tests/check-qom-proplist.c              | 177 +++++++++++++++++++++++++++++++-
>  tests/qapi-schema/qapi-schema-test.json |   8 ++
>  tests/qapi-schema/qapi-schema-test.out  |   6 ++
>  6 files changed, 309 insertions(+), 4 deletions(-)
>
> diff --git a/include/qom/qom-qobject.h b/include/qom/qom-qobject.h
> index 77cd717..fab9c4f 100644
> --- a/include/qom/qom-qobject.h
> +++ b/include/qom/qom-qobject.h
> @@ -30,7 +30,7 @@ struct QObject *object_property_get_qobject(Object *obj, const char *name,
>  /**
>   * object_property_set_qobject:
>   * @obj: the object
> - * @ret: The value that will be written to the property.
> + * @ret: The value that will be written to the property
>   * @name: the name of the property
>   * @errp: returns an error if this function fails
>   *
> @@ -39,4 +39,70 @@ struct QObject *object_property_get_qobject(Object *obj, const char *name,
>  void object_property_set_qobject(Object *obj, struct QObject *qobj,
>                                   const char *name, struct Error **errp);
>  
> +/**
> + * object_property_get_ptr:
> + * @obj: the object
> + * @name: the name of the property
> + * @visit_type: the visitor function for the returned object
> + * @errp: returns an error if this function fails
> + *
> + * Return: the value of an object's property, unmarshaled into a C object
> + * through a QAPI type visitor, or NULL if an error occurs.
> + */
> +void *object_property_get_ptr(Object *obj, const char *name,
> +                              void (*visit_type)(Visitor *, const char *,
> +                                                 void **, Error **),
> +                              Error **errp);
> +
> +/**
> + * OBJECT_PROPERTY_GET_PTR:
> + * @obj: the object
> + * @name: the name of the property
> + * @type: the name of the C struct type that is returned
> + * @errp: returns an error if this function fails
> + *
> + * Return: the value of an object's property, unmarshaled into a C object
> + * through a QAPI type visitor, or NULL if an error occurs.
> + */
> +#define OBJECT_PROPERTY_GET_PTR(obj, name, type, errp)                      \
> +    ((type *)                                                               \
> +     object_property_get_ptr(obj, name,                                     \
> +                             (void (*)(Visitor *, const char *, void**,     \
> +                                       Error **))visit_type_ ## type,       \
> +                             errp))
> +
> +/**
> + * object_property_set_ptr:
> + * @obj: the object
> + * @ptr: The C struct that will be written to the property
> + * @name: the name of the property
> + * @visit_type: the visitor function for @ptr's type
> + * @errp: returns an error if this function fails
> + *
> + * Sets an object's property to a C object's value, using a QAPI
> + * type visitor to marshal the C struct into the property value.
> + */
> +void object_property_set_ptr(Object *obj, void *ptr, const char *name,
> +                             void (*visit_type)(Visitor *, const char *,
> +                                                void **, Error **),
> +                             Error **errp);
> +
> +/**
> + * OBJECT_PROPERTY_SET_PTR:
> + * @obj: the object
> + * @ptr: The C struct that will be written to the property
> + * @name: the name of the property
> + * @type: the name of the C struct type pointed to by @ptr
> + * @errp: returns an error if this function fails
> + *
> + * Sets an object's property to a C object's value, using a QAPI
> + * type visitor to marshal the C struct into the property value.
> + */
> +#define OBJECT_PROPERTY_SET_PTR(obj, ptr, name, type, errp)                 \
> +    object_property_set_ptr(obj, ptr + type_check(type, typeof(*ptr)),      \
> +                            name,                                           \
> +                            (void (*)(Visitor *, const char *, void**,      \
> +                                      Error **))visit_type_ ## type,        \
> +                            errp)

Same function type punning as we use for QAPI clone.  I don't have
better ideas.

> +
>  #endif
> diff --git a/qom/qom-qobject.c b/qom/qom-qobject.c
> index 447e4a0..d4675be 100644
> --- a/qom/qom-qobject.c
> +++ b/qom/qom-qobject.c
> @@ -44,3 +44,55 @@ QObject *object_property_get_qobject(Object *obj, const char *name,
>      visit_free(v);
>      return ret;
>  }
> +
> +void object_property_set_ptr(Object *obj, void *ptr, const char *name,
> +                             void (*visit_type)(Visitor *, const char *,
> +                                                void **, Error **),
> +                             Error **errp)
> +{
> +    Error *local_err = NULL;
> +    QObject *ret = NULL;
> +    Visitor *v;
> +    v = qobject_output_visitor_new(&ret);
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
> +     */

So no conflict with my "[PATCH 15/21] qom: Make
object_property_set_qobject()'s input visitor strict".

> +    v = qobject_input_visitor_new(ret, true);
> +    object_property_set(obj, v, name, errp);
> +    visit_free(v);
> +    qobject_decref(ret);
> +}
> +
> +void *object_property_get_ptr(Object *obj, const char *name,
> +                              void (*visit_type)(Visitor *, const char *,
> +                                                 void **, Error **),
> +                              Error **errp)
> +{
> +    QObject *ret;
> +    Visitor *v;
> +    void *ptr = NULL;
> +
> +    ret = object_property_get_qobject(obj, name, errp);
> +    if (!ret) {
> +        return NULL;
> +    }
> +
> +    /* Do not enable strict mode to allow passing covariant
> +     * data types.
> +     */
> +    v = qobject_input_visitor_new(ret, false);

Hmm, the function contract only says "unmarshaled into a C object
through a QAPI type visitor":

   /**
    * object_property_get_ptr:
    * @obj: the object
    * @name: the name of the property
    * @visit_type: the visitor function for the returned object
    * @errp: returns an error if this function fails
    *
    * Return: the value of an object's property, unmarshaled into a C object
    * through a QAPI type visitor, or NULL if an error occurs.
    */

No word about covariant / contravariant.  Should it be a bit more
verbose?

> +    visit_type(v, name, &ptr, errp);
> +    qobject_decref(ret);
> +    visit_free(v);
> +    return ptr;
> +}

Going through QObject gets you duck typing.  More on that below.

> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index e60bb6c..1a1b6e2 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -519,7 +519,7 @@ tests/check-qfloat$(EXESUF): tests/check-qfloat.o $(test-util-obj-y)
>  tests/check-qnull$(EXESUF): tests/check-qnull.o $(test-util-obj-y)
>  tests/check-qjson$(EXESUF): tests/check-qjson.o $(test-util-obj-y)
>  tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test-qom-obj-y)
> -tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-qom-obj-y)
> +tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-qom-obj-y) $(test-qapi-obj-y)
>  
>  tests/test-char$(EXESUF): tests/test-char.o $(test-util-obj-y) $(qtest-obj-y) $(test-io-obj-y) $(chardev-obj-y)
>  tests/test-coroutine$(EXESUF): tests/test-coroutine.o $(test-block-obj-y)
> diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
> index a16cefc..1bf0320 100644
> --- a/tests/check-qom-proplist.c
> +++ b/tests/check-qom-proplist.c
> @@ -22,8 +22,11 @@
>  
>  #include "qapi/error.h"
>  #include "qom/object.h"
> +#include "qom/qom-qobject.h"
>  #include "qemu/module.h"
>  
> +#include "test-qapi-types.h"
> +#include "test-qapi-visit.h"
>  
>  #define TYPE_DUMMY "qemu-dummy"
>  
> @@ -56,6 +59,8 @@ struct DummyObject {
>      bool bv;
>      DummyAnimal av;
>      char *sv;
> +
> +    UserDefOne *qv;
>  };
>  
>  struct DummyObjectClass {
> @@ -120,12 +125,42 @@ static char *dummy_get_sv(Object *obj,
>  
>  static void dummy_init(Object *obj)
>  {
> +    DummyObject *dobj = DUMMY_OBJECT(obj);
> +
>      object_property_add_bool(obj, "bv",
>                               dummy_get_bv,
>                               dummy_set_bv,
>                               NULL);
> +    dobj->qv = g_new0(UserDefOne, 1);
> +    dobj->qv->string = g_strdup("dummy string");
> +}
> +
> +
> +static void dummy_get_qv(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
> +{
> +    DummyObject *dobj = DUMMY_OBJECT(obj);
> +
> +    visit_type_UserDefOne(v, name, &dobj->qv, errp);
>  }
>  
> +static void dummy_set_qv(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
> +{
> +    DummyObject *dobj = DUMMY_OBJECT(obj);
> +    UserDefOne *qv = NULL;
> +    Error *local_err = NULL;
> +
> +    visit_type_UserDefOne(v, name, &qv, &local_err);
> +    if (local_err) {
> +        g_assert(qv == NULL);
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    qapi_free_UserDefOne(dobj->qv);
> +    dobj->qv = qv;
> +}
>  
>  static void dummy_class_init(ObjectClass *cls, void *data)
>  {
> @@ -143,6 +178,13 @@ static void dummy_class_init(ObjectClass *cls, void *data)
>                                     dummy_get_av,
>                                     dummy_set_av,
>                                     NULL);
> +    object_class_property_add(cls, "qv",
> +                              "UserDefOne",
> +                              dummy_get_qv,
> +                              dummy_set_qv,
> +                              NULL,
> +                              NULL,
> +                              NULL);
>  }
>  
>  
> @@ -151,9 +193,9 @@ static void dummy_finalize(Object *obj)
>      DummyObject *dobj = DUMMY_OBJECT(obj);
>  
>      g_free(dobj->sv);
> +    qapi_free_UserDefOne(dobj->qv);
>  }
>  
> -
>  static const TypeInfo dummy_info = {
>      .name          = TYPE_DUMMY,
>      .parent        = TYPE_OBJECT,
> @@ -473,7 +515,8 @@ static void test_dummy_iterator(void)
>  
>      ObjectProperty *prop;
>      ObjectPropertyIterator iter;
> -    bool seenbv = false, seensv = false, seenav = false, seentype;
> +    bool seenbv = false, seensv = false, seenav = false;
> +    bool seenqv = false, seentype = false;
>  
>      object_property_iter_init(&iter, OBJECT(dobj));
>      while ((prop = object_property_iter_next(&iter))) {
> @@ -483,6 +526,8 @@ static void test_dummy_iterator(void)
>              seensv = true;
>          } else if (g_str_equal(prop->name, "av")) {
>              seenav = true;
> +        } else if (g_str_equal(prop->name, "qv")) {
> +            seenqv = true;
>          } else if (g_str_equal(prop->name, "type")) {
>              /* This prop comes from the base Object class */
>              seentype = true;
> @@ -494,6 +539,7 @@ static void test_dummy_iterator(void)
>      g_assert(seenbv);
>      g_assert(seenav);
>      g_assert(seensv);
> +    g_assert(seenqv);
>      g_assert(seentype);
>  
>      object_unparent(OBJECT(dobj));
> @@ -513,6 +559,129 @@ static void test_dummy_delchild(void)
>      object_unparent(OBJECT(dev));
>  }
>  
> +static void test_dummy_get_set_ptr_struct(void)
> +{
> +    DummyObject *dobj = DUMMY_OBJECT(object_new(TYPE_DUMMY));
> +    Error *local_err = NULL;
> +    const char *s = "my other dummy string";
> +    UserDefOne *ret;
> +    UserDefOne val;
> +
> +    ret = OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
> +                                  UserDefOne, &local_err);
> +    g_assert(!local_err);
> +
> +    g_assert_cmpint(ret->integer, ==, 0);
> +    g_assert_cmpstr(ret->string, ==, "dummy string");
> +    g_assert(!ret->has_enum1);
> +    qapi_free_UserDefOne(ret);
> +
> +    val.integer = 42;
> +    val.string = g_strdup(s);
> +    val.has_enum1 = true;
> +    val.enum1 = ENUM_ONE_VALUE1;
> +    OBJECT_PROPERTY_SET_PTR(OBJECT(dobj), &val, "qv",
> +                            UserDefOne, &local_err);
> +    g_assert(!local_err);
> +
> +    ret = OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
> +                                  UserDefOne, &local_err);
> +    g_assert(!local_err);
> +
> +    g_assert_cmpint(ret->integer, ==, val.integer);
> +    g_assert_cmpstr(ret->string, ==, val.string);
> +    g_assert(ret->has_enum1);
> +    g_assert_cmpint(ret->enum1, ==, val.enum1);
> +    g_free(val.string);
> +    qapi_free_UserDefOne(ret);
> +}

This test tests getting and setting the exact type (UserDefOne).

UserDef one has these members:

    integer: int
    string: str
    *enum1: EnumOne

> +
> +static void test_dummy_get_set_ptr_contravariant(void)
> +{
> +    DummyObject *dobj = DUMMY_OBJECT(object_new(TYPE_DUMMY));
> +    Error *local_err = NULL;
> +    UserDefOneMore *ret;
> +    UserDefOneMore val;
> +
> +    /* You cannot retrieve a contravariant (subclass) type... */
> +    ret = OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
> +                                  UserDefOneMore, &local_err);
> +    error_free_or_abort(&local_err);
> +    g_assert(!ret);
> +
> +    /* And you cannot set one either.  */
> +    val.integer = 42;
> +    val.string = g_strdup("unused");
> +    val.has_enum1 = false;
> +    val.boolean = false;
> +
> +    OBJECT_PROPERTY_SET_PTR(OBJECT(dobj), &val, "qv",
> +                            UserDefOneMore, &local_err);
> +    g_assert(local_err);
> +}

This one tests getting and setting UserDefOneMore, which has UserDefOne
as base.  Members:

    integer: int
    string: str
    *enum1: EnumOne
    boolean: bool

OBJECT_PROPERTY_GET_PTR() gets UserDefOne into UserDefOneMore.  It fails
because the output visitor populates only integer, string and enum1, and
the input visitor then chokes on missing boolean.

OBJECT_PROPERTY_SET_PTR() sets UserDefOne from UserDefOneMore.  It fails
because the output visitor populates integer, string, enum1 and boolean,
and the input visitor then chokes on boolean.

Because OBJECT_PROPERTY_{GET,SET}_PTR() go through QObject, the "is base
of" relationship doesn't actually matter.  All you need is the "right"
member names and values.

Note "values", not necessarily types!  Consider

    { 'struct': 'A', 'data': { 'i': 'int' } }
    { 'struct': 'B', 'data': { 'i': 'int8' } }

Converting from A via QObject to B using output and input visitor works
as long as the value of A.i is between -128 and 127.

This is what I meant by "duck typing".

Is it what you want?

Here's a non-ducky way to convert between QAPI types.  QAPI guarantees
that a pointer to a QAPI type is also valid as pointer to its base type.
One can do:

    UserDefOne *one;
    UserDefOneMore *more;

    *(UserDefOne *)more = *one; // get UserDefOne into UserDefOneMore
                                // members not in one are untouched
    *one = *(UserDefOne *)more; // set UserDefOne from UserDefOneMore
                                // members not in one are ignored

Would this technique suffice for your problem?

> +
> +static void test_dummy_get_set_ptr_covariant(void)
> +{
> +    DummyObject *dobj = DUMMY_OBJECT(object_new(TYPE_DUMMY));
> +    Error *local_err = NULL;
> +    UserDefZero *ret;
> +    UserDefZero val;
> +
> +    /* You can retrieve a covariant (superclass) type... */
> +    ret = OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
> +                                  UserDefZero, &local_err);
> +    g_assert(!local_err);
> +
> +    g_assert_cmpint(ret->integer, ==, 0);
> +    qapi_free_UserDefZero(ret);
> +
> +    /* But you cannot set one.  */
> +    val.integer = 42;
> +    OBJECT_PROPERTY_SET_PTR(OBJECT(dobj), &val, "qv",
> +                            UserDefZero, &local_err);
> +    error_free_or_abort(&local_err);
> +
> +    /* Test that the property has not been modified at all */
> +    ret = OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
> +                                  UserDefZero, &local_err);
> +    g_assert(!local_err);
> +
> +    g_assert_cmpint(ret->integer, ==, 0);
> +    qapi_free_UserDefZero(ret);
> +}

This one tests getting and setting UserDefZero, which is UserDefOne's
base (but that doesn't matter).  Members:

    integer

OBJECT_PROPERTY_GET_PTR() gets UserDefOne into UserDefZero.  It succeeds
because the output visitor again populates integer, string and enum1,
and the (non-strict) input visitor ignores string and enum1.

OBJECT_PROPERTY_SET_PTR() sets UserDefOne from UserDefZero.  It fails
because the output visitor populates only integer, and the input visitor
then chokes on missing string and boolean.

The assymetry is between this and the previous test is a bit odd.

> +
> +static void test_dummy_get_set_ptr_error(void)
> +{
> +    DummyObject *dobj = DUMMY_OBJECT(object_new(TYPE_DUMMY));
> +    Error *local_err = NULL;
> +    const char *s = "my other dummy string";
> +    UserDefOne *ret;
> +    UserDefOne val;
> +
> +    ret = OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "blah",
> +                                  UserDefOne, &local_err);
> +    error_free_or_abort(&local_err);
> +    g_assert(!ret);
> +
> +    val.integer = 42;
> +    val.string = g_strdup(s);
> +    val.has_enum1 = true;
> +    val.enum1 = 100;
> +    OBJECT_PROPERTY_SET_PTR(OBJECT(dobj), &val, "qv",
> +                            UserDefOne, &local_err);
> +    error_free_or_abort(&local_err);
> +
> +    ret = OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
> +                                  UserDefOne, &local_err);
> +    g_assert(!local_err);
> +
> +    /* Test that the property has not been modified at all */
> +    g_assert_cmpint(ret->integer, ==, 0);
> +    g_assert_cmpstr(ret->string, ==, "dummy string");
> +    g_assert(!ret->has_enum1);
> +    qapi_free_UserDefOne(ret);
> +}

Not immediately obvious what exactly this one tests.  Totally different
types?

> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> @@ -530,5 +699,9 @@ int main(int argc, char **argv)
>      g_test_add_func("/qom/proplist/iterator", test_dummy_iterator);
>      g_test_add_func("/qom/proplist/delchild", test_dummy_delchild);
>  
> +    g_test_add_func("/qom/proplist/get-set-ptr/struct", test_dummy_get_set_ptr_struct);
> +    g_test_add_func("/qom/proplist/get-set-ptr/error", test_dummy_get_set_ptr_error);
> +    g_test_add_func("/qom/proplist/get-set-ptr/covariant", test_dummy_get_set_ptr_covariant);
> +    g_test_add_func("/qom/proplist/get-set-ptr/contravariant", test_dummy_get_set_ptr_contravariant);
>      return g_test_run();
>  }
> diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
> index f4d8cc4..4e3f6ff 100644
> --- a/tests/qapi-schema/qapi-schema-test.json
> +++ b/tests/qapi-schema/qapi-schema-test.json
> @@ -91,6 +91,14 @@
>              '*enum1': 'EnumOne' } }   # intentional forward reference
>  
>  ##
> +# @UserDefOneMore:
> +# for testing nested structs
> +##
> +{ 'struct': 'UserDefOneMore',
> +  'base': 'UserDefOne',
> +  'data': { 'boolean': 'bool' } }

I guess you need the chain 'UserDefZero' base of 'UserDefOne' base of
'UserDefOneMore'.

The naming in qapi-schema-test.json have become... suboptimal.

> +
> +##
>  # @EnumOne:
>  ##
>  { 'enum': 'EnumOne',
> diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
> index bc8d496..d3a2990 100644
> --- a/tests/qapi-schema/qapi-schema-test.out
> +++ b/tests/qapi-schema/qapi-schema-test.out
> @@ -107,6 +107,9 @@ object UserDefOne
>      base UserDefZero
>      member string: str optional=False
>      member enum1: EnumOne optional=True
> +object UserDefOneMore
> +    base UserDefOne
> +    member boolean: bool optional=False
>  object UserDefOptions
>      member i64: intList optional=True
>      member u64: uint64List optional=True
> @@ -283,6 +286,9 @@ for testing override of default naming heuristic
>  doc symbol=UserDefOne expr=('struct', 'UserDefOne')
>      body=
>  for testing nested structs
> +doc symbol=UserDefOneMore expr=('struct', 'UserDefOneMore')
> +    body=
> +for testing nested structs
>  doc symbol=EnumOne expr=('enum', 'EnumOne')
>  doc symbol=UserDefZero expr=('struct', 'UserDefZero')
>  doc symbol=UserDefTwoDictDict expr=('struct', 'UserDefTwoDictDict')
