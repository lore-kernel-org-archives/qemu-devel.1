Received: from eggs.gnu.org ([2001:4830:134:3::10]:45612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ef9wx-00007M-2f
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ef9wu-0006bE-0Y
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:46:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ef9wt-0006af-Qb
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:46:07 -0500
Date: Fri, 26 Jan 2018 19:46:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180126194559.GI2610@work-vm>
References: <20180124212246.2352-1-wei@redhat.com>
	<20180125200525.GC2442@work-vm>
	<6e27688f-1350-62f5-23ff-7855ea502be9@redhat.com>
	<CAFEAcA_9HJBETLvsUs9dk=Hw-G_eswNt3R+o+fs70vM9buAeBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_9HJBETLvsUs9dk=Hw-G_eswNt3R+o+fs70vM9buAeBA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH V1 1/1] tests: Add migration test for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Andrew Jones <drjones@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 26 January 2018 at 15:47, Wei Huang <wei@redhat.com> wrote:
> >
> >
> > On 01/25/2018 02:05 PM, Dr. David Alan Gilbert wrote:
> >> * Wei Huang (wei@redhat.com) wrote:
> >>> innerloop:
> >>>         /* clean cache because el2 might still cache guest data under KVM */
> >>>         dc      civac, x2
> >>
> >> Can you explain a bit more about that please;  if it's guest
> >> visible acorss migration, doesn't that suggest we need the cache clear
> >> in KVM or QEMU?
> >
> > I think this is ARM specific. This is caused by the inconsistency
> > between guest VM's data accesses and userspace's accesses (in
> > check_guest_ram) at the destination:
> >
> > 1) Because uncacheable (guest) + cacheable (host) ==> uncacheable. So
> > the data accesses from guest VM go directly into memory.
> > 2) QEMU user space will use the cacheable version. So it is possible
> > that data can come from cache, instead of RAM. The difference between
> > (1) and (2) obviously can cause check_guest_ram() to fail sometimes.
> 
> I think the correct fix here is that your test code should turn
> its MMU on. Trying to treat guest RAM as uncacheable doesn't work
> for Arm KVM guests (for the same reason that VGA device video memory
> doesn't work). If it's RAM your guest has to arrange to map it as
> Normal Cacheable, and then everything should work fine.

Does this cause problems with migrating at just the wrong point during
a VM boot?

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
