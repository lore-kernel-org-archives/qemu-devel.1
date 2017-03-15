Received: from eggs.gnu.org ([2001:4830:134:3::10]:32912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coAvS-0001pr-TP
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coAvN-000058-1E
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:33:22 -0400
Message-ID: <1489591539.15659.60.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 15 Mar 2017 16:25:39 +0100
In-Reply-To: <87efxypqug.fsf@linaro.org>
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
	<87wpbsp49a.fsf@linaro.org>
	<6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>
	<alpine.BSF.2.20.1703141450560.82811@zero.eik.bme.hu>
	<87shmfq31b.fsf@linaro.org>
	<b9006aa4-b606-61d5-6896-8c76a6a6f8f3@ilande.co.uk>
	<87efxypqug.fsf@linaro.org>
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

> Instead of having MMIO register spaces we use the dirty tracking
> mechanism. Here regions are marked as for dirty tracking and when the
> SoftMMU helper first comes to this bit of memory it will follow the slow
> path and mark region as visited.

visited?  Do you mean dirty bit is set for the page?  Or is this
something else?

> Once done this bit is cleared and all
> future writes to that page are written directly from the translated
> code. This no longer has an implicit synchronisation from the BQL so
> there is now a race and you can have memory being updated which might
> miss this flagging.

Not fully following what you are trying to say.  But pages being updated
without dirty bit getting set (if clear) certainly is a problem for the
vga emulation (and live migration too).

> Note that KVM has some similar hacks to avoid trapping all writes to
> video memory with its coalesced mmio mechanism however I'm not familiar
> with all the details.

Normal linear framebuffer access doesn't use this.

> Now there are mechanisms we can use to ensure there are no races happen
> and return to the situation that the display is only updated when the
> TCG cores are not running.

tcg and display updates running in parallel isn't a problem, we have
that with kvm anyway.  Dirty bit handling must be correct though.

With kvm at the start of each display update vga fetches the dirty
bitmap from the kernel (memory_region_sync_dirty_bitmap).  Then it goes
use memory_region_get_dirty to figure which pages have been touched.

When memory_region_sync_dirty_bitmap is called the kernel will clear the
memory bitmap of the region and also map all pages read-only.  Next
guest update will pagefault and the kernel can set the dirty bit for the
page (maybe there is a more efficient way with EPT available).

I suspect the memory_region_sync_dirty_bitmap call on tcg should reset
the fast path optimization, so the slow path can update the dirty bits
correctly.

cheers,
  Gerd
