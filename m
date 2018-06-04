Received: from eggs.gnu.org ([2001:4830:134:3::10]:52849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fPtV2-0001tP-Pz
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fPtV2-0001ux-1G
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:42:32 -0400
References: <20180417153945.20737-1-pbonzini@redhat.com>
	<20180417153945.20737-3-pbonzini@redhat.com>
	<70b2ae2a-491f-211f-7f94-ca1b355054fa@redhat.com>
	<6597ad58-05e3-ec57-b5f8-8a1603e2f42b@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3b1bc7e6-1c88-31b0-fcd7-e4adcfab4901@redhat.com>
Date: Mon, 4 Jun 2018 13:42:25 -0400
MIME-Version: 1.0
In-Reply-To: <6597ad58-05e3-ec57-b5f8-8a1603e2f42b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] ide: push end_transfer_func out of
 start_transfer callback, rename callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org



On 06/04/2018 11:48 AM, Paolo Bonzini wrote:
> On 02/06/2018 02:24, John Snow wrote:
>>> -    if (s->bus->dma->ops->start_transfer) {
>>> -        s->bus->dma->ops->start_transfer(s->bus->dma);
>>> +    if (!s->bus->dma->ops->pio_transfer) {
>>> +        s->end_transfer_func = end_transfer_func;
>>> +        return;
>>>      }
>>> +    s->bus->dma->ops->pio_transfer(s->bus->dma);
>>> +    end_transfer_func(s);
>> Does not setting s->end_transfer_func mess with some of our dumb hacks
>> in e.g. ide_restart_bh or ide_is_pio_out?
> 
> No, ide_is_pio_out is not used by AHCI and ide_restart_bh looks at the
> flags passed to ide_handle_rw_error.
> 
> Thanks,
> 
> Paolo
> 

Yes, that's right -- ide_restart_bh relies less on this now (thanks to
you, if I recall correctly) and ide_is_pio_out is only used by
ide_data_(read|write)[lw] ...

Hmm, it'd be nice to get rid of our reliance on ETF to determine state,
but that's nothing you've caused.

Reviewed-by: John Snow <jsnow@redhat.com>
