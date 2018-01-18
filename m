Received: from eggs.gnu.org ([2001:4830:134:3::10]:58472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ecEag-0007qD-IX
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:07:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ecEaf-0001Lt-FD
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:07:06 -0500
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:42203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ecEaf-0001LR-BZ
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:07:05 -0500
Received: by mail-yw0-x243.google.com with SMTP id u17so10163242ywg.9
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 10:07:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-TwVO+zkCDUNX5x7Wk0YwB4zcDDdiOii1HfZ2t5g66kg@mail.gmail.com>
References: <1515520984-2873-1-git-send-email-jcmvbkbc@gmail.com>
	<CAFEAcA-TwVO+zkCDUNX5x7Wk0YwB4zcDDdiOii1HfZ2t5g66kg@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 18 Jan 2018 10:07:04 -0800
Message-ID: <CAMo8Bf+aczzS9ZKVML6b=Tua_ZNDuRHFxs9__tVcXKJ0g-UpPg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, Jan 18, 2018 at 4:24 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 9 January 2018 at 18:03, Max Filippov <jcmvbkbc@gmail.com> wrote:
>> Replace manual opcode analysis with libisa-based code. This makes it
>> possible to support variable-encoding instructions of the core ISA, like
>> const16, and will allow to support advanced Xtensa features, like FLIX
>> and TIE.
>>
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>
> Hi. Coverity (CID 1385146) complains about this bit of code:
>
>> +        opnds = xtensa_opcode_num_operands(isa, opc);
>> +
>> +        for (opnd = vopnd = 0; opnd < opnds; ++opnd) {
>> +            if (xtensa_operand_is_visible(isa, opc, opnd)) {
>> +                uint32_t v;
>
> because xtensa_opcode_num_operands() can return -1
> (if the CHECK_OPCODE() fails), and then we will try to use
> -1 as an upper bound for this loop and it will loop for a very
> long time.
>
> CID 1385148 is similar but for the outer loop where
> we do "slots = xtensa_format_num_slots()" and then use
> slots as a loop bound without checking whether we got back -1.

In both cases the check inside libisa should not fail, because
the caller just made sure that opcode or format is valid. But I
see, these checks are different. I guess the easiest fix for that
is to make opnd, opnds, slot and slots signed.

-- 
Thanks.
-- Max
