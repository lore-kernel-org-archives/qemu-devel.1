Received: from eggs.gnu.org ([2001:4830:134:3::10]:40523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZc81-0003A6-Ju
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZc80-0002WY-K2
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:34:09 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:32911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZc80-0002Va-DQ
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:34:08 -0500
Received: by mail-wm0-x22b.google.com with SMTP id t18so13876991wmt.0
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 03:34:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170201150553.9381-25-alex.bennee@linaro.org>
References: <20170201150553.9381-1-alex.bennee@linaro.org>
	<20170201150553.9381-25-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 11:33:46 +0000
Message-ID: <CAFEAcA-eB9mzS=j5Y1Upb2f2xw6zjtiRHTXcUY0BLDhL4WasZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 24/25] target-arm: ensure all cross
 vCPUs TLB flushes complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 1 February 2017 at 15:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Previously flushes on other vCPUs would only get serviced when they
> exited their TranslationBlocks. While this isn't overly problematic it
> violates the semantics of TLB flush from the point of view of source
> vCPU.
>
> To solve this we call the cputlb *_all_cpus_synced() functions to do
> the flushes and ask it to ensure all flushes are completed before we
> start the next instruction. As this involves exiting the cpu_loop we
> need to ensure the PC is saved before the tlb helper functions are
> called.

So, to continue the discussion from my comments on the previous round
of this patch: I definitely think that having the helper function
longjump out of the main loop is awkward and is going to cause
problems (for any target doing that, not just ARM). At the moment
we use the longjump-out approach primarily for "this instruction
didn't actually execute". That works fine because "don't actually
do anything else we generated code for" is what we want there.
Trying to longjump-out for "this instruction *did* execute but
we want to get back to the main loop" is more problematic, because
now we really do want to run the generated code that follows,
and so you end up having to duplicate the equivalent operations,
which is error-prone. ("yield" also falls into this bucket, but
we got away with that because it's practically a no-op. Really
we should fix it too, I suspect we get single-step of it wrong.)

So instead we should avoid the longjumping and have a mechanism
for making sure the code we generate after this helper is called
ends the TB in a way that takes us back out to the top level
in the right way.

The "do a TLB sync and longjump out" functions are an invitation
to target CPU implementors to write buggy code, so we should
I think not have them at all.

thanks
-- PMM
