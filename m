Received: from eggs.gnu.org ([2001:4830:134:3::10]:46652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFx5-0001cP-6B
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFx2-0001L2-23
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:01:23 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXFx1-0001Kb-U1
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:01:20 -0400
Received: by mail-qt0-x244.google.com with SMTP id l55so645090qtl.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:01:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-23-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <beca7dc0-8206-47bf-0f23-577b45835e78@twiddle.net>
Date: Mon, 17 Jul 2017 14:01:13 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-23-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 22/45] cpu-exec: lookup/generate TB
 outside exclusive region during step_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/16/2017 10:04 AM, Emilio G. Cota wrote:
> Now that all code generation has been converted to check CF_PARALLEL, we can
> generate !CF_PARALLEL code without having yet set !parallel_cpus --
> and therefore without having to be in the exclusive region during
> cpu_exec_step_atomic.
> 
> While at it, merge cpu_exec_step into cpu_exec_step_atomic.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>   accel/tcg/cpu-exec.c | 26 ++++++++++++--------------
>   1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index efe5c85..23e6d2c 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -226,7 +226,7 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
>   }
>   #endif
>   
> -static void cpu_exec_step(CPUState *cpu)
> +void cpu_exec_step_atomic(CPUState *cpu)
>   {
>       CPUClass *cc = CPU_GET_CLASS(cpu);
>       TranslationBlock *tb;
> @@ -239,16 +239,26 @@ static void cpu_exec_step(CPUState *cpu)
>           if (tb == NULL) {
>               mmap_lock();
>               tb_lock();
> -            tb = tb_gen_code(cpu, pc, cs_base, flags, cflags);
> +            tb = tb_htable_lookup(cpu, pc, cs_base, flags, mask_cf(cflags));
> +            if (likely(tb == NULL)) {
> +                tb = tb_gen_code(cpu, pc, cs_base, flags, cflags);
> +            }
>               tb_unlock();
>               mmap_unlock();
>           }
>   
> +        start_exclusive();
> +
> +        /* Since we got here, we know that parallel_cpus must be true.  */
> +        parallel_cpus = false;

Well, since we've moved parallel_cpus completely out of target/*, we no longer 
have to set this false, right?

I wonder how hard it would be to completely hide this variable now...
That said, even that would probably be better as a follow-on cleanup.

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
