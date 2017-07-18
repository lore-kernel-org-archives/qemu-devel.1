Received: from eggs.gnu.org ([2001:4830:134:3::10]:36818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXJwz-0008Fu-PI
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXJwu-0002qp-Os
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:17:33 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXJwu-0002qN-Hi
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:17:28 -0400
Received: by mail-pg0-x242.google.com with SMTP id d193so1243088pgc.2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 21:17:28 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-38-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b977f473-6e92-9f1b-9f88-8bdddf898365@twiddle.net>
Date: Mon, 17 Jul 2017 18:17:21 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-38-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 37/45] tcg: introduce **tcg_ctxs to keep
 track of all TCGContext's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/16/2017 10:04 AM, Emilio G. Cota wrote:
> Groundwork for supporting multiple TCG contexts.
> 
> Note that having n_tcg_ctxs is unnecessary. However, it is
> convenient to have it, since it will simplify iterating over the
> array: we'll have just a for loop instead of having to iterate
> over a NULL-terminated array (which would require n+1 elems)
> or having to check with ifdef's for usermode/softmmu.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>   tcg/tcg.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index f907c47..8094278 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -115,6 +115,8 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
>   static void tcg_out_tb_init(TCGContext *s);
>   static bool tcg_out_tb_finalize(TCGContext *s);
>   
> +static TCGContext **tcg_ctxs;
> +static unsigned int n_tcg_ctxs;

I'm perfectly happy introducing these now, and converting stuff to use them.

> +static void tcg_ctxs_init(TCGContext *s)
> +{
> +    tcg_ctxs = g_new(TCGContext *, 1);
> +    tcg_ctxs[0] = s;
> +    n_tcg_ctxs = 1;
> +}

This was confusing to me, trying to figure out how this function would be 
extended for multi-threading.  But it turns out it isn't -- it just goes away.

> @@ -381,6 +390,7 @@ void tcg_context_init(TCGContext *s)
>           indirect_reg_alloc_order[i] = tcg_target_reg_alloc_order[i];
>       }
>   
> +    tcg_ctxs_init(s);
>       tcg_ctx = s;
>   }

Thus I think it would be simpler for the interim to do

     tcg_ctx = s;
     tcg_ctxs = &tcg_ctx;
     n_tcg_ctxs = 1;


r~
