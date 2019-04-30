Received: from eggs.gnu.org ([209.51.188.92]:40328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1hLLSs-0000QM-LX
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 01:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1hLLSr-0005Wt-AZ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 01:38:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2205 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <longpeng2@huawei.com>)
	id 1hLLSq-0005WQ-Oj
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 01:38:01 -0400
Message-ID: <5CC7DF2D.7030109@huawei.com>
Date: Tue, 30 Apr 2019 13:37:49 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1556523569-44480-1-git-send-email-longpeng2@huawei.com>
	<7e19e93d-9ad4-51a8-3c1e-ed4d1672a47f@redhat.com>
	<5CC6E333.90108@huawei.com>
	<a14a352c-2587-11a6-7068-01bf52bac817@redhat.com>
	<5CC7ACC7.2010306@huawei.com>
	<ae81a8f8-fd36-a4b3-0c8c-4a6d698959a7@redhat.com>
In-Reply-To: <ae81a8f8-fd36-a4b3-0c8c-4a6d698959a7@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] usb/xchi: avoid trigger assertion if guest
 write wrong epid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: kraxel@redhat.com, Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org



On 2019/4/30 13:06, Philippe Mathieu-Daud=C3=A9 wrote:

> On 4/30/19 4:02 AM, Longpeng (Mike) wrote:
>> On 2019/4/29 20:10, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 4/29/19 1:42 PM, Longpeng (Mike) wrote:
>>>> Hi Philippe,
>>>>
>>>> On 2019/4/29 19:16, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>
>>>>> Hi Mike,
>>>>>
>>>>> On 4/29/19 9:39 AM, Longpeng(Mike) wrote:
>>>>>> From: Longpeng <longpeng2@huawei.com>
>>>>>>
>>>>>> we found the following core in our environment:
>>>>>> 0  0x00007fc6b06c2237 in raise ()
>>>>>> 1  0x00007fc6b06c3928 in abort ()
>>>>>> 2  0x00007fc6b06bb056 in __assert_fail_base ()
>>>>>> 3  0x00007fc6b06bb102 in __assert_fail ()
>>>>>> 4  0x0000000000702e36 in xhci_kick_ep (...)
>>>>>
>>>>>   5 xhci_doorbell_write?
>>>>>
>>>>>> 6  0x000000000047767f in access_with_adjusted_size (...)
>>>>>> 7  0x000000000047944d in memory_region_dispatch_write (...)
>>>>>> 8  0x000000000042df17 in address_space_write_continue (...)
>>>>>> 10 0x000000000043084d in address_space_rw (...)
>>>>>> 11 0x000000000047451b in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x1ab11b0=
)
>>>>>> 12 0x000000000045dcf5 in qemu_kvm_cpu_thread_fn (arg=3D0x1ab11b0)
>>>>>> 13 0x0000000000870631 in qemu_thread_start (args=3Dargs@entry=3D0x=
1acfb50)
>>>>>> 14 0x00000000008959a7 in thread_entry_for_hotfix (pthread_cb=3D<op=
timized out>)
>>>>>> 15 0x00007fc6b0a60dd5 in start_thread ()
>>>>>> 16 0x00007fc6b078a59d in clone ()
>>>>>> (gdb) bt
>>>>>> (gdb) f 5
>>>>>
>>>>> This is the frame you removed...
>>>>>
>>>>>> (gdb) p /x tmp
>>>>>> $9 =3D 0x62481a00 <-- last byte 0x00 is @epid
>>>>>
>>>>> I don't see 'tmp' in xhci_doorbell_write().
>>>>>
>>>>> Can you use trace events?
>>>>>
>>>>> There we have trace_usb_xhci_doorbell_write().
>>>>>
>>>>
>>>> Sorry , I'm careless to remove the important information.
>>>>
>>>>
>>>> This is our whole frame:
>>>>
>>>> (gdb) bt
>>>> #0  0x00007fc6b06c2237 in raise () from /usr/lib64/libc.so.6
>>>> #1  0x00007fc6b06c3928 in abort () from /usr/lib64/libc.so.6
>>>> #2  0x00007fc6b06bb056 in __assert_fail_base () from /usr/lib64/libc=
.so.6
>>>> #3  0x00007fc6b06bb102 in __assert_fail () from /usr/lib64/libc.so.6
>>>> #4  0x0000000000702e36 in xhci_kick_ep (...)
>>>> #5  0x000000000047897a in memory_region_write_accessor (...)
>>>> #6  0x000000000047767f in access_with_adjusted_size (...)
>>>> #7  0x000000000047944d in memory_region_dispatch_write
>>>> (mr=3Dmr@entry=3D0x7fc6a0138df0, addr=3Daddr@entry=3D156, data=3D164=
8892416,
>>>> size=3Dsize@entry=3D4, attrs=3Dattrs@entry=3D...)
>>>
>>> So this is a 32-bit access, to address 156 (which is the slotid) and
>>> data=3D1648892416=3D0x62481a00 indeed.
>>>
>>> But watch out access_with_adjusted_size() calls adjust_endianness()..=
.
>>>
>>>> #8  0x000000000042df17 in address_space_write_continue (...)
>>>> #9  0x00000000004302d5 in address_space_write (...)
>>>> #10 0x000000000043084d in address_space_rw (...)
>>>> #11 0x000000000047451b in kvm_cpu_exec (...)
>>>> #12 0x000000000045dcf5 in qemu_kvm_cpu_thread_fn (arg=3D0x1ab11b0)
>>>> #13 0x0000000000870631 in qemu_thread_start (args=3Dargs@entry=3D0x1=
acfb50)
>>>> #14 0x00000000008959a7 in thread_entry_for_hotfix (pthread_cb=3D<opt=
imized out>)
>>>> #15 0x00007fc6b0a60dd5 in start_thread () from /usr/lib64/libpthread=
.so.0
>>>> #16 0x00007fc6b078a59d in clone () from /usr/lib64/libc.so.6
>>>>
>>>> (gdb) f 5
>>>> #5  0x000000000047897a in memory_region_write_accessor (...)
>>>> 529	    mr->ops->write(mr->opaque, addr, tmp, size);
>>>> (gdb) p /x tmp
>>>> $9 =3D 0x62481a00
>>>
>>> ... since memory_region_write_accessor() has the same argument, then =
I
>>> can assume your guest is running in Little-Endian.
>>>
>>
>> Yes.
>>
>>>> static void xhci_doorbell_write(void *ptr, hwaddr reg,
>>>>                                 uint64_t val, unsigned size)
>>>> So, the @val is 0x62481a00, and the last byte is epid, right?
>>>>
>>>>>>
>>>>>> xhci_doorbell_write() already check the upper bound of @slotid an =
@epid,
>>>>>> it also need to check the lower bound.
>>>>>>
>>>>>> Cc: Gonglei <arei.gonglei@huawei.com>
>>>>>> Signed-off-by: Longpeng <longpeng2@huawei.com>
>>>>>> ---
>>>>>>  hw/usb/hcd-xhci.c | 4 ++--
>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>>>>>> index ec28bee..b4e6bfc 100644
>>>>>> --- a/hw/usb/hcd-xhci.c
>>>>>> +++ b/hw/usb/hcd-xhci.c
>>>>>> @@ -3135,9 +3135,9 @@ static void xhci_doorbell_write(void *ptr, h=
waddr reg,
>>>>>
>>>>> Expanding the diff:
>>>>>
>>>>>        if (reg =3D=3D 0) {
>>>>>            if (val =3D=3D 0) {
>>>>>                xhci_process_commands(xhci);
>>>>>            } else {
>>>>>                DPRINTF("xhci: bad doorbell 0 write: 0x%x\n",
>>>>>                        (uint32_t)val);
>>>>>            }
>>>>>>      } else {
>>>>>>          epid =3D val & 0xff;
>>>>>>          streamid =3D (val >> 16) & 0xffff;
>>>>>> -        if (reg > xhci->numslots) {
>>>>>> +        if (reg =3D=3D 0 || reg > xhci->numslots) {
>>>>>
>>>>> So 'reg' can not be zero here...
>>>>>
>>>>
>>>> Oh, you're right.
>>>>
>>>>>>              DPRINTF("xhci: bad doorbell %d\n", (int)reg);
>>>>>> -        } else if (epid > 31) {
>>>>>> +        } else if (epid =3D=3D 0 || epid > 31) {
>>>>>
>>>>> Here neither.
>>>>>
>>>>
>>>> In our frame, the epid is zero. The @val is from guest which is untr=
usted, when
>>>> this problem happened, I saw it wrote many invalid value, not only u=
sb but also
>>>> other devices.
>>>
>>> If you use mainstream QEMU, we have:
>>>
>>> static void qemu_xhci_instance_init(Object *obj)
>>> {
>>>     ...
>>>     xhci->numslots =3D MAXSLOTS;
>>>     ...
>>> }
>>>
>>> $ git grep define.*MAXSLOTS
>>> hw/usb/hcd-xhci.c:52:#define LEN_DOORBELL    ((MAXSLOTS + 1) * 0x20)
>>> hw/usb/hcd-xhci.h:33:#define MAXSLOTS 64
>>> hw/usb/hcd-xhci.h:37:#define EV_QUEUE (((3 * 24) + 16) * MAXSLOTS)
>>>
>>>>
>>>>>>              DPRINTF("xhci: bad doorbell %d write: 0x%x\n",
>>>>>>                      (int)reg, (uint32_t)val);
>>>>>>          } else {
>>>>>>
>>>>>
>>>>> Isn't it the other line that triggered the assertion?
>>>>>
>>>>> static void xhci_kick_ep(XHCIState *xhci, unsigned int slotid,
>>>>>                          unsigned int epid, unsigned int streamid)
>>>>> {
>>>>>     XHCIEPContext *epctx;
>>>>>
>>>>>     assert(slotid >=3D 1 && slotid <=3D xhci->numslots); // <=3D=3D=
=3D
>>>
>>> slotid >=3D 1 // true
>>> slotid <=3D xhci->numslots // FALSE (156 > 64)
>>>
>>> So this assertion won't pass.
>>>
>>
>> Oh, you miss the following code in xhci_doorbell_write():
>>     reg >>=3D 2;
>>
>> So the @slotid pass to xhci_kick_ep() is 156/4 =3D 39 < 64 and the
>> 'assert(slotid >=3D 1 && slotid <=3D xhci->numslots)' assertion will p=
ass.
>>
>> Check the @epid in xhci_doorbell_write() is still needed.
>=20
> Oh! My bad, I missed that, I'm confused :S
>=20
> So for your next patch with simply this change:
>=20
> -        } else if (epid > 31) {
> +        } else if (epid =3D=3D 0 || epid > 31) {
>=20
> You can include:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> (Please include the full backtrace in the description).
>=20

OK.

> Thanks for being patient with me with this patch :)
>=20

It is a good learning experience for me too :)

>>>>>     assert(epid >=3D 1 && epid <=3D 31);
>>>>>
>>>>> Regards,
>>>>>
>>>>> Phil.
>>>>>
>>>
>>> .
>>>
>=20
> .
>=20


--=20
Regards,
Longpeng(Mike)
