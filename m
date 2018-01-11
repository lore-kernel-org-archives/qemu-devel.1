Received: from eggs.gnu.org ([2001:4830:134:3::10]:49267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkTA-0004Wk-VA
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:33:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkT7-0000A3-NX
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:33:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkT7-00007G-FH
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:33:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 729BA4901B
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 21:32:59 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:31:59 +0100
Message-Id: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 00/51] Hi,
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
on the schema", the series demonstrates adding conditions.

The schema is splitted in common and per-target parts starting from
"build-sys: add a target schema", using a simple expression filtering
mechanism based on a 'unit' name pragma. This allows target schema to
use target-poisoned defines as conditions (such as TARGET_I386).

Ultimately, qmp_unregister_commands() hack is removed.

There are a lot more things we could make conditional in the QAPI
schema, like pci/kvm/xen/numa/vde/slirp/posix/win32/vsock/lzo etc etc,
however I am still evaluating the implication of such changes both
externally and internally, for those interested, I can share my wip
branch.

Comments welcome,

v4:
- added "qlit: use QType instead of int" patch
- use a "default:" case in qobject_from_qlit()
- added a test for invalid 'if': ['']
- listify ifcond in constructors
- added "qapi: leave the ifcond attribute undefined until check()"
  patch (could be squashed)
- use a negative lookahead in "qapi: mcgen() shouldn't indent # lines"
- fix extra empty line in "qapi-introspect: add preprocessor
  conditions to generated QLit"
- added desugar/normalization passes, such as NAME -> { 'name': NAME }
- splitted "qapi: change enum visitor to take QAPISchemaMember"
- prettify test-qapi.py members output
- added missing #if wrapping for enum members in generated introspection
- clarified some error messages
- added "qapi: rename allow_dict to allow_implicit" patch for clarity
- added a seperate patch for "qapi: add a dictionnary form" for enum
  names
- added a seperate patch for "qapi: add a dictionnary form" for struct
  members
- squashed the patches adding #if to generated code (some types
  generate both enum and struct members for example, so a step-by-step
  is unnecessarily complicated to deal with)
- squashed some tests with related patch
- added "qapi: add an error in case a discriminator is conditionnal"
- add back VNC-specific crypto 'des-rfb' when VNC is disabled
- change the way unit filtering is done (so no -u means no filtering)
- made target.json the top-level documentation schema
- removed some blank lines in generated code output
- improve documentation, add various tests
- commit message improvements
- misc pycodestyle/pep8 fixes
- add r-b tags

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

Marc-Andr=C3=A9 Lureau (51):
  qlit: use QType instead of int
  qlit: add qobject_from_qlit()
  qapi: generate a literal qobject for introspection
  qapi2texi: minor python code simplification
  qapi: add 'if' to top-level expressions
  qapi: pass 'if' condition into QAPISchemaEntity objects
  qapi: leave the ifcond attribute undefined until check()
  qapi: add 'ifcond' to visitor methods
  qapi: mcgen() shouldn't indent # lines
  qapi: add #if/#endif helpers
  qapi-introspect: modify to_qlit() to append ',' on level > 0
  qapi-introspect: add preprocessor conditions to generated QLit
  qapi-commands: add #if conditions to commands
  qapi-event: add #if conditions to events
  qapi-types: refactor variants handling
  qapi-types: add #if conditions to types & visitors
  qapi: do not define enumeration value explicitely
  qapi: rename QAPISchemaEnumType.values to .members
  qapi: change enum visitor to take QAPISchemaMember
  tests: modify visit_enum_type() in test-qapi to print members
  qapi: factor out check_known_keys()
  qapi: add a dictionnary form with 'name' key for enum members
  qapi: add 'if' to enum members
  qapi-event: add 'if' condition to implicit event enum
  qapi: rename allow_dict to allow_implicit
  qapi: add a dictionary form with 'type' key for members
  qapi: add 'if' to implicit struct members
  qapi: add an error in case a discriminator is conditionnal
  qapi: add 'if' on union members
  qapi: add 'if' to alternate members
  qapi: add #if conditions to generated code
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
  build-sys: move qmp-introspect per target
  build-sys: add a target schema
  qapi: make rtc-reset-reinjection depend on TARGET_I386
  qapi: make s390 commands depend on TARGET_S390X
  target.json: add a note about query-cpu* not being s390x-specific
  qapi: make query-gic-capabilities depend on TARGET_ARM
  qapi: make query-cpu-model-expansion depend on s390 or x86
  qapi: make query-cpu-definitions depend on specific targets
  qapi: remove qmp_unregister_command()

 qapi-schema.json                                   | 210 ---------
 qapi/block-core.json                               |  15 +-
 qapi/char.json                                     |  10 +-
 qapi/migration.json                                |  12 +-
 qapi/target.json                                   | 230 ++++++++++
 qapi/ui.json                                       |  75 ++--
 scripts/qapi.py                                    | 494 +++++++++++++++=
------
 scripts/qapi-commands.py                           |  13 +-
 scripts/qapi-event.py                              |  12 +-
 scripts/qapi-introspect.py                         | 126 ++++--
 scripts/qapi-types.py                              |  72 ++-
 scripts/qapi-visit.py                              |  27 +-
 scripts/qapi2texi.py                               |  52 ++-
 include/qapi/qmp/dispatch.h                        |   1 -
 include/qapi/qmp/qlit.h                            |   4 +-
 include/sysemu/arch_init.h                         |  11 -
 ui/vnc.h                                           |   2 +
 hmp.c                                              |   9 +-
 hw/s390x/s390-skeys.c                              |   2 +-
 hw/timer/mc146818rtc.c                             |   2 +-
 migration/colo.c                                   |  16 +-
 monitor.c                                          |  73 +--
 qapi/qmp-registry.c                                |   8 -
 qga/main.c                                         |   1 +
 qmp.c                                              |  72 +--
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
 tests/test-qmp-commands.c                          |   7 +
 tests/test-qobject-input-visitor.c                 |  10 +-
 Makefile                                           |  45 +-
 Makefile.objs                                      |   3 +-
 Makefile.target                                    |   4 +
 docs/devel/qapi-code-gen.txt                       |  71 ++-
 hmp-commands-info.hx                               |   2 +
 stubs/Makefile.objs                                |   4 -
 tests/Makefile.include                             |  23 +-
 tests/qapi-schema/alternate-base.err               |   2 +-
 tests/qapi-schema/alternate-invalid-dict.err       |   1 +
 ...ict-member.exit =3D> alternate-invalid-dict.exit} |   0
 tests/qapi-schema/alternate-invalid-dict.json      |   4 +
 ...-dict-member.out =3D> alternate-invalid-dict.out} |   0
 tests/qapi-schema/bad-if-empty-list.err            |   1 +
 tests/qapi-schema/bad-if-empty-list.exit           |   1 +
 tests/qapi-schema/bad-if-empty-list.json           |   3 +
 tests/qapi-schema/bad-if-empty-list.out            |   0
 tests/qapi-schema/bad-if-empty.err                 |   1 +
 tests/qapi-schema/bad-if-empty.exit                |   1 +
 tests/qapi-schema/bad-if-empty.json                |   3 +
 tests/qapi-schema/bad-if-empty.out                 |   0
 tests/qapi-schema/bad-if-list.err                  |   1 +
 tests/qapi-schema/bad-if-list.exit                 |   1 +
 tests/qapi-schema/bad-if-list.json                 |   3 +
 tests/qapi-schema/bad-if-list.out                  |   0
 tests/qapi-schema/bad-if.err                       |   1 +
 tests/qapi-schema/bad-if.exit                      |   1 +
 tests/qapi-schema/bad-if.json                      |   3 +
 tests/qapi-schema/bad-if.out                       |   0
 tests/qapi-schema/comments.out                     |  14 +-
 tests/qapi-schema/doc-bad-section.out              |  13 +-
 tests/qapi-schema/doc-good.json                    |  11 +-
 tests/qapi-schema/doc-good.out                     |  23 +-
 tests/qapi-schema/doc-good.texi                    |  10 +-
 tests/qapi-schema/double-type.err                  |   2 +-
 tests/qapi-schema/empty.out                        |   9 +-
 tests/qapi-schema/enum-bad-member.err              |   1 +
 tests/qapi-schema/enum-bad-member.exit             |   1 +
 tests/qapi-schema/enum-bad-member.json             |   2 +
 tests/qapi-schema/enum-bad-member.out              |   0
 tests/qapi-schema/enum-dict-member-unknown.err     |   1 +
 tests/qapi-schema/enum-dict-member-unknown.exit    |   1 +
 tests/qapi-schema/enum-dict-member-unknown.json    |   2 +
 tests/qapi-schema/enum-dict-member-unknown.out     |   0
 tests/qapi-schema/enum-dict-member.err             |   1 -
 tests/qapi-schema/enum-dict-member.json            |   2 -
 tests/qapi-schema/enum-if-invalid.err              |   1 +
 tests/qapi-schema/enum-if-invalid.exit             |   1 +
 tests/qapi-schema/enum-if-invalid.json             |   3 +
 tests/qapi-schema/enum-if-invalid.out              |   0
 tests/qapi-schema/enum-missing-data.err            |   2 +-
 tests/qapi-schema/event-case.out                   |   9 +-
 tests/qapi-schema/event-nest-struct.err            |   2 +-
 tests/qapi-schema/flat-union-inline.err            |   2 +-
 .../flat-union-invalid-if-discriminator.err        |   1 +
 .../flat-union-invalid-if-discriminator.exit       |   1 +
 .../flat-union-invalid-if-discriminator.json       |  17 +
 .../flat-union-invalid-if-discriminator.out        |   0
 tests/qapi-schema/ident-with-escape.out            |   9 +-
 tests/qapi-schema/include-relpath.out              |  14 +-
 tests/qapi-schema/include-repetition.out           |  14 +-
 tests/qapi-schema/include-simple.out               |  14 +-
 tests/qapi-schema/indented-expr.out                |   9 +-
 tests/qapi-schema/nested-struct-data.err           |   2 +-
 tests/qapi-schema/pragma-unit-invalid.err          |   1 +
 tests/qapi-schema/pragma-unit-invalid.exit         |   1 +
 tests/qapi-schema/pragma-unit-invalid.json         |   3 +
 tests/qapi-schema/pragma-unit-invalid.out          |   0
 tests/qapi-schema/qapi-schema-test.json            |  52 ++-
 tests/qapi-schema/qapi-schema-test.out             | 102 ++++-
 tests/qapi-schema/struct-member-invalid-dict.err   |   1 +
 tests/qapi-schema/struct-member-invalid-dict.exit  |   1 +
 tests/qapi-schema/struct-member-invalid-dict.json  |   3 +
 tests/qapi-schema/struct-member-invalid-dict.out   |   0
 tests/qapi-schema/test-qapi.py                     |  38 +-
 tests/qapi-schema/union-branch-invalid-dict.err    |   1 +
 tests/qapi-schema/union-branch-invalid-dict.exit   |   1 +
 tests/qapi-schema/union-branch-invalid-dict.json   |   4 +
 tests/qapi-schema/union-branch-invalid-dict.out    |   0
 tests/qapi-schema/unknown-expr-key.err             |   2 +-
 tests/qapi-schema/unknown-expr-key.json            |   2 +-
 118 files changed, 1473 insertions(+), 808 deletions(-)
 create mode 100644 qapi/target.json
 delete mode 100644 stubs/arch-query-cpu-def.c
 delete mode 100644 stubs/arch-query-cpu-model-baseline.c
 delete mode 100644 stubs/arch-query-cpu-model-comparison.c
 delete mode 100644 stubs/arch-query-cpu-model-expansion.c
 create mode 100644 tests/qapi-schema/alternate-invalid-dict.err
 rename tests/qapi-schema/{enum-dict-member.exit =3D> alternate-invalid-d=
ict.exit} (100%)
 create mode 100644 tests/qapi-schema/alternate-invalid-dict.json
 rename tests/qapi-schema/{enum-dict-member.out =3D> alternate-invalid-di=
ct.out} (100%)
 create mode 100644 tests/qapi-schema/bad-if-empty-list.err
 create mode 100644 tests/qapi-schema/bad-if-empty-list.exit
 create mode 100644 tests/qapi-schema/bad-if-empty-list.json
 create mode 100644 tests/qapi-schema/bad-if-empty-list.out
 create mode 100644 tests/qapi-schema/bad-if-empty.err
 create mode 100644 tests/qapi-schema/bad-if-empty.exit
 create mode 100644 tests/qapi-schema/bad-if-empty.json
 create mode 100644 tests/qapi-schema/bad-if-empty.out
 create mode 100644 tests/qapi-schema/bad-if-list.err
 create mode 100644 tests/qapi-schema/bad-if-list.exit
 create mode 100644 tests/qapi-schema/bad-if-list.json
 create mode 100644 tests/qapi-schema/bad-if-list.out
 create mode 100644 tests/qapi-schema/bad-if.err
 create mode 100644 tests/qapi-schema/bad-if.exit
 create mode 100644 tests/qapi-schema/bad-if.json
 create mode 100644 tests/qapi-schema/bad-if.out
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
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.err
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.exit
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.json
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.out
 create mode 100644 tests/qapi-schema/pragma-unit-invalid.err
 create mode 100644 tests/qapi-schema/pragma-unit-invalid.exit
 create mode 100644 tests/qapi-schema/pragma-unit-invalid.json
 create mode 100644 tests/qapi-schema/pragma-unit-invalid.out
 create mode 100644 tests/qapi-schema/struct-member-invalid-dict.err
 create mode 100644 tests/qapi-schema/struct-member-invalid-dict.exit
 create mode 100644 tests/qapi-schema/struct-member-invalid-dict.json
 create mode 100644 tests/qapi-schema/struct-member-invalid-dict.out
 create mode 100644 tests/qapi-schema/union-branch-invalid-dict.err
 create mode 100644 tests/qapi-schema/union-branch-invalid-dict.exit
 create mode 100644 tests/qapi-schema/union-branch-invalid-dict.json
 create mode 100644 tests/qapi-schema/union-branch-invalid-dict.out

--=20
2.16.0.rc1.1.gef27df75a1
