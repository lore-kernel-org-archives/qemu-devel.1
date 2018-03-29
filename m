Received: from eggs.gnu.org ([2001:4830:134:3::10]:32859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1VSj-0002zC-NE
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1VSf-00046E-C1
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:11:21 -0400
Date: Thu, 29 Mar 2018 12:11:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180329111059.GD2982@work-vm>
References: <1521530809-11780-1-git-send-email-zhaoshenglong@huawei.com>
	<1521530809-11780-3-git-send-email-zhaoshenglong@huawei.com>
	<CAFEAcA96qV_f7i_36Yzb-QV7W9SRHKfJpg=rvv3tia2X-Xi7QQ@mail.gmail.com>
	<5AB0F254.3050503@huawei.com>
	<CAFEAcA-Ct3qa0OFZ4U+9RH68SQJgmkxJKKS5e+if_MuL2pSu3A@mail.gmail.com>
	<5AB21130.2020309@huawei.com>
	<CAFEAcA8yr+KJFwBSksMP-VjNbsSd190VCzB4wGwOCoaX2ScDiA@mail.gmail.com>
	<CAFEAcA_r=S=YWAuZue1zZnFdtFYK2wU7NnaCcGThZU_u33qD4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_r=S=YWAuZue1zZnFdtFYK2wU7NnaCcGThZU_u33qD4g@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 2/2] arm_gicv3_kvm:
 kvm_dist_get/put: skip the registers banked by GICR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>, Juan Quintela <quintela@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 23 March 2018 at 12:08, Peter Maydell <peter.maydell@linaro.org> wrote:
> > On 21 March 2018 at 08:00, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> >> On 2018/3/20 19:54, Peter Maydell wrote:
> >>> Can you still successfully migrate a VM from a QEMU version
> >>> without this bugfix to one with the bugfix ?
> >>>
> >> I've tested this case. I can migrate a VM between these two versions.
> >
> > Hmm. Looking at the code I can't see how that would work,
> > except by accident. Let me see if I understand what's happening
> > here:
> >
> > In the code in master, we have QEMU data structures
> > (bitmaps, etc) which have one entry for each of GICV3_MAXIRQ
> > irqs. That includes the RAZ/WI unused space for the SPIs/PPIs, so
> > for a 1-bit-per-irq bitmap:
> >  [0x00000000, irq 32, irq 33, .... ]
> >
> > When we fill in the values from KVM into these data structures,
> > we start after the unused space, because the for_each_dist_irq_reg()
> > macro starts with _irq = GIC_INTERNAL. But we forgot to adjust
> > the offset value we use for the KVM access, so we start by
> > reading the RAZ/WI values from KVM, and the data structure
> > contents end up with:
> >  [0x00000000, 0x00000000, irq 32, irq 33, ... ]
> > (and the last irqs wouldn't get transferred).
> >
> > With this change to the code we will get the offset right and
> > the data structure will be filled as
> >  [0x00000000, irq 32, irq 33, .... ]
> >
> > But for migration from the old version, the data structure
> > we receive from the migration source will contain the old
> > broken layout of
> >  [0x00000000, 0x00000000, irq 32, irq 33, ... ]
> > so if the new code doesn't do anything special to handle
> > migration from that old version then it will write zeroes to
> > irq 32..63, and then write incorrect values for all the irqs
> > after that, won't it?
> >
> > That suggests to me that we need to have some code in the
> > migration post-load routine that identifies that the data
> > is coming from an old version with this bug, and shifts
> > all the data down in the arrays so that the code to write
> > it to the kernel can handle it.
> 
> I was thinking a bit more about how to handle this, and
> my best idea was:
> 
> (1) send something in the migration stream that says
> "I don't have this bug" (version number change?
> vmstate field that's just a "no bug" flag? subsection
> with no contents?)
> 
> (2) on the destination, if the source doesn't tell us
> it doesn't have this bug, and we are running KVM, then
> shift all the data in the arrays down to fix it up
> [Strictly what we want to know is if the source is
> running KVM, not if the destination is, but I don't
> know of a way to find that out, and in practice TCG->KVM
> migrations don't work anyway, so it's not a big deal.]
> 
> Juan, David, do you have any suggestions for the best
> mechanism for part 1; or is there some clever way to
> handle this sort of bug that I've missed?

The subsection is probably the best bet; unless that is you can find
a bit to misuse in an existing field.

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
