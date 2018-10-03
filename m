Received: from eggs.gnu.org ([2001:4830:134:3::10]:41599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7erB-0008Ig-CR
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:58:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7edm-0000vD-MI
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:44:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7edl-0000uM-Qv
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:44:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id 193-v6so5106869wme.3
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 03:44:24 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-11-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dd541478-05e2-fcc3-98d8-0f4cb9f126f3@redhat.com>
Date: Wed, 3 Oct 2018 12:44:22 +0200
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/13] target/arm: Add v8M stack checks for
 T32 load/store single
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
> Add v8M stack checks for the instructions in the T32
> "load/store single" encoding class: these are the
> "immediate pre-indexed" and "immediate, post-indexed"
> LDR and STR instructions.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 3fb378a492d..65df8d6975c 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -11624,7 +11624,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>                      imm = -imm;
>                      /* Fall through.  */
>                  case 0xf: /* Pre-increment.  */
> -                    tcg_gen_addi_i32(addr, addr, imm);
>                      writeback = 1;
>                      break;
>                  default:
> @@ -11636,6 +11635,28 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>  
>          issinfo = writeback ? ISSInvalid : rs;
>  
> +        if (s->v8m_stackcheck && rn == 13 && writeback) {
> +            /*
> +             * Stackcheck. Here we know 'addr' is the current SP;
> +             * if imm is +ve we're moving SP up, else down. It is

TIL +ve is a short form for positive, and -ve for negative.

> +             * UNKNOWN whether the limit check triggers when SP starts
> +             * below the limit and ends up above it; we chose to do so.
> +             */
> +            if ((int32_t)imm < 0) {
> +                TCGv_i32 newsp = tcg_temp_new_i32();
> +
> +                tcg_gen_addi_i32(newsp, addr, imm);
> +                gen_helper_v8m_stackcheck(cpu_env, newsp);
> +                tcg_temp_free_i32(newsp);
> +            } else {
> +                gen_helper_v8m_stackcheck(cpu_env, addr);
> +            }
> +        }
> +
> +        if (writeback && !postinc) {
> +            tcg_gen_addi_i32(addr, addr, imm);
> +        }
> +
>          if (insn & (1 << 20)) {
>              /* Load.  */
>              tmp = tcg_temp_new_i32();
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
