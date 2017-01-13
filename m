Received: from eggs.gnu.org ([2001:4830:134:3::10]:60021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33g-0003pe-SN
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33Q-0006dQ-5B
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cS33P-0006cO-HA
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:08 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6B87C04B925
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 14:42:07 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 15:41:29 +0100
Message-Id: <20170113144135.5150-16-marcandre.lureau@redhat.com>
In-Reply-To: <20170113144135.5150-1-marcandre.lureau@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 15/21] qapi: add qapi2texi script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

As the name suggests, the qapi2texi script converts JSON QAPI
description into a texi file suitable for different target
formats (info/man/txt/pdf/html...).

It parses the following kind of blocks:

Free-form:

  ##
  # =3D Section
  # =3D=3D Subsection
  #
  # Some text foo with *emphasis*
  # 1. with a list
  # 2. like that
  #
  # And some code:
  # | $ echo foo
  # | -> do this
  # | <- get that
  #
  ##

Symbol description:

  ##
  # @symbol:
  #
  # Symbol body ditto ergo sum. Foo bar
  # baz ding.
  #
  # @param1: the frob to frobnicate
  # @param2: #optional how hard to frobnicate
  #
  # Returns: the frobnicated frob.
  #          If frob isn't frobnicatable, GenericError.
  #
  # Since: version
  # Notes: notes, comments can have
  #        - itemized list
  #        - like this
  #
  # Example:
  #
  # -> { "execute": "quit" }
  # <- { "return": {} }
  #
  ##

That's roughly following the following EBNF grammar:

api_comment =3D "##\n" comment "##\n"
comment =3D freeform_comment | symbol_comment
freeform_comment =3D { "# " text "\n" | "#\n" }
symbol_comment =3D "# @" name ":\n" { member | tag_section | freeform_com=
ment }
member =3D "# @" name ':' [ text ] "\n" freeform_comment
tag_section =3D "# " ( "Returns:", "Since:", "Note:", "Notes:", "Example:=
", "Examples:" ) [ text ]  "\n" freeform_comment
text =3D free text with markup

Note that the grammar is ambiguous: a line "# @foo:\n" can be parsed
both as freeform_comment and as symbol_comment.  The actual parser
recognizes symbol_comment.

See docs/qapi-code-gen.txt for more details.

Deficiencies and limitations:
- the generated QMP documentation includes internal types
- union type support is lacking
- type information is lacking in generated documentation
- doc comment error message positions are imprecise, they point
  to the beginning of the comment.
- a few minor issues, all marked TODO/FIXME in the code

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                                    | 251 +++++++++++++++=
+++-
 scripts/qapi2texi.py                               | 271 +++++++++++++++=
++++++
 docs/qapi-code-gen.txt                             | 180 +++++++++++---
 tests/Makefile.include                             |  20 ++
 tests/qapi-schema/alternate-any.err                |   2 +-
 tests/qapi-schema/alternate-any.json               |   4 +
 tests/qapi-schema/alternate-array.err              |   2 +-
 tests/qapi-schema/alternate-array.json             |   7 +
 tests/qapi-schema/alternate-base.err               |   2 +-
 tests/qapi-schema/alternate-base.json              |   7 +
 tests/qapi-schema/alternate-clash.err              |   2 +-
 tests/qapi-schema/alternate-clash.json             |   4 +
 tests/qapi-schema/alternate-conflict-dict.err      |   2 +-
 tests/qapi-schema/alternate-conflict-dict.json     |  10 +
 tests/qapi-schema/alternate-conflict-string.err    |   2 +-
 tests/qapi-schema/alternate-conflict-string.json   |   7 +
 tests/qapi-schema/alternate-empty.err              |   2 +-
 tests/qapi-schema/alternate-empty.json             |   4 +
 tests/qapi-schema/alternate-nested.err             |   2 +-
 tests/qapi-schema/alternate-nested.json            |   7 +
 tests/qapi-schema/alternate-unknown.err            |   2 +-
 tests/qapi-schema/alternate-unknown.json           |   4 +
 tests/qapi-schema/args-alternate.err               |   2 +-
 tests/qapi-schema/args-alternate.json              |   8 +
 tests/qapi-schema/args-any.err                     |   2 +-
 tests/qapi-schema/args-any.json                    |   4 +
 tests/qapi-schema/args-array-empty.err             |   2 +-
 tests/qapi-schema/args-array-empty.json            |   4 +
 tests/qapi-schema/args-array-unknown.err           |   2 +-
 tests/qapi-schema/args-array-unknown.json          |   4 +
 tests/qapi-schema/args-bad-boxed.err               |   2 +-
 tests/qapi-schema/args-bad-boxed.json              |   4 +
 tests/qapi-schema/args-boxed-anon.err              |   2 +-
 tests/qapi-schema/args-boxed-anon.json             |   4 +
 tests/qapi-schema/args-boxed-empty.err             |   2 +-
 tests/qapi-schema/args-boxed-empty.json            |   8 +
 tests/qapi-schema/args-boxed-string.err            |   2 +-
 tests/qapi-schema/args-boxed-string.json           |   4 +
 tests/qapi-schema/args-int.err                     |   2 +-
 tests/qapi-schema/args-int.json                    |   4 +
 tests/qapi-schema/args-invalid.err                 |   2 +-
 tests/qapi-schema/args-invalid.json                |   3 +
 tests/qapi-schema/args-member-array-bad.err        |   2 +-
 tests/qapi-schema/args-member-array-bad.json       |   4 +
 tests/qapi-schema/args-member-case.err             |   2 +-
 tests/qapi-schema/args-member-case.json            |   4 +
 tests/qapi-schema/args-member-unknown.err          |   2 +-
 tests/qapi-schema/args-member-unknown.json         |   4 +
 tests/qapi-schema/args-name-clash.err              |   2 +-
 tests/qapi-schema/args-name-clash.json             |   4 +
 tests/qapi-schema/args-union.err                   |   2 +-
 tests/qapi-schema/args-union.json                  |   7 +
 tests/qapi-schema/args-unknown.err                 |   2 +-
 tests/qapi-schema/args-unknown.json                |   4 +
 tests/qapi-schema/bad-base.err                     |   2 +-
 tests/qapi-schema/bad-base.json                    |   7 +
 tests/qapi-schema/bad-data.err                     |   2 +-
 tests/qapi-schema/bad-data.json                    |   4 +
 tests/qapi-schema/bad-ident.err                    |   2 +-
 tests/qapi-schema/bad-ident.json                   |   4 +
 tests/qapi-schema/bad-type-bool.err                |   2 +-
 tests/qapi-schema/bad-type-bool.json               |   4 +
 tests/qapi-schema/bad-type-dict.err                |   2 +-
 tests/qapi-schema/bad-type-dict.json               |   4 +
 tests/qapi-schema/base-cycle-direct.err            |   2 +-
 tests/qapi-schema/base-cycle-direct.json           |   4 +
 tests/qapi-schema/base-cycle-indirect.err          |   2 +-
 tests/qapi-schema/base-cycle-indirect.json         |   7 +
 tests/qapi-schema/command-int.err                  |   2 +-
 tests/qapi-schema/command-int.json                 |   4 +
 tests/qapi-schema/comments.json                    |   4 +
 tests/qapi-schema/comments.out                     |   3 +
 tests/qapi-schema/doc-bad-args.err                 |   1 +
 tests/qapi-schema/doc-bad-args.exit                |   1 +
 tests/qapi-schema/doc-bad-args.json                |   8 +
 tests/qapi-schema/doc-bad-args.out                 |   0
 tests/qapi-schema/doc-bad-symbol.err               |   1 +
 tests/qapi-schema/doc-bad-symbol.exit              |   1 +
 tests/qapi-schema/doc-bad-symbol.json              |   6 +
 tests/qapi-schema/doc-bad-symbol.out               |   0
 tests/qapi-schema/doc-duplicated-arg.err           |   1 +
 tests/qapi-schema/doc-duplicated-arg.exit          |   1 +
 tests/qapi-schema/doc-duplicated-arg.json          |   7 +
 tests/qapi-schema/doc-duplicated-arg.out           |   0
 tests/qapi-schema/doc-duplicated-return.err        |   1 +
 tests/qapi-schema/doc-duplicated-return.exit       |   1 +
 tests/qapi-schema/doc-duplicated-return.json       |   8 +
 tests/qapi-schema/doc-duplicated-return.out        |   0
 tests/qapi-schema/doc-duplicated-since.err         |   1 +
 tests/qapi-schema/doc-duplicated-since.exit        |   1 +
 tests/qapi-schema/doc-duplicated-since.json        |   8 +
 tests/qapi-schema/doc-duplicated-since.out         |   0
 tests/qapi-schema/doc-empty-arg.err                |   1 +
 tests/qapi-schema/doc-empty-arg.exit               |   1 +
 tests/qapi-schema/doc-empty-arg.json               |   6 +
 tests/qapi-schema/doc-empty-arg.out                |   0
 tests/qapi-schema/doc-empty-section.err            |   1 +
 tests/qapi-schema/doc-empty-section.exit           |   1 +
 tests/qapi-schema/doc-empty-section.json           |   8 +
 tests/qapi-schema/doc-empty-section.out            |   0
 tests/qapi-schema/doc-empty-symbol.err             |   1 +
 tests/qapi-schema/doc-empty-symbol.exit            |   1 +
 tests/qapi-schema/doc-empty-symbol.json            |   5 +
 tests/qapi-schema/doc-empty-symbol.out             |   0
 tests/qapi-schema/doc-interleaved-section.err      |   1 +
 tests/qapi-schema/doc-interleaved-section.exit     |   1 +
 tests/qapi-schema/doc-interleaved-section.json     |  21 ++
 tests/qapi-schema/doc-interleaved-section.out      |   0
 tests/qapi-schema/doc-invalid-end.err              |   1 +
 tests/qapi-schema/doc-invalid-end.exit             |   1 +
 tests/qapi-schema/doc-invalid-end.json             |   5 +
 tests/qapi-schema/doc-invalid-end.out              |   0
 tests/qapi-schema/doc-invalid-end2.err             |   1 +
 tests/qapi-schema/doc-invalid-end2.exit            |   1 +
 tests/qapi-schema/doc-invalid-end2.json            |   5 +
 tests/qapi-schema/doc-invalid-end2.out             |   0
 tests/qapi-schema/doc-invalid-return.err           |   1 +
 tests/qapi-schema/doc-invalid-return.exit          |   1 +
 tests/qapi-schema/doc-invalid-return.json          |   7 +
 tests/qapi-schema/doc-invalid-return.out           |   0
 tests/qapi-schema/doc-invalid-section.err          |   1 +
 tests/qapi-schema/doc-invalid-section.exit         |   1 +
 tests/qapi-schema/doc-invalid-section.json         |   6 +
 tests/qapi-schema/doc-invalid-section.out          |   0
 tests/qapi-schema/doc-invalid-start.err            |   1 +
 tests/qapi-schema/doc-invalid-start.exit           |   1 +
 tests/qapi-schema/doc-invalid-start.json           |   5 +
 tests/qapi-schema/doc-invalid-start.out            |   0
 tests/qapi-schema/doc-missing-colon.err            |   1 +
 tests/qapi-schema/doc-missing-colon.exit           |   1 +
 tests/qapi-schema/doc-missing-colon.json           |   5 +
 tests/qapi-schema/doc-missing-colon.out            |   0
 tests/qapi-schema/doc-missing-expr.err             |   1 +
 tests/qapi-schema/doc-missing-expr.exit            |   1 +
 tests/qapi-schema/doc-missing-expr.json            |   5 +
 tests/qapi-schema/doc-missing-expr.out             |   0
 tests/qapi-schema/doc-missing-space.err            |   1 +
 tests/qapi-schema/doc-missing-space.exit           |   1 +
 tests/qapi-schema/doc-missing-space.json           |   6 +
 tests/qapi-schema/doc-missing-space.out            |   0
 tests/qapi-schema/doc-optional.err                 |   1 +
 tests/qapi-schema/doc-optional.exit                |   1 +
 tests/qapi-schema/doc-optional.json                |   7 +
 tests/qapi-schema/doc-optional.out                 |   0
 tests/qapi-schema/double-type.err                  |   2 +-
 tests/qapi-schema/double-type.json                 |   4 +
 tests/qapi-schema/enum-bad-name.err                |   2 +-
 tests/qapi-schema/enum-bad-name.json               |   4 +
 tests/qapi-schema/enum-bad-prefix.err              |   2 +-
 tests/qapi-schema/enum-bad-prefix.json             |   4 +
 tests/qapi-schema/enum-clash-member.err            |   2 +-
 tests/qapi-schema/enum-clash-member.json           |   4 +
 tests/qapi-schema/enum-dict-member.err             |   2 +-
 tests/qapi-schema/enum-dict-member.json            |   4 +
 tests/qapi-schema/enum-member-case.err             |   2 +-
 tests/qapi-schema/enum-member-case.json            |   7 +
 tests/qapi-schema/enum-missing-data.err            |   2 +-
 tests/qapi-schema/enum-missing-data.json           |   4 +
 tests/qapi-schema/enum-wrong-data.err              |   2 +-
 tests/qapi-schema/enum-wrong-data.json             |   4 +
 tests/qapi-schema/event-boxed-empty.err            |   2 +-
 tests/qapi-schema/event-boxed-empty.json           |   4 +
 tests/qapi-schema/event-case.json                  |   4 +
 tests/qapi-schema/event-case.out                   |   3 +
 tests/qapi-schema/event-nest-struct.err            |   2 +-
 tests/qapi-schema/event-nest-struct.json           |   4 +
 tests/qapi-schema/flat-union-array-branch.err      |   2 +-
 tests/qapi-schema/flat-union-array-branch.json     |  12 +
 tests/qapi-schema/flat-union-bad-base.err          |   2 +-
 tests/qapi-schema/flat-union-bad-base.json         |  13 +
 tests/qapi-schema/flat-union-bad-discriminator.err |   2 +-
 .../qapi-schema/flat-union-bad-discriminator.json  |  16 ++
 tests/qapi-schema/flat-union-base-any.err          |   2 +-
 tests/qapi-schema/flat-union-base-any.json         |  13 +
 tests/qapi-schema/flat-union-base-union.err        |   2 +-
 tests/qapi-schema/flat-union-base-union.json       |  16 ++
 tests/qapi-schema/flat-union-clash-member.err      |   2 +-
 tests/qapi-schema/flat-union-clash-member.json     |  16 ++
 tests/qapi-schema/flat-union-empty.err             |   2 +-
 tests/qapi-schema/flat-union-empty.json            |  10 +
 tests/qapi-schema/flat-union-incomplete-branch.err |   2 +-
 .../qapi-schema/flat-union-incomplete-branch.json  |  10 +
 tests/qapi-schema/flat-union-inline.err            |   2 +-
 tests/qapi-schema/flat-union-inline.json           |  10 +
 tests/qapi-schema/flat-union-int-branch.err        |   2 +-
 tests/qapi-schema/flat-union-int-branch.json       |  13 +
 .../qapi-schema/flat-union-invalid-branch-key.err  |   2 +-
 .../qapi-schema/flat-union-invalid-branch-key.json |  15 ++
 .../flat-union-invalid-discriminator.err           |   2 +-
 .../flat-union-invalid-discriminator.json          |  15 ++
 tests/qapi-schema/flat-union-no-base.err           |   2 +-
 tests/qapi-schema/flat-union-no-base.json          |  13 +
 .../flat-union-optional-discriminator.err          |   2 +-
 .../flat-union-optional-discriminator.json         |  13 +
 .../flat-union-string-discriminator.err            |   2 +-
 .../flat-union-string-discriminator.json           |  15 ++
 tests/qapi-schema/ident-with-escape.json           |   4 +
 tests/qapi-schema/ident-with-escape.out            |   3 +
 tests/qapi-schema/include-relpath-sub.json         |   3 +
 tests/qapi-schema/include-relpath.out              |   3 +
 tests/qapi-schema/include-repetition.out           |   3 +
 tests/qapi-schema/include-simple-sub.json          |   3 +
 tests/qapi-schema/include-simple.out               |   3 +
 tests/qapi-schema/indented-expr.json               |   6 +
 tests/qapi-schema/indented-expr.out                |   6 +
 tests/qapi-schema/missing-type.err                 |   2 +-
 tests/qapi-schema/missing-type.json                |   4 +
 tests/qapi-schema/nested-struct-data.err           |   2 +-
 tests/qapi-schema/nested-struct-data.json          |   4 +
 tests/qapi-schema/qapi-schema-test.json            | 213 +++++++++++++++=
+
 tests/qapi-schema/qapi-schema-test.out             | 212 +++++++++++++++=
+
 tests/qapi-schema/redefined-builtin.err            |   2 +-
 tests/qapi-schema/redefined-builtin.json           |   4 +
 tests/qapi-schema/redefined-command.err            |   2 +-
 tests/qapi-schema/redefined-command.json           |   7 +
 tests/qapi-schema/redefined-event.err              |   2 +-
 tests/qapi-schema/redefined-event.json             |   7 +
 tests/qapi-schema/redefined-type.err               |   2 +-
 tests/qapi-schema/redefined-type.json              |   7 +
 tests/qapi-schema/reserved-command-q.err           |   2 +-
 tests/qapi-schema/reserved-command-q.json          |   7 +
 tests/qapi-schema/reserved-enum-q.err              |   2 +-
 tests/qapi-schema/reserved-enum-q.json             |   4 +
 tests/qapi-schema/reserved-member-has.err          |   2 +-
 tests/qapi-schema/reserved-member-has.json         |   4 +
 tests/qapi-schema/reserved-member-q.err            |   2 +-
 tests/qapi-schema/reserved-member-q.json           |   4 +
 tests/qapi-schema/reserved-member-u.err            |   2 +-
 tests/qapi-schema/reserved-member-u.json           |   4 +
 tests/qapi-schema/reserved-member-underscore.err   |   2 +-
 tests/qapi-schema/reserved-member-underscore.json  |   4 +
 tests/qapi-schema/reserved-type-kind.err           |   2 +-
 tests/qapi-schema/reserved-type-kind.json          |   4 +
 tests/qapi-schema/reserved-type-list.err           |   2 +-
 tests/qapi-schema/reserved-type-list.json          |   4 +
 tests/qapi-schema/returns-alternate.err            |   2 +-
 tests/qapi-schema/returns-alternate.json           |   7 +
 tests/qapi-schema/returns-array-bad.err            |   2 +-
 tests/qapi-schema/returns-array-bad.json           |   4 +
 tests/qapi-schema/returns-dict.err                 |   2 +-
 tests/qapi-schema/returns-dict.json                |   4 +
 tests/qapi-schema/returns-unknown.err              |   2 +-
 tests/qapi-schema/returns-unknown.json             |   4 +
 tests/qapi-schema/returns-whitelist.err            |   2 +-
 tests/qapi-schema/returns-whitelist.json           |  16 ++
 tests/qapi-schema/struct-base-clash-deep.err       |   2 +-
 tests/qapi-schema/struct-base-clash-deep.json      |  10 +
 tests/qapi-schema/struct-base-clash.err            |   2 +-
 tests/qapi-schema/struct-base-clash.json           |   7 +
 tests/qapi-schema/struct-data-invalid.err          |   2 +-
 tests/qapi-schema/struct-data-invalid.json         |   3 +
 tests/qapi-schema/struct-member-invalid.err        |   2 +-
 tests/qapi-schema/struct-member-invalid.json       |   3 +
 tests/qapi-schema/test-qapi.py                     |  12 +
 tests/qapi-schema/type-bypass-bad-gen.err          |   2 +-
 tests/qapi-schema/type-bypass-bad-gen.json         |   4 +
 tests/qapi-schema/unicode-str.err                  |   2 +-
 tests/qapi-schema/unicode-str.json                 |   4 +
 tests/qapi-schema/union-base-no-discriminator.err  |   2 +-
 tests/qapi-schema/union-base-no-discriminator.json |  12 +
 tests/qapi-schema/union-branch-case.err            |   2 +-
 tests/qapi-schema/union-branch-case.json           |   4 +
 tests/qapi-schema/union-clash-branches.err         |   2 +-
 tests/qapi-schema/union-clash-branches.json        |   4 +
 tests/qapi-schema/union-empty.err                  |   2 +-
 tests/qapi-schema/union-empty.json                 |   4 +
 tests/qapi-schema/union-invalid-base.err           |   2 +-
 tests/qapi-schema/union-invalid-base.json          |  10 +
 tests/qapi-schema/union-optional-branch.err        |   2 +-
 tests/qapi-schema/union-optional-branch.json       |   4 +
 tests/qapi-schema/union-unknown.err                |   2 +-
 tests/qapi-schema/union-unknown.json               |   4 +
 tests/qapi-schema/unknown-escape.err               |   2 +-
 tests/qapi-schema/unknown-escape.json              |   4 +
 tests/qapi-schema/unknown-expr-key.err             |   2 +-
 tests/qapi-schema/unknown-expr-key.json            |   4 +
 276 files changed, 2021 insertions(+), 127 deletions(-)
 create mode 100755 scripts/qapi2texi.py
 create mode 100644 tests/qapi-schema/doc-bad-args.err
 create mode 100644 tests/qapi-schema/doc-bad-args.exit
 create mode 100644 tests/qapi-schema/doc-bad-args.json
 create mode 100644 tests/qapi-schema/doc-bad-args.out
 create mode 100644 tests/qapi-schema/doc-bad-symbol.err
 create mode 100644 tests/qapi-schema/doc-bad-symbol.exit
 create mode 100644 tests/qapi-schema/doc-bad-symbol.json
 create mode 100644 tests/qapi-schema/doc-bad-symbol.out
 create mode 100644 tests/qapi-schema/doc-duplicated-arg.err
 create mode 100644 tests/qapi-schema/doc-duplicated-arg.exit
 create mode 100644 tests/qapi-schema/doc-duplicated-arg.json
 create mode 100644 tests/qapi-schema/doc-duplicated-arg.out
 create mode 100644 tests/qapi-schema/doc-duplicated-return.err
 create mode 100644 tests/qapi-schema/doc-duplicated-return.exit
 create mode 100644 tests/qapi-schema/doc-duplicated-return.json
 create mode 100644 tests/qapi-schema/doc-duplicated-return.out
 create mode 100644 tests/qapi-schema/doc-duplicated-since.err
 create mode 100644 tests/qapi-schema/doc-duplicated-since.exit
 create mode 100644 tests/qapi-schema/doc-duplicated-since.json
 create mode 100644 tests/qapi-schema/doc-duplicated-since.out
 create mode 100644 tests/qapi-schema/doc-empty-arg.err
 create mode 100644 tests/qapi-schema/doc-empty-arg.exit
 create mode 100644 tests/qapi-schema/doc-empty-arg.json
 create mode 100644 tests/qapi-schema/doc-empty-arg.out
 create mode 100644 tests/qapi-schema/doc-empty-section.err
 create mode 100644 tests/qapi-schema/doc-empty-section.exit
 create mode 100644 tests/qapi-schema/doc-empty-section.json
 create mode 100644 tests/qapi-schema/doc-empty-section.out
 create mode 100644 tests/qapi-schema/doc-empty-symbol.err
 create mode 100644 tests/qapi-schema/doc-empty-symbol.exit
 create mode 100644 tests/qapi-schema/doc-empty-symbol.json
 create mode 100644 tests/qapi-schema/doc-empty-symbol.out
 create mode 100644 tests/qapi-schema/doc-interleaved-section.err
 create mode 100644 tests/qapi-schema/doc-interleaved-section.exit
 create mode 100644 tests/qapi-schema/doc-interleaved-section.json
 create mode 100644 tests/qapi-schema/doc-interleaved-section.out
 create mode 100644 tests/qapi-schema/doc-invalid-end.err
 create mode 100644 tests/qapi-schema/doc-invalid-end.exit
 create mode 100644 tests/qapi-schema/doc-invalid-end.json
 create mode 100644 tests/qapi-schema/doc-invalid-end.out
 create mode 100644 tests/qapi-schema/doc-invalid-end2.err
 create mode 100644 tests/qapi-schema/doc-invalid-end2.exit
 create mode 100644 tests/qapi-schema/doc-invalid-end2.json
 create mode 100644 tests/qapi-schema/doc-invalid-end2.out
 create mode 100644 tests/qapi-schema/doc-invalid-return.err
 create mode 100644 tests/qapi-schema/doc-invalid-return.exit
 create mode 100644 tests/qapi-schema/doc-invalid-return.json
 create mode 100644 tests/qapi-schema/doc-invalid-return.out
 create mode 100644 tests/qapi-schema/doc-invalid-section.err
 create mode 100644 tests/qapi-schema/doc-invalid-section.exit
 create mode 100644 tests/qapi-schema/doc-invalid-section.json
 create mode 100644 tests/qapi-schema/doc-invalid-section.out
 create mode 100644 tests/qapi-schema/doc-invalid-start.err
 create mode 100644 tests/qapi-schema/doc-invalid-start.exit
 create mode 100644 tests/qapi-schema/doc-invalid-start.json
 create mode 100644 tests/qapi-schema/doc-invalid-start.out
 create mode 100644 tests/qapi-schema/doc-missing-colon.err
 create mode 100644 tests/qapi-schema/doc-missing-colon.exit
 create mode 100644 tests/qapi-schema/doc-missing-colon.json
 create mode 100644 tests/qapi-schema/doc-missing-colon.out
 create mode 100644 tests/qapi-schema/doc-missing-expr.err
 create mode 100644 tests/qapi-schema/doc-missing-expr.exit
 create mode 100644 tests/qapi-schema/doc-missing-expr.json
 create mode 100644 tests/qapi-schema/doc-missing-expr.out
 create mode 100644 tests/qapi-schema/doc-missing-space.err
 create mode 100644 tests/qapi-schema/doc-missing-space.exit
 create mode 100644 tests/qapi-schema/doc-missing-space.json
 create mode 100644 tests/qapi-schema/doc-missing-space.out
 create mode 100644 tests/qapi-schema/doc-optional.err
 create mode 100644 tests/qapi-schema/doc-optional.exit
 create mode 100644 tests/qapi-schema/doc-optional.json
 create mode 100644 tests/qapi-schema/doc-optional.out

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 3d5f9e1eaf..ea52fca6b9 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -125,6 +125,122 @@ class QAPISemError(QAPIError):
                            info['parent'], msg)
=20
=20
+class QAPIDoc(object):
+    class Section(object):
+        def __init__(self, name=3DNone):
+            # optional section name (argument/member or section name)
+            self.name =3D name
+            # the list of lines for this section
+            self.content =3D []
+
+        def append(self, line):
+            self.content.append(line)
+
+        def __repr__(self):
+            return "\n".join(self.content).strip()
+
+    class ArgSection(Section):
+        pass
+
+    def __init__(self, parser, info):
+        # self.parser is used to report errors with QAPIParseError.  The
+        # resulting error position depends on the state of the parser.
+        # It happens to be the beginning of the comment.  More or less
+        # servicable, but action at a distance.
+        self.parser =3D parser
+        self.info =3D info
+        self.symbol =3D None
+        self.body =3D QAPIDoc.Section()
+        # dict mapping parameter name to ArgSection
+        self.args =3D OrderedDict()
+        # a list of Section
+        self.sections =3D []
+        # the current section
+        self.section =3D self.body
+        # associated expression (to be set by expression parser)
+        self.expr =3D None
+
+    def has_section(self, name):
+        """Return True if we have a section with this name."""
+        for i in self.sections:
+            if i.name =3D=3D name:
+                return True
+        return False
+
+    def append(self, line):
+        """Parse a comment line and add it to the documentation."""
+        line =3D line[1:]
+        if not line:
+            self._append_freeform(line)
+            return
+
+        if line[0] !=3D ' ':
+            raise QAPIParseError(self.parser, "Missing space after #")
+        line =3D line[1:]
+
+        # FIXME not nice: things like '#  @foo:' and '# @foo: ' aren't
+        # recognized, and get silently treated as ordinary text
+        if self.symbol:
+            self._append_symbol_line(line)
+        elif not self.body.content and line.startswith("@"):
+            if not line.endswith(":"):
+                raise QAPIParseError(self.parser, "Line should end with =
:")
+            self.symbol =3D line[1:-1]
+            # FIXME invalid names other than the empty string aren't fla=
gged
+            if not self.symbol:
+                raise QAPIParseError(self.parser, "Invalid name")
+        else:
+            self._append_freeform(line)
+
+    def _append_symbol_line(self, line):
+        name =3D line.split(' ', 1)[0]
+
+        if name.startswith("@") and name.endswith(":"):
+            line =3D line[len(name)+1:]
+            self._start_args_section(name[1:-1])
+        elif name in ("Returns:", "Since:",
+                      # those are often singular or plural
+                      "Note:", "Notes:",
+                      "Example:", "Examples:",
+                      "TODO:"):
+            line =3D line[len(name)+1:]
+            self._start_section(name[:-1])
+
+        self._append_freeform(line)
+
+    def _start_args_section(self, name):
+        # FIXME invalid names other than the empty string aren't flagged
+        if not name:
+            raise QAPIParseError(self.parser, "Invalid parameter name")
+        if name in self.args:
+            raise QAPIParseError(self.parser,
+                                 "'%s' parameter name duplicated" % name=
)
+        if self.sections:
+            raise QAPIParseError(self.parser,
+                                 "'@%s:' can't follow '%s' section"
+                                 % (name, self.sections[0].name))
+        self.section =3D QAPIDoc.ArgSection(name)
+        self.args[name] =3D self.section
+
+    def _start_section(self, name=3D""):
+        if name in ("Returns", "Since") and self.has_section(name):
+            raise QAPIParseError(self.parser,
+                                 "Duplicated '%s' section" % name)
+        self.section =3D QAPIDoc.Section(name)
+        self.sections.append(self.section)
+
+    def _append_freeform(self, line):
+        in_arg =3D isinstance(self.section, QAPIDoc.ArgSection)
+        if (in_arg and self.section.content
+                and not self.section.content[-1]
+                and line and not line[0].isspace()):
+            self._start_section()
+        if (in_arg or not self.section.name
+                or not self.section.name.startswith("Example")):
+            line =3D line.strip()
+        self.section.append(line)
+
+
 class QAPISchemaParser(object):
=20
     def __init__(self, fp, previously_included=3D[], incl_info=3DNone):
@@ -140,11 +256,17 @@ class QAPISchemaParser(object):
         self.line =3D 1
         self.line_pos =3D 0
         self.exprs =3D []
+        self.docs =3D []
         self.accept()
=20
         while self.tok is not None:
             info =3D {'file': fname, 'line': self.line,
                     'parent': self.incl_info}
+            if self.tok =3D=3D '#':
+                doc =3D self.get_doc(info)
+                self.docs.append(doc)
+                continue
+
             expr =3D self.get_expr(False)
             if isinstance(expr, dict) and "include" in expr:
                 if len(expr) !=3D 1:
@@ -162,6 +284,7 @@ class QAPISchemaParser(object):
                         raise QAPISemError(info, "Inclusion loop for %s"
                                            % include)
                     inf =3D inf['parent']
+
                 # skip multiple include of the same file
                 if incl_abs_fname in previously_included:
                     continue
@@ -172,12 +295,19 @@ class QAPISchemaParser(object):
                 exprs_include =3D QAPISchemaParser(fobj, previously_incl=
uded,
                                                  info)
                 self.exprs.extend(exprs_include.exprs)
+                self.docs.extend(exprs_include.docs)
             else:
                 expr_elem =3D {'expr': expr,
                              'info': info}
+                if (self.docs
+                        and self.docs[-1].info['file'] =3D=3D fname
+                        and not self.docs[-1].expr):
+                    self.docs[-1].expr =3D expr
+                    expr_elem['doc'] =3D self.docs[-1]
+
                 self.exprs.append(expr_elem)
=20
-    def accept(self):
+    def accept(self, skip_comment=3DTrue):
         while True:
             self.tok =3D self.src[self.cursor]
             self.pos =3D self.cursor
@@ -185,7 +315,13 @@ class QAPISchemaParser(object):
             self.val =3D None
=20
             if self.tok =3D=3D '#':
+                if self.src[self.cursor] =3D=3D '#':
+                    # Start of doc comment
+                    skip_comment =3D False
                 self.cursor =3D self.src.find('\n', self.cursor)
+                if not skip_comment:
+                    self.val =3D self.src[self.pos:self.cursor]
+                    return
             elif self.tok in "{}:,[]":
                 return
             elif self.tok =3D=3D "'":
@@ -319,6 +455,28 @@ class QAPISchemaParser(object):
             raise QAPIParseError(self, 'Expected "{", "[" or string')
         return expr
=20
+    def get_doc(self, info):
+        if self.val !=3D '##':
+            raise QAPIParseError(self, "Junk after '##' at start of "
+                                 "documentation comment")
+
+        doc =3D QAPIDoc(self, info)
+        self.accept(False)
+        while self.tok =3D=3D '#':
+            if self.val.startswith('##'):
+                # End of doc comment
+                if self.val !=3D '##':
+                    raise QAPIParseError(self, "Junk after '##' at end o=
f "
+                                         "documentation comment")
+                self.accept()
+                return doc
+            else:
+                doc.append(self.val)
+            self.accept(False)
+
+        raise QAPIParseError(self, "Documentation comment must end with =
'##'")
+
+
 #
 # Semantic analysis of schema expressions
 # TODO fold into QAPISchema
@@ -703,6 +861,11 @@ def check_exprs(exprs):
     for expr_elem in exprs:
         expr =3D expr_elem['expr']
         info =3D expr_elem['info']
+
+        if 'doc' not in expr_elem:
+            raise QAPISemError(info,
+                               "Expression missing documentation comment=
")
+
         if 'enum' in expr:
             check_keys(expr_elem, 'enum', ['data'], ['prefix'])
             add_enum(expr['enum'], info, expr['data'])
@@ -761,6 +924,88 @@ def check_exprs(exprs):
     return exprs
=20
=20
+def check_freeform_doc(doc):
+    if doc.symbol:
+        raise QAPISemError(doc.info,
+                           "Documention for '%s' is not followed"
+                           " by the definition" % doc.symbol)
+
+    body =3D str(doc.body)
+    if re.search(r'@\S+:', body, re.MULTILINE):
+        raise QAPISemError(doc.info,
+                           "Free-form documentation block must not conta=
in"
+                           " @NAME: sections")
+
+
+def check_definition_doc(doc, expr, info):
+    for i in ('enum', 'union', 'alternate', 'struct', 'command', 'event'=
):
+        if i in expr:
+            meta =3D i
+            break
+
+    name =3D expr[meta]
+    if doc.symbol !=3D name:
+        raise QAPISemError(info, "Definition of '%s' follows documentati=
on"
+                           " for '%s'" % (name, doc.symbol))
+    if doc.has_section('Returns') and 'command' not in expr:
+        raise QAPISemError(info, "'Returns:' is only valid for commands"=
)
+
+    if meta =3D=3D 'union':
+        args =3D expr.get('base', [])
+    else:
+        args =3D expr.get('data', [])
+    if isinstance(args, str):
+        return
+    if isinstance(args, dict):
+        args =3D args.keys()
+    assert isinstance(args, list)
+
+    if (meta =3D=3D 'alternate'
+            or (meta =3D=3D 'union' and not expr.get('discriminator'))):
+        args.append('type')
+
+    for arg in args:
+        if arg[0] =3D=3D '*':
+            opt =3D True
+            desc =3D doc.args.get(arg[1:])
+        else:
+            opt =3D False
+            desc =3D doc.args.get(arg)
+        if not desc:
+            continue
+        desc_opt =3D "#optional" in str(desc)
+        if desc_opt and not opt:
+            raise QAPISemError(info, "Description has #optional, "
+                               "but the declaration doesn't")
+        if not desc_opt and opt:
+            # silently fix the doc
+            # TODO either fix the schema and make this an error,
+            # or drop #optional entirely
+            desc.append("#optional")
+
+    doc_args =3D set(doc.args.keys())
+    args =3D set([name.strip('*') for name in args])
+    if not doc_args.issubset(args):
+        raise QAPISemError(info, "The following documented members are n=
ot in "
+                           "the declaration: %s" % ", ".join(doc_args - =
args))
+
+
+def check_docs(docs):
+    for doc in docs:
+        for section in doc.args.values() + doc.sections:
+            content =3D str(section)
+            if not content or content.isspace():
+                raise QAPISemError(doc.info,
+                                   "Empty doc section '%s'" % section.na=
me)
+
+        if not doc.expr:
+            check_freeform_doc(doc)
+        else:
+            check_definition_doc(doc, doc.expr, doc.info)
+
+    return docs
+
+
 #
 # Schema compiler frontend
 #
@@ -1229,7 +1474,9 @@ class QAPISchemaEvent(QAPISchemaEntity):
 class QAPISchema(object):
     def __init__(self, fname):
         try:
-            self.exprs =3D check_exprs(QAPISchemaParser(open(fname, "r")=
).exprs)
+            parser =3D QAPISchemaParser(open(fname, "r"))
+            self.exprs =3D check_exprs(parser.exprs)
+            self.docs =3D check_docs(parser.docs)
             self._entity_dict =3D {}
             self._predefining =3D True
             self._def_predefineds()
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
new file mode 100755
index 0000000000..83ded95c2d
--- /dev/null
+++ b/scripts/qapi2texi.py
@@ -0,0 +1,271 @@
+#!/usr/bin/env python
+# QAPI texi generator
+#
+# This work is licensed under the terms of the GNU LGPL, version 2+.
+# See the COPYING file in the top-level directory.
+"""This script produces the documentation of a qapi schema in texinfo fo=
rmat"""
+import re
+import sys
+
+import qapi
+
+COMMAND_FMT =3D """
+@deftypefn {type} {{}} {name}
+
+{body}
+
+@end deftypefn
+
+""".format
+
+ENUM_FMT =3D """
+@deftp Enum {name}
+
+{body}
+
+@end deftp
+
+""".format
+
+STRUCT_FMT =3D """
+@deftp {{{type}}} {name}
+
+{body}
+
+@end deftp
+
+""".format
+
+EXAMPLE_FMT =3D """@example
+{code}
+@end example
+""".format
+
+
+def subst_strong(doc):
+    """Replaces *foo* by @strong{foo}"""
+    return re.sub(r'\*([^*\n]+)\*', r'@emph{\1}', doc)
+
+
+def subst_emph(doc):
+    """Replaces _foo_ by @emph{foo}"""
+    return re.sub(r'\b_([^_\n]+)_\b', r' @emph{\1} ', doc)
+
+
+def subst_vars(doc):
+    """Replaces @var by @code{var}"""
+    return re.sub(r'@([\w-]+)', r'@code{\1}', doc)
+
+
+def subst_braces(doc):
+    """Replaces {} with @{ @}"""
+    return doc.replace("{", "@{").replace("}", "@}")
+
+
+def texi_example(doc):
+    """Format @example"""
+    # TODO: Neglects to escape @ characters.
+    # We should probably escape them in subst_braces(), and rename the
+    # function to subst_special() or subs_texi_special().  If we do that=
, we
+    # need to delay it until after subst_vars() in texi_format().
+    doc =3D subst_braces(doc).strip('\n')
+    return EXAMPLE_FMT(code=3Ddoc)
+
+
+def texi_format(doc):
+    """
+    Format documentation
+
+    Lines starting with:
+    - |: generates an @example
+    - =3D: generates @section
+    - =3D=3D: generates @subsection
+    - 1. or 1): generates an @enumerate @item
+    - */-: generates an @itemize list
+    """
+    lines =3D []
+    doc =3D subst_braces(doc)
+    doc =3D subst_vars(doc)
+    doc =3D subst_emph(doc)
+    doc =3D subst_strong(doc)
+    inlist =3D ""
+    lastempty =3D False
+    for line in doc.split('\n'):
+        empty =3D line =3D=3D ""
+
+        # FIXME: Doing this in a single if / elif chain is
+        # problematic.  For instance, a line without markup terminates
+        # a list if it follows a blank line (reaches the final elif),
+        # but a line with some *other* markup, such as a =3D title
+        # doesn't.
+        #
+        # Make sure to update section "Documentation markup" in
+        # docs/qapi-code-gen.txt when fixing this.
+        if line.startswith("| "):
+            line =3D EXAMPLE_FMT(code=3Dline[2:])
+        elif line.startswith("=3D "):
+            line =3D "@section " + line[2:]
+        elif line.startswith("=3D=3D "):
+            line =3D "@subsection " + line[3:]
+        elif re.match(r'^([0-9]*\.) ', line):
+            if not inlist:
+                lines.append("@enumerate")
+                inlist =3D "enumerate"
+            line =3D line[line.find(" ")+1:]
+            lines.append("@item")
+        elif re.match(r'^[*-] ', line):
+            if not inlist:
+                lines.append("@itemize %s" % {'*': "@bullet",
+                                              '-': "@minus"}[line[0]])
+                inlist =3D "itemize"
+            lines.append("@item")
+            line =3D line[2:]
+        elif lastempty and inlist:
+            lines.append("@end %s\n" % inlist)
+            inlist =3D ""
+
+        lastempty =3D empty
+        lines.append(line)
+
+    if inlist:
+        lines.append("@end %s\n" % inlist)
+    return "\n".join(lines)
+
+
+def texi_body(doc):
+    """
+    Format the body of a symbol documentation:
+    - main body
+    - table of arguments
+    - followed by "Returns/Notes/Since/Example" sections
+    """
+    body =3D texi_format(str(doc.body)) + "\n"
+    if doc.args:
+        body +=3D "@table @asis\n"
+        for arg, section in doc.args.iteritems():
+            desc =3D str(section)
+            opt =3D ''
+            if "#optional" in desc:
+                desc =3D desc.replace("#optional", "")
+                opt =3D ' (optional)'
+            body +=3D "@item @code{'%s'}%s\n%s\n" % (arg, opt,
+                                                   texi_format(desc))
+        body +=3D "@end table\n"
+
+    for section in doc.sections:
+        name, doc =3D (section.name, str(section))
+        func =3D texi_format
+        if name.startswith("Example"):
+            func =3D texi_example
+
+        if name:
+            # FIXME the indentation produced by @quotation in .txt and
+            # .html output is confusing
+            body +=3D "\n@quotation %s\n%s\n@end quotation" % \
+                    (name, func(doc))
+        else:
+            body +=3D func(doc)
+
+    return body
+
+
+def texi_alternate(expr, doc):
+    """Format an alternate to texi"""
+    body =3D texi_body(doc)
+    return STRUCT_FMT(type=3D"Alternate",
+                      name=3Ddoc.symbol,
+                      body=3Dbody)
+
+
+def texi_union(expr, doc):
+    """Format a union to texi"""
+    discriminator =3D expr.get("discriminator")
+    if discriminator:
+        union =3D "Flat Union"
+    else:
+        union =3D "Simple Union"
+
+    body =3D texi_body(doc)
+    return STRUCT_FMT(type=3Dunion,
+                      name=3Ddoc.symbol,
+                      body=3Dbody)
+
+
+def texi_enum(expr, doc):
+    """Format an enum to texi"""
+    for i in expr['data']:
+        if i not in doc.args:
+            doc.args[i] =3D ''
+    body =3D texi_body(doc)
+    return ENUM_FMT(name=3Ddoc.symbol,
+                    body=3Dbody)
+
+
+def texi_struct(expr, doc):
+    """Format a struct to texi"""
+    body =3D texi_body(doc)
+    return STRUCT_FMT(type=3D"Struct",
+                      name=3Ddoc.symbol,
+                      body=3Dbody)
+
+
+def texi_command(expr, doc):
+    """Format a command to texi"""
+    body =3D texi_body(doc)
+    return COMMAND_FMT(type=3D"Command",
+                       name=3Ddoc.symbol,
+                       body=3Dbody)
+
+
+def texi_event(expr, doc):
+    """Format an event to texi"""
+    body =3D texi_body(doc)
+    return COMMAND_FMT(type=3D"Event",
+                       name=3Ddoc.symbol,
+                       body=3Dbody)
+
+
+def texi_expr(expr, doc):
+    """Format an expr to texi"""
+    (kind, _) =3D expr.items()[0]
+
+    fmt =3D {"command": texi_command,
+           "struct": texi_struct,
+           "enum": texi_enum,
+           "union": texi_union,
+           "alternate": texi_alternate,
+           "event": texi_event}[kind]
+
+    return fmt(expr, doc)
+
+
+def texi(docs):
+    """Convert QAPI schema expressions to texi documentation"""
+    res =3D []
+    for doc in docs:
+        expr =3D doc.expr
+        if not expr:
+            res.append(texi_body(doc))
+            continue
+        try:
+            doc =3D texi_expr(expr, doc)
+            res.append(doc)
+        except:
+            print >>sys.stderr, "error at @%s" % doc.info
+            raise
+
+    return '\n'.join(res)
+
+
+def main(argv):
+    """Takes schema argument, prints result to stdout"""
+    if len(argv) !=3D 2:
+        print >>sys.stderr, "%s: need exactly 1 argument: SCHEMA" % argv=
[0]
+        sys.exit(1)
+
+    schema =3D qapi.QAPISchema(argv[1])
+    print texi(schema.docs)
+
+
+if __name__ =3D=3D "__main__":
+    main(sys.argv)
diff --git a/docs/qapi-code-gen.txt b/docs/qapi-code-gen.txt
index 2841c5144a..7eb7be12ab 100644
--- a/docs/qapi-code-gen.txt
+++ b/docs/qapi-code-gen.txt
@@ -44,40 +44,154 @@ Input must be ASCII (although QMP supports full Unic=
ode strings, the
 QAPI parser does not).  At present, there is no place where a QAPI
 schema requires the use of JSON numbers or null.
=20
+
+=3D=3D=3D Comments =3D=3D=3D
+
 Comments are allowed; anything between an unquoted # and the following
-newline is ignored.  Although there is not yet a documentation
-generator, a form of stylized comments has developed for consistently
-documenting details about an expression and when it was added to the
-schema.  The documentation is delimited between two lines of ##, then
-the first line names the expression, an optional overview is provided,
-then individual documentation about each member of 'data' is provided,
-and finally, a 'Since: x.y.z' tag lists the release that introduced
-the expression.  Optional members are tagged with the phrase
-'#optional', often with their default value; and extensions added
-after the expression was first released are also given a '(since
-x.y.z)' comment.  For example:
-
-    ##
-    # @BlockStats:
-    #
-    # Statistics of a virtual block device or a block backing device.
-    #
-    # @device: #optional If the stats are for a virtual block device, th=
e name
-    #          corresponding to the virtual block device.
-    #
-    # @stats:  A @BlockDeviceStats for the device.
-    #
-    # @parent: #optional This describes the file block device if it has =
one.
-    #
-    # @backing: #optional This describes the backing block device if it =
has one.
-    #           (Since 2.0)
-    #
-    # Since: 0.14.0
-    ##
-    { 'struct': 'BlockStats',
-      'data': {'*device': 'str', 'stats': 'BlockDeviceStats',
-               '*parent': 'BlockStats',
-               '*backing': 'BlockStats'} }
+newline is ignored.
+
+A multi-line comment that starts and ends with a '##' line is a
+documentation comment.  These are parsed by the documentation
+generator, which recognizes certain markup detailed below.
+
+
+=3D=3D=3D=3D Documentation markup =3D=3D=3D=3D
+
+Comment text starting with '=3D' is a section title:
+
+    # =3D Section title
+
+Double the '=3D' for a subsection title:
+
+    # =3D=3D Subection title
+
+'|' denotes examples:
+
+    # | Text of the example, may span
+    # | multiple lines
+
+'*' starts an itemized list:
+
+    # * First item, may span
+    #   multiple lines
+    # * Second item
+
+You can also use '-' instead of '*'.
+
+A decimal number followed by '.' starts a numbered list:
+
+    # 1. First item, may span
+    #    multiple lines
+    # 2. Second item
+
+The actual number doesn't matter.  You could even use '*' instead of
+'2.' for the second item.
+
+Lists can't be nested.  Blank lines are currently not supported within
+lists.
+
+Additional whitespace between the initial '#' and the comment text is
+permitted.
+
+*foo* and _foo_ are for strong and emphasis styles respectively (they
+do not work over multiple lines). @foo is used to reference a name in
+the schema.
+
+Example:
+
+##
+# =3D Section
+# =3D=3D Subsection
+#
+# Some text foo with *strong* and _emphasis_
+# 1. with a list
+# 2. like that
+#
+# And some code:
+# | $ echo foo
+# | -> do this
+# | <- get that
+#
+##
+
+
+=3D=3D=3D=3D Expression documentation =3D=3D=3D=3D
+
+Each expression that isn't an include directive must be preceded by a
+documentation block.  Such blocks are called expression documentation
+blocks.
+
+The documentation block consists of a first line naming the
+expression, an optional overview, a description of each argument (for
+commands and events) or member (for structs, unions and alternates),
+and optional tagged sections.
+
+FIXME: the parser accepts these things in almost any order.
+
+Optional arguments / members are tagged with the phrase '#optional',
+often with their default value; and extensions added after the
+expression was first released are also given a '(since x.y.z)'
+comment.
+
+A tagged section starts with one of the following words:
+"Note:"/"Notes:", "Since:", "Example"/"Examples", "Returns:", "TODO:".
+The section ends with the start of a new section.
+
+A 'Since: x.y.z' tagged section lists the release that introduced the
+expression.
+
+For example:
+
+##
+# @BlockStats:
+#
+# Statistics of a virtual block device or a block backing device.
+#
+# @device: #optional If the stats are for a virtual block device, the na=
me
+#          corresponding to the virtual block device.
+#
+# @node-name: #optional The node name of the device. (since 2.3)
+#
+# ... more members ...
+#
+# Since: 0.14.0
+##
+{ 'struct': 'BlockStats',
+  'data': {'*device': 'str', '*node-name': 'str',
+           ... more members ... } }
+
+##
+# @query-blockstats:
+#
+# Query the @BlockStats for all virtual block devices.
+#
+# @query-nodes: #optional If true, the command will query all the
+#               block nodes ... explain, explain ...  (since 2.3)
+#
+# Returns: A list of @BlockStats for each virtual block devices.
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-blockstats" }
+# <- {
+#      ... lots of output ...
+#    }
+#
+##
+{ 'command': 'query-blockstats',
+  'data': { '*query-nodes': 'bool' },
+  'returns': ['BlockStats'] }
+
+=3D=3D=3D=3D Free-form documentation =3D=3D=3D=3D
+
+A documentation block that isn't an expression documentation block is
+a free-form documentation block.  These may be used to provide
+additional text and structuring content.
+
+
+=3D=3D=3D Schema overview =3D=3D=3D
=20
 The schema sets up a series of types, as well as commands and events
 that will use those types.  Forward references are allowed: the parser
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 202901374c..96f59703a1 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -352,6 +352,24 @@ qapi-schema +=3D base-cycle-direct.json
 qapi-schema +=3D base-cycle-indirect.json
 qapi-schema +=3D command-int.json
 qapi-schema +=3D comments.json
+qapi-schema +=3D doc-bad-args.json
+qapi-schema +=3D doc-bad-symbol.json
+qapi-schema +=3D doc-duplicated-arg.json
+qapi-schema +=3D doc-duplicated-return.json
+qapi-schema +=3D doc-duplicated-since.json
+qapi-schema +=3D doc-empty-arg.json
+qapi-schema +=3D doc-empty-section.json
+qapi-schema +=3D doc-empty-symbol.json
+qapi-schema +=3D doc-interleaved-section.json
+qapi-schema +=3D doc-invalid-end.json
+qapi-schema +=3D doc-invalid-end2.json
+qapi-schema +=3D doc-invalid-return.json
+qapi-schema +=3D doc-invalid-section.json
+qapi-schema +=3D doc-invalid-start.json
+qapi-schema +=3D doc-missing-colon.json
+qapi-schema +=3D doc-missing-expr.json
+qapi-schema +=3D doc-missing-space.json
+qapi-schema +=3D doc-optional.json
 qapi-schema +=3D double-data.json
 qapi-schema +=3D double-type.json
 qapi-schema +=3D duplicate-key.json
@@ -445,6 +463,8 @@ qapi-schema +=3D union-optional-branch.json
 qapi-schema +=3D union-unknown.json
 qapi-schema +=3D unknown-escape.json
 qapi-schema +=3D unknown-expr-key.json
+
+
 check-qapi-schema-y :=3D $(addprefix tests/qapi-schema/, $(qapi-schema))
=20
 GENERATED_HEADERS +=3D tests/test-qapi-types.h tests/test-qapi-visit.h \
diff --git a/tests/qapi-schema/alternate-any.err b/tests/qapi-schema/alte=
rnate-any.err
index aaa0154731..395c8ab583 100644
--- a/tests/qapi-schema/alternate-any.err
+++ b/tests/qapi-schema/alternate-any.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-any.json:2: Alternate 'Alt' member 'one' can=
not use type 'any'
+tests/qapi-schema/alternate-any.json:6: Alternate 'Alt' member 'one' can=
not use type 'any'
diff --git a/tests/qapi-schema/alternate-any.json b/tests/qapi-schema/alt=
ernate-any.json
index e47a73a116..c958776767 100644
--- a/tests/qapi-schema/alternate-any.json
+++ b/tests/qapi-schema/alternate-any.json
@@ -1,4 +1,8 @@
 # we do not allow the 'any' type as an alternate branch
+
+##
+# @Alt:
+##
 { 'alternate': 'Alt',
   'data': { 'one': 'any',
             'two': 'int' } }
diff --git a/tests/qapi-schema/alternate-array.err b/tests/qapi-schema/al=
ternate-array.err
index 7b930c64ab..09628e9755 100644
--- a/tests/qapi-schema/alternate-array.err
+++ b/tests/qapi-schema/alternate-array.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-array.json:5: Member 'two' of alternate 'Alt=
' cannot be an array
+tests/qapi-schema/alternate-array.json:12: Member 'two' of alternate 'Al=
t' cannot be an array
diff --git a/tests/qapi-schema/alternate-array.json b/tests/qapi-schema/a=
lternate-array.json
index f241aac122..c2f98ad608 100644
--- a/tests/qapi-schema/alternate-array.json
+++ b/tests/qapi-schema/alternate-array.json
@@ -1,7 +1,14 @@
 # we do not allow array branches in alternates
+
+##
+# @One:
+##
 # TODO: should we support this?
 { 'struct': 'One',
   'data': { 'name': 'str' } }
+##
+# @Alt:
+##
 { 'alternate': 'Alt',
   'data': { 'one': 'One',
             'two': [ 'int' ] } }
diff --git a/tests/qapi-schema/alternate-base.err b/tests/qapi-schema/alt=
ernate-base.err
index 30d8a34373..3b679140e0 100644
--- a/tests/qapi-schema/alternate-base.err
+++ b/tests/qapi-schema/alternate-base.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-base.json:4: Unknown key 'base' in alternate=
 'Alt'
+tests/qapi-schema/alternate-base.json:11: Unknown key 'base' in alternat=
e 'Alt'
diff --git a/tests/qapi-schema/alternate-base.json b/tests/qapi-schema/al=
ternate-base.json
index 529430ecf2..9612b7925d 100644
--- a/tests/qapi-schema/alternate-base.json
+++ b/tests/qapi-schema/alternate-base.json
@@ -1,6 +1,13 @@
 # we reject alternate with base type
+
+##
+# @Base:
+##
 { 'struct': 'Base',
   'data': { 'string': 'str' } }
+##
+# @Alt:
+##
 { 'alternate': 'Alt',
   'base': 'Base',
   'data': { 'number': 'int' } }
diff --git a/tests/qapi-schema/alternate-clash.err b/tests/qapi-schema/al=
ternate-clash.err
index 604d8495eb..f07c3e8ad3 100644
--- a/tests/qapi-schema/alternate-clash.err
+++ b/tests/qapi-schema/alternate-clash.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-clash.json:7: 'a_b' (branch of Alt1) collide=
s with 'a-b' (branch of Alt1)
+tests/qapi-schema/alternate-clash.json:11: 'a_b' (branch of Alt1) collid=
es with 'a-b' (branch of Alt1)
diff --git a/tests/qapi-schema/alternate-clash.json b/tests/qapi-schema/a=
lternate-clash.json
index 6d73bc527b..97ca7c80e7 100644
--- a/tests/qapi-schema/alternate-clash.json
+++ b/tests/qapi-schema/alternate-clash.json
@@ -4,5 +4,9 @@
 # TODO: In the future, if alternates are simplified to not generate
 # the implicit Alt1Kind enum, we would still have a collision with the
 # resulting C union trying to have two members named 'a_b'.
+
+##
+# @Alt1:
+##
 { 'alternate': 'Alt1',
   'data': { 'a-b': 'str', 'a_b': 'int' } }
diff --git a/tests/qapi-schema/alternate-conflict-dict.err b/tests/qapi-s=
chema/alternate-conflict-dict.err
index 0f411f4faf..7cb023fdd8 100644
--- a/tests/qapi-schema/alternate-conflict-dict.err
+++ b/tests/qapi-schema/alternate-conflict-dict.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-conflict-dict.json:6: Alternate 'Alt' member=
 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-dict.json:16: Alternate 'Alt' membe=
r 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-dict.json b/tests/qapi-=
schema/alternate-conflict-dict.json
index d566cca816..9f9d97fa2e 100644
--- a/tests/qapi-schema/alternate-conflict-dict.json
+++ b/tests/qapi-schema/alternate-conflict-dict.json
@@ -1,8 +1,18 @@
 # we reject alternates with multiple object branches
+
+##
+# @One:
+##
 { 'struct': 'One',
   'data': { 'name': 'str' } }
+##
+# @Two:
+##
 { 'struct': 'Two',
   'data': { 'value': 'int' } }
+##
+# @Alt:
+##
 { 'alternate': 'Alt',
   'data': { 'one': 'One',
             'two': 'Two' } }
diff --git a/tests/qapi-schema/alternate-conflict-string.err b/tests/qapi=
-schema/alternate-conflict-string.err
index fc523b0879..6dbbacd1d2 100644
--- a/tests/qapi-schema/alternate-conflict-string.err
+++ b/tests/qapi-schema/alternate-conflict-string.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-conflict-string.json:4: Alternate 'Alt' memb=
er 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-string.json:11: Alternate 'Alt' mem=
ber 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-string.json b/tests/qap=
i-schema/alternate-conflict-string.json
index 72f04a820a..12aafab808 100644
--- a/tests/qapi-schema/alternate-conflict-string.json
+++ b/tests/qapi-schema/alternate-conflict-string.json
@@ -1,6 +1,13 @@
 # we reject alternates with multiple string-like branches
+
+##
+# @Enum:
+##
 { 'enum': 'Enum',
   'data': [ 'hello', 'world' ] }
+##
+# @Alt:
+##
 { 'alternate': 'Alt',
   'data': { 'one': 'str',
             'two': 'Enum' } }
diff --git a/tests/qapi-schema/alternate-empty.err b/tests/qapi-schema/al=
ternate-empty.err
index bb06c5bfec..8245ce3103 100644
--- a/tests/qapi-schema/alternate-empty.err
+++ b/tests/qapi-schema/alternate-empty.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-empty.json:2: Alternate 'Alt' should have at=
 least two branches in 'data'
+tests/qapi-schema/alternate-empty.json:6: Alternate 'Alt' should have at=
 least two branches in 'data'
diff --git a/tests/qapi-schema/alternate-empty.json b/tests/qapi-schema/a=
lternate-empty.json
index fff15baf16..db54405240 100644
--- a/tests/qapi-schema/alternate-empty.json
+++ b/tests/qapi-schema/alternate-empty.json
@@ -1,2 +1,6 @@
 # alternates must list at least two types to be useful
+
+##
+# @Alt:
+##
 { 'alternate': 'Alt', 'data': { 'i': 'int' } }
diff --git a/tests/qapi-schema/alternate-nested.err b/tests/qapi-schema/a=
lternate-nested.err
index 4d1187e60e..1804ffbf47 100644
--- a/tests/qapi-schema/alternate-nested.err
+++ b/tests/qapi-schema/alternate-nested.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-nested.json:4: Member 'nested' of alternate =
'Alt2' cannot use alternate type 'Alt1'
+tests/qapi-schema/alternate-nested.json:11: Member 'nested' of alternate=
 'Alt2' cannot use alternate type 'Alt1'
diff --git a/tests/qapi-schema/alternate-nested.json b/tests/qapi-schema/=
alternate-nested.json
index 8e22186491..9f83ebe2e0 100644
--- a/tests/qapi-schema/alternate-nested.json
+++ b/tests/qapi-schema/alternate-nested.json
@@ -1,5 +1,12 @@
 # we reject a nested alternate branch
+
+##
+# @Alt1:
+##
 { 'alternate': 'Alt1',
   'data': { 'name': 'str', 'value': 'int' } }
+##
+# @Alt2:
+##
 { 'alternate': 'Alt2',
   'data': { 'nested': 'Alt1', 'b': 'bool' } }
diff --git a/tests/qapi-schema/alternate-unknown.err b/tests/qapi-schema/=
alternate-unknown.err
index dea45dc730..cf5b9b6830 100644
--- a/tests/qapi-schema/alternate-unknown.err
+++ b/tests/qapi-schema/alternate-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-unknown.json:2: Member 'unknown' of alternat=
e 'Alt' uses unknown type 'MissingType'
+tests/qapi-schema/alternate-unknown.json:6: Member 'unknown' of alternat=
e 'Alt' uses unknown type 'MissingType'
diff --git a/tests/qapi-schema/alternate-unknown.json b/tests/qapi-schema=
/alternate-unknown.json
index 08c80dced0..941ba1fac4 100644
--- a/tests/qapi-schema/alternate-unknown.json
+++ b/tests/qapi-schema/alternate-unknown.json
@@ -1,3 +1,7 @@
 # we reject an alternate with unknown type in branch
+
+##
+# @Alt:
+##
 { 'alternate': 'Alt',
   'data': { 'unknown': 'MissingType', 'i': 'int' } }
diff --git a/tests/qapi-schema/args-alternate.err b/tests/qapi-schema/arg=
s-alternate.err
index 3086eae56b..2e6bf54245 100644
--- a/tests/qapi-schema/args-alternate.err
+++ b/tests/qapi-schema/args-alternate.err
@@ -1 +1 @@
-tests/qapi-schema/args-alternate.json:3: 'data' for command 'oops' canno=
t use alternate type 'Alt'
+tests/qapi-schema/args-alternate.json:11: 'data' for command 'oops' cann=
ot use alternate type 'Alt'
diff --git a/tests/qapi-schema/args-alternate.json b/tests/qapi-schema/ar=
gs-alternate.json
index 69e94d4819..49d0211a03 100644
--- a/tests/qapi-schema/args-alternate.json
+++ b/tests/qapi-schema/args-alternate.json
@@ -1,3 +1,11 @@
 # we do not allow alternate arguments
+
+##
+# @Alt:
+##
 { 'alternate': 'Alt', 'data': { 'case1': 'int', 'case2': 'str' } }
+
+##
+# @oops:
+##
 { 'command': 'oops', 'data': 'Alt' }
diff --git a/tests/qapi-schema/args-any.err b/tests/qapi-schema/args-any.=
err
index bf9b5e0730..955504b10f 100644
--- a/tests/qapi-schema/args-any.err
+++ b/tests/qapi-schema/args-any.err
@@ -1 +1 @@
-tests/qapi-schema/args-any.json:2: 'data' for command 'oops' cannot use =
built-in type 'any'
+tests/qapi-schema/args-any.json:6: 'data' for command 'oops' cannot use =
built-in type 'any'
diff --git a/tests/qapi-schema/args-any.json b/tests/qapi-schema/args-any=
.json
index 58fe5e470e..f494479cc9 100644
--- a/tests/qapi-schema/args-any.json
+++ b/tests/qapi-schema/args-any.json
@@ -1,2 +1,6 @@
 # we do not allow an 'any' argument
+
+##
+# @oops:
+##
 { 'command': 'oops', 'data': 'any' }
diff --git a/tests/qapi-schema/args-array-empty.err b/tests/qapi-schema/a=
rgs-array-empty.err
index cb7ed33b3f..e85f7918ab 100644
--- a/tests/qapi-schema/args-array-empty.err
+++ b/tests/qapi-schema/args-array-empty.err
@@ -1 +1 @@
-tests/qapi-schema/args-array-empty.json:2: Member 'empty' of 'data' for =
command 'oops': array type must contain single type name
+tests/qapi-schema/args-array-empty.json:6: Member 'empty' of 'data' for =
command 'oops': array type must contain single type name
diff --git a/tests/qapi-schema/args-array-empty.json b/tests/qapi-schema/=
args-array-empty.json
index 652dcfb24a..78a0b88221 100644
--- a/tests/qapi-schema/args-array-empty.json
+++ b/tests/qapi-schema/args-array-empty.json
@@ -1,2 +1,6 @@
 # we reject an array for data if it does not contain a known type
+
+##
+# @oops:
+##
 { 'command': 'oops', 'data': { 'empty': [ ] } }
diff --git a/tests/qapi-schema/args-array-unknown.err b/tests/qapi-schema=
/args-array-unknown.err
index cd7a0f98d7..77788de099 100644
--- a/tests/qapi-schema/args-array-unknown.err
+++ b/tests/qapi-schema/args-array-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/args-array-unknown.json:2: Member 'array' of 'data' fo=
r command 'oops' uses unknown type 'NoSuchType'
+tests/qapi-schema/args-array-unknown.json:6: Member 'array' of 'data' fo=
r command 'oops' uses unknown type 'NoSuchType'
diff --git a/tests/qapi-schema/args-array-unknown.json b/tests/qapi-schem=
a/args-array-unknown.json
index 6f3e883315..f680fc10d3 100644
--- a/tests/qapi-schema/args-array-unknown.json
+++ b/tests/qapi-schema/args-array-unknown.json
@@ -1,2 +1,6 @@
 # we reject an array for data if it does not contain a known type
+
+##
+# @oops:
+##
 { 'command': 'oops', 'data': { 'array': [ 'NoSuchType' ] } }
diff --git a/tests/qapi-schema/args-bad-boxed.err b/tests/qapi-schema/arg=
s-bad-boxed.err
index ad0d417321..87a906137a 100644
--- a/tests/qapi-schema/args-bad-boxed.err
+++ b/tests/qapi-schema/args-bad-boxed.err
@@ -1 +1 @@
-tests/qapi-schema/args-bad-boxed.json:2: 'boxed' of command 'foo' should=
 only use true value
+tests/qapi-schema/args-bad-boxed.json:6: 'boxed' of command 'foo' should=
 only use true value
diff --git a/tests/qapi-schema/args-bad-boxed.json b/tests/qapi-schema/ar=
gs-bad-boxed.json
index dea0cd0aa5..4c0b28f291 100644
--- a/tests/qapi-schema/args-bad-boxed.json
+++ b/tests/qapi-schema/args-bad-boxed.json
@@ -1,2 +1,6 @@
 # 'boxed' should only appear with value true
+
+##
+# @foo:
+##
 { 'command': 'foo', 'boxed': false }
diff --git a/tests/qapi-schema/args-boxed-anon.err b/tests/qapi-schema/ar=
gs-boxed-anon.err
index f24f345218..3cfac0b923 100644
--- a/tests/qapi-schema/args-boxed-anon.err
+++ b/tests/qapi-schema/args-boxed-anon.err
@@ -1 +1 @@
-tests/qapi-schema/args-boxed-anon.json:2: 'data' for command 'foo' shoul=
d be a type name
+tests/qapi-schema/args-boxed-anon.json:6: 'data' for command 'foo' shoul=
d be a type name
diff --git a/tests/qapi-schema/args-boxed-anon.json b/tests/qapi-schema/a=
rgs-boxed-anon.json
index 95f60da2ed..2358e6abb1 100644
--- a/tests/qapi-schema/args-boxed-anon.json
+++ b/tests/qapi-schema/args-boxed-anon.json
@@ -1,2 +1,6 @@
 # 'boxed' can only be used with named types
+
+##
+# @foo:
+##
 { 'command': 'foo', 'boxed': true, 'data': { 'string': 'str' } }
diff --git a/tests/qapi-schema/args-boxed-empty.err b/tests/qapi-schema/a=
rgs-boxed-empty.err
index 039603e85c..963f495a9d 100644
--- a/tests/qapi-schema/args-boxed-empty.err
+++ b/tests/qapi-schema/args-boxed-empty.err
@@ -1 +1 @@
-tests/qapi-schema/args-boxed-empty.json:3: Cannot use 'boxed' with empty=
 type
+tests/qapi-schema/args-boxed-empty.json:11: Cannot use 'boxed' with empt=
y type
diff --git a/tests/qapi-schema/args-boxed-empty.json b/tests/qapi-schema/=
args-boxed-empty.json
index 52717e065f..8e8cc26525 100644
--- a/tests/qapi-schema/args-boxed-empty.json
+++ b/tests/qapi-schema/args-boxed-empty.json
@@ -1,3 +1,11 @@
 # 'boxed' requires a non-empty type
+
+##
+# @Empty:
+##
 { 'struct': 'Empty', 'data': {} }
+
+##
+# @foo:
+##
 { 'command': 'foo', 'boxed': true, 'data': 'Empty' }
diff --git a/tests/qapi-schema/args-boxed-string.err b/tests/qapi-schema/=
args-boxed-string.err
index d326b48aef..7623755208 100644
--- a/tests/qapi-schema/args-boxed-string.err
+++ b/tests/qapi-schema/args-boxed-string.err
@@ -1 +1 @@
-tests/qapi-schema/args-boxed-string.json:2: 'data' for command 'foo' can=
not use built-in type 'str'
+tests/qapi-schema/args-boxed-string.json:6: 'data' for command 'foo' can=
not use built-in type 'str'
diff --git a/tests/qapi-schema/args-boxed-string.json b/tests/qapi-schema=
/args-boxed-string.json
index f91a1502e7..aecdf97ce9 100644
--- a/tests/qapi-schema/args-boxed-string.json
+++ b/tests/qapi-schema/args-boxed-string.json
@@ -1,2 +1,6 @@
 # 'boxed' requires a complex (not built-in) type
+
+##
+# @foo:
+##
 { 'command': 'foo', 'boxed': true, 'data': 'str' }
diff --git a/tests/qapi-schema/args-int.err b/tests/qapi-schema/args-int.=
err
index dc1d2504ff..38b3202b09 100644
--- a/tests/qapi-schema/args-int.err
+++ b/tests/qapi-schema/args-int.err
@@ -1 +1 @@
-tests/qapi-schema/args-int.json:2: 'data' for command 'oops' cannot use =
built-in type 'int'
+tests/qapi-schema/args-int.json:6: 'data' for command 'oops' cannot use =
built-in type 'int'
diff --git a/tests/qapi-schema/args-int.json b/tests/qapi-schema/args-int=
.json
index a334d92e8c..7f4e1b7aa6 100644
--- a/tests/qapi-schema/args-int.json
+++ b/tests/qapi-schema/args-int.json
@@ -1,2 +1,6 @@
 # we reject commands where data is not an array or complex type
+
+##
+# @oops:
+##
 { 'command': 'oops', 'data': 'int' }
diff --git a/tests/qapi-schema/args-invalid.err b/tests/qapi-schema/args-=
invalid.err
index fe1e94975b..5d3568d7c3 100644
--- a/tests/qapi-schema/args-invalid.err
+++ b/tests/qapi-schema/args-invalid.err
@@ -1 +1 @@
-tests/qapi-schema/args-invalid.json:1: 'data' for command 'foo' should b=
e a dictionary or type name
+tests/qapi-schema/args-invalid.json:4: 'data' for command 'foo' should b=
e a dictionary or type name
diff --git a/tests/qapi-schema/args-invalid.json b/tests/qapi-schema/args=
-invalid.json
index db0981341b..1a7e63bb23 100644
--- a/tests/qapi-schema/args-invalid.json
+++ b/tests/qapi-schema/args-invalid.json
@@ -1,2 +1,5 @@
+##
+# @foo:
+##
 { 'command': 'foo',
   'data': false }
diff --git a/tests/qapi-schema/args-member-array-bad.err b/tests/qapi-sch=
ema/args-member-array-bad.err
index 881b4d954f..825ffca9bf 100644
--- a/tests/qapi-schema/args-member-array-bad.err
+++ b/tests/qapi-schema/args-member-array-bad.err
@@ -1 +1 @@
-tests/qapi-schema/args-member-array-bad.json:2: Member 'member' of 'data=
' for command 'oops': array type must contain single type name
+tests/qapi-schema/args-member-array-bad.json:6: Member 'member' of 'data=
' for command 'oops': array type must contain single type name
diff --git a/tests/qapi-schema/args-member-array-bad.json b/tests/qapi-sc=
hema/args-member-array-bad.json
index b2ff144ec6..e934f5c457 100644
--- a/tests/qapi-schema/args-member-array-bad.json
+++ b/tests/qapi-schema/args-member-array-bad.json
@@ -1,2 +1,6 @@
 # we reject data if it does not contain a valid array type
+
+##
+# @oops:
+##
 { 'command': 'oops', 'data': { 'member': [ { 'nested': 'str' } ] } }
diff --git a/tests/qapi-schema/args-member-case.err b/tests/qapi-schema/a=
rgs-member-case.err
index 19c4426601..a3fb2bdd60 100644
--- a/tests/qapi-schema/args-member-case.err
+++ b/tests/qapi-schema/args-member-case.err
@@ -1 +1 @@
-tests/qapi-schema/args-member-case.json:2: 'Arg' (parameter of no-way-th=
is-will-get-whitelisted) should not use uppercase
+tests/qapi-schema/args-member-case.json:6: 'Arg' (parameter of no-way-th=
is-will-get-whitelisted) should not use uppercase
diff --git a/tests/qapi-schema/args-member-case.json b/tests/qapi-schema/=
args-member-case.json
index 93439bee8b..811e658d66 100644
--- a/tests/qapi-schema/args-member-case.json
+++ b/tests/qapi-schema/args-member-case.json
@@ -1,2 +1,6 @@
 # Member names should be 'lower-case' unless the struct/command is white=
listed
+
+##
+# @no-way-this-will-get-whitelisted:
+##
 { 'command': 'no-way-this-will-get-whitelisted', 'data': { 'Arg': 'int' =
} }
diff --git a/tests/qapi-schema/args-member-unknown.err b/tests/qapi-schem=
a/args-member-unknown.err
index f6f82828ce..3db452b95a 100644
--- a/tests/qapi-schema/args-member-unknown.err
+++ b/tests/qapi-schema/args-member-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/args-member-unknown.json:2: Member 'member' of 'data' =
for command 'oops' uses unknown type 'NoSuchType'
+tests/qapi-schema/args-member-unknown.json:6: Member 'member' of 'data' =
for command 'oops' uses unknown type 'NoSuchType'
diff --git a/tests/qapi-schema/args-member-unknown.json b/tests/qapi-sche=
ma/args-member-unknown.json
index 342a41ec90..e2fef9c46f 100644
--- a/tests/qapi-schema/args-member-unknown.json
+++ b/tests/qapi-schema/args-member-unknown.json
@@ -1,2 +1,6 @@
 # we reject data if it does not contain a known type
+
+##
+# @oops:
+##
 { 'command': 'oops', 'data': { 'member': 'NoSuchType' } }
diff --git a/tests/qapi-schema/args-name-clash.err b/tests/qapi-schema/ar=
gs-name-clash.err
index d953e8d241..23988cb5ca 100644
--- a/tests/qapi-schema/args-name-clash.err
+++ b/tests/qapi-schema/args-name-clash.err
@@ -1 +1 @@
-tests/qapi-schema/args-name-clash.json:4: 'a_b' (parameter of oops) coll=
ides with 'a-b' (parameter of oops)
+tests/qapi-schema/args-name-clash.json:8: 'a_b' (parameter of oops) coll=
ides with 'a-b' (parameter of oops)
diff --git a/tests/qapi-schema/args-name-clash.json b/tests/qapi-schema/a=
rgs-name-clash.json
index 61423cb893..991323b78d 100644
--- a/tests/qapi-schema/args-name-clash.json
+++ b/tests/qapi-schema/args-name-clash.json
@@ -1,4 +1,8 @@
 # C member name collision
 # Reject members that clash when mapped to C names (we would have two 'a=
_b'
 # members).
+
+##
+# @oops:
+##
 { 'command': 'oops', 'data': { 'a-b': 'str', 'a_b': 'str' } }
diff --git a/tests/qapi-schema/args-union.err b/tests/qapi-schema/args-un=
ion.err
index f8ad223dde..ce0a34e16c 100644
--- a/tests/qapi-schema/args-union.err
+++ b/tests/qapi-schema/args-union.err
@@ -1 +1 @@
-tests/qapi-schema/args-union.json:3: 'data' for command 'oops' cannot us=
e union type 'Uni'
+tests/qapi-schema/args-union.json:10: 'data' for command 'oops' cannot u=
se union type 'Uni'
diff --git a/tests/qapi-schema/args-union.json b/tests/qapi-schema/args-u=
nion.json
index 2fcaeaae16..57284b43c5 100644
--- a/tests/qapi-schema/args-union.json
+++ b/tests/qapi-schema/args-union.json
@@ -1,3 +1,10 @@
 # use of union arguments requires 'boxed':true
+
+##
+# @Uni:
+##
 { 'union': 'Uni', 'data': { 'case1': 'int', 'case2': 'str' } }
+##
+# oops:
+##
 { 'command': 'oops', 'data': 'Uni' }
diff --git a/tests/qapi-schema/args-unknown.err b/tests/qapi-schema/args-=
unknown.err
index 4d91ec869f..ba6c6cf326 100644
--- a/tests/qapi-schema/args-unknown.err
+++ b/tests/qapi-schema/args-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/args-unknown.json:2: 'data' for command 'oops' uses un=
known type 'NoSuchType'
+tests/qapi-schema/args-unknown.json:6: 'data' for command 'oops' uses un=
known type 'NoSuchType'
diff --git a/tests/qapi-schema/args-unknown.json b/tests/qapi-schema/args=
-unknown.json
index 32aba43b3f..12666dc020 100644
--- a/tests/qapi-schema/args-unknown.json
+++ b/tests/qapi-schema/args-unknown.json
@@ -1,2 +1,6 @@
 # we reject data if it does not contain a known type
+
+##
+# @oops:
+##
 { 'command': 'oops', 'data': 'NoSuchType' }
diff --git a/tests/qapi-schema/bad-base.err b/tests/qapi-schema/bad-base.=
err
index 154274bdd3..e668761c65 100644
--- a/tests/qapi-schema/bad-base.err
+++ b/tests/qapi-schema/bad-base.err
@@ -1 +1 @@
-tests/qapi-schema/bad-base.json:3: 'base' for struct 'MyType' cannot use=
 union type 'Union'
+tests/qapi-schema/bad-base.json:10: 'base' for struct 'MyType' cannot us=
e union type 'Union'
diff --git a/tests/qapi-schema/bad-base.json b/tests/qapi-schema/bad-base=
.json
index a634331cdd..c3faa8242b 100644
--- a/tests/qapi-schema/bad-base.json
+++ b/tests/qapi-schema/bad-base.json
@@ -1,3 +1,10 @@
 # we reject a base that is not a struct
+
+##
+# @Union:
+##
 { 'union': 'Union', 'data': { 'a': 'int', 'b': 'str' } }
+##
+# @MyType:
+##
 { 'struct': 'MyType', 'base': 'Union', 'data': { 'c': 'int' } }
diff --git a/tests/qapi-schema/bad-data.err b/tests/qapi-schema/bad-data.=
err
index 8523ac4f46..c1b9e35313 100644
--- a/tests/qapi-schema/bad-data.err
+++ b/tests/qapi-schema/bad-data.err
@@ -1 +1 @@
-tests/qapi-schema/bad-data.json:2: 'data' for command 'oops' cannot be a=
n array
+tests/qapi-schema/bad-data.json:6: 'data' for command 'oops' cannot be a=
n array
diff --git a/tests/qapi-schema/bad-data.json b/tests/qapi-schema/bad-data=
.json
index 832eeb76f4..51c444f4f8 100644
--- a/tests/qapi-schema/bad-data.json
+++ b/tests/qapi-schema/bad-data.json
@@ -1,2 +1,6 @@
 # we ensure 'data' is a dictionary for all but enums
+
+##
+# @oops:
+##
 { 'command': 'oops', 'data': [ ] }
diff --git a/tests/qapi-schema/bad-ident.err b/tests/qapi-schema/bad-iden=
t.err
index c4190602b5..b757aa21e7 100644
--- a/tests/qapi-schema/bad-ident.err
+++ b/tests/qapi-schema/bad-ident.err
@@ -1 +1 @@
-tests/qapi-schema/bad-ident.json:2: 'struct' does not allow optional nam=
e '*oops'
+tests/qapi-schema/bad-ident.json:6: 'struct' does not allow optional nam=
e '*oops'
diff --git a/tests/qapi-schema/bad-ident.json b/tests/qapi-schema/bad-ide=
nt.json
index 763627ad23..b43df7a3e0 100644
--- a/tests/qapi-schema/bad-ident.json
+++ b/tests/qapi-schema/bad-ident.json
@@ -1,2 +1,6 @@
 # we reject creating a type name with bad name
+
+##
+# @*oops:
+##
 { 'struct': '*oops', 'data': { 'i': 'int' } }
diff --git a/tests/qapi-schema/bad-type-bool.err b/tests/qapi-schema/bad-=
type-bool.err
index 62fd70baaf..72e026b46c 100644
--- a/tests/qapi-schema/bad-type-bool.err
+++ b/tests/qapi-schema/bad-type-bool.err
@@ -1 +1 @@
-tests/qapi-schema/bad-type-bool.json:2: 'struct' key must have a string =
value
+tests/qapi-schema/bad-type-bool.json:6: 'struct' key must have a string =
value
diff --git a/tests/qapi-schema/bad-type-bool.json b/tests/qapi-schema/bad=
-type-bool.json
index bde17b56c4..1f9eddf938 100644
--- a/tests/qapi-schema/bad-type-bool.json
+++ b/tests/qapi-schema/bad-type-bool.json
@@ -1,2 +1,6 @@
 # we reject an expression with a metatype that is not a string
+
+##
+# @true:
+##
 { 'struct': true, 'data': { } }
diff --git a/tests/qapi-schema/bad-type-dict.err b/tests/qapi-schema/bad-=
type-dict.err
index 0b2a2aeac4..d0d1f607e5 100644
--- a/tests/qapi-schema/bad-type-dict.err
+++ b/tests/qapi-schema/bad-type-dict.err
@@ -1 +1 @@
-tests/qapi-schema/bad-type-dict.json:2: 'command' key must have a string=
 value
+tests/qapi-schema/bad-type-dict.json:6: 'command' key must have a string=
 value
diff --git a/tests/qapi-schema/bad-type-dict.json b/tests/qapi-schema/bad=
-type-dict.json
index 2a91b241f8..5952caab28 100644
--- a/tests/qapi-schema/bad-type-dict.json
+++ b/tests/qapi-schema/bad-type-dict.json
@@ -1,2 +1,6 @@
 # we reject an expression with a metatype that is not a string
+
+##
+# @foo:
+##
 { 'command': { } }
diff --git a/tests/qapi-schema/base-cycle-direct.err b/tests/qapi-schema/=
base-cycle-direct.err
index 9c68f6543d..dd7f5aace6 100644
--- a/tests/qapi-schema/base-cycle-direct.err
+++ b/tests/qapi-schema/base-cycle-direct.err
@@ -1 +1 @@
-tests/qapi-schema/base-cycle-direct.json:2: Object Loopy contains itself
+tests/qapi-schema/base-cycle-direct.json:6: Object Loopy contains itself
diff --git a/tests/qapi-schema/base-cycle-direct.json b/tests/qapi-schema=
/base-cycle-direct.json
index 4fc66d0516..9780f7e2ca 100644
--- a/tests/qapi-schema/base-cycle-direct.json
+++ b/tests/qapi-schema/base-cycle-direct.json
@@ -1,2 +1,6 @@
 # we reject a loop in base classes
+
+##
+# @Loopy:
+##
 { 'struct': 'Loopy', 'base': 'Loopy', 'data': {} }
diff --git a/tests/qapi-schema/base-cycle-indirect.err b/tests/qapi-schem=
a/base-cycle-indirect.err
index fc92fe47f8..f4198e4a40 100644
--- a/tests/qapi-schema/base-cycle-indirect.err
+++ b/tests/qapi-schema/base-cycle-indirect.err
@@ -1 +1 @@
-tests/qapi-schema/base-cycle-indirect.json:2: Object Base1 contains itse=
lf
+tests/qapi-schema/base-cycle-indirect.json:6: Object Base1 contains itse=
lf
diff --git a/tests/qapi-schema/base-cycle-indirect.json b/tests/qapi-sche=
ma/base-cycle-indirect.json
index 28667721a3..99926c4609 100644
--- a/tests/qapi-schema/base-cycle-indirect.json
+++ b/tests/qapi-schema/base-cycle-indirect.json
@@ -1,3 +1,10 @@
 # we reject a loop in base classes
+
+##
+# @Base1:
+##
 { 'struct': 'Base1', 'base': 'Base2', 'data': {} }
+##
+# @Base2:
+##
 { 'struct': 'Base2', 'base': 'Base1', 'data': {} }
diff --git a/tests/qapi-schema/command-int.err b/tests/qapi-schema/comman=
d-int.err
index 0f9300679b..3c834a97ab 100644
--- a/tests/qapi-schema/command-int.err
+++ b/tests/qapi-schema/command-int.err
@@ -1 +1 @@
-tests/qapi-schema/command-int.json:2: built-in 'int' is already defined
+tests/qapi-schema/command-int.json:6: built-in 'int' is already defined
diff --git a/tests/qapi-schema/command-int.json b/tests/qapi-schema/comma=
nd-int.json
index 9a62554fc6..5b51bf148b 100644
--- a/tests/qapi-schema/command-int.json
+++ b/tests/qapi-schema/command-int.json
@@ -1,2 +1,6 @@
 # we reject collisions between commands and types
+
+##
+# @int:
+##
 { 'command': 'int', 'data': { 'character': 'str' } }
diff --git a/tests/qapi-schema/comments.json b/tests/qapi-schema/comments=
.json
index e643f3a74c..d31ef0d90a 100644
--- a/tests/qapi-schema/comments.json
+++ b/tests/qapi-schema/comments.json
@@ -1,4 +1,8 @@
 # Unindented comment
+
+##
+# @Status:
+##
 { 'enum': 'Status',             # Comment to the right of code
   # Indented comment
   'data': [ 'good', 'bad', 'ugly' ] }
diff --git a/tests/qapi-schema/comments.out b/tests/qapi-schema/comments.=
out
index 5d7c13cad1..ab3d74f49f 100644
--- a/tests/qapi-schema/comments.out
+++ b/tests/qapi-schema/comments.out
@@ -2,3 +2,6 @@ enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', =
'qlist', 'qfloat', 'qbo
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
 object q_empty
+doc symbol=3DStatus expr=3D('enum', 'Status')
+    body=3D
+
diff --git a/tests/qapi-schema/doc-bad-args.err b/tests/qapi-schema/doc-b=
ad-args.err
new file mode 100644
index 0000000000..5d44d9b668
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-args.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-bad-args.json:3: The following documented members =
are not in the declaration: b
diff --git a/tests/qapi-schema/doc-bad-args.exit b/tests/qapi-schema/doc-=
bad-args.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-args.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-bad-args.json b/tests/qapi-schema/doc-=
bad-args.json
new file mode 100644
index 0000000000..048e0fc5ef
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-args.json
@@ -0,0 +1,8 @@
+# Arguments listed in the doc comment must exist in the actual schema
+
+##
+# @foo:
+# @a: a
+# @b: b
+##
+{ 'command': 'foo', 'data': {'a': 'int'} }
diff --git a/tests/qapi-schema/doc-bad-args.out b/tests/qapi-schema/doc-b=
ad-args.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-bad-symbol.err b/tests/qapi-schema/doc=
-bad-symbol.err
new file mode 100644
index 0000000000..ac4e5667cb
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-symbol.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-bad-symbol.json:3: Definition of 'foo' follows doc=
umentation for 'food'
diff --git a/tests/qapi-schema/doc-bad-symbol.exit b/tests/qapi-schema/do=
c-bad-symbol.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-symbol.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-bad-symbol.json b/tests/qapi-schema/do=
c-bad-symbol.json
new file mode 100644
index 0000000000..a7c15b3b8f
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-symbol.json
@@ -0,0 +1,6 @@
+# Documentation symbol mismatch with expression
+
+##
+# @food:
+##
+{ 'command': 'foo', 'data': {'a': 'int'} }
diff --git a/tests/qapi-schema/doc-bad-symbol.out b/tests/qapi-schema/doc=
-bad-symbol.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-duplicated-arg.err b/tests/qapi-schema=
/doc-duplicated-arg.err
new file mode 100644
index 0000000000..1c3f8e0a54
--- /dev/null
+++ b/tests/qapi-schema/doc-duplicated-arg.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-duplicated-arg.json:6:1: 'a' parameter name duplic=
ated
diff --git a/tests/qapi-schema/doc-duplicated-arg.exit b/tests/qapi-schem=
a/doc-duplicated-arg.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/doc-duplicated-arg.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-duplicated-arg.json b/tests/qapi-schem=
a/doc-duplicated-arg.json
new file mode 100644
index 0000000000..035cae9745
--- /dev/null
+++ b/tests/qapi-schema/doc-duplicated-arg.json
@@ -0,0 +1,7 @@
+# Do not allow duplicated argument
+
+##
+# @foo:
+# @a:
+# @a:
+##
diff --git a/tests/qapi-schema/doc-duplicated-arg.out b/tests/qapi-schema=
/doc-duplicated-arg.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-duplicated-return.err b/tests/qapi-sch=
ema/doc-duplicated-return.err
new file mode 100644
index 0000000000..e48039f8e5
--- /dev/null
+++ b/tests/qapi-schema/doc-duplicated-return.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-duplicated-return.json:7:1: Duplicated 'Returns' s=
ection
diff --git a/tests/qapi-schema/doc-duplicated-return.exit b/tests/qapi-sc=
hema/doc-duplicated-return.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/doc-duplicated-return.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-duplicated-return.json b/tests/qapi-sc=
hema/doc-duplicated-return.json
new file mode 100644
index 0000000000..b44b5ae979
--- /dev/null
+++ b/tests/qapi-schema/doc-duplicated-return.json
@@ -0,0 +1,8 @@
+# Do not allow duplicated Returns section
+
+##
+# @foo:
+#
+# Returns: 0
+# Returns: 1
+##
diff --git a/tests/qapi-schema/doc-duplicated-return.out b/tests/qapi-sch=
ema/doc-duplicated-return.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-duplicated-since.err b/tests/qapi-sche=
ma/doc-duplicated-since.err
new file mode 100644
index 0000000000..3fb890744a
--- /dev/null
+++ b/tests/qapi-schema/doc-duplicated-since.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-duplicated-since.json:7:1: Duplicated 'Since' sect=
ion
diff --git a/tests/qapi-schema/doc-duplicated-since.exit b/tests/qapi-sch=
ema/doc-duplicated-since.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/doc-duplicated-since.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-duplicated-since.json b/tests/qapi-sch=
ema/doc-duplicated-since.json
new file mode 100644
index 0000000000..343cd872cb
--- /dev/null
+++ b/tests/qapi-schema/doc-duplicated-since.json
@@ -0,0 +1,8 @@
+# Do not allow duplicated Since section
+
+##
+# @foo:
+#
+# Since: 0
+# Since: 1
+##
diff --git a/tests/qapi-schema/doc-duplicated-since.out b/tests/qapi-sche=
ma/doc-duplicated-since.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-empty-arg.err b/tests/qapi-schema/doc-=
empty-arg.err
new file mode 100644
index 0000000000..2895518fa7
--- /dev/null
+++ b/tests/qapi-schema/doc-empty-arg.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-empty-arg.json:5:1: Invalid parameter name
diff --git a/tests/qapi-schema/doc-empty-arg.exit b/tests/qapi-schema/doc=
-empty-arg.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/doc-empty-arg.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-empty-arg.json b/tests/qapi-schema/doc=
-empty-arg.json
new file mode 100644
index 0000000000..8f76ede8f3
--- /dev/null
+++ b/tests/qapi-schema/doc-empty-arg.json
@@ -0,0 +1,6 @@
+# An invalid empty argument name
+
+##
+# @foo:
+# @:
+##
diff --git a/tests/qapi-schema/doc-empty-arg.out b/tests/qapi-schema/doc-=
empty-arg.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-empty-section.err b/tests/qapi-schema/=
doc-empty-section.err
new file mode 100644
index 0000000000..00ad625e17
--- /dev/null
+++ b/tests/qapi-schema/doc-empty-section.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-empty-section.json:3: Empty doc section 'Note'
diff --git a/tests/qapi-schema/doc-empty-section.exit b/tests/qapi-schema=
/doc-empty-section.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/doc-empty-section.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-empty-section.json b/tests/qapi-schema=
/doc-empty-section.json
new file mode 100644
index 0000000000..f3384e9a3b
--- /dev/null
+++ b/tests/qapi-schema/doc-empty-section.json
@@ -0,0 +1,8 @@
+# Tagged-section must not be empty
+
+##
+# @foo:
+#
+# Note:
+##
+{ 'command': 'foo', 'data': {'a': 'int'} }
diff --git a/tests/qapi-schema/doc-empty-section.out b/tests/qapi-schema/=
doc-empty-section.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-empty-symbol.err b/tests/qapi-schema/d=
oc-empty-symbol.err
new file mode 100644
index 0000000000..1936ad094f
--- /dev/null
+++ b/tests/qapi-schema/doc-empty-symbol.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-empty-symbol.json:4:1: Invalid name
diff --git a/tests/qapi-schema/doc-empty-symbol.exit b/tests/qapi-schema/=
doc-empty-symbol.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/doc-empty-symbol.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-empty-symbol.json b/tests/qapi-schema/=
doc-empty-symbol.json
new file mode 100644
index 0000000000..fb8fddc4ae
--- /dev/null
+++ b/tests/qapi-schema/doc-empty-symbol.json
@@ -0,0 +1,5 @@
+# Invalid documentation symbol
+
+##
+# @:
+##
diff --git a/tests/qapi-schema/doc-empty-symbol.out b/tests/qapi-schema/d=
oc-empty-symbol.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-interleaved-section.err b/tests/qapi-s=
chema/doc-interleaved-section.err
new file mode 100644
index 0000000000..d373eabc55
--- /dev/null
+++ b/tests/qapi-schema/doc-interleaved-section.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-interleaved-section.json:15:1: '@foobar:' can't fo=
llow 'Note' section
diff --git a/tests/qapi-schema/doc-interleaved-section.exit b/tests/qapi-=
schema/doc-interleaved-section.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/doc-interleaved-section.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-interleaved-section.json b/tests/qapi-=
schema/doc-interleaved-section.json
new file mode 100644
index 0000000000..adb29e98da
--- /dev/null
+++ b/tests/qapi-schema/doc-interleaved-section.json
@@ -0,0 +1,21 @@
+# Arguments and sections must not be interleaved
+
+##
+# @TestStruct:
+#
+# body
+#
+# @integer: foo
+#           blah
+#
+#           bao
+#
+# Note: a section.
+#
+# @foobar: catch this
+#
+# Since: 2.3
+#
+##
+{ 'struct': 'TestStruct',
+  'data': { 'integer': 'int', 'foobar': 'int' } }
diff --git a/tests/qapi-schema/doc-interleaved-section.out b/tests/qapi-s=
chema/doc-interleaved-section.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-invalid-end.err b/tests/qapi-schema/do=
c-invalid-end.err
new file mode 100644
index 0000000000..2bda28cb54
--- /dev/null
+++ b/tests/qapi-schema/doc-invalid-end.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-invalid-end.json:5:2: Documentation comment must e=
nd with '##'
diff --git a/tests/qapi-schema/doc-invalid-end.exit b/tests/qapi-schema/d=
oc-invalid-end.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/doc-invalid-end.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-invalid-end.json b/tests/qapi-schema/d=
oc-invalid-end.json
new file mode 100644
index 0000000000..3583b23b18
--- /dev/null
+++ b/tests/qapi-schema/doc-invalid-end.json
@@ -0,0 +1,5 @@
+# Documentation must end with '##'
+
+##
+# An invalid comment
+#
diff --git a/tests/qapi-schema/doc-invalid-end.out b/tests/qapi-schema/do=
c-invalid-end.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-invalid-end2.err b/tests/qapi-schema/d=
oc-invalid-end2.err
new file mode 100644
index 0000000000..6fad9c789e
--- /dev/null
+++ b/tests/qapi-schema/doc-invalid-end2.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-invalid-end2.json:5:1: Junk after '##' at end of d=
ocumentation comment
diff --git a/tests/qapi-schema/doc-invalid-end2.exit b/tests/qapi-schema/=
doc-invalid-end2.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/doc-invalid-end2.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-invalid-end2.json b/tests/qapi-schema/=
doc-invalid-end2.json
new file mode 100644
index 0000000000..fa2d39d7c2
--- /dev/null
+++ b/tests/qapi-schema/doc-invalid-end2.json
@@ -0,0 +1,5 @@
+# Documentation must end with '##'
+
+##
+#
+## invalid
diff --git a/tests/qapi-schema/doc-invalid-end2.out b/tests/qapi-schema/d=
oc-invalid-end2.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-invalid-return.err b/tests/qapi-schema=
/doc-invalid-return.err
new file mode 100644
index 0000000000..5aaba33bb4
--- /dev/null
+++ b/tests/qapi-schema/doc-invalid-return.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-invalid-return.json:3: 'Returns:' is only valid fo=
r commands
diff --git a/tests/qapi-schema/doc-invalid-return.exit b/tests/qapi-schem=
a/doc-invalid-return.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/doc-invalid-return.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-invalid-return.json b/tests/qapi-schem=
a/doc-invalid-return.json
new file mode 100644
index 0000000000..1ba45de414
--- /dev/null
+++ b/tests/qapi-schema/doc-invalid-return.json
@@ -0,0 +1,7 @@
+# Events can't have 'Returns' section
+
+##
+# @foo:
+# Returns: blah
+##
+{ 'event': 'foo' }
diff --git a/tests/qapi-schema/doc-invalid-return.out b/tests/qapi-schema=
/doc-invalid-return.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-invalid-section.err b/tests/qapi-schem=
a/doc-invalid-section.err
new file mode 100644
index 0000000000..85bb67b829
--- /dev/null
+++ b/tests/qapi-schema/doc-invalid-section.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-invalid-section.json:3: Free-form documentation bl=
ock must not contain @NAME: sections
diff --git a/tests/qapi-schema/doc-invalid-section.exit b/tests/qapi-sche=
ma/doc-invalid-section.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/doc-invalid-section.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-invalid-section.json b/tests/qapi-sche=
ma/doc-invalid-section.json
new file mode 100644
index 0000000000..0578b8ae25
--- /dev/null
+++ b/tests/qapi-schema/doc-invalid-section.json
@@ -0,0 +1,6 @@
+# Free-form documentation doesn't have tagged-sections
+
+##
+# freeform
+# @note: foo
+##
diff --git a/tests/qapi-schema/doc-invalid-section.out b/tests/qapi-schem=
a/doc-invalid-section.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-invalid-start.err b/tests/qapi-schema/=
doc-invalid-start.err
new file mode 100644
index 0000000000..149af2bfac
--- /dev/null
+++ b/tests/qapi-schema/doc-invalid-start.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-invalid-start.json:3:1: Junk after '##' at start o=
f documentation comment
diff --git a/tests/qapi-schema/doc-invalid-start.exit b/tests/qapi-schema=
/doc-invalid-start.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/doc-invalid-start.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-invalid-start.json b/tests/qapi-schema=
/doc-invalid-start.json
new file mode 100644
index 0000000000..4f6c15a38c
--- /dev/null
+++ b/tests/qapi-schema/doc-invalid-start.json
@@ -0,0 +1,5 @@
+# Documentation must start with '##'
+
+## invalid
+#
+##
diff --git a/tests/qapi-schema/doc-invalid-start.out b/tests/qapi-schema/=
doc-invalid-start.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-missing-colon.err b/tests/qapi-schema/=
doc-missing-colon.err
new file mode 100644
index 0000000000..817398b8e4
--- /dev/null
+++ b/tests/qapi-schema/doc-missing-colon.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-missing-colon.json:4:1: Line should end with :
diff --git a/tests/qapi-schema/doc-missing-colon.exit b/tests/qapi-schema=
/doc-missing-colon.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/doc-missing-colon.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-missing-colon.json b/tests/qapi-schema=
/doc-missing-colon.json
new file mode 100644
index 0000000000..d88c06c6dd
--- /dev/null
+++ b/tests/qapi-schema/doc-missing-colon.json
@@ -0,0 +1,5 @@
+# The symbol section must end with ':'
+
+##
+# @missing-colon
+##
diff --git a/tests/qapi-schema/doc-missing-colon.out b/tests/qapi-schema/=
doc-missing-colon.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-missing-expr.err b/tests/qapi-schema/d=
oc-missing-expr.err
new file mode 100644
index 0000000000..c0e687cadd
--- /dev/null
+++ b/tests/qapi-schema/doc-missing-expr.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-missing-expr.json:3: Documention for 'bar' is not =
followed by the definition
diff --git a/tests/qapi-schema/doc-missing-expr.exit b/tests/qapi-schema/=
doc-missing-expr.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/doc-missing-expr.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-missing-expr.json b/tests/qapi-schema/=
doc-missing-expr.json
new file mode 100644
index 0000000000..06ad7df8d6
--- /dev/null
+++ b/tests/qapi-schema/doc-missing-expr.json
@@ -0,0 +1,5 @@
+# Expression documentation must be followed by the actual expression
+
+##
+# @bar:
+##
diff --git a/tests/qapi-schema/doc-missing-expr.out b/tests/qapi-schema/d=
oc-missing-expr.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-missing-space.err b/tests/qapi-schema/=
doc-missing-space.err
new file mode 100644
index 0000000000..d6b46ffd77
--- /dev/null
+++ b/tests/qapi-schema/doc-missing-space.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-missing-space.json:5:1: Missing space after #
diff --git a/tests/qapi-schema/doc-missing-space.exit b/tests/qapi-schema=
/doc-missing-space.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/doc-missing-space.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-missing-space.json b/tests/qapi-schema=
/doc-missing-space.json
new file mode 100644
index 0000000000..beb276bc64
--- /dev/null
+++ b/tests/qapi-schema/doc-missing-space.json
@@ -0,0 +1,6 @@
+# Documentation line must have a leading space
+
+##
+# missing space:
+#wef
+##
diff --git a/tests/qapi-schema/doc-missing-space.out b/tests/qapi-schema/=
doc-missing-space.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-optional.err b/tests/qapi-schema/doc-o=
ptional.err
new file mode 100644
index 0000000000..20d405af79
--- /dev/null
+++ b/tests/qapi-schema/doc-optional.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-optional.json:3: Description has #optional, but th=
e declaration doesn't
diff --git a/tests/qapi-schema/doc-optional.exit b/tests/qapi-schema/doc-=
optional.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/doc-optional.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-optional.json b/tests/qapi-schema/doc-=
optional.json
new file mode 100644
index 0000000000..06c855ec94
--- /dev/null
+++ b/tests/qapi-schema/doc-optional.json
@@ -0,0 +1,7 @@
+# Description #optional should match declaration
+
+##
+# @foo:
+# @a: a #optional
+##
+{ 'command': 'foo', 'data': {'a': 'int'} }
diff --git a/tests/qapi-schema/doc-optional.out b/tests/qapi-schema/doc-o=
ptional.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/double-type.err b/tests/qapi-schema/double=
-type.err
index f9613c6d6b..424df9bedd 100644
--- a/tests/qapi-schema/double-type.err
+++ b/tests/qapi-schema/double-type.err
@@ -1 +1 @@
-tests/qapi-schema/double-type.json:2: Unknown key 'command' in struct 'b=
ar'
+tests/qapi-schema/double-type.json:6: Unknown key 'command' in struct 'b=
ar'
diff --git a/tests/qapi-schema/double-type.json b/tests/qapi-schema/doubl=
e-type.json
index 911fa7af50..ab59523ff7 100644
--- a/tests/qapi-schema/double-type.json
+++ b/tests/qapi-schema/double-type.json
@@ -1,2 +1,6 @@
 # we reject an expression with ambiguous metatype
+
+##
+# @foo:
+##
 { 'command': 'foo', 'struct': 'bar', 'data': { } }
diff --git a/tests/qapi-schema/enum-bad-name.err b/tests/qapi-schema/enum=
-bad-name.err
index 9c3c1002b7..157d1b0d69 100644
--- a/tests/qapi-schema/enum-bad-name.err
+++ b/tests/qapi-schema/enum-bad-name.err
@@ -1 +1 @@
-tests/qapi-schema/enum-bad-name.json:2: Member of enum 'MyEnum' uses inv=
alid name 'not^possible'
+tests/qapi-schema/enum-bad-name.json:6: Member of enum 'MyEnum' uses inv=
alid name 'not^possible'
diff --git a/tests/qapi-schema/enum-bad-name.json b/tests/qapi-schema/enu=
m-bad-name.json
index 8506562b31..978cb88994 100644
--- a/tests/qapi-schema/enum-bad-name.json
+++ b/tests/qapi-schema/enum-bad-name.json
@@ -1,2 +1,6 @@
 # we ensure all enum names can map to C
+
+##
+# @MyEnum:
+##
 { 'enum': 'MyEnum', 'data': [ 'not^possible' ] }
diff --git a/tests/qapi-schema/enum-bad-prefix.err b/tests/qapi-schema/en=
um-bad-prefix.err
index 399f5f7af5..918915f7ab 100644
--- a/tests/qapi-schema/enum-bad-prefix.err
+++ b/tests/qapi-schema/enum-bad-prefix.err
@@ -1 +1 @@
-tests/qapi-schema/enum-bad-prefix.json:2: Enum 'MyEnum' requires a strin=
g for 'prefix'
+tests/qapi-schema/enum-bad-prefix.json:6: Enum 'MyEnum' requires a strin=
g for 'prefix'
diff --git a/tests/qapi-schema/enum-bad-prefix.json b/tests/qapi-schema/e=
num-bad-prefix.json
index 996f628f6d..25f17a7b08 100644
--- a/tests/qapi-schema/enum-bad-prefix.json
+++ b/tests/qapi-schema/enum-bad-prefix.json
@@ -1,2 +1,6 @@
 # The prefix must be a string type
+
+##
+# @MyEnum:
+##
 { 'enum': 'MyEnum', 'data': [ 'one' ], 'prefix': [ 'fish' ] }
diff --git a/tests/qapi-schema/enum-clash-member.err b/tests/qapi-schema/=
enum-clash-member.err
index 5403c78507..25249b63c4 100644
--- a/tests/qapi-schema/enum-clash-member.err
+++ b/tests/qapi-schema/enum-clash-member.err
@@ -1 +1 @@
-tests/qapi-schema/enum-clash-member.json:2: 'one_two' (member of MyEnum)=
 collides with 'one-two' (member of MyEnum)
+tests/qapi-schema/enum-clash-member.json:6: 'one_two' (member of MyEnum)=
 collides with 'one-two' (member of MyEnum)
diff --git a/tests/qapi-schema/enum-clash-member.json b/tests/qapi-schema=
/enum-clash-member.json
index b6928b8bfd..fd52751941 100644
--- a/tests/qapi-schema/enum-clash-member.json
+++ b/tests/qapi-schema/enum-clash-member.json
@@ -1,2 +1,6 @@
 # we reject enums where members will clash when mapped to C enum
+
+##
+# @MyEnum:
+##
 { 'enum': 'MyEnum', 'data': [ 'one-two', 'one_two' ] }
diff --git a/tests/qapi-schema/enum-dict-member.err b/tests/qapi-schema/e=
num-dict-member.err
index 8ca146ea59..9b7d2f111d 100644
--- a/tests/qapi-schema/enum-dict-member.err
+++ b/tests/qapi-schema/enum-dict-member.err
@@ -1 +1 @@
-tests/qapi-schema/enum-dict-member.json:2: Member of enum 'MyEnum' requi=
res a string name
+tests/qapi-schema/enum-dict-member.json:6: Member of enum 'MyEnum' requi=
res a string name
diff --git a/tests/qapi-schema/enum-dict-member.json b/tests/qapi-schema/=
enum-dict-member.json
index 79672e0f09..69d30f0c1e 100644
--- a/tests/qapi-schema/enum-dict-member.json
+++ b/tests/qapi-schema/enum-dict-member.json
@@ -1,2 +1,6 @@
 # we reject any enum member that is not a string
+
+##
+# @MyEnum:
+##
 { 'enum': 'MyEnum', 'data': [ { 'value': 'str' } ] }
diff --git a/tests/qapi-schema/enum-member-case.err b/tests/qapi-schema/e=
num-member-case.err
index b652e9aacc..df96e2205a 100644
--- a/tests/qapi-schema/enum-member-case.err
+++ b/tests/qapi-schema/enum-member-case.err
@@ -1 +1 @@
-tests/qapi-schema/enum-member-case.json:3: 'Value' (member of NoWayThisW=
illGetWhitelisted) should not use uppercase
+tests/qapi-schema/enum-member-case.json:10: 'Value' (member of NoWayThis=
WillGetWhitelisted) should not use uppercase
diff --git a/tests/qapi-schema/enum-member-case.json b/tests/qapi-schema/=
enum-member-case.json
index 2096b350ca..d2e4aba39d 100644
--- a/tests/qapi-schema/enum-member-case.json
+++ b/tests/qapi-schema/enum-member-case.json
@@ -1,3 +1,10 @@
 # Member names should be 'lower-case' unless the enum is whitelisted
+
+##
+# @UuidInfo:
+##
 { 'enum': 'UuidInfo', 'data': [ 'Value' ] } # UuidInfo is whitelisted
+##
+# @NoWayThisWillGetWhitelisted:
+##
 { 'enum': 'NoWayThisWillGetWhitelisted', 'data': [ 'Value' ] }
diff --git a/tests/qapi-schema/enum-missing-data.err b/tests/qapi-schema/=
enum-missing-data.err
index ba4873ae69..de4b9e8281 100644
--- a/tests/qapi-schema/enum-missing-data.err
+++ b/tests/qapi-schema/enum-missing-data.err
@@ -1 +1 @@
-tests/qapi-schema/enum-missing-data.json:2: Key 'data' is missing from e=
num 'MyEnum'
+tests/qapi-schema/enum-missing-data.json:6: Key 'data' is missing from e=
num 'MyEnum'
diff --git a/tests/qapi-schema/enum-missing-data.json b/tests/qapi-schema=
/enum-missing-data.json
index 558fd35e93..d7601f91fb 100644
--- a/tests/qapi-schema/enum-missing-data.json
+++ b/tests/qapi-schema/enum-missing-data.json
@@ -1,2 +1,6 @@
 # we require that all QAPI enums have a data array
+
+##
+# @MyEnum:
+##
 { 'enum': 'MyEnum' }
diff --git a/tests/qapi-schema/enum-wrong-data.err b/tests/qapi-schema/en=
um-wrong-data.err
index 11b43471cf..c44e9b59dc 100644
--- a/tests/qapi-schema/enum-wrong-data.err
+++ b/tests/qapi-schema/enum-wrong-data.err
@@ -1 +1 @@
-tests/qapi-schema/enum-wrong-data.json:2: Enum 'MyEnum' requires an arra=
y for 'data'
+tests/qapi-schema/enum-wrong-data.json:6: Enum 'MyEnum' requires an arra=
y for 'data'
diff --git a/tests/qapi-schema/enum-wrong-data.json b/tests/qapi-schema/e=
num-wrong-data.json
index 7b3e255c14..4b9e97878b 100644
--- a/tests/qapi-schema/enum-wrong-data.json
+++ b/tests/qapi-schema/enum-wrong-data.json
@@ -1,2 +1,6 @@
 # we require that all qapi enums have an array for data
+
+##
+# @MyEnum:
+##
 { 'enum': 'MyEnum', 'data': { 'value': 'str' } }
diff --git a/tests/qapi-schema/event-boxed-empty.err b/tests/qapi-schema/=
event-boxed-empty.err
index 68ec6f2d2b..defe656e32 100644
--- a/tests/qapi-schema/event-boxed-empty.err
+++ b/tests/qapi-schema/event-boxed-empty.err
@@ -1 +1 @@
-tests/qapi-schema/event-boxed-empty.json:2: Use of 'boxed' requires 'dat=
a'
+tests/qapi-schema/event-boxed-empty.json:6: Use of 'boxed' requires 'dat=
a'
diff --git a/tests/qapi-schema/event-boxed-empty.json b/tests/qapi-schema=
/event-boxed-empty.json
index cb145f1433..63b870b31b 100644
--- a/tests/qapi-schema/event-boxed-empty.json
+++ b/tests/qapi-schema/event-boxed-empty.json
@@ -1,2 +1,6 @@
 # 'boxed' requires a non-empty type
+
+##
+# @FOO:
+##
 { 'event': 'FOO', 'boxed': true }
diff --git a/tests/qapi-schema/event-case.json b/tests/qapi-schema/event-=
case.json
index 3a92d8b610..6b05c5d247 100644
--- a/tests/qapi-schema/event-case.json
+++ b/tests/qapi-schema/event-case.json
@@ -1,3 +1,7 @@
 # TODO: might be nice to enforce naming conventions; but until then this=
 works
 # even though events should usually be ALL_CAPS
+
+##
+# @oops:
+##
 { 'event': 'oops' }
diff --git a/tests/qapi-schema/event-case.out b/tests/qapi-schema/event-c=
ase.out
index 5a0f2bf805..5a36293c8f 100644
--- a/tests/qapi-schema/event-case.out
+++ b/tests/qapi-schema/event-case.out
@@ -3,3 +3,6 @@ enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', =
'qlist', 'qfloat', 'qbo
 event oops None
    boxed=3DFalse
 object q_empty
+doc symbol=3Doops expr=3D('event', 'oops')
+    body=3D
+
diff --git a/tests/qapi-schema/event-nest-struct.err b/tests/qapi-schema/=
event-nest-struct.err
index 5a42701b8f..17a6c3c7b9 100644
--- a/tests/qapi-schema/event-nest-struct.err
+++ b/tests/qapi-schema/event-nest-struct.err
@@ -1 +1 @@
-tests/qapi-schema/event-nest-struct.json:1: Member 'a' of 'data' for eve=
nt 'EVENT_A' should be a type name
+tests/qapi-schema/event-nest-struct.json:5: Member 'a' of 'data' for eve=
nt 'EVENT_A' should be a type name
diff --git a/tests/qapi-schema/event-nest-struct.json b/tests/qapi-schema=
/event-nest-struct.json
index ee6f3ecb6f..328e0a64d3 100644
--- a/tests/qapi-schema/event-nest-struct.json
+++ b/tests/qapi-schema/event-nest-struct.json
@@ -1,2 +1,6 @@
+##
+# @EVENT_A:
+# event-nest-struct
+##
 { 'event': 'EVENT_A',
   'data': { 'a' : { 'string' : 'str', 'integer': 'int' }, 'b' : 'str' } =
}
diff --git a/tests/qapi-schema/flat-union-array-branch.err b/tests/qapi-s=
chema/flat-union-array-branch.err
index 8ea91eadb2..e456094993 100644
--- a/tests/qapi-schema/flat-union-array-branch.err
+++ b/tests/qapi-schema/flat-union-array-branch.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-array-branch.json:8: Member 'value1' of uni=
on 'TestUnion' cannot be an array
+tests/qapi-schema/flat-union-array-branch.json:20: Member 'value1' of un=
ion 'TestUnion' cannot be an array
diff --git a/tests/qapi-schema/flat-union-array-branch.json b/tests/qapi-=
schema/flat-union-array-branch.json
index 0b98820a8f..51dde10392 100644
--- a/tests/qapi-schema/flat-union-array-branch.json
+++ b/tests/qapi-schema/flat-union-array-branch.json
@@ -1,10 +1,22 @@
+##
+# @TestEnum:
+##
 # we require flat union branches to be a struct
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
+##
+# @Base:
+##
 { 'struct': 'Base',
   'data': { 'enum1': 'TestEnum' } }
+##
+# @TestTypeB:
+##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
+##
+# @TestUnion:
+##
 { 'union': 'TestUnion',
   'base': 'Base',
   'discriminator': 'enum1',
diff --git a/tests/qapi-schema/flat-union-bad-base.err b/tests/qapi-schem=
a/flat-union-bad-base.err
index bee24a217a..072ffbaadd 100644
--- a/tests/qapi-schema/flat-union-bad-base.err
+++ b/tests/qapi-schema/flat-union-bad-base.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-bad-base.json:8: 'string' (member of TestTy=
peA) collides with 'string' (base of TestUnion)
+tests/qapi-schema/flat-union-bad-base.json:21: 'string' (member of TestT=
ypeA) collides with 'string' (base of TestUnion)
diff --git a/tests/qapi-schema/flat-union-bad-base.json b/tests/qapi-sche=
ma/flat-union-bad-base.json
index 74dd421708..7713e7f0ad 100644
--- a/tests/qapi-schema/flat-union-bad-base.json
+++ b/tests/qapi-schema/flat-union-bad-base.json
@@ -1,10 +1,23 @@
 # we allow anonymous base, but enforce no duplicate keys
+
+##
+# @TestEnum:
+##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
+##
+# @TestTypeA:
+##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
+##
+# @TestTypeB:
+##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
+##
+# @TestUnion:
+##
 { 'union': 'TestUnion',
   'base': { 'enum1': 'TestEnum', 'string': 'str' },
   'discriminator': 'enum1',
diff --git a/tests/qapi-schema/flat-union-bad-discriminator.err b/tests/q=
api-schema/flat-union-bad-discriminator.err
index c38cc8e4df..1be4e7b23a 100644
--- a/tests/qapi-schema/flat-union-bad-discriminator.err
+++ b/tests/qapi-schema/flat-union-bad-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-bad-discriminator.json:11: Discriminator of=
 flat union 'TestUnion' requires a string name
+tests/qapi-schema/flat-union-bad-discriminator.json:27: Discriminator of=
 flat union 'TestUnion' requires a string name
diff --git a/tests/qapi-schema/flat-union-bad-discriminator.json b/tests/=
qapi-schema/flat-union-bad-discriminator.json
index cd10b9d901..ef92f9b583 100644
--- a/tests/qapi-schema/flat-union-bad-discriminator.json
+++ b/tests/qapi-schema/flat-union-bad-discriminator.json
@@ -1,13 +1,29 @@
 # we require the discriminator to be a string naming a base-type member
 # this tests the old syntax for anonymous unions before we added alterna=
tes
+
+##
+# @TestEnum:
+##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
+##
+# @TestBase:
+##
 { 'struct': 'TestBase',
   'data': { 'enum1': 'TestEnum', 'kind': 'str' } }
+##
+# @TestTypeA:
+##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
+##
+# @TestTypeB:
+##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
+##
+# @TestUnion:
+##
 { 'union': 'TestUnion',
   'base': 'TestBase',
   'discriminator': {},
diff --git a/tests/qapi-schema/flat-union-base-any.err b/tests/qapi-schem=
a/flat-union-base-any.err
index 646f1c9cd1..c1ea2d76b3 100644
--- a/tests/qapi-schema/flat-union-base-any.err
+++ b/tests/qapi-schema/flat-union-base-any.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-base-any.json:8: 'base' for union 'TestUnio=
n' cannot use built-in type 'any'
+tests/qapi-schema/flat-union-base-any.json:21: 'base' for union 'TestUni=
on' cannot use built-in type 'any'
diff --git a/tests/qapi-schema/flat-union-base-any.json b/tests/qapi-sche=
ma/flat-union-base-any.json
index fe66b713ef..3dfb02fa30 100644
--- a/tests/qapi-schema/flat-union-base-any.json
+++ b/tests/qapi-schema/flat-union-base-any.json
@@ -1,10 +1,23 @@
 # we require the base to be an existing struct
+
+##
+# @TestEnum:
+##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
+##
+# @TestTypeA:
+##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
+##
+# @TestTypeB:
+##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
+##
+# @TestUnion:
+##
 { 'union': 'TestUnion',
   'base': 'any',
   'discriminator': 'enum1',
diff --git a/tests/qapi-schema/flat-union-base-union.err b/tests/qapi-sch=
ema/flat-union-base-union.err
index f138395e45..ccc5e85876 100644
--- a/tests/qapi-schema/flat-union-base-union.err
+++ b/tests/qapi-schema/flat-union-base-union.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-base-union.json:14: 'base' for union 'TestU=
nion' cannot use union type 'UnionBase'
+tests/qapi-schema/flat-union-base-union.json:30: 'base' for union 'TestU=
nion' cannot use union type 'UnionBase'
diff --git a/tests/qapi-schema/flat-union-base-union.json b/tests/qapi-sc=
hema/flat-union-base-union.json
index 98b4eba181..c63c6130b8 100644
--- a/tests/qapi-schema/flat-union-base-union.json
+++ b/tests/qapi-schema/flat-union-base-union.json
@@ -2,15 +2,31 @@
 # TODO: It would be possible to allow a union as a base, as long as all
 # permutations of QMP names exposed by base do not clash with any QMP
 # member names added by local variants.
+
+##
+# @TestEnum:
+##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
+##
+# @TestTypeA:
+##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
+##
+# @TestTypeB:
+##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
+##
+# @UnionBase:
+##
 { 'union': 'UnionBase',
   'data': { 'kind1': 'TestTypeA',
             'kind2': 'TestTypeB' } }
+##
+# @TestUnion:
+##
 { 'union': 'TestUnion',
   'base': 'UnionBase',
   'discriminator': 'type',
diff --git a/tests/qapi-schema/flat-union-clash-member.err b/tests/qapi-s=
chema/flat-union-clash-member.err
index 2adf69755a..fe12a07e2d 100644
--- a/tests/qapi-schema/flat-union-clash-member.err
+++ b/tests/qapi-schema/flat-union-clash-member.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-clash-member.json:11: 'name' (member of Bra=
nch1) collides with 'name' (member of Base)
+tests/qapi-schema/flat-union-clash-member.json:27: 'name' (member of Bra=
nch1) collides with 'name' (member of Base)
diff --git a/tests/qapi-schema/flat-union-clash-member.json b/tests/qapi-=
schema/flat-union-clash-member.json
index 9efc7719b8..9000b94f16 100644
--- a/tests/qapi-schema/flat-union-clash-member.json
+++ b/tests/qapi-schema/flat-union-clash-member.json
@@ -1,13 +1,29 @@
 # We check for no duplicate keys between branch members and base
 # base's member 'name' clashes with Branch1's
+
+##
+# @TestEnum:
+##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
+##
+# @Base:
+##
 { 'struct': 'Base',
   'data': { 'enum1': 'TestEnum', '*name': 'str' } }
+##
+# @Branch1:
+##
 { 'struct': 'Branch1',
   'data': { 'name': 'str' } }
+##
+# @Branch2:
+##
 { 'struct': 'Branch2',
   'data': { 'value': 'int' } }
+##
+# @TestUnion:
+##
 { 'union': 'TestUnion',
   'base': 'Base',
   'discriminator': 'enum1',
diff --git a/tests/qapi-schema/flat-union-empty.err b/tests/qapi-schema/f=
lat-union-empty.err
index 15754f54eb..ead7bd4fcb 100644
--- a/tests/qapi-schema/flat-union-empty.err
+++ b/tests/qapi-schema/flat-union-empty.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-empty.json:4: Union 'Union' cannot have emp=
ty 'data'
+tests/qapi-schema/flat-union-empty.json:14: Union 'Union' cannot have em=
pty 'data'
diff --git a/tests/qapi-schema/flat-union-empty.json b/tests/qapi-schema/=
flat-union-empty.json
index 77f1d9abfb..afa8988205 100644
--- a/tests/qapi-schema/flat-union-empty.json
+++ b/tests/qapi-schema/flat-union-empty.json
@@ -1,4 +1,14 @@
 # flat unions cannot be empty
+
+##
+# @Empty:
+##
 { 'enum': 'Empty', 'data': [ ] }
+##
+# @Base:
+##
 { 'struct': 'Base', 'data': { 'type': 'Empty' } }
+##
+# @Union:
+##
 { 'union': 'Union', 'base': 'Base', 'discriminator': 'type', 'data': { }=
 }
diff --git a/tests/qapi-schema/flat-union-incomplete-branch.err b/tests/q=
api-schema/flat-union-incomplete-branch.err
index e826bf0789..c655bbfb4a 100644
--- a/tests/qapi-schema/flat-union-incomplete-branch.err
+++ b/tests/qapi-schema/flat-union-incomplete-branch.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-incomplete-branch.json:6: Union 'TestUnion'=
 data missing 'value2' branch
+tests/qapi-schema/flat-union-incomplete-branch.json:16: Union 'TestUnion=
' data missing 'value2' branch
diff --git a/tests/qapi-schema/flat-union-incomplete-branch.json b/tests/=
qapi-schema/flat-union-incomplete-branch.json
index 25a411bc83..dea03775c7 100644
--- a/tests/qapi-schema/flat-union-incomplete-branch.json
+++ b/tests/qapi-schema/flat-union-incomplete-branch.json
@@ -1,8 +1,18 @@
 # we require all branches of the union to be covered
+
+##
+# @TestEnum:
+##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
+##
+# @TestTypeA:
+##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
+##
+# @TestUnion:
+##
 { 'union': 'TestUnion',
   'base': { 'type': 'TestEnum' },
   'discriminator': 'type',
diff --git a/tests/qapi-schema/flat-union-inline.err b/tests/qapi-schema/=
flat-union-inline.err
index 2333358d28..c2c3f7604b 100644
--- a/tests/qapi-schema/flat-union-inline.err
+++ b/tests/qapi-schema/flat-union-inline.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-inline.json:7: Member 'value1' of union 'Te=
stUnion' should be a type name
+tests/qapi-schema/flat-union-inline.json:17: Member 'value1' of union 'T=
estUnion' should be a type name
diff --git a/tests/qapi-schema/flat-union-inline.json b/tests/qapi-schema=
/flat-union-inline.json
index 62c7cda617..400f0817a1 100644
--- a/tests/qapi-schema/flat-union-inline.json
+++ b/tests/qapi-schema/flat-union-inline.json
@@ -1,9 +1,19 @@
 # we require branches to be a struct name
 # TODO: should we allow anonymous inline branch types?
+
+##
+# @TestEnum:
+##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
+##
+# @Base:
+##
 { 'struct': 'Base',
   'data': { 'enum1': 'TestEnum', 'kind': 'str' } }
+##
+# @TestUnion:
+##
 { 'union': 'TestUnion',
   'base': 'Base',
   'discriminator': 'enum1',
diff --git a/tests/qapi-schema/flat-union-int-branch.err b/tests/qapi-sch=
ema/flat-union-int-branch.err
index faf01573b7..299cbb24b2 100644
--- a/tests/qapi-schema/flat-union-int-branch.err
+++ b/tests/qapi-schema/flat-union-int-branch.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-int-branch.json:8: Member 'value1' of union=
 'TestUnion' cannot use built-in type 'int'
+tests/qapi-schema/flat-union-int-branch.json:21: Member 'value1' of unio=
n 'TestUnion' cannot use built-in type 'int'
diff --git a/tests/qapi-schema/flat-union-int-branch.json b/tests/qapi-sc=
hema/flat-union-int-branch.json
index 9370c349e8..9603e172f8 100644
--- a/tests/qapi-schema/flat-union-int-branch.json
+++ b/tests/qapi-schema/flat-union-int-branch.json
@@ -1,10 +1,23 @@
 # we require flat union branches to be a struct
+
+##
+# @TestEnum:
+##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
+##
+# @Base:
+##
 { 'struct': 'Base',
   'data': { 'enum1': 'TestEnum' } }
+##
+# @TestTypeB:
+##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
+##
+# @TestUnion:
+##
 { 'union': 'TestUnion',
   'base': 'Base',
   'discriminator': 'enum1',
diff --git a/tests/qapi-schema/flat-union-invalid-branch-key.err b/tests/=
qapi-schema/flat-union-invalid-branch-key.err
index ccf72d2dfe..455f2dc083 100644
--- a/tests/qapi-schema/flat-union-invalid-branch-key.err
+++ b/tests/qapi-schema/flat-union-invalid-branch-key.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-invalid-branch-key.json:13: Discriminator v=
alue 'value_wrong' is not found in enum 'TestEnum'
+tests/qapi-schema/flat-union-invalid-branch-key.json:28: Discriminator v=
alue 'value_wrong' is not found in enum 'TestEnum'
diff --git a/tests/qapi-schema/flat-union-invalid-branch-key.json b/tests=
/qapi-schema/flat-union-invalid-branch-key.json
index 95ff7746bf..00f28966ff 100644
--- a/tests/qapi-schema/flat-union-invalid-branch-key.json
+++ b/tests/qapi-schema/flat-union-invalid-branch-key.json
@@ -1,15 +1,30 @@
+##
+# @TestEnum:
+##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
=20
+##
+# @TestBase:
+##
 { 'struct': 'TestBase',
   'data': { 'enum1': 'TestEnum' } }
=20
+##
+# @TestTypeA:
+##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
=20
+##
+# @TestTypeB:
+##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
=20
+##
+# @TestUnion:
+##
 { 'union': 'TestUnion',
   'base': 'TestBase',
   'discriminator': 'enum1',
diff --git a/tests/qapi-schema/flat-union-invalid-discriminator.err b/tes=
ts/qapi-schema/flat-union-invalid-discriminator.err
index 5f4055614e..f0e427b0a7 100644
--- a/tests/qapi-schema/flat-union-invalid-discriminator.err
+++ b/tests/qapi-schema/flat-union-invalid-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-invalid-discriminator.json:13: Discriminato=
r 'enum_wrong' is not a member of base struct 'TestBase'
+tests/qapi-schema/flat-union-invalid-discriminator.json:28: Discriminato=
r 'enum_wrong' is not a member of base struct 'TestBase'
diff --git a/tests/qapi-schema/flat-union-invalid-discriminator.json b/te=
sts/qapi-schema/flat-union-invalid-discriminator.json
index 48b94c3a4d..c8700c7d71 100644
--- a/tests/qapi-schema/flat-union-invalid-discriminator.json
+++ b/tests/qapi-schema/flat-union-invalid-discriminator.json
@@ -1,15 +1,30 @@
+##
+# @TestEnum:
+##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
=20
+##
+# @TestBase:
+##
 { 'struct': 'TestBase',
   'data': { 'enum1': 'TestEnum' } }
=20
+##
+# @TestTypeA:
+##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
=20
+##
+# @TestTypeB:
+##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
=20
+##
+# @TestUnion:
+##
 { 'union': 'TestUnion',
   'base': 'TestBase',
   'discriminator': 'enum_wrong',
diff --git a/tests/qapi-schema/flat-union-no-base.err b/tests/qapi-schema=
/flat-union-no-base.err
index 841c93b554..a2d0a81aa0 100644
--- a/tests/qapi-schema/flat-union-no-base.err
+++ b/tests/qapi-schema/flat-union-no-base.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-no-base.json:9: Flat union 'TestUnion' must=
 have a base
+tests/qapi-schema/flat-union-no-base.json:22: Flat union 'TestUnion' mus=
t have a base
diff --git a/tests/qapi-schema/flat-union-no-base.json b/tests/qapi-schem=
a/flat-union-no-base.json
index ffc4c6f0e6..641f68aea4 100644
--- a/tests/qapi-schema/flat-union-no-base.json
+++ b/tests/qapi-schema/flat-union-no-base.json
@@ -1,11 +1,24 @@
 # flat unions require a base
 # TODO: simple unions should be able to use an enum discriminator
+
+##
+# @TestTypeA:
+##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
+##
+# @TestTypeB:
+##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
+##
+# @Enum:
+##
 { 'enum': 'Enum',
   'data': [ 'value1', 'value2' ] }
+##
+# @TestUnion:
+##
 { 'union': 'TestUnion',
   'discriminator': 'Enum',
   'data': { 'value1': 'TestTypeA',
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.err b/te=
sts/qapi-schema/flat-union-optional-discriminator.err
index aaabedb3bd..e15f8564dd 100644
--- a/tests/qapi-schema/flat-union-optional-discriminator.err
+++ b/tests/qapi-schema/flat-union-optional-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-optional-discriminator.json:6: Discriminato=
r of flat union 'MyUnion' does not allow optional name '*switch'
+tests/qapi-schema/flat-union-optional-discriminator.json:19: Discriminat=
or of flat union 'MyUnion' does not allow optional name '*switch'
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.json b/t=
ests/qapi-schema/flat-union-optional-discriminator.json
index 08a8f7ef8b..9f19af5789 100644
--- a/tests/qapi-schema/flat-union-optional-discriminator.json
+++ b/tests/qapi-schema/flat-union-optional-discriminator.json
@@ -1,8 +1,21 @@
 # we require the discriminator to be non-optional
+
+##
+# @Enum:
+##
 { 'enum': 'Enum', 'data': [ 'one', 'two' ] }
+##
+# @Base:
+##
 { 'struct': 'Base',
   'data': { '*switch': 'Enum' } }
+##
+# @Branch:
+##
 { 'struct': 'Branch', 'data': { 'name': 'str' } }
+##
+# @MyUnion:
+##
 { 'union': 'MyUnion',
   'base': 'Base',
   'discriminator': '*switch',
diff --git a/tests/qapi-schema/flat-union-string-discriminator.err b/test=
s/qapi-schema/flat-union-string-discriminator.err
index 200016bd5c..bc0c133aa9 100644
--- a/tests/qapi-schema/flat-union-string-discriminator.err
+++ b/tests/qapi-schema/flat-union-string-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/flat-union-string-discriminator.json:13: Discriminator=
 'kind' must be of enumeration type
+tests/qapi-schema/flat-union-string-discriminator.json:28: Discriminator=
 'kind' must be of enumeration type
diff --git a/tests/qapi-schema/flat-union-string-discriminator.json b/tes=
ts/qapi-schema/flat-union-string-discriminator.json
index 8af60333b6..47a17d2e4a 100644
--- a/tests/qapi-schema/flat-union-string-discriminator.json
+++ b/tests/qapi-schema/flat-union-string-discriminator.json
@@ -1,15 +1,30 @@
+##
+# @TestEnum:
+##
 { 'enum': 'TestEnum',
   'data': [ 'value1', 'value2' ] }
=20
+##
+# @TestBase:
+##
 { 'struct': 'TestBase',
   'data': { 'enum1': 'TestEnum', 'kind': 'str' } }
=20
+##
+# @TestTypeA:
+##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
=20
+##
+# @TestTypeB:
+##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
=20
+##
+# @TestUnion:
+##
 { 'union': 'TestUnion',
   'base': 'TestBase',
   'discriminator': 'kind',
diff --git a/tests/qapi-schema/ident-with-escape.json b/tests/qapi-schema=
/ident-with-escape.json
index 56617501e7..c03404bee3 100644
--- a/tests/qapi-schema/ident-with-escape.json
+++ b/tests/qapi-schema/ident-with-escape.json
@@ -1,4 +1,8 @@
 # we allow escape sequences in strings, if they map back to ASCII
 # { 'command': 'fooA', 'data': { 'bar1': 'str' } }
+
+##
+# @fooA:
+##
 { 'c\u006fmmand': '\u0066\u006f\u006FA',
   'd\u0061ta': { '\u0062\u0061\u00721': '\u0073\u0074\u0072' } }
diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/=
ident-with-escape.out
index 1d2722c02e..4a98933b28 100644
--- a/tests/qapi-schema/ident-with-escape.out
+++ b/tests/qapi-schema/ident-with-escape.out
@@ -5,3 +5,6 @@ command fooA q_obj_fooA-arg -> None
 object q_empty
 object q_obj_fooA-arg
     member bar1: str optional=3DFalse
+doc symbol=3DfooA expr=3D('command', 'fooA')
+    body=3D
+
diff --git a/tests/qapi-schema/include-relpath-sub.json b/tests/qapi-sche=
ma/include-relpath-sub.json
index 4bd4af4162..b4bd8a23d7 100644
--- a/tests/qapi-schema/include-relpath-sub.json
+++ b/tests/qapi-schema/include-relpath-sub.json
@@ -1,2 +1,5 @@
+##
+# @Status:
+##
 { 'enum': 'Status',
   'data': [ 'good', 'bad', 'ugly' ] }
diff --git a/tests/qapi-schema/include-relpath.out b/tests/qapi-schema/in=
clude-relpath.out
index 5d7c13cad1..ab3d74f49f 100644
--- a/tests/qapi-schema/include-relpath.out
+++ b/tests/qapi-schema/include-relpath.out
@@ -2,3 +2,6 @@ enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', =
'qlist', 'qfloat', 'qbo
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
 object q_empty
+doc symbol=3DStatus expr=3D('enum', 'Status')
+    body=3D
+
diff --git a/tests/qapi-schema/include-repetition.out b/tests/qapi-schema=
/include-repetition.out
index 5d7c13cad1..ab3d74f49f 100644
--- a/tests/qapi-schema/include-repetition.out
+++ b/tests/qapi-schema/include-repetition.out
@@ -2,3 +2,6 @@ enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', =
'qlist', 'qfloat', 'qbo
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
 object q_empty
+doc symbol=3DStatus expr=3D('enum', 'Status')
+    body=3D
+
diff --git a/tests/qapi-schema/include-simple-sub.json b/tests/qapi-schem=
a/include-simple-sub.json
index 4bd4af4162..b4bd8a23d7 100644
--- a/tests/qapi-schema/include-simple-sub.json
+++ b/tests/qapi-schema/include-simple-sub.json
@@ -1,2 +1,5 @@
+##
+# @Status:
+##
 { 'enum': 'Status',
   'data': [ 'good', 'bad', 'ugly' ] }
diff --git a/tests/qapi-schema/include-simple.out b/tests/qapi-schema/inc=
lude-simple.out
index 5d7c13cad1..ab3d74f49f 100644
--- a/tests/qapi-schema/include-simple.out
+++ b/tests/qapi-schema/include-simple.out
@@ -2,3 +2,6 @@ enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', =
'qlist', 'qfloat', 'qbo
     prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
 object q_empty
+doc symbol=3DStatus expr=3D('enum', 'Status')
+    body=3D
+
diff --git a/tests/qapi-schema/indented-expr.json b/tests/qapi-schema/ind=
ented-expr.json
index 7115d3131e..d759be1877 100644
--- a/tests/qapi-schema/indented-expr.json
+++ b/tests/qapi-schema/indented-expr.json
@@ -1,2 +1,8 @@
+##
+# @eins:
+##
 { 'command' : 'eins' }
+##
+# @zwei:
+##
  { 'command' : 'zwei' }
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/inde=
nted-expr.out
index e8171c935f..4ef4d7f48d 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -5,3 +5,9 @@ command eins None -> None
 object q_empty
 command zwei None -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
+doc symbol=3Deins expr=3D('command', 'eins')
+    body=3D
+
+doc symbol=3Dzwei expr=3D('command', 'zwei')
+    body=3D
+
diff --git a/tests/qapi-schema/missing-type.err b/tests/qapi-schema/missi=
ng-type.err
index b3e7b14e42..74c4ef7324 100644
--- a/tests/qapi-schema/missing-type.err
+++ b/tests/qapi-schema/missing-type.err
@@ -1 +1 @@
-tests/qapi-schema/missing-type.json:2: Expression is missing metatype
+tests/qapi-schema/missing-type.json:6: Expression is missing metatype
diff --git a/tests/qapi-schema/missing-type.json b/tests/qapi-schema/miss=
ing-type.json
index ff5349d3fe..c2fc62d0af 100644
--- a/tests/qapi-schema/missing-type.json
+++ b/tests/qapi-schema/missing-type.json
@@ -1,2 +1,6 @@
 # we reject an expression with missing metatype
+
+##
+# @foo:
+##
 { 'data': { } }
diff --git a/tests/qapi-schema/nested-struct-data.err b/tests/qapi-schema=
/nested-struct-data.err
index da767bade2..379bd1d3f4 100644
--- a/tests/qapi-schema/nested-struct-data.err
+++ b/tests/qapi-schema/nested-struct-data.err
@@ -1 +1 @@
-tests/qapi-schema/nested-struct-data.json:2: Member 'a' of 'data' for co=
mmand 'foo' should be a type name
+tests/qapi-schema/nested-struct-data.json:6: Member 'a' of 'data' for co=
mmand 'foo' should be a type name
diff --git a/tests/qapi-schema/nested-struct-data.json b/tests/qapi-schem=
a/nested-struct-data.json
index efbe773ded..6106e15e86 100644
--- a/tests/qapi-schema/nested-struct-data.json
+++ b/tests/qapi-schema/nested-struct-data.json
@@ -1,3 +1,7 @@
 # inline subtypes collide with our desired future use of defaults
+
+##
+# @foo:
+##
 { 'command': 'foo',
   'data': { 'a' : { 'string' : 'str', 'integer': 'int' }, 'b' : 'str' } =
}
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 17194637ba..f4d8cc4230 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -3,67 +3,153 @@
 # This file is a stress test of supported qapi constructs that must
 # parse and compile correctly.
=20
+##
+# =3D Section
+# =3D=3D subsection
+#
+# Some text foo with *strong* and _emphasis_
+# 1. with a list
+# 2. like that @foo
+#
+# And some code:
+# | $ echo foo
+# | -> do this
+# | <- get that
+#
+# Note: is not a meta
+##
+
+##
+# @TestStruct:
+#
+# body with @var
+#
+# @integer: foo
+#           blah
+#
+#           bao
+#
+# @boolean: bar
+# @string: baz
+#
+# Example:
+#
+# -> { "execute": ... }
+# <- { "return": ... }
+#
+# Since: 2.3
+# Note: a note
+#
+##
 { 'struct': 'TestStruct',
   'data': { 'integer': 'int', 'boolean': 'bool', 'string': 'str' } }
=20
+##
+# @NestedEnumsOne:
 # for testing enums
+##
 { 'struct': 'NestedEnumsOne',
   'data': { 'enum1': 'EnumOne',   # Intentional forward reference
             '*enum2': 'EnumOne', 'enum3': 'EnumOne', '*enum4': 'EnumOne'=
 } }
=20
+##
+# @MyEnum:
 # An empty enum, although unusual, is currently acceptable
+##
 { 'enum': 'MyEnum', 'data': [ ] }
=20
+##
+# @Empty1:
 # Likewise for an empty struct, including an empty base
+##
 { 'struct': 'Empty1', 'data': { } }
+##
+# @Empty2:
+##
 { 'struct': 'Empty2', 'base': 'Empty1', 'data': { } }
=20
+##
+# @user_def_cmd0:
+##
 { 'command': 'user_def_cmd0', 'data': 'Empty2', 'returns': 'Empty2' }
=20
+##
+# @QEnumTwo:
 # for testing override of default naming heuristic
+##
 { 'enum': 'QEnumTwo',
   'prefix': 'QENUM_TWO',
   'data': [ 'value1', 'value2' ] }
=20
+##
+# @UserDefOne:
 # for testing nested structs
+##
 { 'struct': 'UserDefOne',
   'base': 'UserDefZero',        # intentional forward reference
   'data': { 'string': 'str',
             '*enum1': 'EnumOne' } }   # intentional forward reference
=20
+##
+# @EnumOne:
+##
 { 'enum': 'EnumOne',
   'data': [ 'value1', 'value2', 'value3' ] }
=20
+##
+# @UserDefZero:
+##
 { 'struct': 'UserDefZero',
   'data': { 'integer': 'int' } }
=20
+##
+# @UserDefTwoDictDict:
+##
 { 'struct': 'UserDefTwoDictDict',
   'data': { 'userdef': 'UserDefOne', 'string': 'str' } }
=20
+##
+# @UserDefTwoDict:
+##
 { 'struct': 'UserDefTwoDict',
   'data': { 'string1': 'str',
             'dict2': 'UserDefTwoDictDict',
             '*dict3': 'UserDefTwoDictDict' } }
=20
+##
+# @UserDefTwo:
+##
 { 'struct': 'UserDefTwo',
   'data': { 'string0': 'str',
             'dict1': 'UserDefTwoDict' } }
=20
+##
+# @ForceArrays:
 # dummy struct to force generation of array types not otherwise mentione=
d
+##
 { 'struct': 'ForceArrays',
   'data': { 'unused1':['UserDefOne'], 'unused2':['UserDefTwo'],
             'unused3':['TestStruct'] } }
=20
+##
+# @UserDefA:
 # for testing unions
 # Among other things, test that a name collision between branches does
 # not cause any problems (since only one branch can be in use at a time)=
,
 # by intentionally using two branches that both have a C member 'a_b'
+##
 { 'struct': 'UserDefA',
   'data': { 'boolean': 'bool', '*a_b': 'int' } }
=20
+##
+# @UserDefB:
+##
 { 'struct': 'UserDefB',
   'data': { 'intb': 'int', '*a-b': 'bool' } }
=20
+##
+# @UserDefFlatUnion:
+##
 { 'union': 'UserDefFlatUnion',
   'base': 'UserDefUnionBase',   # intentional forward reference
   'discriminator': 'enum1',
@@ -71,35 +157,71 @@
             'value2' : 'UserDefB',
             'value3' : 'UserDefB' } }
=20
+##
+# @UserDefUnionBase:
+##
 { 'struct': 'UserDefUnionBase',
   'base': 'UserDefZero',
   'data': { 'string': 'str', 'enum1': 'EnumOne' } }
=20
+##
+# @UserDefFlatUnion2:
 # this variant of UserDefFlatUnion defaults to a union that uses members=
 with
 # allocated types to test corner cases in the cleanup/dealloc visitor
+##
 { 'union': 'UserDefFlatUnion2',
   'base': { '*integer': 'int', 'string': 'str', 'enum1': 'QEnumTwo' },
   'discriminator': 'enum1',
   'data': { 'value1' : 'UserDefC', # intentional forward reference
             'value2' : 'UserDefB' } }
=20
+##
+# @WrapAlternate:
+##
 { 'struct': 'WrapAlternate',
   'data': { 'alt': 'UserDefAlternate' } }
+##
+# @UserDefAlternate:
+##
 { 'alternate': 'UserDefAlternate',
   'data': { 'udfu': 'UserDefFlatUnion', 's': 'str', 'i': 'int' } }
=20
+##
+# @UserDefC:
+##
 { 'struct': 'UserDefC',
   'data': { 'string1': 'str', 'string2': 'str' } }
=20
 # for testing use of 'number' within alternates
+##
+# @AltStrBool:
+##
 { 'alternate': 'AltStrBool', 'data': { 's': 'str', 'b': 'bool' } }
+##
+# @AltStrNum:
+##
 { 'alternate': 'AltStrNum', 'data': { 's': 'str', 'n': 'number' } }
+##
+# @AltNumStr:
+##
 { 'alternate': 'AltNumStr', 'data': { 'n': 'number', 's': 'str' } }
+##
+# @AltStrInt:
+##
 { 'alternate': 'AltStrInt', 'data': { 's': 'str', 'i': 'int' } }
+##
+# @AltIntNum:
+##
 { 'alternate': 'AltIntNum', 'data': { 'i': 'int', 'n': 'number' } }
+##
+# @AltNumInt:
+##
 { 'alternate': 'AltNumInt', 'data': { 'n': 'number', 'i': 'int' } }
=20
+##
+# @UserDefNativeListUnion:
 # for testing native lists
+##
 { 'union': 'UserDefNativeListUnion',
   'data': { 'integer': ['int'],
             's8': ['int8'],
@@ -117,19 +239,61 @@
             'any': ['any'] } }
=20
 # testing commands
+##
+# @user_def_cmd:
+##
 { 'command': 'user_def_cmd', 'data': {} }
+##
+# @user_def_cmd1:
+##
 { 'command': 'user_def_cmd1', 'data': {'ud1a': 'UserDefOne'} }
+##
+# @user_def_cmd2:
+##
 { 'command': 'user_def_cmd2',
   'data': {'ud1a': 'UserDefOne', '*ud1b': 'UserDefOne'},
   'returns': 'UserDefTwo' }
=20
+##
+# Another comment
+##
+
+##
+# @guest-get-time:
+#
+# @guest-get-time body
+#
+# @a: an integer
+# @b: #optional integer
+#
+# Returns: returns something
+#
+# Example:
+#
+# -> { "execute": "guest-get-time", ... }
+# <- { "return": "42" }
+#
+##
+
 # Returning a non-dictionary requires a name from the whitelist
 { 'command': 'guest-get-time', 'data': {'a': 'int', '*b': 'int' },
   'returns': 'int' }
+##
+# @guest-sync:
+##
 { 'command': 'guest-sync', 'data': { 'arg': 'any' }, 'returns': 'any' }
+##
+# @boxed-struct:
+##
 { 'command': 'boxed-struct', 'boxed': true, 'data': 'UserDefZero' }
+##
+# @boxed-union:
+##
 { 'command': 'boxed-union', 'data': 'UserDefNativeListUnion', 'boxed': t=
rue }
=20
+##
+# @UserDefOptions:
+#
 # For testing integer range flattening in opts-visitor. The following sc=
hema
 # corresponds to the option format:
 #
@@ -137,6 +301,7 @@
 #
 # For simplicity, this example doesn't use [type=3D]discriminator nor op=
targs
 # specific to discriminator values.
+##
 { 'struct': 'UserDefOptions',
   'data': {
     '*i64' : [ 'int'    ],
@@ -146,35 +311,83 @@
     '*u64x':   'uint64'  } }
=20
 # testing event
+##
+# @EventStructOne:
+##
 { 'struct': 'EventStructOne',
   'data': { 'struct1': 'UserDefOne', 'string': 'str', '*enum2': 'EnumOne=
' } }
=20
+##
+# @EVENT_A:
+##
 { 'event': 'EVENT_A' }
+##
+# @EVENT_B:
+##
 { 'event': 'EVENT_B',
   'data': { } }
+##
+# @EVENT_C:
+##
 { 'event': 'EVENT_C',
   'data': { '*a': 'int', '*b': 'UserDefOne', 'c': 'str' } }
+##
+# @EVENT_D:
+##
 { 'event': 'EVENT_D',
   'data': { 'a' : 'EventStructOne', 'b' : 'str', '*c': 'str', '*enum3': =
'EnumOne' } }
+##
+# @EVENT_E:
+##
 { 'event': 'EVENT_E', 'boxed': true, 'data': 'UserDefZero' }
+##
+# @EVENT_F:
+##
 { 'event': 'EVENT_F', 'boxed': true, 'data': 'UserDefAlternate' }
=20
 # test that we correctly compile downstream extensions, as well as munge
 # ticklish names
+##
+# @__org.qemu_x-Enum:
+##
 { 'enum': '__org.qemu_x-Enum', 'data': [ '__org.qemu_x-value' ] }
+##
+# @__org.qemu_x-Base:
+##
 { 'struct': '__org.qemu_x-Base',
   'data': { '__org.qemu_x-member1': '__org.qemu_x-Enum' } }
+##
+# @__org.qemu_x-Struct:
+##
 { 'struct': '__org.qemu_x-Struct', 'base': '__org.qemu_x-Base',
   'data': { '__org.qemu_x-member2': 'str', '*wchar-t': 'int' } }
+##
+# @__org.qemu_x-Union1:
+##
 { 'union': '__org.qemu_x-Union1', 'data': { '__org.qemu_x-branch': 'str'=
 } }
+##
+# @__org.qemu_x-Struct2:
+##
 { 'struct': '__org.qemu_x-Struct2',
   'data': { 'array': ['__org.qemu_x-Union1'] } }
+##
+# @__org.qemu_x-Union2:
+##
 { 'union': '__org.qemu_x-Union2', 'base': '__org.qemu_x-Base',
   'discriminator': '__org.qemu_x-member1',
   'data': { '__org.qemu_x-value': '__org.qemu_x-Struct2' } }
+##
+# @__org.qemu_x-Alt:
+##
 { 'alternate': '__org.qemu_x-Alt',
   'data': { '__org.qemu_x-branch': 'str', 'b': '__org.qemu_x-Base' } }
+##
+# @__ORG.QEMU_X-EVENT:
+##
 { 'event': '__ORG.QEMU_X-EVENT', 'data': '__org.qemu_x-Struct' }
+##
+# @__org.qemu_x-command:
+##
 { 'command': '__org.qemu_x-command',
   'data': { 'a': ['__org.qemu_x-Enum'], 'b': ['__org.qemu_x-Struct'],
             'c': '__org.qemu_x-Union2', 'd': '__org.qemu_x-Alt' },
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 9d99c4eebb..1b44be8045 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -232,3 +232,215 @@ command user_def_cmd1 q_obj_user_def_cmd1-arg -> No=
ne
    gen=3DTrue success_response=3DTrue boxed=3DFalse
 command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDefTwo
    gen=3DTrue success_response=3DTrue boxed=3DFalse
+doc freeform
+    body=3D
+=3D Section
+=3D=3D subsection
+
+Some text foo with *strong* and _emphasis_
+1. with a list
+2. like that @foo
+
+And some code:
+| $ echo foo
+| -> do this
+| <- get that
+
+Note: is not a meta
+doc symbol=3DTestStruct expr=3D('struct', 'TestStruct')
+    arg=3Dinteger
+foo
+blah
+
+bao
+    arg=3Dboolean
+bar
+    arg=3Dstring
+baz
+    section=3DExample
+-> { "execute": ... }
+<- { "return": ... }
+    section=3DSince
+2.3
+    section=3DNote
+a note
+    body=3D
+body with @var
+doc symbol=3DNestedEnumsOne expr=3D('struct', 'NestedEnumsOne')
+    body=3D
+for testing enums
+doc symbol=3DMyEnum expr=3D('enum', 'MyEnum')
+    body=3D
+An empty enum, although unusual, is currently acceptable
+doc symbol=3DEmpty1 expr=3D('struct', 'Empty1')
+    body=3D
+Likewise for an empty struct, including an empty base
+doc symbol=3DEmpty2 expr=3D('struct', 'Empty2')
+    body=3D
+
+doc symbol=3Duser_def_cmd0 expr=3D('command', 'user_def_cmd0')
+    body=3D
+
+doc symbol=3DQEnumTwo expr=3D('enum', 'QEnumTwo')
+    body=3D
+for testing override of default naming heuristic
+doc symbol=3DUserDefOne expr=3D('struct', 'UserDefOne')
+    body=3D
+for testing nested structs
+doc symbol=3DEnumOne expr=3D('enum', 'EnumOne')
+    body=3D
+
+doc symbol=3DUserDefZero expr=3D('struct', 'UserDefZero')
+    body=3D
+
+doc symbol=3DUserDefTwoDictDict expr=3D('struct', 'UserDefTwoDictDict')
+    body=3D
+
+doc symbol=3DUserDefTwoDict expr=3D('struct', 'UserDefTwoDict')
+    body=3D
+
+doc symbol=3DUserDefTwo expr=3D('struct', 'UserDefTwo')
+    body=3D
+
+doc symbol=3DForceArrays expr=3D('struct', 'ForceArrays')
+    body=3D
+dummy struct to force generation of array types not otherwise mentioned
+doc symbol=3DUserDefA expr=3D('struct', 'UserDefA')
+    body=3D
+for testing unions
+Among other things, test that a name collision between branches does
+not cause any problems (since only one branch can be in use at a time),
+by intentionally using two branches that both have a C member 'a_b'
+doc symbol=3DUserDefB expr=3D('struct', 'UserDefB')
+    body=3D
+
+doc symbol=3DUserDefFlatUnion expr=3D('union', 'UserDefFlatUnion')
+    body=3D
+
+doc symbol=3DUserDefUnionBase expr=3D('struct', 'UserDefUnionBase')
+    body=3D
+
+doc symbol=3DUserDefFlatUnion2 expr=3D('union', 'UserDefFlatUnion2')
+    body=3D
+this variant of UserDefFlatUnion defaults to a union that uses members w=
ith
+allocated types to test corner cases in the cleanup/dealloc visitor
+doc symbol=3DWrapAlternate expr=3D('struct', 'WrapAlternate')
+    body=3D
+
+doc symbol=3DUserDefAlternate expr=3D('alternate', 'UserDefAlternate')
+    body=3D
+
+doc symbol=3DUserDefC expr=3D('struct', 'UserDefC')
+    body=3D
+
+doc symbol=3DAltStrBool expr=3D('alternate', 'AltStrBool')
+    body=3D
+
+doc symbol=3DAltStrNum expr=3D('alternate', 'AltStrNum')
+    body=3D
+
+doc symbol=3DAltNumStr expr=3D('alternate', 'AltNumStr')
+    body=3D
+
+doc symbol=3DAltStrInt expr=3D('alternate', 'AltStrInt')
+    body=3D
+
+doc symbol=3DAltIntNum expr=3D('alternate', 'AltIntNum')
+    body=3D
+
+doc symbol=3DAltNumInt expr=3D('alternate', 'AltNumInt')
+    body=3D
+
+doc symbol=3DUserDefNativeListUnion expr=3D('union', 'UserDefNativeListU=
nion')
+    body=3D
+for testing native lists
+doc symbol=3Duser_def_cmd expr=3D('command', 'user_def_cmd')
+    body=3D
+
+doc symbol=3Duser_def_cmd1 expr=3D('command', 'user_def_cmd1')
+    body=3D
+
+doc symbol=3Duser_def_cmd2 expr=3D('command', 'user_def_cmd2')
+    body=3D
+
+doc freeform
+    body=3D
+Another comment
+doc symbol=3Dguest-get-time expr=3D('command', 'guest-get-time')
+    arg=3Da
+an integer
+    arg=3Db
+#optional integer
+    section=3DReturns
+returns something
+    section=3DExample
+-> { "execute": "guest-get-time", ... }
+<- { "return": "42" }
+    body=3D
+@guest-get-time body
+doc symbol=3Dguest-sync expr=3D('command', 'guest-sync')
+    body=3D
+
+doc symbol=3Dboxed-struct expr=3D('command', 'boxed-struct')
+    body=3D
+
+doc symbol=3Dboxed-union expr=3D('command', 'boxed-union')
+    body=3D
+
+doc symbol=3DUserDefOptions expr=3D('struct', 'UserDefOptions')
+    body=3D
+For testing integer range flattening in opts-visitor. The following sche=
ma
+corresponds to the option format:
+
+-userdef i64=3D3-6,i64=3D-5--1,u64=3D2,u16=3D1,u16=3D7-12
+
+For simplicity, this example doesn't use [type=3D]discriminator nor opta=
rgs
+specific to discriminator values.
+doc symbol=3DEventStructOne expr=3D('struct', 'EventStructOne')
+    body=3D
+
+doc symbol=3DEVENT_A expr=3D('event', 'EVENT_A')
+    body=3D
+
+doc symbol=3DEVENT_B expr=3D('event', 'EVENT_B')
+    body=3D
+
+doc symbol=3DEVENT_C expr=3D('event', 'EVENT_C')
+    body=3D
+
+doc symbol=3DEVENT_D expr=3D('event', 'EVENT_D')
+    body=3D
+
+doc symbol=3DEVENT_E expr=3D('event', 'EVENT_E')
+    body=3D
+
+doc symbol=3DEVENT_F expr=3D('event', 'EVENT_F')
+    body=3D
+
+doc symbol=3D__org.qemu_x-Enum expr=3D('enum', '__org.qemu_x-Enum')
+    body=3D
+
+doc symbol=3D__org.qemu_x-Base expr=3D('struct', '__org.qemu_x-Base')
+    body=3D
+
+doc symbol=3D__org.qemu_x-Struct expr=3D('struct', '__org.qemu_x-Struct'=
)
+    body=3D
+
+doc symbol=3D__org.qemu_x-Union1 expr=3D('union', '__org.qemu_x-Union1')
+    body=3D
+
+doc symbol=3D__org.qemu_x-Struct2 expr=3D('struct', '__org.qemu_x-Struct=
2')
+    body=3D
+
+doc symbol=3D__org.qemu_x-Union2 expr=3D('union', '__org.qemu_x-Union2')
+    body=3D
+
+doc symbol=3D__org.qemu_x-Alt expr=3D('alternate', '__org.qemu_x-Alt')
+    body=3D
+
+doc symbol=3D__ORG.QEMU_X-EVENT expr=3D('event', '__ORG.QEMU_X-EVENT')
+    body=3D
+
+doc symbol=3D__org.qemu_x-command expr=3D('command', '__org.qemu_x-comma=
nd')
+    body=3D
+
diff --git a/tests/qapi-schema/redefined-builtin.err b/tests/qapi-schema/=
redefined-builtin.err
index b2757225c4..ee0a2adf0b 100644
--- a/tests/qapi-schema/redefined-builtin.err
+++ b/tests/qapi-schema/redefined-builtin.err
@@ -1 +1 @@
-tests/qapi-schema/redefined-builtin.json:2: built-in 'size' is already d=
efined
+tests/qapi-schema/redefined-builtin.json:6: built-in 'size' is already d=
efined
diff --git a/tests/qapi-schema/redefined-builtin.json b/tests/qapi-schema=
/redefined-builtin.json
index 45b8a550ad..6d3a940d5e 100644
--- a/tests/qapi-schema/redefined-builtin.json
+++ b/tests/qapi-schema/redefined-builtin.json
@@ -1,2 +1,6 @@
 # we reject types that duplicate builtin names
+
+##
+# @size:
+##
 { 'struct': 'size', 'data': { 'myint': 'size' } }
diff --git a/tests/qapi-schema/redefined-command.err b/tests/qapi-schema/=
redefined-command.err
index 82ae256e63..1e297c43ba 100644
--- a/tests/qapi-schema/redefined-command.err
+++ b/tests/qapi-schema/redefined-command.err
@@ -1 +1 @@
-tests/qapi-schema/redefined-command.json:3: command 'foo' is already def=
ined
+tests/qapi-schema/redefined-command.json:10: command 'foo' is already de=
fined
diff --git a/tests/qapi-schema/redefined-command.json b/tests/qapi-schema=
/redefined-command.json
index 247e401948..3a8cb9024c 100644
--- a/tests/qapi-schema/redefined-command.json
+++ b/tests/qapi-schema/redefined-command.json
@@ -1,3 +1,10 @@
 # we reject commands defined more than once
+
+##
+# @foo:
+##
 { 'command': 'foo', 'data': { 'one': 'str' } }
+##
+# @foo:
+##
 { 'command': 'foo', 'data': { '*two': 'str' } }
diff --git a/tests/qapi-schema/redefined-event.err b/tests/qapi-schema/re=
defined-event.err
index 35429cb481..912c785119 100644
--- a/tests/qapi-schema/redefined-event.err
+++ b/tests/qapi-schema/redefined-event.err
@@ -1 +1 @@
-tests/qapi-schema/redefined-event.json:3: event 'EVENT_A' is already def=
ined
+tests/qapi-schema/redefined-event.json:10: event 'EVENT_A' is already de=
fined
diff --git a/tests/qapi-schema/redefined-event.json b/tests/qapi-schema/r=
edefined-event.json
index 7717e91c18..ec7aeea0f0 100644
--- a/tests/qapi-schema/redefined-event.json
+++ b/tests/qapi-schema/redefined-event.json
@@ -1,3 +1,10 @@
 # we reject duplicate events
+
+##
+# @EVENT_A:
+##
 { 'event': 'EVENT_A', 'data': { 'myint': 'int' } }
+##
+# @EVENT_A:
+##
 { 'event': 'EVENT_A', 'data': { 'myint': 'int' } }
diff --git a/tests/qapi-schema/redefined-type.err b/tests/qapi-schema/red=
efined-type.err
index 06ea78c478..28d87c098c 100644
--- a/tests/qapi-schema/redefined-type.err
+++ b/tests/qapi-schema/redefined-type.err
@@ -1 +1 @@
-tests/qapi-schema/redefined-type.json:3: struct 'foo' is already defined
+tests/qapi-schema/redefined-type.json:10: struct 'foo' is already define=
d
diff --git a/tests/qapi-schema/redefined-type.json b/tests/qapi-schema/re=
defined-type.json
index a09e768bae..7a8f3e1ec8 100644
--- a/tests/qapi-schema/redefined-type.json
+++ b/tests/qapi-schema/redefined-type.json
@@ -1,3 +1,10 @@
 # we reject types defined more than once
+
+##
+# @foo:
+##
 { 'struct': 'foo', 'data': { 'one': 'str' } }
+##
+# @foo:
+##
 { 'enum': 'foo', 'data': [ 'two' ] }
diff --git a/tests/qapi-schema/reserved-command-q.err b/tests/qapi-schema=
/reserved-command-q.err
index f939e044eb..5e17f3169b 100644
--- a/tests/qapi-schema/reserved-command-q.err
+++ b/tests/qapi-schema/reserved-command-q.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-command-q.json:5: 'command' uses invalid name=
 'q-unix'
+tests/qapi-schema/reserved-command-q.json:12: 'command' uses invalid nam=
e 'q-unix'
diff --git a/tests/qapi-schema/reserved-command-q.json b/tests/qapi-schem=
a/reserved-command-q.json
index 99f8aae314..bba0860c99 100644
--- a/tests/qapi-schema/reserved-command-q.json
+++ b/tests/qapi-schema/reserved-command-q.json
@@ -1,5 +1,12 @@
 # C entity name collision
 # We reject names like 'q-unix', because they can collide with the mangl=
ed
 # name for 'unix' in generated C.
+
+##
+# @unix:
+##
 { 'command': 'unix' }
+##
+# @q-unix:
+##
 { 'command': 'q-unix' }
diff --git a/tests/qapi-schema/reserved-enum-q.err b/tests/qapi-schema/re=
served-enum-q.err
index e1c3480ee2..acb2df811d 100644
--- a/tests/qapi-schema/reserved-enum-q.err
+++ b/tests/qapi-schema/reserved-enum-q.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-enum-q.json:4: Member of enum 'Foo' uses inva=
lid name 'q-Unix'
+tests/qapi-schema/reserved-enum-q.json:8: Member of enum 'Foo' uses inva=
lid name 'q-Unix'
diff --git a/tests/qapi-schema/reserved-enum-q.json b/tests/qapi-schema/r=
eserved-enum-q.json
index 3593a765ea..6c7e7177c3 100644
--- a/tests/qapi-schema/reserved-enum-q.json
+++ b/tests/qapi-schema/reserved-enum-q.json
@@ -1,4 +1,8 @@
 # C entity name collision
 # We reject names like 'q-unix', because they can collide with the mangl=
ed
 # name for 'unix' in generated C.
+
+##
+# @Foo:
+##
 { 'enum': 'Foo', 'data': [ 'unix', 'q-Unix' ] }
diff --git a/tests/qapi-schema/reserved-member-has.err b/tests/qapi-schem=
a/reserved-member-has.err
index e755771446..9ace796055 100644
--- a/tests/qapi-schema/reserved-member-has.err
+++ b/tests/qapi-schema/reserved-member-has.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-member-has.json:5: Member of 'data' for comma=
nd 'oops' uses reserved name 'has-a'
+tests/qapi-schema/reserved-member-has.json:9: Member of 'data' for comma=
nd 'oops' uses reserved name 'has-a'
diff --git a/tests/qapi-schema/reserved-member-has.json b/tests/qapi-sche=
ma/reserved-member-has.json
index 45b9109bdc..f0d8905ca2 100644
--- a/tests/qapi-schema/reserved-member-has.json
+++ b/tests/qapi-schema/reserved-member-has.json
@@ -2,4 +2,8 @@
 # We reject names like 'has-a', because they can collide with the flag
 # for an optional 'a' in generated C.
 # TODO we could munge the optional flag name to avoid the collision.
+
+##
+# @oops:
+##
 { 'command': 'oops', 'data': { '*a': 'str', 'has-a': 'str' } }
diff --git a/tests/qapi-schema/reserved-member-q.err b/tests/qapi-schema/=
reserved-member-q.err
index f3d5dd7818..1709a88462 100644
--- a/tests/qapi-schema/reserved-member-q.err
+++ b/tests/qapi-schema/reserved-member-q.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-member-q.json:4: Member of 'data' for struct =
'Foo' uses invalid name 'q-unix'
+tests/qapi-schema/reserved-member-q.json:8: Member of 'data' for struct =
'Foo' uses invalid name 'q-unix'
diff --git a/tests/qapi-schema/reserved-member-q.json b/tests/qapi-schema=
/reserved-member-q.json
index 62fed8fddf..f51e312917 100644
--- a/tests/qapi-schema/reserved-member-q.json
+++ b/tests/qapi-schema/reserved-member-q.json
@@ -1,4 +1,8 @@
 # C member name collision
 # We reject names like 'q-unix', because they can collide with the mangl=
ed
 # name for 'unix' in generated C.
+
+##
+# @Foo:
+##
 { 'struct': 'Foo', 'data': { 'unix':'int', 'q-unix':'bool' } }
diff --git a/tests/qapi-schema/reserved-member-u.err b/tests/qapi-schema/=
reserved-member-u.err
index 87d42296cc..6ec69a712a 100644
--- a/tests/qapi-schema/reserved-member-u.err
+++ b/tests/qapi-schema/reserved-member-u.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-member-u.json:7: Member of 'data' for struct =
'Oops' uses reserved name 'u'
+tests/qapi-schema/reserved-member-u.json:11: Member of 'data' for struct=
 'Oops' uses reserved name 'u'
diff --git a/tests/qapi-schema/reserved-member-u.json b/tests/qapi-schema=
/reserved-member-u.json
index 1eaf0f301c..3a578e5b56 100644
--- a/tests/qapi-schema/reserved-member-u.json
+++ b/tests/qapi-schema/reserved-member-u.json
@@ -4,4 +4,8 @@
 # This is true even for non-unions, because it is possible to convert a
 # struct to flat union while remaining backwards compatible in QMP.
 # TODO - we could munge the member name to 'q_u' to avoid the collision
+
+##
+# @Oops:
+##
 { 'struct': 'Oops', 'data': { 'u': 'str' } }
diff --git a/tests/qapi-schema/reserved-member-underscore.err b/tests/qap=
i-schema/reserved-member-underscore.err
index 65ff0da8ce..c9aefee3a8 100644
--- a/tests/qapi-schema/reserved-member-underscore.err
+++ b/tests/qapi-schema/reserved-member-underscore.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-member-underscore.json:4: Member of 'data' fo=
r struct 'Oops' uses invalid name '_oops'
+tests/qapi-schema/reserved-member-underscore.json:8: Member of 'data' fo=
r struct 'Oops' uses invalid name '_oops'
diff --git a/tests/qapi-schema/reserved-member-underscore.json b/tests/qa=
pi-schema/reserved-member-underscore.json
index 4a3a017638..cc34b54b02 100644
--- a/tests/qapi-schema/reserved-member-underscore.json
+++ b/tests/qapi-schema/reserved-member-underscore.json
@@ -1,4 +1,8 @@
 # C member name collision
 # We reject use of a single leading underscore in all names (names must
 # begin with a letter or a downstream extension double-underscore prefix=
).
+
+##
+# @Oops:
+##
 { 'struct': 'Oops', 'data': { '_oops': 'str' } }
diff --git a/tests/qapi-schema/reserved-type-kind.err b/tests/qapi-schema=
/reserved-type-kind.err
index 0a38efaad8..8698073062 100644
--- a/tests/qapi-schema/reserved-type-kind.err
+++ b/tests/qapi-schema/reserved-type-kind.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-type-kind.json:2: enum 'UnionKind' should not=
 end in 'Kind'
+tests/qapi-schema/reserved-type-kind.json:6: enum 'UnionKind' should not=
 end in 'Kind'
diff --git a/tests/qapi-schema/reserved-type-kind.json b/tests/qapi-schem=
a/reserved-type-kind.json
index 9ecaba12bc..a094941561 100644
--- a/tests/qapi-schema/reserved-type-kind.json
+++ b/tests/qapi-schema/reserved-type-kind.json
@@ -1,2 +1,6 @@
 # we reject types that would conflict with implicit union enum
+
+##
+# @UnionKind:
+##
 { 'enum': 'UnionKind', 'data': [ 'oops' ] }
diff --git a/tests/qapi-schema/reserved-type-list.err b/tests/qapi-schema=
/reserved-type-list.err
index 4510fa6d90..ec0531c4b9 100644
--- a/tests/qapi-schema/reserved-type-list.err
+++ b/tests/qapi-schema/reserved-type-list.err
@@ -1 +1 @@
-tests/qapi-schema/reserved-type-list.json:5: struct 'FooList' should not=
 end in 'List'
+tests/qapi-schema/reserved-type-list.json:9: struct 'FooList' should not=
 end in 'List'
diff --git a/tests/qapi-schema/reserved-type-list.json b/tests/qapi-schem=
a/reserved-type-list.json
index 98d53bf808..6effb78e7f 100644
--- a/tests/qapi-schema/reserved-type-list.json
+++ b/tests/qapi-schema/reserved-type-list.json
@@ -2,4 +2,8 @@
 # We reserve names ending in 'List' for use by array types.
 # TODO - we could choose array names to avoid collision with user types,
 # in order to let this compile
+
+##
+# @FooList:
+##
 { 'struct': 'FooList', 'data': { 's': 'str' } }
diff --git a/tests/qapi-schema/returns-alternate.err b/tests/qapi-schema/=
returns-alternate.err
index dfbb419cac..2b81623ca3 100644
--- a/tests/qapi-schema/returns-alternate.err
+++ b/tests/qapi-schema/returns-alternate.err
@@ -1 +1 @@
-tests/qapi-schema/returns-alternate.json:3: 'returns' for command 'oops'=
 cannot use alternate type 'Alt'
+tests/qapi-schema/returns-alternate.json:10: 'returns' for command 'oops=
' cannot use alternate type 'Alt'
diff --git a/tests/qapi-schema/returns-alternate.json b/tests/qapi-schema=
/returns-alternate.json
index 972390c06b..005bf2d148 100644
--- a/tests/qapi-schema/returns-alternate.json
+++ b/tests/qapi-schema/returns-alternate.json
@@ -1,3 +1,10 @@
 # we reject returns if it is an alternate type
+
+##
+# @Alt:
+##
 { 'alternate': 'Alt', 'data': { 'a': 'int', 'b': 'str' } }
+##
+# @oops:
+##
 { 'command': 'oops', 'returns': 'Alt' }
diff --git a/tests/qapi-schema/returns-array-bad.err b/tests/qapi-schema/=
returns-array-bad.err
index 138095ccde..b53bdb0ade 100644
--- a/tests/qapi-schema/returns-array-bad.err
+++ b/tests/qapi-schema/returns-array-bad.err
@@ -1 +1 @@
-tests/qapi-schema/returns-array-bad.json:2: 'returns' for command 'oops'=
: array type must contain single type name
+tests/qapi-schema/returns-array-bad.json:6: 'returns' for command 'oops'=
: array type must contain single type name
diff --git a/tests/qapi-schema/returns-array-bad.json b/tests/qapi-schema=
/returns-array-bad.json
index 09b0b1f182..30528fed29 100644
--- a/tests/qapi-schema/returns-array-bad.json
+++ b/tests/qapi-schema/returns-array-bad.json
@@ -1,2 +1,6 @@
 # we reject an array return that is not a single type
+
+##
+# @oops:
+##
 { 'command': 'oops', 'returns': [ 'str', 'str' ] }
diff --git a/tests/qapi-schema/returns-dict.err b/tests/qapi-schema/retur=
ns-dict.err
index eb2d0c4661..1570a35d49 100644
--- a/tests/qapi-schema/returns-dict.err
+++ b/tests/qapi-schema/returns-dict.err
@@ -1 +1 @@
-tests/qapi-schema/returns-dict.json:2: 'returns' for command 'oops' shou=
ld be a type name
+tests/qapi-schema/returns-dict.json:6: 'returns' for command 'oops' shou=
ld be a type name
diff --git a/tests/qapi-schema/returns-dict.json b/tests/qapi-schema/retu=
rns-dict.json
index 1cfef3ede7..6a3ed0f34d 100644
--- a/tests/qapi-schema/returns-dict.json
+++ b/tests/qapi-schema/returns-dict.json
@@ -1,2 +1,6 @@
 # we reject inline struct return type
+
+##
+# @oops:
+##
 { 'command': 'oops', 'returns': { 'a': 'str' } }
diff --git a/tests/qapi-schema/returns-unknown.err b/tests/qapi-schema/re=
turns-unknown.err
index 1f43e3ac9f..d76bcfe455 100644
--- a/tests/qapi-schema/returns-unknown.err
+++ b/tests/qapi-schema/returns-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/returns-unknown.json:2: 'returns' for command 'oops' u=
ses unknown type 'NoSuchType'
+tests/qapi-schema/returns-unknown.json:6: 'returns' for command 'oops' u=
ses unknown type 'NoSuchType'
diff --git a/tests/qapi-schema/returns-unknown.json b/tests/qapi-schema/r=
eturns-unknown.json
index 25bd498bff..3837f0e607 100644
--- a/tests/qapi-schema/returns-unknown.json
+++ b/tests/qapi-schema/returns-unknown.json
@@ -1,2 +1,6 @@
 # we reject returns if it does not contain a known type
+
+##
+# @oops:
+##
 { 'command': 'oops', 'returns': 'NoSuchType' }
diff --git a/tests/qapi-schema/returns-whitelist.err b/tests/qapi-schema/=
returns-whitelist.err
index f47c1ee7ca..e77ea2da3f 100644
--- a/tests/qapi-schema/returns-whitelist.err
+++ b/tests/qapi-schema/returns-whitelist.err
@@ -1 +1 @@
-tests/qapi-schema/returns-whitelist.json:10: 'returns' for command 'no-w=
ay-this-will-get-whitelisted' cannot use built-in type 'int'
+tests/qapi-schema/returns-whitelist.json:26: 'returns' for command 'no-w=
ay-this-will-get-whitelisted' cannot use built-in type 'int'
diff --git a/tests/qapi-schema/returns-whitelist.json b/tests/qapi-schema=
/returns-whitelist.json
index e8b3cea396..0bc952db87 100644
--- a/tests/qapi-schema/returns-whitelist.json
+++ b/tests/qapi-schema/returns-whitelist.json
@@ -1,11 +1,27 @@
 # we enforce that 'returns' be a dict or array of dict unless whiteliste=
d
+
+##
+# @human-monitor-command:
+##
 { 'command': 'human-monitor-command',
   'data': {'command-line': 'str', '*cpu-index': 'int'},
   'returns': 'str' }
+##
+# @TpmModel:
+##
 { 'enum': 'TpmModel', 'data': [ 'tpm-tis' ] }
+##
+# @query-tpm-models:
+##
 { 'command': 'query-tpm-models', 'returns': ['TpmModel'] }
+##
+# @guest-get-time:
+##
 { 'command': 'guest-get-time',
   'returns': 'int' }
=20
+##
+# @no-way-this-will-get-whitelisted:
+##
 { 'command': 'no-way-this-will-get-whitelisted',
   'returns': [ 'int' ] }
diff --git a/tests/qapi-schema/struct-base-clash-deep.err b/tests/qapi-sc=
hema/struct-base-clash-deep.err
index e2d7943f21..1b7c0e9d12 100644
--- a/tests/qapi-schema/struct-base-clash-deep.err
+++ b/tests/qapi-schema/struct-base-clash-deep.err
@@ -1 +1 @@
-tests/qapi-schema/struct-base-clash-deep.json:10: 'name' (member of Sub)=
 collides with 'name' (member of Base)
+tests/qapi-schema/struct-base-clash-deep.json:20: 'name' (member of Sub)=
 collides with 'name' (member of Base)
diff --git a/tests/qapi-schema/struct-base-clash-deep.json b/tests/qapi-s=
chema/struct-base-clash-deep.json
index fa873ab5d4..646d680ad6 100644
--- a/tests/qapi-schema/struct-base-clash-deep.json
+++ b/tests/qapi-schema/struct-base-clash-deep.json
@@ -2,11 +2,21 @@
 # Here, 'name' would have to appear twice on the wire, locally and
 # indirectly for the grandparent base; the collision doesn't care that
 # one instance is optional.
+
+##
+# @Base:
+##
 { 'struct': 'Base',
   'data': { 'name': 'str' } }
+##
+# @Mid:
+##
 { 'struct': 'Mid',
   'base': 'Base',
   'data': { 'value': 'int' } }
+##
+# @Sub:
+##
 { 'struct': 'Sub',
   'base': 'Mid',
   'data': { '*name': 'str' } }
diff --git a/tests/qapi-schema/struct-base-clash.err b/tests/qapi-schema/=
struct-base-clash.err
index c52f33d27b..5fe6393efa 100644
--- a/tests/qapi-schema/struct-base-clash.err
+++ b/tests/qapi-schema/struct-base-clash.err
@@ -1 +1 @@
-tests/qapi-schema/struct-base-clash.json:5: 'name' (member of Sub) colli=
des with 'name' (member of Base)
+tests/qapi-schema/struct-base-clash.json:12: 'name' (member of Sub) coll=
ides with 'name' (member of Base)
diff --git a/tests/qapi-schema/struct-base-clash.json b/tests/qapi-schema=
/struct-base-clash.json
index 11aec80fe5..a8539958b5 100644
--- a/tests/qapi-schema/struct-base-clash.json
+++ b/tests/qapi-schema/struct-base-clash.json
@@ -1,7 +1,14 @@
 # Reject attempts to duplicate QMP members
 # Here, 'name' would have to appear twice on the wire, locally and for b=
ase.
+
+##
+# @Base:
+##
 { 'struct': 'Base',
   'data': { 'name': 'str' } }
+##
+# @Sub:
+##
 { 'struct': 'Sub',
   'base': 'Base',
   'data': { 'name': 'str' } }
diff --git a/tests/qapi-schema/struct-data-invalid.err b/tests/qapi-schem=
a/struct-data-invalid.err
index 6644f4c2ad..27163355bd 100644
--- a/tests/qapi-schema/struct-data-invalid.err
+++ b/tests/qapi-schema/struct-data-invalid.err
@@ -1 +1 @@
-tests/qapi-schema/struct-data-invalid.json:1: 'data' for struct 'foo' sh=
ould be a dictionary or type name
+tests/qapi-schema/struct-data-invalid.json:4: 'data' for struct 'foo' sh=
ould be a dictionary or type name
diff --git a/tests/qapi-schema/struct-data-invalid.json b/tests/qapi-sche=
ma/struct-data-invalid.json
index 9adbc3bb6b..aa817bda34 100644
--- a/tests/qapi-schema/struct-data-invalid.json
+++ b/tests/qapi-schema/struct-data-invalid.json
@@ -1,2 +1,5 @@
+##
+# @foo:
+##
 { 'struct': 'foo',
   'data': false }
diff --git a/tests/qapi-schema/struct-member-invalid.err b/tests/qapi-sch=
ema/struct-member-invalid.err
index 69a326d450..f2b105ba88 100644
--- a/tests/qapi-schema/struct-member-invalid.err
+++ b/tests/qapi-schema/struct-member-invalid.err
@@ -1 +1 @@
-tests/qapi-schema/struct-member-invalid.json:1: Member 'a' of 'data' for=
 struct 'foo' should be a type name
+tests/qapi-schema/struct-member-invalid.json:4: Member 'a' of 'data' for=
 struct 'foo' should be a type name
diff --git a/tests/qapi-schema/struct-member-invalid.json b/tests/qapi-sc=
hema/struct-member-invalid.json
index 8f172f7a87..10c74262d3 100644
--- a/tests/qapi-schema/struct-member-invalid.json
+++ b/tests/qapi-schema/struct-member-invalid.json
@@ -1,2 +1,5 @@
+##
+# @foo:
+##
 { 'struct': 'foo',
   'data': { 'a': false } }
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index ef74e2c4c8..39b55b994a 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -55,3 +55,15 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
=20
 schema =3D QAPISchema(sys.argv[1])
 schema.visit(QAPISchemaTestVisitor())
+
+for doc in schema.docs:
+    if doc.symbol:
+        print 'doc symbol=3D%s expr=3D%s' % \
+            (doc.symbol, doc.expr.items()[0])
+    else:
+        print 'doc freeform'
+    for arg, section in doc.args.iteritems():
+        print '    arg=3D%s\n%s' % (arg, section)
+    for section in doc.sections:
+        print '    section=3D%s\n%s' % (section.name, section)
+    print '    body=3D\n%s' % doc.body
diff --git a/tests/qapi-schema/type-bypass-bad-gen.err b/tests/qapi-schem=
a/type-bypass-bad-gen.err
index a83c3c655d..bd5431f60b 100644
--- a/tests/qapi-schema/type-bypass-bad-gen.err
+++ b/tests/qapi-schema/type-bypass-bad-gen.err
@@ -1 +1 @@
-tests/qapi-schema/type-bypass-bad-gen.json:2: 'gen' of command 'foo' sho=
uld only use false value
+tests/qapi-schema/type-bypass-bad-gen.json:6: 'gen' of command 'foo' sho=
uld only use false value
diff --git a/tests/qapi-schema/type-bypass-bad-gen.json b/tests/qapi-sche=
ma/type-bypass-bad-gen.json
index e8dec34249..7162c1a0ca 100644
--- a/tests/qapi-schema/type-bypass-bad-gen.json
+++ b/tests/qapi-schema/type-bypass-bad-gen.json
@@ -1,2 +1,6 @@
 # 'gen' should only appear with value false
+
+##
+# @foo:
+##
 { 'command': 'foo', 'gen': 'whatever' }
diff --git a/tests/qapi-schema/unicode-str.err b/tests/qapi-schema/unicod=
e-str.err
index f621cd6448..92ee277370 100644
--- a/tests/qapi-schema/unicode-str.err
+++ b/tests/qapi-schema/unicode-str.err
@@ -1 +1 @@
-tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '=C3=A9=
'
+tests/qapi-schema/unicode-str.json:6: 'command' uses invalid name '=C3=A9=
'
diff --git a/tests/qapi-schema/unicode-str.json b/tests/qapi-schema/unico=
de-str.json
index 5253a1b9f3..75a08b3d93 100644
--- a/tests/qapi-schema/unicode-str.json
+++ b/tests/qapi-schema/unicode-str.json
@@ -1,2 +1,6 @@
 # we don't support full Unicode strings, yet
+
+##
+# @e:
+##
 { 'command': '=C3=A9' }
diff --git a/tests/qapi-schema/union-base-no-discriminator.err b/tests/qa=
pi-schema/union-base-no-discriminator.err
index 8b7a24260f..ca6ee92357 100644
--- a/tests/qapi-schema/union-base-no-discriminator.err
+++ b/tests/qapi-schema/union-base-no-discriminator.err
@@ -1 +1 @@
-tests/qapi-schema/union-base-no-discriminator.json:11: Simple union 'Tes=
tUnion' must not have a base
+tests/qapi-schema/union-base-no-discriminator.json:23: Simple union 'Tes=
tUnion' must not have a base
diff --git a/tests/qapi-schema/union-base-no-discriminator.json b/tests/q=
api-schema/union-base-no-discriminator.json
index 1409cf5c9e..cc6bac1424 100644
--- a/tests/qapi-schema/union-base-no-discriminator.json
+++ b/tests/qapi-schema/union-base-no-discriminator.json
@@ -1,13 +1,25 @@
+##
+# @TestTypeA:
+##
 # we reject simple unions with a base (or flat unions without discrimina=
tor)
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
=20
+##
+# @TestTypeB:
+##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
=20
+##
+# @Base:
+##
 { 'struct': 'Base',
   'data': { 'string': 'str' } }
=20
+##
+# @TestUnion:
+##
 { 'union': 'TestUnion',
   'base': 'Base',
   'data': { 'value1': 'TestTypeA',
diff --git a/tests/qapi-schema/union-branch-case.err b/tests/qapi-schema/=
union-branch-case.err
index 11521901d8..9095bae565 100644
--- a/tests/qapi-schema/union-branch-case.err
+++ b/tests/qapi-schema/union-branch-case.err
@@ -1 +1 @@
-tests/qapi-schema/union-branch-case.json:2: 'Branch' (branch of NoWayThi=
sWillGetWhitelisted) should not use uppercase
+tests/qapi-schema/union-branch-case.json:6: 'Branch' (branch of NoWayThi=
sWillGetWhitelisted) should not use uppercase
diff --git a/tests/qapi-schema/union-branch-case.json b/tests/qapi-schema=
/union-branch-case.json
index e6565dc3b3..6de131548c 100644
--- a/tests/qapi-schema/union-branch-case.json
+++ b/tests/qapi-schema/union-branch-case.json
@@ -1,2 +1,6 @@
 # Branch names should be 'lower-case' unless the union is whitelisted
+
+##
+# @NoWayThisWillGetWhitelisted:
+##
 { 'union': 'NoWayThisWillGetWhitelisted', 'data': { 'Branch': 'int' } }
diff --git a/tests/qapi-schema/union-clash-branches.err b/tests/qapi-sche=
ma/union-clash-branches.err
index e5b21135bb..640caeab8c 100644
--- a/tests/qapi-schema/union-clash-branches.err
+++ b/tests/qapi-schema/union-clash-branches.err
@@ -1 +1 @@
-tests/qapi-schema/union-clash-branches.json:4: 'a_b' (branch of TestUnio=
n) collides with 'a-b' (branch of TestUnion)
+tests/qapi-schema/union-clash-branches.json:8: 'a_b' (branch of TestUnio=
n) collides with 'a-b' (branch of TestUnion)
diff --git a/tests/qapi-schema/union-clash-branches.json b/tests/qapi-sch=
ema/union-clash-branches.json
index 3bece8c948..6615665dfe 100644
--- a/tests/qapi-schema/union-clash-branches.json
+++ b/tests/qapi-schema/union-clash-branches.json
@@ -1,5 +1,9 @@
 # Union branch name collision
 # Reject a union that would result in a collision in generated C names (=
this
 # would try to generate two members 'a_b').
+
+##
+# @TestUnion:
+##
 { 'union': 'TestUnion',
   'data': { 'a-b': 'int', 'a_b': 'str' } }
diff --git a/tests/qapi-schema/union-empty.err b/tests/qapi-schema/union-=
empty.err
index 12c20221bd..749bc76fc5 100644
--- a/tests/qapi-schema/union-empty.err
+++ b/tests/qapi-schema/union-empty.err
@@ -1 +1 @@
-tests/qapi-schema/union-empty.json:2: Union 'Union' cannot have empty 'd=
ata'
+tests/qapi-schema/union-empty.json:6: Union 'Union' cannot have empty 'd=
ata'
diff --git a/tests/qapi-schema/union-empty.json b/tests/qapi-schema/union=
-empty.json
index 1f0b13ca21..c9b0a1ef33 100644
--- a/tests/qapi-schema/union-empty.json
+++ b/tests/qapi-schema/union-empty.json
@@ -1,2 +1,6 @@
 # unions cannot be empty
+
+##
+# @Union:
+##
 { 'union': 'Union', 'data': { } }
diff --git a/tests/qapi-schema/union-invalid-base.err b/tests/qapi-schema=
/union-invalid-base.err
index 03d7b97a93..41e238f453 100644
--- a/tests/qapi-schema/union-invalid-base.err
+++ b/tests/qapi-schema/union-invalid-base.err
@@ -1 +1 @@
-tests/qapi-schema/union-invalid-base.json:8: 'base' for union 'TestUnion=
' cannot use built-in type 'int'
+tests/qapi-schema/union-invalid-base.json:18: 'base' for union 'TestUnio=
n' cannot use built-in type 'int'
diff --git a/tests/qapi-schema/union-invalid-base.json b/tests/qapi-schem=
a/union-invalid-base.json
index 92be39df69..fd837cb80b 100644
--- a/tests/qapi-schema/union-invalid-base.json
+++ b/tests/qapi-schema/union-invalid-base.json
@@ -1,10 +1,20 @@
 # a union base type must be a struct
+
+##
+# @TestTypeA:
+##
 { 'struct': 'TestTypeA',
   'data': { 'string': 'str' } }
=20
+##
+# @TestTypeB:
+##
 { 'struct': 'TestTypeB',
   'data': { 'integer': 'int' } }
=20
+##
+# @TestUnion:
+##
 { 'union': 'TestUnion',
   'base': 'int',
   'discriminator': 'int',
diff --git a/tests/qapi-schema/union-optional-branch.err b/tests/qapi-sch=
ema/union-optional-branch.err
index 3ada1334dc..60523c07e4 100644
--- a/tests/qapi-schema/union-optional-branch.err
+++ b/tests/qapi-schema/union-optional-branch.err
@@ -1 +1 @@
-tests/qapi-schema/union-optional-branch.json:2: Member of union 'Union' =
does not allow optional name '*a'
+tests/qapi-schema/union-optional-branch.json:6: Member of union 'Union' =
does not allow optional name '*a'
diff --git a/tests/qapi-schema/union-optional-branch.json b/tests/qapi-sc=
hema/union-optional-branch.json
index 591615fc68..7d2ee4c730 100644
--- a/tests/qapi-schema/union-optional-branch.json
+++ b/tests/qapi-schema/union-optional-branch.json
@@ -1,2 +1,6 @@
 # union branches cannot be optional
+
+##
+# @Union:
+##
 { 'union': 'Union', 'data': { '*a': 'int', 'b': 'str' } }
diff --git a/tests/qapi-schema/union-unknown.err b/tests/qapi-schema/unio=
n-unknown.err
index 54fe456f9c..5568302205 100644
--- a/tests/qapi-schema/union-unknown.err
+++ b/tests/qapi-schema/union-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/union-unknown.json:2: Member 'unknown' of union 'Union=
' uses unknown type 'MissingType'
+tests/qapi-schema/union-unknown.json:6: Member 'unknown' of union 'Union=
' uses unknown type 'MissingType'
diff --git a/tests/qapi-schema/union-unknown.json b/tests/qapi-schema/uni=
on-unknown.json
index aa7e8143d8..5042b23197 100644
--- a/tests/qapi-schema/union-unknown.json
+++ b/tests/qapi-schema/union-unknown.json
@@ -1,3 +1,7 @@
 # we reject a union with unknown type in branch
+
+##
+# @Union:
+##
 { 'union': 'Union',
   'data': { 'unknown': 'MissingType' } }
diff --git a/tests/qapi-schema/unknown-escape.err b/tests/qapi-schema/unk=
nown-escape.err
index 000e30ddf3..1a4ead632b 100644
--- a/tests/qapi-schema/unknown-escape.err
+++ b/tests/qapi-schema/unknown-escape.err
@@ -1 +1 @@
-tests/qapi-schema/unknown-escape.json:3:21: Unknown escape \x
+tests/qapi-schema/unknown-escape.json:7:21: Unknown escape \x
diff --git a/tests/qapi-schema/unknown-escape.json b/tests/qapi-schema/un=
known-escape.json
index 8e6891e52a..e3ae6793f2 100644
--- a/tests/qapi-schema/unknown-escape.json
+++ b/tests/qapi-schema/unknown-escape.json
@@ -1,3 +1,7 @@
 # we only recognize JSON escape sequences, plus our \' extension (no \x)
+
+##
+# @foo:
+##
 # { 'command': 'foo', 'data': {} }
 { 'command': 'foo', 'dat\x61':{} }
diff --git a/tests/qapi-schema/unknown-expr-key.err b/tests/qapi-schema/u=
nknown-expr-key.err
index 12f5ed5b43..b19a668bd6 100644
--- a/tests/qapi-schema/unknown-expr-key.err
+++ b/tests/qapi-schema/unknown-expr-key.err
@@ -1 +1 @@
-tests/qapi-schema/unknown-expr-key.json:2: Unknown key 'bogus' in struct=
 'bar'
+tests/qapi-schema/unknown-expr-key.json:6: Unknown key 'bogus' in struct=
 'bar'
diff --git a/tests/qapi-schema/unknown-expr-key.json b/tests/qapi-schema/=
unknown-expr-key.json
index 3b2be00cc4..1b764c7b9d 100644
--- a/tests/qapi-schema/unknown-expr-key.json
+++ b/tests/qapi-schema/unknown-expr-key.json
@@ -1,2 +1,6 @@
 # we reject an expression with unknown top-level keys
+
+##
+# @bar:
+##
 { 'struct': 'bar', 'data': { 'string': 'str'}, 'bogus': { } }
--=20
2.11.0
