Received: from eggs.gnu.org ([2001:4830:134:3::10]:41639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etQVx-0002K2-Hn
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 23:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etQVw-0000F4-7x
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 23:17:17 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etQVw-0000Em-0L
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 23:17:16 -0500
Received: by mail-oi0-x244.google.com with SMTP id c83so710844oib.1
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 20:17:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <24d071b1-52d1-7558-90f4-21c318bf6792@amsat.org>
References: <1520369037-37977-1-git-send-email-mjc@sifive.com>
	<1520369037-37977-10-git-send-email-mjc@sifive.com>
	<24d071b1-52d1-7558-90f4-21c318bf6792@amsat.org>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 7 Mar 2018 17:17:14 +1300
Message-ID: <CAHNT7NtdU=utDcuQjgnLxveDTN4-h-AhUT+UUsf=6-RzZBaKRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches disassembly <patches@groups.riscv.org>

On Wed, Mar 7, 2018 at 12:09 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> On 03/06/2018 05:43 PM, Michael Clark wrote:
> > This was added to help debug issues using -d in_asm. It is
> > useful to see the instruction bytes, as one can detect if
> > one is trying to execute ASCII or device-tree magic.
>
> clean :)


Yap. One feature crept in. I was trying to debug early firmware (to
separate firmware and kernel image) and this helped me discover that I was
jumping into device tree. 0xfeedd00d is the device-tree magic and it is
actually valid RVC code so I was quite puzzled until I modifed the
disassembler to show the instruction bytes.

> Signed-off-by: Michael Clark <mjc@sifive.com>
> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> > ---
> >  disas/riscv.c | 39 ++++++++++++++++++++-------------------
> >  1 file changed, 20 insertions(+), 19 deletions(-)
> >
> > diff --git a/disas/riscv.c b/disas/riscv.c
> > index 3c17501..4580308 100644
> > --- a/disas/riscv.c
> > +++ b/disas/riscv.c
> > @@ -2769,25 +2769,6 @@ static void format_inst(char *buf, size_t buflen=
,
> size_t tab, rv_decode *dec)
> >      char tmp[64];
> >      const char *fmt;
> >
> > -    if (dec->op =3D=3D rv_op_illegal) {
> > -        size_t len =3D inst_length(dec->inst);
> > -        switch (len) {
> > -        case 2:
> > -            snprintf(buf, buflen, "(0x%04" PRIx64 ")", dec->inst);
> > -            break;
> > -        case 4:
> > -            snprintf(buf, buflen, "(0x%08" PRIx64 ")", dec->inst);
> > -            break;
> > -        case 6:
> > -            snprintf(buf, buflen, "(0x%012" PRIx64 ")", dec->inst);
> > -            break;
> > -        default:
> > -            snprintf(buf, buflen, "(0x%016" PRIx64 ")", dec->inst);
> > -            break;
> > -        }
> > -        return;
> > -    }
> > -
> >      fmt =3D opcode_data[dec->op].format;
> >      while (*fmt) {
> >          switch (*fmt) {
> > @@ -3004,6 +2985,11 @@ disasm_inst(char *buf, size_t buflen, rv_isa isa=
,
> uint64_t pc, rv_inst inst)
> >      format_inst(buf, buflen, 16, &dec);
> >  }
> >
> > +#define INST_FMT_2 "%04" PRIx64 "              "
> > +#define INST_FMT_4 "%08" PRIx64 "          "
> > +#define INST_FMT_6 "%012" PRIx64 "      "
> > +#define INST_FMT_8 "%016" PRIx64 "  "
> > +
> >  static int
> >  print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_is=
a
> isa)
> >  {
> > @@ -3031,6 +3017,21 @@ print_insn_riscv(bfd_vma memaddr, struct
> disassemble_info *info, rv_isa isa)
> >          }
> >      }
> >
> > +    switch (len) {
> > +    case 2:
> > +        (*info->fprintf_func)(info->stream, INST_FMT_2, inst);
> > +        break;
> > +    case 4:
> > +        (*info->fprintf_func)(info->stream, INST_FMT_4, inst);
> > +        break;
> > +    case 6:
> > +        (*info->fprintf_func)(info->stream, INST_FMT_6, inst);
> > +        break;
> > +    default:
> > +        (*info->fprintf_func)(info->stream, INST_FMT_8, inst);
> > +        break;
> > +    }
> > +
> >      disasm_inst(buf, sizeof(buf), isa, memaddr, inst);
> >      (*info->fprintf_func)(info->stream, "%s", buf);
> >
> >
>
