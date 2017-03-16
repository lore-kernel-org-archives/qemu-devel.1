Received: from eggs.gnu.org ([2001:4830:134:3::10]:47287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coPwK-0003Le-8q
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coPwF-0000SC-B8
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:35:16 -0400
Message-ID: <1489649706.15659.72.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 16 Mar 2017 08:35:06 +0100
In-Reply-To: <87bmt2pl47.fsf@linaro.org>
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
	<87wpbsp49a.fsf@linaro.org>
	<6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>
	<alpine.BSF.2.20.1703141450560.82811@zero.eik.bme.hu>
	<87shmfq31b.fsf@linaro.org>
	<b9006aa4-b606-61d5-6896-8c76a6a6f8f3@ilande.co.uk>
	<87efxypqug.fsf@linaro.org> <1489591539.15659.60.camel@redhat.com>
	<87bmt2pl47.fsf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
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
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, BALATON Zoltan <balaton@eik.bme.hu>, jan.kiszka@siemens.com, qemu-devel <qemu-devel@nongnu.org>, cota@braap.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, bobby.prani@gmail.com, fred.konrad@greensocs.com, rth@twiddle.net

  Hi,

> >> Note that KVM has some similar hacks to avoid trapping all writes to
> >> video memory with its coalesced mmio mechanism however I'm not familia=
r
> >> with all the details.
> >
> > Normal linear framebuffer access doesn't use this.
>=20
> Ahh OK - as I said I wasn't super familiar with what coalesced mmio was
> trying to achieve. I assume it is trying to avoid trapping on every
> single MMIO access?

You can't avoid the trap, but you can avoid notifying userspace about
each and every single trap and batch things.

But vga framebuffer is normal ram in most video modes, it doesn't trap
(except on first access with dirty bit clear, for dirty bit tracking). =20

IIRC some of the historic video modes which are pretty much unused these
days (planar 4bit) trap on each access and perform better with coalesced
mmio.  Also nics which use mmio instead of dma for package xfer.

> > I suspect the memory_region_sync_dirty_bitmap call on tcg should reset
> > the fast path optimization, so the slow path can update the dirty bits
> > correctly.
>=20
> Sure. And for the low level cputlb implementation we can clear those
> bits atomically. However when the memory region is synced we also need
> to flush any entries in the TLB that have already been hit and cleared
> TLB_NOTDIRTY to we can trigger the slow path again. This is tricky from
> outside of a vCPU context because we can't just queue the work and exit
> the vCPU run loop to reach a known CPU state.

Hmm, ok.

> The RFC PATCH I sent earlier solves this by ensuring the update runs in
> a quiescent period (i.e. when the vCPUs are not running) but it is
> sub-optimal as it means the display code has to have a basic knowledge
> of vCPUs and when they run.

Still the best option for 2.9 I guess ...

cheers,
  Gerd
