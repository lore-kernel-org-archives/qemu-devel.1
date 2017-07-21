Received: from eggs.gnu.org ([2001:4830:134:3::10]:48756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYQhc-0007Sq-Co
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 01:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYQhY-00006t-De
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 01:42:16 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47121)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYQhY-00006X-2t
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 01:42:12 -0400
Date: Fri, 21 Jul 2017 01:42:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170721054210.GA16334@flamenco>
References: <20170719233455.8740-1-rth@twiddle.net>
	<20170719233455.8740-7-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170719233455.8740-7-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH] target/arm: fix TCG temp leak in aarch64 rev16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Wed, Jul 19, 2017 at 13:34:47 -1000, Richard Henderson wrote:
> It is much shorter to reverse all 4 half-words in parallel
> than extract, reverse, and deposit each in turn.
> 
> Suggested-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/arm/translate-a64.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 3fa39023ca..5bb0f8ef22 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -4043,25 +4043,13 @@ static void handle_rev16(DisasContext *s, unsigned int sf,
>      TCGv_i64 tcg_rd = cpu_reg(s, rd);
>      TCGv_i64 tcg_tmp = tcg_temp_new_i64();
>      TCGv_i64 tcg_rn = read_cpu_reg(s, rn, sf);
> +    TCGv_i64 mask = tcg_const_i64(sf ? 0x00ff00ff00ff00ffull : 0x00ff00ff);
>  
> -    tcg_gen_andi_i64(tcg_tmp, tcg_rn, 0xffff);
> -    tcg_gen_bswap16_i64(tcg_rd, tcg_tmp);
> -
> -    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 16);
> -    tcg_gen_andi_i64(tcg_tmp, tcg_tmp, 0xffff);
> -    tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp);
> -    tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, 16, 16);
> -
> -    if (sf) {
> -        tcg_gen_shri_i64(tcg_tmp, tcg_rn, 32);
> -        tcg_gen_andi_i64(tcg_tmp, tcg_tmp, 0xffff);
> -        tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp);
> -        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, 32, 16);
> -
> -        tcg_gen_shri_i64(tcg_tmp, tcg_rn, 48);
> -        tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp);
> -        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, 48, 16);
> -    }
> +    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 8);
> +    tcg_gen_and_i64(tcg_rd, tcg_rn, mask);
> +    tcg_gen_and_i64(tcg_tmp, tcg_tmp, mask);
> +    tcg_gen_shli_i64(tcg_rd, tcg_rd, 8);
> +    tcg_gen_or_i64(tcg_rd, tcg_rd, tcg_tmp);
>  
>      tcg_temp_free_i64(tcg_tmp);

const leak! patch below -- cut with `git am --scissors'.

		Emilio

---8<---

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/arm/translate-a64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 883e9df..58ed4c6 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4044,20 +4044,21 @@ static void handle_rev16(DisasContext *s, unsigned int sf,
     TCGv_i64 tcg_tmp = tcg_temp_new_i64();
     TCGv_i64 tcg_rn = read_cpu_reg(s, rn, sf);
     TCGv_i64 mask = tcg_const_i64(sf ? 0x00ff00ff00ff00ffull : 0x00ff00ff);
 
     tcg_gen_shri_i64(tcg_tmp, tcg_rn, 8);
     tcg_gen_and_i64(tcg_rd, tcg_rn, mask);
     tcg_gen_and_i64(tcg_tmp, tcg_tmp, mask);
     tcg_gen_shli_i64(tcg_rd, tcg_rd, 8);
     tcg_gen_or_i64(tcg_rd, tcg_rd, tcg_tmp);
 
+    tcg_temp_free_i64(mask);
     tcg_temp_free_i64(tcg_tmp);
 }
 
 /* C3.5.7 Data-processing (1 source)
  *   31  30  29  28             21 20     16 15    10 9    5 4    0
  * +----+---+---+-----------------+---------+--------+------+------+
  * | sf | 1 | S | 1 1 0 1 0 1 1 0 | opcode2 | opcode |  Rn  |  Rd  |
  * +----+---+---+-----------------+---------+--------+------+------+
  */
 static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
-- 
2.7.4
