Received: from eggs.gnu.org ([2001:4830:134:3::10]:60207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1chHoM-0005xY-HK
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1chHoI-0007Y8-Gz
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:29:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1chHoI-0007Xv-88
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:29:30 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27C81C04BD4F
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 15:29:30 +0000 (UTC)
References: <20170222180423.26571-1-pbonzini@redhat.com>
	<20170222180423.26571-2-pbonzini@redhat.com>
	<87d1e7abbb.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <09c6aaf5-0575-0445-b8bc-400c026a8a68@redhat.com>
Date: Fri, 24 Feb 2017 16:29:27 +0100
MIME-Version: 1.0
In-Reply-To: <87d1e7abbb.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com



On 24/02/2017 15:54, Markus Armbruster wrote:
>> +    /* Do not use object_property_set_qobject until we switch it
>> +     * to use qobject_input_visitor_new in strict mode.  See the
>> +     * /qom/proplist/get-set-ptr/contravariant unit test.
>> +     */
>=20
> So no conflict with my "[PATCH 15/21] qom: Make
> object_property_set_qobject()'s input visitor strict".

No, and in fact this comment would be an example of why that patch is
good.  With 15/21 we could just use object_property_set_qobject.

> Here's a non-ducky way to convert between QAPI types.  QAPI guarantees
> that a pointer to a QAPI type is also valid as pointer to its base type=
.
> One can do:
>=20
>     UserDefOne *one;
>     UserDefOneMore *more;
>=20
>     *(UserDefOne *)more =3D *one; // get UserDefOne into UserDefOneMore
>                                 // members not in one are untouched
>     *one =3D *(UserDefOne *)more; // set UserDefOne from UserDefOneMore
>                                 // members not in one are ignored
>=20
> Would this technique suffice for your problem?

I am not sure.  What I'm trying to do here is to keep backwards
compatibility in case a device provides UserDefOneMore for a well-known
property name, and another device provides UserDefOneAnother.  As long
as all devices provide the same (duck-typed) base class, things work.

Maybe the right thing to do would be to define a union, but I wasn't
sure it was possible to do that in a fully backwards compatible way (can
you define a union where the discriminator is optional, for example?).

>> +
>> +static void test_dummy_get_set_ptr_covariant(void)
>> +{
>> +    DummyObject *dobj =3D DUMMY_OBJECT(object_new(TYPE_DUMMY));
>> +    Error *local_err =3D NULL;
>> +    UserDefZero *ret;
>> +    UserDefZero val;
>> +
>> +    /* You can retrieve a covariant (superclass) type... */
>> +    ret =3D OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
>> +                                  UserDefZero, &local_err);
>> +    g_assert(!local_err);
>> +
>> +    g_assert_cmpint(ret->integer, =3D=3D, 0);
>> +    qapi_free_UserDefZero(ret);
>> +
>> +    /* But you cannot set one.  */
>> +    val.integer =3D 42;
>> +    OBJECT_PROPERTY_SET_PTR(OBJECT(dobj), &val, "qv",
>> +                            UserDefZero, &local_err);
>> +    error_free_or_abort(&local_err);
>> +
>> +    /* Test that the property has not been modified at all */
>> +    ret =3D OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
>> +                                  UserDefZero, &local_err);
>> +    g_assert(!local_err);
>> +
>> +    g_assert_cmpint(ret->integer, =3D=3D, 0);
>> +    qapi_free_UserDefZero(ret);
>> +}
> This one tests getting and setting UserDefZero, which is UserDefOne's
> base (but that doesn't matter).  Members:
>=20
>     integer
>=20
> OBJECT_PROPERTY_GET_PTR() gets UserDefOne into UserDefZero.  It succeed=
s
> because the output visitor again populates integer, string and enum1,
> and the (non-strict) input visitor ignores string and enum1.
>=20
> OBJECT_PROPERTY_SET_PTR() sets UserDefOne from UserDefZero.  It fails
> because the output visitor populates only integer, and the input visito=
r
> then chokes on missing string and boolean.
>=20
> The assymetry is between this and the previous test is a bit odd.

That's true, but it makes sense I think; unlike OOP languages we don't
have a QAPI equivalent of virtual methods, which is what makes it useful
to have contravariant arguments (i.e. passing an Apple* to a food(Meal*)
method).

If you're setting UserDefOne from UserDefOneMore, some of the values are
going to be lost.  Presumably there was a reason why you used
UserDefOneMore, and therefore an error is the safe bet.

If you're getting UserDefOne from UserDefOneMore, some of the values are
going to be lost.  However, it's reasonable that you didn't even know
that UserDefOneMore existed, which makes it sensible to allow reading
into a covariant type.

>> +
>> +static void test_dummy_get_set_ptr_error(void)
>> +{
>> +    DummyObject *dobj =3D DUMMY_OBJECT(object_new(TYPE_DUMMY));
>> +    Error *local_err =3D NULL;
>> +    const char *s =3D "my other dummy string";
>> +    UserDefOne *ret;
>> +    UserDefOne val;
>> +
>> +    ret =3D OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "blah",
>> +                                  UserDefOne, &local_err);
>> +    error_free_or_abort(&local_err);
>> +    g_assert(!ret);
>> +
>> +    val.integer =3D 42;
>> +    val.string =3D g_strdup(s);
>> +    val.has_enum1 =3D true;
>> +    val.enum1 =3D 100;
>> +    OBJECT_PROPERTY_SET_PTR(OBJECT(dobj), &val, "qv",
>> +                            UserDefOne, &local_err);
>> +    error_free_or_abort(&local_err);
>> +
>> +    ret =3D OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
>> +                                  UserDefOne, &local_err);
>> +    g_assert(!local_err);
>> +
>> +    /* Test that the property has not been modified at all */
>> +    g_assert_cmpint(ret->integer, =3D=3D, 0);
>> +    g_assert_cmpstr(ret->string, =3D=3D, "dummy string");
>> +    g_assert(!ret->has_enum1);
>> +    qapi_free_UserDefOne(ret);
>> +}
>=20
> Not immediately obvious what exactly this one tests.  Totally different
> types?

enum1 is out of range, so the set fails.  The test checks that integer
and string parts of the property were not touched.

I'm leaving these three patches out of the pull request (and 2.9) while
the discussion goes on.

Paolo
