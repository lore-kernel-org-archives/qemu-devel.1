Received: from eggs.gnu.org ([2001:4830:134:3::10]:39340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddZGl-00089m-GN
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddZGk-0005bs-Fv
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:51:47 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:35839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ddZGk-0005bC-6r
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:51:46 -0400
Received: by mail-wm0-x235.google.com with SMTP id m85so15385670wma.0
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 02:51:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <91f1649d-ffcf-85c5-b83b-644ad1875fcd@twiddle.net>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-11-git-send-email-peter.maydell@linaro.org>
	<91f1649d-ffcf-85c5-b83b-644ad1875fcd@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2017 10:51:24 +0100
Message-ID: <CAFEAcA9PsNQHxm-wVwCEFJq_NuenkQhLp5SiwSQu02eJ=S9EWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 10/15] target/arm: Don't use
 cpsr_write/cpsr_read to transfer M profile XPSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 3 August 2017 at 23:13, Richard Henderson <rth@twiddle.net> wrote:
> On 08/02/2017 09:43 AM, Peter Maydell wrote:
>> +        if (val & XPSR_EXCP) {
>> +            /* This is a CPSR format value from an older QEMU. (We can tell
>> +             * because values transferred in XPSR format always have zero
>> +             * for the EXCP field, and CPSR format will always have bit 4
>> +             * set in CPSR_M.) Rearrange it into XPSR format. The significant
>> +             * differences are that the T bit is not in the same place, the
>> +             * primask/faultmask info may be in the CPSR I and F bits, and
>> +             * we do not want the mode bits.
>> +             */
>> +            uint32_t newval = val;
>> +
>> +            newval &= (CPSR_NZCV | CPSR_Q | CPSR_IT | CPSR_GE);
>> +            if (val & CPSR_T) {
>> +                newval |= XPSR_T;
>> +            }
>> +            /* If the I or F bits are set then this is a migration from
>> +             * an old QEMU which still stored the M profile FAULTMASK
>> +             * and PRIMASK in env->daif. For a new QEMU, the data is
>> +             * transferred using the vmstate_m_faultmask_primask subsection.
>> +             */
>
> The second comment seems sort of redundant with the first now.

I felt that the migration-compat stuff was sufficiently subtle
that it was worth retaining the second detailed comment as well
as the brief summary in the new first comment.

thanks
-- PMM
