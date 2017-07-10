Received: from eggs.gnu.org ([2001:4830:134:3::10]:46375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dURXF-0007dM-9k
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 01:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dURXE-00058B-F2
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 01:47:05 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dURXE-00057p-8H
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 01:47:04 -0400
Received: by mail-pg0-x242.google.com with SMTP id d193so11407369pgc.2
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 22:47:04 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499665789-20058-1-git-send-email-jiang.biao2@zte.com.cn>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <66e555ff-46c2-1517-80cb-e4277ea86dc3@twiddle.net>
Date: Sun, 9 Jul 2017 19:46:57 -1000
MIME-Version: 1.0
In-Reply-To: <1499665789-20058-1-git-send-email-jiang.biao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] tcg/mips: Bugfix for crash when running
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

On 07/09/2017 07:49 PM, Jiang Biao wrote:
> When running a helloworld program with qemu-i386 in linux-user
> mode on Loongson 3A3000, it will crash. The reasion is wrong
> assigning from base to addr_regl directly. This patch fix the
> bug.
> 
> Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>   tcg/mips/tcg-target.inc.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
> index 8cff9a6..cebca8e 100644
> --- a/tcg/mips/tcg-target.inc.c
> +++ b/tcg/mips/tcg-target.inc.c
> @@ -1539,16 +1539,18 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is_64)
>                           s->code_ptr, label_ptr);
>   #else
>       if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
> -        tcg_out_ext32u(s, base, addr_regl);
> -        addr_regl = base;
> +        tcg_out_ext32u(s, TCG_TMP0, addr_regl);
> +    } else {
> +        tcg_out_mov(s, TCG_TYPE_PTR, TCG_TMP0, addr_regl);
>       }

No, this is exactly why the assignment to the addr_regl variable exists, so 
that you do not need to emit an extra instruction for a 64-bit guest.


r~
