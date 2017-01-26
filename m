Received: from eggs.gnu.org ([2001:4830:134:3::10]:56079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWjhT-0000Km-3b
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWjhP-0006mK-T3
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:02:51 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cWjhP-0006ly-Mh
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:02:47 -0500
Received: by mail-wm0-x243.google.com with SMTP id c85so50170024wmi.1
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 05:02:47 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170126123411.5412.44769.stgit@PASHA-ISP>
	<20170126123423.5412.2388.stgit@PASHA-ISP>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <06b49612-9faf-5933-d8e9-8645a2fcde4d@redhat.com>
Date: Thu, 26 Jan 2017 14:02:45 +0100
MIME-Version: 1.0
In-Reply-To: <20170126123423.5412.2388.stgit@PASHA-ISP>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 2/9] icount: exit cpu loop on expire
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, kraxel@redhat.com



On 26/01/2017 13:34, Pavel Dovgalyuk wrote:
> This patch adds check to break cpu loop when icount expires without
> setting the TB_EXIT_ICOUNT_EXPIRED flag. It happens when there is no
> available translated blocks and all instructions were executed.
> In icount replay mode unnecessary tb_find will be called (which may
> cause an exception) and execution will be non-deterministic.
> 
> v8: refactored loop exit code and moved it to separate function
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  cpu-exec.c |   24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/cpu-exec.c b/cpu-exec.c
> index fa08c73..f9b8ec8 100644
> --- a/cpu-exec.c
> +++ b/cpu-exec.c
> @@ -523,9 +523,25 @@ static inline void cpu_handle_interrupt(CPUState *cpu,
>              *last_tb = NULL;
>          }
>      }
> -    if (unlikely(atomic_read(&cpu->exit_request) || replay_has_interrupt())) {
> +}
> +
> +
> +static void cpu_check_loop_exit(CPUState *cpu)
> +{
> +    if (unlikely(atomic_read(&cpu->exit_request)
> +        /* icount has expired, we need to break the execution loop.
> +           This check is needed before tb_find to make execution
> +           deterministic - tb_find may cause an exception
> +           while translating the code from non-mapped page. */
> +        || (use_icount && ((cpu->icount_extra == 0
> +                        && cpu->icount_decr.u16.low == 0)
> +                    || (int32_t)cpu->icount_decr.u32 < 0)))) {

Simpler:

	use_icount &&
	((int32_t)cpu->icount_decr.u32 < 0 ||
	 cpu->icount_decr.low + cpu->icount_extra == 0)

But I'm not sure that you need to test u32.  After all you're not
testing tcg_exit_req, which is the equivalent when icount is disabled.

>          atomic_set(&cpu->exit_request, 0);
> -        cpu->exception_index = EXCP_INTERRUPT;
> +        /* If there is an exception that wasn't replayed yet,
> +           don't change exception_index. */
> +        if (cpu->exception_index == -1) {
> +            cpu->exception_index = EXCP_INTERRUPT;
> +        }
>          cpu_loop_exit(cpu);

The siglongjmp is effectively the same as exiting the for(;;) loop of
cpu_exec and going back to cpu_handle_exception.  So I would just merge
this with cpu_handle_interrupt, which exits a lot with cpu_loop_exit too.

All cpu_loop_exit() calls in cpu_handle_interrupt become "return true",
similar to cpu_handle_exception, and then in cpu_exec you have:

            /* if an exception is pending, we execute it here */
            while (!cpu_handle_exception(cpu, &ret)) {
                /* if an interrupt is pending, inject it and go back
                 * to cpu_handle_exception.
                 */
                while (!cpu_handle_interrupt(cpu, &last_tb)) {
                    tb = tb_find(cpu, last_tb, tb_exit);
                    cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
                    /* Try to align the host and virtual clocks
                       if the guest is in advance */
                    align_clocks(&sc, cpu);
                }
            }
            break;



>  #endif
> @@ -634,6 +647,7 @@ int cpu_exec(CPUState *cpu)
>  
>              for(;;) {
>                  cpu_handle_interrupt(cpu, &last_tb);
> +                cpu_check_loop_exit(cpu);


	if (cpu_should_check_exception_or_exit(cpu)) {
	    break;
	}


>                  tb = tb_find(cpu, last_tb, tb_exit);
>                  cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
>                  /* Try to align the host and virtual clocks
> 
> 
> 
