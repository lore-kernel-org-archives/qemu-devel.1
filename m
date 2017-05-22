Received: from eggs.gnu.org ([2001:4830:134:3::10]:52389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCdMk-00046r-L6
	for qemu-devel@nongnu.org; Sun, 21 May 2017 22:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCdMh-0000Mg-JQ
	for qemu-devel@nongnu.org; Sun, 21 May 2017 22:46:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dCdMh-0000MT-AN
	for qemu-devel@nongnu.org; Sun, 21 May 2017 22:46:35 -0400
References: <1495021572-20852-1-git-send-email-sameeh@daynix.com>
	<eebf4765-3c20-7ca4-badd-a02f3870e8a0@redhat.com>
	<CAKPgXcHWJqHoJ4R84znRrTK68XOQbYh9fNV_vn2+xY2QHG3Tig@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <39c5030d-6de6-a3b9-355d-2abeaacc3317@redhat.com>
Date: Mon, 22 May 2017 10:46:29 +0800
MIME-Version: 1.0
In-Reply-To: <CAKPgXcHWJqHoJ4R84znRrTK68XOQbYh9fNV_vn2+xY2QHG3Tig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Sameeh Jubran <sameeh@daynix.com>
Cc: Dmitry Fleytman <dmitry@daynix.com>, Yan Vugenfirer <yan@daynix.com>, QEMU Developers <qemu-devel@nongnu.org>



On 2017=E5=B9=B405=E6=9C=8819=E6=97=A5 22:04, Sameeh Jubran wrote:
> On Fri, May 19, 2017 at 9:25 AM, Jason Wang <jasowang@redhat.com> wrote=
:
>
>>
>> On 2017=E5=B9=B405=E6=9C=8817=E6=97=A5 19:46, Sameeh Jubran wrote:
>>
>>> The bug was caused by the "receive overrun" (bit #6 of the ICR regist=
er)
>>> interrupt
>>> which would be triggered post migration in a heavy traffic environmen=
t.
>>> Even though the
>>> "receive overrun" bit (#6) is masked out by the IMS register (refer t=
o
>>> the log below)
>>> the driver still receives an interrupt as the "receive overrun" bit (=
#6)
>>> causes the
>>> "Other" - bit #24 of the ICR register - bit to be set as documented
>>> below. The driver
>>> handles the interrupt and clears the "Other" bit (#24) but doesn't cl=
ear
>>> the
>>> "receive overrun" bit (#6) which leads to an infinite loop. Apparentl=
y
>>> the Windows
>>> driver expects that the "receive overrun" bit and other ones - docume=
nted
>>> below - to be
>>> cleared when the "Other" bit (#24) is cleared.
>>>
>>> So to sum that up:
>>> 1. Bit #6 of the ICR register is set by heavy traffic
>>> 2. As a results of setting bit #6, bit #24 is set
>>> 3. The driver receives an interrupt for bit 24 (it doesn't receieve a=
n
>>> interrupt for bit #6 as it is masked out by IMS)
>>> 4. The driver handles and clears the interrupt of bit #24
>>> 5. Bit #6 is still set.
>>> 6. 2 happens all over again
>>>
>>> The Interrupt Cause Read - ICR register:
>>>
>>> The ICR has the "Other" bit - bit #24 - that is set when one or more =
of
>>> the following
>>> ICR register's bits are set:
>>>
>>> LSC - bit #2, RXO - bit #6, MDAC - bit #9, SRPD - bit #16, ACK - bit =
#17,
>>> MNG - bit #18
>>>
>>> Log sample of the storm:
>>>
>>> 27563@1494850819.411877:e1000e_irq_pending_interrupts ICR PENDING:
>>> 0x1000000 (ICR: 0x815000c2, IMS: 0x1a00004)
>>> 27563@1494850819.411900:e1000e_irq_pending_interrupts ICR PENDING: 0x=
0
>>> (ICR: 0x815000c2, IMS: 0xa00004)
>>> 27563@1494850819.411915:e1000e_irq_pending_interrupts ICR PENDING: 0x=
0
>>> (ICR: 0x815000c2, IMS: 0xa00004)
>>> 27563@1494850819.412380:e1000e_irq_pending_interrupts ICR PENDING: 0x=
0
>>> (ICR: 0x815000c2, IMS: 0xa00004)
>>> 27563@1494850819.412395:e1000e_irq_pending_interrupts ICR PENDING: 0x=
0
>>> (ICR: 0x815000c2, IMS: 0xa00004)
>>> 27563@1494850819.412436:e1000e_irq_pending_interrupts ICR PENDING: 0x=
0
>>> (ICR: 0x815000c2, IMS: 0xa00004)
>>> 27563@1494850819.412441:e1000e_irq_pending_interrupts ICR PENDING: 0x=
0
>>> (ICR: 0x815000c2, IMS: 0xa00004)
>>> 27563@1494850819.412998:e1000e_irq_pending_interrupts ICR PENDING:
>>> 0x1000000 (ICR: 0x815000c2, IMS: 0x1a00004)
>>>
>>> This commit solves:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1447935
>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1449490
>>>
>>> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
>>> ---
>>>    hw/net/e1000e_core.c | 7 +++++--
>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>>> index 28c5be1..8174b53 100644
>>> --- a/hw/net/e1000e_core.c
>>> +++ b/hw/net/e1000e_core.c
>>> @@ -2454,14 +2454,17 @@ e1000e_set_ics(E1000ECore *core, int index,
>>> uint32_t val)
>>>    static void
>>>    e1000e_set_icr(E1000ECore *core, int index, uint32_t val)
>>>    {
>>> +    uint32_t icr =3D 0;
>>>        if ((core->mac[ICR] & E1000_ICR_ASSERTED) &&
>>>            (core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME)) {
>>>            trace_e1000e_irq_icr_process_iame();
>>>            e1000e_clear_ims_bits(core, core->mac[IAM]);
>>>        }
>>>    -    trace_e1000e_irq_icr_write(val, core->mac[ICR], core->mac[ICR=
] &
>>> ~val);
>>> -    core->mac[ICR] &=3D ~val;
>>> +    icr =3D core->mac[ICR] & ~val;
>>> +    icr =3D (val & E1000_ICR_OTHER) ? (icr & ~E1000_ICR_OTHER_CAUSES=
) :
>>> icr;
>>> +    trace_e1000e_irq_icr_write(val, core->mac[ICR], icr);
>>> +    core->mac[ICR] =3D icr;
>>>        e1000e_update_interrupt_state(core);
>>>    }
>>>
>>>
>> Thanks for the patch.
>>
>> So this is an undocumented behavior, we must be careful on this. Sever=
al
>> question below:
>>
>> - have you verified this on real hardware?
>>
> No I haven't

Any chance to verify the behavior on real hardware?

>
>> - is MSIX enabled in this case?
>>
> Yes it is, I have tested the patch with msi disabled too.

Does the problem exist in no msi case. If not, is this better to hack=20
EIAC behavior?

>
>> - according to the steps you've summed up above, it's not specific to
>> migration?
>>
> True

Then we probably need tweak the title.

Thanks.

>
>> Thanks
>>
>
>
