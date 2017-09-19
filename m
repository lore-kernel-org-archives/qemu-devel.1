Received: from eggs.gnu.org ([2001:4830:134:3::10]:60450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duJg1-0006EV-Uj
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duJfw-0003iV-3Y
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:39:05 -0400
Date: Tue, 19 Sep 2017 15:38:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170919143829.GH2107@work-vm>
References: <6cc4a99c-0212-6b7b-4a12-3e898215bea9@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cc4a99c-0212-6b7b-4a12-3e898215bea9@kamp.de>
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
> Hi,
> 
> I just noticed that CPU throttling and Block Migration don't work together very well.
> During block migration the throttling heuristic detects that we obviously make no progress
> in ram transfer. But the reason is the running block migration and not a too high dirty pages rate.
> 
> The result is that any VM is throttled by 99% during block migration.

Hmm that's unfortunate; do you have a bandwidth set lower than your
actual network connection? I'm just wondering if it's actually going
between the block and RAM iterative sections or getting stuck in ne.

> I wonder what the best way would be fix this. I came up with the following ideas so far:
> 
> - disable throttling while block migration is in bulk stage

mig_throttle_guest_down is currently in migration/ram.c
so however we do it, we've got to add an 'inhibit' that
block.c could set (I suggest a counter so that it could
be set by a few things).

> - check if absolute number of num_dirty_pages_period crosses a threshold and not if its just
>   greater than 50% of transferred bytes
> - check if migration_dirty_pages > 0. This slows down throttling, but does not avoid it completely.

An interesting question is whether you want to inhibit in the non-bulk
stage if IO writes are happening too quickly to keep up.

Dave

> 
> Peter
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
