Received: from eggs.gnu.org ([2001:4830:134:3::10]:35645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eNMRj-0007Lp-3w
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eNMRf-0003st-3d
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:28:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eNMRe-0003sJ-Rh
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 12:28:19 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171208074515.1553-1-lprosek@redhat.com>
	<20171208074515.1553-5-lprosek@redhat.com>
	<87y3mde3z1.fsf@dusky.pond.sub.org>
	<CABdb737EUy_rRCunxeDUDdhhDiCU8eZBNoYmh+QGp39mqsDung@mail.gmail.com>
Date: Fri, 08 Dec 2017 18:28:13 +0100
In-Reply-To: <CABdb737EUy_rRCunxeDUDdhhDiCU8eZBNoYmh+QGp39mqsDung@mail.gmail.com>
	(Ladi Prosek's message of "Fri, 8 Dec 2017 14:44:03 +0100")
Message-ID: <87vahh9ljm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Ladi Prosek <lprosek@redhat.com>
Cc: Geoffrey McRae <geoff@hostfission.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, =?utf-8?Q?Ma?= =?utf-8?Q?rc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Ladi Prosek <lprosek@redhat.com> writes:

> On Fri, Dec 8, 2017 at 2:36 PM, Markus Armbruster <armbru@redhat.com> wrote:
>> Ladi Prosek <lprosek@redhat.com> writes:
>>
>>> The effects of ivshmem_enable_irqfd() was not undone on device reset.
>>>
>>> This manifested as:
>>> ivshmem_add_kvm_msi_virq: Assertion `!s->msi_vectors[vector].pdev' failed.
>>>
>>> when irqfd was enabled before reset and then enabled again after reset, making
>>> ivshmem_enable_irqfd() run for the second time.
>>>
>>> To reproduce, run:
>>>
>>>   ivshmem-server
>>>
>>> and QEMU with:
>>>
>>>   -device ivshmem-doorbell,chardev=iv
>>>   -chardev socket,path=/tmp/ivshmem_socket,id=iv
>>>
>>> then install the Windows driver, at the time of writing available at:
>>>
>>> https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/ivshmem
>>>
>>> and crash-reboot the guest by inducing a BSOD.
>>>
>>> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
>>> ---
>>>  hw/misc/ivshmem.c | 24 +++++++++++++-----------
>>>  1 file changed, 13 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
>>> index d1bb246d12..4be0d2627b 100644
>>> --- a/hw/misc/ivshmem.c
>>> +++ b/hw/misc/ivshmem.c
>>> @@ -758,17 +758,6 @@ static void ivshmem_msix_vector_use(IVShmemState *s)
>>>      }
>>>  }
>>>
>>> -static void ivshmem_reset(DeviceState *d)
>>> -{
>>> -    IVShmemState *s = IVSHMEM_COMMON(d);
>>> -
>>> -    s->intrstatus = 0;
>>> -    s->intrmask = 0;
>>> -    if (ivshmem_has_feature(s, IVSHMEM_MSI)) {
>>> -        ivshmem_msix_vector_use(s);
>>> -    }
>>> -}
>>> -
>>>  static int ivshmem_setup_interrupts(IVShmemState *s, Error **errp)
>>>  {
>>>      /* allocate QEMU callback data for receiving interrupts */
>>> @@ -855,6 +844,19 @@ static void ivshmem_disable_irqfd(IVShmemState *s)
>>>
>>>  }
>>>
>>> +static void ivshmem_reset(DeviceState *d)
>>> +{
>>> +    IVShmemState *s = IVSHMEM_COMMON(d);
>>> +
>>> +    ivshmem_disable_irqfd(s);
>>> +
>>> +    s->intrstatus = 0;
>>> +    s->intrmask = 0;
>>> +    if (ivshmem_has_feature(s, IVSHMEM_MSI)) {
>>> +        ivshmem_msix_vector_use(s);
>>> +    }
>>> +}
>>> +
>>>  static void ivshmem_write_config(PCIDevice *pdev, uint32_t address,
>>>                                   uint32_t val, int len)
>>>  {
>>
>> Why are you moving ivshmem_reset()?  Makes the actual change harder to
>> see than necessary.
>
> ivshmem_disable_irqfd() is declared after ivshmem_reset() in the
> source file. I generally prefer to order static functions
> topologically if possible. If you'd prefer adding a forward decl
> instead (fewer lines touched, easier to bisect?) I can certainly do
> that. Thanks!

Well, it compiles before your patch, your patch doesn't add any calls,
so I can't quite see why a forward declaration would be needed.
