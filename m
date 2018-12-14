Received: from eggs.gnu.org ([2001:4830:134:3::10]:33247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXlzB-0002zb-Kl
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:50:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXlzA-0002ij-Ml
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:50:29 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXlzA-0002h3-98
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:50:28 -0500
Received: by mail-ot1-x344.google.com with SMTP id e12so5118809otl.5
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 03:50:28 -0800 (PST)
MIME-Version: 1.0
References: <20181119162658.30358-1-peter.maydell@linaro.org>
	<20181126150307.GM2448@perard.uk.xensource.com>
In-Reply-To: <20181126150307.GM2448@perard.uk.xensource.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 11:50:16 +0000
Message-ID: <CAFEAcA8Z+g8HQq=HeY=2YbY1ToPyNpL8FO2mvfACS=sK-SBGfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1] hw/xen/xen_pt_graphics: Don't
 trust the BIOS ROM contents so much
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, "open list:X86" <xen-devel@lists.xenproject.org>

On Mon, 26 Nov 2018 at 15:03, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> On Mon, Nov 19, 2018 at 04:26:58PM +0000, Peter Maydell wrote:
> > Coverity (CID 796599) points out that xen_pt_setup_vga() trusts
> > the rom->size field in the BIOS ROM from a PCI passthrough VGA
> > device, and uses it as an index into the memory which contains
> > the BIOS image. A corrupt BIOS ROM could therefore cause us to
> > index off the end of the buffer.
> >
> > Check that the size is within bounds before we use it.
> >
> > We are also trusting the pcioffset field, and assuming that
> > the whole rom_header is present; Coverity doesn't notice these,
> > but check them too.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Disclaimer: compile tested only, as I don't have a Xen setup,
> > let alone one with pass-through PCI graphics.
> >
> > Note that https://xenbits.xen.org/xsa/advisory-124.html
> > defines that bugs which are only exploitable by a malicious
> > piece of hardware that is passed through to the guest are
> > not security vulnerabilities as far as the Xen Project is
> > concerned, and are treated like normal non-security-related bugs.
> > So this is just a bugfix, not a security issue.
> >
> > Marked "for-3.1" because it would let us squash another Coverity
> > issue, and it is a bug fix; on the other hand it's an obscure
> > corner case and has been this way since forever.
>
> I haven't tested that patch either, but the changes looks fine, so:
>
> Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Ping! Would the Xen folks like to test this and/or send it in
via a xen pullreq now that 4.0 has reopened for development?

Alternatively I can put it in via a pullreq I'm currently
doing in its current "not tested but looks fine" state :-)

thanks
-- PMM
