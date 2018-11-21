Received: from eggs.gnu.org ([2001:4830:134:3::10]:33846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPH7E-0007Zr-U6
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 20:15:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPH7E-0008RC-2f
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 20:15:40 -0500
MIME-Version: 1.0
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<1fe9630dd4ad73b8581684cd0ed6d5fa2918390f.1542321076.git.alistair.francis@wdc.com>
	<34cb4780-f35f-9bd5-7980-fae18e3e93dd@linaro.org>
In-Reply-To: <34cb4780-f35f-9bd5-7980-fae18e3e93dd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 Nov 2018 17:15:11 -0800
Message-ID: <CAKmqyKMh3T7w-NsP-i2HaRUHvR-0BhqeyTgd2mD0hnH9k8gZiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v1 11/23] riscv: tcg-target: Add the
 relocation functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org

On Fri, Nov 16, 2018 at 12:33 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/15/18 11:35 PM, Alistair Francis wrote:
> > +static void reloc_sbimm12(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
> > +{
> > +    intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
> > +    tcg_debug_assert(offset == sextract32(offset, 1, 12) << 1);
> > +
> > +    code_ptr[0] |= encode_sbimm12(offset);
> > +}
>
> FYI, I have an in-flight patch for 4.0 that will make patch_reloc return a bool
> for relocation success, which will move these asserts.
>
> http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg02237.html

Thanks, I'll keep an eye on this.

>
>
> > +static void reloc_call(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
> > +{
> > +    intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
> > +    tcg_debug_assert(offset == (int32_t)offset);
> > +
> > +    int32_t hi20 = ((offset + 0x800) >> 12) << 12;
> > +    int32_t lo12 = offset - hi20;
> > +
> > +    code_ptr[0] |= encode_uimm20(hi20);
> > +    code_ptr[1] |= encode_imm12(lo12);
> > +}
> > +
>
> This is ok for patching during generation, but it is not ok for
> tb_target_set_jmp_target from patch 9.
>
> Will the riscv-32 compiler use a FSTD insn to implement atomic_set for 64-bit?
>  If not, you may be just better off using the indirect method.

I'm not sure. Is the indirect method just using atomic set, because
that is what I have now?

Alistair

>
>
> r~
