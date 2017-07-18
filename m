Received: from eggs.gnu.org ([2001:4830:134:3::10]:33012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXJZx-00034E-QM
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXJZs-0002bG-Kj
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:53:45 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXJZs-0002ZO-EK
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:53:40 -0400
Received: by mail-pg0-x243.google.com with SMTP id v190so1180727pgv.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 20:53:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-37-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9b862388-4b4a-1db6-6161-4cab02ae5051@twiddle.net>
Date: Mon, 17 Jul 2017 17:53:33 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-37-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 36/45] tcg: dynamically allocate
 optimizer globals + fold into TCGContext
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
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>   tcg/tcg.h      | 12 ++++++++++++
>   tcg/optimize.c | 40 +++++++++++++++++++++++-----------------
>   2 files changed, 35 insertions(+), 17 deletions(-)
> 
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 569f823..175d4de 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -641,6 +641,14 @@ QEMU_BUILD_BUG_ON(OPPARAM_BUF_SIZE > (1 << 14));
>   /* Make sure that we don't overflow 64 bits without noticing.  */
>   QEMU_BUILD_BUG_ON(sizeof(TCGOp) > 8);
>   
> +struct tcg_temp_info {
> +    bool is_const;
> +    uint16_t prev_copy;
> +    uint16_t next_copy;
> +    tcg_target_ulong val;
> +    tcg_target_ulong mask;
> +};
> +
>   struct TCGContext {
>       uint8_t *pool_cur, *pool_end;
>       TCGPool *pool_first, *pool_current, *pool_first_large;
> @@ -717,6 +725,10 @@ struct TCGContext {
>       TCGTempSet free_temps[TCG_TYPE_COUNT * 2];
>       TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */
>   
> +    /* optimizer */
> +    struct tcg_temp_info *opt_temps;
> +    TCGTempSet opt_temps_used;

I would prefer either

   (1) Dynamic allocation.  I know we eschew that most places during,
       but surely this is the exact situation for which it's handy.

   (2) Make opt_temps an array of TCG_MAX_TEMPS and drop the pointer.

I think the TCGTempSet should be a local within tcg_optimize.


r~
