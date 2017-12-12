Received: from eggs.gnu.org ([2001:4830:134:3::10]:46802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOo07-0005he-KQ
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOo06-00041P-IT
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:05:51 -0500
Date: Tue, 12 Dec 2017 17:05:33 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171212170533.GG2409@work-vm>
References: <6cc4a99c-0212-6b7b-4a12-3e898215bea9@kamp.de>
	<20170919143829.GH2107@work-vm>
	<48cdd8ff-4940-9aa1-9aba-1acf8ce74ebe@kamp.de>
	<20170919144130.GI2107@work-vm>
	<a271a2f8-173e-45c8-bd64-16f4963b3518@kamp.de>
	<20170921123625.GE2717@work-vm>
	<b7f1d6ec-9511-ef3d-80d1-c52cf8adfc24@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7f1d6ec-9511-ef3d-80d1-c52cf8adfc24@kamp.de>
Subject: Re: [Qemu-devel] Block Migration and CPU throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu block <qemu-block@nongnu.org>, jjherne@linux.vnet.ibm.com

* Peter Lieven (pl@kamp.de) wrote:
> Am 21.09.2017 um 14:36 schrieb Dr. David Alan Gilbert:
> > * Peter Lieven (pl@kamp.de) wrote:
> > > Am 19.09.2017 um 16:41 schrieb Dr. David Alan Gilbert:
> > > > * Peter Lieven (pl@kamp.de) wrote:
> > > > > Am 19.09.2017 um 16:38 schrieb Dr. David Alan Gilbert:
> > > > > > * Peter Lieven (pl@kamp.de) wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > I just noticed that CPU throttling and Block Migration don't work together very well.
> > > > > > > During block migration the throttling heuristic detects that we obviously make no progress
> > > > > > > in ram transfer. But the reason is the running block migration and not a too high dirty pages rate.
> > > > > > > 
> > > > > > > The result is that any VM is throttled by 99% during block migration.
> > > > > > Hmm that's unfortunate; do you have a bandwidth set lower than your
> > > > > > actual network connection? I'm just wondering if it's actually going
> > > > > > between the block and RAM iterative sections or getting stuck in ne.
> > > > > It happens also if source and dest are on the same machine and speed is set to 100G.
> > > > But does it happen if they're not and the speed is set low?
> > > Yes, it does. I noticed it in our test environment between different nodes with a 10G
> > > link in between. But its totally clear why it happens. During block migration we transfer
> > > all dirty memory pages in each round (if there is moderate memory load), but all dirty
> > > pages are obviously more than 50% of the transferred ram in that round.
> > > It is more exactly 100%. But the current logic triggers on this condition.
> > > 
> > > I think I will go forward and send a patch which disables auto converge during
> > > block migration bulk stage.
> > Yes, that's fair;  it probably would also make sense to throttle the RAM
> > migration during the block migration bulk stage, since the chances are
> > it's not going to get far.  (I think in the nbd setup, the main
> > migration process isn't started until the end of bulk).
> 
> Catching up with the idea of delaying ram migration until block bulk has completed.
> What do you think is the easiest way to achieve this?

<excavates inbox, and notices I never replied>

I think the answer depends whether we think this is a 'special' or we
need a new general purpose mechanism.

If it was really general then we'd probably want to split the iterative
stage in two somehow, and only do RAM in the second half.

But I'm not sure it's worth it; I suspect the easiest way is:

   a) Add a counter in migration/ram.c or in the RAM state somewhere
   b) Make ram_save_inhibit increment the counter
   c) Check the counter at the head of ram_save_iterate and just exit
     if it's none 0
   d) Call ram_save_inhibit from block_save_setup
   e) Then release it when you've finished the bulk stage

Make sure you still count the RAM in the pending totals, otherwise
migration might think it's finished a bit early.

Dave

> Peter
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
