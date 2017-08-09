Received: from eggs.gnu.org ([2001:4830:134:3::10]:41340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfQbz-0005o2-1H
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfQbs-0005hH-0I
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:01:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dfQbr-0005eA-NE
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:01:15 -0400
Date: Wed, 9 Aug 2017 15:01:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170809150105.66c970c0.cohuck@redhat.com>
In-Reply-To: <20170721125609.11117-6-david@redhat.com>
References: <20170721125609.11117-1-david@redhat.com>
	<20170721125609.11117-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 5/6] target/s390x: add basic MSA features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, borntraeger@de.ibm.com

On Fri, 21 Jul 2017 14:56:08 +0200
David Hildenbrand <david@redhat.com> wrote:

Finally got around to that one...

> The STFLE bits for the MSA (extension) facilities simply indicate that
> the respective instructions can be executed. The QUERY subfunction can then
> be used to identify which features exactly are available.
> 
> Availability of subfunctions can also vary on real hardware. For now, we
> simply implement a CPU model without any available subfunctions except
> QUERY (which is always around).
> 
> As all MSA functions behave quite similarly, we can use one translation
> handler for now. Prepare the code for implementation of actual subfunctions.

Sounds reasonable.

> 
> At least MSA is helpful for now, as older Linux kernels require this
> facility when compiled for a z9 model. Allow to enable the facilities
> for the qemu cpu model.

Do you remember which kernels?

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/Makefile.objs   |  2 +-
>  target/s390x/cpu_models.c    |  4 +++
>  target/s390x/crypto_helper.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/helper.h        |  1 +
>  target/s390x/insn-data.def   | 13 +++++++++
>  target/s390x/translate.c     | 56 ++++++++++++++++++++++++++++++++++++++
>  6 files changed, 140 insertions(+), 1 deletion(-)
>  create mode 100644 target/s390x/crypto_helper.c
> 
> diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
> index 46f6a8c..9d261ed 100644
> --- a/target/s390x/Makefile.objs
> +++ b/target/s390x/Makefile.objs
> @@ -1,4 +1,4 @@
> -obj-y += translate.o helper.o cpu.o interrupt.o
> +obj-y += translate.o helper.o cpu.o interrupt.o crypto_helper.o
>  obj-y += int_helper.o fpu_helper.o cc_helper.o mem_helper.o misc_helper.o
>  obj-y += gdbstub.o cpu_models.o cpu_features.o
>  obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o mmu_helper.o

This doesn't apply cleanly anymore.

> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 92120f4..45bd920 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -792,6 +792,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
>          S390_FEAT_STFLE,
>          S390_FEAT_EXTENDED_IMMEDIATE,
>          S390_FEAT_EXTENDED_TRANSLATION_2,
> +        S390_FEAT_MSA,
>          S390_FEAT_EXTENDED_TRANSLATION_3,
>          S390_FEAT_LONG_DISPLACEMENT,
>          S390_FEAT_LONG_DISPLACEMENT_FAST,
> @@ -808,6 +809,9 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
>          S390_FEAT_STFLE_49,
>          S390_FEAT_LOCAL_TLB_CLEARING,
>          S390_FEAT_STFLE_53,
> +        S390_FEAT_MSA_EXT_5,
> +        S390_FEAT_MSA_EXT_3,
> +        S390_FEAT_MSA_EXT_4,

I first thought that this looks weird, but it is the actual sequence of
the facility bits (probably the bit for MSA_EXT_5 has been reused?)

>      };
>      int i;
>  
> diff --git a/target/s390x/crypto_helper.c b/target/s390x/crypto_helper.c
> new file mode 100644
> index 0000000..125bd9b
> --- /dev/null
> +++ b/target/s390x/crypto_helper.c
> @@ -0,0 +1,65 @@
> +/*
> + *  s390x crypto helpers
> + *
> + *  Copyright (c) 2017 Red Hat Inc
> + *
> + *  Authors:
> + *   David Hildenbrand <david@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
> +#include "cpu.h"
> +#include "exec/helper-proto.h"
> +#include "exec/exec-all.h"
> +#include "exec/cpu_ldst.h"
> +
> +uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
> +                     uint32_t type)
> +{
> +    const uintptr_t ra = GETPC();
> +    const uint8_t mod = env->regs[0] & 0x80ULL;
> +    const uint8_t fc = env->regs[0] & 0x7fULL;
> +    CPUState *cs = CPU(s390_env_get_cpu(env));
> +    uint8_t subfunc[16] = { 0 };
> +    uint64_t param_addr;
> +    int i;
> +
> +    switch (type) {
> +    case S390_FEAT_TYPE_KMAC:
> +    case S390_FEAT_TYPE_KIMD:
> +    case S390_FEAT_TYPE_KLMD:
> +    case S390_FEAT_TYPE_PCKMO:
> +    case S390_FEAT_TYPE_PCC:
> +        if (mod) {
> +            cpu_restore_state(cs, ra);
> +            program_interrupt(env, PGM_SPECIFICATION, 4);
> +            return 0;
> +        }
> +        break;
> +    }
> +
> +    s390_get_feat_block(type, subfunc);
> +    if (fc >= 128 || !test_be_bit(fc, subfunc)) {
> +        cpu_restore_state(cs, ra);
> +        program_interrupt(env, PGM_SPECIFICATION, 4);
> +        return 0;
> +    }
> +
> +    switch (fc) {
> +    case 0:

A comment which subfunction this is might be helpful.

> +        for (i = 0; i < 16; i++) {
> +            param_addr = wrap_address(env, env->regs[1] + i);

This does not compile for me (after massaging the Makefile above), as
wrap_address does not seem to be exported... can you do a respin,
please?

> +            cpu_stb_data_ra(env, param_addr, subfunc[i], ra);
> +        }
> +        break;
> +    default:
> +        /* we don't implement any other subfunction yet */
> +        g_assert_not_reached();
> +    }
> +
> +    return 0;
> +}
