Received: from eggs.gnu.org ([2001:4830:134:3::10]:48198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9oLY-0007Td-It
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9oLW-0003OL-Hm
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:30:31 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9oLS-0003JT-V5
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:30:27 -0400
Received: by mail-ot1-x341.google.com with SMTP id k9so891725otl.10
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 02:30:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181008213407.GF4229@toto>
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
	<1538579266-8389-11-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA9b4O4HrMwNTgbZ7JYdO=S3dnzC8ayabBEpKY5=DyBMog@mail.gmail.com>
	<20181008213407.GF4229@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Oct 2018 10:30:01 +0100
Message-ID: <CAFEAcA__7wJ-4mNe3rKe4T+gDUbdBH+rB-DHE+fddmjVzG2=Eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 10/12] target/arm: Add the Cortex-A72
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

On 8 October 2018 at 22:34, Edgar E. Iglesias <edgar.iglesias@xilinx.com> wrote:
> On Mon, Oct 08, 2018 at 02:10:29PM +0100, Peter Maydell wrote:
>> On 3 October 2018 at 16:07, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
>> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>> >
>> > Add the ARM Cortex-A72.
>> >
>> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

>> > +    cpu->midr = 0x410fd083;
>> > +    cpu->revidr = 0x00000000;
>> > +    cpu->reset_fpsid = 0x41034080;
>> > +    cpu->mvfr0 = 0x10110222;
>> > +    cpu->mvfr1 = 0x12111111;
>> > +    cpu->mvfr2 = 0x00000043;
>> > +    cpu->ctr = 0x8444c004;
>> > +    cpu->reset_sctlr = 0x00c50838;
>>
>> Do you happen to have the hardware to hand to check what the
>> top 4 bits of the reset value of SCTLR_ELx are? I think they
>> should be 0x3 -- the Arm ARM says that [29:28] are RES1 (as
>> does the A72 TRM, though its top level summary table lists
>> 0x00c50838 as the reset value for some of the SCTLR_ELx.)
>>
>> QEMU may have the wrong value for A53/A57 here too, I suspect.
>
> I don't have access to the A72s at the moment but looking at logs
> it seems to be 0x00c50838 for both the A53 and A72.
> Looking at "Table 4-118 SCTLR bit assignments" in the A72 TRM,
> bits [30:28] seem to have been allocated. Bit 30 depends on
> configuration inputs to the core and [29:28] seem to be hard-coded
> to zero.

Ah, this is a 32-bit view vs 64-bit view thing. In 32-bit,
SCTLR[28] is TRE (TEX remap enable), and SCTLR[29] is AFE
(access flag enable), and both are resets-to-zero.
HSCTLR[28] and [29] are both reserved, RES1.
In 64-bit, SCTLR_EL1[29:28] are RES1 in ARMv8.1 and v8.0, and
have new meanings assigned in v8.2 and v8.3.
SCTLR_EL2[29:28] and SCTLR_EL3[29:28] are reserved, RES1.

For QEMU at the moment we don't deal with this, and so we
have only the one reset value, cpu->reset_sctlr, which we use
for both the SCTLR_EL1 and SCTLR_EL3 resets. Our HSCTLR/SCTLR_EL2
resets to zero, and we don't allow for the 64-bit and 32-bit views
not necessarily being the same value.

thanks
-- PMM
