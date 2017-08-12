Received: from eggs.gnu.org ([2001:4830:134:3::10]:59841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1dgUj5-0005IE-NX
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1dgUj4-0001Ld-Iu
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:37:07 -0400
Date: Sat, 12 Aug 2017 13:36:45 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20170812113645.GW12347@toto>
References: <cover.1502488636.git.alistair.francis@xilinx.com>
	<bc18dddca56e8c2ea4a3def48d33ceb5d21d1fff.1502488636.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bc18dddca56e8c2ea4a3def48d33ceb5d21d1fff.1502488636.git.alistair.francis@xilinx.com>
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
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, alistair23@gmail.com, edgar.iglesias@gmail.com, qemu-arm@nongnu.org

On Fri, Aug 11, 2017 at 03:17:41PM -0700, Alistair Francis wrote:
> When we perform the atomic_cmpxchg operation we want to perform the
> operation on a pair of 32-bit registers. Previously we were just passing
> the register size in which was set to MO_32. This would result in the
> high register to be ignored. To fix this issue we hardcode the size to
> be 64-bits long when operating on 32-bit pairs.

Good catch Alistair!
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



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
> -- 
> 2.11.0
> 
