Received: from eggs.gnu.org ([2001:4830:134:3::10]:35150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gQEkJ-0001Lv-F1
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:56:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gQEkF-0003B4-CM
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:55:59 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gQEkF-000396-65
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:55:55 -0500
Received: by mail-wr1-x42e.google.com with SMTP id 96so12989824wrb.2
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 08:55:55 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-19-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-19-cota@braap.org>
Date: Fri, 23 Nov 2018 16:55:52 +0000
Message-ID: <87sgzrhgx3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 18/48] tcg: add memory callbacks for plugins
 (WIP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> XXX: store hostaddr from non-i386 TCG backends
> XXX: what hostaddr to return for I/O accesses?
> XXX: what hostaddr to return for cross-page accesses?
>
> Here the trickiest feature is passing the host address to
> memory callbacks that request it. Perhaps it would be more
> appropriate to pass a "physical" address to plugins, but since
> in QEMU host addr ~=3D guest physical, I'm going with that for
> simplicity.
>
> To keep the implementation simple we piggy-back on the TLB fast path,
> and thus can only provide the host address _after_ memory accesses
> have occurred. For the slow path, it's a bit tedious because there
> are many places to update, but it's fairly simple.
>
> However, note that cross-page accesses are tricky, since the
> access might be to non-contiguous host addresses. So I'm punting
> on that and just passing NULL.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/atomic_template.h               |  8 ++++-
>  accel/tcg/softmmu_template.h              | 39 ++++++++++++++++++++
>  include/exec/cpu-defs.h                   |  2 ++
>  include/exec/cpu_ldst_template.h          | 43 +++++++++++++++--------
>  include/exec/cpu_ldst_useronly_template.h | 42 +++++++++++++++-------
>  tcg/tcg-op.h                              |  5 +++
>  tcg/tcg.h                                 |  4 +++
>  tcg/i386/tcg-target.inc.c                 |  5 +++
>  tcg/tcg-op.c                              | 37 ++++++++++++++-----
>  tcg/tcg.c                                 |  3 ++
>  10 files changed, 152 insertions(+), 36 deletions(-)
>
> diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
> index b13318c1ce..3de34dc462 100644
> --- a/accel/tcg/atomic_template.h
> +++ b/accel/tcg/atomic_template.h
> @@ -18,6 +18,7 @@
>   * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
>   */
>
> +#include "qemu/plugin.h"
>  #include "trace/mem.h"
>
>  #if DATA_SIZE =3D=3D 16
> @@ -66,17 +67,22 @@
>      trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info | TRACE_MEM=
_ST); \
>  } while (0)
>
> -# define ATOMIC_TRACE_RMW_POST                                          \
> +# define ATOMIC_TRACE_RMW_POST do {                                     =
       \
> +  qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), addr, haddr, info);         =
       \
> +  qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), addr, haddr, info | TRACE_ME=
M_ST); \
> +} while (0)
>
>  # define ATOMIC_TRACE_LD_PRE                                    \
>      trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info)
>
>  # define ATOMIC_TRACE_LD_POST                                           \
> +    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), addr, haddr, info)
>
>  # define ATOMIC_TRACE_ST_PRE                                    \
>      trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info)
>
>  # define ATOMIC_TRACE_ST_POST                                           \
> +    qemu_plugin_vcpu_mem_cb(ENV_GET_CPU(env), addr, haddr, info)
>
>  #endif /* ATOMIC_TRACE_RMW_PRE */
>
> diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
> index b0adea045e..f6d2f60b81 100644
> --- a/accel/tcg/softmmu_template.h
> +++ b/accel/tcg/softmmu_template.h
> @@ -103,6 +103,11 @@ static inline DATA_TYPE glue(io_read, SUFFIX)(CPUArc=
hState *env,
>                                                MMUAccessType access_type)
>  {
>      CPUIOTLBEntry *iotlbentry =3D &env->iotlb[mmu_idx][index];
> +
> +    /* XXX Any sensible choice other than NULL? */
> +    if (tcg_ctx->plugin_mem_cb) {
> +        env->hostaddr =3D NULL;
> +    }

This is more argument for getting the softmmu de-macrofiction in first.


--
Alex Benn=C3=A9e
