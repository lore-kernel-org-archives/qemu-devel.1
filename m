Received: from eggs.gnu.org ([2001:4830:134:3::10]:39766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cF02Y-0007LI-CI
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 09:51:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cF02V-0002Hk-9B
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 09:51:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1cF02V-0002HP-0g
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 09:51:15 -0500
Date: Thu, 8 Dec 2016 15:51:08 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20161208145108.zeh3uvjrkjt6pwso@kamzik.brq.redhat.com>
References: <1481047528-16180-1-git-send-email-wei@redhat.com>
	<1481047528-16180-4-git-send-email-wei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481047528-16180-4-git-send-email-wei@redhat.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v14 3/5] arm: Add PMU test
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

On Tue, Dec 06, 2016 at 12:05:26PM -0600, Wei Huang wrote:
> From: Christopher Covington <cov@codeaurora.org>
> 
> Beginning with a simple sanity check of the control register, add
> a unit test for the ARM Performance Monitors Unit (PMU).
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  arm/Makefile.common |  3 +-
>  arm/pmu.c           | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  arm/unittests.cfg   |  5 +++
>  3 files changed, 100 insertions(+), 1 deletion(-)
>  create mode 100644 arm/pmu.c
> 
> diff --git a/arm/Makefile.common b/arm/Makefile.common
> index f37b5c2..5da2fdd 100644
> --- a/arm/Makefile.common
> +++ b/arm/Makefile.common
> @@ -12,7 +12,8 @@ endif
>  tests-common = \
>  	$(TEST_DIR)/selftest.flat \
>  	$(TEST_DIR)/spinlock-test.flat \
> -	$(TEST_DIR)/pci-test.flat
> +	$(TEST_DIR)/pci-test.flat \
> +	$(TEST_DIR)/pmu.flat
>  
>  all: test_cases
>  
> diff --git a/arm/pmu.c b/arm/pmu.c
> new file mode 100644
> index 0000000..bf6ac69
> --- /dev/null
> +++ b/arm/pmu.c
> @@ -0,0 +1,93 @@
> +/*
> + * Test the ARM Performance Monitors Unit (PMU).
> + *
> + * Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
> + * Copyright (C) 2016, Red Hat Inc, Wei Huang <wei@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU Lesser General Public License version 2.1 and
> + * only version 2.1 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License
> + * for more details.
> + */
> +#include "libcflat.h"
> +#include "asm/barrier.h"
> +#include "asm/sysreg.h"
> +#include "asm/processor.h"
> +
> +#define PMU_PMCR_N_SHIFT   11
> +#define PMU_PMCR_N_MASK    0x1f
> +#define PMU_PMCR_ID_SHIFT  16
> +#define PMU_PMCR_ID_MASK   0xff
> +#define PMU_PMCR_IMP_SHIFT 24
> +#define PMU_PMCR_IMP_MASK  0xff
> +
> +#define ID_DFR0_PERFMON_SHIFT 24
> +#define ID_DFR0_PERFMON_MASK  0xf
> +
> +static unsigned int pmu_version;
> +#if defined(__arm__)
> +#define PMCR         __ACCESS_CP15(c9, 0, c12, 0)
> +#define ID_DFR0      __ACCESS_CP15(c0, 0, c1, 2)
> +
> +static inline uint32_t get_id_dfr0(void) { return read_sysreg(ID_DFR0); }
> +static inline uint32_t get_pmcr(void) { return read_sysreg(PMCR); }
> +#elif defined(__aarch64__)
> +static inline uint32_t get_id_dfr0(void) { return read_sysreg(id_dfr0_el1); }
> +static inline uint32_t get_pmcr(void) { return read_sysreg(pmcr_el0); }
> +#endif
> +
> +/*
> + * As a simple sanity check on the PMCR_EL0, ensure the implementer field isn't
> + * null. Also print out a couple other interesting fields for diagnostic
> + * purposes. For example, as of fall 2016, QEMU TCG mode doesn't implement
> + * event counters and therefore reports zero event counters, but hopefully
> + * support for at least the instructions event will be added in the future and
> + * the reported number of event counters will become nonzero.
> + */
> +static bool check_pmcr(void)
> +{
> +	uint32_t pmcr;
> +
> +	pmcr = get_pmcr();
> +
> +	report_info("PMU implementer/ID code/counters: 0x%x(\"%c\")/0x%x/%d",
> +		    (pmcr >> PMU_PMCR_IMP_SHIFT) & PMU_PMCR_IMP_MASK,
> +		    ((pmcr >> PMU_PMCR_IMP_SHIFT) & PMU_PMCR_IMP_MASK) ? : ' ',
> +		    (pmcr >> PMU_PMCR_ID_SHIFT) & PMU_PMCR_ID_MASK,
> +		    (pmcr >> PMU_PMCR_N_SHIFT) & PMU_PMCR_N_MASK);
> +
> +	return ((pmcr >> PMU_PMCR_IMP_SHIFT) & PMU_PMCR_IMP_MASK) != 0;
> +}
> +
> +/* Return FALSE if no PMU found, otherwise return TRUE */
> +bool pmu_probe(void)
> +{
> +	uint32_t dfr0;
> +
> +	/* probe pmu version */
> +	dfr0 = get_id_dfr0();

Testing on ThunderX I found this register was zero. I looked at the spec
and see "In an AArch64-only implementation, this register is UNKNOWN."
Which means...

> +	pmu_version = (dfr0 >> ID_DFR0_PERFMON_SHIFT) & ID_DFR0_PERFMON_MASK;
> +
> +	if (pmu_version)
> +		report_info("PMU version: %d", pmu_version);
> +
> +	return pmu_version;
> +}
> +
> +int main(void)
> +{
> +	if (!pmu_probe()) {
> +		printf("No PMU found, test skipped...\n");
> +		return report_summary();

...we don't want to do this.

We haven't heard from other reviewers yet (Andre, are you out there?),
but if this is the only issue with this series, than rather than require
another round, I'll just post a patch that fixes it later.

drew

> +	}
> +
> +	report_prefix_push("pmu");
> +
> +	report("Control register", check_pmcr());
> +
> +	return report_summary();
> +}
> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
> index ae32a42..816f494 100644
> --- a/arm/unittests.cfg
> +++ b/arm/unittests.cfg
> @@ -58,3 +58,8 @@ groups = selftest
>  [pci-test]
>  file = pci-test.flat
>  groups = pci
> +
> +# Test PMU support
> +[pmu]
> +file = pmu.flat
> +groups = pmu
> -- 
> 1.8.3.1
> 
> 
