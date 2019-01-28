Received: from eggs.gnu.org ([209.51.188.92]:34416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goESX-0002Ii-3K
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 16:28:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goESW-0005is-4h
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 16:28:49 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goESV-0005eU-Ir
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 16:28:48 -0500
Received: by mail-ot1-x341.google.com with SMTP id n8so16024473otl.6
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 13:28:44 -0800 (PST)
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-7-richard.henderson@linaro.org>
	<CAFEAcA_cvfL2Sja4WawDAR++Ak85yKo7J=Xy4hzO_ChiFt7mZw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b4e20937-dbf0-1e26-8426-dcea14874833@linaro.org>
Date: Mon, 28 Jan 2019 13:28:40 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_cvfL2Sja4WawDAR++Ak85yKo7J=Xy4hzO_ChiFt7mZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/11] target/arm: Reset btype for direct
 branches and syscalls
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

On 1/22/19 6:12 AM, Peter Maydell wrote:
> On Thu, 10 Jan 2019 at 12:17, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This is all of the non-exception cases of DISAS_NORETURN.
> 
> What about the gen_helper_exit_atomic() exit cases ?

In that case we are going to re-execute the same insn with a different
translation, so we do not want to change btype.

(Although I'm not sure how the guest could tell.  Given where we check for
btype mismatch, we would recognize the BTI exception before getting into the
ldst_ex path that generates the ATOMIC exception.  So any DataAbort exception
that the atomic insn itself might generate must also have BTYPE == 0.)

>> For the rest of the synchronous exceptions, the state of
>> SPSR_ELx.BTYPE is CONSTRAINED UNPREDICTABLE.  However, it
>> makes more sense to me to have syscalls reset BTYPE.
> 
> The advantage of picking the other choice (SPSR_ELx.BTYPE ==
> PSTATE.BTYPE) is that it means that the behaviour is identical
> for all exceptions (async or sync of any type) and we don't
> do the work of clearing the BTYPE field (which will happen
> potentially in "normal" guest code if we're not in a guarded page,
> I think).

Well, BTYPE is in the TB flags, so we know it's already zero in that case, so
there's no extra work.  But you're probably right about not making syscall
special.  I've removed that.


r~
