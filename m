Received: from eggs.gnu.org ([2001:4830:134:3::10]:46516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fteRR-0003ku-Pt
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 15:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fteRO-0006Md-6X
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 15:41:49 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fteRK-0006La-Hr
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 15:41:44 -0400
Received: by mail-pg1-x543.google.com with SMTP id v66-v6so5693352pgb.10
	for <qemu-devel@nongnu.org>; Sat, 25 Aug 2018 12:41:40 -0700 (PDT)
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-10-richard.henderson@linaro.org>
	<CAFEAcA__p5-xuYvqAh=97Uz81rxAiQNAnrKFFCsPAk-P4i_FHQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1f72a33b-7303-6e5e-92e7-a0142aee3b81@linaro.org>
Date: Sat, 25 Aug 2018 12:41:35 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA__p5-xuYvqAh=97Uz81rxAiQNAnrKFFCsPAk-P4i_FHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/20] target/arm: Handle SVE vector length
 changes in system mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 08/17/2018 09:22 AM, Peter Maydell wrote:
>> +    /*
>> +     * When FP is enabled, but SVE is disabled, the effective len is 0.
>> +     * ??? How should sve_exception_el interact with AArch32 state?
>> +     * That isn't included in the CheckSVEEnabled pseudocode, so is the
>> +     * host kernel required to explicitly disable SVE for an EL using aa32?
>> +     */
> I'm not clear what you're asking here. If the EL is AArch32
> then why does it make a difference if SVE is enabled or disabled?
> You can't get at it...
> 
>> +    old_len = (sve_exception_el(env, old_el)
>> +               ? 0 : sve_zcr_len_for_el(env, old_el));
>> +    new_len = (sve_exception_el(env, new_el)
>> +               ? 0 : sve_zcr_len_for_el(env, new_el));

Yes the registers are inaccessible.  But...

It may be that we must produce old_len/new_len == 0 if old_el/new_el is in
32-bit mode, so that the high part of the SVE registers are zeroed.

However, it may be UNDEFINED what happens if the OS switches to an el in 32-bit
mode while CPACR.ZEN == 3.  And if so, then there may be no point in adding an
additional test here.

So far I have re-worded the comment as:

     * ??? Do we need a conditional for old_el/new_el in aa32 state?
     * That isn't included in the CheckSVEEnabled pseudocode, so is the
     * host kernel required to explicitly disable SVE for an EL using aa32?

Thoughts on the underlying issue?


r~
