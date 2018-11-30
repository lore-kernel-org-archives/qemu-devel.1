Received: from eggs.gnu.org ([2001:4830:134:3::10]:48269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSlY1-0007tB-4N
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:21:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSlY0-0004Rp-BE
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:21:45 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:38135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSlY0-0004RV-4u
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:21:44 -0500
Received: by mail-oi1-x22b.google.com with SMTP id a77so5179939oii.5
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 08:21:44 -0800 (PST)
MIME-Version: 1.0
References: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
	<1543407172-16175-8-git-send-email-peng.hao2@zte.com.cn>
	<CAFEAcA83C_Eic3K4yY5bGeEKJpY2uf26diFtDJ5r+W71jcX2DQ@mail.gmail.com>
	<CAFEAcA8nfp0ueLMJHhgRyf+mqG1QbakjKJiqSnLF-MFkjkDhZA@mail.gmail.com>
	<20181130161449.dg2yxiac5lnk7mbb@kamzik.brq.redhat.com>
In-Reply-To: <20181130161449.dg2yxiac5lnk7mbb@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 16:21:31 +0000
Message-ID: <CAFEAcA9Od4vjo2EeEXhP1iE_XONaK8H22L9eq1qw3w6C2nR_cQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V10 7/9] hw/misc/pvpanic: preparing for
 adding configure interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Peng Hao <peng.hao2@zte.com.cn>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 30 Nov 2018 at 16:14, Andrew Jones <drjones@redhat.com> wrote:
>
> On Fri, Nov 30, 2018 at 03:57:13PM +0000, Peter Maydell wrote:
> > On Fri, 30 Nov 2018 at 15:56, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > I suspect the reason you've done this is that you're
> > > trying to get "-device pvpanic" to work on the command
> > > line. I recommend not trying to get that to work.
> > > MMIO devices are not pluggable devices, and -device
> > > is not expected to work with them.
> >
> > If you do want a pluggable pvpanic device for the virt
> > board then you should implement it as a PCI device,
> > incidentally.
> >
>
> We'd have to allocate it a PCI device ID, but I guess that's OK as
> there are plenty of IDs left for 1b36. I'm not sure it's worth it
> though. Phil asked that this device by user creatable, but maybe
> that's not necessary. Maybe we just need a mach-virt compat boolean
> and then to always provide this device for 4.0 and later machines?

Yes, if it's just an mmio device then we should either:
 * default to providing it, with the usual flag to say "don't create
   in older virt board versions", and also a machine property to
   disable it manually (like we do with the ITS)
 * default to not providing it at all, and have a machine
   property to enable it (like we do with the IOMMU)
Which is all doable, but every time we do that it makes the
virt board code that extra bit more complicated (we have
half a dozen machine properties on it already).

This kind of thing is why a PCI device is cleaner -- it just
works on any machine with a PCI controller, it by default is
something that the user can provide if they want to and not if
they don't, and it's not a custom UI that management layers
might need to special-case. The guest does need to do a bit
of PCI probing and setup initially, but then it can just leave
the MMIO BAR permanently mapped and write to that address
when the guest panics.

thanks
-- PMM
