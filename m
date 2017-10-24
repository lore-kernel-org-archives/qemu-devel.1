Received: from eggs.gnu.org ([2001:4830:134:3::10]:49664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e727a-0006I0-Ux
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e727a-0003ae-6F
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:32:06 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:55660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e727Z-0003aI-VX
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:32:06 -0400
Received: by mail-wr0-x243.google.com with SMTP id l8so8430758wre.12
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 09:32:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_-b5kb=_jDeDbCGugmzvcuUGKvWV0myThVJuTDbg9jNA@mail.gmail.com>
References: <alpine.DEB.2.10.1710211105550.27209@sstabellini-ThinkPad-X260>
	<CAFEAcA_-b5kb=_jDeDbCGugmzvcuUGKvWV0myThVJuTDbg9jNA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Oct 2017 17:31:44 +0100
Message-ID: <CAFEAcA9Zcm4tEbYXJhsp=ZDCoQDZjd53XuM6T+cxfL7fj5QxCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] fix WFI/WFE length in syndrome register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 24 October 2017 at 16:53, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 21 October 2017 at 19:09, Stefano Stabellini <sstabellini@kernel.org> wrote:
>> diff --git a/target/arm/translate.c b/target/arm/translate.c
>> index 4da1a4c..a89518f 100644
>> --- a/target/arm/translate.c
>> +++ b/target/arm/translate.c
>> @@ -12325,12 +12325,15 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>>              /* nothing more to generate */
>>              break;
>>          case DISAS_WFI:
>> -            gen_helper_wfi(cpu_env);
>> +        {
>> +            TCGv_i32 tmp = tcg_const_i32((dc->insn & (1U << 31)) ? 4 : 2);
>
> This won't work, because dc->insn is only populated by the translate-a64.c
> A64 translator, not by the A32/T32 code. I guess 'principle of least
> surprise' suggests we should populate it for Thumb and ARM too.

...and also, this code path is used for both A32 and Thumb instruction
sets, so just looking at the top bit of dc->insn isn't sufficient, because
you might have the A32 encoding with a cond field with the top bit clear.
You can either look also at dc->thumb, or alternatively have a new
field is_16bit in DisasContext which you populate in arm_tr_translate_insn()
and thumb_tr_translate_insn().

thanks
-- PMM
