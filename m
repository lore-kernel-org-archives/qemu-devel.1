Received: from eggs.gnu.org ([2001:4830:134:3::10]:33694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDMuL-0006DS-86
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDMu5-0004LX-1U
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:01:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDMu2-0004AY-Ca
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:00:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id 63-v6so35900589wra.11
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 22:00:49 -0700 (PDT)
References: <20181019015617.22583-1-richard.henderson@linaro.org>
	<20181019015617.22583-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6cc16bbf-8353-547e-3fe1-5adfced7e53a@redhat.com>
Date: Fri, 19 Oct 2018 07:00:45 +0200
MIME-Version: 1.0
In-Reply-To: <20181019015617.22583-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] target/arm: Only flush tlb if ASID
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 19/10/2018 03:56, Richard Henderson wrote:
> Since QEMU does not implement ASIDs, changes to the ASID must flush the
> tlb.  However, if the ASID does not change there is no reason to flush.
> 
> In testing a boot of the Ubuntu installer to the first menu, this reduces
> the number of flushes by 30%, or nearly 600k instances.
> 
> Reviewed-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/arm/helper.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 24bbde4f76..ed70ac645e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2709,12 +2709,10 @@ static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                              uint64_t value)
>  {
> -    /* 64 bit accesses to the TTBRs can change the ASID and so we
> -     * must flush the TLB.
> -     */
> -    if (cpreg_field_is_64bit(ri)) {
> +    /* If the ASID changes (with a 64-bit write), we must flush the TLB.  */
> +    if (cpreg_field_is_64bit(ri) &&
> +        extract64(raw_read(env, ri) ^ value, 48, 16) != 0) {
>          ARMCPU *cpu = arm_env_get_cpu(env);
> -
>          tlb_flush(CPU(cpu));
>      }
>      raw_write(env, ri, value);
> 
