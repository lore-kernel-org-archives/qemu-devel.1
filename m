Received: from eggs.gnu.org ([2001:4830:134:3::10]:37453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eNMXy-0002Xr-K3
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eNMXv-0000Gq-DG
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:34:50 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eNMXv-0000Gc-8z
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:34:47 -0500
Received: by mail-vk0-f67.google.com with SMTP id f73so7354860vki.3
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 09:34:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87vahh9ljm.fsf@dusky.pond.sub.org>
References: <20171208074515.1553-1-lprosek@redhat.com>
	<20171208074515.1553-5-lprosek@redhat.com>
	<87y3mde3z1.fsf@dusky.pond.sub.org>
	<CABdb737EUy_rRCunxeDUDdhhDiCU8eZBNoYmh+QGp39mqsDung@mail.gmail.com>
	<87vahh9ljm.fsf@dusky.pond.sub.org>
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri, 8 Dec 2017 18:34:45 +0100
Message-ID: <CABdb737A3bOdxychRQAaEYmKPLt3SpUFU9UxHM9okmt2jURF2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 4/4] ivshmem: Disable irqfd on device
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Geoffrey McRae <geoff@hostfission.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Fri, Dec 8, 2017 at 6:28 PM, Markus Armbruster <armbru@redhat.com> wrote:
> Ladi Prosek <lprosek@redhat.com> writes:
>
>> On Fri, Dec 8, 2017 at 2:36 PM, Markus Armbruster <armbru@redhat.com> wrote:
>>> Ladi Prosek <lprosek@redhat.com> writes:
>>>
>>>> The effects of ivshmem_enable_irqfd() was not undone on device reset.
>>>>
>>>> This manifested as:
>>>> ivshmem_add_kvm_msi_virq: Assertion `!s->msi_vectors[vector].pdev' failed.
>>>>
>>>> when irqfd was enabled before reset and then enabled again after reset, making
>>>> ivshmem_enable_irqfd() run for the second time.
>>>>
>>>> To reproduce, run:
>>>>
>>>>   ivshmem-server
>>>>
>>>> and QEMU with:
>>>>
>>>>   -device ivshmem-doorbell,chardev=iv
>>>>   -chardev socket,path=/tmp/ivshmem_socket,id=iv
>>>>
>>>> then install the Windows driver, at the time of writing available at:
>>>>
>>>> https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/ivshmem
>>>>
>>>> and crash-reboot the guest by inducing a BSOD.
>>>>
>>>> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
>>>> ---
>>>>  hw/misc/ivshmem.c | 24 +++++++++++++-----------
>>>>  1 file changed, 13 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
>>>> index d1bb246d12..4be0d2627b 100644
>>>> --- a/hw/misc/ivshmem.c
>>>> +++ b/hw/misc/ivshmem.c
>>>> @@ -758,17 +758,6 @@ static void ivshmem_msix_vector_use(IVShmemState *s)
>>>>      }
>>>>  }
>>>>
>>>> -static void ivshmem_reset(DeviceState *d)
>>>> -{
>>>> -    IVShmemState *s = IVSHMEM_COMMON(d);
>>>> -
>>>> -    s->intrstatus = 0;
>>>> -    s->intrmask = 0;
>>>> -    if (ivshmem_has_feature(s, IVSHMEM_MSI)) {
>>>> -        ivshmem_msix_vector_use(s);
>>>> -    }
>>>> -}
>>>> -
>>>>  static int ivshmem_setup_interrupts(IVShmemState *s, Error **errp)
>>>>  {
>>>>      /* allocate QEMU callback data for receiving interrupts */
>>>> @@ -855,6 +844,19 @@ static void ivshmem_disable_irqfd(IVShmemState *s)
>>>>
>>>>  }
>>>>
>>>> +static void ivshmem_reset(DeviceState *d)
>>>> +{
>>>> +    IVShmemState *s = IVSHMEM_COMMON(d);
>>>> +
>>>> +    ivshmem_disable_irqfd(s);
>>>> +
>>>> +    s->intrstatus = 0;
>>>> +    s->intrmask = 0;
>>>> +    if (ivshmem_has_feature(s, IVSHMEM_MSI)) {
>>>> +        ivshmem_msix_vector_use(s);
>>>> +    }
>>>> +}
>>>> +
>>>>  static void ivshmem_write_config(PCIDevice *pdev, uint32_t address,
>>>>                                   uint32_t val, int len)
>>>>  {
>>>
>>> Why are you moving ivshmem_reset()?  Makes the actual change harder to
>>> see than necessary.
>>
>> ivshmem_disable_irqfd() is declared after ivshmem_reset() in the
>> source file. I generally prefer to order static functions
>> topologically if possible. If you'd prefer adding a forward decl
>> instead (fewer lines touched, easier to bisect?) I can certainly do
>> that. Thanks!
>
> Well, it compiles before your patch, your patch doesn't add any calls,
> so I can't quite see why a forward declaration would be needed.

It adds a call to ivshmem_disable_irqfd().
