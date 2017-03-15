Received: from eggs.gnu.org ([2001:4830:134:3::10]:56263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1co6t8-0007x7-L9
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1co6t2-0006qQ-Pt
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:14:42 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1co6t2-0006pz-JE
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:14:36 -0400
Received: by mail-wm0-x232.google.com with SMTP id n11so84806357wma.1
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 04:14:36 -0700 (PDT)
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
	<87wpbsp49a.fsf@linaro.org>
	<6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>
	<alpine.BSF.2.20.1703141450560.82811@zero.eik.bme.hu>
	<87shmfq31b.fsf@linaro.org>
	<b9006aa4-b606-61d5-6896-8c76a6a6f8f3@ilande.co.uk>
	<87o9x3pzxe.fsf@linaro.org>
	<alpine.BSF.2.20.1703141829440.39248@zero.eik.bme.hu>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <alpine.BSF.2.20.1703141829440.39248@zero.eik.bme.hu>
Date: Wed, 15 Mar 2017 11:14:52 +0000
Message-ID: <87h92upz9v.fsf@linaro.org>
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
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jan.kiszka@siemens.com, qemu-devel <qemu-devel@nongnu.org>, cota@braap.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, bobby.prani@gmail.com, fred.konrad@greensocs.com, rth@twiddle.net


BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Tue, 14 Mar 2017, Alex Bennée wrote:
>> So from a single-threaded -smp guest case there should be no difference
>> in behaviour.
<snip>
>>However this shouldn't affect
>> anything in the single-threaded world.
>
> I think we have a single CPU and thread for these ppc machines here so
> I'm not sure how this could be relevant.
>
>> However delaying tlb_flushes() could certainly expose/hide stuff that is
>> accessing the dirty mechanism. tlb_flush itself now takes the tb_lock() to
>> avoid racing with the TB invalidation logic. The act of the flush will
>> certainly wipe all existing SoftMMU entries and force a re-load on each
>> memory access.
>>
>> So is the dirty status of memory being read from outside a vCPU
>> execution context?
>
> Like from the display controller models that use
> memory_region_get_dirty() to check if the frambuffer needs to be
> updated? But all display adaptors seem to do this and the problem was
> only seem on ppc so it may be related to something ppc specific.

So this accesses the memory_region API which is under RCU control.
AFAIUI this should mean the dirty status may be read late (e.g. next
update) but should never be incorrect (e.g. miss a dirtying operation).

--
Alex Bennée
