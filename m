Received: from eggs.gnu.org ([2001:4830:134:3::10]:41519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebsq5-0006ve-LX
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 13:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebsq1-0004I5-HP
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 13:53:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebsq1-0004Ha-7I
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 13:53:29 -0500
Date: Wed, 17 Jan 2018 19:53:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180117195321.55f5e7e8@redhat.com>
In-Reply-To: <20180117165348.xo3pat6voqaacmfz@kamzik.brq.redhat.com>
References: <CAFEAcA8F4iO91c8OGtDbHQ_hqzY+9ka41PW4q+ES9sYGRUha0g@mail.gmail.com>
	<176e66bb-7990-20da-a82f-fbabd9b4ed88@redhat.com>
	<CAKv+Gu__twgv27OxV=ORHywzeotk3+TNYo_-=bSjdFokfmXyGw@mail.gmail.com>
	<20180117171540.7e892ce7@redhat.com>
	<CAFEAcA89q-HzCHUsW7=9KovWx0tamPtgirPaiFHu7cFxhuoZnA@mail.gmail.com>
	<20180117165348.xo3pat6voqaacmfz@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU virt board: extending various limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Wei Huang <wei@redhat.com>, "Leif
	Lindholm (Linaro address)" <leif.lindholm@linaro.org>

On Wed, 17 Jan 2018 17:53:48 +0100
Andrew Jones <drjones@redhat.com> wrote:

> On Wed, Jan 17, 2018 at 04:18:30PM +0000, Peter Maydell wrote:
> > On 17 January 2018 at 16:15, Igor Mammedov <imammedo@redhat.com> wrote:  
> > > my idea was to drop fixed RAM base for virt board (at least for
> > > new machine types) so that QEMU could specify it dynamically and
> > > firmware would get base from x0 instead of compiled in constant.  
> > 
> > "base of ram is fixed" is about the one thing we've told
> > people they can rely on without fishing it out of the
> > device tree, so I think I'll just rule changing that out
> > of consideration now :-)
> >  
> 
> So that leaves three choices:
> 
> 1) New machine type that has a different or non-fixed RAM base
> 
> (Makes the QEMU/AAVMF zoo even worse.)
may be it's a way to go, we can drop all the stuff we don't
really need for virt use case and new firmware would
pick up RAM base from x0 and it would be able to work on
both new and old (fixed base put in x0) machine type.
Guests that want to run on new machine would have to
be booted by new AAVMF or handle dynamic RAM base from
x0 themselves.

how about virt-enterprise (64bit only EFI OS support booted by AAVMF)?

> 2) Implement spit memory where one chunk is guaranteed to be at
>    the 1G boundary, e.g. 'size <= 1G' at 1G
> 
> (The QEMU work will no doubt snowball, especially when considering
>  memory hotplug. Although hotplug will likely warrant using DIMMs
>  anyway, which means one 'size <= 1G' at 1G DIMM could be a non-removable,
>  there by default DIMM, and other DIMM(s) would go elsewhere in order to
>  implement the split memory.)
look at PC memory map and a bunch of tweaks that alter it,
it's hard to figure out if a change to it would break something.
So if we can (i.e. not restricted by spec) than we should go
for a flexible route that doesn't have design issues from the start.


> 3) Leave memory like it is and just put everything else we want to expand
>    in high memory, probably above the second PCIe window. I.e. CPU
>    redistributor regions 124 and up and an additional PCIe ECAM space
>    would go up there.
> 
> (Easiest, most backward compatible thing to do. Is there risk with putting
>  those things above 4G? Someday we may want to shift those things and the
>  second PCIe window even higher, if we ever want to support more than 515
>  GB of memory, but I guess that shouldn't be a problem.)
we can do that, but platform is too new so eventually we might
have to change layout and have to deal with compat issues than,
but it will be too late to change direction (with existing customers)
so we would have to live with self-inflicted pain which could
be avoided if we made thing flexible.


> 
> Thanks,
> drew
