Received: from eggs.gnu.org ([2001:4830:134:3::10]:46666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXQF9-0008FZ-MF
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXQF7-0004Bb-VF
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:37:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXQF7-00047S-Js
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:37:29 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F28A630034BB
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 12:37:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 16:37:02 +0400
Message-Id: <20181213123724.4866-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 00/22] qapi: add #if pre-processor
 conditions to generated code (part 2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is the second part of the "add #if pre-processor conditions to
generated code" series, adding schema member conditions (roughly
16-38/49).

Members can be exploded as dictionnary with 'type'/'if' keys:

{ 'struct': 'TestIfStruct', 'data':
  { 'foo': 'int',
    'bar': { 'type': 'int', 'if': 'defined(TEST_IF_STRUCT_BAR)'} } }

Enum values can be exploded as dictionnary with 'type'/'if' keys:

{ 'enum': 'TestIfEnum', 'data':
  [ 'foo',
    { 'name' : 'bar', 'if': 'defined(TEST_IF_ENUM_BAR)' } ] }

Based-on: git://repo.or.cz/qemu/armbru.git qapi-next

v8:
- rebased on Markus qapi-next branch
- based on code changes from Markus in his qapi-next-2 branch (code
  changes, commits squashed & reordered)
- minor code cleanup / style fixes
- commit messages update & rb tags

v7:
- replaced osdep.h include by a #warning check
- renamed event_names/event_enum_members, enum_name/event_enum_ename
- move normalization after checking
- simplify make_enum_members()
- some tests changes
- rebase/conflicts tweaks
- squash documentation changes in related patches
- tweak generated documentation code & output
- modify commit comments, add rb tags

v6:
- subset of v5 series: add schema member conditions
- split "qapi: factor out check_known_keys()", error report improvements
- add a patch to "qapi: include osdep.h in type headers" to avoid
  potential build configuration change issues
- rebased, on top of Markus's qapi-next branch (first 4 patches,
  included for patchew testing)

Marc-Andr=C3=A9 Lureau (22):
  qapi: Do not define enumeration value explicitly
  qapi: change enum visitor and gen_enum* to take QAPISchemaMember
  tests: print enum type members more like object type members
  qapi: factor out checking for keys
  qapi: improve reporting of unknown or missing keys
  qapi: add a dictionary form with 'name' key for enum members
  qapi: pass long form enum to make_enum_members
  qapi: simplify make_enum_members()
  qapi: add 'if' to enum members
  qapi-events: add 'if' condition to implicit event enum
  qapi: rename allow_dict to allow_implicit
  qapi: add a dictionary form for TYPE
  qapi: add 'if' to implicit struct members
  qapi: add an error in case a discriminator is conditional
  qapi: add 'if' to union members
  qapi: add 'if' to alternate members
  qapi: add #if conditions to generated code members
  qapi: add 'If:' condition to enum values documentation
  qapi: add 'If:' condition to struct members documentation
  qapi: add condition to variants documentation
  qapi: add more conditions to SPICE
  qapi: add conditions to REPLICATION type/commands on the schema

 qapi/block-core.json                          |  13 +-
 qapi/char.json                                |  16 +-
 qapi/migration.json                           |  12 +-
 scripts/qapi/common.py                        | 201 +++++++++++-------
 scripts/qapi/doc.py                           |  31 +--
 scripts/qapi/events.py                        |  13 +-
 scripts/qapi/introspect.py                    |  17 +-
 scripts/qapi/types.py                         |  10 +-
 scripts/qapi/visit.py                         |   8 +-
 migration/colo.c                              |  16 +-
 monitor.c                                     |   5 -
 docs/devel/qapi-code-gen.txt                  |  19 ++
 tests/Makefile.include                        |  11 +-
 tests/qapi-schema/alternate-base.err          |   1 +
 tests/qapi-schema/alternate-invalid-dict.err  |   1 +
 ...ember.exit =3D> alternate-invalid-dict.exit} |   0
 tests/qapi-schema/alternate-invalid-dict.json |   4 +
 ...-member.out =3D> alternate-invalid-dict.out} |   0
 tests/qapi-schema/comments.out                |  14 +-
 tests/qapi-schema/doc-bad-section.out         |  13 +-
 tests/qapi-schema/doc-good.json               |  11 +-
 tests/qapi-schema/doc-good.out                |  22 +-
 tests/qapi-schema/doc-good.texi               |   7 +-
 tests/qapi-schema/double-type.err             |   1 +
 tests/qapi-schema/empty.out                   |   9 +-
 tests/qapi-schema/enum-bad-member.err         |   1 +
 tests/qapi-schema/enum-bad-member.exit        |   1 +
 tests/qapi-schema/enum-bad-member.json        |   2 +
 tests/qapi-schema/enum-bad-member.out         |   0
 .../qapi-schema/enum-dict-member-unknown.err  |   2 +
 .../qapi-schema/enum-dict-member-unknown.exit |   1 +
 .../qapi-schema/enum-dict-member-unknown.json |   2 +
 .../qapi-schema/enum-dict-member-unknown.out  |   0
 tests/qapi-schema/enum-dict-member.err        |   1 -
 tests/qapi-schema/enum-dict-member.json       |   2 -
 tests/qapi-schema/enum-if-invalid.err         |   1 +
 tests/qapi-schema/enum-if-invalid.exit        |   1 +
 tests/qapi-schema/enum-if-invalid.json        |   3 +
 tests/qapi-schema/enum-if-invalid.out         |   0
 tests/qapi-schema/event-case.out              |   9 +-
 .../qapi-schema/event-member-invalid-dict.err |   1 +
 .../event-member-invalid-dict.exit            |   1 +
 .../event-member-invalid-dict.json            |   2 +
 .../qapi-schema/event-member-invalid-dict.out |   0
 tests/qapi-schema/event-nest-struct.json      |   2 +-
 .../flat-union-inline-invalid-dict.err        |   1 +
 .../flat-union-inline-invalid-dict.exit       |   1 +
 .../flat-union-inline-invalid-dict.json       |  11 +
 .../flat-union-inline-invalid-dict.out        |   0
 tests/qapi-schema/flat-union-inline.json      |   2 +-
 .../flat-union-invalid-if-discriminator.err   |   1 +
 .../flat-union-invalid-if-discriminator.exit  |   1 +
 .../flat-union-invalid-if-discriminator.json  |  17 ++
 .../flat-union-invalid-if-discriminator.out   |   0
 tests/qapi-schema/ident-with-escape.out       |   9 +-
 tests/qapi-schema/include-relpath.out         |  14 +-
 tests/qapi-schema/include-repetition.out      |  14 +-
 tests/qapi-schema/include-simple.out          |  14 +-
 tests/qapi-schema/indented-expr.out           |   9 +-
 .../nested-struct-data-invalid-dict.err       |   1 +
 .../nested-struct-data-invalid-dict.exit      |   1 +
 .../nested-struct-data-invalid-dict.json      |   3 +
 .../nested-struct-data-invalid-dict.out       |   0
 tests/qapi-schema/nested-struct-data.json     |   2 +-
 tests/qapi-schema/qapi-schema-test.json       |  33 ++-
 tests/qapi-schema/qapi-schema-test.out        |  62 +++++-
 .../struct-member-invalid-dict.err            |   1 +
 .../struct-member-invalid-dict.exit           |   1 +
 .../struct-member-invalid-dict.json           |   3 +
 .../struct-member-invalid-dict.out            |   0
 tests/qapi-schema/test-qapi.py                |   9 +-
 .../qapi-schema/union-branch-invalid-dict.err |   1 +
 .../union-branch-invalid-dict.exit            |   1 +
 .../union-branch-invalid-dict.json            |   4 +
 .../qapi-schema/union-branch-invalid-dict.out |   0
 tests/qapi-schema/unknown-expr-key.err        |   3 +-
 tests/qapi-schema/unknown-expr-key.json       |   2 +-
 77 files changed, 522 insertions(+), 186 deletions(-)
 create mode 100644 tests/qapi-schema/alternate-invalid-dict.err
 rename tests/qapi-schema/{enum-dict-member.exit =3D> alternate-invalid-d=
ict.exit} (100%)
 create mode 100644 tests/qapi-schema/alternate-invalid-dict.json
 rename tests/qapi-schema/{enum-dict-member.out =3D> alternate-invalid-di=
ct.out} (100%)
 create mode 100644 tests/qapi-schema/enum-bad-member.err
 create mode 100644 tests/qapi-schema/enum-bad-member.exit
 create mode 100644 tests/qapi-schema/enum-bad-member.json
 create mode 100644 tests/qapi-schema/enum-bad-member.out
 create mode 100644 tests/qapi-schema/enum-dict-member-unknown.err
 create mode 100644 tests/qapi-schema/enum-dict-member-unknown.exit
 create mode 100644 tests/qapi-schema/enum-dict-member-unknown.json
 create mode 100644 tests/qapi-schema/enum-dict-member-unknown.out
 delete mode 100644 tests/qapi-schema/enum-dict-member.err
 delete mode 100644 tests/qapi-schema/enum-dict-member.json
 create mode 100644 tests/qapi-schema/enum-if-invalid.err
 create mode 100644 tests/qapi-schema/enum-if-invalid.exit
 create mode 100644 tests/qapi-schema/enum-if-invalid.json
 create mode 100644 tests/qapi-schema/enum-if-invalid.out
 create mode 100644 tests/qapi-schema/event-member-invalid-dict.err
 create mode 100644 tests/qapi-schema/event-member-invalid-dict.exit
 create mode 100644 tests/qapi-schema/event-member-invalid-dict.json
 create mode 100644 tests/qapi-schema/event-member-invalid-dict.out
 create mode 100644 tests/qapi-schema/flat-union-inline-invalid-dict.err
 create mode 100644 tests/qapi-schema/flat-union-inline-invalid-dict.exit
 create mode 100644 tests/qapi-schema/flat-union-inline-invalid-dict.json
 create mode 100644 tests/qapi-schema/flat-union-inline-invalid-dict.out
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.err
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.exit
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.json
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.out
 create mode 100644 tests/qapi-schema/nested-struct-data-invalid-dict.err
 create mode 100644 tests/qapi-schema/nested-struct-data-invalid-dict.exi=
t
 create mode 100644 tests/qapi-schema/nested-struct-data-invalid-dict.jso=
n
 create mode 100644 tests/qapi-schema/nested-struct-data-invalid-dict.out
 create mode 100644 tests/qapi-schema/struct-member-invalid-dict.err
 create mode 100644 tests/qapi-schema/struct-member-invalid-dict.exit
 create mode 100644 tests/qapi-schema/struct-member-invalid-dict.json
 create mode 100644 tests/qapi-schema/struct-member-invalid-dict.out
 create mode 100644 tests/qapi-schema/union-branch-invalid-dict.err
 create mode 100644 tests/qapi-schema/union-branch-invalid-dict.exit
 create mode 100644 tests/qapi-schema/union-branch-invalid-dict.json
 create mode 100644 tests/qapi-schema/union-branch-invalid-dict.out

--=20
2.20.0
