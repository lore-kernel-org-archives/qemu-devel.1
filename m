Received: from eggs.gnu.org ([2001:4830:134:3::10]:48465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddOP3-0006To-7n
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddOP0-00007U-2P
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:15:37 -0400
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-11-git-send-email-peter.maydell@linaro.org>
	<91f1649d-ffcf-85c5-b83b-644ad1875fcd@twiddle.net>
Message-ID: <a07ea64f-1d12-7831-d91f-9c0e0cc3df40@twiddle.net>
Date: Thu, 3 Aug 2017 15:15:31 -0700
MIME-Version: 1.0
In-Reply-To: <91f1649d-ffcf-85c5-b83b-644ad1875fcd@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 08/03/2017 03:13 PM, Richard Henderson wrote:
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

... and I meant to say, otherwise,


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
