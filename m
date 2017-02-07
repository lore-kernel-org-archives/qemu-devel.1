Received: from eggs.gnu.org ([2001:4830:134:3::10]:47506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cavVP-0000m8-F0
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:27:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cavVN-0004Ky-SK
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:27:43 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:35195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cavVN-0004Kq-Jx
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:27:41 -0500
Received: by mail-ot0-x242.google.com with SMTP id 65so12613466otq.2
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 18:27:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170206153113.27729-6-alex.bennee@linaro.org>
References: <20170206153113.27729-1-alex.bennee@linaro.org>
	<20170206153113.27729-6-alex.bennee@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 6 Feb 2017 21:27:10 -0500
Message-ID: <CAJhHMCDJS31TtUs0z4g5bjZctPG9nV9fBdENgJeD7OrqqvOzcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 05/23] tcg: add options for enabling
 MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, MTTCG Devel <mttcg@listserver.greensocs.com>, qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, alvise rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, nikunj@linux.vnet.ibm.com, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Sergey Fedorov <serge.fdrv@gmail.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Hi Alex,

I just spotted this:

On Mon, Feb 6, 2017 at 10:30 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:

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
> [AJB: move to -accel tcg,thread=3Dmulti|single, defaults]
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> ---
> v1:
>   - merge with add mttcg option.
>   - update commit message
> v2:
>   - machine_init->opts_init
> v3:
>   - moved from -tcg to -accel tcg,thread=3Dsingle|multi
>   - fix checkpatch warnings
> v4:
>   - make mttcg_enabled extern, qemu_tcg_mttcg_enabled() now just macro
>   - qemu_tcg_configure now propagates Error instead of exiting
>   - better error checking of thread=3Dfoo
>   - use CONFIG flags for default_mttcg_enabled()
>   - disable mttcg with icount, error if both forced on
> v7
>   - explicitly disable MTTCG for TCG_OVERSIZED_GUEST
>   - use check_tcg_memory_orders_compatible() instead of CONFIG_MTTCG_HOST
>   - change CONFIG_MTTCG_TARGET to TARGET_SUPPORTS_MTTCG
> v8
>   - fix missing include tcg.h
>   - change mismatched MOs to a warning instead of error
> v10
>   - TCG_DEFAULT_MO -> TCG_GUEST_DEFAULT_MO
> ---
>  cpus.c                | 72 ++++++++++++++++++++++++++++++
> +++++++++++++++++++++
>  include/qom/cpu.h     |  9 +++++++
>  include/sysemu/cpus.h |  2 ++
>  qemu-options.hx       | 20 ++++++++++++++
>  tcg/tcg.h             |  9 +++++++
>  vl.c                  | 49 ++++++++++++++++++++++++++++++++++-
>  6 files changed, 160 insertions(+), 1 deletion(-)
>
> diff --git a/cpus.c b/cpus.c
> index 71a82e5004..6a7e5a50d8 100644
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
> +#if defined(TCG_GUEST_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
> +    return (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO) =3D=3D 0;
> +#else
> +    return false;
> +#endif
> +}
> +
> +static bool default_mttcg_enabled(void)
> +{
> +    QemuOpts *icount_opts =3D qemu_find_opts_singleton("icount");
> +    const char *rr =3D qemu_opt_get(icount_opts, "rr");
> +
> +    if (rr || TCG_OVERSIZED_GUEST) {
> +        return false;
> +    } else {
> +#ifdef TARGET_SUPPORTS_MTTCG
> +        return check_tcg_memory_orders_compatible();
> +#else
> +        return false;
> +#endif
> +    }
> +}
> +
> +void qemu_tcg_configure(QemuOpts *opts, Error **errp)
> +{
> +    const char *t =3D qemu_opt_get(opts, "thread");
> +    if (t) {
> +        if (strcmp(t, "multi") =3D=3D 0) {
> +            if (TCG_OVERSIZED_GUEST) {
> +                error_setg(errp, "No MTTCG when guest word size > hosts"=
);
> +            } else {
> +                if (!check_tcg_memory_orders_compatible()) {
> +                    error_report("Guest requires stronger MO that host")=
;
>

s/MO that host/MO than host/?

Also, this message is a bit cryptic for end users. How about saying "Guest
and host architectures are incompatible, you may encounter errors!" or
something similar?

Thanks,
--=20
Pranith
