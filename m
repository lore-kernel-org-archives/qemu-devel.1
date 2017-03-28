Received: from eggs.gnu.org ([2001:4830:134:3::10]:33650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1csrMx-0005yA-SQ
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1csrMt-0006v0-0Y
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:41:07 -0400
Message-ID: <1490708459.4704.101.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 28 Mar 2017 15:40:59 +0200
In-Reply-To: <4fa44363-76fe-d33c-249c-b1af88f09f9f@redhat.com>
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
	<4fa44363-76fe-d33c-249c-b1af88f09f9f@redhat.com>
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
Cc: jan.kiszka@siemens.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>, cota@braap.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, bobby.prani@gmail.com, fred.konrad@greensocs.com, Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, rth@twiddle.net

  Hi,

> > Well, not *that* simple.  vga checks the dirty bitmap with scanline
> > granularity, like that:
> >=20
> >   foreach (scanline) {
> >      if (get_dirty(scanline))
> >         update_scanline()
> >   }
> >   reset_dirty(framebuffer)
> >=20
> > I suspect simply transforming that to
> >=20
> >   foreach (scanline) {
> >      if (test_and_clear_dirty(scanline))
> >        update_scanline()
> >   }
> >=20
> > is not going to fly due to page tracking working with page granularity.
> > With two subsequent scanlines within one page the second scanline will
> > never be updated because updating first clears the dirty bit of the
> > page ...

> You're right; an alternative is to copy the dirty bitmap to a local one
> and clear the global one (the dirty bitmap for an 8 MB full HD frame
> buffer is just 256 bytes).  With the right API to abstract the job, it
> should be relatively easy to fix all adapters.

Started looking into this.  So I guess you are thinking about a variant
of memory_region_test_and_clear_dirty and/or
cpu_physical_memory_test_and_clear_dirty
which returns a bitmap instead of a bool?  Plus some helper function
which use the returned bitmap to figure whenever a specific scanline has
been touched or not?

cheers,
  Gerd
