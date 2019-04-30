Received: from eggs.gnu.org ([209.51.188.92]:35717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLKyn-0003Up-Vj
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 01:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLKym-0000ba-FF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 01:06:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLKym-0000bQ-8p
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 01:06:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id c12so19298769wrt.8
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 22:06:56 -0700 (PDT)
References: <1556523569-44480-1-git-send-email-longpeng2@huawei.com>
	<7e19e93d-9ad4-51a8-3c1e-ed4d1672a47f@redhat.com>
	<5CC6E333.90108@huawei.com>
	<a14a352c-2587-11a6-7068-01bf52bac817@redhat.com>
	<5CC7ACC7.2010306@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ae81a8f8-fd36-a4b3-0c8c-4a6d698959a7@redhat.com>
Date: Tue, 30 Apr 2019 07:06:52 +0200
MIME-Version: 1.0
In-Reply-To: <5CC7ACC7.2010306@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: kraxel@redhat.com, Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org

On 4/30/19 4:02 AM, Longpeng (Mike) wrote:
> On 2019/4/29 20:10, Philippe Mathieu-Daudé wrote:
>> On 4/29/19 1:42 PM, Longpeng (Mike) wrote:
>>> Hi Philippe,
>>>
>>> On 2019/4/29 19:16, Philippe Mathieu-Daudé wrote:
>>>
>>>> Hi Mike,
>>>>
>>>> On 4/29/19 9:39 AM, Longpeng(Mike) wrote:
>>>>> From: Longpeng <longpeng2@huawei.com>
>>>>>
>>>>> we found the following core in our environment:
>>>>> 0  0x00007fc6b06c2237 in raise ()
>>>>> 1  0x00007fc6b06c3928 in abort ()
>>>>> 2  0x00007fc6b06bb056 in __assert_fail_base ()
>>>>> 3  0x00007fc6b06bb102 in __assert_fail ()
>>>>> 4  0x0000000000702e36 in xhci_kick_ep (...)
>>>>
>>>>   5 xhci_doorbell_write?
>>>>
>>>>> 6  0x000000000047767f in access_with_adjusted_size (...)
>>>>> 7  0x000000000047944d in memory_region_dispatch_write (...)
>>>>> 8  0x000000000042df17 in address_space_write_continue (...)
>>>>> 10 0x000000000043084d in address_space_rw (...)
>>>>> 11 0x000000000047451b in kvm_cpu_exec (cpu=cpu@entry=0x1ab11b0)
>>>>> 12 0x000000000045dcf5 in qemu_kvm_cpu_thread_fn (arg=0x1ab11b0)
>>>>> 13 0x0000000000870631 in qemu_thread_start (args=args@entry=0x1acfb50)
>>>>> 14 0x00000000008959a7 in thread_entry_for_hotfix (pthread_cb=<optimized out>)
>>>>> 15 0x00007fc6b0a60dd5 in start_thread ()
>>>>> 16 0x00007fc6b078a59d in clone ()
>>>>> (gdb) bt
>>>>> (gdb) f 5
>>>>
>>>> This is the frame you removed...
>>>>
>>>>> (gdb) p /x tmp
>>>>> $9 = 0x62481a00 <-- last byte 0x00 is @epid
>>>>
>>>> I don't see 'tmp' in xhci_doorbell_write().
>>>>
>>>> Can you use trace events?
>>>>
>>>> There we have trace_usb_xhci_doorbell_write().
>>>>
>>>
>>> Sorry , I'm careless to remove the important information.
>>>
>>>
>>> This is our whole frame:
>>>
>>> (gdb) bt
>>> #0  0x00007fc6b06c2237 in raise () from /usr/lib64/libc.so.6
>>> #1  0x00007fc6b06c3928 in abort () from /usr/lib64/libc.so.6
>>> #2  0x00007fc6b06bb056 in __assert_fail_base () from /usr/lib64/libc.so.6
>>> #3  0x00007fc6b06bb102 in __assert_fail () from /usr/lib64/libc.so.6
>>> #4  0x0000000000702e36 in xhci_kick_ep (...)
>>> #5  0x000000000047897a in memory_region_write_accessor (...)
>>> #6  0x000000000047767f in access_with_adjusted_size (...)
>>> #7  0x000000000047944d in memory_region_dispatch_write
>>> (mr=mr@entry=0x7fc6a0138df0, addr=addr@entry=156, data=1648892416,
>>> size=size@entry=4, attrs=attrs@entry=...)
>>
>> So this is a 32-bit access, to address 156 (which is the slotid) and
>> data=1648892416=0x62481a00 indeed.
>>
>> But watch out access_with_adjusted_size() calls adjust_endianness()...
>>
>>> #8  0x000000000042df17 in address_space_write_continue (...)
>>> #9  0x00000000004302d5 in address_space_write (...)
>>> #10 0x000000000043084d in address_space_rw (...)
>>> #11 0x000000000047451b in kvm_cpu_exec (...)
>>> #12 0x000000000045dcf5 in qemu_kvm_cpu_thread_fn (arg=0x1ab11b0)
>>> #13 0x0000000000870631 in qemu_thread_start (args=args@entry=0x1acfb50)
>>> #14 0x00000000008959a7 in thread_entry_for_hotfix (pthread_cb=<optimized out>)
>>> #15 0x00007fc6b0a60dd5 in start_thread () from /usr/lib64/libpthread.so.0
>>> #16 0x00007fc6b078a59d in clone () from /usr/lib64/libc.so.6
>>>
>>> (gdb) f 5
>>> #5  0x000000000047897a in memory_region_write_accessor (...)
>>> 529	    mr->ops->write(mr->opaque, addr, tmp, size);
>>> (gdb) p /x tmp
>>> $9 = 0x62481a00
>>
>> ... since memory_region_write_accessor() has the same argument, then I
>> can assume your guest is running in Little-Endian.
>>
> 
> Yes.
> 
>>> static void xhci_doorbell_write(void *ptr, hwaddr reg,
>>>                                 uint64_t val, unsigned size)
>>> So, the @val is 0x62481a00, and the last byte is epid, right?
>>>
>>>>>
>>>>> xhci_doorbell_write() already check the upper bound of @slotid an @epid,
>>>>> it also need to check the lower bound.
>>>>>
>>>>> Cc: Gonglei <arei.gonglei@huawei.com>
>>>>> Signed-off-by: Longpeng <longpeng2@huawei.com>
>>>>> ---
>>>>>  hw/usb/hcd-xhci.c | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>>>>> index ec28bee..b4e6bfc 100644
>>>>> --- a/hw/usb/hcd-xhci.c
>>>>> +++ b/hw/usb/hcd-xhci.c
>>>>> @@ -3135,9 +3135,9 @@ static void xhci_doorbell_write(void *ptr, hwaddr reg,
>>>>
>>>> Expanding the diff:
>>>>
>>>>        if (reg == 0) {
>>>>            if (val == 0) {
>>>>                xhci_process_commands(xhci);
>>>>            } else {
>>>>                DPRINTF("xhci: bad doorbell 0 write: 0x%x\n",
>>>>                        (uint32_t)val);
>>>>            }
>>>>>      } else {
>>>>>          epid = val & 0xff;
>>>>>          streamid = (val >> 16) & 0xffff;
>>>>> -        if (reg > xhci->numslots) {
>>>>> +        if (reg == 0 || reg > xhci->numslots) {
>>>>
>>>> So 'reg' can not be zero here...
>>>>
>>>
>>> Oh, you're right.
>>>
>>>>>              DPRINTF("xhci: bad doorbell %d\n", (int)reg);
>>>>> -        } else if (epid > 31) {
>>>>> +        } else if (epid == 0 || epid > 31) {
>>>>
>>>> Here neither.
>>>>
>>>
>>> In our frame, the epid is zero. The @val is from guest which is untrusted, when
>>> this problem happened, I saw it wrote many invalid value, not only usb but also
>>> other devices.
>>
>> If you use mainstream QEMU, we have:
>>
>> static void qemu_xhci_instance_init(Object *obj)
>> {
>>     ...
>>     xhci->numslots = MAXSLOTS;
>>     ...
>> }
>>
>> $ git grep define.*MAXSLOTS
>> hw/usb/hcd-xhci.c:52:#define LEN_DOORBELL    ((MAXSLOTS + 1) * 0x20)
>> hw/usb/hcd-xhci.h:33:#define MAXSLOTS 64
>> hw/usb/hcd-xhci.h:37:#define EV_QUEUE (((3 * 24) + 16) * MAXSLOTS)
>>
>>>
>>>>>              DPRINTF("xhci: bad doorbell %d write: 0x%x\n",
>>>>>                      (int)reg, (uint32_t)val);
>>>>>          } else {
>>>>>
>>>>
>>>> Isn't it the other line that triggered the assertion?
>>>>
>>>> static void xhci_kick_ep(XHCIState *xhci, unsigned int slotid,
>>>>                          unsigned int epid, unsigned int streamid)
>>>> {
>>>>     XHCIEPContext *epctx;
>>>>
>>>>     assert(slotid >= 1 && slotid <= xhci->numslots); // <===
>>
>> slotid >= 1 // true
>> slotid <= xhci->numslots // FALSE (156 > 64)
>>
>> So this assertion won't pass.
>>
> 
> Oh, you miss the following code in xhci_doorbell_write():
>     reg >>= 2;
> 
> So the @slotid pass to xhci_kick_ep() is 156/4 = 39 < 64 and the
> 'assert(slotid >= 1 && slotid <= xhci->numslots)' assertion will pass.
> 
> Check the @epid in xhci_doorbell_write() is still needed.

Oh! My bad, I missed that, I'm confused :S

So for your next patch with simply this change:

-        } else if (epid > 31) {
+        } else if (epid == 0 || epid > 31) {

You can include:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

(Please include the full backtrace in the description).

Thanks for being patient with me with this patch :)

>>>>     assert(epid >= 1 && epid <= 31);
>>>>
>>>> Regards,
>>>>
>>>> Phil.
>>>>
>>
>> .
>>
