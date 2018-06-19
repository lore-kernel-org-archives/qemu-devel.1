Received: from eggs.gnu.org ([2001:4830:134:3::10]:50107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVBWV-00073o-U7
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVBWR-0007y1-2b
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:57:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53218 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVBWQ-0007xn-TT
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:57:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54EBF400E9A3
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 07:57:50 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-4-marcandre.lureau@redhat.com>
Date: Tue, 19 Jun 2018 09:57:39 +0200
In-Reply-To: <20180321115211.17937-4-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 21 Mar 2018 12:51:25 +0100")
Message-ID: <87po0nyzrg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/49] qapi: add 'if' to top-level
 expressions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Accept 'if' key in top-level elements, accepted as string or list of
> string type. The following patches will modify the test visitor to
> check the value is correctly saved, and generate #if/#endif code (as a
> single #if/endif line or a series for a list).
>
> Example of 'if' key:
> { 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
>   'if': 'defined(TEST_IF_STRUCT)' }
>
> The generated code is for now *unconditional*. Later patches generate
> the conditionals.
>
> A following patch for qapi-code-gen.txt will provide more complete
> documentation for 'if' usage.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
[...]
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 0b277036df..f77ad2ba3b 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -436,6 +436,10 @@ qapi-schema +=3D args-unknown.json
>  qapi-schema +=3D bad-base.json
>  qapi-schema +=3D bad-data.json
>  qapi-schema +=3D bad-ident.json
> +qapi-schema +=3D bad-if.json
> +qapi-schema +=3D bad-if-empty.json
> +qapi-schema +=3D bad-if-empty-list.json
> +qapi-schema +=3D bad-if-list.json
>  qapi-schema +=3D bad-type-bool.json
>  qapi-schema +=3D bad-type-dict.json
>  qapi-schema +=3D bad-type-int.json
> @@ -933,6 +937,8 @@ $(patsubst %, check-%, $(check-qapi-schema-y)): check=
-%.json: $(SRC_PATH)/%.json
>  		"TEST","$*.out")
>  	@# Sanitize error messages (make them independent of build directory)
>  	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff -u $(SRC_PATH)/$=
*.err -
> +	@if test "$(QAPI_REGENERATE)" =3D=3D 1 ; then cp $*.test.out $(SRC_PATH=
)/$*.out ; fi
> +	@if test "$(QAPI_REGENERATE)" =3D=3D 1 ; then cp $*.test.err $(SRC_PATH=
)/$*.err ; fi
>  	@diff -u $(SRC_PATH)/$*.out $*.test.out
>  	@diff -u $(SRC_PATH)/$*.exit $*.test.exit
>=20=20

Huh?

[...]
