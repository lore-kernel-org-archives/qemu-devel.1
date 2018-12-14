Received: from eggs.gnu.org ([2001:4830:134:3::10]:41714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXpvx-0001KN-JA
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:03:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXpvu-0000sG-Hg
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:03:25 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXpvt-0000pu-S3
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:03:22 -0500
Received: by mail-ot1-x343.google.com with SMTP id w25so5806372otm.13
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 08:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
In-Reply-To: <20181213040126.6768-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 16:03:08 +0000
Message-ID: <CAFEAcA_4xV2M0Tgw6KSSQ7DOhv3r=FhETH_Yhmg2h0UT3AYS9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/27] ppc-for-4.0 queue 20181213
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: gkurz@kaod.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Laurent Vivier <lvivier@redhat.com>, spopovyc@redhat.com, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 13 Dec 2018 at 04:01, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 4b3aab204204ca742836219b97b538d90584f4f2:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2018-12-11 22:26:44 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20181213
>
> for you to fetch changes up to 67888a17b6683600ae3fa64ca275c737ba8a9a45:
>
>   spapr/xive: use the VCPU id as a NVT identifier (2018-12-13 09:44:04 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-12-13
>
> Here's the first ppc and spapr pull request for 4.0.  Highlights are:
>
>  * The start of support for the POWER9 "XIVE" interrupt controller
>    (not complete enough to use yet, but we're getting there)
>  * A number of g_new vs. g_malloc cleanups
>  * Some IRQ wiring cleanups
>  * A fix for how we advertise NUMA nodes to the guest for pseries
>
> ---------------------------------------------------------------


Compile errors in the windows cross-build. These look like
they're assumptions that "long" is 64 bits, which it is not on Windows.
For instance the PPC_BIT macro should be using the ULL suffix, not UL
("UL" is almost always a bug: either the constant is 32-bit, in
which case "U" is what you want, or it's 64-bit and you need "ULL").

Using __builtin_ffsl() directly in target/ppc/cpu.h also looks
a bit dubious -- this should be rephrased to use ctz32() or ctz64()
instead.

In file included from /home/petmay01/qemu-for-merges/hw/intc/xive.c:13:0:
/home/petmay01/qemu-for-merges/hw/intc/xive.c: In function 'xive_router_notify':
/home/petmay01/qemu-for-merges/target/ppc/cpu.h:76:33: error: overflow
in implicit constant conversion [-Werror=overflow]
 #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
                                 ^
/home/petmay01/qemu-for-merges/target/ppc/cpu.h:84:50: note: in
definition of macro 'MASK_TO_LSH'
 # define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
                                                  ^
/home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
note: in expansion of macro 'GETFIELD'
 #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
                                  ^
/home/petmay01/qemu-for-merges/hw/intc/xive.c:1366:28: note: in
expansion of macro 'GETFIELD_BE64'
                            GETFIELD_BE64(EAS_END_BLOCK, eas.w),
                            ^
/home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:120:25:
note: in expansion of macro 'PPC_BITMASK'
 #define EAS_END_BLOCK   PPC_BITMASK(4, 7)        /* Destination END block# */
                         ^
/home/petmay01/qemu-for-merges/hw/intc/xive.c:1366:42: note: in
expansion of macro 'EAS_END_BLOCK'
                            GETFIELD_BE64(EAS_END_BLOCK, eas.w),
                                          ^
/home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
shift count is negative [-Werror=shift-count-negative]
 #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
                                              ^
/home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
note: in expansion of macro 'GETFIELD'
 #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
                                  ^
/home/petmay01/qemu-for-merges/hw/intc/xive.c:1366:28: note: in
expansion of macro 'GETFIELD_BE64'
                            GETFIELD_BE64(EAS_END_BLOCK, eas.w),
                            ^
/home/petmay01/qemu-for-merges/target/ppc/cpu.h:76:33: error: overflow
in implicit constant conversion [-Werror=overflow]
 #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
                                 ^
/home/petmay01/qemu-for-merges/target/ppc/cpu.h:84:50: note: in
definition of macro 'MASK_TO_LSH'
 # define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
                                                  ^
/home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
note: in expansion of macro 'GETFIELD'
 #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
                                  ^
/home/petmay01/qemu-for-merges/hw/intc/xive.c:1367:28: note: in
expansion of macro 'GETFIELD_BE64'
                            GETFIELD_BE64(EAS_END_INDEX, eas.w),
                            ^
/home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:121:25:
note: in expansion of macro 'PPC_BITMASK'
 #define EAS_END_INDEX   PPC_BITMASK(8, 31)       /* Destination END index */
                         ^
/home/petmay01/qemu-for-merges/hw/intc/xive.c:1367:42: note: in
expansion of macro 'EAS_END_INDEX'
                            GETFIELD_BE64(EAS_END_INDEX, eas.w),
                                          ^
/home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
shift count is negative [-Werror=shift-count-negative]
 #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
                                              ^
/home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
note: in expansion of macro 'GETFIELD'
 #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
                                  ^
/home/petmay01/qemu-for-merges/hw/intc/xive.c:1367:28: note: in
expansion of macro 'GETFIELD_BE64'
                            GETFIELD_BE64(EAS_END_INDEX, eas.w),
                            ^
/home/petmay01/qemu-for-merges/hw/intc/xive.c: In function
'xive_eas_pic_print_info':
/home/petmay01/qemu-for-merges/target/ppc/cpu.h:76:33: error: overflow
in implicit constant conversion [-Werror=overflow]
 #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
                                 ^
/home/petmay01/qemu-for-merges/target/ppc/cpu.h:84:50: note: in
definition of macro 'MASK_TO_LSH'
 # define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
                                                  ^
/home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
note: in expansion of macro 'GETFIELD'
 #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
                                  ^
/home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:31: note: in
expansion of macro 'GETFIELD_BE64'
                    (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
                               ^
/home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:120:25:
note: in expansion of macro 'PPC_BITMASK'
 #define EAS_END_BLOCK   PPC_BITMASK(4, 7)        /* Destination END block# */
                         ^
/home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:45: note: in
expansion of macro 'EAS_END_BLOCK'
                    (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
                                             ^
/home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
shift count is negative [-Werror=shift-count-negative]
 #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
                                              ^
/home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
note: in expansion of macro 'GETFIELD'
 #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
                                  ^
/home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:31: note: in
expansion of macro 'GETFIELD_BE64'
                    (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
                               ^
/home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:120:25:
note: in expansion of macro 'PPC_BITMASK'
 #define EAS_END_BLOCK   PPC_BITMASK(4, 7)        /* Destination END block# */
                         ^
/home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:45: note: in
expansion of macro 'EAS_END_BLOCK'
                    (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
                                             ^
/home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
shift count is negative [-Werror=shift-count-negative]
 #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
                                              ^
/home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
note: in expansion of macro 'GETFIELD'
 #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
                                  ^
/home/petmay01/qemu-for-merges/hw/intc/xive.c:1400:31: note: in
expansion of macro 'GETFIELD_BE64'
                    (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
                               ^
/home/petmay01/qemu-for-merges/target/ppc/cpu.h:76:33: error: overflow
in implicit constant conversion [-Werror=overflow]
 #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
                                 ^
/home/petmay01/qemu-for-merges/target/ppc/cpu.h:84:50: note: in
definition of macro 'MASK_TO_LSH'
 # define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
                                                  ^
/home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
note: in expansion of macro 'GETFIELD'
 #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
                                  ^
/home/petmay01/qemu-for-merges/hw/intc/xive.c:1401:31: note: in
expansion of macro 'GETFIELD_BE64'
                    (uint32_t) GETFIELD_BE64(EAS_END_INDEX, eas->w),
                               ^
/home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:121:25:
note: in expansion of macro 'PPC_BITMASK'
 #define EAS_END_INDEX   PPC_BITMASK(8, 31)       /* Destination END index */
                         ^
/home/petmay01/qemu-for-merges/hw/intc/xive.c:1401:45: note: in
expansion of macro 'EAS_END_INDEX'
                    (uint32_t) GETFIELD_BE64(EAS_END_INDEX, eas->w),
                                             ^
/home/petmay01/qemu-for-merges/target/ppc/cpu.h:89:46: error: right
shift count is negative [-Werror=shift-count-negative]
 #define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
                                              ^
/home/petmay01/qemu-for-merges/include/hw/ppc/xive_regs.h:129:34:
note: in expansion of macro 'GETFIELD'
 #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
                                  ^
/home/petmay01/qemu-for-merges/hw/intc/xive.c:1401:31: note: in
expansion of macro 'GETFIELD_BE64'
                    (uint32_t) GETFIELD_BE64(EAS_END_INDEX, eas->w),
                               ^


thanks
-- PMM
