Received: from eggs.gnu.org ([2001:4830:134:3::10]:57484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpYkK-0003Xq-Df
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpYkH-0004gc-Aj
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:43:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpYkH-0004gQ-4B
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:43:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-28-marcandre.lureau@redhat.com>
Date: Wed, 06 Sep 2017 13:43:44 +0200
In-Reply-To: <20170822132255.23945-28-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 22 Aug 2017
	15:22:28 +0200")
Message-ID: <87bmmoaw7j.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Wrap generated code with #if/#endif using the ifcond_decorator.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

In my testing, this generates repeated conditionals, e.g.

    diff -rup qapi-gen-24-dc1833e3fb/test-qapi-types.c qapi-gen-27-9600b463=
8d/test-qapi-types.c
    --- qapi-gen-24-dc1833e3fb/test-qapi-types.c	2017-09-06 12:02:33.440375=
590 +0200
    +++ qapi-gen-27-9600b4638d/test-qapi-types.c	2017-09-06 12:55:08.709973=
386 +0200
    @@ -178,6 +178,12 @@ const QEnumLookup QEnumTwo_lookup =3D {
         .size =3D QENUM_TWO__MAX
     };

    +#if defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)
    +
    +
    +#if defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)
    +
    +
     void qapi_free_TestIfAlternate(TestIfAlternate *obj)
     {
         Visitor *v;
    @@ -191,6 +197,15 @@ void qapi_free_TestIfAlternate(TestIfAlt
         visit_free(v);
     }

    +#endif /* defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT) */
    +
    +
    +#endif /* defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT) */
    +
    +

and

    diff -rup qapi-gen-24-dc1833e3fb/test-qapi-types.h qapi-gen-27-9600b463=
8d/test-qapi-types.h
    --- qapi-gen-24-dc1833e3fb/test-qapi-types.h	2017-09-06 12:02:27.386461=
287 +0200
    +++ qapi-gen-27-9600b4638d/test-qapi-types.h	2017-09-06 12:55:02.365062=
236 +0200
    [...]
    @@ -486,6 +498,9 @@ struct NestedEnumsOne {

     void qapi_free_NestedEnumsOne(NestedEnumsOne *obj);

    +#if defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)
    +
    +
     struct TestIfAlternate {
         QType type;
         union { /* union tag is @type */
    @@ -494,18 +509,42 @@ struct TestIfAlternate {
         } u;
     };

    +#if defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)
    +
    +
     void qapi_free_TestIfAlternate(TestIfAlternate *obj);

    +#endif /* defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT) */
    +
    +
    +#endif /* defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT) */
    +
    +

Let's ignore this until we've made up our mind *how* to best generate
conditionals.
