Received: from eggs.gnu.org ([2001:4830:134:3::10]:54828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cfu2P-0003vq-Le
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:54:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cfu2M-0002Ic-Nv
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:54:21 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487585521-19445-5-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ed5544c1-647e-4cca-b3eb-975747ccf323@twiddle.net>
Date: Tue, 21 Feb 2017 06:38:35 +1100
MIME-Version: 1.0
In-Reply-To: <1487585521-19445-5-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 04/10] target/ppc: compute ca32 for
 arithmetic substract
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
> For 64-bit mode use the compute ca32 routine. While for 32-bit mode, CA
> and CA32 will have same value.
>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target/ppc/translate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 77045be..dd413de 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1389,6 +1389,7 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
>              tcg_temp_free(t1);
>              tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);    /* extract bit 32 */
>              tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
> +            tcg_gen_mov_tl(cpu_ca32, cpu_ca);
>          } else {
>              if (add_ca) {
>                  TCGv zero, inv1 = tcg_temp_new();
> @@ -1402,6 +1403,7 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
>                  tcg_gen_setcond_tl(TCG_COND_GEU, cpu_ca, arg2, arg1);
>                  tcg_gen_sub_tl(t0, arg2, arg1);
>              }
> +            gen_op_arith_compute_ca32(ctx, arg1, arg2, add_ca, 1);
>          }

Ah, I see what you wanted with the previous patch.  However, you won't want to 
put this here when you fix ca32 computation as I described, because for the 
add_ca case you'll want to pass in inv1 as arg1 so that you don't have to 
re-invert it.


r~
