Received: from eggs.gnu.org ([2001:4830:134:3::10]:40227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gQEyq-0006mI-1A
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 12:11:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gQEym-00009o-Vp
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 12:11:00 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gQEym-00007Q-Pw
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 12:10:56 -0500
Received: by mail-wr1-x441.google.com with SMTP id 96so13031034wrb.2
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 09:10:56 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-23-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-23-cota@braap.org>
Date: Fri, 23 Nov 2018 17:10:53 +0000
Message-ID: <87mupzhg82.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 22/48] cpu: hook plugin vcpu events
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

> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  cpus.c    | 10 ++++++++++
>  exec.c    |  2 ++
>  qom/cpu.c |  2 ++
>  3 files changed, 14 insertions(+)
>
> diff --git a/cpus.c b/cpus.c
> index 28e39f045a..3efe89354d 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -43,6 +43,7 @@
>  #include "exec/exec-all.h"
>
>  #include "qemu/thread.h"
> +#include "qemu/plugin.h"
>  #include "sysemu/cpus.h"
>  #include "sysemu/qtest.h"
>  #include "qemu/main-loop.h"
> @@ -1322,12 +1323,21 @@ static void qemu_tcg_rr_wait_io_event(CPUState *c=
pu)
>
>  static void qemu_wait_io_event(CPUState *cpu)
>  {
> +    bool asleep =3D false;
> +

slept?

>      g_assert(cpu_mutex_locked(cpu));
>      g_assert(!qemu_mutex_iothread_locked());
>
>      while (cpu_thread_is_idle(cpu)) {
> +        if (!asleep) {
> +            asleep =3D true;
> +            qemu_plugin_vcpu_idle_cb(cpu);
> +        }
>          qemu_cond_wait(&cpu->halt_cond, &cpu->lock);
>      }
> +    if (asleep) {
> +        qemu_plugin_vcpu_resume_cb(cpu);
> +    }

I wonder if having two hooks is too much? What might a plugin want to do
before we go into idle sleep?

It feels like we are exposing too much of the guts of TCG to the plugin
here as wait_io could be for any number of internal reasons other than
the actual emulation blocking for IO through a WFI or something. If a
plugin really wants to track such things shouldn't it be hooking to the
guest sleep points?

If idle sleeps really are that important maybe we could just report our
sleep time on resume - so a single hook but passing a bit more
information?

>
>  #ifdef _WIN32
>      /* Eat dummy APC queued by qemu_cpu_kick_thread.  */
> diff --git a/exec.c b/exec.c
> index cd171adb93..71fc76f55e 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -967,6 +967,8 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
>      }
>      tlb_init(cpu);
>
> +    qemu_plugin_vcpu_init_hook(cpu);
> +
>  #ifndef CONFIG_USER_ONLY
>      if (qdev_get_vmsd(DEVICE(cpu)) =3D=3D NULL) {
>          vmstate_register(NULL, cpu->cpu_index, &vmstate_cpu_common, cpu);
> diff --git a/qom/cpu.c b/qom/cpu.c
> index d1e6ecae03..062817c03b 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -32,6 +32,7 @@
>  #include "hw/boards.h"
>  #include "hw/qdev-properties.h"
>  #include "trace-root.h"
> +#include "qemu/plugin.h"
>
>  CPUInterruptHandler cpu_interrupt_handler;
>
> @@ -353,6 +354,7 @@ static void cpu_common_unrealizefn(DeviceState *dev, =
Error **errp)
>      CPUState *cpu =3D CPU(dev);
>      /* NOTE: latest generic point before the cpu is fully unrealized */
>      trace_fini_vcpu(cpu);
> +    qemu_plugin_vcpu_exit_hook(cpu);
>      cpu_exec_unrealizefn(cpu);
>  }


--
Alex Benn=C3=A9e
