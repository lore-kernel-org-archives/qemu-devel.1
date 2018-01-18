Received: from eggs.gnu.org ([2001:4830:134:3::10]:34300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ec9F4-00035r-5p
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ec9F3-0000lL-CK
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:24:26 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:44266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ec9F3-0000l0-6J
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:24:25 -0500
Received: by mail-ot0-x243.google.com with SMTP id t20so10545477ote.11
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 04:24:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515520984-2873-1-git-send-email-jcmvbkbc@gmail.com>
References: <1515520984-2873-1-git-send-email-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2018 12:24:03 +0000
Message-ID: <CAFEAcA-TwVO+zkCDUNX5x7Wk0YwB4zcDDdiOii1HfZ2t5g66kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4] target/xtensa: use libisa for
 instruction decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9 January 2018 at 18:03, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Replace manual opcode analysis with libisa-based code. This makes it
> possible to support variable-encoding instructions of the core ISA, like
> const16, and will allow to support advanced Xtensa features, like FLIX
> and TIE.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Hi. Coverity (CID 1385146) complains about this bit of code:

> +        opnds = xtensa_opcode_num_operands(isa, opc);
> +
> +        for (opnd = vopnd = 0; opnd < opnds; ++opnd) {
> +            if (xtensa_operand_is_visible(isa, opc, opnd)) {
> +                uint32_t v;

because xtensa_opcode_num_operands() can return -1
(if the CHECK_OPCODE() fails), and then we will try to use
-1 as an upper bound for this loop and it will loop for a very
long time.

CID 1385148 is similar but for the outer loop where
we do "slots = xtensa_format_num_slots()" and then use
slots as a loop bound without checking whether we got back -1.

thanks
-- PMM
