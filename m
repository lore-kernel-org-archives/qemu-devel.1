Received: from eggs.gnu.org ([2001:4830:134:3::10]:57078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciILe-0002oV-BK
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciILd-0004wq-62
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:16:06 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciILc-0004w9-SC
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:16:05 -0500
Received: by mail-wm0-x230.google.com with SMTP id v77so58457453wmv.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 02:16:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87d1e4p59c.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
References: <1486976352-549-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1486976352-549-2-git-send-email-nikunj@linux.vnet.ibm.com>
	<CAFEAcA8X873FLQxF_n_KZ-jc0hrKcqAj_tjNm6SO0hpPxbF75w@mail.gmail.com>
	<87d1e4p59c.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 10:15:43 +0000
Message-ID: <CAFEAcA8x8G7Xjx+W8Y2nbX2NA3YCLJyj_c0pZgm3xtEHYtQQ3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 2/2] risu_ppc64le: distinguish real illegal
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>

On 27 February 2017 at 05:33, Nikunj A Dadhania
<nikunj@linux.vnet.ibm.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 13 February 2017 at 08:59, Nikunj A Dadhania
>> <nikunj@linux.vnet.ibm.com> wrote:
>>> While executing qemu_ppc64le, found an issue that the real illegal
>>> instructions are handled as risu_op which results in wrong info at the
>>> master end. Even the master needs to distinguish real illegal
>>> instructions versus risu_op.
>>>
>>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>>
>> No, this is deliberate. Otherwise you can't test illegal
>> instructions. What should happen is that both master and
>> apprentice ends end up in the default case, which does
>> a register info compare and continues having stepped the
>> PC past the illegal insn.
>
> One of the issue that I had was some of the instruction are implemented
> in the master and not in apprentice. I think we could then disable them
> in the ppc64.risu. And enable them only when we have that implemented it
> in qemu tcg.

Yes; if you haven't yet implemented an instruction the best
approach is just to not try to test it.

>> (If only one end thinks the insn is illegal then there will
>> be a register mismatch on the PC.)
>
> Yeah, the issue here was it does not come out obviously that there was a
> real illegal instruction. Maybe a error print at both the ends would
> help in debugging.

It should print "faulting insn mismatch" if the instructions which
fault aren't the same thing. This is what the arm and aarch64
implementations of reginfo_dump_mismatch() do, anyway. It looks
like the ppc and m68k versions don't do that, though.

thanks
-- PMM
