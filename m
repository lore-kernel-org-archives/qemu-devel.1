Received: from eggs.gnu.org ([2001:4830:134:3::10]:49769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cvTn9-0002Pk-Dq
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 15:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cvTn4-0007JD-KZ
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 15:06:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cvTn4-0007Io-D4
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 15:06:54 -0400
Date: Tue, 4 Apr 2017 20:06:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170404190648.GN2147@work-vm>
References: <CGME20170318151328eucas1p24d754940723a0e777a2096a678a2094d@eucas1p2.samsung.com>
	<1489850003-5652-1-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489850003-5652-1-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] Calcuate downtime for postcopy
 live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> Hi David,
> 
> I already asked you about downtime calculation for postcopy live migration.
> As I remember you said it's worth not to calculate it per vCPU or maybe I
> understood you incorrectly. I decided to proof it could be useful.

Thanks - apologies for taking so long to look at it.
Some higher level thoughts:
   a) It needs to be switchable - the tree etc look like they could use a fair
      amount of RAM.
   b) The cpu bitmask is a problem given we can have more than 64 CPUs
   c) Tracing the pages that took the longest can be interesting - I've done
      graphs of latencies before - you get fun things like watching messes
      where you lose requests and the page eventually arrives anyway after
      a few seconds.
      
> This patch set is based on commit 272d7dee5951f926fad1911f2f072e5915cdcba0
> of QEMU master branch. It requires commit into Andreas git repository
> "userfaultfd: provide pid in userfault uffd_msg"
> 
> When I tested it I found following moments are strange:
> 1. First userfault always occurs due to access to ram in vapic_map_rom_writable,
> all vCPU are sleeping in this time

That's probably not too surprising - I bet the vapic device load code does that?
I've sometimes wondered about preloading the queue on the source with some that we know
will need to be loaded early.

> 2. Latest half of all userfault was initiated by kworkers, that's why I had a doubt
> about current in handle_userfault inside kernel as a proper task_struct for pagefault
> initiator. All vCPU was sleeping at that moment.

When you say kworkers - which ones?  I wonder what they are - perhaps incoming network
packets using vhost?

> 3. Also there is a discrepancy, of vCPU state and real vCPU thread state.

What do you mean by that?

> This patch is just for showing and idea, if you ok with this idea none RFC patch will not
> include proc access && a lot of traces.
> Also I think it worth to guard postcopy_downtime in MigrationIncomingState and
> return calculated downtime into src, where qeury-migration will be invocked.

I don't think it's worth it, we can always ask the destination and sending stuff
back to the source is probably messy - especially at the end.

Dave

> Alexey Perevalov (2):
>   userfault: add pid into uffd_msg
>   migration: calculate downtime on dst side
> 
>  include/migration/migration.h     |  11 ++
>  linux-headers/linux/userfaultfd.h |   1 +
>  migration/migration.c             | 238 +++++++++++++++++++++++++++++++++++++-
>  migration/postcopy-ram.c          |  61 +++++++++-
>  migration/savevm.c                |   2 +
>  migration/trace-events            |  10 +-
>  6 files changed, 319 insertions(+), 4 deletions(-)
> 
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
