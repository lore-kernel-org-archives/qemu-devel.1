Received: from eggs.gnu.org ([2001:4830:134:3::10]:38297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQcR6-0003IG-I2
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQcR1-0005SW-SS
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:36:56 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dQcR1-0005S5-L4
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:36:51 -0400
Received: by mail-pg0-x244.google.com with SMTP id u62so12514355pgb.0
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:36:51 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170629075243.26984-1-bobby.prani@gmail.com>
	<20170629075243.26984-3-bobby.prani@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0f0e153e-3ddc-f9b2-533a-6a856d115433@twiddle.net>
Date: Thu, 29 Jun 2017 09:36:47 -0700
MIME-Version: 1.0
In-Reply-To: <20170629075243.26984-3-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] tcg/aarch64: Use ADRP+ADD to
 compute target address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org

On 06/29/2017 12:52 AM, Pranith Kumar wrote:
> We use ADRP+ADD to compute the target address for goto_tb. This patch
> introduces the NOP instruction which is used to align the above
> instruction pair so that we can use one atomic instruction to patch
> the destination offsets.
> 
> CC: Richard Henderson <rth@twiddle.net>
> CC: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>   accel/tcg/translate-all.c    |  2 +-
>   tcg/aarch64/tcg-target.inc.c | 26 +++++++++++++++++++++-----
>   2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index f6ad46b613..b6d122e087 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -522,7 +522,7 @@ static inline PageDesc *page_find(tb_page_addr_t index)
>   #elif defined(__powerpc__)
>   # define MAX_CODE_GEN_BUFFER_SIZE  (32u * 1024 * 1024)
>   #elif defined(__aarch64__)
> -# define MAX_CODE_GEN_BUFFER_SIZE  (128ul * 1024 * 1024)
> +# define MAX_CODE_GEN_BUFFER_SIZE  (3ul * 1024 * 1024 * 1024)

The max is 2GB, because the 4GB range of ADRP is signed.
The end of the buffer must be able to address the beginning of the buffer.

>   void aarch64_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr)
>   {
>       tcg_insn_unit *code_ptr = (tcg_insn_unit *)jmp_addr;
> -    tcg_insn_unit *target = (tcg_insn_unit *)addr;
> +    tcg_insn_unit adrp_insn = *code_ptr++;
> +    tcg_insn_unit addi_insn = *code_ptr;
>   
> -    reloc_pc26_atomic(code_ptr, target);
> -    flush_icache_range(jmp_addr, jmp_addr + 4);
> +    ptrdiff_t offset = (addr >> 12) - (jmp_addr >> 12);
> +
> +    /* patch ADRP */
> +    adrp_insn = deposit32(adrp_insn, 29, 2, offset & 0x3);
> +    adrp_insn = deposit32(adrp_insn, 5, 19, offset >> 2);
> +    /* patch ADDI */
> +    addi_insn = deposit32(addi_insn, 10, 12, addr & 0xfff);
> +    atomic_set((uint64_t *)jmp_addr, adrp_insn | ((uint64_t)addi_insn << 32));
> +    flush_icache_range(jmp_addr, jmp_addr + 8);

(1) You don't need to load the ADRP and ADDI insns, because you know exactly 
what they are.  (2) You should check to see if the branch is within 128MB and 
use a direct branch in that case; it will happen quite often.  See the ppc64 
ppc_tb_set_jmp_target for an example.

>           /* actual branch destination will be patched by
> +           aarch64_tb_set_jmp_target later, beware of retranslation */

We can actually drop the retranslation comment now; that's a cleanup that 
should be applied to all of the backends...

> +        tcg_out_insn(s, 3406, ADRP, TCG_REG_TMP, 0);
> +        tcg_out_insn(s, 3401, ADDI, TCG_TYPE_I64, TCG_REG_TMP, TCG_REG_TMP, 0);
> +        tcg_out_callr(s, TCG_REG_TMP);

Don't use callr, use BR like you did for goto_long in the previous patch.


r~
