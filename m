Received: from eggs.gnu.org ([2001:4830:134:3::10]:35743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOMFH-0003Yw-Ue
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOMFH-0004hT-4u
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:59:56 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOMFG-0004h0-VR
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:59:55 -0400
Received: by mail-oi0-x242.google.com with SMTP id 14-v6so11239512oie.3
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 04:59:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <35601960-682e-9ccc-c724-2c6504e8cc2c@redhat.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-24-peter.maydell@linaro.org>
	<c049f864-304d-f8ee-4b2f-1476a602be30@redhat.com>
	<CAFEAcA_ErfYKnVrp=Dv9mNg55Y+=fFmg4eEMddGdMxUGVb9ztA@mail.gmail.com>
	<530bef1b-a143-1566-3089-32629ab250b8@redhat.com>
	<CAFEAcA94JAccGhbhSrBkTHUV+dLR-EvYQW_nuB9FodtLTDQPZw@mail.gmail.com>
	<c7e4c537-2174-005b-fa15-0e8286e540ad@redhat.com>
	<CAFEAcA8p=PzfMbzbE6zQ-mAhP-vgvDRvPTjharRD76BFLyS_fA@mail.gmail.com>
	<35601960-682e-9ccc-c724-2c6504e8cc2c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 12:59:33 +0100
Message-ID: <CAFEAcA_8cPWHUQaBFE4hO=YKCTHUpNyBk=LUt11EePvU417j_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 23/27] hw/core/or-irq: Support more than 16
 inputs to an OR gate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Richard Henderson <rth@twiddle.net>

On 31 May 2018 at 12:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 31/05/2018 12:50, Peter Maydell wrote:
>> No, calling qemu_set_irq in postload is a bug. (You don't know
>> which order the state of the source and destination devices is
>> restored, so asserting a signal in postload would have different
>> effects depending on whether the destination had already had
>> its state restored or not.)
>
> Hmm, I suppose the x86 world is a bit more "hierarchical" and you cannot
> create a qemu_irq loop - and creating the sink always before the source
> ensures that migration works fine with post_load.  I'm pretty sure that
> there are devices that do that

If there are then they are broken, because that's not how
qemu_irqs work... (Similarly, you can't assert an irq
in a reset method, because of ordering problems.)

>, and an interesting case (for the sake of
> this thread) is the IOMMU, which prompted the introduction of
> MigrationPriority.  Thanks for the lesson! :)

This sounds like a workaround for a bug in the device implementation.
Devices shouldn't care about which order they're restored in.

thanks
-- PMM
