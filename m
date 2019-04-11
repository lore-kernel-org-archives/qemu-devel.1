Received: from eggs.gnu.org ([209.51.188.92]:60558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hETTk-0003gw-4z
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 02:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hETTj-0004wZ-4P
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 02:46:32 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:40781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1hETTh-0004pK-H8
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 02:46:30 -0400
Received: by mail-pg1-x52d.google.com with SMTP id d31so3034538pgl.7
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 23:46:26 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190410194838.10123-1-sw@weilnetz.de>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <46e4ee2d-f991-1910-db15-0ec216ab9cab@twiddle.net>
Date: Wed, 10 Apr 2019 20:46:19 -1000
MIME-Version: 1.0
In-Reply-To: <20190410194838.10123-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tci: Add implementation for
 INDEX_op_ld16u_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

On 4/10/19 9:48 AM, Stefan Weil wrote:
> @@ -127,6 +127,12 @@ static void tci_write_reg8(tcg_target_ulong *regs, TCGReg index, uint8_t value)
>      tci_write_reg(regs, index, value);
>  }
>  
> +static void
> +tci_write_reg16(tcg_target_ulong *regs, TCGReg index, uint16_t value)
> +{
> +    tci_write_reg(regs, index, value);
> +}
> +
>  static void
>  tci_write_reg32(tcg_target_ulong *regs, TCGReg index, uint32_t value)
>  {
> @@ -854,7 +862,14 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
>              tci_write_reg8(regs, t0, *(uint8_t *)(t1 + t2));
>              break;
>          case INDEX_op_ld8s_i64:
> +            TODO();
> +            break;
>          case INDEX_op_ld16u_i64:
> +            t0 = *tb_ptr++;
> +            t1 = tci_read_r(regs, &tb_ptr);
> +            t2 = tci_read_s32(&tb_ptr);
> +            tci_write_reg16(regs, t0, *(uint16_t *)(t1 + t2));
> +            break;

Looks ok, I guess, although the introduction of tci_write_reg16 seems redundant
with the uint16_t value that is loaded.

Why not use tci_write_reg64, since that is the size of the register you're
modifying?  Let the zero-extension explicit in the name of the opcode to be
reflected in the zero-extension implied by the passing of a uint16_t value to a
uint64_t argument.


r~
