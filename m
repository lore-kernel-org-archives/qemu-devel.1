Received: from eggs.gnu.org ([2001:4830:134:3::10]:58516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ejNB4-00032o-4k
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ejNB1-0004ZE-0e
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:42:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47342 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ejNB0-0004Ym-S9
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:42:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF2487C6BB
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 10:42:02 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  7 Feb 2018 11:40:22 +0100
Message-Id: <1518000027-274608-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/5] generalize parsing of cpu_model (part 4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>

v4:
  - drop not needed leftover from previous impl. hunk in arm
    CPU_RESOLVING_TYPE patch
  - squash CPU_RESOLVING_TYPE patches into one
  - move test cases from CPU_RESOLVING_TYPE patches into test patch
  - silence microblaze(el) test waring as its cpu doesn't work
    with 'none' machine
  - ensure that cpu_common_parse_features() could be called only once
  - add new test target 'hppa' that were merged since v4

v3:
  - use qtest_startf() instead of qtest_start()
  - rename tests/machine-none.c to tests/machine-none-test.c
  - introduce first CPU_RESOLVING_TYPE for all targets and
    only then use it parse_cpu_model()=20
  - stop abusing  mc->default_cpu_type as resolving cpu type,
    move cpu_parse_cpu_model() in to exec.c and embed in
    CPU_RESOLVING_TYPE, so that callers won't have to know
    about unnecessary detail

v2:
  - implemented new approach only for x86/ARM (will be done for all targe=
ts
    if approach seems acceptable)
  - add test case for '-M none -cpu FOO' case
  - redefine TARGET_DEFAULT_CPU_TYPE into CPU_RESOLVING_TYPE
  - scrape off default cpu_model refactoring, so it would cause
    less conflicts with Laurent's series where he tries to rework
    defaults to use ELF hints of executed program

Series is finishing work on generalizing cpu_model parsing
and limiting parts that deal with inconsistent cpu_model
naming to "-cpu" CLI option in vl.c, bsd|linux-user/main.c
CLI and default cpu_model processing and FOO_cpu_class_by_name()
callbacks.

It introduces CPU_RESOLVING_TYPE which must be defined
by each target and is used by helper parse_cpu_model()
(former cpu_parse_cpu_model()) to get access to target
specific FOO_cpu_class_by_name() callback.

CC: Eduardo Habkost <ehabkost@redhat.com>

Igor Mammedov (5):
  nios2: 10m50_devboard: replace cpu_model with cpu_type
  tests: add machine 'none' with -cpu test
  cpu: add CPU_RESOLVING_TYPE macro
  Use cpu_create(type) instead of cpu_init(cpu_model)
  cpu: get rid of unused cpu_init() defines

 include/hw/boards.h       |   1 -
 include/qom/cpu.h         |  16 +-------
 target/alpha/cpu.h        |   3 +-
 target/arm/cpu.h          |   3 +-
 target/cris/cpu.h         |   3 +-
 target/hppa/cpu.h         |   2 +-
 target/i386/cpu.h         |   3 +-
 target/lm32/cpu.h         |   3 +-
 target/m68k/cpu.h         |   3 +-
 target/microblaze/cpu.h   |   2 +-
 target/mips/cpu.h         |   3 +-
 target/moxie/cpu.h        |   3 +-
 target/nios2/cpu.h        |   2 +-
 target/openrisc/cpu.h     |   3 +-
 target/ppc/cpu.h          |   3 +-
 target/s390x/cpu.h        |   3 +-
 target/sh4/cpu.h          |   3 +-
 target/sparc/cpu.h        |   5 +--
 target/tilegx/cpu.h       |   2 +-
 target/tricore/cpu.h      |   3 +-
 target/unicore32/cpu.h    |   3 +-
 target/xtensa/cpu.h       |   3 +-
 bsd-user/main.c           |   4 +-
 exec.c                    |  23 +++++++++++
 hw/core/null-machine.c    |   6 +--
 hw/nios2/10m50_devboard.c |   2 +-
 linux-user/main.c         |   8 +++-
 qom/cpu.c                 |  47 ++--------------------
 tests/Makefile.include    |   2 +
 tests/machine-none-test.c | 100 ++++++++++++++++++++++++++++++++++++++++=
++++++
 vl.c                      |  10 ++---
 31 files changed, 167 insertions(+), 110 deletions(-)
 create mode 100644 tests/machine-none-test.c

--=20
2.7.4
