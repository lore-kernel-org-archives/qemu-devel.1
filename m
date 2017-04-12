Received: from eggs.gnu.org ([2001:4830:134:3::10]:50707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cyJgz-0001nz-Tq
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cyJgw-0001b7-0C
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:56:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cyJgv-0001b0-OY
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:56:17 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170410142112.11550-1-marcandre.lureau@redhat.com>
	<8737ddna9i.fsf@dusky.pond.sub.org>
	<CAJ+F1C+XcrF042iTjsU6y5U7pqZDnaT8zMr1dGhe+W5bm34Naw@mail.gmail.com>
Date: Wed, 12 Apr 2017 16:56:14 +0200
In-Reply-To: <CAJ+F1C+XcrF042iTjsU6y5U7pqZDnaT8zMr1dGhe+W5bm34Naw@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 12 Apr 2017
	14:33:07 +0000")
Message-ID: <87pogh1xpt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] test-keyval: fix leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Wed, Apr 12, 2017 at 3:19 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  tests/test-keyval.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/tests/test-keyval.c b/tests/test-keyval.c
>> > index ba19560a22..141ee5d0c4 100644
>> > --- a/tests/test-keyval.c
>> > +++ b/tests/test-keyval.c
>> > @@ -628,6 +628,7 @@ static void test_keyval_visit_alternate(void)
>> >      visit_type_AltNumStr(v, "a", &ans, &error_abort);
>> >      g_assert_cmpint(ans->type, =3D=3D, QTYPE_QSTRING);
>> >      g_assert_cmpstr(ans->u.s, =3D=3D, "1");
>> > +    qapi_free_AltNumStr(ans);
>> >      visit_type_AltNumInt(v, "a", &ani, &err);
>> >      error_free_or_abort(&err);
>> >      visit_end_struct(v, NULL);
>> > @@ -649,11 +650,14 @@ static void test_keyval_visit_any(void)
>> >      visit_type_any(v, "a", &any, &error_abort);
>>
>> @any becomes a strong reference (qobject_input_type_any() increments the
>> reference count).
>>
>> >      qlist =3D qobject_to_qlist(any);
>>
>> Reference count unchanged.
>>
>> >      g_assert(qlist);
>> > +    qobject_decref(any);
>>
>> Uh, this is unnecessarily dirty: you relinquish the reference before
>> you're actually done with it.  Works only because there's *another*
>> reference hiding within @v.  Let's move this ...
>>
>> >      qstr =3D qobject_to_qstring(qlist_pop(qlist));
>> >      g_assert_cmpstr(qstring_get_str(qstr), =3D=3D, "null");
>> > +    QDECREF(qstr);
>> >      qstr =3D qobject_to_qstring(qlist_pop(qlist));
>> >      g_assert_cmpstr(qstring_get_str(qstr), =3D=3D, "1");
>> >      g_assert(qlist_empty(qlist));
>> > +    QDECREF(qstr);
>>
>> ... here.  Okay to do that on commit?
>>
>
>  sure, makes sense
>
>
>> >      visit_check_struct(v, &error_abort);
>> >      visit_end_struct(v, NULL);
>> >      visit_free(v);
>>
>> With the reference counting cleaned up:
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>
>>
> thanks

Applied to qapi-next, thanks!
