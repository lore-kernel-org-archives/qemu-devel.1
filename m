Received: from eggs.gnu.org ([2001:4830:134:3::10]:59542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS332-0003Ds-1y
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS32y-0006L8-2t
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cS32x-0006KL-Mr
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:39 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E53C77F7D4
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 14:41:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 15:41:14 +0100
Message-Id: <20170113144135.5150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 00/21] qapi doc generation (whole version,
 squashed)
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

Add a qapi2texi script to generate the documentation from the qapi
schemas.

The SQUASHED patch in this series is a squashed version of the
documentation move from qmp-commands.txt to the schemas. The whole
version (not sent on the ML to avoid spamming) is in the following git
branch: https://github.com/elmarco/qemu/commits/qapi-doc

PDF preview:
https://fedorapeople.org/~elmarco/qemu-qmp-ref.pdf (v7 without type info)

v8: after Markus review of v7
- error messages improvements
- python code style change (despite bad W503 pep8 warnings)
- build-sys GEN message fix
- doc improvements from Markus
- more TODOs

v7: after Markus review of v6
- removed type information, doc and syntax (post-poned)
- keep original documentation order (consequently,
  tests/qapi-schema/doc-bad-section.json is now accepted)
- removed "qapi: use a QAPIParseError in parser" patch
- removed "reorder documentation body" patch
- removed 'o' support for list items
- added several TODOs
- added a few preliminary patches for the new changes
- improved some error messages
- updated tests corresponding to the changes above
- added r-b tags

v6:
- rebased on top of armbru/qapi-next branch
- add a few patches to improve Exception subclasses and usage in
  qapi.py as suggested during review
- parser and generator fixes and improvements after v5 review:
  - various union improvements, hopefully with a better syntax
  - improve error messages
  - improve docs/qapi-code-gen.txt documentation section
  - do not allow interleaved body documentation between sections
  - more tests for new cases
  - make expression documentation mandatory, fix the tests
  - replace bad usage of @var{} with @t{} in texi, fix texi2pod to
    handle it
  - renaming, reordering etc..
- add docs/qapi-syntax.texi to describe the API syntax used in the
  texi documentation
- fix interleaved body and section documentation
- improve documentation sections name
- many build-sys improvements after review
- fix and improve commit messages, update R-b tags

v5:
- many parser and generator fixes and improvements after v4 review:
 - simplified current section handling by using a Section object
 - adding a line is more stateful: either freeform or symbol comment
 - always check_docs() when parsing with QAPISchema
 - simplified some code and comments
 - do not break current section on empty line, but break after a non
   indented paragraph in an argument section. This seems to reflects
   the way documentation is written:

   ##
   # @foo:
   # @arg: fluctuat nec mergitur
   #       - continues here
   #
   #       Since: 1853
   #
   # Body
   #
   ##

   Other sections (Note/Examples etc) are not indented (it seems), but
   could use a similar rule. I prefer to keep this only for args, for
   styling reasons (bikeshedding?).

- better handling of flat-union in generator
- list all enum values (even when not documented)
- added qapi-doc parsing tests and more error checking
- pep8/pylint fixes
- some more schema doc fixes
- do not move logo to docs/

v4:
- more device_add schema fixes
- do not merge docs/qmp-intro.txt in qemu-qmp-ref.texi
- remove needless @ifinfo, add GPL copying text
- added qemu logo to pdf
- added some r-b tags

v3:
- many improvements to the doc parser:
  - throws an error in various malformated conditions
  - allows multiple meta-sections, except for "Since:" and "Return:"
  - build a list of docs, instead of attaching docs to expressions
  - accept() breaks on new doc block, and get_doc() returns a QAPIDoc
- fix more documentation to fit the new parser
- use a master texi file that includes the generated file, instead of
  templated texi file
- texi fixes after Markus review
- only build and install html and man pages by default
- fix .gitignore

v2:
- change licence to be lgpl2+
- fix some comments & commit message
- add more code comments
- improve the doc parsing to treat only "Since" as a special case not
  requiring ":" (common notation in the doc)
- include some early schema doc fixes (to fix generated doc)
- include the squashed version of the doc move
- include the man page and installation build changes

Marc-Andr=C3=A9 Lureau (21):
  qapi: replace 'o' for list items
  qapi: move QKeyCode doc body at the top
  qapi: make TODOs named-sections
  qapi: improve device_add schema
  qapi: improve TransactionAction doc
  qga/schema: improve guest-set-vcpus Returns: section
  qapi: avoid interleaving sections and parameters
  qapi: move experimental note down
  qapi: add some sections in docs
  docs: add master qapi texi files
  qapi: rework qapi Exception
  qapi.py: fix line break before binary operator pep8
  texi2pod: learn quotation, deftp and deftypefn
  (SQUASHED) move doc to schema
  qapi: add qapi2texi script
  docs: add qemu logo to pdf
  build-sys: use --no-split for info
  build-sys: remove dvi doc generation
  build-sys: use a generic TEXI2MAN rule
  build-sys: add txt documentation rules
  build-sys: add qapi doc generation targets

 qapi-schema.json                                   | 1338 ++++++-
 qapi/block-core.json                               |  700 +++-
 qapi/block.json                                    |   66 +-
 qapi/common.json                                   |   38 +-
 qapi/crypto.json                                   |    5 +-
 qapi/event.json                                    |  248 +-
 qapi/introspect.json                               |    5 +-
 qapi/rocker.json                                   |   61 +-
 qapi/trace.json                                    |   17 +
 scripts/qapi.py                                    |  587 ++-
 scripts/qapi2texi.py                               |  271 ++
 .gitignore                                         |   11 +-
 Makefile                                           |   94 +-
 configure                                          |    2 +-
 docs/qapi-code-gen.txt                             |  180 +-
 docs/qemu-ga-ref.texi                              |   78 +
 docs/qemu-qmp-ref.texi                             |   78 +
 docs/qemu_logo.pdf                                 |  Bin 0 -> 9117 byte=
s
 docs/qmp-commands.txt                              | 3824 --------------=
------
 docs/qmp-events.txt                                |  731 ----
 docs/qmp-intro.txt                                 |    3 +-
 qga/qapi-schema.json                               |   11 +-
 rules.mak                                          |   12 +
 scripts/texi2pod.pl                                |   54 +-
 tests/Makefile.include                             |   20 +
 tests/qapi-schema/alternate-any.err                |    2 +-
 tests/qapi-schema/alternate-any.json               |    4 +
 tests/qapi-schema/alternate-array.err              |    2 +-
 tests/qapi-schema/alternate-array.json             |    7 +
 tests/qapi-schema/alternate-base.err               |    2 +-
 tests/qapi-schema/alternate-base.json              |    7 +
 tests/qapi-schema/alternate-clash.err              |    2 +-
 tests/qapi-schema/alternate-clash.json             |    4 +
 tests/qapi-schema/alternate-conflict-dict.err      |    2 +-
 tests/qapi-schema/alternate-conflict-dict.json     |   10 +
 tests/qapi-schema/alternate-conflict-string.err    |    2 +-
 tests/qapi-schema/alternate-conflict-string.json   |    7 +
 tests/qapi-schema/alternate-empty.err              |    2 +-
 tests/qapi-schema/alternate-empty.json             |    4 +
 tests/qapi-schema/alternate-nested.err             |    2 +-
 tests/qapi-schema/alternate-nested.json            |    7 +
 tests/qapi-schema/alternate-unknown.err            |    2 +-
 tests/qapi-schema/alternate-unknown.json           |    4 +
 tests/qapi-schema/args-alternate.err               |    2 +-
 tests/qapi-schema/args-alternate.json              |    8 +
 tests/qapi-schema/args-any.err                     |    2 +-
 tests/qapi-schema/args-any.json                    |    4 +
 tests/qapi-schema/args-array-empty.err             |    2 +-
 tests/qapi-schema/args-array-empty.json            |    4 +
 tests/qapi-schema/args-array-unknown.err           |    2 +-
 tests/qapi-schema/args-array-unknown.json          |    4 +
 tests/qapi-schema/args-bad-boxed.err               |    2 +-
 tests/qapi-schema/args-bad-boxed.json              |    4 +
 tests/qapi-schema/args-boxed-anon.err              |    2 +-
 tests/qapi-schema/args-boxed-anon.json             |    4 +
 tests/qapi-schema/args-boxed-empty.err             |    2 +-
 tests/qapi-schema/args-boxed-empty.json            |    8 +
 tests/qapi-schema/args-boxed-string.err            |    2 +-
 tests/qapi-schema/args-boxed-string.json           |    4 +
 tests/qapi-schema/args-int.err                     |    2 +-
 tests/qapi-schema/args-int.json                    |    4 +
 tests/qapi-schema/args-invalid.err                 |    2 +-
 tests/qapi-schema/args-invalid.json                |    3 +
 tests/qapi-schema/args-member-array-bad.err        |    2 +-
 tests/qapi-schema/args-member-array-bad.json       |    4 +
 tests/qapi-schema/args-member-case.err             |    2 +-
 tests/qapi-schema/args-member-case.json            |    4 +
 tests/qapi-schema/args-member-unknown.err          |    2 +-
 tests/qapi-schema/args-member-unknown.json         |    4 +
 tests/qapi-schema/args-name-clash.err              |    2 +-
 tests/qapi-schema/args-name-clash.json             |    4 +
 tests/qapi-schema/args-union.err                   |    2 +-
 tests/qapi-schema/args-union.json                  |    7 +
 tests/qapi-schema/args-unknown.err                 |    2 +-
 tests/qapi-schema/args-unknown.json                |    4 +
 tests/qapi-schema/bad-base.err                     |    2 +-
 tests/qapi-schema/bad-base.json                    |    7 +
 tests/qapi-schema/bad-data.err                     |    2 +-
 tests/qapi-schema/bad-data.json                    |    4 +
 tests/qapi-schema/bad-ident.err                    |    2 +-
 tests/qapi-schema/bad-ident.json                   |    4 +
 tests/qapi-schema/bad-type-bool.err                |    2 +-
 tests/qapi-schema/bad-type-bool.json               |    4 +
 tests/qapi-schema/bad-type-dict.err                |    2 +-
 tests/qapi-schema/bad-type-dict.json               |    4 +
 tests/qapi-schema/base-cycle-direct.err            |    2 +-
 tests/qapi-schema/base-cycle-direct.json           |    4 +
 tests/qapi-schema/base-cycle-indirect.err          |    2 +-
 tests/qapi-schema/base-cycle-indirect.json         |    7 +
 tests/qapi-schema/command-int.err                  |    2 +-
 tests/qapi-schema/command-int.json                 |    4 +
 tests/qapi-schema/comments.json                    |    4 +
 tests/qapi-schema/comments.out                     |    3 +
 tests/qapi-schema/doc-bad-args.err                 |    1 +
 tests/qapi-schema/doc-bad-args.exit                |    1 +
 tests/qapi-schema/doc-bad-args.json                |    8 +
 tests/qapi-schema/doc-bad-args.out                 |    0
 tests/qapi-schema/doc-bad-symbol.err               |    1 +
 tests/qapi-schema/doc-bad-symbol.exit              |    1 +
 tests/qapi-schema/doc-bad-symbol.json              |    6 +
 tests/qapi-schema/doc-bad-symbol.out               |    0
 tests/qapi-schema/doc-duplicated-arg.err           |    1 +
 tests/qapi-schema/doc-duplicated-arg.exit          |    1 +
 tests/qapi-schema/doc-duplicated-arg.json          |    7 +
 tests/qapi-schema/doc-duplicated-arg.out           |    0
 tests/qapi-schema/doc-duplicated-return.err        |    1 +
 tests/qapi-schema/doc-duplicated-return.exit       |    1 +
 tests/qapi-schema/doc-duplicated-return.json       |    8 +
 tests/qapi-schema/doc-duplicated-return.out        |    0
 tests/qapi-schema/doc-duplicated-since.err         |    1 +
 tests/qapi-schema/doc-duplicated-since.exit        |    1 +
 tests/qapi-schema/doc-duplicated-since.json        |    8 +
 tests/qapi-schema/doc-duplicated-since.out         |    0
 tests/qapi-schema/doc-empty-arg.err                |    1 +
 tests/qapi-schema/doc-empty-arg.exit               |    1 +
 tests/qapi-schema/doc-empty-arg.json               |    6 +
 tests/qapi-schema/doc-empty-arg.out                |    0
 tests/qapi-schema/doc-empty-section.err            |    1 +
 tests/qapi-schema/doc-empty-section.exit           |    1 +
 tests/qapi-schema/doc-empty-section.json           |    8 +
 tests/qapi-schema/doc-empty-section.out            |    0
 tests/qapi-schema/doc-empty-symbol.err             |    1 +
 tests/qapi-schema/doc-empty-symbol.exit            |    1 +
 tests/qapi-schema/doc-empty-symbol.json            |    5 +
 tests/qapi-schema/doc-empty-symbol.out             |    0
 tests/qapi-schema/doc-interleaved-section.err      |    1 +
 tests/qapi-schema/doc-interleaved-section.exit     |    1 +
 tests/qapi-schema/doc-interleaved-section.json     |   21 +
 tests/qapi-schema/doc-interleaved-section.out      |    0
 tests/qapi-schema/doc-invalid-end.err              |    1 +
 tests/qapi-schema/doc-invalid-end.exit             |    1 +
 tests/qapi-schema/doc-invalid-end.json             |    5 +
 tests/qapi-schema/doc-invalid-end.out              |    0
 tests/qapi-schema/doc-invalid-end2.err             |    1 +
 tests/qapi-schema/doc-invalid-end2.exit            |    1 +
 tests/qapi-schema/doc-invalid-end2.json            |    5 +
 tests/qapi-schema/doc-invalid-end2.out             |    0
 tests/qapi-schema/doc-invalid-return.err           |    1 +
 tests/qapi-schema/doc-invalid-return.exit          |    1 +
 tests/qapi-schema/doc-invalid-return.json          |    7 +
 tests/qapi-schema/doc-invalid-return.out           |    0
 tests/qapi-schema/doc-invalid-section.err          |    1 +
 tests/qapi-schema/doc-invalid-section.exit         |    1 +
 tests/qapi-schema/doc-invalid-section.json         |    6 +
 tests/qapi-schema/doc-invalid-section.out          |    0
 tests/qapi-schema/doc-invalid-start.err            |    1 +
 tests/qapi-schema/doc-invalid-start.exit           |    1 +
 tests/qapi-schema/doc-invalid-start.json           |    5 +
 tests/qapi-schema/doc-invalid-start.out            |    0
 tests/qapi-schema/doc-missing-colon.err            |    1 +
 tests/qapi-schema/doc-missing-colon.exit           |    1 +
 tests/qapi-schema/doc-missing-colon.json           |    5 +
 tests/qapi-schema/doc-missing-colon.out            |    0
 tests/qapi-schema/doc-missing-expr.err             |    1 +
 tests/qapi-schema/doc-missing-expr.exit            |    1 +
 tests/qapi-schema/doc-missing-expr.json            |    5 +
 tests/qapi-schema/doc-missing-expr.out             |    0
 tests/qapi-schema/doc-missing-space.err            |    1 +
 tests/qapi-schema/doc-missing-space.exit           |    1 +
 tests/qapi-schema/doc-missing-space.json           |    6 +
 tests/qapi-schema/doc-missing-space.out            |    0
 tests/qapi-schema/doc-optional.err                 |    1 +
 tests/qapi-schema/doc-optional.exit                |    1 +
 tests/qapi-schema/doc-optional.json                |    7 +
 tests/qapi-schema/doc-optional.out                 |    0
 tests/qapi-schema/double-type.err                  |    2 +-
 tests/qapi-schema/double-type.json                 |    4 +
 tests/qapi-schema/enum-bad-name.err                |    2 +-
 tests/qapi-schema/enum-bad-name.json               |    4 +
 tests/qapi-schema/enum-bad-prefix.err              |    2 +-
 tests/qapi-schema/enum-bad-prefix.json             |    4 +
 tests/qapi-schema/enum-clash-member.err            |    2 +-
 tests/qapi-schema/enum-clash-member.json           |    4 +
 tests/qapi-schema/enum-dict-member.err             |    2 +-
 tests/qapi-schema/enum-dict-member.json            |    4 +
 tests/qapi-schema/enum-member-case.err             |    2 +-
 tests/qapi-schema/enum-member-case.json            |    7 +
 tests/qapi-schema/enum-missing-data.err            |    2 +-
 tests/qapi-schema/enum-missing-data.json           |    4 +
 tests/qapi-schema/enum-wrong-data.err              |    2 +-
 tests/qapi-schema/enum-wrong-data.json             |    4 +
 tests/qapi-schema/event-boxed-empty.err            |    2 +-
 tests/qapi-schema/event-boxed-empty.json           |    4 +
 tests/qapi-schema/event-case.json                  |    4 +
 tests/qapi-schema/event-case.out                   |    3 +
 tests/qapi-schema/event-nest-struct.err            |    2 +-
 tests/qapi-schema/event-nest-struct.json           |    4 +
 tests/qapi-schema/flat-union-array-branch.err      |    2 +-
 tests/qapi-schema/flat-union-array-branch.json     |   12 +
 tests/qapi-schema/flat-union-bad-base.err          |    2 +-
 tests/qapi-schema/flat-union-bad-base.json         |   13 +
 tests/qapi-schema/flat-union-bad-discriminator.err |    2 +-
 .../qapi-schema/flat-union-bad-discriminator.json  |   16 +
 tests/qapi-schema/flat-union-base-any.err          |    2 +-
 tests/qapi-schema/flat-union-base-any.json         |   13 +
 tests/qapi-schema/flat-union-base-union.err        |    2 +-
 tests/qapi-schema/flat-union-base-union.json       |   16 +
 tests/qapi-schema/flat-union-clash-member.err      |    2 +-
 tests/qapi-schema/flat-union-clash-member.json     |   16 +
 tests/qapi-schema/flat-union-empty.err             |    2 +-
 tests/qapi-schema/flat-union-empty.json            |   10 +
 tests/qapi-schema/flat-union-incomplete-branch.err |    2 +-
 .../qapi-schema/flat-union-incomplete-branch.json  |   10 +
 tests/qapi-schema/flat-union-inline.err            |    2 +-
 tests/qapi-schema/flat-union-inline.json           |   10 +
 tests/qapi-schema/flat-union-int-branch.err        |    2 +-
 tests/qapi-schema/flat-union-int-branch.json       |   13 +
 .../qapi-schema/flat-union-invalid-branch-key.err  |    2 +-
 .../qapi-schema/flat-union-invalid-branch-key.json |   15 +
 .../flat-union-invalid-discriminator.err           |    2 +-
 .../flat-union-invalid-discriminator.json          |   15 +
 tests/qapi-schema/flat-union-no-base.err           |    2 +-
 tests/qapi-schema/flat-union-no-base.json          |   13 +
 .../flat-union-optional-discriminator.err          |    2 +-
 .../flat-union-optional-discriminator.json         |   13 +
 .../flat-union-string-discriminator.err            |    2 +-
 .../flat-union-string-discriminator.json           |   15 +
 tests/qapi-schema/ident-with-escape.json           |    4 +
 tests/qapi-schema/ident-with-escape.out            |    3 +
 tests/qapi-schema/include-relpath-sub.json         |    3 +
 tests/qapi-schema/include-relpath.out              |    3 +
 tests/qapi-schema/include-repetition.out           |    3 +
 tests/qapi-schema/include-simple-sub.json          |    3 +
 tests/qapi-schema/include-simple.out               |    3 +
 tests/qapi-schema/indented-expr.json               |    6 +
 tests/qapi-schema/indented-expr.out                |    6 +
 tests/qapi-schema/missing-type.err                 |    2 +-
 tests/qapi-schema/missing-type.json                |    4 +
 tests/qapi-schema/nested-struct-data.err           |    2 +-
 tests/qapi-schema/nested-struct-data.json          |    4 +
 tests/qapi-schema/qapi-schema-test.json            |  213 ++
 tests/qapi-schema/qapi-schema-test.out             |  212 ++
 tests/qapi-schema/redefined-builtin.err            |    2 +-
 tests/qapi-schema/redefined-builtin.json           |    4 +
 tests/qapi-schema/redefined-command.err            |    2 +-
 tests/qapi-schema/redefined-command.json           |    7 +
 tests/qapi-schema/redefined-event.err              |    2 +-
 tests/qapi-schema/redefined-event.json             |    7 +
 tests/qapi-schema/redefined-type.err               |    2 +-
 tests/qapi-schema/redefined-type.json              |    7 +
 tests/qapi-schema/reserved-command-q.err           |    2 +-
 tests/qapi-schema/reserved-command-q.json          |    7 +
 tests/qapi-schema/reserved-enum-q.err              |    2 +-
 tests/qapi-schema/reserved-enum-q.json             |    4 +
 tests/qapi-schema/reserved-member-has.err          |    2 +-
 tests/qapi-schema/reserved-member-has.json         |    4 +
 tests/qapi-schema/reserved-member-q.err            |    2 +-
 tests/qapi-schema/reserved-member-q.json           |    4 +
 tests/qapi-schema/reserved-member-u.err            |    2 +-
 tests/qapi-schema/reserved-member-u.json           |    4 +
 tests/qapi-schema/reserved-member-underscore.err   |    2 +-
 tests/qapi-schema/reserved-member-underscore.json  |    4 +
 tests/qapi-schema/reserved-type-kind.err           |    2 +-
 tests/qapi-schema/reserved-type-kind.json          |    4 +
 tests/qapi-schema/reserved-type-list.err           |    2 +-
 tests/qapi-schema/reserved-type-list.json          |    4 +
 tests/qapi-schema/returns-alternate.err            |    2 +-
 tests/qapi-schema/returns-alternate.json           |    7 +
 tests/qapi-schema/returns-array-bad.err            |    2 +-
 tests/qapi-schema/returns-array-bad.json           |    4 +
 tests/qapi-schema/returns-dict.err                 |    2 +-
 tests/qapi-schema/returns-dict.json                |    4 +
 tests/qapi-schema/returns-unknown.err              |    2 +-
 tests/qapi-schema/returns-unknown.json             |    4 +
 tests/qapi-schema/returns-whitelist.err            |    2 +-
 tests/qapi-schema/returns-whitelist.json           |   16 +
 tests/qapi-schema/struct-base-clash-deep.err       |    2 +-
 tests/qapi-schema/struct-base-clash-deep.json      |   10 +
 tests/qapi-schema/struct-base-clash.err            |    2 +-
 tests/qapi-schema/struct-base-clash.json           |    7 +
 tests/qapi-schema/struct-data-invalid.err          |    2 +-
 tests/qapi-schema/struct-data-invalid.json         |    3 +
 tests/qapi-schema/struct-member-invalid.err        |    2 +-
 tests/qapi-schema/struct-member-invalid.json       |    3 +
 tests/qapi-schema/test-qapi.py                     |   12 +
 tests/qapi-schema/type-bypass-bad-gen.err          |    2 +-
 tests/qapi-schema/type-bypass-bad-gen.json         |    4 +
 tests/qapi-schema/unicode-str.err                  |    2 +-
 tests/qapi-schema/unicode-str.json                 |    4 +
 tests/qapi-schema/union-base-no-discriminator.err  |    2 +-
 tests/qapi-schema/union-base-no-discriminator.json |   12 +
 tests/qapi-schema/union-branch-case.err            |    2 +-
 tests/qapi-schema/union-branch-case.json           |    4 +
 tests/qapi-schema/union-clash-branches.err         |    2 +-
 tests/qapi-schema/union-clash-branches.json        |    4 +
 tests/qapi-schema/union-empty.err                  |    2 +-
 tests/qapi-schema/union-empty.json                 |    4 +
 tests/qapi-schema/union-invalid-base.err           |    2 +-
 tests/qapi-schema/union-invalid-base.json          |   10 +
 tests/qapi-schema/union-optional-branch.err        |    2 +-
 tests/qapi-schema/union-optional-branch.json       |    4 +
 tests/qapi-schema/union-unknown.err                |    2 +-
 tests/qapi-schema/union-unknown.json               |    4 +
 tests/qapi-schema/unknown-escape.err               |    2 +-
 tests/qapi-schema/unknown-escape.json              |    4 +
 tests/qapi-schema/unknown-expr-key.err             |    2 +-
 tests/qapi-schema/unknown-expr-key.json            |    4 +
 297 files changed, 4847 insertions(+), 5013 deletions(-)
 create mode 100755 scripts/qapi2texi.py
 create mode 100644 docs/qemu-ga-ref.texi
 create mode 100644 docs/qemu-qmp-ref.texi
 create mode 100644 docs/qemu_logo.pdf
 delete mode 100644 docs/qmp-commands.txt
 delete mode 100644 docs/qmp-events.txt
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

--=20
2.11.0
