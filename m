Received: from eggs.gnu.org ([2001:4830:134:3::10]:51724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cT3j6-0001a0-0i
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cT3j2-0004jL-1Z
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:37:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cT3j1-0004j0-PG
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:37:15 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9511DB8926
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 09:37:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
	<20170113144135.5150-16-marcandre.lureau@redhat.com>
Date: Mon, 16 Jan 2017 10:37:12 +0100
In-Reply-To: <20170113144135.5150-16-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 13 Jan 2017 15:41:29 +0100")
Message-ID: <87wpdvxs53.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 15/21] qapi: add qapi2texi script
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

> As the name suggests, the qapi2texi script converts JSON QAPI
> description into a texi file suitable for different target
> formats (info/man/txt/pdf/html...).
>
> It parses the following kind of blocks:
>
> Free-form:
>
>   ##
>   # =3D Section
>   # =3D=3D Subsection
>   #
>   # Some text foo with *emphasis*
>   # 1. with a list
>   # 2. like that
>   #
>   # And some code:
>   # | $ echo foo
>   # | -> do this
>   # | <- get that
>   #
>   ##
>
> Symbol description:
>
>   ##
>   # @symbol:
>   #
>   # Symbol body ditto ergo sum. Foo bar
>   # baz ding.
>   #
>   # @param1: the frob to frobnicate
>   # @param2: #optional how hard to frobnicate
>   #
>   # Returns: the frobnicated frob.
>   #          If frob isn't frobnicatable, GenericError.
>   #
>   # Since: version
>   # Notes: notes, comments can have
>   #        - itemized list
>   #        - like this
>   #
>   # Example:
>   #
>   # -> { "execute": "quit" }
>   # <- { "return": {} }
>   #
>   ##
>
> That's roughly following the following EBNF grammar:
>
> api_comment =3D "##\n" comment "##\n"
> comment =3D freeform_comment | symbol_comment
> freeform_comment =3D { "# " text "\n" | "#\n" }
> symbol_comment =3D "# @" name ":\n" { member | tag_section | freeform_com=
ment }
> member =3D "# @" name ':' [ text ] "\n" freeform_comment
> tag_section =3D "# " ( "Returns:", "Since:", "Note:", "Notes:", "Example:=
", "Examples:" ) [ text ]  "\n" freeform_comment
> text =3D free text with markup
>
> Note that the grammar is ambiguous: a line "# @foo:\n" can be parsed
> both as freeform_comment and as symbol_comment.  The actual parser
> recognizes symbol_comment.
>
> See docs/qapi-code-gen.txt for more details.
>
> Deficiencies and limitations:
> - the generated QMP documentation includes internal types
> - union type support is lacking
> - type information is lacking in generated documentation
> - doc comment error message positions are imprecise, they point
>   to the beginning of the comment.
> - a few minor issues, all marked TODO/FIXME in the code
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Squashing in the appended patch along with updates to expected output to
avoid git complaining about trailing blank lines like this:

tests/qapi-schema/comments.out:7: new blank line at EOF.
tests/qapi-schema/event-case.out:8: new blank line at EOF.
tests/qapi-schema/ident-with-escape.out:10: new blank line at EOF.
tests/qapi-schema/include-relpath.out:7: new blank line at EOF.
tests/qapi-schema/include-repetition.out:7: new blank line at EOF.
tests/qapi-schema/include-simple.out:7: new blank line at EOF.
tests/qapi-schema/indented-expr.out:13: new blank line at EOF.
tests/qapi-schema/qapi-schema-test.out:446: new blank line at EOF.

diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 39b55b9..b4cde4f 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -66,4 +66,6 @@ for doc in schema.docs:
         print '    arg=3D%s\n%s' % (arg, section)
     for section in doc.sections:
         print '    section=3D%s\n%s' % (section.name, section)
-    print '    body=3D\n%s' % doc.body
+    body =3D str(doc.body)
+    if body:
+        print '    body=3D\n%s' % body
