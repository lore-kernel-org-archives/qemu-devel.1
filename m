Received: from eggs.gnu.org ([2001:4830:134:3::10]:42162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyWRO-00025y-2L
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 01:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyWRN-00050K-A3
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 01:37:38 -0400
References: <20180223152640.11459-1-pbonzini@redhat.com>
	<20180223152640.11459-2-pbonzini@redhat.com>
	<af95cb35-4a25-0082-ca54-6b344241f9f2@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <49397b53-2063-8dd1-f5e0-707167de5eab@redhat.com>
Date: Wed, 21 Mar 2018 06:37:19 +0100
MIME-Version: 1.0
In-Reply-To: <af95cb35-4a25-0082-ca54-6b344241f9f2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] ide: push call to end_transfer_func
 out of start_transfer callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org

On 20/03/2018 22:46, John Snow wrote:
>>      }
>> -    if (s->bus->dma->ops->start_transfer) {
>> -        s->bus->dma->ops->start_transfer(s->bus->dma);
>> +    if (!s->bus->dma->ops->start_transfer) {
>> +        s->end_transfer_func = end_transfer_func;
>> +        return;
>>      }
>> +    s->bus->dma->ops->start_transfer(s->bus->dma);
>> +    end_transfer_func(s);
> wow, this makes me really uneasy to look at. The assumption now is: "If
> you have a start_transfer method, that method if successful implies that
> the transfer is *COMPLETED*."
> 
> It's implicit here, but I think anyone but the two of us would probably
> not understand that implication. (Or me in three months.) What can we do
> about that? Since AHCI is the only interface that uses this callback, I
> wonder if we can't just rename it to something more obvious.

You are completely right, it should be renamed to pio_transfer.

> Under normal circumstances this function really does just "start" a
> transfer and it's not obvious from context that some adapters have
> synchronous methods to finish the transfer without further PIO pingpong
> with the guest.

Yeah, though it is already doing it---the patch is only unhiding the
mutual recursion by pulling it one level up.

Paolo
