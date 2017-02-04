Received: from eggs.gnu.org ([2001:4830:134:3::10]:41307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ca16c-0001yp-91
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 09:14:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ca16b-00036Q-BF
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 09:14:22 -0500
Date: Sat, 4 Feb 2017 15:14:13 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170204141413.GO9606@toto>
References: <1486144135-4894-1-git-send-email-peter.maydell@linaro.org>
	<1486144135-4894-2-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486144135-4894-2-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] target/arm: Abstract out pbit/wbit
 tests in ARM ldr/str decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On Fri, Feb 03, 2017 at 05:48:54PM +0000, Peter Maydell wrote:
> In the ARM ldr/str decode path, rather than directly testing
> "insn & (1 << 21)" and "insn & (1 << 24)", abstract these
> bits out into wbit and pbit local flags. (We will want to
> do more tests against them to determine whether we need to
> provide syndrome information.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  target/arm/translate.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 493c627..175b4c1 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8782,6 +8782,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>              } else {
>                  int address_offset;
>                  bool load = insn & (1 << 20);
> +                bool wbit = insn & (1 << 21);
> +                bool pbit = insn & (1 << 24);
>                  bool doubleword = false;
>                  /* Misc load/store */
>                  rn = (insn >> 16) & 0xf;
> @@ -8799,8 +8801,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>                  }
>  
>                  addr = load_reg(s, rn);
> -                if (insn & (1 << 24))
> +                if (pbit) {
>                      gen_add_datah_offset(s, insn, 0, addr);
> +                }
>                  address_offset = 0;
>  
>                  if (doubleword) {
> @@ -8849,10 +8852,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>                     ensure correct behavior with overlapping index registers.
>                     ldrd with base writeback is undefined if the
>                     destination and index registers overlap.  */
> -                if (!(insn & (1 << 24))) {
> +                if (!pbit) {
>                      gen_add_datah_offset(s, insn, address_offset, addr);
>                      store_reg(s, rn, addr);
> -                } else if (insn & (1 << 21)) {
> +                } else if (wbit) {
>                      if (address_offset)
>                          tcg_gen_addi_i32(addr, addr, address_offset);
>                      store_reg(s, rn, addr);
> -- 
> 2.7.4
> 
