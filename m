Received: from eggs.gnu.org ([2001:4830:134:3::10]:37468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWMkC-0003KQ-G3
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWMkB-00052C-82
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:08:56 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:39605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWMkB-00051z-1Q
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:08:55 -0400
Received: by mail-ot0-x244.google.com with SMTP id l15-v6so7614754oth.6
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:08:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180622135045.GD12424@codeaurora.org>
References: <1523997485-1905-1-git-send-email-alindsay@codeaurora.org>
	<1523997485-1905-4-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA_g1Bb=-cj+QToHDypZPiqw_U5YioRWfDSs0Ano3PqDTQ@mail.gmail.com>
	<20180622135045.GD12424@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 15:08:33 +0100
Message-ID: <CAFEAcA_EEXRQQjXDsei0Y6mQB6EVTtJB5=EFHFsT7kbZk5iv6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 03/21] target/arm: Reorganize PMCCNTR
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 22 June 2018 at 14:50, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> On Apr 20 11:17, Peter Maydell wrote:
>> On 17 April 2018 at 21:37, Aaron Lindsay <alindsay@codeaurora.org> wrote:
>> > pmccntr_read and pmccntr_write contained duplicate code that was already
>> > being handled by pmccntr_sync. Consolidate the duplicated code into two
>> > functions: pmccntr_op_start and pmccntr_op_finish. Add a companion to
>> > c15_ccnt in CPUARMState so that we can simultaneously save both the
>> > architectural register value and the last underlying cycle count - this
>> > ensure time isn't lost and will also allow us to access the 'old'
>> > architectural register value in order to detect overflows in later
>> > patches.
>> >
>> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>

>> > -        /* If the counter is enabled, this stores the last time the counter
>> > -         * was reset. Otherwise it stores the counter value
>> > +        /* Stores the architectural value of the counter *the last time it was
>> > +         * updated* by pmccntr_op_start. Accesses should always be surrounded
>> > +         * by pmccntr_op_start/pmccntr_op_finish to guarantee the latest
>> > +         * architecturally-corect value is being read/set.
>> >           */
>> >          uint64_t c15_ccnt;
>> > +        /* Stores the delta between the architectural value and the underlying
>> > +         * cycle count during normal operation. It is used to update c15_ccnt
>> > +         * to be the correct architectural value before accesses. During
>> > +         * accesses, c15_ccnt_delta contains the underlying count being used
>> > +         * for the access, after which it reverts to the delta value in
>> > +         * pmccntr_op_finish.
>> > +         */
>> > +        uint64_t c15_ccnt_delta;
>>
>> So the key question here is: how does this work for VM migration?
>
> To be honest, I'm not sure I fully understand the things I need to be
> looking out for with VM migration.
>
> My guess, though, is that this current implementation is not sufficient.
> Perhaps there needs to be logic to ensure that c15_ccnt is the current
> architectural value before migration and also to setup c15_ccnt_delta to
> be the delta between that architectural value and the underlying cycle
> count upon inbound migration. Does that sound like an approach which
> would fit well within the rest of the migration framework?

You need to deal with two different situations:
 (1) migration from an older QEMU which doesn't have this patchset
 (2) migration from a QEMU with this patchset to one with this patchset

Either:
 (a) all the architectural state can be expressed in our existing
state fields in whatever the previous format was -- in this case
you just need to ensure that cpu_pre_save() and cpu_post_load()
put the state there and unpack it again
 (b) we were missing some architectural state and really do need
to transfer more over the wire than we were before -- in this case
you need to add a new subsection to the vmstate which has the fields
that contain that new state, and give the subsection a suitable 'needed'
function to indicate when the subsection should be transferred plus
pre_load and post_load functions that allow us to cope correctly with
the case of the older QEMU that doesn't send the subsection.

thanks
-- PMM
