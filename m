Received: from eggs.gnu.org ([2001:4830:134:3::10]:43162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtFI-000466-Vj
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtFA-0004eZ-Mj
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:21:24 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtF5-0004bm-DY
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:21:19 -0400
Received: by mail-wr1-x444.google.com with SMTP id j26-v6so2993044wre.1
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:21:14 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-30-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-30-cota@braap.org>
Date: Wed, 31 Oct 2018 16:21:11 +0000
Message-ID: <87sh0m6qa0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 30/71] cpu: define cpu_interrupt_request
 helpers
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

> Add a comment about how atomic_read works here. The comment refers to
> a "BQL-less CPU loop", which will materialize toward the end
> of this series.
>
> Note that the modifications to cpu_reset_interrupt are there to
> avoid deadlock during the CPU lock transition; once that is complete,
> cpu_interrupt_request will be simple again.
>
<snip>
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -98,14 +98,29 @@ static void cpu_common_get_memory_mapping(CPUState *c=
pu,
>   * BQL here if we need to.  cpu_interrupt assumes it is held.*/
>  void cpu_reset_interrupt(CPUState *cpu, int mask)
>  {
> -    bool need_lock =3D !qemu_mutex_iothread_locked();
> +    bool has_bql =3D qemu_mutex_iothread_locked();
> +    bool has_cpu_lock =3D cpu_mutex_locked(cpu);
>
> -    if (need_lock) {
> -        qemu_mutex_lock_iothread();
> +    if (has_bql) {
> +        if (has_cpu_lock) {
> +            atomic_set(&cpu->interrupt_request, cpu->interrupt_request &=
 ~mask);
> +        } else {
> +            cpu_mutex_lock(cpu);
> +            atomic_set(&cpu->interrupt_request, cpu->interrupt_request &=
 ~mask);
> +            cpu_mutex_unlock(cpu);
> +        }
> +        return;
> +    }
> +
> +    if (has_cpu_lock) {
> +        cpu_mutex_unlock(cpu);
>      }
> -    cpu->interrupt_request &=3D ~mask;
> -    if (need_lock) {
> -        qemu_mutex_unlock_iothread();
> +    qemu_mutex_lock_iothread();
> +    cpu_mutex_lock(cpu);
> +    atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
> +    qemu_mutex_unlock_iothread();
> +    if (!has_cpu_lock) {
> +        cpu_mutex_unlock(cpu);
>      }
>  }

Yeah I can see this is pretty ugly but cleaned up by the end of the
series. If it's the same sequence as the previous patch I wonder if it's
possible to hide the ugliness in a common helper while we transition?

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
