Received: from eggs.gnu.org ([2001:4830:134:3::10]:57604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7dsq-0001SK-UJ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7dsm-0001hA-UY
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:55:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7dsm-0001gw-NP
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:55:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id 143-v6so5055479wmf.1
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 02:55:52 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-13-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <35235ad8-c104-05a9-3f9e-677a743b73e2@redhat.com>
Date: Wed, 3 Oct 2018 11:55:49 +0200
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 12/13] target/arm: Add v8M stack checks for
 VLDM/VSTM
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
> Add the v8M stack checks for the VLDM/VSTM
> (aka VPUSH/VPOP) instructions. This code is currently
> unreachable because we haven't yet implemented M profile
> floating point support, but since the change is simple,
> we add it now because otherwise we're likely to forget to
> do it later.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index ef64d2559de..2d3a1be518b 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -4229,6 +4229,18 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
>                  if (insn & (1 << 24)) /* pre-decrement */
>                      tcg_gen_addi_i32(addr, addr, -((insn & 0xff) << 2));
>  
> +                if (rn == 13 && w && s->v8m_stackcheck) {

Following previous patches style:

                   if (s->v8m_stackcheck && rn == 13 && w) {

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +                    /*
> +                     * Here 'addr' is the lowest address we will store to,
> +                     * and is either the old SP (if post-increment) or
> +                     * the new SP (if pre-decrement). For post-increment
> +                     * where the old value is below the limit and the new
> +                     * value is above, it is UNKNOWN whether the limit check
> +                     * triggers; we choose to trigger.
> +                     */
> +                    gen_helper_v8m_stackcheck(cpu_env, addr);
> +                }
> +
>                  if (dp)
>                      offset = 8;
>                  else
> 
