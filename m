Received: from eggs.gnu.org ([2001:4830:134:3::10]:53492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8zOX-00039y-40
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8zOT-0002z3-5i
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:29:25 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8zOT-0002ya-0C
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:29:21 -0400
Received: by mail-qk0-x242.google.com with SMTP id o85so6054628qkh.0
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 18:29:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170510200535.13268-1-f4bug@amsat.org>
	<20170510200535.13268-5-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2eb86310-071e-cbe8-5473-2e1256236dbc@amsat.org>
Date: Thu, 11 May 2017 22:29:14 -0300
MIME-Version: 1.0
In-Reply-To: <20170510200535.13268-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/8] target/cris: optimize gen_swapb()
 using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Hi,

As reviewd by Richard this patch is WRONG, so need to further review :)

http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg02551.html

On 05/10/2017 05:05 PM, Philippe Mathieu-Daudé wrote:
> Applied using Coccinelle script.
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/cris/translate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index 0ee05ca02d..c03403ac62 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -442,8 +442,7 @@ static inline void t_gen_swapb(TCGv d, TCGv s)
>      tcg_gen_mov_tl(org_s, s);
>      tcg_gen_shli_tl(t, org_s, 8);
>      tcg_gen_andi_tl(d, t, 0xff00ff00);
> -    tcg_gen_shri_tl(t, org_s, 8);
> -    tcg_gen_andi_tl(t, t, 0x00ff00ff);
> +    tcg_gen_extract_tl(t, org_s, 8, 0x00ff00ff);
>      tcg_gen_or_tl(d, d, t);
>      tcg_temp_free(t);
>      tcg_temp_free(org_s);
>

corrected Coccinelle script displays:

candidate at target/cris/translate.c:445
   op_size: tl/tl (same)
   low_bits: 8 (value: 0xff)
   len: 0xff00ff
   len_bits != low_bits
   candidate is NOT optimizable
