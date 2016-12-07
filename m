Received: from eggs.gnu.org ([2001:4830:134:3::10]:60903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cEfZg-0004kG-BS
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 12:00:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cEfZb-0004zz-2W
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 12:00:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1cEfZa-0004yn-Tt
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 12:00:03 -0500
Date: Wed, 7 Dec 2016 17:59:56 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20161207165956.ehw4buztnzqiie2v@kamzik.brq.redhat.com>
References: <1481047528-16180-1-git-send-email-wei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481047528-16180-1-git-send-email-wei@redhat.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v14 0/5] ARM PMU tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: cov@codeaurora.org, alindsay@codeaurora.org, kvm@vger.kernel.org, andre.przywara@arm.com, croberts@codeaurora.org, qemu-devel@nongnu.org, alistair.francis@xilinx.com, shannon.zhao@linaro.org, kvmarm@lists.cs.columbia.edu

On Tue, Dec 06, 2016 at 12:05:23PM -0600, Wei Huang wrote:
> Changes from v13:
> * Rename cp15.h to sysreg.h for ARMv7 and add a new file sysreg.h for ARMv8
> * Add macros for read_sysreg() and write_sysreg(). CP15 registers can be
>   defined with __ACCESS_CP15() or __ACCESS_CP15_64(). sysreg.h (ARMv8) was
>   from Drew's GIC testing code, which can be leveraged when his GIC testing
>   code is imported.
> * Rewrite PMU testing code based on new macros. All get_xxx() and set_xxx()
>   functions are defined in pmu.c based on read_sysreg() and write_sysreg().
>   So the code parsing tool, like cscope, can parse them easily.
> * Minor fixes inside pmu.c, printf formatting, pmu_probe() func, based on
>   Andre's comments.

Thanks for this Wei. I like the sysreg framework. It should address
Andre's concerns with asm-maintainability, plus maintain code analysis
tool (cscope) support.

The series looks good to me, so I'll apply it to arm/next and rebase the
gic series on it, using the new sysreg framework everywhere needed.

drew

> 
> Note:
> Current KVM code has bugs in handling PMCCFILTR write. A fix (see below) is
> required for this unit testing code to work correctly under KVM mode.
> Link: https://lists.cs.columbia.edu/pipermail/kvmarm/2016-November/022134.html.
> 
> Thanks,
> -Wei
> 
> Christopher Covington (3):
>   arm: Add PMU test
>   arm: pmu: Check cycle count increases
>   arm: pmu: Add CPI checking
> 
> Wei Huang (2):
>   arm: rename cp15.h to sysreg.h
>   arm: Add support for read_sysreg() and write_sysreg()
> 
>  arm/Makefile.common              |   3 +-
>  arm/cstart.S                     |   2 +-
>  arm/pmu.c                        | 290 +++++++++++++++++++++++++++++++++++++++
>  arm/unittests.cfg                |  19 +++
>  lib/arm/asm/processor.h          |   6 +-
>  lib/arm/asm/{cp15.h => sysreg.h} |  25 +++-
>  lib/arm64/asm/processor.h        |  11 +-
>  lib/arm64/asm/sysreg.h           |  26 ++++
>  lib/libcflat.h                   |   4 +-
>  9 files changed, 369 insertions(+), 17 deletions(-)
>  create mode 100644 arm/pmu.c
>  rename lib/arm/asm/{cp15.h => sysreg.h} (68%)
>  create mode 100644 lib/arm64/asm/sysreg.h
> 
> -- 
> 1.8.3.1
> 
> 
