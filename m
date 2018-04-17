Received: from eggs.gnu.org ([2001:4830:134:3::10]:52405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8SgH-0000FR-Ap
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8SgG-0004Ri-JB
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:38:05 -0400
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:41585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8SgG-0004RM-DB
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:38:04 -0400
Received: by mail-ot0-x22e.google.com with SMTP id m22-v6so21837549otf.8
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 08:38:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180417152101.GP24561@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-13-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA_UP-DgPZPL8-sMAs9TFHiUrfya8LAxAnO2U_WJAMH6yg@mail.gmail.com>
	<20180412173625.GK24561@codeaurora.org>
	<20180417152101.GP24561@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 16:37:43 +0100
Message-ID: <CAFEAcA_QdPChiMPtZt7t_aqQTUcSDweGVG0anchKYH6KtEgEYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 12/22] target/arm: Filter cycle counter
 based on PMCCFILTR_EL0
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

On 17 April 2018 at 16:21, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> On Apr 12 13:36, Aaron Lindsay wrote:
>> On Apr 12 18:15, Peter Maydell wrote:
>> > On 16 March 2018 at 20:31, Aaron Lindsay <alindsay@codeaurora.org> wrote:
>> > > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> > > index b0ef727..9c3b5ef 100644
>> > > --- a/target/arm/cpu.h
>> > > +++ b/target/arm/cpu.h
>> > > @@ -458,6 +458,11 @@ typedef struct CPUARMState {
>> > >           * was reset. Otherwise it stores the counter value
>> > >           */
>> > >          uint64_t c15_ccnt;
>> > > +        /* ccnt_cached_cycles is used to hold the last cycle count when
>> > > +         * c15_ccnt holds the guest-visible count instead of the delta during
>> > > +         * PMU operations which require this.
>> > > +         */
>> > > +        uint64_t ccnt_cached_cycles;
>> >
>> > Can this ever hold valid state at a point when we need to do VM
>> > migration, or is it purely temporary ?
>>
>> I believe that as of this version of the patch it is temporary and will
>> not need to be migrated. However, I believe it's going to be necessary
>> to have two variables to represent the state of each counter in order to
>> implement interrupt on overflow.
>
> Coming back around to this, I don't see a way around using two variables
> to hold PMCCNTR's full state to make interrupt on overflow work. I
> haven't been able to find other examples or documentation covering state
> needing to be updated in more than one location for a given CP register
> - do you know of any I've missed or have recommendations about how to
> approach this?

Can you explain the problem in more detail? In general it's a bit of
a red flag if you think you need more state storage space than the
hardware has, and I don't think there's any "hidden" state in the h/w here.

thanks
-- PMM
