Received: from eggs.gnu.org ([2001:4830:134:3::10]:54064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1coQH4-0001lz-Gb
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1coQH1-00005u-Du
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:56:42 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:35505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1coQH1-00005c-6J
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:56:39 -0400
Received: by mail-wr0-x234.google.com with SMTP id g10so25991115wrg.2
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 00:56:38 -0700 (PDT)
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
	<87wpbsp49a.fsf@linaro.org>
	<6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>
	<alpine.BSF.2.20.1703141450560.82811@zero.eik.bme.hu>
	<87shmfq31b.fsf@linaro.org>
	<b9006aa4-b606-61d5-6896-8c76a6a6f8f3@ilande.co.uk>
	<87efxypqug.fsf@linaro.org> <1489591539.15659.60.camel@redhat.com>
	<87bmt2pl47.fsf@linaro.org> <1489649706.15659.72.camel@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1489649706.15659.72.camel@redhat.com>
Date: Thu, 16 Mar 2017 07:56:56 +0000
Message-ID: <877f3ppsc7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, BALATON Zoltan <balaton@eik.bme.hu>, jan.kiszka@siemens.com, qemu-devel <qemu-devel@nongnu.org>, cota@braap.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, bobby.prani@gmail.com, fred.konrad@greensocs.com, rth@twiddle.net


Gerd Hoffmann <kraxel@redhat.com> writes:

>   Hi,
>
>> >> Note that KVM has some similar hacks to avoid trapping all writes to
>> >> video memory with its coalesced mmio mechanism however I'm not familiar
>> >> with all the details.
>> >
>> > Normal linear framebuffer access doesn't use this.
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
>> > I suspect the memory_region_sync_dirty_bitmap call on tcg should reset
>> > the fast path optimization, so the slow path can update the dirty bits
>> > correctly.
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

I think so although Paolo has pointed out potential issues with the
other display adaptors.

As this dirty tracking is also used for live migration I also need to
check if the BQL change has broken that for TCG guests or that it just
never worked anyway. If it is the later then that gives a bit more
breathing room for plumbing in the full fix to keep the memory_regions
view of the world consistent with the SoftMMU TLB.

>
> cheers,
>   Gerd


--
Alex Bennée
