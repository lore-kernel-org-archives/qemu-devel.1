Received: from eggs.gnu.org ([209.51.188.92]:46156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grRlb-0004hK-Vl
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:17:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grRla-0001xP-3F
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:17:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1grRlX-0001om-S3
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:17:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22834369A0
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 18:17:28 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  6 Feb 2019 19:17:08 +0100
Message-Id: <20190206181725.14337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/17] qapi: add #if pre-processor
 conditions to generated code (part 3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

Marc-Andr=C3=A9 posted a v1 that relies on a QAPI schema language extensi=
on
'top-unit' to permit splitting the generated code.  Here is his cover
letter:

    The thrid and last part (of "[PATCH v2 00/54] qapi: add #if
    pre-processor conditions to generated code") is about adding schema
    conditions based on the target.

    For now, the qapi code is compiled in common objects (common to all
    targets). This makes it impossible to add #if TARGET_ARM for example.

    The patch "RFC: qapi: learn to split the schema by 'top-unit'"
    proposes to split the schema by "top-unit", so that generated code ca=
n
    be built either in common objects or per-target. That patch is a bit
    rough, I would like to get some feedback about the approach before
    trying to improve it. The following patches demonstrate usage of
    target-based #if conditions, and getting rid of the
    qmp_unregister_command() hack.

We already have a way to split generated code: QAPI modules.  I took
the liberty to rework Marc-Andr=C3=A9's series to use a target module
instead.  Less code, no change to the QAPI language.

v3:
* PATCH v2 01+02 have been merged
* PATCH 01-04: New
* PATCH 05: Rebase of PATCH v2 03
* PATCH 06-17: Trivially rebased, R-by and such retained

Marc-Andr=C3=A9 Lureau (9):
  build-sys: move qmp-introspect per target
  qapi: make rtc-reset-reinjection and SEV depend on TARGET_I386
  qapi: make s390 commands depend on TARGET_S390X
  target.json: add a note about query-cpu* not being s390x-specific
  qapi: make query-gic-capabilities depend on TARGET_ARM
  qapi: make query-cpu-model-expansion depend on s390 or x86
  qapi: make query-cpu-definitions depend on specific targets
  qapi: remove qmp_unregister_command()
  qapi: move RTC_CHANGE to the target schema

Markus Armbruster (8):
  qapi: Belatedly document modular code generation
  qapi: Fix up documentation for recent commit a95291007b2
  qapi: Clean up modular built-in code generation a bit
  qapi: Prepare for system modules other than 'builtin'
  qapi: Generate QAPIEvent stuff into separate files
  qapi: New module target.json
  Revert "qapi-events: add 'if' condition to implicit event enum"
  qmp: Deprecate query-events in favor of query-qmp-schema

 .gitignore                               |   1 +
 Makefile                                 |   1 +
 Makefile.objs                            |  23 +-
 Makefile.target                          |  12 +
 docs/devel/qapi-code-gen.txt             |  82 +++-
 hw/ppc/spapr_rtc.c                       |   2 +-
 hw/s390x/s390-skeys.c                    |   2 +-
 hw/timer/mc146818rtc.c                   |   4 +-
 include/qapi/qmp/dispatch.h              |   1 -
 include/sysemu/arch_init.h               |  11 -
 monitor.c                                |  88 +---
 qapi/misc.json                           | 485 +--------------------
 qapi/qapi-schema.json                    |   1 +
 qapi/qmp-registry.c                      |   8 -
 qapi/target.json                         | 514 +++++++++++++++++++++++
 qemu-deprecated.texi                     |   5 +
 qmp.c                                    |  26 --
 scripts/qapi/commands.py                 |   2 +-
 scripts/qapi/common.py                   |  55 ++-
 scripts/qapi/events.py                   |  38 +-
 scripts/qapi/types.py                    |   4 +-
 scripts/qapi/visit.py                    |   4 +-
 stubs/Makefile.objs                      |   4 -
 stubs/arch-query-cpu-def.c               |  11 -
 stubs/arch-query-cpu-model-baseline.c    |  13 -
 stubs/arch-query-cpu-model-comparison.c  |  13 -
 stubs/arch-query-cpu-model-expansion.c   |  13 -
 stubs/monitor.c                          |   2 +-
 target/arm/helper.c                      |   3 +-
 target/arm/monitor.c                     |   2 +-
 target/i386/cpu.c                        |   7 +-
 target/i386/sev_i386.h                   |   2 +-
 target/ppc/translate_init.inc.c          |   3 +-
 target/s390x/cpu_models.c                |   9 +-
 tests/qapi-schema/comments.out           |   1 +
 tests/qapi-schema/doc-bad-section.out    |   1 +
 tests/qapi-schema/doc-good.out           |   1 +
 tests/qapi-schema/empty.out              |   1 +
 tests/qapi-schema/event-case.out         |   1 +
 tests/qapi-schema/ident-with-escape.out  |   1 +
 tests/qapi-schema/include-relpath.out    |   1 +
 tests/qapi-schema/include-repetition.out |   1 +
 tests/qapi-schema/include-simple.out     |   1 +
 tests/qapi-schema/indented-expr.out      |   1 +
 tests/qapi-schema/qapi-schema-test.out   |   1 +
 tests/test-qmp-event.c                   |   1 +
 tests/test-qobject-input-visitor.c       |   1 -
 ui/vnc.c                                 |   3 +-
 48 files changed, 730 insertions(+), 737 deletions(-)
 create mode 100644 qapi/target.json
 delete mode 100644 stubs/arch-query-cpu-def.c
 delete mode 100644 stubs/arch-query-cpu-model-baseline.c
 delete mode 100644 stubs/arch-query-cpu-model-comparison.c
 delete mode 100644 stubs/arch-query-cpu-model-expansion.c

--=20
2.17.2
