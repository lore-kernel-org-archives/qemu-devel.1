Received: from eggs.gnu.org ([2001:4830:134:3::10]:41853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgUHd-00011H-0n
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgUHZ-0001G2-UG
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:36:29 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487755788-16415-6-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <64842dbd-8b97-0ccd-28d8-89f73a625b44@twiddle.net>
Date: Wed, 22 Feb 2017 21:36:16 +1100
MIME-Version: 1.0
In-Reply-To: <1487755788-16415-6-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/11] target/ppc: update ca32 in
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

On 02/22/2017 08:29 PM, Nikunj A Dadhania wrote:
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target/ppc/translate.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b589d09..184d10f 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -827,7 +827,15 @@ static inline void gen_op_arith_compute_ca32(DisasContext *ctx,
>      }
>
>      t0 = tcg_temp_new();
> -    tcg_gen_xor_tl(t0, arg0, arg1);
> +    if (!add_ca && sub) {

I think checking add_ca is wrong.  And note that it is otherwise unused.

> +        /* Invert arg0 before xor as in the !add_ca case,
> +         * we do not get inverse of arg0
> +         */
> +        tcg_gen_not_tl(t0, arg0);
> +        tcg_gen_xor_tl(t0, t0, arg1);
> +    } else {
> +        tcg_gen_xor_tl(t0, arg0, arg1);
> +    }
>      tcg_gen_xor_tl(t0, t0, res);
>      tcg_gen_extract_tl(cpu_ca32, t0, 32, 1);
>      tcg_temp_free(t0);
> @@ -1382,11 +1390,13 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
>              zero = tcg_const_tl(0);
>              tcg_gen_add2_tl(t0, cpu_ca, arg2, zero, cpu_ca, zero);
>              tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, inv1, zero);
> +            gen_op_arith_compute_ca32(ctx, t0, inv1, arg2, add_ca, 1);

The last parameter here should be 0.

>              tcg_temp_free(zero);
>              tcg_temp_free(inv1);
>          } else {
>              tcg_gen_setcond_tl(TCG_COND_GEU, cpu_ca, arg2, arg1);
>              tcg_gen_sub_tl(t0, arg2, arg1);
> +            gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, add_ca, 1);
>          }
>      } else if (add_ca) {
>          /* Since we're ignoring carry-out, we can simplify the
>

r~
