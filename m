Received: from eggs.gnu.org ([2001:4830:134:3::10]:48679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhdy5-0007F6-W6
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhdy2-0006e1-2L
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:41:22 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhdy1-0006cr-UM
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:41:17 -0400
Received: by mail-qt0-x244.google.com with SMTP id u19so1071487qtc.0
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 08:41:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170815145714.17635-1-richard.henderson@linaro.org>
	<20170815145714.17635-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <73e9be7e-c87a-9514-0fbe-55d082bf4e47@amsat.org>
Date: Tue, 15 Aug 2017 12:41:09 -0300
MIME-Version: 1.0
In-Reply-To: <20170815145714.17635-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 1/3] target/arm: Correct
 exclusive store cmpxchg memop mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, alistair.francis@xilinx.com

On 08/15/2017 11:57 AM, Richard Henderson wrote:
> From: Alistair Francis <alistair.francis@xilinx.com>
> 
> When we perform the atomic_cmpxchg operation we want to perform the
> operation on a pair of 32-bit registers. Previously we were just passing
> the register size in which was set to MO_32. This would result in the
> high register to be ignored. To fix this issue we hardcode the size to
> be 64-bits long when operating on 32-bit pairs.
> 
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Message-Id: <bc18dddca56e8c2ea4a3def48d33ceb5d21d1fff.1502488636.git.alistair.francis@xilinx.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/arm/translate-a64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 58ed4c6d05..113e2e172b 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1913,7 +1913,7 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
>               tcg_gen_concat32_i64(val, cpu_exclusive_val, cpu_exclusive_high);
>               tcg_gen_atomic_cmpxchg_i64(tmp, addr, val, tmp,
>                                          get_mem_index(s),
> -                                       size | MO_ALIGN | s->be_data);
> +                                       MO_64 | MO_ALIGN | s->be_data);
>               tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, val);
>               tcg_temp_free_i64(val);
>           } else if (s->be_data == MO_LE) {
> 
