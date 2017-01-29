Received: from eggs.gnu.org ([2001:4830:134:3::10]:43089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cXwEM-0005Oc-ED
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 15:37:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cXwEI-0001fc-Gm
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 15:37:46 -0500
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:33362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cXwEI-0001dy-AQ
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 15:37:42 -0500
Received: by mail-yw0-x242.google.com with SMTP id u68so28195609ywg.0
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 12:37:40 -0800 (PST)
References: <20170127103922.19658-1-alex.bennee@linaro.org>
	<20170127103922.19658-6-alex.bennee@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
In-reply-to: <20170127103922.19658-6-alex.bennee@linaro.org>
Date: Sun, 29 Jan 2017 15:37:38 -0500
Message-ID: <877f5dr4a5.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 05/25] tcg: add options for enabling
 MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>


Alex Bennée writes:

> From: KONRAD Frederic <fred.konrad@greensocs.com>
>
> We know there will be cases where MTTCG won't work until additional work
> is done in the front/back ends to support. It will however be useful to
> be able to turn it on.
>
> As a result MTTCG will default to off unless the combination is
> supported. However the user can turn it on for the sake of testing.
>
> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
> [AJB: move to -accel tcg,thread=multi|single, defaults]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> ---
> v1:
>   - merge with add mttcg option.
>   - update commit message
> v2:
>   - machine_init->opts_init
> v3:
>   - moved from -tcg to -accel tcg,thread=single|multi
>   - fix checkpatch warnings
> v4:
>   - make mttcg_enabled extern, qemu_tcg_mttcg_enabled() now just macro
>   - qemu_tcg_configure now propagates Error instead of exiting
>   - better error checking of thread=foo
>   - use CONFIG flags for default_mttcg_enabled()
>   - disable mttcg with icount, error if both forced on
> v7
>   - explicitly disable MTTCG for TCG_OVERSIZED_GUEST
>   - use check_tcg_memory_orders_compatible() instead of CONFIG_MTTCG_HOST
>   - change CONFIG_MTTCG_TARGET to TARGET_SUPPORTS_MTTCG
> v8
>   - fix missing include tcg.h
>   - change mismatched MOs to a warning instead of error
> ---
>  cpus.c                | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/qom/cpu.h     |  9 +++++++
>  include/sysemu/cpus.h |  2 ++
>  qemu-options.hx       | 20 ++++++++++++++
>  tcg/tcg.h             |  9 +++++++
>  vl.c                  | 49 ++++++++++++++++++++++++++++++++++-
>  6 files changed, 160 insertions(+), 1 deletion(-)
>
> diff --git a/cpus.c b/cpus.c
> index 71a82e5004..76b6e04332 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -25,6 +25,7 @@
>  /* Needed early for CONFIG_BSD etc. */
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> +#include "qemu/config-file.h"
>  #include "cpu.h"
>  #include "monitor/monitor.h"
>  #include "qapi/qmp/qerror.h"
> @@ -45,6 +46,7 @@
>  #include "qemu/main-loop.h"
>  #include "qemu/bitmap.h"
>  #include "qemu/seqlock.h"
> +#include "tcg.h"
>  #include "qapi-event.h"
>  #include "hw/nmi.h"
>  #include "sysemu/replay.h"
> @@ -150,6 +152,76 @@ typedef struct TimersState {
>  } TimersState;
>  
>  static TimersState timers_state;
> +bool mttcg_enabled;
> +
> +/*
> + * We default to false if we know other options have been enabled
> + * which are currently incompatible with MTTCG. Otherwise when each
> + * guest (target) has been updated to support:
> + *   - atomic instructions
> + *   - memory ordering primitives (barriers)
> + * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
> + *
> + * Once a guest architecture has been converted to the new primitives
> + * there are two remaining limitations to check.
> + *
> + * - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
> + * - The host must have a stronger memory order than the guest
> + *
> + * It may be possible in future to support strong guests on weak hosts
> + * but that will require tagging all load/stores in a guest with their
> + * implicit memory order requirements which would likely slow things
> + * down a lot.
> + */
> +
> +static bool check_tcg_memory_orders_compatible(void)
> +{
> +#if defined(TCG_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
> +    return (TCG_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO) == 0;
> +#else
> +    return false;
> +#endif
> +}

This still doesn't look right. It is saying that a host like ARM will be able
to run guests that have a stronger memory model, no?

-- 
Pranith
