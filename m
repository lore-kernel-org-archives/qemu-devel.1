Received: from eggs.gnu.org ([2001:4830:134:3::10]:53555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9EV-0003eN-I8
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9ES-0003bK-6A
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:28:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53563)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9ER-0003av-SM
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:28:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21EA3C047B9D
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 13:23:01 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:01 +0200
Message-Id: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/54] qapi: add #if pre-processor
 conditions to generated code
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

v2: after Markus review
 - "qboject: add literal qobject type", splitted & many updates
 - "qapi: generate a literal qobject for introspection", fixed leak
 - "visitor: pass size of strings array to enum visitor", rewrote as a
  series of patches to change char*[] to struct { int n, char *[] }.
 - split the "if" patches in parsing, tests, generation
 - added a docs/devel/qapi-code-gen.txt patch
 - added a patch to remove enum value assignment, to avoid "holes"
   with #if values
 - update #if VNC patch, compile out "info vnc", compile out des-rfb
 - dropped "qobject: replace dump_qobject() by qobject_to_string()" patch
 - dropped qapi.mk patch
 - other smaller changes

Marc-Andr=C3=A9 Lureau (54):
  qapi: fix type_seen key error
  qdict: add qdict_put_null() helper
  qobject: add literal qobject type
  qlit: add qobject_form_qlit()
  qapi: generate a literal qobject for introspection
  qapi: introduce qapi_enum_lookup()
  tpm: simplify driver registration & lookup
  hmp: use qapi_enum_parse() in hmp_migrate_set_capability
  hmp: use qapi_enum_parse() in hmp_migrate_set_parameter
  block: use qemu_enum_parse() in blkdebug_debug_breakpoint
  quorum: use qapi_enum_parse() in quorum_open
  qapi: change enum lookup structure
  qapi: drop the sentinel in enum array
  qapi2texi: minor python code simplification
  qapi: add 'if' to top-level expressions
  qapi: add a test for invalid 'if'
  qapi: add 'if' condition on entity objects
  qapi: add 'ifcond' to visitor methods
  qapi: add #if/#endif helpers
  qapi-introspect: modify to_qlit() to take an optional suffix
  qapi-introspect: modify to_qlit() to generate #if code
  qapi-introspect: add preprocessor conditions to generated QLit
  qapi-commands: add #if conditions to commands
  qapi-event: add #if conditions to events
  qapi-visit: add #if conditions to visitors
  qapi-types: refactor variants handling
  qapi-types: add #if conditions to types
  qapi: do not define enumeration value explicitely
  qapi: add 'if' to enum members
  qapi: add #if conditions on generated enum values
  tests: add some enum members tests
  qapi: add 'if' to struct members
  qapi: add some struct member tests
  qapi: add #if conditions to generated struct members
  qapi: add 'if' on union variants
  qapi: add #if conditions to generated variants
  qapi: 'if' to alternate variant
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
  tests/qmp-test: add query-qmp-schema test
  build-sys: make qemu qapi objects per-target
  qapi: make rtc-reset-reinjection depend on TARGET_I386
  qapi: make s390 commands depend on TARGET_S390X
  qapi: make query-gic-capabilities depend on TARGET_ARM
  qapi: make query-cpu-model-expansion depend on s390 or x86
  qapi: make query-cpu-definitions depend on specific targets

 qapi-schema.json                                 |  98 +++++---
 qapi/block-core.json                             |  13 +-
 qapi/crypto.json                                 |   3 +-
 qapi/event.json                                  |  21 +-
 include/qapi/visitor.h                           |   2 +-
 scripts/qapi.py                                  | 279 +++++++++++++++++=
------
 scripts/qapi-commands.py                         |   4 +-
 scripts/qapi-event.py                            |   4 +-
 scripts/qapi-introspect.py                       | 124 ++++++----
 scripts/qapi-types.py                            |  62 +++--
 scripts/qapi-visit.py                            |  21 +-
 scripts/qapi2texi.py                             |  51 +++--
 include/hw/qdev-core.h                           |   2 +-
 include/qapi/qmp/qdict.h                         |   2 +
 include/qapi/qmp/qlit.h                          |  56 +++++
 include/qapi/util.h                              |   6 +-
 include/qom/object.h                             |   4 +-
 include/sysemu/arch_init.h                       |  11 -
 include/sysemu/tpm_backend.h                     |   2 +-
 qapi/qapi-visit-core.c                           |  24 +-
 backends/hostmem.c                               |   5 +-
 block.c                                          |   3 +-
 block/backup.c                                   |   3 +-
 block/blkdebug.c                                 |  28 +--
 block/file-posix.c                               |  18 +-
 block/file-win32.c                               |   6 +-
 block/gluster.c                                  |  12 +-
 block/iscsi.c                                    |   3 +-
 block/nfs.c                                      |   3 +-
 block/parallels.c                                |  11 +-
 block/qcow2.c                                    |  15 +-
 block/qed.c                                      |   3 +-
 block/quorum.c                                   |  27 +--
 block/rbd.c                                      |   3 +-
 block/sheepdog.c                                 |   3 +-
 blockdev.c                                       |   9 +-
 blockjob.c                                       |   9 +-
 chardev/char.c                                   |   7 +-
 crypto/block-luks.c                              |  43 ++--
 crypto/block.c                                   |   5 +-
 crypto/cipher-afalg.c                            |   2 +-
 crypto/cipher-builtin.c                          |  17 +-
 crypto/cipher-gcrypt.c                           |  14 +-
 crypto/cipher-nettle.c                           |  22 +-
 crypto/cipher.c                                  |  14 +-
 crypto/hmac-gcrypt.c                             |   2 +-
 crypto/hmac-glib.c                               |   3 +-
 crypto/hmac-nettle.c                             |   3 +-
 crypto/pbkdf-gcrypt.c                            |   3 +-
 crypto/pbkdf-nettle.c                            |   4 +-
 crypto/secret.c                                  |   2 +-
 crypto/tlscreds.c                                |   2 +-
 hmp.c                                            | 252 ++++++++++-------=
---
 hw/block/fdc.c                                   |   9 +-
 hw/char/escc.c                                   |   3 +-
 hw/core/qdev-properties.c                        |  19 +-
 hw/input/virtio-input-hid.c                      |   5 +-
 migration/colo-failover.c                        |   6 +-
 migration/colo.c                                 |  31 +--
 migration/global_state.c                         |   5 +-
 monitor.c                                        |  94 ++------
 net/filter.c                                     |   2 +-
 net/net.c                                        |   5 +-
 qapi/qapi-util.c                                 |  16 +-
 qapi/qmp-dispatch.c                              |   4 +-
 qemu-img.c                                       |   6 +-
 qemu-nbd.c                                       |   3 +-
 qmp.c                                            |  72 +-----
 qobject/qlit.c                                   | 143 ++++++++++++
 qom/object.c                                     |  16 +-
 stubs/arch-query-cpu-def.c                       |  10 -
 stubs/arch-query-cpu-model-baseline.c            |  12 -
 stubs/arch-query-cpu-model-comparison.c          |  12 -
 stubs/arch-query-cpu-model-expansion.c           |  12 -
 stubs/qapi-event.c                               |  74 ++++++
 target/arm/helper.c                              |   3 +-
 target/i386/cpu.c                                |   5 +-
 target/ppc/translate_init.c                      |   3 +-
 target/s390x/cpu_models.c                        |   9 +-
 tests/check-qjson.c                              | 150 +++---------
 tests/check-qlit.c                               |  94 ++++++++
 tests/check-qom-proplist.c                       |   7 +-
 tests/qmp-test.c                                 |  21 ++
 tests/test-qapi-util.c                           |  17 +-
 tests/test-qmp-commands.c                        |   6 +
 tests/test-qobject-input-visitor.c               |  18 +-
 tests/test-qobject-output-visitor.c              |   4 +-
 tests/test-string-input-visitor.c                |   4 +-
 tests/test-string-output-visitor.c               |   6 +-
 tpm.c                                            |  44 ++--
 ui/input-legacy.c                                |   6 +-
 ui/input.c                                       |  13 +-
 ui/vnc.c                                         |   8 +-
 vl.c                                             |   7 +-
 Makefile.objs                                    |   9 +-
 Makefile.target                                  |   4 +
 docs/devel/qapi-code-gen.txt                     |  76 +++++-
 hmp-commands-info.hx                             |   2 +
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
 tests/qapi-schema/qapi-schema-test.json          |  32 +++
 tests/qapi-schema/qapi-schema-test.out           |  47 ++++
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
 134 files changed, 1606 insertions(+), 990 deletions(-)
 create mode 100644 include/qapi/qmp/qlit.h
 create mode 100644 qobject/qlit.c
 delete mode 100644 stubs/arch-query-cpu-def.c
 delete mode 100644 stubs/arch-query-cpu-model-baseline.c
 delete mode 100644 stubs/arch-query-cpu-model-comparison.c
 delete mode 100644 stubs/arch-query-cpu-model-expansion.c
 create mode 100644 stubs/qapi-event.c
 create mode 100644 tests/check-qlit.c
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
2.14.1.146.gd35faa819
