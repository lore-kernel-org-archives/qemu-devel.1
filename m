Received: from eggs.gnu.org ([2001:4830:134:3::10]:36586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIdg7-0005Ob-LR
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIdg4-0006lM-L4
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:56:13 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIdg3-0006Rd-Jc
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:56:12 -0400
Received: by mail-oi1-x244.google.com with SMTP id h23-v6so2257180oih.9
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 10:55:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181016093703.10637-1-peter.maydell@linaro.org>
References: <20181016093703.10637-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 17:55:26 +0000
Message-ID: <CAFEAcA-sh3mb3prsrvd8J1sVDsmJN7wbsoQtn1CdniRMfzvr4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/2] target/arm: fix some ATS*
 bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

Ping for code review, please?

thanks
-- PMM

On 16 October 2018 at 10:37, Peter Maydell <peter.maydell@linaro.org> wrote:
> This small patchset fixes a couple of bugs in our ATS insn
> handling:
>  * for faults reported to the 64-bit PAR we were not
>    setting the S and PTW bits to indicate stage 2
>    fault information
>    (NB: stage 2 faults aren't reported with 32-bit
>    PAR formats so there's no need to change the 32-bit
>    code path)
>  * ATS1Hx were implementing the wrong thing (doing a
>    stage 2 lookup rather than an EL2 stage 1 lookup)
>
> The major missing bit of ATS at the moment is that a stage
> 2 fault during execution of an NS-EL1 ATS insn that asks
> for a stage 1 lookup should cause a trap to EL2. I started
> to sketch out some code to do that, but I realised by
> putting an assert() in it that I didn't have any guests
> that actually hit the problem, so put it on the back burner.
> If anybody does hit that missing feature, feel free to send
> me a test case :-)
>
> Based-on: <20181012144235.19646-1-peter.maydell@linaro.org>
> ("[PATCH 00/10] target/arm: more HCR bits, improve syndrome reporting")
> but only to avoid a textual conflict in the patch context.
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   target/arm: Set S and PTW in 64-bit PAR format
>   target/arm: Fix ATS1Hx instructions
>
>  target/arm/helper.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
