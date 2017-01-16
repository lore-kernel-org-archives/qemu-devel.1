Received: from eggs.gnu.org ([2001:4830:134:3::10]:34660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cT4UV-0005jd-FX
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 05:26:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cT4UU-0003gQ-JR
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 05:26:19 -0500
Date: Mon, 16 Jan 2017 10:26:06 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170116102606.GB2136@work-vm>
References: <98b1ad64-fe10-4ede-3493-f6d4b49ee1d9@sysgo.com>
	<CAFEAcA8asry6LGTuv+SLVyemNVFk9Q7WhU74Cc2YA_yud8qPMg@mail.gmail.com>
	<20170112113619.zuc5tuhmhzvawnmz@hawk.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170112113619.zuc5tuhmhzvawnmz@hawk.localdomain>
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
To: Andrew Jones <drjones@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, David Engraf <david.engraf@sysgo.com>, Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

* Andrew Jones (drjones@redhat.com) wrote:
> On Thu, Jan 12, 2017 at 10:42:41AM +0000, Peter Maydell wrote:
> > On 12 January 2017 at 10:35, David Engraf <david.engraf@sysgo.com> wrote:
> > > The CFI entry for sector length must be set to sector length per device.
> > > This is important for boards using multiple devices like the ARM Vexpress
> > > board (width = 4, device-width = 2).
> > >
> > > Linux and u-boots calculate the size ratio by dividing both values:
> > >
> > > size_ratio = info->portwidth / info->chipwidth;
> > >
> > > After that the sector length will be multiplied by the size_ratio, thus the
> > > CFI entry for sector length is doubled. When Linux or u-boot send a sector
> > > erase, they expect to erase the doubled sector length, but QEMU only erases
> > > the board specified sector length.
> > >
> > > This patch fixes the sector length in the CFI table to match the length per
> > > device, equal to blocks_per_device.
> > 
> > Thanks for the patch. I haven't checked against the pflash spec yet,
> > but this looks like it's probably the right thing.
> > 
> > The only two machines which use a setup with multiple devices (ie
> > which specify device_width to the pflash_cfi01) are vexpress and virt.
> > For all other machines this patch leaves the behaviour unchanged.
> > 
> > Q: do we need to have some kind of nasty hack so that pre-2.9 virt
> > still gets the old broken values in the CFI table, for version and
> > migration compatibility? Ccing Drew for an opinion...
> >
> 
> I'm pretty sure we need the nasty hack, but I'm also Ccing David for
> his opinion.

Hmm I don't understand enough about pflash to understand the change here;
but generally if you need to keep something unchanged for older
machine types, add a property and then set that property in
the compatibility macros.

See include/hw/compat.h, I think you'd add the entry to HW_COMPAT_2_8
and follow a simple example like  old_msi_addr on intel-hda.c,
that should get picked up by aarch, x86, ppc etc versioned machine types.

Dave


> Thanks,
> drew
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
