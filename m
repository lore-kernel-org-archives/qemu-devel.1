Received: from eggs.gnu.org ([209.51.188.92]:47600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hESHg-0006g7-Qa
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 01:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hESHf-0005gP-KF
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 01:30:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hESHf-0005fx-7d
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 01:29:59 -0400
References: <20190410194838.10123-1-sw@weilnetz.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a6cef4ba-026c-75e7-d63b-70bb79621583@redhat.com>
Date: Thu, 11 Apr 2019 07:29:56 +0200
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
Cc: Richard Henderson <rth@twiddle.net>

On 10/04/2019 21.48, Stefan Weil wrote:
> This fixes "make check-tcg" on a Debian x86_64 host.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  tcg/tci.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tcg/tci.c b/tcg/tci.c
> index 33edca1903..a6208653e8 100644
> --- a/tcg/tci.c
> +++ b/tcg/tci.c
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
> @@ -585,6 +591,8 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
>              tci_write_reg8(regs, t0, *(uint8_t *)(t1 + t2));
>              break;
>          case INDEX_op_ld8s_i32:
> +            TODO();
> +            break;
>          case INDEX_op_ld16u_i32:
>              TODO();
>              break;
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
>          case INDEX_op_ld16s_i64:
>              TODO();
>              break;
> 

Works for me, too:

 https://gitlab.com/huth/qemu/-/jobs/194622472

Tested-by: Thomas Huth <thuth@redhat.com>
