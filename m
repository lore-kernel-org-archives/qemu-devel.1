Received: from eggs.gnu.org ([2001:4830:134:3::10]:53526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAnJr-00036W-Sd
	for qemu-devel@nongnu.org; Tue, 16 May 2017 21:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAnJn-0006oB-9X
	for qemu-devel@nongnu.org; Tue, 16 May 2017 21:00:03 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAnJn-0006o1-4q
	for qemu-devel@nongnu.org; Tue, 16 May 2017 20:59:59 -0400
Received: by mail-qt0-x242.google.com with SMTP id j13so23039696qta.3
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 17:59:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170516230159.4195-1-aurelien@aurel32.net>
	<20170516230159.4195-4-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b84e9237-3b91-0b80-8b10-d94c7d6c931d@amsat.org>
Date: Tue, 16 May 2017 21:59:54 -0300
MIME-Version: 1.0
In-Reply-To: <20170516230159.4195-4-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/4] target/cris: optimize swap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>

On 05/16/2017 08:01 PM, Aurelien Jarno wrote:
> Use the same mask to avoid having to load two different constants, as
> suggest by Richard Henderson. Also use one less temp.
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  target/cris/translate.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index 0ee05ca02d..103b214233 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -433,20 +433,19 @@ static inline void t_gen_subx_carry(DisasContext *dc, TCGv d)
>     T0 = ((T0 << 8) & 0xff00ff00) | ((T0 >> 8) & 0x00ff00ff)  */
>  static inline void t_gen_swapb(TCGv d, TCGv s)
>  {
> -    TCGv t, org_s;
> +    TCGv t, m;
>
>      t = tcg_temp_new();
> -    org_s = tcg_temp_new();
> +    m = tcg_const_tl(0x00ff00ff);
>
>      /* d and s may refer to the same object.  */
> -    tcg_gen_mov_tl(org_s, s);
> -    tcg_gen_shli_tl(t, org_s, 8);
> -    tcg_gen_andi_tl(d, t, 0xff00ff00);
> -    tcg_gen_shri_tl(t, org_s, 8);
> -    tcg_gen_andi_tl(t, t, 0x00ff00ff);
> +    tcg_gen_shri_tl(t, s, 8);
> +    tcg_gen_and_tl(t, t, m);
> +    tcg_gen_and_tl(d, s, m);

Eventually add a comment /* set d 0xff00ff00 */

Anyway,
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    tcg_gen_shli_tl(d, d, 8);
>      tcg_gen_or_tl(d, d, t);
> +    tcg_temp_free(m);
>      tcg_temp_free(t);
> -    tcg_temp_free(org_s);
>  }
>
>  /* Swap the halfwords of the s operand.  */
>
