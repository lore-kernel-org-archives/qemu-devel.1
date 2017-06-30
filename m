Received: from eggs.gnu.org ([2001:4830:134:3::10]:38656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQnq5-0005uz-0W
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 00:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQnq2-0005PY-0I
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 00:47:29 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dQnq1-0005PM-Ra
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 00:47:25 -0400
Received: by mail-qk0-x243.google.com with SMTP id 16so14196271qkg.2
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 21:47:25 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170630004059.25619-1-bobby.prani@gmail.com>
	<20170630004059.25619-3-bobby.prani@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fa409172-2651-d685-6de0-b1559745cba9@twiddle.net>
Date: Thu, 29 Jun 2017 21:47:22 -0700
MIME-Version: 1.0
In-Reply-To: <20170630004059.25619-3-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] tcg/aarch64: Use ADRP+ADD to
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

On 06/29/2017 05:40 PM, Pranith Kumar wrote:
>   void aarch64_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr)
>   {
>       tcg_insn_unit *code_ptr = (tcg_insn_unit *)jmp_addr;
> -    tcg_insn_unit *target = (tcg_insn_unit *)addr;
> +    tcg_insn_unit i1, i2;
> +    uint64_t pair;
>   
> +    ptrdiff_t offset = addr - jmp_addr;
> +
> +    if (offset == sextract64(offset, 0, 26)) {
> +        i1 = NOP;
> +        i2 = I3206_B | ((offset >> 2) & 0x3ffffff);

Branch first, since that's the offset you calculated.
Also, the nop need not be executed.

> +    } else {
> +        offset = (addr >> 12) - (jmp_addr >> 12);
> +
> +        /* patch ADRP */
> +        i2 = deposit32(*code_ptr++, 29, 2, offset & 0x3);
> +        i2 = deposit32(i2, 5, 19, offset >> 2);
> +        /* patch ADDI */
> +        i1 = deposit32(*code_ptr, 10, 12, addr & 0xfff);

You can't just patch these insns, because they aren't necessarily ADRP+ADD. 
Indeed, they will very likely be B and NOP.  The first address we patch in is 
tb_jmp_reset_offset, which is the following opcode, which is definitely in 
range of the branch above.


r~
