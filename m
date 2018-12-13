Received: from eggs.gnu.org ([2001:4830:134:3::10]:53091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxi-0005c9-8W
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxa-0001Sy-O3
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:43:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXVxY-00017O-0d
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:43:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3101BC7913
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 18:43:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-56.ams2.redhat.com
	[10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CA9CE600C0
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 18:43:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Dec 2018 19:43:08 +0100
Message-Id: <20181213184340.24037-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/32] QAPI patches for 2018-12-13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit c3ec0fa1a8e815ecfec9eabb9c20ee206c313e=
07:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2018-12-=
12' into staging (2018-12-13 13:41:44 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2018-12-13

for you to fetch changes up to badfa07f5fc309936e22aabd5a51a0203de78cb4:

  qapi: add conditions to REPLICATION type/commands on the schema (2018-1=
2-13 19:20:11 +0100)

----------------------------------------------------------------
QAPI patches for 2018-12-13

* Rewrite the ugly parts of string-input-visitor
* Support conditional QAPI enum, struct, union and alternate members

----------------------------------------------------------------
David Hildenbrand (9):
      cutils: Add qemu_strtod() and qemu_strtod_finite()
      cutils: Fix qemu_strtosz() & friends to reject non-finite sizes
      qapi: Fix string-input-visitor to reject NaN and infinities
      qapi: Use qemu_strtod_finite() in qobject-input-visitor
      test-string-input-visitor: Add more tests
      qapi: Rewrite string-input-visitor's integer and list parsing
      test-string-input-visitor: Use virtual walk
      test-string-input-visitor: Split off uint64 list tests
      test-string-input-visitor: Add range overflow tests

Eric Blake (1):
      docs: Update references to JSON RFC

Marc-Andr=C3=A9 Lureau (21):
      tests/qapi: Cover commands with 'if' and union / alternate 'data'
      qapi: rename QAPISchemaEnumType.values to .members
      qapi: break long lines at 'data' member
      qapi: Do not define enumeration value explicitly
      qapi: change enum visitor and gen_enum* to take QAPISchemaMember
      tests: print enum type members more like object type members
      qapi: factor out checking for keys
      qapi: improve reporting of unknown or missing keys
      qapi: add a dictionary form with 'name' key for enum members
      qapi: add 'if' to enum members
      qapi-events: add 'if' condition to implicit event enum
      qapi: add a dictionary form for TYPE
      qapi: Add 'if' to implicit struct members
      qapi: add 'if' to union members
      qapi: add 'if' to alternate members
      qapi: add #if conditions to generated code members
      qapi: add 'If:' condition to enum values documentation
      qapi: add 'If:' condition to struct members documentation
      qapi: add condition to variants documentation
      qapi: add more conditions to SPICE
      qapi: add conditions to REPLICATION type/commands on the schema

Markus Armbruster (1):
      json: Fix to reject duplicate object member names

 docs/devel/qapi-code-gen.txt                       |  21 +-
 docs/interop/qmp-spec.txt                          |   2 +-
 include/qapi/string-input-visitor.h                |   4 +-
 include/qemu/cutils.h                              |   8 +-
 migration/colo.c                                   |  16 +-
 monitor.c                                          |   7 +-
 qapi/block-core.json                               |  26 +-
 qapi/char.json                                     | 150 ++++----
 qapi/migration.json                                |  15 +-
 qapi/misc.json                                     |   7 +-
 qapi/net.json                                      |   3 +-
 qapi/qobject-input-visitor.c                       |   9 +-
 qapi/string-input-visitor.c                        | 407 ++++++++++++---=
------
 qapi/tpm.json                                      |   5 +-
 qapi/ui.json                                       |   3 +-
 qobject/json-parser.c                              |   5 +
 scripts/qapi/common.py                             | 207 +++++++----
 scripts/qapi/doc.py                                |  31 +-
 scripts/qapi/events.py                             |  13 +-
 scripts/qapi/introspect.py                         |  17 +-
 scripts/qapi/types.py                              |  10 +-
 scripts/qapi/visit.py                              |   8 +-
 tests/Makefile.include                             |  11 +-
 tests/qapi-schema/alternate-base.err               |   1 +
 tests/qapi-schema/alternate-invalid-dict.err       |   1 +
 ...ict-member.exit =3D> alternate-invalid-dict.exit} |   0
 tests/qapi-schema/alternate-invalid-dict.json      |   4 +
 ...-dict-member.out =3D> alternate-invalid-dict.out} |   0
 tests/qapi-schema/comments.out                     |  14 +-
 tests/qapi-schema/doc-bad-section.out              |  13 +-
 tests/qapi-schema/doc-good.json                    |  11 +-
 tests/qapi-schema/doc-good.out                     |  22 +-
 tests/qapi-schema/doc-good.texi                    |   7 +-
 tests/qapi-schema/double-type.err                  |   1 +
 tests/qapi-schema/empty.out                        |   9 +-
 tests/qapi-schema/enum-bad-member.err              |   1 +
 tests/qapi-schema/enum-bad-member.exit             |   1 +
 tests/qapi-schema/enum-bad-member.json             |   2 +
 tests/qapi-schema/enum-bad-member.out              |   0
 tests/qapi-schema/enum-dict-member-unknown.err     |   2 +
 tests/qapi-schema/enum-dict-member-unknown.exit    |   1 +
 tests/qapi-schema/enum-dict-member-unknown.json    |   2 +
 tests/qapi-schema/enum-dict-member-unknown.out     |   0
 tests/qapi-schema/enum-dict-member.err             |   1 -
 tests/qapi-schema/enum-dict-member.json            |   2 -
 tests/qapi-schema/enum-if-invalid.err              |   1 +
 tests/qapi-schema/enum-if-invalid.exit             |   1 +
 tests/qapi-schema/enum-if-invalid.json             |   3 +
 tests/qapi-schema/enum-if-invalid.out              |   0
 tests/qapi-schema/event-case.out                   |   9 +-
 tests/qapi-schema/event-member-invalid-dict.err    |   1 +
 tests/qapi-schema/event-member-invalid-dict.exit   |   1 +
 tests/qapi-schema/event-member-invalid-dict.json   |   2 +
 tests/qapi-schema/event-member-invalid-dict.out    |   0
 tests/qapi-schema/event-nest-struct.json           |   2 +-
 .../qapi-schema/flat-union-inline-invalid-dict.err |   1 +
 .../flat-union-inline-invalid-dict.exit            |   1 +
 .../flat-union-inline-invalid-dict.json            |  11 +
 .../qapi-schema/flat-union-inline-invalid-dict.out |   0
 tests/qapi-schema/flat-union-inline.json           |   2 +-
 .../flat-union-invalid-if-discriminator.err        |   1 +
 .../flat-union-invalid-if-discriminator.exit       |   1 +
 .../flat-union-invalid-if-discriminator.json       |  17 +
 .../flat-union-invalid-if-discriminator.out        |   0
 tests/qapi-schema/ident-with-escape.out            |   9 +-
 tests/qapi-schema/include-relpath.out              |  14 +-
 tests/qapi-schema/include-repetition.out           |  14 +-
 tests/qapi-schema/include-simple.out               |  14 +-
 tests/qapi-schema/indented-expr.out                |   9 +-
 .../nested-struct-data-invalid-dict.err            |   1 +
 .../nested-struct-data-invalid-dict.exit           |   1 +
 .../nested-struct-data-invalid-dict.json           |   3 +
 .../nested-struct-data-invalid-dict.out            |   0
 tests/qapi-schema/nested-struct-data.json          |   2 +-
 tests/qapi-schema/qapi-schema-test.json            |  39 +-
 tests/qapi-schema/qapi-schema-test.out             |  74 +++-
 tests/qapi-schema/struct-member-invalid-dict.err   |   1 +
 tests/qapi-schema/struct-member-invalid-dict.exit  |   1 +
 tests/qapi-schema/struct-member-invalid-dict.json  |   3 +
 tests/qapi-schema/struct-member-invalid-dict.out   |   0
 tests/qapi-schema/test-qapi.py                     |   9 +-
 tests/qapi-schema/union-branch-invalid-dict.err    |   1 +
 tests/qapi-schema/union-branch-invalid-dict.exit   |   1 +
 tests/qapi-schema/union-branch-invalid-dict.json   |   4 +
 tests/qapi-schema/union-branch-invalid-dict.out    |   0
 tests/qapi-schema/unknown-expr-key.err             |   3 +-
 tests/qapi-schema/unknown-expr-key.json            |   2 +-
 tests/qemu-iotests/229                             |   1 -
 tests/test-cutils.c                                |  24 +-
 tests/test-string-input-visitor.c                  | 223 +++++++++--
 util/cutils.c                                      |  83 ++++-
 91 files changed, 1163 insertions(+), 507 deletions(-)
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
2.17.2
