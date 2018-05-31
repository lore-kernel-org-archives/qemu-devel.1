Received: from eggs.gnu.org ([2001:4830:134:3::10]:40923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOLA8-0002sk-Ow
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOLA7-0006E2-Ed
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:50:32 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:37573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOLA7-0006DH-5y
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:50:31 -0400
Received: by mail-oi0-x243.google.com with SMTP id l22-v6so11375148oib.4
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 03:50:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c7e4c537-2174-005b-fa15-0e8286e540ad@redhat.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-24-peter.maydell@linaro.org>
	<c049f864-304d-f8ee-4b2f-1476a602be30@redhat.com>
	<CAFEAcA_ErfYKnVrp=Dv9mNg55Y+=fFmg4eEMddGdMxUGVb9ztA@mail.gmail.com>
	<530bef1b-a143-1566-3089-32629ab250b8@redhat.com>
	<CAFEAcA94JAccGhbhSrBkTHUV+dLR-EvYQW_nuB9FodtLTDQPZw@mail.gmail.com>
	<c7e4c537-2174-005b-fa15-0e8286e540ad@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 11:50:10 +0100
Message-ID: <CAFEAcA8p=PzfMbzbE6zQ-mAhP-vgvDRvPTjharRD76BFLyS_fA@mail.gmail.com>
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

On 31 May 2018 at 11:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 30/05/2018 19:35, Peter Maydell wrote:
>> On 30 May 2018 at 17:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> On 21/05/2018 17:02, Peter Maydell wrote:
>>>> On 21 May 2018 at 15:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>>> Why do the levels have to be migrated at all?  It should be enough if
>>>>> the IRQ level is either migrated manually, or restored (e.g. in
>>>>> post_save callbacks) through other data that is migrated.
>>>> This is standard behaviour for devices: they track their
>>>> inbound irq/gpio lines, and then that becomes internal state for
>>>> them that must be migrated.
>>>
>>> But or_irq's input are another device's outbound lines, so tracking them
>>> should not be necessary.  The other device would do it for or_irq.
>>
>> There's no mechanism in qemu_irq for the destination end to ask
>> the source end about its current value. The information flow
>> is strictly one-way.
>
> On postload, the source must call qemu_set_irq and that will cause an
> update of the or_irq, won't it?

No, calling qemu_set_irq in postload is a bug. (You don't know
which order the state of the source and destination devices is
restored, so asserting a signal in postload would have different
effects depending on whether the destination had already had
its state restored or not.) The system design relies on each
device keeping track of (and migrating) the state of the input
lines it cares about.

thanks
-- PMM
