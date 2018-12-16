Received: from eggs.gnu.org ([2001:4830:134:3::10]:60987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gYX6W-00012j-E7
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gYX6S-0004hZ-3v
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:09:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gYX6R-0004gq-SC
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:09:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C1A43DEEB
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 14:09:06 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Dec 2018 18:08:49 +0400
Message-Id: <20181216140902.23986-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/13] qapi: add #if pre-processor conditions
 to generated code (part 3)
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

Hi,

The thrid and last part (of "[PATCH v2 00/54] qapi: add #if
pre-processor conditions to generated code") is about adding schema
conditions based on the target.

For now, the qapi code is compiled in common objects (common to all
targets). This makes it impossible to add #if TARGET_ARM for example.

The patch "RFC: qapi: learn to split the schema by 'top-unit'"
proposes to split the schema by "top-unit", so that generated code can
be built either in common objects or per-target. That patch is a bit
rough, I would like to get some feedback about the approach before
trying to improve it. The following patches demonstrate usage of
target-based #if conditions, and getting rid of the
qmp_unregister_command() hack.

Marc-Andr=C3=A9 Lureau (13):
  build-sys: move qmp-introspect per target
  qapi-commands: don't initialize command list in qmp_init_marshall()
  qapi-commands: rename init_marshal() to register_commands()
  RFC: qapi: learn to split the schema by 'top-unit'
  qapi: add a top-unit 'target' schema
  qapi: make rtc-reset-reinjection and SEV depend on TARGET_I386
  qapi: make s390 commands depend on TARGET_S390X
  target.json: add a note about query-cpu* not being s390x-specific
  qapi: make query-gic-capabilities depend on TARGET_ARM
  qapi: make query-cpu-model-expansion depend on s390 or x86
  qapi: make query-cpu-definitions depend on specific targets
  qapi: remove qmp_unregister_command()
  qapi: move RTC_CHANGE to the target schema

 qapi/misc.json                          | 478 ----------------------
 qapi/qapi-schema.json                   |   1 +
 qapi/target.json                        | 516 ++++++++++++++++++++++++
 scripts/qapi/commands.py                |  28 +-
 scripts/qapi/common.py                  | 105 ++++-
 scripts/qapi/events.py                  |  37 +-
 scripts/qapi/types.py                   |   8 +-
 scripts/qapi/visit.py                   |   8 +-
 include/qapi/qmp-event.h                |   4 +
 include/qapi/qmp/dispatch.h             |   1 -
 include/sysemu/arch_init.h              |  11 -
 target/i386/sev_i386.h                  |   2 +-
 hw/ppc/spapr_rtc.c                      |   2 +-
 hw/s390x/s390-skeys.c                   |   2 +-
 hw/timer/mc146818rtc.c                  |   4 +-
 monitor.c                               | 306 +++++++-------
 qapi/qmp-event.c                        |  11 +
 qapi/qmp-registry.c                     |   8 -
 qga/main.c                              |   3 +-
 qmp.c                                   |  26 --
 stubs/arch-query-cpu-def.c              |  11 -
 stubs/arch-query-cpu-model-baseline.c   |  13 -
 stubs/arch-query-cpu-model-comparison.c |  13 -
 stubs/arch-query-cpu-model-expansion.c  |  13 -
 target/arm/helper.c                     |   3 +-
 target/arm/monitor.c                    |   2 +-
 target/i386/cpu.c                       |   6 +-
 target/ppc/translate_init.inc.c         |   3 +-
 target/s390x/cpu_models.c               |   9 +-
 tests/test-qmp-cmds.c                   |   3 +-
 tests/test-qobject-input-visitor.c      |   1 -
 Makefile                                |   7 +-
 Makefile.objs                           |   2 -
 Makefile.target                         |   4 +
 docs/devel/qapi-code-gen.txt            |   6 +-
 stubs/Makefile.objs                     |   4 -
 36 files changed, 851 insertions(+), 810 deletions(-)
 create mode 100644 qapi/target.json
 delete mode 100644 stubs/arch-query-cpu-def.c
 delete mode 100644 stubs/arch-query-cpu-model-baseline.c
 delete mode 100644 stubs/arch-query-cpu-model-comparison.c
 delete mode 100644 stubs/arch-query-cpu-model-expansion.c

--=20
2.20.0
