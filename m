Received: from eggs.gnu.org ([2001:4830:134:3::10]:45368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drmFV-0004ry-2f
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drmFP-0000yU-9w
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:33:13 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:45965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drmFP-0000xk-32
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:33:07 -0400
Received: by mail-wm0-x22d.google.com with SMTP id f199so58818566wme.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 07:33:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <59B7EBC5.9060908@ispras.ru>
References: <59B7EBC5.9060908@ispras.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 15:32:45 +0100
Message-ID: <CAFEAcA-to=vWWBHoxZRX-ExcbDe0OTMwpHunE7HXaYA0GE+ccw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] MIPS 'move' insn emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergey Smolov <smolov@ispras.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12 September 2017 at 15:14, Sergey Smolov <smolov@ispras.ru> wrote:
> I've the code I probably need to modify in target/mips/translate.c:
>
> [code]
>
> static void gen_logic(DisasContext *ctx, uint32_t opc,
>                       int rd, int rs, int rt)
> {
> ...
> } else if (rs != 0 && rt == 0) {
>             tcg_gen_mov_tl(cpu_gpr[rd], cpu_gpr[rs]);
> }
>
> [/code]
>
> I suppose that for my assembler program cpu_gpr[rs] here should contain 0x7
> value at runtime. Is it possible to extract this value somehow? I've tried
> the following constructions:
>
> GET_TCG_I32(cpu_gpr[rs])
> ((CPUMIPSState *)tcg_ctx.cpu)->active_tc.gpr[rs]
>
> but they do not provide me the correct value.

You can't do this in this bit of the code. The functions in
translate.c are called at "translate time", when we convert
MIPS assembly into x86 code to run on the host. At this point
we don't know what the values in MIPS registers are, because
we're generating code that will later be run multiple times
perhaps with different values. The register contents are only
known later, at "run time".

thanks
-- PMM
