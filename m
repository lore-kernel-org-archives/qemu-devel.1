Received: from eggs.gnu.org ([2001:4830:134:3::10]:34068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0SaS-0004BD-VX
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0SaR-0004rF-SW
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:22:44 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:48990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0SaR-0004qe-Kr
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:22:43 -0400
Received: by mail-wm0-x234.google.com with SMTP id i124so7554725wmf.3
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:22:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8dmJLEz_J5z8hCipmPgjxm5WE0D-6DPs5mA3HC_5ou6Q@mail.gmail.com>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-3-git-send-email-peter.maydell@linaro.org>
	<c0b514b4-6474-87ed-6fa0-c109761d243c@linaro.org>
	<CAFEAcA8dmJLEz_J5z8hCipmPgjxm5WE0D-6DPs5mA3HC_5ou6Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 14:22:21 +0100
Message-ID: <CAFEAcA_H_cgEPs1+aJ4fWzPys8-0Omyn_BtHGhJVwWuNbrr=gQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 02/20] target/arm: Don't switch to target
 stack early in v7M exception return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 5 October 2017 at 17:20, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 5 October 2017 at 17:04, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> On 09/22/2017 10:59 AM, Peter Maydell wrote:
>>> +static uint32_t *get_v7m_sp_ptr(CPUARMState *env, bool secure, bool threadmode,
>>> +                                bool spsel)
>>> +{
>>> +    /* Return a pointer to the location where we currently store the
>>> +     * stack pointer for the requested security state and thread mode.
>>> +     * This pointer will become invalid if the CPU state is updated
>>> +     * such that the stack pointers are switched around (eg changing
>>> +     * the SPSEL control bit).
>>> +     * Compare the v8M ARM ARM pseudocode LookUpSP_with_security_mode().
>>> +     * Unlike that pseudocode, we require the caller to pass us in the
>>> +     * SPSEL control bit value; this is because we also use this
>>> +     * function in handling of pushing of the callee-saves registers
>>> +     * part of the v8M stack frame, and in that case the SPSEL bit
>>> +     * comes from the exception return magic LR value.
>>
>> Exception return magic lr value does not appear to match "pushing".  Did you
>> mean "poping" here?
>
> No, because the code creates the exception magic LR value for an
> exception entry, and then uses it to determine which SPSEL to use.
> In the tailchained-exception case we use the magic LR that
> the attempted exception-exit got when figuring out where we need
> to push more registers as part of the tailchaining. The pseudocode
> chooses to open-code the "find the right stack pointer" for that
> codepath (in pseudocode function PushCalleeStack), whereas for this
> QEMU code I opted to make the utility function more specific. That's
> what this comment is trying to gesture at.
>
> [The push-on-exception-entry code is in "target/arm: Add v8M support
> to exception entry code"]

I'm going to change this part of the comment to read
     * Compare the v8M ARM ARM pseudocode LookUpSP_with_security_mode().
     * Unlike that pseudocode, we require the caller to pass us in the
     * SPSEL control bit value; this is because we also use this
     * function in handling of pushing of the callee-saves registers
     * part of the v8M stack frame (pseudocode PushCalleeStack()),
     * and in the tailchain codepath the SPSEL bit comes from the exception
     * return magic LR value from the previous exception. The pseudocode
     * opencodes the stack-selection in PushCalleeStack(), but we prefer
     * to make this utility function generic enough to do the job.

which hopefully is a little clearer.

thanks
-- PMM
