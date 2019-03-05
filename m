Received: from eggs.gnu.org ([209.51.188.92]:44362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1JyY-0007Mh-2u
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1JyX-0007rA-7J
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:59:58 -0500
References: <20190301191545.8728-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f6c62d23-5925-daaf-37e8-27a3026cc5c5@redhat.com>
Date: Tue, 5 Mar 2019 18:59:48 -0500
MIME-Version: 1.0
In-Reply-To: <20190301191545.8728-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/7] bitmaps: add inconsistent bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>



On 3/1/19 2:15 PM, John Snow wrote:
> Allow QEMU to read in bitmaps that have the in-use bit set, for the
> purposes of allowing users to delete those bitmaps.
> 
> This is chosen in preference to a hard error on load to minimize
> impact for a non-critical error, but to force the user or management
> utility to acknowledge that the bitmap is no longer viable.
> 
> 1. Changed wording of meaning of persistent bit, inconsistent bit
>    Declining to optimize to avoid allocations for this revision.
> 
> 2. Add Reviewed-by from Eric.
> 
> 3. Split into several patches that are more single-purpose, which
>    highlights the individual fixes more clearly;
> 
>    - Prohibit BUSY or INCONSISTENT bitmaps from being merge sources.
> 
> 4. Declining feedback to prohibit disabling or enabling readonly bitmaps,
>    on the basis that users may wish to enable/disable them prior to
>    remounting their backing storage RW.
> 
>    Decided to prohibit attempting to remove readonly bitmaps, so the
>    failure happens earlier.
> 
>    Prohibit sync=incremental backups using readonly bitmaps, because
>    they're not capable of clearing the bitmap on success.
>    sync=differential would be acceptable here. (Good spot, Vladimir.)
> 
> John Snow (7):
>   block/dirty-bitmaps: add inconsistent bit
>   block/dirty-bitmap: add inconsistent status
>   block/dirty-bitmaps: add block_dirty_bitmap_check function
>   block/dirty-bitmaps: prohibit readonly bitmaps for backups
>   block/dirty-bitmaps: prohibit removing readonly bitmaps
>   block/dirty-bitmaps: disallow busy bitmaps as merge source
>   block/dirty-bitmaps: implement inconsistent bit
> 
>  qapi/block-core.json           |  20 +++++--
>  include/block/dirty-bitmap.h   |  15 ++++-
>  block/dirty-bitmap.c           |  63 +++++++++++++++++---
>  block/qcow2-bitmap.c           | 103 +++++++++++++++++----------------
>  blockdev.c                     |  50 ++++------------
>  migration/block-dirty-bitmap.c |  12 +---
>  nbd/server.c                   |   3 +-
>  7 files changed, 151 insertions(+), 115 deletions(-)
> 

Thanks for the reviews Eric, I have staged this on my bitmaps branch. I
realize this is hasty, but it's time to get patches in for release, and
it will make reviewing the next series earlier.

Vladimir, I realize I didn't take a few of your suggestions here so I am
delaying sending the PR for this a little bit to give you a chance to
object.

--js
