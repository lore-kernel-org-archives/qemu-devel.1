Received: from eggs.gnu.org ([2001:4830:134:3::10]:34168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7eEb-00047i-AV
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7eEX-0003qe-9n
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:18:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7eEX-0003po-3N
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:18:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id z3-v6so5446300wrr.13
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 03:18:19 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-14-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6516f5a5-449c-1d49-a4f0-241f49f16b61@redhat.com>
Date: Wed, 3 Oct 2018 12:18:17 +0200
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 13/13] target/arm: Add v8M stack checks for
 MSR to SP_NS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 02/10/2018 18:35, Peter Maydell wrote:
> Updating the NS stack pointer via MSR to SP_NS should include
> a check whether the new SP value is below the stack limit.
> No other kinds of update to the various stack pointer and
> limit registers via MSR should perform a check.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/arm/helper.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 074f7616272..712828674fa 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -10963,11 +10963,23 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
>               * currently in handler mode or not, using the NS CONTROL.SPSEL.
>               */
>              bool spsel = env->v7m.control[M_REG_NS] & R_V7M_CONTROL_SPSEL_MASK;
> +            bool is_psp = !arm_v7m_is_handler_mode(env) && spsel;
> +            uint32_t limit;
>  
>              if (!env->v7m.secure) {
>                  return;
>              }
> -            if (!arm_v7m_is_handler_mode(env) && spsel) {
> +
> +            limit = is_psp ? env->v7m.psplim[false] : env->v7m.msplim[false];
> +
> +            if (val < limit) {
> +                CPUState *cs = CPU(arm_env_get_cpu(env));
> +
> +                cpu_restore_state(cs, GETPC(), true);
> +                raise_exception(env, EXCP_STKOF, 0, 1);
> +            }
> +
> +            if (is_psp) {
>                  env->v7m.other_ss_psp = val;
>              } else {
>                  env->v7m.other_ss_msp = val;
> 
