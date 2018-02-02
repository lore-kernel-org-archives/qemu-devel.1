Received: from eggs.gnu.org ([208.118.235.92]:56000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdLa-0002kI-84
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdKW-0003WV-5C
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:33:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehdKV-0003TZ-9R
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:32:43 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 14:03:15 +0100
Message-Id: <20180202130336.24719-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RFC 00/21] Modularize generated QAPI code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Our qapi-schema.json is composed of modules connected by include
directives, but the generated code is monolithic all the same: one
qapi-types.h with all the types, one qapi-visit.h with all the
visitors, and so forth.  These monolithic headers get included all
over the place.  In my "build everyhing" tree, adding a QAPI type
recompiles about 4500 out of 4800 objects.

Nobody would write such monolithic headers by hand.  It stands to
reason that one shouldn't generate them, either.

This series' basic idea is to split up generated headers to mirror the
schema's modular structure: one header per module.  That way, you can
include just what you need.

The series is RFC for a number of reasons:

* The split is implemented only for qapi-types.h.  That one should
  provide the biggest benefits, though.

* There's a bit of code duplication.

* I haven't re-read my patches, yet.

Even in this incomplete state, the compile-time improvements can be
massive.  Before this series, any QAPI schema change recompiles some
4500 out of 4800 objects in my "build everything" tree.  Afterwards,
adding a type to qapi/migration.json recompiles less than 400, adding
a QMP event recompiles less than 200, and a documentation change no
longer recompiles anything.

Related: Marc-Andr=C3=A9's 'unit' pragma proposal.  That's a different wa=
y
to split off parts of the generated code, motivated by the desire to
use poisoned identifiers such as TARGET_I386.  I noted in my review of
v3 that I "can either accept it, or come up with a better solution."
This is my attempt at a better solution.  It's a bit more ambitious,
and thus more useful (I hope).  The pragma has one theoretical
advantage, though: you can modularize the generated output in
different ways than the input.  The patches using don't do that,
however.

Based-on: <20180201111846.21846-1-armbru@redhat.com>
[PATCH v3 00/19] Clean up includes to reduce compile time

Markus Armbruster (21):
  qapi: Streamline boilerplate comment generation
  qapi: Generate up-to-date copyright notice
  qapi: New classes QAPIGenC, QAPIGenH, QAPIGenDoc
  qapi: Reduce use of global variables in generators some
  qapi: Turn generators into modules
  qapi-gen: New common driver for code and doc generators
  qapi: Move parse_command_line() next to its only use
  qapi: Touch generated files only when they change
  qapi: Don't absolutize include file name in error messages
  qapi/common: Eliminate QAPISchema.exprs
  qapi: Lift error reporting from QAPISchema.__init__() to callers
  qapi: Concentrate QAPISchemaParser.exprs updates in .__init__()
  qapi: Record 'include' directives in parse tree
  qapi: Generate in source order
  qapi: Record 'include' directives in intermediate representation
  qapi/types qapi/visit: Make visitors use QAPIGen more
  qapi/types qapi/visit: Generate built-in stuff into separate files
  qapi/common: Fix guardname() for funny filenames
  qapi/types: Generate separate .h, .c for each module
  Include less of qapi-types.h
  qapi: Empty out qapi-schema.json

 Makefile                                           |  131 +-
 Makefile.objs                                      |   20 +-
 crypto/cipherpriv.h                                |    2 +-
 hw/block/block.c                                   |    1 +
 hw/block/hd-geometry.c                             |    1 +
 hw/net/rocker/rocker_fp.c                          |    2 +-
 include/block/block.h                              |    2 +-
 include/block/dirty-bitmap.h                       |    2 +-
 include/chardev/char.h                             |    1 +
 include/crypto/cipher.h                            |    2 +-
 include/crypto/hash.h                              |    2 +-
 include/crypto/hmac.h                              |    2 +-
 include/crypto/secret.h                            |    1 +
 include/crypto/tlscreds.h                          |    1 +
 include/hw/block/block.h                           |    2 +-
 include/hw/block/fdc.h                             |    2 +-
 include/hw/ppc/spapr_drc.h                         |    1 +
 include/hw/qdev-properties.h                       |    2 +
 include/io/dns-resolver.h                          |    1 +
 include/migration/colo.h                           |    2 +-
 include/migration/failover.h                       |    2 +-
 include/migration/global_state.h                   |    1 +
 include/monitor/monitor.h                          |    1 +
 include/net/filter.h                               |    1 +
 include/net/net.h                                  |    2 +-
 include/qapi/error.h                               |    2 +-
 include/qapi/qmp/qobject.h                         |    2 +-
 include/qapi/visitor.h                             |    2 +-
 include/qemu/sockets.h                             |    2 +-
 include/qemu/throttle.h                            |    2 +-
 include/qom/cpu.h                                  |    1 +
 include/qom/object.h                               |    2 +-
 include/sysemu/arch_init.h                         |    2 +-
 include/sysemu/balloon.h                           |    2 +-
 include/sysemu/dump.h                              |    2 +
 include/sysemu/hostmem.h                           |    1 +
 include/sysemu/replay.h                            |    2 +
 include/sysemu/sysemu.h                            |    1 +
 include/sysemu/tpm.h                               |    1 +
 include/sysemu/watchdog.h                          |    2 +-
 include/ui/input.h                                 |    2 +-
 migration/migration.h                              |    1 +
 migration/ram.h                                    |    2 +-
 net/tap_int.h                                      |    2 +-
 qapi-schema.json                                   | 3098 +-------------=
------
 qapi/misc.json                                     | 3090 ++++++++++++++=
+++++
 qapi/run-state.json                                |   10 +
 replication.h                                      |    1 +
 scripts/qapi-gen.py                                |   95 +
 scripts/qapi/__init__.py                           |    0
 scripts/{qapi-commands.py =3D> qapi/commands.py}     |   98 +-
 scripts/{qapi.py =3D> qapi/common.py}                |  290 +-
 scripts/{qapi2texi.py =3D> qapi/doc.py}              |   28 +-
 scripts/{qapi-event.py =3D> qapi/events.py}          |  101 +-
 scripts/{qapi-introspect.py =3D> qapi/introspect.py} |   87 +-
 scripts/{qapi-types.py =3D> qapi/types.py}           |  218 +-
 scripts/{qapi-visit.py =3D> qapi/visit.py}           |  208 +-
 tests/Makefile.include                             |   56 +-
 tests/qapi-schema/comments.out                     |    3 +-
 tests/qapi-schema/doc-bad-section.out              |    5 +-
 tests/qapi-schema/doc-good.out                     |   33 +-
 tests/qapi-schema/doc-good.texi                    |    3 +-
 tests/qapi-schema/empty.out                        |    2 +-
 tests/qapi-schema/event-case.out                   |    3 +-
 tests/qapi-schema/ident-with-escape.out            |    7 +-
 tests/qapi-schema/include-no-file.err              |    2 +-
 tests/qapi-schema/include-relpath.out              |    7 +-
 tests/qapi-schema/include-repetition.out           |   12 +-
 tests/qapi-schema/include-simple.out               |    5 +-
 tests/qapi-schema/indented-expr.out                |    3 +-
 tests/qapi-schema/qapi-schema-test.out             |  321 +-
 tests/qapi-schema/test-qapi.py                     |   17 +-
 ui/vnc.h                                           |    1 +
 73 files changed, 4040 insertions(+), 3984 deletions(-)
 create mode 100644 qapi/misc.json
 create mode 100755 scripts/qapi-gen.py
 create mode 100644 scripts/qapi/__init__.py
 rename scripts/{qapi-commands.py =3D> qapi/commands.py} (78%)
 rename scripts/{qapi.py =3D> qapi/common.py} (93%)
 rename scripts/{qapi2texi.py =3D> qapi/doc.py} (93%)
 mode change 100755 =3D> 100644
 rename scripts/{qapi-event.py =3D> qapi/events.py} (69%)
 rename scripts/{qapi-introspect.py =3D> qapi/introspect.py} (78%)
 rename scripts/{qapi-types.py =3D> qapi/types.py} (54%)
 rename scripts/{qapi-visit.py =3D> qapi/visit.py} (66%)

--=20
2.13.6
