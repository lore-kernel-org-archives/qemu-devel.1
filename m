Received: from eggs.gnu.org ([2001:4830:134:3::10]:59556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dgXvM-0003ca-Mj
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 11:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dgXvI-0005Zg-2n
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 11:02:00 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:34307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dgXvH-0005Z8-TH
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 11:01:56 -0400
Received: by mail-pf0-x236.google.com with SMTP id o86so26450460pfj.1
	for <qemu-devel@nongnu.org>; Sat, 12 Aug 2017 08:01:54 -0700 (PDT)
References: <cover.1502488636.git.alistair.francis@xilinx.com>
	<bc18dddca56e8c2ea4a3def48d33ceb5d21d1fff.1502488636.git.alistair.francis@xilinx.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b916859a-2ce6-24ae-5310-e07651c8acfe@linaro.org>
Date: Sat, 12 Aug 2017 08:01:48 -0700
MIME-Version: 1.0
In-Reply-To: <bc18dddca56e8c2ea4a3def48d33ceb5d21d1fff.1502488636.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/3] target/arm: Correct exclusive store
 cmpxchg memop mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: edgar.iglesias@xilinx.com, alistair23@gmail.com, qemu-arm@nongnu.org, edgar.iglesias@gmail.com

On 08/11/2017 03:17 PM, Alistair Francis wrote:
> When we perform the atomic_cmpxchg operation we want to perform the
> operation on a pair of 32-bit registers. Previously we were just passing
> the register size in which was set to MO_32. This would result in the
> high register to be ignored. To fix this issue we hardcode the size to
> be 64-bits long when operating on 32-bit pairs.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
> This was caught with an internal fuzzy tester. These patches fix the
> Xilinx 2.10-rc2 tree. I tested with the fuzzy tester (single CPU) and
> Linux boot (4 CPUs) on the Xilinx tree. I don't have a good test case to
> run on mainline, but am working with some internal teams to get one.
> Also linux-user is fully untested.
> 
> All tests were with MTTCG enabled.
> 
>  target/arm/translate-a64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 245175e2f1..49b4d6918d 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1913,7 +1913,7 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
>              tcg_gen_concat32_i64(val, cpu_exclusive_val, cpu_exclusive_high);
>              tcg_gen_atomic_cmpxchg_i64(tmp, addr, val, tmp,
>                                         get_mem_index(s),
> -                                       size | MO_ALIGN | s->be_data);
> +                                       MO_64 | MO_ALIGN | s->be_data);
>              tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, val);
>              tcg_temp_free_i64(val);
>          } else if (s->be_data == MO_LE) {
> 

Reading the ARM pseudocode again, especially wrt SetExclusiveMonitors, I think
there are other bugs here wrt 32-bit LDXP/STXP.

Since SetExclusiveMonitors is invoked only with address + dsize, one should be
able to write

	ldxp	w0, w1, [x5]
	stxr	w3, x2, [x5]
or
	ldxr	x0, [x5]
	stxp	w3, w1, w2, [x5]

However, the LDXR and LDXP above do not store the cpu_exclusive_* metadata in
the same format.  Fixing this is simply a matter of ignoring cpu_exclusive_high
for 32-bit pair operations and store it all in cpu_exclusive_val, as the 64-bit
single-register operation does.

In addition, 32-bit LDXP must be single-copy atomic, and we're issuing 2 loads,
this is trivially fixed with the rest of the required changes, but perhaps
worth noting.

I'll post a patch shortly.


r~
