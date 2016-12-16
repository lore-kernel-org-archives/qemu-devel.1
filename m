Received: from eggs.gnu.org ([2001:4830:134:3::10]:34327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHt8M-0006Ze-PO
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHt8L-0005MP-Md
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:05:14 -0500
Received: from mail-ua0-x235.google.com ([2607:f8b0:400c:c08::235]:33234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHt8L-0005MA-Is
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:05:13 -0500
Received: by mail-ua0-x235.google.com with SMTP id b35so11148419uaa.0
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 06:05:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1481130374-5147-3-git-send-email-vijay.kilari@gmail.com>
References: <1481130374-5147-1-git-send-email-vijay.kilari@gmail.com>
	<1481130374-5147-3-git-send-email-vijay.kilari@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 14:04:31 +0000
Message-ID: <CAFEAcA_hfxvW9do3xTP4KoEKMWk4NOUKJZFMiTVbJV3hY48HGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v5 2/3] utils: Add helper to read arm
 MIDR_EL1 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vijay Kilari <vijay.kilari@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

On 7 December 2016 at 17:06,  <vijay.kilari@gmail.com> wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>
> Add helper API to read MIDR_EL1 registers to fetch
> cpu identification information. This helps in
> adding errata's and architecture specific features.
>
> This is implemented only for arm architecture.
>
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> ---
>  include/qemu/aarch64-cpuid.h | 38 ++++++++++++++++++++++++++++++++
>  util/Makefile.objs           |  1 +
>  util/aarch64-cpuid.c         | 52 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 91 insertions(+)
>
> diff --git a/include/qemu/aarch64-cpuid.h b/include/qemu/aarch64-cpuid.h
> new file mode 100644
> index 0000000..fb88ed8
> --- /dev/null
> +++ b/include/qemu/aarch64-cpuid.h
> @@ -0,0 +1,38 @@
> +#ifndef QEMU_AARCH64_CPUID_H
> +#define QEMU_AARCH64_CPUID_H
> +
> +#if defined(__aarch64__) && defined(CONFIG_LINUX)
> +#define MIDR_IMPLEMENTER_SHIFT  24
> +#define MIDR_IMPLEMENTER_MASK   (0xffULL << MIDR_IMPLEMENTER_SHIFT)
> +#define MIDR_ARCHITECTURE_SHIFT 16
> +#define MIDR_ARCHITECTURE_MASK  (0xf << MIDR_ARCHITECTURE_SHIFT)
> +#define MIDR_PARTNUM_SHIFT      4
> +#define MIDR_PARTNUM_MASK       (0xfff << MIDR_PARTNUM_SHIFT)
> +
> +#define MIDR_CPU_PART(imp, partnum) \
> +        (((imp)                 << MIDR_IMPLEMENTER_SHIFT)  | \
> +        (0xf                    << MIDR_ARCHITECTURE_SHIFT) | \
> +        ((partnum)              << MIDR_PARTNUM_SHIFT))
> +
> +#define ARM_CPU_IMP_CAVIUM        0x43
> +#define CAVIUM_CPU_PART_THUNDERX  0x0A1
> +
> +#define MIDR_THUNDERX_PASS2  \
> +               MIDR_CPU_PART(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
> +#define CPU_MODEL_MASK  (MIDR_IMPLEMENTER_MASK | MIDR_ARCHITECTURE_MASK | \
> +                         MIDR_PARTNUM_MASK)
> +
> +uint64_t get_aarch64_cpu_id(void);
> +bool is_thunderx_pass2_cpu(void);
> +#else
> +static inline uint64_t get_aarch64_cpu_id(void)
> +{
> +    return 0;
> +}
> +
> +static inline bool is_thunderx_pass2_cpu(void)
> +{
> +    return false;
> +}
> +#endif
> +#endif
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index ad0f9c7..a9585c9 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -36,3 +36,4 @@ util-obj-y += log.o
>  util-obj-y += qdist.o
>  util-obj-y += qht.o
>  util-obj-y += range.o
> +util-obj-$(CONFIG_LINUX) += aarch64-cpuid.o
> diff --git a/util/aarch64-cpuid.c b/util/aarch64-cpuid.c
> new file mode 100644
> index 0000000..575f52e
> --- /dev/null
> +++ b/util/aarch64-cpuid.c
> @@ -0,0 +1,52 @@
> +/*
> + * Dealing with arm cpu identification information.
> + *
> + * Copyright (C) 2016 Cavium, Inc.
> + *
> + * Authors:
> + *  Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.1
> + * or later.  See the COPYING.LIB file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/cutils.h"
> +#include "qemu/aarch64-cpuid.h"
> +
> +#if defined(__aarch64__)
> +static uint64_t qemu_read_aarch64_midr_el1(void)
> +{
> +    const char *file = "/sys/devices/system/cpu/cpu0/regs/identification/midr_el1";

If CPU0 happens to be offline (eg hot-unplugged) then this file
won't exist, and we'll fail to identify any MIDR value.

The API as designed here also doesn't seem to consider
the idea of big.LITTLE systems -- if there are multiple
CPUs with different MIDRs, which one should we return here?

> +    char *buf;
> +    uint64_t midr = 0;
> +
> +    if (!g_file_get_contents(file, &buf, 0, NULL)) {
> +        goto out;
> +    }
> +
> +    if (qemu_strtoull(buf, NULL, 0, &midr) < 0) {
> +        midr = 0;
> +        goto out;
> +    }
> +
> +out:
> +    g_free(buf);
> +
> +    return midr;

thanks
-- PMM
