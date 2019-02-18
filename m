Received: from eggs.gnu.org ([209.51.188.92]:59969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvjYp-0001rg-HQ
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvjYn-0005Sw-1n
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:10158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gvjYm-0005OS-IW
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA360315D3C
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:06:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FEA71048102
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:06:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Feb 2019 15:05:49 +0100
Message-Id: <20190218140607.31998-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/18] QAPI patches for 2019-02-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 1e36232994c8ad01774501d2e299deba3a2469=
af:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-20190=
215' into staging (2019-02-15 11:12:14 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-02-18

for you to fetch changes up to 183e4281a30962729b760dfe8bed5aab27238b0c:

  qapi: move RTC_CHANGE to the target schema (2019-02-18 14:44:05 +0100)

----------------------------------------------------------------
QAPI patches for 2019-02-18

* Support for QAPI conditionals is finally complete.  query-qmp-schema
  now reflects compile-time configuration accurately.  In particular,
  it shows only commands that actually exist in in this build.

----------------------------------------------------------------
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

Markus Armbruster (9):
      qapi: Belatedly document modular code generation
      qapi: Fix up documentation for recent commit a95291007b2
      qapi: Clean up modular built-in code generation a bit
      qapi: Prepare for system modules other than 'builtin'
      qapi: Generate QAPIEvent stuff into separate files
      build: Deal with all of QAPI's .o in qapi/Makefile.objs
      qapi: New module target.json
      Revert "qapi-events: add 'if' condition to implicit event enum"
      qmp: Deprecate query-events in favor of query-qmp-schema

 .gitignore                               |   1 +
 Makefile                                 |   2 +-
 Makefile.objs                            |  17 +-
 Makefile.target                          |   1 +
 docs/devel/qapi-code-gen.txt             |  82 ++++-
 hw/ppc/spapr_rtc.c                       |   2 +-
 hw/s390x/s390-skeys.c                    |   2 +-
 hw/timer/mc146818rtc.c                   |   4 +-
 include/qapi/qmp/dispatch.h              |   1 -
 include/sysemu/arch_init.h               |  11 -
 monitor.c                                |  88 +-----
 qapi/Makefile.objs                       |  25 ++
 qapi/misc.json                           | 485 +------------------------=
----
 qapi/qapi-schema.json                    |   1 +
 qapi/qmp-registry.c                      |   8 -
 qapi/target.json                         | 514 +++++++++++++++++++++++++=
++++++
 qemu-deprecated.texi                     |   5 +
 qmp.c                                    |  26 --
 scripts/qapi/commands.py                 |   2 +-
 scripts/qapi/common.py                   |  55 +++-
 scripts/qapi/events.py                   |  38 ++-
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
 49 files changed, 735 insertions(+), 741 deletions(-)
 create mode 100644 qapi/target.json
 delete mode 100644 stubs/arch-query-cpu-def.c
 delete mode 100644 stubs/arch-query-cpu-model-baseline.c
 delete mode 100644 stubs/arch-query-cpu-model-comparison.c
 delete mode 100644 stubs/arch-query-cpu-model-expansion.c

--=20
2.17.2
