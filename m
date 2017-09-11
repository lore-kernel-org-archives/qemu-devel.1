Received: from eggs.gnu.org ([2001:4830:134:3::10]:42497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMXv-0004hv-DE
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMXt-0005vI-0u
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMXs-0005ug-Ot
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31351362ADD
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 11:06:27 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:05:33 +0200
Message-Id: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/50] Hi,
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

In order to clean-up some hacks in qapi (having to unregister commands
at runtime), I proposed a "[PATCH v5 02/20] qapi.py: add a simple #ifdef =
condition"

(see http://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03106.html).

However, we decided to drop that patch from the series and solve the
problem later. The main issues were:
- the syntax was awkward to the JSON schema and documentation
- the evaluation of the condition was done in the qapi scripts, with
  very limited capability
- each target/config would need different generated files.

Instead, it could defer the #if evaluation to the C-preprocessor.

With this series, top-level qapi JSON entity can take 'if' keys:

{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
  'if': 'defined(TEST_IF_STRUCT)' }

Members can be exploded as dictionnary with 'type'/'if' keys:

{ 'struct': 'TestIfStruct', 'data':
  { 'foo': 'int',
    'bar': { 'type': 'int', 'if': 'defined(TEST_IF_STRUCT_BAR)'} } }

Enum values can be exploded as dictionnary with 'type'/'if' keys:

{ 'enum': 'TestIfEnum', 'data':
  [ 'foo',
    { 'name' : 'bar', 'if': 'defined(TEST_IF_ENUM_BAR)' } ] }

A good benefit from having conditional schema is that introspection
will reflect more accurately the capability of the server. Another
benefit is that it may help to remove some dead code when disabling a
functionality.

Starting from patch "qapi: add conditions to VNC type/commands/events
on the schema", the series demonstrate adding conditions, in order to
remove qmp_unregister_commands_hack(). The main difference with v2, is
the addition of a per-target schema in "build-sys: add a target
schema". This removes the NEED_CPU_H hack, and keep most of the qapi
files in common build.

There are a lot more things we could make conditional in the QAPI
schema, like pci/kvm/xen/numa/vde/slirp/posix/win32/vsock/lzo etc etc,
however I am still evaluating the implication of such changes both
externally and internally, for those interested, I can share my wip
branch.

Comments welcome,

v3:
- rebased (qlit is now merged upstream)
- solve the per-target #ifdef problem by using a target.json
  and new qapi generated target files
- update some commit messages based on Markus review
- more schema error reporting
- move the ifcond argument closer to info/doc
- use mcgen() in gen_if()/gen_endif()
- simplify "modify to_qlit() to take an optional suffix"
- fix generated qlit indentation
- fix temporary build break by merging #if types & visitors patch
- fix some redundant condtionals generation
- change enum visitor to take QAPISchemaMember
- reject unknown dictionnary keys in { .., 'if': ..}
- split qapi test visitor print() with trailing ',' trick

Marc-Andr=C3=A9 Lureau (50):
  qlit: add qobject_from_qlit()
  qapi: generate a literal qobject for introspection
  qapi2texi: minor python code simplification
  qapi: add 'if' to top-level expressions
  qapi: add tests for invalid 'if'
  qapi: pass 'if' condition into QAPISchemaEntity objects
  qapi: add 'ifcond' to visitor methods
  qapi: mcgen() shouldn't indent # lines
  qapi: add #if/#endif helpers
  qapi-introspect: modify to_qlit() to append ',' on level > 0
  qapi-introspect: modify to_qlit() to generate #if code
  qapi-introspect: add preprocessor conditions to generated QLit
  qapi-commands: add #if conditions to commands
  qapi-event: add #if conditions to events
  qapi-types: refactor variants handling
  qapi-types: add #if conditions to types & visitors
  qapi: do not define enumeration value explicitely
  qapi: change enum visitor to take QAPISchemaMember
  qapi: add 'if' to enum members
  qapi-event: add 'if' condition to generated enum
  qapi: add #if conditions on generated enum members
  tests: add some enum members tests
  qapi: add 'if' to struct members and implicit objects members
  qapi: add some struct member tests
  qapi: add #if conditions to generated struct members
  qapi: add 'if' on union variants
  qapi: add #if conditions to generated variants
  qapi: add 'if' to alternate variant
  qapi: add tests for invalid alternate
  qapi: add #if conditions to generated alternate variants
  docs: document schema configuration
  qapi2texi: add 'If:' section to generated documentation
  qapi2texi: add 'If:' condition to enum values
  qapi2texi: add 'If:' condition to struct members
  qapi2texi: add condition to variants
  qapi: add conditions to VNC type/commands/events on the schema
  qapi: add conditions to SPICE type/commands/events on the schema
  qapi: add conditions to REPLICATION type/commands on the schema
  qapi-commands: don't initialize command list in qmp_init_marshall()
  qapi: add -i/--include filename.h
  qapi: add a 'unit' pragma
  qapi: add a -u/--unit option to specify which unit to visit
  build-sys: move qmp-introspect per target
  build-sys: add a target schema
  qapi: make rtc-reset-reinjection depend on TARGET_I386
  qapi: make s390 commands depend on TARGET_S390X
  target.json: add a note about query-cpu* not being s390x-specific
  qapi: make query-gic-capabilities depend on TARGET_ARM
  qapi: make query-cpu-model-expansion depend on s390 or x86
  qapi: make query-cpu-definitions depend on specific targets

 qapi-schema.json                                   | 212 +-----------
 qapi/block-core.json                               |  15 +-
 qapi/char.json                                     |  10 +-
 qapi/crypto.json                                   |   3 +-
 qapi/migration.json                                |  12 +-
 qapi/target.json                                   | 228 +++++++++++++
 qapi/ui.json                                       |  75 +++--
 scripts/qapi.py                                    | 372 +++++++++++++++=
------
 scripts/qapi-commands.py                           |  13 +-
 scripts/qapi-event.py                              |  12 +-
 scripts/qapi-introspect.py                         | 121 ++++---
 scripts/qapi-types.py                              |  71 ++--
 scripts/qapi-visit.py                              |  24 +-
 scripts/qapi2texi.py                               |  52 +--
 include/qapi/qmp/qlit.h                            |   2 +
 include/sysemu/arch_init.h                         |  11 -
 ui/vnc.h                                           |   2 +
 crypto/cipher-builtin.c                            |   9 +
 crypto/cipher-gcrypt.c                             |  10 +-
 crypto/cipher-nettle.c                             |  14 +-
 crypto/cipher.c                                    |  13 +-
 hmp.c                                              |   9 +-
 hw/s390x/s390-skeys.c                              |   2 +-
 hw/timer/mc146818rtc.c                             |   2 +-
 migration/colo.c                                   |  16 +-
 monitor.c                                          |  73 +---
 qga/main.c                                         |   1 +
 qmp.c                                              |  72 +---
 qobject/qlit.c                                     |  36 ++
 stubs/arch-query-cpu-def.c                         |  10 -
 stubs/arch-query-cpu-model-baseline.c              |  12 -
 stubs/arch-query-cpu-model-comparison.c            |  12 -
 stubs/arch-query-cpu-model-expansion.c             |  12 -
 target/arm/helper.c                                |   3 +-
 target/arm/monitor.c                               |   2 +-
 target/i386/cpu.c                                  |   5 +-
 target/ppc/translate_init.c                        |   3 +-
 target/s390x/cpu_models.c                          |   9 +-
 tests/check-qlit.c                                 |  26 ++
 tests/test-crypto-cipher.c                         |   2 +
 tests/test-qmp-commands.c                          |   7 +
 tests/test-qobject-input-visitor.c                 |  10 +-
 Makefile                                           |  29 +-
 Makefile.objs                                      |   3 +-
 Makefile.target                                    |   4 +
 docs/devel/qapi-code-gen.txt                       |  69 +++-
 hmp-commands-info.hx                               |   2 +
 stubs/Makefile.objs                                |   4 -
 tests/Makefile.include                             |  10 +-
 tests/qapi-schema/alternate-dict-invalid.err       |   1 +
 ...ict-member.exit =3D> alternate-dict-invalid.exit} |   0
 tests/qapi-schema/alternate-dict-invalid.json      |   4 +
 ...-dict-member.out =3D> alternate-dict-invalid.out} |   0
 tests/qapi-schema/bad-if-empty-list.err            |   1 +
 tests/qapi-schema/bad-if-empty-list.exit           |   1 +
 tests/qapi-schema/bad-if-empty-list.json           |   3 +
 tests/qapi-schema/bad-if-empty-list.out            |   0
 tests/qapi-schema/bad-if-empty.err                 |   1 +
 tests/qapi-schema/bad-if-empty.exit                |   1 +
 tests/qapi-schema/bad-if-empty.json                |   3 +
 tests/qapi-schema/bad-if-empty.out                 |   0
 tests/qapi-schema/bad-if.err                       |   1 +
 tests/qapi-schema/bad-if.exit                      |   1 +
 tests/qapi-schema/bad-if.json                      |   3 +
 tests/qapi-schema/bad-if.out                       |   0
 tests/qapi-schema/comments.out                     |  14 +-
 tests/qapi-schema/doc-good.out                     |  17 +-
 tests/qapi-schema/empty.out                        |   9 +-
 tests/qapi-schema/enum-dict-member-invalid.err     |   1 +
 tests/qapi-schema/enum-dict-member-invalid.exit    |   1 +
 tests/qapi-schema/enum-dict-member-invalid.json    |   2 +
 tests/qapi-schema/enum-dict-member-invalid.out     |   0
 tests/qapi-schema/enum-dict-member-invalid2.err    |   1 +
 tests/qapi-schema/enum-dict-member-invalid2.exit   |   1 +
 tests/qapi-schema/enum-dict-member-invalid2.json   |   2 +
 tests/qapi-schema/enum-dict-member-invalid2.out    |   0
 tests/qapi-schema/enum-dict-member.err             |   1 -
 tests/qapi-schema/enum-dict-member.json            |   2 -
 tests/qapi-schema/enum-if-invalid.err              |   1 +
 tests/qapi-schema/enum-if-invalid.exit             |   1 +
 tests/qapi-schema/enum-if-invalid.json             |   3 +
 tests/qapi-schema/enum-if-invalid.out              |   0
 tests/qapi-schema/event-case.out                   |   9 +-
 tests/qapi-schema/ident-with-escape.out            |   9 +-
 tests/qapi-schema/include-relpath.out              |  14 +-
 tests/qapi-schema/include-repetition.out           |  14 +-
 tests/qapi-schema/include-simple.out               |  14 +-
 tests/qapi-schema/indented-expr.out                |   9 +-
 tests/qapi-schema/qapi-schema-test.json            |  36 ++
 tests/qapi-schema/qapi-schema-test.out             |  93 +++++-
 tests/qapi-schema/struct-if-invalid.err            |   1 +
 tests/qapi-schema/struct-if-invalid.exit           |   1 +
 tests/qapi-schema/struct-if-invalid.json           |   3 +
 tests/qapi-schema/struct-if-invalid.out            |   0
 tests/qapi-schema/struct-member-type.err           |   0
 tests/qapi-schema/struct-member-type.exit          |   1 +
 tests/qapi-schema/struct-member-type.json          |   2 +
 tests/qapi-schema/struct-member-type.out           |  12 +
 tests/qapi-schema/test-qapi.py                     |  43 ++-
 99 files changed, 1328 insertions(+), 735 deletions(-)
 create mode 100644 qapi/target.json
 delete mode 100644 stubs/arch-query-cpu-def.c
 delete mode 100644 stubs/arch-query-cpu-model-baseline.c
 delete mode 100644 stubs/arch-query-cpu-model-comparison.c
 delete mode 100644 stubs/arch-query-cpu-model-expansion.c
 create mode 100644 tests/qapi-schema/alternate-dict-invalid.err
 rename tests/qapi-schema/{enum-dict-member.exit =3D> alternate-dict-inva=
lid.exit} (100%)
 create mode 100644 tests/qapi-schema/alternate-dict-invalid.json
 rename tests/qapi-schema/{enum-dict-member.out =3D> alternate-dict-inval=
id.out} (100%)
 create mode 100644 tests/qapi-schema/bad-if-empty-list.err
 create mode 100644 tests/qapi-schema/bad-if-empty-list.exit
 create mode 100644 tests/qapi-schema/bad-if-empty-list.json
 create mode 100644 tests/qapi-schema/bad-if-empty-list.out
 create mode 100644 tests/qapi-schema/bad-if-empty.err
 create mode 100644 tests/qapi-schema/bad-if-empty.exit
 create mode 100644 tests/qapi-schema/bad-if-empty.json
 create mode 100644 tests/qapi-schema/bad-if-empty.out
 create mode 100644 tests/qapi-schema/bad-if.err
 create mode 100644 tests/qapi-schema/bad-if.exit
 create mode 100644 tests/qapi-schema/bad-if.json
 create mode 100644 tests/qapi-schema/bad-if.out
 create mode 100644 tests/qapi-schema/enum-dict-member-invalid.err
 create mode 100644 tests/qapi-schema/enum-dict-member-invalid.exit
 create mode 100644 tests/qapi-schema/enum-dict-member-invalid.json
 create mode 100644 tests/qapi-schema/enum-dict-member-invalid.out
 create mode 100644 tests/qapi-schema/enum-dict-member-invalid2.err
 create mode 100644 tests/qapi-schema/enum-dict-member-invalid2.exit
 create mode 100644 tests/qapi-schema/enum-dict-member-invalid2.json
 create mode 100644 tests/qapi-schema/enum-dict-member-invalid2.out
 delete mode 100644 tests/qapi-schema/enum-dict-member.err
 delete mode 100644 tests/qapi-schema/enum-dict-member.json
 create mode 100644 tests/qapi-schema/enum-if-invalid.err
 create mode 100644 tests/qapi-schema/enum-if-invalid.exit
 create mode 100644 tests/qapi-schema/enum-if-invalid.json
 create mode 100644 tests/qapi-schema/enum-if-invalid.out
 create mode 100644 tests/qapi-schema/struct-if-invalid.err
 create mode 100644 tests/qapi-schema/struct-if-invalid.exit
 create mode 100644 tests/qapi-schema/struct-if-invalid.json
 create mode 100644 tests/qapi-schema/struct-if-invalid.out
 create mode 100644 tests/qapi-schema/struct-member-type.err
 create mode 100644 tests/qapi-schema/struct-member-type.exit
 create mode 100644 tests/qapi-schema/struct-member-type.json
 create mode 100644 tests/qapi-schema/struct-member-type.out

--=20
2.14.1.146.gd35faa819
