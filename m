Received: from eggs.gnu.org ([2001:4830:134:3::10]:56129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal23-0005na-Eb
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal20-0004cx-85
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:48:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dal1z-0004cN-VV
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:48:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E50AC04D30A
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 15:41:30 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Jul 2017 17:41:00 +0200
Message-Id: <20170727154126.11339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/26] qapi: add #if pre-processor conditions
 to generated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

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
remove qmp_unregister_commands_hack(). However, it feels like I
cheated a little bit by using per-target NEED_CPU_H in the headers to
avoid #define poison. The alternative could be to split the headers in
common/target?

There are a lot more things we could make conditional in the QAPI
schema, like pci/kvm/xen/numa/vde/slirp/posix/win32/vsock/lzo etc etc,
however I am still evaluating the implication of such changes both
externally and internally, for those interested, I can share my wip
branch.

Comments welcome,

Marc-Andr=C3=A9 Lureau (26):
  qapi: fix type_seen key error
  qobject: replace dump_qobject() by qobject_to_string()
  qboject: add literal qobject type
  qapi: generate a literal qobject for introspection
  visitor: pass size of strings array to enum visitor
  qapi2texi: minor python code simplification
  qapi: add 'if' condition on top-level schema elements
  qapi: add 'if' condition on enum member values
  qapi: add 'if' condition on struct member
  qapi: add 'if' condition on union variant
  qapi: add 'if' condition on alternate variant
  qapi2texi: add 'If:' section to generated documentation
  qapi2texi: add 'If:' condition to enum values
  qapi2texi: add 'If:' condition to struct members
  qapi2texi: add condition to variants
  qapi: add conditions to VNC type/commands/events on the schema
  qapi: add conditions to SPICE type/commands/events on the schema
  qapi: add conditions to REPLICATION type/commands on the schema
  build-sys: move qapi variables in qapi.mak
  tests/qmp-test: add query-qmp-schema test
  build-sys: make qemu qapi objects per-target
  qapi: make rtc-reset-reinjection depend on TARGET_I386
  qapi: make s390 commands depend on TARGET_S390X
  qapi: make query-gic-capabilities depend on TARGET_ARM
  qapi: make query-cpu-model-expansion depend on s390 or x86
  qapi: make query-cpu-definitions depend on specific targets

 qapi-schema.json                                 |  98 ++++++----
 qapi/event.json                                  |  21 +-
 include/qapi/visitor.h                           |   3 +-
 scripts/qapi.py                                  | 232 +++++++++++++++++=
+-----
 scripts/qapi-commands.py                         |   4 +-
 scripts/qapi-event.py                            |   4 +-
 scripts/qapi-introspect.py                       | 116 +++++++-----
 scripts/qapi-types.py                            |  55 ++++--
 scripts/qapi-visit.py                            |  29 ++-
 scripts/qapi2texi.py                             |  49 ++---
 include/hw/qdev-core.h                           |   1 +
 include/qapi/qmp/qdict.h                         |   2 +
 include/qapi/qmp/qlist.h                         |   2 +
 include/qapi/qmp/qlit.h                          |  53 ++++++
 include/qapi/qmp/qobject.h                       |   7 +
 include/qom/object.h                             |   4 +
 include/sysemu/arch_init.h                       |  11 --
 qapi/qapi-visit-core.c                           |  23 +--
 backends/hostmem.c                               |   1 +
 block/qapi.c                                     |  90 +--------
 crypto/secret.c                                  |   1 +
 crypto/tlscreds.c                                |   1 +
 hmp.c                                            |  14 +-
 hw/core/qdev-properties.c                        |  11 +-
 migration/colo.c                                 |  14 +-
 monitor.c                                        |  70 +------
 net/filter.c                                     |   1 +
 qmp.c                                            |  72 +------
 qobject/qdict.c                                  |  30 +++
 qobject/qlist.c                                  |  23 +++
 qobject/qlit.c                                   |  53 ++++++
 qobject/qobject.c                                |  21 ++
 qom/object.c                                     |  11 +-
 stubs/arch-query-cpu-def.c                       |  10 -
 stubs/arch-query-cpu-model-baseline.c            |  12 --
 stubs/arch-query-cpu-model-comparison.c          |  12 --
 stubs/arch-query-cpu-model-expansion.c           |  12 --
 stubs/qapi-event.c                               |  74 ++++++++
 target/arm/helper.c                              |   3 +-
 target/i386/cpu.c                                |   5 +-
 target/ppc/translate_init.c                      |   3 +-
 target/s390x/cpu_models.c                        |   9 +-
 tests/check-qjson.c                              |  91 +++++----
 tests/check-qlit.c                               |  52 +++++
 tests/check-qom-proplist.c                       |   1 +
 tests/qmp-test.c                                 |  21 ++
 tests/test-qobject-input-visitor.c               |  11 +-
 Makefile                                         |  43 ++---
 Makefile.objs                                    |   9 +-
 Makefile.target                                  |   4 +
 docs/devel/qapi-code-gen.txt                     |  29 ++-
 qapi.mak                                         |  14 ++
 qobject/Makefile.objs                            |   2 +-
 stubs/Makefile.objs                              |   5 +-
 tests/Makefile.include                           |  11 +-
 tests/qapi-schema/alternate-conflict-string.json |   4 +-
 tests/qapi-schema/alternate-dict-invalid.err     |   1 +
 tests/qapi-schema/alternate-dict-invalid.exit    |   1 +
 tests/qapi-schema/alternate-dict-invalid.json    |   4 +
 tests/qapi-schema/alternate-dict-invalid.out     |   0
 tests/qapi-schema/bad-if.err                     |   1 +
 tests/qapi-schema/bad-if.exit                    |   1 +
 tests/qapi-schema/bad-if.json                    |   3 +
 tests/qapi-schema/bad-if.out                     |   0
 tests/qapi-schema/enum-dict-member-invalid.err   |   1 +
 tests/qapi-schema/enum-dict-member-invalid.exit  |   1 +
 tests/qapi-schema/enum-dict-member-invalid.json  |   2 +
 tests/qapi-schema/enum-dict-member-invalid.out   |   0
 tests/qapi-schema/enum-dict-member.err           |   1 -
 tests/qapi-schema/enum-dict-member.exit          |   2 +-
 tests/qapi-schema/enum-dict-member.json          |   3 +-
 tests/qapi-schema/enum-dict-member.out           |   4 +
 tests/qapi-schema/enum-if-invalid.err            |   1 +
 tests/qapi-schema/enum-if-invalid.exit           |   1 +
 tests/qapi-schema/enum-if-invalid.json           |   3 +
 tests/qapi-schema/enum-if-invalid.out            |   0
 tests/qapi-schema/qapi-schema-test.json          |  32 ++++
 tests/qapi-schema/qapi-schema-test.out           |  47 +++++
 tests/qapi-schema/struct-if-invalid.err          |   1 +
 tests/qapi-schema/struct-if-invalid.exit         |   1 +
 tests/qapi-schema/struct-if-invalid.json         |   3 +
 tests/qapi-schema/struct-if-invalid.out          |   0
 tests/qapi-schema/struct-member-type.err         |   0
 tests/qapi-schema/struct-member-type.exit        |   1 +
 tests/qapi-schema/struct-member-type.json        |   1 +
 tests/qapi-schema/struct-member-type.out         |   5 +
 tests/qapi-schema/test-qapi.py                   |  31 ++-
 trace/Makefile.objs                              |   2 +-
 88 files changed, 1094 insertions(+), 624 deletions(-)
 create mode 100644 include/qapi/qmp/qlit.h
 create mode 100644 qobject/qlit.c
 delete mode 100644 stubs/arch-query-cpu-def.c
 delete mode 100644 stubs/arch-query-cpu-model-baseline.c
 delete mode 100644 stubs/arch-query-cpu-model-comparison.c
 delete mode 100644 stubs/arch-query-cpu-model-expansion.c
 create mode 100644 stubs/qapi-event.c
 create mode 100644 tests/check-qlit.c
 create mode 100644 qapi.mak
 create mode 100644 tests/qapi-schema/alternate-dict-invalid.err
 create mode 100644 tests/qapi-schema/alternate-dict-invalid.exit
 create mode 100644 tests/qapi-schema/alternate-dict-invalid.json
 create mode 100644 tests/qapi-schema/alternate-dict-invalid.out
 create mode 100644 tests/qapi-schema/bad-if.err
 create mode 100644 tests/qapi-schema/bad-if.exit
 create mode 100644 tests/qapi-schema/bad-if.json
 create mode 100644 tests/qapi-schema/bad-if.out
 create mode 100644 tests/qapi-schema/enum-dict-member-invalid.err
 create mode 100644 tests/qapi-schema/enum-dict-member-invalid.exit
 create mode 100644 tests/qapi-schema/enum-dict-member-invalid.json
 create mode 100644 tests/qapi-schema/enum-dict-member-invalid.out
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
2.14.0.rc0.1.g40ca67566
