Received: from eggs.gnu.org ([2001:4830:134:3::10]:55316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecAKw-0005tD-Lf
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:34:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecAKq-0005zS-St
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:34:34 -0500
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:42039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ecAKq-0005yJ-OS
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:34:28 -0500
Received: by mail-oi0-x235.google.com with SMTP id o64so15679162oia.9
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 05:34:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513661932-6849-17-git-send-email-jcmvbkbc@gmail.com>
References: <1513661932-6849-1-git-send-email-jcmvbkbc@gmail.com>
	<1513661932-6849-17-git-send-email-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2018 13:34:07 +0000
Message-ID: <CAFEAcA9nZL+aTSRsjzweZm=mZh5-QAUS2y0CGeC-auRfhe3EvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 16/16] target/xtensa: implement
 disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 19 December 2017 at 05:38, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Add disas/xtensa.c and use libisa for instruction decoding/opcode name
> lookup.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

> +    slots = xtensa_format_num_slots(isa, fmt);
> +
> +    if (slots > 1) {
> +        info->fprintf_func(info->stream, "{ ");
> +    }
> +
> +    for (slot = 0; slot < slots; ++slot) {
> +        xtensa_opcode opc;
> +        unsigned opnd, vopnd, opnds;
> +
> +        if (slot) {
> +            info->fprintf_func(info->stream, "; ");
> +        }
> +        xtensa_format_get_slot(isa, fmt, slot, insnbuf, slotbuf);
> +        opc = xtensa_opcode_decode(isa, fmt, slot, slotbuf);
> +        if (opc == XTENSA_UNDEFINED) {
> +            info->fprintf_func(info->stream, "???");
> +            continue;
> +        }
> +        opnds = xtensa_opcode_num_operands(isa, opc);
> +
> +        info->fprintf_func(info->stream, "%s", xtensa_opcode_name(isa, opc));
> +
> +        for (opnd = vopnd = 0; opnd < opnds; ++opnd) {

Hi. Coverity complains here as well (CID 1385149, 1385150)
that the loop bound may be negative if xtensa_format_num_slots() or
xtensa_opcode_num_operands() return -1.


thanks
-- PMM
