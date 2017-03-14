Received: from eggs.gnu.org ([2001:4830:134:3::10]:33741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cnqLW-0006Kx-Ue
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cnqLS-0002xg-UT
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:34:55 -0400
Date: Tue, 14 Mar 2017 18:34:48 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <87o9x3pzxe.fsf@linaro.org>
Message-ID: <alpine.BSF.2.20.1703141829440.39248@zero.eik.bme.hu>
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
	<87wpbsp49a.fsf@linaro.org>
	<6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>
	<alpine.BSF.2.20.1703141450560.82811@zero.eik.bme.hu>
	<87shmfq31b.fsf@linaro.org>
	<b9006aa4-b606-61d5-6896-8c76a6a6f8f3@ilande.co.uk>
	<87o9x3pzxe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jan.kiszka@siemens.com, qemu-devel <qemu-devel@nongnu.org>, cota@braap.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, bobby.prani@gmail.com, fred.konrad@greensocs.com, rth@twiddle.net

On Tue, 14 Mar 2017, Alex Benn=C3=A9e wrote:
> So from a single-threaded -smp guest case there should be no difference
> in behaviour. However cross-vCPU flushes are queued up using the async
> work queue and are dealt with in the target vCPU context. In the single
> threaded case it shouldn't matter as this work will get executed as soo=
n
> as round-robin scheduler gets to it:
>
> cpus.c/qemu_tcg_rr_cpu_thread_fn:
>  while (cpu && !cpu->queued_work_first && !cpu->exit_request) {
>
> When converting a target to MTTCG its certainly something that has to
> have attention paid to it. For example some cross-vCPU tlb flushes need
> to be complete from the source vCPU point of view. In this case you cal=
l
> the tlb_flush_*_synced() variants and exit the execution loop. This
> ensures all vCPUs have completed flushes before we continue. See
> a67cf2772733e for what I did on ARM. However this shouldn't affect
> anything in the single-threaded world.

I think we have a single CPU and thread for these ppc machines here so I'=
m=20
not sure how this could be relevant.

> However delaying tlb_flushes() could certainly expose/hide stuff that i=
s
> accessing the dirty mechanism. tlb_flush itself now takes the tb_lock()=
 to
> avoid racing with the TB invalidation logic. The act of the flush will
> certainly wipe all existing SoftMMU entries and force a re-load on each
> memory access.
>
> So is the dirty status of memory being read from outside a vCPU
> execution context?

Like from the display controller models that use memory_region_get_dirty(=
)=20
to check if the frambuffer needs to be updated? But all display adaptors=20
seem to do this and the problem was only seem on ppc so it may be related=
=20
to something ppc specific.

Regards,
BALATON Zoltan
