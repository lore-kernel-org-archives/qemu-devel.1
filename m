Received: from eggs.gnu.org ([209.51.188.92]:41654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hBL1K-0000rY-Ds
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hBL1F-000311-Fx
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:08:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hBL1F-00030L-5c
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:08:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so17116198wrq.8
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 08:08:09 -0700 (PDT)
References: <1554207110-9113-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554207110-9113-2-git-send-email-mateja.marjanovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8dd10edf-a799-1c3b-2421-601d91eff0ac@redhat.com>
Date: Tue, 2 Apr 2019 17:08:06 +0200
MIME-Version: 1.0
In-Reply-To: <1554207110-9113-2-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] target/mips: Make the results of
 DIV_<U|S>.<B|H|W|D> the same as on hardware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, Richard Henderson <rth@twiddle.net>, aurelien@aurel32.net

Hi Mateja,

On 4/2/19 2:11 PM, Mateja Marjanovic wrote:
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
> 
> MSA instructions DIV_<U|S>.<B|H|W|D> when dividing by zero,
> didn't return the same value when executed on a referent hardware
> (FPGA MIPS 64 r6, little endian) and when executed on QEMU, which
> is not a real bug, because the result when dividing by zero is
> UNPREDICTABLE [1] (page 141, 142).

I'm surprised by the arch, I'd have expected a MSA floating point
exception instead of UNPREDICTABLE.

So here we decide to follow the FPGA model behavior rather than the
architecture...
If the community agree, my only request is to add a comment in the code
that this is the "FPGA MIPS 64 r6" behavior (else while looking at this
code later I'd be tempted to revert to a 0 return value instead of -1/1).

> 
> [1] MIPS Architecture for Programmers
>     Volume IV-j: The MIPS64 SIMD
>     Architecture Module, Revision 1.12
> 
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---
>  target/mips/msa_helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index 655148d..8c77f12 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -641,14 +641,15 @@ static inline int64_t msa_div_s_df(uint32_t df, int64_t arg1, int64_t arg2)
>      if (arg1 == DF_MIN_INT(df) && arg2 == -1) {
>          return DF_MIN_INT(df);
>      }
> -    return arg2 ? arg1 / arg2 : 0;
> +    return arg2 ? arg1 / arg2
> +                : arg1 >= 0 ? -1 : 1;
>  }
>  
>  static inline int64_t msa_div_u_df(uint32_t df, int64_t arg1, int64_t arg2)
>  {
>      uint64_t u_arg1 = UNSIGNED(arg1, df);
>      uint64_t u_arg2 = UNSIGNED(arg2, df);
> -    return u_arg2 ? u_arg1 / u_arg2 : 0;
> +    return arg2 ? u_arg1 / u_arg2 : -1;
>  }
>  
>  static inline int64_t msa_mod_s_df(uint32_t df, int64_t arg1, int64_t arg2)
> 
