Received: from eggs.gnu.org ([2001:4830:134:3::10]:39050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgui2-00063v-Qs
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cguhy-0005HA-Pn
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:49:30 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cguhy-0005Gw-J7
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:49:26 -0500
Received: by mail-wm0-x22f.google.com with SMTP id v186so174068306wmd.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 06:49:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170223135800.GB7958@codeaurora.org>
References: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
	<1486750082-12324-4-git-send-email-peter.maydell@linaro.org>
	<20170223135800.GB7958@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Feb 2017 14:49:04 +0000
Message-ID: <CAFEAcA_vWZ4pLT+40XK2CeVckcREFZ9DW2yGKMCuZjPMGSNZEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 03/12] target-arm: Add support for PMU
 register PMINTENSET_EL1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 23 February 2017 at 13:58, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> Wei, Peter,
>
> On Feb 10 18:07, Peter Maydell wrote:
>> From: Wei Huang <wei@redhat.com>
>>
>> This patch adds access support for PMINTENSET_EL1.
>>
>> Signed-off-by: Wei Huang <wei@redhat.com>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Message-id: 1486504171-26807-4-git-send-email-wei@redhat.com
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  target/arm/cpu.h    |  2 +-
>>  target/arm/helper.c | 10 +++++++++-
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index edc1f76..0956a54 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -309,7 +309,7 @@ typedef struct CPUARMState {
>>          uint32_t c9_pmovsr; /* perf monitor overflow status */
>>          uint32_t c9_pmuserenr; /* perf monitor user enable */
>>          uint64_t c9_pmselr; /* perf monitor counter selection register */
>> -        uint32_t c9_pminten; /* perf monitor interrupt enables */
>> +        uint64_t c9_pminten; /* perf monitor interrupt enables */
>
> PMINTENSET_EL1 and PMINTENCLR_EL1 are both 32-bit registers, just like
> their AArch32 counterparts. Is there a reason I'm missing for why this
> has been changed to a uint64_t? There are a number of other 32-bit PMU
> registers also currently being represented by uint64_t.

Two reasons:

 (1) The conceptual reason. In AArch64 "32-bit system register" is just
a convenient shorthand for "64-bit system register where the upper 32
bits are RAZ/WI". The register itself is still 64 bits and in a future
architecture revision it might end up with defined bits in the upper
half (this has happened already for a few registers).

 (2) The QEMU implementation reason. The way we implement system register
access instructions typically ends up in generating a simple "load/store
64 bit value from address" instruction. Rather than having the generic
"handle a system register access" code  have two codepaths to cope with
"64-bit sysreg that's stored in a 32-bit field" and "64-bit sysreg that's
stored in a 64-bit field", we choose to require that the fields are always
64-bits wide, so that the code that accesses them doesn't have to care.

(The implementation reason derives from the conceptual reason:
architecturally there is no real different "32-bit system register"
concept, so we don't need to implement handling differently. For
AArch32 we do distinguish between 32-bit and 64-bit coprocessor
registers, because they're really different things and need
different handling.)

thanks
-- PMM
