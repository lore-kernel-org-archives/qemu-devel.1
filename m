Received: from eggs.gnu.org ([208.118.235.92]:53743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gehVE-00012a-Ht
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gehVB-0005Q9-50
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:28:12 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:45810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gehVA-0005Pk-V2
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:28:09 -0500
Received: by mail-wr1-f49.google.com with SMTP id t6so30633833wrr.12
	for <qemu-devel@nongnu.org>; Wed, 02 Jan 2019 06:28:08 -0800 (PST)
References: <20190102141603.3681-1-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c976232a-47a6-966d-4ab9-807e20525e31@redhat.com>
Date: Wed, 2 Jan 2019 15:28:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190102141603.3681-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] cpus: ignore ESRCH in
 qemu_cpu_kick_thread()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On 1/2/19 3:16 PM, Laurent Vivier wrote:
> We can have a race condition between qemu_cpu_kick_thread() and
> qemu_kvm_cpu_thread_fn() when we hotunplug a CPU. In this case,
> qemu_cpu_kick_thread() can try to kick a thread that is exiting.
> pthread_kill() returns an error and qemu is stopped by an exit(1).
> 
>    qemu:qemu_cpu_kick_thread: No such process
> 
> We can ignore safely this error.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  cpus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cpus.c b/cpus.c
> index 0ddeeefc14..4717490bd0 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1778,7 +1778,7 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
>      }
>      cpu->thread_kicked = true;
>      err = pthread_kill(cpu->thread->thread, SIG_IPI);
> -    if (err) {
> +    if (err && err != ESRCH) {
>          fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
>          exit(1);
>      }
> 
