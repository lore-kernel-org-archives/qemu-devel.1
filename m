Received: from eggs.gnu.org ([209.51.188.92]:45556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0aXm-0006Gg-0C
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0aXl-0002SW-1j
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:29:17 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h0aXj-0002QV-IW
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:29:15 -0500
Received: by mail-pg1-x541.google.com with SMTP id u9so1670704pgo.7
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 15:29:14 -0800 (PST)
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
	<20190303172343.13406-6-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dac4fce0-f063-5d41-1fc5-66e1eeac3c2c@linaro.org>
Date: Sun, 3 Mar 2019 15:29:10 -0800
MIME-Version: 1.0
In-Reply-To: <20190303172343.13406-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/8] target/ppc: introduce avr_offset()
 function
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
> All TCG vector operations require pointers to the base address of the vector
> rather than separate access to the top and bottom 64-bits. Convert
> the VMX TCG instructions to use a new avr_offset() function instead of
> avr64_offset(), which can itself be written as a simple wrapper onto
> vsr_full_offset().
> 
> After the conversion is complete then avr64_offset() can be removed since its
> functionality is now completely within get_avr64()/set_avr64().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/cpu.h                    | 12 +++++++++++-
>  target/ppc/translate/vmx-impl.inc.c | 27 +++++++++++----------------
>  target/ppc/translate/vsx-impl.inc.c |  5 -----
>  3 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 326593e0e7..89651988ab 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2598,6 +2598,11 @@ static inline int vsrl_offset(int i)
>      return offsetof(CPUPPCState, vsr[i].u64[1]);
>  }
>  
> +static inline int vsr_full_offset(int i)
> +{
> +    return offsetof(CPUPPCState, vsr[i].u64[0]);
> +}
> +
>  static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
>  {
>      return (uint64_t *)((uintptr_t)env + vsrl_offset(i));
> @@ -2613,9 +2618,14 @@ static inline int avrl_offset(int i)
>      return offsetof(CPUPPCState, vsr[32 + i].VsrD(1));
>  }
>  
> +static inline int avr_offset(int i)
> +{
> +    return vsr_full_offset(i + 32);
> +}

avr_full_offset?


r~
