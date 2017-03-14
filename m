Received: from eggs.gnu.org ([2001:4830:134:3::10]:45128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnpcQ-0007Qu-Js
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnpcM-0005tW-Mf
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:48:18 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cnpcM-0005se-D2
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:48:14 -0400
Received: by mail-wr0-x229.google.com with SMTP id g10so128076430wrg.2
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:48:14 -0700 (PDT)
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
	<87wpbsp49a.fsf@linaro.org>
	<6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>
	<alpine.BSF.2.20.1703141450560.82811@zero.eik.bme.hu>
	<87shmfq31b.fsf@linaro.org>
	<b9006aa4-b606-61d5-6896-8c76a6a6f8f3@ilande.co.uk>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <b9006aa4-b606-61d5-6896-8c76a6a6f8f3@ilande.co.uk>
Date: Tue, 14 Mar 2017 16:48:29 +0000
Message-ID: <87o9x3pzxe.fsf@linaro.org>
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, jan.kiszka@siemens.com, qemu-devel <qemu-devel@nongnu.org>, cota@braap.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, bobby.prani@gmail.com, fred.konrad@greensocs.com, rth@twiddle.net


Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 14/03/17 15:41, Alex Bennée wrote:
>
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>
>>> On Tue, 14 Mar 2017, Mark Cave-Ayland wrote:
>>>> On 14/03/17 10:00, Alex Bennée wrote:
>>>>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>>>>>
>>>>>> I've recently noticed some video artifacts appearing in the form of
>>>>>> horizontal lines whilst testing OpenBIOS boot on some qemu-system-ppc
>>>>>> images (see https://www.ilande.co.uk/tmp/qemu/macos9-stripe.png for an
>>>>>> example) which I've finally bisected down to this commit.
>>>>>
>>>>> Interesting. Is the video hardware in this case a simple framebuffer or
>>>>> is there some sort of GPU involved?
>>>>
>>>> For the mac99 machine it's just the normal QEMU PCI std-vga card, so
>>>> nothing special. Having run tests across SPARC which uses its own
>>>> framebuffer, there have been no obvious artifacts that I've spotted
>>>> there to date.
>>>>
>>>>>> The horizontal lines tend to appear at different positions with
>>>>>> different lengths, although it seems to be more common that a complete
>>>>>> scanline is affected. Reproducing the issue is fairly easy with a MacOS
>>>>>> 9.2.1 ISO and the command line below:
>>>>>>
>>>>>> ./qemu-system-ppc -cdrom MacOS921.iso -boot d -m 512 -M mac99
>>>>>>
>>>>>> Could it be that this patch is still missing a lock somewhere which
>>>>>> causes these artifacts to appear?
>>>>>
>>>>> It depends. If the hardware is accessed via MMIO then the BQL is taken
>>>>> automatically (unless the area is explicitly marked as doing its own
>>>>> locking see: mr->global_locking).
>>>>>
>>>>> Is the artefact temporary or permanent? Could it be a change in
>>>>> synchronisation between the emulator updating the framebuffer and
>>>>> whatever backend updating its display?
>>>>
>>>> AFAICT they are temporary in that they appear randomly on the display,
>>>> but the next time that particular area of the display is updated by the
>>>> guest then they tend to either change/disappear.
>>>
>>> I've also noticed artifacts when testing the SM501 changes with
>>> MorphOS on recent QEMU so it may not be related to just the std vga.
>>> It's shown as bands (larger number of adjacent scanlines) not updating
>>> when the client first wrote to the framebuffer but then they
>>> disappeared during the next refresh. I'm guessing it may be related to
>>> dirty checking of the framebuffer memory which is used to decide when
>>> a scan line needs update?
>>
>> Interesting. I guess if the corrupted scan lines are in blocks of
>> PAGE_SIZE that might make sense.
>>
>> Commit (b0706b716769494f321a0d2bfd9fa9893992f995) made
>> tlb_reset_dirty_range update the SoftMMU addr_write entry atomically.
>> Now I don't see how that could race in single threaded TCG mode but it
>> could explain things.
>>
>> I notice that tlb_set_dirty/tlb_set_dirty1 should maybe do the same. The
>> currently assume they are only called from the CPU's context. If you
>> enable #define DEBUG_TLB in cputlb.c does the assert fire?
>
> Not in a quick local test here.

I've just realised that assert will never fire because all vCPUS in
single threaded mode share the same thread id:

cpus.c/qemu_tcg_init_vcpu:

        /* For non-MTTCG cases we share the thread */
        cpu->thread = single_tcg_cpu_thread;
        cpu->halt_cond = single_tcg_halt_cond;

> However this does ring a bell - one of
> Ben's PPC optimisations was to batch TLB flushes so they only occur at
> certain times - see commit cd0c6f473532bfaf20a095bc90a18e45162981b5 for
> more detail.
>
> Could it be that these underlying assumptions have now changed?

Hmm I'm not sure.

So from a single-threaded -smp guest case there should be no difference
in behaviour. However cross-vCPU flushes are queued up using the async
work queue and are dealt with in the target vCPU context. In the single
threaded case it shouldn't matter as this work will get executed as soon
as round-robin scheduler gets to it:

cpus.c/qemu_tcg_rr_cpu_thread_fn:
  while (cpu && !cpu->queued_work_first && !cpu->exit_request) {

When converting a target to MTTCG its certainly something that has to
have attention paid to it. For example some cross-vCPU tlb flushes need
to be complete from the source vCPU point of view. In this case you call
the tlb_flush_*_synced() variants and exit the execution loop. This
ensures all vCPUs have completed flushes before we continue. See
a67cf2772733e for what I did on ARM. However this shouldn't affect
anything in the single-threaded world.

However delaying tlb_flushes() could certainly expose/hide stuff that is
accessing the dirty mechanism. tlb_flush itself now takes the tb_lock() to
avoid racing with the TB invalidation logic. The act of the flush will
certainly wipe all existing SoftMMU entries and force a re-load on each
memory access.

So is the dirty status of memory being read from outside a vCPU
execution context?

--
Alex Bennée
