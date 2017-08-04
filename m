Received: from eggs.gnu.org ([2001:4830:134:3::10]:43412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddfdA-0003pT-4f
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 12:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddfd6-0002fT-GU
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 12:39:20 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:38273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddfd6-0002em-9u
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 12:39:16 -0400
Received: by mail-qt0-x243.google.com with SMTP id p3so2008416qtg.5
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 09:39:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170804054426.10590-1-rth@twiddle.net>
	<20170804054426.10590-23-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a9a144cb-0e9d-c6dc-c549-c2bd6a1836a9@amsat.org>
Date: Fri, 4 Aug 2017 13:39:12 -0300
MIME-Version: 1.0
In-Reply-To: <20170804054426.10590-23-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 22/23] tcg/ppc: Look for shifted
 constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

Hi Richard,

On 08/04/2017 02:44 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>   tcg/ppc/tcg-target.inc.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index bc14d2c9c6..4b32809217 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -598,6 +598,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
>   {
>       intptr_t tb_diff;
>       int32_t high;
> +    int lsb;
>   
>       tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
>   
> @@ -638,6 +639,14 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
>           return;
>       }
>   
> +    lsb = ctz64(arg);
> +    high = arg >> lsb;
> +    if (arg == (int16_t)arg) {

Can you move these here?

+    lsb = ctz64(arg);
+    high = arg >> lsb;

> +        tcg_out32(s, ADDI | TAI(ret, 0, high));
> +        tcg_out_shli64(s, ret, ret, lsb);
> +        return;
> +    }
> +
>       high = arg >> 31 >> 1;
>       tcg_out_movi(s, TCG_TYPE_I32, ret, high);
>       if (high) {
> 

Regards,

Phil.
