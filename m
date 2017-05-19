Received: from eggs.gnu.org ([2001:4830:134:3::10]:36400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dBiVt-0008Fi-Hq
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dBiVp-0002Mg-8i
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:04:17 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:33872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dBiVp-0002M8-17
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:04:13 -0400
Received: by mail-vk0-x244.google.com with SMTP id w1so1551015vkd.1
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 07:04:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <eebf4765-3c20-7ca4-badd-a02f3870e8a0@redhat.com>
References: <1495021572-20852-1-git-send-email-sameeh@daynix.com>
	<eebf4765-3c20-7ca4-badd-a02f3870e8a0@redhat.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Fri, 19 May 2017 17:04:11 +0300
Message-ID: <CAKPgXcHWJqHoJ4R84znRrTK68XOQbYh9fNV_vn2+xY2QHG3Tig@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Dmitry Fleytman <dmitry@daynix.com>, Yan Vugenfirer <yan@daynix.com>

On Fri, May 19, 2017 at 9:25 AM, Jason Wang <jasowang@redhat.com> wrote:

>
>
> On 2017=E5=B9=B405=E6=9C=8817=E6=97=A5 19:46, Sameeh Jubran wrote:
>
>> The bug was caused by the "receive overrun" (bit #6 of the ICR register)
>> interrupt
>> which would be triggered post migration in a heavy traffic environment.
>> Even though the
>> "receive overrun" bit (#6) is masked out by the IMS register (refer to
>> the log below)
>> the driver still receives an interrupt as the "receive overrun" bit (#6)
>> causes the
>> "Other" - bit #24 of the ICR register - bit to be set as documented
>> below. The driver
>> handles the interrupt and clears the "Other" bit (#24) but doesn't clear
>> the
>> "receive overrun" bit (#6) which leads to an infinite loop. Apparently
>> the Windows
>> driver expects that the "receive overrun" bit and other ones - documente=
d
>> below - to be
>> cleared when the "Other" bit (#24) is cleared.
>>
>> So to sum that up:
>> 1. Bit #6 of the ICR register is set by heavy traffic
>> 2. As a results of setting bit #6, bit #24 is set
>> 3. The driver receives an interrupt for bit 24 (it doesn't receieve an
>> interrupt for bit #6 as it is masked out by IMS)
>> 4. The driver handles and clears the interrupt of bit #24
>> 5. Bit #6 is still set.
>> 6. 2 happens all over again
>>
>> The Interrupt Cause Read - ICR register:
>>
>> The ICR has the "Other" bit - bit #24 - that is set when one or more of
>> the following
>> ICR register's bits are set:
>>
>> LSC - bit #2, RXO - bit #6, MDAC - bit #9, SRPD - bit #16, ACK - bit #17=
,
>> MNG - bit #18
>>
>> Log sample of the storm:
>>
>> 27563@1494850819.411877:e1000e_irq_pending_interrupts ICR PENDING:
>> 0x1000000 (ICR: 0x815000c2, IMS: 0x1a00004)
>> 27563@1494850819.411900:e1000e_irq_pending_interrupts ICR PENDING: 0x0
>> (ICR: 0x815000c2, IMS: 0xa00004)
>> 27563@1494850819.411915:e1000e_irq_pending_interrupts ICR PENDING: 0x0
>> (ICR: 0x815000c2, IMS: 0xa00004)
>> 27563@1494850819.412380:e1000e_irq_pending_interrupts ICR PENDING: 0x0
>> (ICR: 0x815000c2, IMS: 0xa00004)
>> 27563@1494850819.412395:e1000e_irq_pending_interrupts ICR PENDING: 0x0
>> (ICR: 0x815000c2, IMS: 0xa00004)
>> 27563@1494850819.412436:e1000e_irq_pending_interrupts ICR PENDING: 0x0
>> (ICR: 0x815000c2, IMS: 0xa00004)
>> 27563@1494850819.412441:e1000e_irq_pending_interrupts ICR PENDING: 0x0
>> (ICR: 0x815000c2, IMS: 0xa00004)
>> 27563@1494850819.412998:e1000e_irq_pending_interrupts ICR PENDING:
>> 0x1000000 (ICR: 0x815000c2, IMS: 0x1a00004)
>>
>> This commit solves:
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1447935
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1449490
>>
>> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
>> ---
>>   hw/net/e1000e_core.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>> index 28c5be1..8174b53 100644
>> --- a/hw/net/e1000e_core.c
>> +++ b/hw/net/e1000e_core.c
>> @@ -2454,14 +2454,17 @@ e1000e_set_ics(E1000ECore *core, int index,
>> uint32_t val)
>>   static void
>>   e1000e_set_icr(E1000ECore *core, int index, uint32_t val)
>>   {
>> +    uint32_t icr =3D 0;
>>       if ((core->mac[ICR] & E1000_ICR_ASSERTED) &&
>>           (core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME)) {
>>           trace_e1000e_irq_icr_process_iame();
>>           e1000e_clear_ims_bits(core, core->mac[IAM]);
>>       }
>>   -    trace_e1000e_irq_icr_write(val, core->mac[ICR], core->mac[ICR] &
>> ~val);
>> -    core->mac[ICR] &=3D ~val;
>> +    icr =3D core->mac[ICR] & ~val;
>> +    icr =3D (val & E1000_ICR_OTHER) ? (icr & ~E1000_ICR_OTHER_CAUSES) :
>> icr;
>> +    trace_e1000e_irq_icr_write(val, core->mac[ICR], icr);
>> +    core->mac[ICR] =3D icr;
>>       e1000e_update_interrupt_state(core);
>>   }
>>
>>
>
> Thanks for the patch.
>
> So this is an undocumented behavior, we must be careful on this. Several
> question below:
>
> - have you verified this on real hardware?
>
No I haven't

> - is MSIX enabled in this case?
>
Yes it is, I have tested the patch with msi disabled too.

> - according to the steps you've summed up above, it's not specific to
> migration?
>
True

>
> Thanks
>



--=20
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
