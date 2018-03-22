Received: from eggs.gnu.org ([2001:4830:134:3::10]:39658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ez5be-0006V3-1r
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ez5bc-0005yP-HL
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:10:33 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:34203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ez5bc-0005y2-9y
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:10:32 -0400
Received: by mail-oi0-x235.google.com with SMTP id u141-v6so8327397oif.1
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 12:10:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHNT7NsnE2ci24E8JPFRZUda2E1ZMrQaa1hyrB0NpePWp7te8A@mail.gmail.com>
References: <1521584722-39133-1-git-send-email-mjc@sifive.com>
	<2ced1950-9cbb-9230-578a-162741713ff7@amsat.org>
	<CAHNT7NsnE2ci24E8JPFRZUda2E1ZMrQaa1hyrB0NpePWp7te8A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Mar 2018 19:10:11 +0000
Message-ID: <CAFEAcA8Fx-ZtdaLk10mu_yczk2+NOko28nFZwDM6Ppm+EwpzPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] RISC-V Post-merge spec conformance
 and cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 22 March 2018 at 18:26, Michael Clark <mjc@sifive.com> wrote:
> Besides some trivial cleanups (erroneous comments, dead-code), and the cpu
> init work we were asked to work on by Peter Maydell, the focus of the
> changes are specification conformance. e.g. cases where we were trapping on
> CSR accesses when we should return 0 or cases where the page walker didn't
> comply with the specification. To review these, it will require a thorough
> reading of the RISC-V Privileged ISA Specification:
>
> - https://riscv.org/specifications/privileged-isa/
>
> Given i'm the primary active RISC-V QEMU maintainer then its mostly my
> responsibility that we conform with the RISC-V specifications.

Right, but it is also your responsibility to make the best effort
you can to make your code available for review. Sometimes there are
patches that go out on the list and just don't get any review, and
you have to make a judgement call about whether you think they're
solid enough to go in anyway. But the ideal is that those are
not very common, and you should allow plenty of time and several
"pings for review" before doing that.

I am at the moment allowing you some extra slack because risc-v
support is new to QEMU and delay at this point would risk these
things not getting into 2.12. If we were not currently in freeze
I would take the approach of asking you to submit just the reviewed
patches and let the others have more time on-list for review.

> In time we
> will have tests for these corner cases in page walker, and control and
> status registers on processor variants that implement different subsets of
> the specification (such as SiFive's E series that has no MMU and no S mode,
> versus the SiFive U series which implements S mode and has an MMU), but at
> this stage it requires a very careful reading of the RISC-V ISA Privileged
> ISA Specification.
>
> We will more changes and the patch queue will only grow longer. Soon we will
> be trapping on s* CSRs if misa.S is not set and we'll add
> RISCV_FEATURE_MMU_HW_AD so that we can distinguish processors that handle
> PTE AD bits in hardware vs processors that defer PTE AD bit handling to
> software. These can only be reviewed by someone who is familar with the
> RISC-V Privileged ISA specification.

Pretty much all of our target frontends require at least some
familiarity with the relevant ISA specifications, yes. (You can
get a long way with knowing ISAs in general and having the manual,
though. We have several developers who have reviewed code for
multiple different supported guest architectures.)
Code review isn't only about "does this behave as the
secification requires". It can also catch:
 * simple logic bugs
 * places where the code is more complicated than it needs to be
 * style issues
 * places where a QEMU utility routine could have been used
 * misunderstandings about QEMU internal APIs
 * memory leaks or memory corruption bugs
Review by somebody who is familiar with QEMU is just as useful
as review by somebody familiar with the target ISA.

>> In your 25 matches, only 12 have R-b tag.
>>
>> You could have sent a PR of the reviewed patches, and respin the
>> unreviewed patches separately.
>>
>> I also see you addressed some of my comments, so I'd have liked be able
>> to take time to review and eventually test your series.
>
>
> Sure take your time, however do consider that we should be able to fix bugs
> as a maintainer for RISC-V. I'm very able to separate well-tested changes
> from experimental code. e.g
>
> - https://github.com/michaeljclark/riscv-qemu/tree/wip-riscv-tcg-backend
>
> It will be some time before we submit patches for the RISC-V backend. It
> needs to be rock-solid before I would consider submitting it.

This is perhaps not the best possible approach. You will find
that it's easier to get code into QEMU (and many upstream projects)
if you do the development as a part of that upstream. So for
instance you can submit "RFC" patches if they're work in progress,
or initial versions of a patchset which implement a basic working
version with optimizations to follow. (You just need to be clear
in a patchset cover letter what is/isn't implemented, what you're
asking for review on, and so on.) If you do that then you won't
find yourself in the position of submitting what you think is a
complete finished feature and being asked to do significant rework.
You also are less likely find yourself two weeks before a codefreeze
with a large pile of unreviewed and uncommitted changes and
having huge difficulty getting your code into the tree.

In my experience the best way to work is "upstream first" and
incrementally, so that large features and bugfixes all go onto
the list, get reviewed and then go into upstream in small parts
over the whole QEMU development cycle. It's often possible
to put not-yet-finished work behind a feature-bit gate that means
that it doesn't appear to guests until it's finished and the
feature-bit is enabled.

Working incrementally also significantly improves the odds of
your code getting prompt review. A 20 patch patchset is a large
chunk of work to review, and is likely to be put off or ignored.
Four separate 5 patch sets sent out over a week or two are
much easier for reviewers to digest, and for people to review
even if risc-v stuff isn't their primary focus.

If your queue of unsubmitted or unreviewed patches is steadily
getting longer then something is going wrong; you should be
aiming for it to be as short as possible.

thanks
-- PMM
