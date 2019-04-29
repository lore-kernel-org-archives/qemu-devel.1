Received: from eggs.gnu.org ([209.51.188.92]:41188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL57N-0003CF-NN
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL57M-0002BM-D4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:10:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hL57M-0002B0-6v
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:10:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id j13so13816359wmh.2
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:10:44 -0700 (PDT)
References: <1556523569-44480-1-git-send-email-longpeng2@huawei.com>
	<7e19e93d-9ad4-51a8-3c1e-ed4d1672a47f@redhat.com>
	<5CC6E333.90108@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a14a352c-2587-11a6-7068-01bf52bac817@redhat.com>
Date: Mon, 29 Apr 2019 14:10:41 +0200
MIME-Version: 1.0
In-Reply-To: <5CC6E333.90108@huawei.com>
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

On 4/29/19 1:42 PM, Longpeng (Mike) wrote:
> Hi Philippe,
> 
> On 2019/4/29 19:16, Philippe Mathieu-Daudé wrote:
> 
>> Hi Mike,
>>
>> On 4/29/19 9:39 AM, Longpeng(Mike) wrote:
>>> From: Longpeng <longpeng2@huawei.com>
>>>
>>> we found the following core in our environment:
>>> 0  0x00007fc6b06c2237 in raise ()
>>> 1  0x00007fc6b06c3928 in abort ()
>>> 2  0x00007fc6b06bb056 in __assert_fail_base ()
>>> 3  0x00007fc6b06bb102 in __assert_fail ()
>>> 4  0x0000000000702e36 in xhci_kick_ep (...)
>>
>>   5 xhci_doorbell_write?
>>
>>> 6  0x000000000047767f in access_with_adjusted_size (...)
>>> 7  0x000000000047944d in memory_region_dispatch_write (...)
>>> 8  0x000000000042df17 in address_space_write_continue (...)
>>> 10 0x000000000043084d in address_space_rw (...)
>>> 11 0x000000000047451b in kvm_cpu_exec (cpu=cpu@entry=0x1ab11b0)
>>> 12 0x000000000045dcf5 in qemu_kvm_cpu_thread_fn (arg=0x1ab11b0)
>>> 13 0x0000000000870631 in qemu_thread_start (args=args@entry=0x1acfb50)
>>> 14 0x00000000008959a7 in thread_entry_for_hotfix (pthread_cb=<optimized out>)
>>> 15 0x00007fc6b0a60dd5 in start_thread ()
>>> 16 0x00007fc6b078a59d in clone ()
>>> (gdb) bt
>>> (gdb) f 5
>>
>> This is the frame you removed...
>>
>>> (gdb) p /x tmp
>>> $9 = 0x62481a00 <-- last byte 0x00 is @epid
>>
>> I don't see 'tmp' in xhci_doorbell_write().
>>
>> Can you use trace events?
>>
>> There we have trace_usb_xhci_doorbell_write().
>>
> 
> Sorry , I'm careless to remove the important information.
> 
> 
> This is our whole frame:
> 
> (gdb) bt
> #0  0x00007fc6b06c2237 in raise () from /usr/lib64/libc.so.6
> #1  0x00007fc6b06c3928 in abort () from /usr/lib64/libc.so.6
> #2  0x00007fc6b06bb056 in __assert_fail_base () from /usr/lib64/libc.so.6
> #3  0x00007fc6b06bb102 in __assert_fail () from /usr/lib64/libc.so.6
> #4  0x0000000000702e36 in xhci_kick_ep (...)
> #5  0x000000000047897a in memory_region_write_accessor (...)
> #6  0x000000000047767f in access_with_adjusted_size (...)
> #7  0x000000000047944d in memory_region_dispatch_write
> (mr=mr@entry=0x7fc6a0138df0, addr=addr@entry=156, data=1648892416,
> size=size@entry=4, attrs=attrs@entry=...)

So this is a 32-bit access, to address 156 (which is the slotid) and
data=1648892416=0x62481a00 indeed.

But watch out access_with_adjusted_size() calls adjust_endianness()...

> #8  0x000000000042df17 in address_space_write_continue (...)
> #9  0x00000000004302d5 in address_space_write (...)
> #10 0x000000000043084d in address_space_rw (...)
> #11 0x000000000047451b in kvm_cpu_exec (...)
> #12 0x000000000045dcf5 in qemu_kvm_cpu_thread_fn (arg=0x1ab11b0)
> #13 0x0000000000870631 in qemu_thread_start (args=args@entry=0x1acfb50)
> #14 0x00000000008959a7 in thread_entry_for_hotfix (pthread_cb=<optimized out>)
> #15 0x00007fc6b0a60dd5 in start_thread () from /usr/lib64/libpthread.so.0
> #16 0x00007fc6b078a59d in clone () from /usr/lib64/libc.so.6
> 
> (gdb) f 5
> #5  0x000000000047897a in memory_region_write_accessor (...)
> 529	    mr->ops->write(mr->opaque, addr, tmp, size);
> (gdb) p /x tmp
> $9 = 0x62481a00

... since memory_region_write_accessor() has the same argument, then I
can assume your guest is running in Little-Endian.

> static void xhci_doorbell_write(void *ptr, hwaddr reg,
>                                 uint64_t val, unsigned size)
> So, the @val is 0x62481a00, and the last byte is epid, right?
> 
>>>
>>> xhci_doorbell_write() already check the upper bound of @slotid an @epid,
>>> it also need to check the lower bound.
>>>
>>> Cc: Gonglei <arei.gonglei@huawei.com>
>>> Signed-off-by: Longpeng <longpeng2@huawei.com>
>>> ---
>>>  hw/usb/hcd-xhci.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>>> index ec28bee..b4e6bfc 100644
>>> --- a/hw/usb/hcd-xhci.c
>>> +++ b/hw/usb/hcd-xhci.c
>>> @@ -3135,9 +3135,9 @@ static void xhci_doorbell_write(void *ptr, hwaddr reg,
>>
>> Expanding the diff:
>>
>>        if (reg == 0) {
>>            if (val == 0) {
>>                xhci_process_commands(xhci);
>>            } else {
>>                DPRINTF("xhci: bad doorbell 0 write: 0x%x\n",
>>                        (uint32_t)val);
>>            }
>>>      } else {
>>>          epid = val & 0xff;
>>>          streamid = (val >> 16) & 0xffff;
>>> -        if (reg > xhci->numslots) {
>>> +        if (reg == 0 || reg > xhci->numslots) {
>>
>> So 'reg' can not be zero here...
>>
> 
> Oh, you're right.
> 
>>>              DPRINTF("xhci: bad doorbell %d\n", (int)reg);
>>> -        } else if (epid > 31) {
>>> +        } else if (epid == 0 || epid > 31) {
>>
>> Here neither.
>>
> 
> In our frame, the epid is zero. The @val is from guest which is untrusted, when
> this problem happened, I saw it wrote many invalid value, not only usb but also
> other devices.

If you use mainstream QEMU, we have:

static void qemu_xhci_instance_init(Object *obj)
{
    ...
    xhci->numslots = MAXSLOTS;
    ...
}

$ git grep define.*MAXSLOTS
hw/usb/hcd-xhci.c:52:#define LEN_DOORBELL    ((MAXSLOTS + 1) * 0x20)
hw/usb/hcd-xhci.h:33:#define MAXSLOTS 64
hw/usb/hcd-xhci.h:37:#define EV_QUEUE (((3 * 24) + 16) * MAXSLOTS)

> 
>>>              DPRINTF("xhci: bad doorbell %d write: 0x%x\n",
>>>                      (int)reg, (uint32_t)val);
>>>          } else {
>>>
>>
>> Isn't it the other line that triggered the assertion?
>>
>> static void xhci_kick_ep(XHCIState *xhci, unsigned int slotid,
>>                          unsigned int epid, unsigned int streamid)
>> {
>>     XHCIEPContext *epctx;
>>
>>     assert(slotid >= 1 && slotid <= xhci->numslots); // <===

slotid >= 1 // true
slotid <= xhci->numslots // FALSE (156 > 64)

So this assertion won't pass.

>>     assert(epid >= 1 && epid <= 31);
>>
>> Regards,
>>
>> Phil.
>>
