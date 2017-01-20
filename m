Received: from eggs.gnu.org ([2001:4830:134:3::10]:56818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cUMlB-0006IN-P8
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 19:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cUMlA-0004Rj-Tv
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 19:08:53 -0500
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-27-alex.bennee@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
In-reply-to: <20170119170507.16185-27-alex.bennee@linaro.org>
Date: Thu, 19 Jan 2017 19:08:44 -0500
Message-ID: <87a8amr3sj.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 26/27] tcg: enable MTTCG by default for
 ARM on x86 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, "open list:ARM" <qemu-arm@nongnu.org>


Alex Bennée writes:

> This enables the multi-threaded system emulation by default for ARMv7
> and ARMv8 guests using the x86_64 TCG backend. This is because on the
> guest side:
>
>   - The ARM translate.c/translate-64.c have been converted to
>     - use MTTCG safe atomic primitives
>     - emit the appropriate barrier ops
>   - The ARM machine has been updated to
>     - hold the BQL when modifying shared cross-vCPU state
>     - defer cpu_reset to async safe work
>
> All the host backends support the barrier and atomic primitives but
> need to provide same-or-better support for normal load/store
> operations.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

<snip>

>
> +/* This defines the natural memory order supported by this
> + * architecture before guarantees made by various barrier
> + * instructions.
> + *
> + * The x86 has a pretty strong memory ordering which only really
> + * allows for some stores to be re-ordered after loads.
> + */
> +#include "tcg-mo.h"
> +
> +static inline int get_tcg_target_mo(void)
> +{
> +    return TCG_MO_ALL & ~TCG_MO_LD_ST;
> +}
> +

Shouldn't this be TCG_MO_ALL & ~TCG_MO_ST_LD?

Thanks,
-- 
Pranith
