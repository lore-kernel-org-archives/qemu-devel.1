Received: from eggs.gnu.org ([2001:4830:134:3::10]:38723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dCl9x-0006fP-GP
	for qemu-devel@nongnu.org; Mon, 22 May 2017 07:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dCl9s-0000wU-Vk
	for qemu-devel@nongnu.org; Mon, 22 May 2017 07:05:57 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:34370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dCl9s-0000vw-ML
	for qemu-devel@nongnu.org; Mon, 22 May 2017 07:05:52 -0400
Received: by mail-ua0-x243.google.com with SMTP id j17so7427281uag.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 04:05:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <39c5030d-6de6-a3b9-355d-2abeaacc3317@redhat.com>
References: <1495021572-20852-1-git-send-email-sameeh@daynix.com>
	<eebf4765-3c20-7ca4-badd-a02f3870e8a0@redhat.com>
	<CAKPgXcHWJqHoJ4R84znRrTK68XOQbYh9fNV_vn2+xY2QHG3Tig@mail.gmail.com>
	<39c5030d-6de6-a3b9-355d-2abeaacc3317@redhat.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 22 May 2017 14:05:50 +0300
Message-ID: <CAKPgXcGks5XjMzzqRw--ok72WaiBw7-Z_jOQj+JTtspGd=fsug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] e1000e: Fix a bug where guest hangs upon
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Dmitry Fleytman <dmitry@daynix.com>, Yan Vugenfirer <yan@daynix.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, May 22, 2017 at 5:46 AM, Jason Wang <jasowang@redhat.com> wrote:

>
>
> On 2017=E5=B9=B405=E6=9C=8819=E6=97=A5 22:04, Sameeh Jubran wrote:
>
>> On Fri, May 19, 2017 at 9:25 AM, Jason Wang <jasowang@redhat.com> wrote:
>>
>>
>>> On 2017=E5=B9=B405=E6=9C=8817=E6=97=A5 19:46, Sameeh Jubran wrote:
>>>
>>> The bug was caused by the "receive overrun" (bit #6 of the ICR register=
)
>>>> interrupt
>>>> which would be triggered post migration in a heavy traffic environment=
.
>>>> Even though the
>>>> "receive overrun" bit (#6) is masked out by the IMS register (refer to
>>>> the log below)
>>>> the driver still receives an interrupt as the "receive overrun" bit (#=
6)
>>>> causes the
>>>> "Other" - bit #24 of the ICR register - bit to be set as documented
>>>> below. The driver
>>>> handles the interrupt and clears the "Other" bit (#24) but doesn't cle=
ar
>>>> the
>>>> "receive overrun" bit (#6) which leads to an infinite loop. Apparently
>>>> the Windows
>>>> driver expects that the "receive overrun" bit and other ones -
>>>> documented
>>>> below - to be
>>>> cleared when the "Other" bit (#24) is cleared.
>>>>
>>>> So to sum that up:
>>>> 1. Bit #6 of the ICR register is set by heavy traffic
>>>> 2. As a results of setting bit #6, bit #24 is set
>>>> 3. The driver receives an interrupt for bit 24 (it doesn't receieve an
>>>> interrupt for bit #6 as it is masked out by IMS)
>>>> 4. The driver handles and clears the interrupt of bit #24
>>>> 5. Bit #6 is still set.
>>>> 6. 2 happens all over again
>>>>
>>>> The Interrupt Cause Read - ICR register:
>>>>
>>>> The ICR has the "Other" bit - bit #24 - that is set when one or more o=
f
>>>> the following
>>>> ICR register's bits are set:
>>>>
>>>> LSC - bit #2, RXO - bit #6, MDAC - bit #9, SRPD - bit #16, ACK - bit
>>>> #17,
>>>> MNG - bit #18
>>>>
>>>> Log sample of the storm:
>>>>
>>>> 27563@1494850819.411877:e1000e_irq_pending_interrupts ICR PENDING:
>>>> 0x1000000 (ICR: 0x815000c2, IMS: 0x1a00004)
>>>> 27563@1494850819.411900:e1000e_irq_pending_interrupts ICR PENDING: 0x0
>>>> (ICR: 0x815000c2, IMS: 0xa00004)
>>>> 27563@1494850819.411915:e1000e_irq_pending_interrupts ICR PENDING: 0x0
>>>> (ICR: 0x815000c2, IMS: 0xa00004)
>>>> 27563@1494850819.412380:e1000e_irq_pending_interrupts ICR PENDING: 0x0
>>>> (ICR: 0x815000c2, IMS: 0xa00004)
>>>> 27563@1494850819.412395:e1000e_irq_pending_interrupts ICR PENDING: 0x0
>>>> (ICR: 0x815000c2, IMS: 0xa00004)
>>>> 27563@1494850819.412436:e1000e_irq_pending_interrupts ICR PENDING: 0x0
>>>> (ICR: 0x815000c2, IMS: 0xa00004)
>>>> 27563@1494850819.412441:e1000e_irq_pending_interrupts ICR PENDING: 0x0
>>>> (ICR: 0x815000c2, IMS: 0xa00004)
>>>> 27563@1494850819.412998:e1000e_irq_pending_interrupts ICR PENDING:
>>>> 0x1000000 (ICR: 0x815000c2, IMS: 0x1a00004)
>>>>
>>>> This commit solves:
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1447935
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1449490
>>>>
>>>> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
>>>> ---
>>>>    hw/net/e1000e_core.c | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>>>> index 28c5be1..8174b53 100644
>>>> --- a/hw/net/e1000e_core.c
>>>> +++ b/hw/net/e1000e_core.c
>>>> @@ -2454,14 +2454,17 @@ e1000e_set_ics(E1000ECore *core, int index,
>>>> uint32_t val)
>>>>    static void
>>>>    e1000e_set_icr(E1000ECore *core, int index, uint32_t val)
>>>>    {
>>>> +    uint32_t icr =3D 0;
>>>>        if ((core->mac[ICR] & E1000_ICR_ASSERTED) &&
>>>>            (core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME)) {
>>>>            trace_e1000e_irq_icr_process_iame();
>>>>            e1000e_clear_ims_bits(core, core->mac[IAM]);
>>>>        }
>>>>    -    trace_e1000e_irq_icr_write(val, core->mac[ICR], core->mac[ICR]
>>>> &
>>>> ~val);
>>>> -    core->mac[ICR] &=3D ~val;
>>>> +    icr =3D core->mac[ICR] & ~val;
>>>> +    icr =3D (val & E1000_ICR_OTHER) ? (icr & ~E1000_ICR_OTHER_CAUSES)=
 :
>>>> icr;
>>>> +    trace_e1000e_irq_icr_write(val, core->mac[ICR], icr);
>>>> +    core->mac[ICR] =3D icr;
>>>>        e1000e_update_interrupt_state(core);
>>>>    }
>>>>
>>>>
>>>> Thanks for the patch.
>>>
>>> So this is an undocumented behavior, we must be careful on this. Severa=
l
>>> question below:
>>>
>>> - have you verified this on real hardware?
>>>
>>> No I haven't
>>
>
> Any chance to verify the behavior on real hardware?

This can be very challenging to reproduce on a real hardware as the Windows
source code isn't available and the bug doesn't
reproduce with the Linux driver; Moreover, the Linux driver configures the
device differently than the Windows driver.

>
>
>
>> - is MSIX enabled in this case?
>>>
>>> Yes it is, I have tested the patch with msi disabled too.
>>
>
> Does the problem exist in no msi case. If not, is this better to hack EIA=
C
> behavior?

Even though it doesn't reproduce in no msi case, this certainly can occur
as the ICR register is present in both msi and
no msi cases while the EIAC register is for MSI only.

>
>> - according to the steps you've summed up above, it's not specific to
>>> migration?
>>>
>>> True
>>
>
> Then we probably need tweak the title.
>
No problem, I'll send a v2 soon.

> Thanks.
>
>
>> Thanks
>>>
>>>
>>
>>
>


--=20
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
