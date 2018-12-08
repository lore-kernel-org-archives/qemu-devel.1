Received: from eggs.gnu.org ([2001:4830:134:3::10]:60452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gVadt-0007PQ-3I
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:19:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gVadp-00051L-Tq
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:19:29 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gVadp-000513-In
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:19:25 -0500
Received: by mail-qt1-f193.google.com with SMTP id k12so7421930qtf.7
	for <qemu-devel@nongnu.org>; Sat, 08 Dec 2018 03:19:25 -0800 (PST)
MIME-Version: 1.0
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
In-Reply-To: <20181208111606.8505-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 8 Dec 2018 15:19:11 +0400
Message-ID: <CAMxuvazbS3hq8FgXXU1YnDgWoFkeu35bDUQz83fOJWGXZdq0Lg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 00/27] Hi,
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: "Armbruster, Markus" <armbru@redhat.com>

Hi,

The cover letter title should be "qapi: add #if pre-processor
conditions to generated code (part 2)"


On Sat, Dec 8, 2018 at 3:16 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> This is the second part of the "add #if pre-processor conditions to
> generated code" series, adding schema member conditions (roughly
> 16-38/49).
>
> Members can be exploded as dictionnary with 'type'/'if' keys:
>
> { 'struct': 'TestIfStruct', 'data':
>   { 'foo': 'int',
>     'bar': { 'type': 'int', 'if': 'defined(TEST_IF_STRUCT_BAR)'} } }
>
> Enum values can be exploded as dictionnary with 'type'/'if' keys:
>
> { 'enum': 'TestIfEnum', 'data':
>   [ 'foo',
>     { 'name' : 'bar', 'if': 'defined(TEST_IF_ENUM_BAR)' } ] }
>
> v7:
> - replaced osdep.h include by a #warning check
> - renamed event_names/event_enum_members, enum_name/event_enum_ename
> - move normalization after checking
> - simplify make_enum_members()
> - some tests changes
> - rebase/conflicts tweaks
> - squash documentation changes in related patches
> - tweak generated documentation code & output
> - modify commit comments, add rb tags
>
> v6:
> - subset of v5 series: add schema member conditions
> - split "qapi: factor out check_known_keys()", error report improvements
> - add a patch to "qapi: include osdep.h in type headers" to avoid
>   potential build configuration change issues
> - rebased, on top of Markus's qapi-next branch (first 4 patches,
>   included for patchew testing)
>
> Marc-Andr=C3=A9 Lureau (27):
>   qapi: make sure osdep.h is included in type headers
>   qapi: do not define enumeration value explicitly
>   qapi: rename QAPISchemaEnumType.values to .members
>   qapi: change enum visitor and gen_enum* to take QAPISchemaMember
>   tests: print enum type members more like object type members
>   qapi: factor out checking for keys
>   qapi: improve reporting of unknown or missing keys
>   qapi: add a dictionary form with 'name' key for enum members
>   qapi: add 'if' to enum members
>   qapi-events: add 'if' condition to implicit event enum
>   qapi: pass long form enum to make_enum_members
>   qapi: rename allow_dict to allow_implicit
>   qapi: add a dictionary form for TYPE
>   qapi: add 'if' to implicit struct members
>   qapi: add an error in case a discriminator is conditional
>   qapi: add 'if' to union members
>   qapi: simplify make_enum_members()
>   tests/qapi: add command with condition on union argument
>   qapi: add 'if' to alternate members
>   tests/qapi: add command with condition on alternate argument
>   qapi: add #if conditions to generated code members
>   qapi: add 'If:' condition to enum values documentation
>   qapi: add 'If:' condition to struct members documentation
>   qapi: add condition to variants documentation
>   qapi: break long lines at 'data' member
>   qapi: add more conditions to SPICE
>   qapi: add conditions to REPLICATION type/commands on the schema
>
>  qapi/block-core.json                          |  26 +-
>  qapi/char.json                                | 150 ++++++-----
>  qapi/migration.json                           |  15 +-
>  qapi/misc.json                                |   7 +-
>  qapi/net.json                                 |   3 +-
>  qapi/tpm.json                                 |   5 +-
>  qapi/ui.json                                  |   3 +-
>  scripts/qapi/common.py                        | 253 ++++++++++++------
>  scripts/qapi/doc.py                           |  30 ++-
>  scripts/qapi/events.py                        |  13 +-
>  scripts/qapi/introspect.py                    |  16 +-
>  scripts/qapi/types.py                         |  13 +-
>  scripts/qapi/visit.py                         |   8 +-
>  migration/colo.c                              |  16 +-
>  monitor.c                                     |   5 -
>  docs/devel/qapi-code-gen.txt                  |  19 ++
>  tests/Makefile.include                        |  11 +-
>  tests/qapi-schema/alternate-base.err          |   1 +
>  tests/qapi-schema/alternate-invalid-dict.err  |   1 +
>  ...ember.exit =3D> alternate-invalid-dict.exit} |   0
>  tests/qapi-schema/alternate-invalid-dict.json |   4 +
>  ...-member.out =3D> alternate-invalid-dict.out} |   0
>  tests/qapi-schema/comments.out                |  14 +-
>  tests/qapi-schema/doc-bad-section.out         |  13 +-
>  tests/qapi-schema/doc-good.json               |  11 +-
>  tests/qapi-schema/doc-good.out                |  22 +-
>  tests/qapi-schema/doc-good.texi               |   7 +-
>  tests/qapi-schema/double-type.err             |   1 +
>  tests/qapi-schema/empty.out                   |   9 +-
>  tests/qapi-schema/enum-bad-member.err         |   1 +
>  tests/qapi-schema/enum-bad-member.exit        |   1 +
>  tests/qapi-schema/enum-bad-member.json        |   2 +
>  tests/qapi-schema/enum-bad-member.out         |   0
>  .../qapi-schema/enum-dict-member-unknown.err  |   2 +
>  .../qapi-schema/enum-dict-member-unknown.exit |   1 +
>  .../qapi-schema/enum-dict-member-unknown.json |   2 +
>  .../qapi-schema/enum-dict-member-unknown.out  |   0
>  tests/qapi-schema/enum-dict-member.err        |   1 -
>  tests/qapi-schema/enum-dict-member.json       |   2 -
>  tests/qapi-schema/enum-if-invalid.err         |   1 +
>  tests/qapi-schema/enum-if-invalid.exit        |   1 +
>  tests/qapi-schema/enum-if-invalid.json        |   3 +
>  tests/qapi-schema/enum-if-invalid.out         |   0
>  tests/qapi-schema/event-case.out              |   9 +-
>  .../qapi-schema/event-member-invalid-dict.err |   1 +
>  .../event-member-invalid-dict.exit            |   1 +
>  .../event-member-invalid-dict.json            |   2 +
>  .../qapi-schema/event-member-invalid-dict.out |   0
>  tests/qapi-schema/event-nest-struct.json      |   2 +-
>  .../flat-union-inline-invalid-dict.err        |   1 +
>  .../flat-union-inline-invalid-dict.exit       |   1 +
>  .../flat-union-inline-invalid-dict.json       |  11 +
>  .../flat-union-inline-invalid-dict.out        |   0
>  tests/qapi-schema/flat-union-inline.json      |   2 +-
>  .../flat-union-invalid-if-discriminator.err   |   1 +
>  .../flat-union-invalid-if-discriminator.exit  |   1 +
>  .../flat-union-invalid-if-discriminator.json  |  17 ++
>  .../flat-union-invalid-if-discriminator.out   |   0
>  tests/qapi-schema/ident-with-escape.out       |   9 +-
>  tests/qapi-schema/include-relpath.out         |  14 +-
>  tests/qapi-schema/include-repetition.out      |  14 +-
>  tests/qapi-schema/include-simple.out          |  14 +-
>  tests/qapi-schema/indented-expr.out           |   9 +-
>  .../nested-struct-data-invalid-dict.err       |   1 +
>  .../nested-struct-data-invalid-dict.exit      |   1 +
>  .../nested-struct-data-invalid-dict.json      |   3 +
>  .../nested-struct-data-invalid-dict.out       |   0
>  tests/qapi-schema/nested-struct-data.json     |   2 +-
>  tests/qapi-schema/qapi-schema-test.json       |  39 ++-
>  tests/qapi-schema/qapi-schema-test.out        |  74 ++++-
>  .../struct-member-invalid-dict.err            |   1 +
>  .../struct-member-invalid-dict.exit           |   1 +
>  .../struct-member-invalid-dict.json           |   3 +
>  .../struct-member-invalid-dict.out            |   0
>  tests/qapi-schema/test-qapi.py                |   9 +-
>  .../qapi-schema/union-branch-invalid-dict.err |   1 +
>  .../union-branch-invalid-dict.exit            |   1 +
>  .../union-branch-invalid-dict.json            |   4 +
>  .../qapi-schema/union-branch-invalid-dict.out |   0
>  tests/qapi-schema/unknown-expr-key.err        |   3 +-
>  tests/qapi-schema/unknown-expr-key.json       |   2 +-
>  81 files changed, 681 insertions(+), 266 deletions(-)
>  create mode 100644 tests/qapi-schema/alternate-invalid-dict.err
>  rename tests/qapi-schema/{enum-dict-member.exit =3D> alternate-invalid-d=
ict.exit} (100%)
>  create mode 100644 tests/qapi-schema/alternate-invalid-dict.json
>  rename tests/qapi-schema/{enum-dict-member.out =3D> alternate-invalid-di=
ct.out} (100%)
>  create mode 100644 tests/qapi-schema/enum-bad-member.err
>  create mode 100644 tests/qapi-schema/enum-bad-member.exit
>  create mode 100644 tests/qapi-schema/enum-bad-member.json
>  create mode 100644 tests/qapi-schema/enum-bad-member.out
>  create mode 100644 tests/qapi-schema/enum-dict-member-unknown.err
>  create mode 100644 tests/qapi-schema/enum-dict-member-unknown.exit
>  create mode 100644 tests/qapi-schema/enum-dict-member-unknown.json
>  create mode 100644 tests/qapi-schema/enum-dict-member-unknown.out
>  delete mode 100644 tests/qapi-schema/enum-dict-member.err
>  delete mode 100644 tests/qapi-schema/enum-dict-member.json
>  create mode 100644 tests/qapi-schema/enum-if-invalid.err
>  create mode 100644 tests/qapi-schema/enum-if-invalid.exit
>  create mode 100644 tests/qapi-schema/enum-if-invalid.json
>  create mode 100644 tests/qapi-schema/enum-if-invalid.out
>  create mode 100644 tests/qapi-schema/event-member-invalid-dict.err
>  create mode 100644 tests/qapi-schema/event-member-invalid-dict.exit
>  create mode 100644 tests/qapi-schema/event-member-invalid-dict.json
>  create mode 100644 tests/qapi-schema/event-member-invalid-dict.out
>  create mode 100644 tests/qapi-schema/flat-union-inline-invalid-dict.err
>  create mode 100644 tests/qapi-schema/flat-union-inline-invalid-dict.exit
>  create mode 100644 tests/qapi-schema/flat-union-inline-invalid-dict.json
>  create mode 100644 tests/qapi-schema/flat-union-inline-invalid-dict.out
>  create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.err
>  create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.exit
>  create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.json
>  create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.out
>  create mode 100644 tests/qapi-schema/nested-struct-data-invalid-dict.err
>  create mode 100644 tests/qapi-schema/nested-struct-data-invalid-dict.exi=
t
>  create mode 100644 tests/qapi-schema/nested-struct-data-invalid-dict.jso=
n
>  create mode 100644 tests/qapi-schema/nested-struct-data-invalid-dict.out
>  create mode 100644 tests/qapi-schema/struct-member-invalid-dict.err
>  create mode 100644 tests/qapi-schema/struct-member-invalid-dict.exit
>  create mode 100644 tests/qapi-schema/struct-member-invalid-dict.json
>  create mode 100644 tests/qapi-schema/struct-member-invalid-dict.out
>  create mode 100644 tests/qapi-schema/union-branch-invalid-dict.err
>  create mode 100644 tests/qapi-schema/union-branch-invalid-dict.exit
>  create mode 100644 tests/qapi-schema/union-branch-invalid-dict.json
>  create mode 100644 tests/qapi-schema/union-branch-invalid-dict.out
>
> --
> 2.20.0.rc1
>
