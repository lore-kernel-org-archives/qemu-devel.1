Received: from eggs.gnu.org ([2001:4830:134:3::10]:38419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYv1I-0004Zy-0x
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYv1H-0008B5-0V
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:09:07 -0400
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:38581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYv1G-00089G-FW
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:09:06 -0400
Received: by mail-ot0-x236.google.com with SMTP id w22-v6so10282844otk.5
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 08:09:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <eb78a151-b5e4-87c6-89d6-a527904c0961@linaro.org>
References: <20180629001538.11415-1-richard.henderson@linaro.org>
	<20180629001538.11415-7-richard.henderson@linaro.org>
	<CAFEAcA9JkC_9niGrEoVf8FKzT+k6yn0WS0Mjbwz8WpLpzJhszQ@mail.gmail.com>
	<eb78a151-b5e4-87c6-89d6-a527904c0961@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 16:08:45 +0100
Message-ID: <CAFEAcA8t3n2p3v75q3EoAUD=jvi=zDB=F_=VBHK3knTMSPHx2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 6/6] target/arm: Set ISAR bits for -cpu max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 29 June 2018 at 15:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 06/29/2018 01:42 AM, Peter Maydell wrote:
>> On 29 June 2018 at 01:15, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>> For the supported extensions, fill in the appropriate bits in
>>> ID_ISAR5, ID_ISAR6, ID_AA64ISAR0, ID_AA64ISAR1.

>> This makes sense, but I'd rather have a bit of time to think
>> about how exactly we want to handle feature bits vs ID
>> register values (the current codebase is not entirely
>> coherent on the topic), so I'd rather not put this in
>> for softfreeze unless there's a strong reason we should...
>
> Fair.
>
> I was wondering if we'd post-process the feature bits to initialize the id
> registers, so that we don't have different places with the same knowledge.
>
> The clearing of EL3 bits from id_pfr1 is an example of that already.

Yes, exactly. We have a few bits that are odd like that,
where we've kind of ad-hoc tweaked stuff to make things work.
I'd rather we decided on a coherent design and then moved
the code to do that. (Another example is Aaron's PMUv3
patchset, which wants to tweak the PMU related ID registers
to match what the emulation code implements.)

The original QEMU design I think was more or less "we report
fixed ID regs which don't necessarily match our actual
capabilities" (which is also how a KVM vCPU will behave).
"Feature bits are the primary source of truth" is also a
coherent design, just not the one we started with...

thanks
-- PMM
