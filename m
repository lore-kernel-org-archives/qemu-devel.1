Received: from eggs.gnu.org ([2001:4830:134:3::10]:50611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coYlH-00087g-1X
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coYlE-0007aN-9P
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:00:27 -0400
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
	<1489678462.15659.112.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4fa44363-76fe-d33c-249c-b1af88f09f9f@redhat.com>
Date: Thu, 16 Mar 2017 18:00:19 +0100
MIME-Version: 1.0
In-Reply-To: <1489678462.15659.112.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: jan.kiszka@siemens.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>, cota@braap.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, bobby.prani@gmail.com, rth@twiddle.net, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, fred.konrad@greensocs.com



On 16/03/2017 16:34, Gerd Hoffmann wrote:
> Well, not *that* simple.  vga checks the dirty bitmap with scanline
> granularity, like that:
>=20
>   foreach (scanline) {
>      if (get_dirty(scanline))
>         update_scanline()
>   }
>   reset_dirty(framebuffer)
>=20
> I suspect simply transforming that to
>=20
>   foreach (scanline) {
>      if (test_and_clear_dirty(scanline))
>        update_scanline()
>   }
>=20
> is not going to fly due to page tracking working with page granularity.
> With two subsequent scanlines within one page the second scanline will
> never be updated because updating first clears the dirty bit of the
> page ...
>=20
> Looping twice over all scanlines, with the first loop just figuring
> which scanlines are modified, then clear dirty bits, then update in a
> second loop should work I think.  It'll duplicate a bunch of code
> though, because in reality the loop isn't just three lines because of
> doublescan, interlave and other funky stuff coming from CGA
> compatibility.
>=20
> Given that probably pretty much every display adapter is affected I'd
> tend to take Alex patch for 2.9, then sort the mess in the 2.10 devel
> cycle and revert the patch when done.

You're right; an alternative is to copy the dirty bitmap to a local one
and clear the global one (the dirty bitmap for an 8 MB full HD frame
buffer is just 256 bytes).  With the right API to abstract the job, it
should be relatively easy to fix all adapters.

Paolo
