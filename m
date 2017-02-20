Received: from eggs.gnu.org ([2001:4830:134:3::10]:50154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cfthk-0008Sm-Hk
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:33:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cfthh-0004rg-9U
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:33:00 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487585521-19445-3-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6227dda7-460d-443b-2e59-0e2c2e14c53f@twiddle.net>
Date: Tue, 21 Feb 2017 06:32:49 +1100
MIME-Version: 1.0
In-Reply-To: <1487585521-19445-3-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 02/10] target/ppc: Update ca32 in
 arithmetic add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 02/20/2017 09:11 PM, Nikunj A Dadhania wrote:
> Adds routine to compute ca32 - gen_op_arith_compute_ca32
>
> For 64-bit mode use the compute ca32 routine. While for 32-bit mode, CA
> and CA32 will have same value.
>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target/ppc/translate.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 498b095..2a2d071 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -816,6 +816,36 @@ static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
>      tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
>  }
>
> +static inline void gen_op_arith_compute_ca32(DisasContext *ctx, TCGv arg0,
> +                                             TCGv arg1, bool add_ca, int sub)
> +{
> +    TCGv t0 = tcg_temp_new();
> +    TCGv t1 = tcg_temp_new();
> +    TCGv inv0 = tcg_temp_new();
> +
> +    tcg_gen_extract_tl(t0, arg0, 0, 32);
> +    tcg_gen_extract_tl(t1, arg1, 0, 32);
> +    if (sub) {
> +        tcg_gen_not_tl(inv0, t0);
> +        if (add_ca) {
> +            tcg_gen_add_tl(t1, t1, cpu_ca32);
> +        } else {
> +            tcg_gen_addi_tl(t1, t1, 1);
> +        }
> +        tcg_gen_add_tl(t0, t1, inv0);
> +        tcg_gen_extract_tl(cpu_ca32, t0, 32, 1);
> +    } else {
> +        tcg_gen_add_tl(t0, t0, t1);
> +        if (add_ca) {
> +            tcg_gen_add_tl(t0, t0, cpu_ca32);
> +        }
> +        tcg_gen_extract_tl(cpu_ca32, t0, 32, 1);
> +    }
> +    tcg_temp_free(t0);
> +    tcg_temp_free(t1);
> +}

This is incorrect, since you're not considering the carry-in bits.  It's also 
inefficient since you should only need a single extraction.

Compute ca32 via

   t0 = result ^ in0 ^ in1
   extract_tl(ca32, t0, 32, 1)


r~
