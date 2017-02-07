Received: from eggs.gnu.org ([2001:4830:134:3::10]:47096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cb3WM-0005jH-IX
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 06:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cb3WL-0006sy-Sq
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 06:01:14 -0500
References: <7c016bdc97ed45dc2eb5002db98efcee26c4d8bf.1486437689.git.sam.bobroff@au1.ibm.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b8ffa3b3-375b-9afc-944c-c853114160dd@vivier.eu>
Date: Tue, 7 Feb 2017 12:00:48 +0100
MIME-Version: 1.0
In-Reply-To: <7c016bdc97ed45dc2eb5002db98efcee26c4d8bf.1486437689.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] target-ppc,
 tcg: fix usermode segfault with pthread_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, qemu-ppc@nongnu.org
Cc: benh@kernel.crashing.org, david@gibson.dropbear.id.au, peter.maydell@linaro.org, anibal.limon@linux.intel.com, qemu-devel@nongnu.org

Le 07/02/2017 à 04:21, Sam Bobroff a écrit :
> Programs run under qemu-ppc64 on an x86_64 host currently segfault
> if they use pthread_create() due to the adjustment made to the NIP in
> commit bd6fefe71cec5a0c7d2be4ac96307f25db56abf9.
> 
> This patch changes cpu_loop() to set the NIP back to the
> pre-incremented value before calling do_syscall(), which causes the
> correct address to be used for the new thread and corrects the fault.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
> 
> v2:
> 
> * Remove the NIP adjustment from the -TARGET_QEMU_ESIGRETURN case, it must
> break out with the same NIP as do_syscall().
> 
>  linux-user/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 30049581ef..4ea49f68be 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -1712,10 +1712,12 @@ void cpu_loop(CPUPPCState *env)
>               * in syscalls.
>               */
>              env->crf[0] &= ~0x1;
> +            env->nip += 4;
>              ret = do_syscall(env, env->gpr[0], env->gpr[3], env->gpr[4],
>                               env->gpr[5], env->gpr[6], env->gpr[7],
>                               env->gpr[8], 0, 0);
>              if (ret == -TARGET_ERESTARTSYS) {
> +                env->nip -= 4;
>                  break;
>              }
>              if (ret == (target_ulong)(-TARGET_QEMU_ESIGRETURN)) {
> @@ -1723,7 +1725,6 @@ void cpu_loop(CPUPPCState *env)
>                     Avoid corrupting register state.  */
>                  break;
>              }
> -            env->nip += 4;
>              if (ret > (target_ulong)(-515)) {
>                  env->crf[0] |= 0x1;
>                  ret = -ret;
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
[my comments on previous patch were inaccurate]

Thanks,
Laurent
