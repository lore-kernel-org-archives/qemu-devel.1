Received: from eggs.gnu.org ([2001:4830:134:3::10]:38157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLhp-0001vI-Vk
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLhl-0002Ri-69
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:09:13 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:52547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etLhk-0002R3-VM
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:09:09 -0500
Received: by mail-wm0-x244.google.com with SMTP id t3so1329502wmc.2
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 15:09:08 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1520369037-37977-1-git-send-email-mjc@sifive.com>
	<1520369037-37977-10-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <24d071b1-52d1-7558-90f4-21c318bf6792@amsat.org>
Date: Tue, 6 Mar 2018 20:09:05 -0300
MIME-Version: 1.0
In-Reply-To: <1520369037-37977-10-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 09/22] RISC-V: Include hexidecimal
 instruction in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches disassembly <patches@groups.riscv.org>

On 03/06/2018 05:43 PM, Michael Clark wrote:
> This was added to help debug issues using -d in_asm. It is
> useful to see the instruction bytes, as one can detect if
> one is trying to execute ASCII or device-tree magic.

clean :)

> 
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  disas/riscv.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 3c17501..4580308 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2769,25 +2769,6 @@ static void format_inst(char *buf, size_t buflen, size_t tab, rv_decode *dec)
>      char tmp[64];
>      const char *fmt;
>  
> -    if (dec->op == rv_op_illegal) {
> -        size_t len = inst_length(dec->inst);
> -        switch (len) {
> -        case 2:
> -            snprintf(buf, buflen, "(0x%04" PRIx64 ")", dec->inst);
> -            break;
> -        case 4:
> -            snprintf(buf, buflen, "(0x%08" PRIx64 ")", dec->inst);
> -            break;
> -        case 6:
> -            snprintf(buf, buflen, "(0x%012" PRIx64 ")", dec->inst);
> -            break;
> -        default:
> -            snprintf(buf, buflen, "(0x%016" PRIx64 ")", dec->inst);
> -            break;
> -        }
> -        return;
> -    }
> -
>      fmt = opcode_data[dec->op].format;
>      while (*fmt) {
>          switch (*fmt) {
> @@ -3004,6 +2985,11 @@ disasm_inst(char *buf, size_t buflen, rv_isa isa, uint64_t pc, rv_inst inst)
>      format_inst(buf, buflen, 16, &dec);
>  }
>  
> +#define INST_FMT_2 "%04" PRIx64 "              "
> +#define INST_FMT_4 "%08" PRIx64 "          "
> +#define INST_FMT_6 "%012" PRIx64 "      "
> +#define INST_FMT_8 "%016" PRIx64 "  "
> +
>  static int
>  print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
>  {
> @@ -3031,6 +3017,21 @@ print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
>          }
>      }
>  
> +    switch (len) {
> +    case 2:
> +        (*info->fprintf_func)(info->stream, INST_FMT_2, inst);
> +        break;
> +    case 4:
> +        (*info->fprintf_func)(info->stream, INST_FMT_4, inst);
> +        break;
> +    case 6:
> +        (*info->fprintf_func)(info->stream, INST_FMT_6, inst);
> +        break;
> +    default:
> +        (*info->fprintf_func)(info->stream, INST_FMT_8, inst);
> +        break;
> +    }
> +
>      disasm_inst(buf, sizeof(buf), isa, memaddr, inst);
>      (*info->fprintf_func)(info->stream, "%s", buf);
>  
> 
