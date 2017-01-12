Received: from eggs.gnu.org ([2001:4830:134:3::10]:59636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cRdgE-0008SB-Gy
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cRdgD-0002ZI-FC
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:36:30 -0500
Date: Thu, 12 Jan 2017 12:36:19 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170112113619.zuc5tuhmhzvawnmz@hawk.localdomain>
References: <98b1ad64-fe10-4ede-3493-f6d4b49ee1d9@sysgo.com>
	<CAFEAcA8asry6LGTuv+SLVyemNVFk9Q7WhU74Cc2YA_yud8qPMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8asry6LGTuv+SLVyemNVFk9Q7WhU74Cc2YA_yud8qPMg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] pflash_cfi01: fix per device sector length
 in CFI table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Engraf <david.engraf@sysgo.com>, Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, dgilbert@redhat.com

On Thu, Jan 12, 2017 at 10:42:41AM +0000, Peter Maydell wrote:
> On 12 January 2017 at 10:35, David Engraf <david.engraf@sysgo.com> wrote:
> > The CFI entry for sector length must be set to sector length per device.
> > This is important for boards using multiple devices like the ARM Vexpress
> > board (width = 4, device-width = 2).
> >
> > Linux and u-boots calculate the size ratio by dividing both values:
> >
> > size_ratio = info->portwidth / info->chipwidth;
> >
> > After that the sector length will be multiplied by the size_ratio, thus the
> > CFI entry for sector length is doubled. When Linux or u-boot send a sector
> > erase, they expect to erase the doubled sector length, but QEMU only erases
> > the board specified sector length.
> >
> > This patch fixes the sector length in the CFI table to match the length per
> > device, equal to blocks_per_device.
> 
> Thanks for the patch. I haven't checked against the pflash spec yet,
> but this looks like it's probably the right thing.
> 
> The only two machines which use a setup with multiple devices (ie
> which specify device_width to the pflash_cfi01) are vexpress and virt.
> For all other machines this patch leaves the behaviour unchanged.
> 
> Q: do we need to have some kind of nasty hack so that pre-2.9 virt
> still gets the old broken values in the CFI table, for version and
> migration compatibility? Ccing Drew for an opinion...
>

I'm pretty sure we need the nasty hack, but I'm also Ccing David for
his opinion.

Thanks,
drew
