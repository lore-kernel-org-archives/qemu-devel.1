Received: from eggs.gnu.org ([2001:4830:134:3::10]:59745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejBmp-0002Mj-Nn
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 17:32:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejBmo-0007yM-Hb
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 17:32:23 -0500
Date: Tue, 6 Feb 2018 20:32:13 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180206223213.GG13301@localhost.localdomain>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/25] generalize parsing of cpu_model
 (part 4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Laurent Vivier <laurent@vivier.eu>

I will try to summarize my comments here:

* I suggest squashing patches 2-22 together.  This way we
  shouldn't have any intermediate commits where "make check"
  generates warnings, and the series is shorter.
  * Or, even better: squash the CPU_RESOLVING_TYPE parts of 3-22
    into one patch, and the tests/machine-none-test.c parts of
    3-22 into patch 2.

* The linux-user/main.c hunk of patch 03/25 looks unnecessary.

* I suggest testing all CPU models in patch 02/25, but this
  shouldn't block the series.  Can be a follow-up patch.

All the rest looks good to me.

Thanks!


On Tue, Jan 23, 2018 at 09:07:59AM +0100, Igor Mammedov wrote:
> 
> v3:
>   - use qtest_startf() instead of qtest_start()
>   - rename tests/machine-none.c to tests/machine-none-test.c
>   - introduce first CPU_RESOLVING_TYPE for all targets and
>     only then use it parse_cpu_model() 
>   - stop abusing  mc->default_cpu_type as resolving cpu type,
>     move cpu_parse_cpu_model() in to exec.c and embed in
>     CPU_RESOLVING_TYPE, so that callers won't have to know
>     about unnecessary detail
> 
> v2:
>   - implemented new approach only for x86/ARM (will be done for all targets
>     if approach seems acceptable)
>   - add test case for '-M none -cpu FOO' case
>   - redefine TARGET_DEFAULT_CPU_TYPE into CPU_RESOLVING_TYPE
>   - scrape off default cpu_model refactoring, so it would cause
>     less conflicts with Laurent's series where he tries to rework
>     defaults to use ELF hints of executed program
> 
> Series is finishing work on generalizing cpu_model parsing
> and limiting parts that deal with inconsistent cpu_model
> naming to "-cpu" CLI option in vl.c, bsd|linux-user/main.c
> CLI and default cpu_model processing and FOO_cpu_class_by_name()
> callbacks.
> 
> It introduces CPU_RESOLVING_TYPE which must be defined
> by each target and is used by helper parse_cpu_model()
> (former cpu_parse_cpu_model()) to get access to target
> specific FOO_cpu_class_by_name() callback.
> 
> git tree for testing:
>    https://github.com/imammedo/qemu.git cpu_init_removal_v3
> 
> CC: Laurent Vivier <laurent@vivier.eu>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: qemu-s390x@nongnu.org
> CC: qemu-ppc@nongnu.org
> CC: qemu-arm@nongnu.org
> 
> Igor Mammedov (25):
>   nios2: 10m50_devboard: replace cpu_model with cpu_type
>   tests: add machine 'none' with -cpu test
>   arm: cpu: add CPU_RESOLVING_TYPE macro
>   x86: cpu: add CPU_RESOLVING_TYPE macro
>   alpha: cpu: add CPU_RESOLVING_TYPE macro
>   cris: cpu: add CPU_RESOLVING_TYPE macro
>   lm32: cpu: add CPU_RESOLVING_TYPE macro
>   m68k: cpu: add CPU_RESOLVING_TYPE macro
>   microblaze: cpu: add CPU_RESOLVING_TYPE macro
>   mips: cpu: add CPU_RESOLVING_TYPE macro
>   moxie: cpu: add CPU_RESOLVING_TYPE macro
>   nios2: cpu: add CPU_RESOLVING_TYPE macro
>   openrisc: cpu: add CPU_RESOLVING_TYPE macro
>   ppc: cpu: add CPU_RESOLVING_TYPE macro
>   s390x: cpu: add CPU_RESOLVING_TYPE macro
>   sh4: cpu: add CPU_RESOLVING_TYPE macro
>   sparc: cpu: add CPU_RESOLVING_TYPE macro
>   tricore: cpu: add CPU_RESOLVING_TYPE macro
>   unicore32: cpu: add CPU_RESOLVING_TYPE macro
>   xtensa: cpu: add CPU_RESOLVING_TYPE macro
>   hppa: cpu: add CPU_RESOLVING_TYPE macro
>   tilegx: cpu: add CPU_RESOLVING_TYPE macro
>   Use cpu_create(type) instead of cpu_init(cpu_model)
>   cpu: get rid of unused cpu_init() defines
>   cpu: get rid of cpu_generic_init()
> 
>  include/qom/cpu.h         | 16 +-------
>  target/alpha/cpu.h        |  3 +-
>  target/arm/cpu.h          |  3 +-
>  target/cris/cpu.h         |  3 +-
>  target/hppa/cpu.h         |  2 +-
>  target/i386/cpu.h         |  3 +-
>  target/lm32/cpu.h         |  3 +-
>  target/m68k/cpu.h         |  3 +-
>  target/microblaze/cpu.h   |  2 +-
>  target/mips/cpu.h         |  3 +-
>  target/moxie/cpu.h        |  3 +-
>  target/nios2/cpu.h        |  2 +-
>  target/openrisc/cpu.h     |  3 +-
>  target/ppc/cpu.h          |  3 +-
>  target/s390x/cpu.h        |  3 +-
>  target/sh4/cpu.h          |  3 +-
>  target/sparc/cpu.h        |  5 +--
>  target/tilegx/cpu.h       |  2 +-
>  target/tricore/cpu.h      |  3 +-
>  target/unicore32/cpu.h    |  3 +-
>  target/xtensa/cpu.h       |  3 +-
>  bsd-user/main.c           |  4 +-
>  exec.c                    | 23 +++++++++++
>  hw/core/null-machine.c    |  6 +--
>  hw/nios2/10m50_devboard.c |  2 +-
>  linux-user/main.c         | 10 +++--
>  qom/cpu.c                 | 48 +----------------------
>  tests/Makefile.include    |  2 +
>  tests/machine-none-test.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++
>  vl.c                      | 10 ++---
>  30 files changed, 162 insertions(+), 114 deletions(-)
>  create mode 100644 tests/machine-none-test.c
> 
> -- 
> 2.7.4
> 
> 

-- 
Eduardo
