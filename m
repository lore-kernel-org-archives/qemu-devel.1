Received: from eggs.gnu.org ([2001:4830:134:3::10]:43254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dpbl1-0002uI-C0
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dpbl0-0005HR-GT
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:56:47 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dpbl0-0005Gy-Bd
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:56:46 -0400
Received: by mail-oi0-x244.google.com with SMTP id h70so4589656oic.4
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 07:56:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87bmmoaw7j.fsf@dusky.pond.sub.org>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-28-marcandre.lureau@redhat.com>
	<87bmmoaw7j.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 6 Sep 2017 16:56:44 +0200
Message-ID: <CAJ+F1CLyh0WeHf14T7Czi7ApAtjVD-W2ySMMRMKqfGqAfbE3=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 27/54] qapi-types: add #if conditions to
 types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Wed, Sep 6, 2017 at 1:43 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Wrap generated code with #if/#endif using the ifcond_decorator.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> In my testing, this generates repeated conditionals, e.g.
>
>     diff -rup qapi-gen-24-dc1833e3fb/test-qapi-types.c qapi-gen-27-9600b4=
638d/test-qapi-types.c
>     --- qapi-gen-24-dc1833e3fb/test-qapi-types.c        2017-09-06 12:02:=
33.440375590 +0200
>     +++ qapi-gen-27-9600b4638d/test-qapi-types.c        2017-09-06 12:55:=
08.709973386 +0200
>     @@ -178,6 +178,12 @@ const QEnumLookup QEnumTwo_lookup =3D {
>          .size =3D QENUM_TWO__MAX
>      };
>
>     +#if defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)
>     +
>     +
>     +#if defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)
>     +
>     +
>      void qapi_free_TestIfAlternate(TestIfAlternate *obj)
>      {
>          Visitor *v;
>     @@ -191,6 +197,15 @@ void qapi_free_TestIfAlternate(TestIfAlt
>          visit_free(v);
>      }
>
>     +#endif /* defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT) */
>     +
>     +
>     +#endif /* defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT) */
>     +
>     +
>
> and
>
>     diff -rup qapi-gen-24-dc1833e3fb/test-qapi-types.h qapi-gen-27-9600b4=
638d/test-qapi-types.h
>     --- qapi-gen-24-dc1833e3fb/test-qapi-types.h        2017-09-06 12:02:=
27.386461287 +0200
>     +++ qapi-gen-27-9600b4638d/test-qapi-types.h        2017-09-06 12:55:=
02.365062236 +0200
>     [...]
>     @@ -486,6 +498,9 @@ struct NestedEnumsOne {
>
>      void qapi_free_NestedEnumsOne(NestedEnumsOne *obj);
>
>     +#if defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)
>     +
>     +
>      struct TestIfAlternate {
>          QType type;
>          union { /* union tag is @type */
>     @@ -494,18 +509,42 @@ struct TestIfAlternate {
>          } u;
>      };
>
>     +#if defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)
>     +
>     +
>      void qapi_free_TestIfAlternate(TestIfAlternate *obj);
>
>     +#endif /* defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT) */
>     +
>     +
>     +#endif /* defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT) */
>     +
>     +
>
> Let's ignore this until we've made up our mind *how* to best generate
> conditionals.
>

Fixed, that was being extra cautious :)



--=20
Marc-Andr=C3=A9 Lureau
