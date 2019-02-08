Received: from eggs.gnu.org ([209.51.188.92]:38364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs4Ph-0000dk-D9
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs4Pd-0006DT-Q3
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:33:44 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gs4PX-00069k-OT
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:33:39 -0500
Received: by mail-wr1-x444.google.com with SMTP id q18so3170546wrx.9
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 03:33:35 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-63-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190130004811.27372-63-cota@braap.org>
Date: Fri, 08 Feb 2019 11:33:32 +0000
Message-ID: <877eeams4z.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 62/73] cpu: introduce
 cpu_has_work_with_iothread_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> It will gain some users soon.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h | 36 +++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 96a5d0cb94..27a80bc113 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -27,6 +27,7 @@
>  #include "qapi/qapi-types-run-state.h"
>  #include "qemu/bitmap.h"
>  #include "qemu/fprintf-fn.h"
> +#include "qemu/main-loop.h"
>  #include "qemu/rcu_queue.h"
>  #include "qemu/queue.h"
>  #include "qemu/thread.h"
> @@ -87,6 +88,8 @@ struct TranslationBlock;
>   * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
>   * @has_work: Callback for checking if there is work to do. Called with =
the
>   * CPU lock held.
> + * @has_work_with_iothread_lock: Callback for checking if there is work =
to do.
> + * Called with both the BQL and the CPU lock held.
>   * @do_interrupt: Callback for interrupt handling.
>   * @do_unassigned_access: Callback for unassigned access handling.
>   * (this is deprecated: new targets should use do_transaction_failed ins=
tead)
> @@ -158,6 +161,7 @@ typedef struct CPUClass {
>      void (*reset)(CPUState *cpu);
>      int reset_dump_flags;
>      bool (*has_work)(CPUState *cpu);
> +    bool (*has_work_with_iothread_lock)(CPUState *cpu);
>      void (*do_interrupt)(CPUState *cpu);
>      CPUUnassignedAccess do_unassigned_access;
>      void (*do_unaligned_access)(CPUState *cpu, vaddr addr,
> @@ -796,14 +800,40 @@ const char *parse_cpu_model(const char *cpu_model);
>  static inline bool cpu_has_work(CPUState *cpu)
>  {
>      CPUClass *cc =3D CPU_GET_CLASS(cpu);
> +    bool has_cpu_lock =3D cpu_mutex_locked(cpu);
> +    bool (*func)(CPUState *cpu);
>      bool ret;
>
> +    if (cc->has_work_with_iothread_lock) {
> +        if (qemu_mutex_iothread_locked()) {
> +            func =3D cc->has_work_with_iothread_lock;
> +            goto call_func;
> +        }
> +
> +        if (has_cpu_lock) {
> +            /* avoid deadlock by acquiring the locks in order */

This is fine here but can we expand the comment above:

 * cpu_has_work:
 * @cpu: The vCPU to check.
 *
 * Checks whether the CPU has work to do. If the vCPU helper needs to
 * check it's work status with the BQL held ensure we hold the BQL
 * before taking the CPU lock.

Where is our canonical description of the locking interaction between
BQL and CPU locks?

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> +            cpu_mutex_unlock(cpu);
> +        }
> +        qemu_mutex_lock_iothread();
> +        cpu_mutex_lock(cpu);
> +
> +        ret =3D cc->has_work_with_iothread_lock(cpu);
> +
> +        qemu_mutex_unlock_iothread();
> +        if (!has_cpu_lock) {
> +            cpu_mutex_unlock(cpu);
> +        }
> +        return ret;
> +    }
> +
>      g_assert(cc->has_work);
> -    if (cpu_mutex_locked(cpu)) {
> -        return cc->has_work(cpu);
> +    func =3D cc->has_work;
> + call_func:
> +    if (has_cpu_lock) {
> +        return func(cpu);
>      }
>      cpu_mutex_lock(cpu);
> -    ret =3D cc->has_work(cpu);
> +    ret =3D func(cpu);
>      cpu_mutex_unlock(cpu);
>      return ret;
>  }


--
Alex Benn=C3=A9e
