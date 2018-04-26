Received: from eggs.gnu.org ([2001:4830:134:3::10]:60317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBkLC-0008Pn-D8
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBkLB-0008C0-EQ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:05:54 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:44103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fBkLB-0008Ba-7i
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:05:53 -0400
Received: by mail-lf0-x244.google.com with SMTP id h197-v6so4428647lfg.11
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 10:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<1524699938-6764-7-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-7-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Apr 2018 17:05:26 +0000
Message-ID: <CAKmqyKPCSiVssGj53pTA5trT8YmAUnQ5q6dpZ3-OjaV1_WUWQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 06/35] RISC-V: Include instruction hex
 in disassembly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, patches@groups.riscv.org, palmer@sifive.com, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Wed, Apr 25, 2018 at 4:53 PM Michael Clark <mjc@sifive.com> wrote:

> This was added to help debug issues using -d in_asm. It is
> useful to see the instruction bytes, as one can detect if
> one is trying to execute ASCII or device-tree magic.

> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   disas/riscv.c | 39 ++++++++++++++++++++-------------------
>   1 file changed, 20 insertions(+), 19 deletions(-)

> diff --git a/disas/riscv.c b/disas/riscv.c
> index 74ad16e..2cecf0d 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2769,25 +2769,6 @@ static void format_inst(char *buf, size_t buflen,
size_t tab, rv_decode *dec)
>       char tmp[64];
>       const char *fmt;

> -    if (dec->op =3D=3D rv_op_illegal) {
> -        size_t len =3D inst_length(dec->inst);
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
>       fmt =3D opcode_data[dec->op].format;
>       while (*fmt) {
>           switch (*fmt) {
> @@ -3004,6 +2985,11 @@ disasm_inst(char *buf, size_t buflen, rv_isa isa,
uint64_t pc, rv_inst inst)
>       format_inst(buf, buflen, 16, &dec);
>   }

> +#define INST_FMT_2 "%04" PRIx64 "              "
> +#define INST_FMT_4 "%08" PRIx64 "          "
> +#define INST_FMT_6 "%012" PRIx64 "      "
> +#define INST_FMT_8 "%016" PRIx64 "  "
> +
>   static int
>   print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa
isa)
>   {
> @@ -3031,6 +3017,21 @@ print_insn_riscv(bfd_vma memaddr, struct
disassemble_info *info, rv_isa isa)
>           }
>       }

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
>       disasm_inst(buf, sizeof(buf), isa, memaddr, inst);
>       (*info->fprintf_func)(info->stream, "%s", buf);

> --
> 2.7.0
