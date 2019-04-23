Received: from eggs.gnu.org ([209.51.188.92]:48847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hIr7I-0007Qb-LX
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hIqrz-0001sp-Hw
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:33:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hIqrz-0001sZ-9j
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:33:39 -0400
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-6-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3bf1ec75-4956-bb65-938f-cace75dbf628@redhat.com>
Date: Tue, 23 Apr 2019 10:33:37 +0200
MIME-Version: 1.0
In-Reply-To: <20190420073442.7488-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/38] tcg: Allow add_vec, sub_vec, neg_vec,
 not_vec to be expanded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 20.04.19 09:34, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op-vec.c | 49 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 33 insertions(+), 16 deletions(-)
> 
> diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
> index 27f65600c3..cfb18682b1 100644
> --- a/tcg/tcg-op-vec.c
> +++ b/tcg/tcg-op-vec.c
> @@ -226,16 +226,6 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr b, TCGArg o, TCGType low_type)
>      vec_gen_3(INDEX_op_st_vec, low_type, 0, ri, bi, o);
>  }
>  
> -void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
> -{
> -    vec_gen_op3(INDEX_op_add_vec, vece, r, a, b);
> -}
> -
> -void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
> -{
> -    vec_gen_op3(INDEX_op_sub_vec, vece, r, a, b);
> -}
> -
>  void tcg_gen_and_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
>  {
>      vec_gen_op3(INDEX_op_and_vec, 0, r, a, b);
> @@ -296,11 +286,30 @@ void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
>      tcg_gen_not_vec(0, r, r);
>  }
>  
> +static bool do_op2(unsigned vece, TCGv_vec r, TCGv_vec a, TCGOpcode opc)
> +{
> +    TCGTemp *rt = tcgv_vec_temp(r);
> +    TCGTemp *at = tcgv_vec_temp(a);
> +    TCGArg ri = temp_arg(rt);
> +    TCGArg ai = temp_arg(at);
> +    TCGType type = rt->base_type;
> +    int can;
> +
> +    tcg_debug_assert(at->base_type >= type);
> +    can = tcg_can_emit_vec_op(opc, type, vece);
> +    if (can > 0) {
> +        vec_gen_2(opc, type, vece, ri, ai);
> +    } else if (can < 0) {
> +        tcg_expand_vec_op(opc, type, vece, ri, ai);
> +    } else {
> +        return false;
> +    }
> +    return true;
> +}

I'd do

    if (can > 0) {
       vec_gen_2(opc, type, vece, ri, ai);
       return true;
    } else if (can < 0) {
       tcg_expand_vec_op(opc, type, vece, ri, ai);
       return true;
    }
    return false;


Or less readable "return can != 0;"

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
