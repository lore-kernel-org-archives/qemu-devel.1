Received: from eggs.gnu.org ([209.51.188.92]:43843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzQ3b-0003Jg-BA
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzQ3V-0004jy-MD
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:05:19 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:33396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzQ3T-0004d0-Hz
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:05:13 -0500
Received: by mail-pg1-x535.google.com with SMTP id h11so10103528pgl.0
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:05:06 -0800 (PST)
References: <5F2C0013-1D18-44A9-ADAF-F86EC6FD1174@oberlin.edu>
	<CAFEAcA8VzJRMSThWQ=CgNbB8BY0EAmi77oAJuHQt5iQnkiZmzg@mail.gmail.com>
	<63A30600-CCE3-4412-A3EB-8D535A8B21B3@oberlin.edu>
	<4F8E4327-9F59-4F50-A22D-20A3F939899F@oberlin.edu>
	<9108923c-076b-034c-9d68-af355861ae0c@linaro.org>
	<1FBF59F3-F256-4680-B2AD-199C197814C9@oberlin.edu>
	<013f91f0-1968-1400-84b2-4d4fe2ece9a6@linaro.org>
	<8F89FA7E-E952-425F-A587-66BEECF4A295@oberlin.edu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a244b0af-9b69-3760-0663-dbf9a0315789@linaro.org>
Date: Thu, 28 Feb 2019 10:05:02 -0800
MIME-Version: 1.0
In-Reply-To: <8F89FA7E-E952-425F-A587-66BEECF4A295@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] x86 segment limits enforcement with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>

On 2/28/19 9:18 AM, Stephen Checkoway wrote:
> I wonder if it would make sense to maintain a small cache of TLBs. The
> majority of cases are likely to involving setting segment registers to one
> of a handful of segments (e.g., setting es to ds or ss). So it might be nice
> to avoid the flushes entirely.
Hmm.

The straight-forward approach to this would change the mapping between segment
and mmu index, which would need to force a new translation (since mmu indexes
are built into the generated code as constants).  It would be easy for this
scheme to generate too many translations and slow down the system as a whole.

However, since the change to dynamic tlbs, the actual tlb is now a pointer.  So
it might not be out of the question to simply swap TLB contents around when
changing segment registers.  All you would need is N+1 tlbs to support the
(easy?) case of es swapping.

With some additional work in cputlb, it might even be possible to have
different mmu indexes share the same backing tlb.  This would be tricky to
manage during a tlb resize, but perhaps not impossible.

Emilio, do you have any thoughts here?


> I agree that the vast majority of x86 instructions access at most one
> segment, but off-hand, I can think of a handful that access two:
> 
> - movs 
> - cmps
> - push r/m32
> - pop r/m32
> - call m32
> - call m16:m32
> 
> I'm not sure if there are others.

Sure, but my point is that we're certainly talking about 10's not 1000's, which
is where we were when talking about every memory operation for every x86
instruction.


r~
