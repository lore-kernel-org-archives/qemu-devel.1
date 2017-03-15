Received: from eggs.gnu.org ([2001:4830:134:3::10]:45758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1co8x6-0001q9-Eq
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1co8x5-00012K-Kp
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:26:56 -0400
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
	<87wpbsp49a.fsf@linaro.org>
	<6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>
	<alpine.BSF.2.20.1703141450560.82811@zero.eik.bme.hu>
	<87shmfq31b.fsf@linaro.org>
	<b9006aa4-b606-61d5-6896-8c76a6a6f8f3@ilande.co.uk>
	<87o9x3pzxe.fsf@linaro.org>
	<alpine.BSF.2.20.1703141829440.39248@zero.eik.bme.hu>
	<87h92upz9v.fsf@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <f1bba13a-0be4-b97e-c2fd-181e81e738cf@ilande.co.uk>
Date: Wed, 15 Mar 2017 13:26:23 +0000
MIME-Version: 1.0
In-Reply-To: <87h92upz9v.fsf@linaro.org>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: jan.kiszka@siemens.com, qemu-devel <qemu-devel@nongnu.org>, cota@braap.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, bobby.prani@gmail.com, rth@twiddle.net, fred.konrad@greensocs.com

On 15/03/17 11:14, Alex Bennée wrote:

> BALATON Zoltan <balaton@eik.bme.hu> writes:
> 
>> On Tue, 14 Mar 2017, Alex Bennée wrote:
>>> So from a single-threaded -smp guest case there should be no difference
>>> in behaviour.
> <snip>
>>> However this shouldn't affect
>>> anything in the single-threaded world.
>>
>> I think we have a single CPU and thread for these ppc machines here so
>> I'm not sure how this could be relevant.
>>
>>> However delaying tlb_flushes() could certainly expose/hide stuff that is
>>> accessing the dirty mechanism. tlb_flush itself now takes the tb_lock() to
>>> avoid racing with the TB invalidation logic. The act of the flush will
>>> certainly wipe all existing SoftMMU entries and force a re-load on each
>>> memory access.
>>>
>>> So is the dirty status of memory being read from outside a vCPU
>>> execution context?
>>
>> Like from the display controller models that use
>> memory_region_get_dirty() to check if the frambuffer needs to be
>> updated? But all display adaptors seem to do this and the problem was
>> only seem on ppc so it may be related to something ppc specific.
> 
> So this accesses the memory_region API which is under RCU control.
> AFAIUI this should mean the dirty status may be read late (e.g. next
> update) but should never be incorrect (e.g. miss a dirtying operation).

AFAICT check_tlb_flush() gets passed a global parameter which if set
true invalidates the TLB across all CPU TLBs rather than just the local
CPU TLB - but then in this case we're only running with a single CPU so
I can't see how this is relevant.

Have you been able to reproduce the artifacts locally at all? I'm
wondering if once the icount fixup patches are in, it might be easier to
debug if enabling icount causes the artifacts to appear in a
deterministic manner.


ATB,

Mark.
