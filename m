Received: from eggs.gnu.org ([2001:4830:134:3::10]:56891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRir1-0005xw-1O
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:08:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRiqy-0004Bp-DT
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:07:59 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cRiqy-0004BY-5x
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:07:56 -0500
Received: by mail-lf0-x243.google.com with SMTP id v186so2759331lfa.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 09:07:56 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170112105132.10394-1-pbonzini@redhat.com>
	<20170112141145.GA14042@stefanha-x1.localdomain>
	<e458f658-bcb8-8864-e6cf-96df9c69578d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dba6430e-0b2e-78a5-77dd-ee86ab4cc91e@redhat.com>
Date: Thu, 12 Jan 2017 18:07:54 +0100
MIME-Version: 1.0
In-Reply-To: <e458f658-bcb8-8864-e6cf-96df9c69578d@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ide: avoid unbounded recursion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org



On 12/01/2017 17:05, John Snow wrote:
> 
> 
> On 01/12/2017 09:11 AM, Stefan Hajnoczi wrote:
>> On Thu, Jan 12, 2017 at 11:51:32AM +0100, Paolo Bonzini wrote:
>>> The end_transfer_func can call ide_transfer_start immediately, before
>>> returning, and unbounded recursion can happen at least for
>>> ide_atapi_cmd_reply_end.  Use a bottom half to defer the call and
>>> limit stack usage.
>>>
>>> Cc: Peter Lieven <pl@kamp.de>
>>> Cc: John Snow <jsnow@redhat.com>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  hw/ide/core.c | 14 +++++++++++++-
>>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>>> index 43709e5..7b9831f 100644
>>> --- a/hw/ide/core.c
>>> +++ b/hw/ide/core.c
>>> @@ -482,6 +482,13 @@ static void ide_clear_retry(IDEState *s)
>>>      s->bus->retry_nsector = 0;
>>>  }
>>>  
>>> +static void ide_start_transfer_bh_cb(void *opaque)
>>> +{
>>> +    IDEDMA *dma = opaque;
>>> +
>>> +    dma->ops->start_transfer(dma);
>>> +}
>>> +
>>>  /* prepare data transfer and tell what to do after */
>>>  void ide_transfer_start(IDEState *s, uint8_t *buf, int size,
>>>                          EndTransferFunc *end_transfer_func)
>>> @@ -494,7 +501,12 @@ void ide_transfer_start(IDEState *s, uint8_t *buf, int size,
>>>          s->status |= DRQ_STAT;
>>>      }
>>>      if (s->bus->dma->ops->start_transfer) {
>>> -        s->bus->dma->ops->start_transfer(s->bus->dma);
>>> +        /* There can be unbounded recursion between ops->start_transfer
>>> +         * and end_transfer_func, so defer to a bottom half.
>>> +         */
>>> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
>>> +                                ide_start_transfer_bh_cb,
>>> +                                s->bus->dma);
>>
>> Are you sure this is safe?
>>
>> I wonder if there are races with device reset, vmsave, or vcpu hw
>> register accesses.
>>
>> Stefan
>>
> 
> Oh, right, reset -- we're guarded against normal accesses because the
> ATA device will be busy, but we're always allowed to reset.
> 
> Can we just amend the ide reset functionality to delete the BH if it
> hasn't triggered yet?

Yes, but there's still migration.

> Also, I suppose drain doesn't clear out any scheduled bottom halves
> associated with the device, does it?

You could use bdrv_inc/dec_in_flight, but I'm not suggesting that seriously.

Paolo
