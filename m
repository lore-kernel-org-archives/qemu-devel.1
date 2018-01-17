Received: from eggs.gnu.org ([2001:4830:134:3::10]:55320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ebqyT-0008IJ-3A
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ebqyQ-0001y2-0t
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:54:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ebqyP-0001xA-Qj
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:54:01 -0500
Date: Wed, 17 Jan 2018 17:53:48 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180117165348.xo3pat6voqaacmfz@kamzik.brq.redhat.com>
References: <CAFEAcA8F4iO91c8OGtDbHQ_hqzY+9ka41PW4q+ES9sYGRUha0g@mail.gmail.com>
	<176e66bb-7990-20da-a82f-fbabd9b4ed88@redhat.com>
	<CAKv+Gu__twgv27OxV=ORHywzeotk3+TNYo_-=bSjdFokfmXyGw@mail.gmail.com>
	<20180117171540.7e892ce7@redhat.com>
	<CAFEAcA89q-HzCHUsW7=9KovWx0tamPtgirPaiFHu7cFxhuoZnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA89q-HzCHUsW7=9KovWx0tamPtgirPaiFHu7cFxhuoZnA@mail.gmail.com>
Subject: Re: [Qemu-devel] QEMU virt board: extending various limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Wei Huang <wei@redhat.com>, "Leif Lindholm (Linaro address)" <leif.lindholm@linaro.org>

On Wed, Jan 17, 2018 at 04:18:30PM +0000, Peter Maydell wrote:
> On 17 January 2018 at 16:15, Igor Mammedov <imammedo@redhat.com> wrote:
> > my idea was to drop fixed RAM base for virt board (at least for
> > new machine types) so that QEMU could specify it dynamically and
> > firmware would get base from x0 instead of compiled in constant.
> 
> "base of ram is fixed" is about the one thing we've told
> people they can rely on without fishing it out of the
> device tree, so I think I'll just rule changing that out
> of consideration now :-)
>

So that leaves three choices:

1) New machine type that has a different or non-fixed RAM base

(Makes the QEMU/AAVMF zoo even worse.)

2) Implement spit memory where one chunk is guaranteed to be at
   the 1G boundary, e.g. 'size <= 1G' at 1G

(The QEMU work will no doubt snowball, especially when considering
 memory hotplug. Although hotplug will likely warrant using DIMMs
 anyway, which means one 'size <= 1G' at 1G DIMM could be a non-removable,
 there by default DIMM, and other DIMM(s) would go elsewhere in order to
 implement the split memory.)

3) Leave memory like it is and just put everything else we want to expand
   in high memory, probably above the second PCIe window. I.e. CPU
   redistributor regions 124 and up and an additional PCIe ECAM space
   would go up there.

(Easiest, most backward compatible thing to do. Is there risk with putting
 those things above 4G? Someday we may want to shift those things and the
 second PCIe window even higher, if we ever want to support more than 515
 GB of memory, but I guess that shouldn't be a problem.)

Thanks,
drew
