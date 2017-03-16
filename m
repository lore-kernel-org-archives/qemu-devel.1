Received: from eggs.gnu.org ([2001:4830:134:3::10]:56015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coWIB-00041F-PQ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coWI8-0000xQ-IF
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:22:15 -0400
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
	<87wpbsp49a.fsf@linaro.org>
	<6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>
	<alpine.BSF.2.20.1703141450560.82811@zero.eik.bme.hu>
	<87shmfq31b.fsf@linaro.org>
	<b9006aa4-b606-61d5-6896-8c76a6a6f8f3@ilande.co.uk>
	<87efxypqug.fsf@linaro.org> <1489591539.15659.60.camel@redhat.com>
	<87bmt2pl47.fsf@linaro.org> <1489649706.15659.72.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <48551ece-baee-21a5-1dc9-5eb0e5a36049@redhat.com>
Date: Thu, 16 Mar 2017 15:22:05 +0100
MIME-Version: 1.0
In-Reply-To: <1489649706.15659.72.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] qemu-system-ppc video artifacts since
 "tcg: drop global lock during TCG code execution"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: jan.kiszka@siemens.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>, cota@braap.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, bobby.prani@gmail.com, rth@twiddle.net, fred.konrad@greensocs.com



On 16/03/2017 08:35, Gerd Hoffmann wrote:
>   Hi,
> 
>>>> Note that KVM has some similar hacks to avoid trapping all writes to
>>>> video memory with its coalesced mmio mechanism however I'm not familiar
>>>> with all the details.
>>>
>>> Normal linear framebuffer access doesn't use this.
>>
>> Ahh OK - as I said I wasn't super familiar with what coalesced mmio was
>> trying to achieve. I assume it is trying to avoid trapping on every
>> single MMIO access?
> 
> You can't avoid the trap, but you can avoid notifying userspace about
> each and every single trap and batch things.
> 
> But vga framebuffer is normal ram in most video modes, it doesn't trap
> (except on first access with dirty bit clear, for dirty bit tracking).  
> 
> IIRC some of the historic video modes which are pretty much unused these
> days (planar 4bit) trap on each access and perform better with coalesced
> mmio.  Also nics which use mmio instead of dma for package xfer.
> 
>>> I suspect the memory_region_sync_dirty_bitmap call on tcg should reset
>>> the fast path optimization, so the slow path can update the dirty bits
>>> correctly.
>>
>> Sure. And for the low level cputlb implementation we can clear those
>> bits atomically. However when the memory region is synced we also need
>> to flush any entries in the TLB that have already been hit and cleared
>> TLB_NOTDIRTY to we can trigger the slow path again. This is tricky from
>> outside of a vCPU context because we can't just queue the work and exit
>> the vCPU run loop to reach a known CPU state.
> 
> Hmm, ok.
> 
>> The RFC PATCH I sent earlier solves this by ensuring the update runs in
>> a quiescent period (i.e. when the vCPUs are not running) but it is
>> sub-optimal as it means the display code has to have a basic knowledge
>> of vCPUs and when they run.
> 
> Still the best option for 2.9 I guess ...

For both VGA and SM501, it should be the issue I pointed out in
https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg03197.html.
The dirty bitmap has been thread-safe for a long time now.

Paolo
