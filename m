Received: from eggs.gnu.org ([2001:4830:134:3::10]:52882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coXQ5-0006V1-7T
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coXQ1-0005XH-AY
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:34:29 -0400
Message-ID: <1489678462.15659.112.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 16 Mar 2017 16:34:22 +0100
In-Reply-To: <5d39e125-e0cf-5ecf-3564-9a6a5b3b0bb6@redhat.com>
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
	<87wpbsp49a.fsf@linaro.org>
	<6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>
	<alpine.BSF.2.20.1703141450560.82811@zero.eik.bme.hu>
	<87shmfq31b.fsf@linaro.org>
	<b9006aa4-b606-61d5-6896-8c76a6a6f8f3@ilande.co.uk>
	<87o9x3pzxe.fsf@linaro.org>
	<alpine.BSF.2.20.1703141829440.39248@zero.eik.bme.hu>
	<95e306ce-8b80-f3c7-c374-85def4f549ff@redhat.com>
	<878to5psky.fsf@linaro.org>
	<5d39e125-e0cf-5ecf-3564-9a6a5b3b0bb6@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, jan.kiszka@siemens.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>, cota@braap.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, bobby.prani@gmail.com, fred.konrad@greensocs.com, rth@twiddle.net

  Hi,

> >> least cg3.c is doing
> >>
> >> 	read dirty bitmap
> >> 	read VRAM
> >> 	clear dirty bitmap
> >>
> >> which has a race.

> It's much simpler than that, just clear the dirty bitmap bit before
> reading the memory.

Well, not *that* simple.  vga checks the dirty bitmap with scanline
granularity, like that:

  foreach (scanline) {
     if (get_dirty(scanline))
        update_scanline()
  }
  reset_dirty(framebuffer)

I suspect simply transforming that to

  foreach (scanline) {
     if (test_and_clear_dirty(scanline))
       update_scanline()
  }

is not going to fly due to page tracking working with page granularity.
With two subsequent scanlines within one page the second scanline will
never be updated because updating first clears the dirty bit of the
page ...

Looping twice over all scanlines, with the first loop just figuring
which scanlines are modified, then clear dirty bits, then update in a
second loop should work I think.  It'll duplicate a bunch of code
though, because in reality the loop isn't just three lines because of
doublescan, interlave and other funky stuff coming from CGA
compatibility.

Given that probably pretty much every display adapter is affected I'd
tend to take Alex patch for 2.9, then sort the mess in the 2.10 devel
cycle and revert the patch when done.

cheers,
  Gerd
