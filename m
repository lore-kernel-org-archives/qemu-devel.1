Received: from eggs.gnu.org ([2001:4830:134:3::10]:46855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTKcx-0005AG-Lm
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 00:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTKcu-0001tH-Gn
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 00:12:23 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTKcu-0001t1-Bg
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 00:12:20 -0400
Received: by mail-qk0-x242.google.com with SMTP id 91so2974885qkq.1
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 21:12:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499397307-13605-1-git-send-email-jiang.biao2@zte.com.cn>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6b623406-d340-6c54-ef6a-894eb2825b8a@twiddle.net>
Date: Thu, 6 Jul 2017 18:12:12 -1000
MIME-Version: 1.0
In-Reply-To: <1499397307-13605-1-git-send-email-jiang.biao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/mips: Bugfix for crash when running
 program with qemu-i386.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiang Biao <jiang.biao2@zte.com.cn>, qemu-devel@nongnu.org
Cc: jinguojie@loongson.cn, james.hogan@imgtec.com, jiang.yong5@zte.com.cn, wang.liang82@zte.com.cn, shi.zhongbing@zte.com.cn, zhong.weidong@zte.com.cn

On 07/06/2017 05:15 PM, Jiang Biao wrote:
> When running a helloworld program with qemu-i386 in linux-user
> mode on Loongson 3A3000, it will crash. This patch fix the bug.
> 
> Signed-off-by: Jiang Biao<jiang.biao2@zte.com.cn>
> ---
>   tcg/mips/tcg-target.inc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
> index 8cff9a6..e6fedc9 100644
> --- a/tcg/mips/tcg-target.inc.c
> +++ b/tcg/mips/tcg-target.inc.c
> @@ -1540,7 +1540,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is_64)
>   #else
>       if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
>           tcg_out_ext32u(s, base, addr_regl);
> -        addr_regl = base;
> +        tcg_out_mov(s, TCG_TYPE_PTR, addr_regl, base);
>       }
>       if (guest_base == 0 && data_regl != addr_regl) {
>           base = addr_regl;

This is wrong, because you're not allowed to modify the input operands.

Try this, just a few lines lower in the function:

-        tcg_out_movi(s, TCG_TYPE_PTR, base, guest_base);
-        tcg_out_opc_reg(s, ALIAS_PADD, base, base, addr_regl);
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_TMP0, guest_base);
+        tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_TMP0, addr_regl);

and you'll need the same change within tcg_out_qemu_st.

Better would be to reserve a register for the guest_base, like we do for ppc. 
See all of the uses of TCG_GUEST_BASE_REG in tcg/ppc/tcg-target.inc.c.


r~
