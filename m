Received: from eggs.gnu.org ([2001:4830:134:3::10]:58165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cnkvF-0001FH-Rg
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cnkvC-0008GQ-ML
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:47:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1cnkvC-0008G2-CR
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:47:22 -0400
References: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
	<1488777954-4578-13-git-send-email-jasowang@redhat.com>
	<b3d2249e-9eb9-8621-e4c7-c77ac0962615@redhat.com>
	<20170314111614.GD2445@work-vm>
	<0f4c58f4-01a4-53d3-fb9e-6409d120827c@redhat.com>
	<20170314113804.GF2445@work-vm>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <f38153ed-9a1c-4970-ac2a-610802857eb7@redhat.com>
Date: Tue, 14 Mar 2017 12:47:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170314113804.GF2445@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL RESEND 12/19] vmxnet3: Convert ring values
 to uint32_t's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org

On 14/03/2017 12:38, Dr. David Alan Gilbert wrote:
> * Laurent Vivier (lvivier@redhat.com) wrote:
>> On 14/03/2017 12:16, Dr. David Alan Gilbert wrote:
>>> * Laurent Vivier (lvivier@redhat.com) wrote:
>>>> On 06/03/2017 06:25, Jason Wang wrote:
>>>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>>>
>>>>> The index's in the Vmxnet3Ring were migrated as 32bit ints
>>>>> yet are declared as size_t's.  They appear to be derived
>>>>> from 32bit values loaded from guest memory, so actually
>>>>> store them as that.
>>>>>
>>>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>>> Acked-by: Dmitry Fleytman <dmitry@daynix.com>
>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>> ---
>>>>>  hw/net/vmxnet3.c | 12 ++++++------
>>>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
>>>>> index e13a798..224c109 100644
>>>>> --- a/hw/net/vmxnet3.c
>>>>> +++ b/hw/net/vmxnet3.c
>>>>> @@ -141,17 +141,17 @@ typedef struct VMXNET3Class {
>>>>>  /* Cyclic ring abstraction */
>>>>>  typedef struct {
>>>>>      hwaddr pa;
>>>>> -    size_t size;
>>>>> -    size_t cell_size;
>>>>> -    size_t next;
>>>>> +    uint32_t size;
>>>>> +    uint32_t cell_size;
>>>>> +    uint32_t next;
>>>>>      uint8_t gen;
>>>>>  } Vmxnet3Ring;
>>>>>  
>>>>>  static inline void vmxnet3_ring_init(PCIDevice *d,
>>>>>  				     Vmxnet3Ring *ring,
>>>>>                                       hwaddr pa,
>>>>> -                                     size_t size,
>>>>> -                                     size_t cell_size,
>>>>> +                                     uint32_t size,
>>>>> +                                     uint32_t cell_size,
>>>>>                                       bool zero_region)
>>>>>  {
>>>>>      ring->pa = pa;
>>>>> @@ -166,7 +166,7 @@ static inline void vmxnet3_ring_init(PCIDevice *d,
>>>>>  }
>>>>>  
>>>>>  #define VMXNET3_RING_DUMP(macro, ring_name, ridx, r)                         \
>>>>> -    macro("%s#%d: base %" PRIx64 " size %zu cell_size %zu gen %d next %zu",  \
>>>>> +    macro("%s#%d: base %" PRIx64 " size %u cell_size %u gen %d next %u",  \
>>>>>            (ring_name), (ridx),                                               \
>>>>>            (r)->pa, (r)->size, (r)->cell_size, (r)->gen, (r)->next)
>>>>>  
>>>>>
>>>>
>>>>
>>>> David, with '-dump-vmstate' with 2.8 machine type and with v2.8 and
>>>> master I can see the size of "txq_descr" and "rxq_descr" changes because
>>>> of "sizeof(Vmxnet3TxqDescr)" and "sizeof(Vmxnet3RxqDescr)". This changes
>>>> because the size of Vmxnet3Ring has changed with the s/size_t/uint32_t/":
>>>>
>>>>         {
>>>>           "field": "txq_descr",
>>>>           "version_id": 0,
>>>>           "field_exists": false,
>>>>           "size": 176
>>>>         },
>>>>         {
>>>>           "field": "rxq_descr",
>>>>           "version_id": 0,
>>>>           "field_exists": false,
>>>>           "size": 216
>>>>         },
>>>>
>>>> becomes:
>>>>
>>>>         {
>>>>           "field": "txq_descr",
>>>>           "version_id": 0,
>>>>           "field_exists": false,
>>>>           "size": 144
>>>>         },
>>>>         {
>>>>           "field": "rxq_descr",
>>>>           "version_id": 0,
>>>>           "field_exists": false,
>>>>           "size": 168
>>>>         },
>>>
>>> But the old migration code used to write these fields using qemu_put_be32
>>> (from a11f5cb005f9854f0d78da97fc23adf5bc8c83f3)
>>>
>>> -static void vmxnet3_put_ring_to_file(QEMUFile *f, Vmxnet3Ring *r)
>>> -{
>>> -    qemu_put_be64(f, r->pa);
>>> -    qemu_put_be32(f, r->size);
>>> -    qemu_put_be32(f, r->cell_size);
>>> -    qemu_put_be32(f, r->next);
>>> -    qemu_put_byte(f, r->gen);
>>> -}
>>>
>>> +static const VMStateDescription vmstate_vmxnet3_ring = {
>>> +    .name = "vmxnet3-ring",
>>> +    .version_id = 0,
>>> +    .fields = (VMStateField[]) {
>>> +        VMSTATE_UINT64(pa, Vmxnet3Ring),
>>> +        VMSTATE_UINT32(size, Vmxnet3Ring),
>>> +        VMSTATE_UINT32(cell_size, Vmxnet3Ring),
>>> +        VMSTATE_UINT32(next, Vmxnet3Ring),
>>> +        VMSTATE_UINT8(gen, Vmxnet3Ring),
>>> +        VMSTATE_END_OF_LIST()
>>> +    }
>>>  };
>>>
>>> so they used to be size_t's written with be32 and now they're uint32_t's
>>> written as 32bit - so that should be the same.
>>> I'm not sure i understand where the old txq_descr sizes come from - what
>>> managed to print the 176 number before it was converted to VMState?
>>
>> I think it comes from the sizeof() in VMSTATE_STRUCT(Vmxnet3TxqDescr):
>>
>> static const VMStateDescription vmstate_vmxnet3_txq_descr = {
>>     .name = "vmxnet3-txq-descr",
>>     .version_id = 0,
>>     .fields = (VMStateField[]) {
>>         VMSTATE_STRUCT(tx_ring, Vmxnet3TxqDescr, 0, vmstate_vmxnet3_ring,
>>                        Vmxnet3Ring),
>>         VMSTATE_STRUCT(comp_ring, Vmxnet3TxqDescr, 0, vmstate_vmxnet3_ring,
>>                        Vmxnet3Ring),
>>         VMSTATE_UINT8(intr_idx, Vmxnet3TxqDescr),
>>         VMSTATE_UINT64(tx_stats_pa, Vmxnet3TxqDescr),
>>         VMSTATE_STRUCT(txq_stats, Vmxnet3TxqDescr, 0,
>> vmstate_vmxnet3_tx_stats,
>>                        struct UPT1_TxStats),
>>         VMSTATE_END_OF_LIST()
>>     }
>> };
>>
>> I will check the '-dump-vmstate' code to see if it's relevant.
> 
> OK, but that sizeof() should never make it onto the wire; all that
> teh VMSTATE_STRUCT should do is execute the vmstate_vmxnet3_ring on
> that data.
> (And again I'm curious what happened in the version before I committed
> that change).
> 
>>>
>>>> And if I try a migration, I have:
>>>>
>>>> qemu/migration/vmstate.c:112: vmstate_load_state: Assertion `first_elem
>>>> || !n_elems' failed.
>>>
>>> Interesting; that's Halil's new assert; I need to look.
>>
>> Can't it be related to the size problem?
> 
> It could, I need to see exactly how it's failing; what was the full
> command line you used, and with what guest?

Tested with pseries machine type on ppc64le host, no guest started.

qemu-system-ppc64 -M pseries-2.8 -S -serial mon:stdio -vnc :0 -device
vmxnet3

Laurent
