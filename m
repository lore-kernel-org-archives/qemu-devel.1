Received: from eggs.gnu.org ([209.51.188.92]:45898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0aZs-0007F8-9R
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0aZo-0003Vt-PT
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:31:26 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h0aZk-0003PS-Q8
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:31:21 -0500
Received: by mail-pf1-x443.google.com with SMTP id n74so1602644pfi.9
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 15:31:18 -0800 (PST)
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
	<20190303172343.13406-5-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a6832b4d-f6ae-e783-f3df-68d702eb18ef@linaro.org>
Date: Sun, 3 Mar 2019 15:31:14 -0800
MIME-Version: 1.0
In-Reply-To: <20190303172343.13406-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/8] target/ppc: introduce avrh_offset()
 and avrl_offset() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 3/3/19 9:23 AM, Mark Cave-Ayland wrote:
> These will become more useful later, but initially use this as an aid to
> simplify the offset calculation by replacing the HOST_TARGET_BIGENDIAN
> sections with the VsrD macro.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/cpu.h       | 10 ++++++++++
>  target/ppc/translate.c | 24 ++++++++++--------------
>  2 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index d0580c6b6d..326593e0e7 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2603,6 +2603,16 @@ static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
>      return (uint64_t *)((uintptr_t)env + vsrl_offset(i));
>  }
>  
> +static inline int avrh_offset(int i)
> +{
> +    return offsetof(CPUPPCState, vsr[32 + i].VsrD(0));
> +}
> +
> +static inline int avrl_offset(int i)
> +{
> +    return offsetof(CPUPPCState, vsr[32 + i].VsrD(1));
> +}

I really don't see the point of these...

>  static inline void get_avr64(TCGv_i64 dst, int regno, bool high)
>  {
> -#ifdef HOST_WORDS_BIGENDIAN
> -    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState,
> -                                          vsr[32 + regno].u64[(high ? 0 : 1)]));
> -#else
> -    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState,
> -                                          vsr[32 + regno].u64[(high ? 1 : 0)]));
> -#endif
> +    if (high) {
> +        tcg_gen_ld_i64(dst, cpu_env, avrh_offset(regno));
> +    } else {
> +        tcg_gen_ld_i64(dst, cpu_env, avrl_offset(regno));
> +    }

When you could just as well write this as

  tcg_gen_ld_i64(dst, cpu_env,
    offsetof(CPUPPCState, vsr[32+regno].VsrD(high)));


r~
