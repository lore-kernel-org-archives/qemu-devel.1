Received: from eggs.gnu.org ([2001:4830:134:3::10]:41941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRN6l-0006R2-6z
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 15:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRN6k-0001c6-7I
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 15:31:35 -0400
References: <20180606182449.1607-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3c3c51a2-52c3-a621-7567-b42c94999051@redhat.com>
Date: Fri, 8 Jun 2018 15:31:23 -0400
MIME-Version: 1.0
In-Reply-To: <20180606182449.1607-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] block dirty bitmaps: support
 libvirt API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 06/06/2018 02:24 PM, John Snow wrote:
> This is largely the same series that Vladimir sent in January, but at
> the time I was unsure of if we'd want these commands or not in QEMU.
> 
> After discussing with Virtuozzo their plans for a checkpoint-like API
> implemented primarily in libvirt, I agree that these commands are at
> least tentatively useful.
> 
> Eric Blake is currently writing a counter-proposal and demo API to show
> to Virtuozzo on libvirt's development list. Check in these QMP commands
> with the experimental prefix 'x-' for now so that it can be used for
> prototyping.
> 
> Once the design for the libvirt API looks reasonably final I will
> remove the 'x-' prefixes, or, if we wind up not using these particular
> commands I will delete them entirely.
> 
> v4:
>  - Reinstated Vladimir's authorship credit on all patches
>  - Switched 2.12 to 3.0
>  - Edited doc to clarify failure mode for merge (Jeff)
>  - Removed !bs check where applicable (Jeff)
> 
> v3:
>  - Drop patch one (already merged)
>  - Minor phrasing adjustments to documentation
>  - Removed &state->bs argument to bitmap lookup for enable/disable
>  - Added x- prefix to all three commands and to add's new argument.
> 
> Vladimir's original cover letter is below:
> 
> There are three qmp commands, needed to implement external backup API.
> 
> Using these three commands, client may do all needed bitmap management by
> hand:
> 
> on backup start we need to do a transaction:
>  {disable old bitmap, create new bitmap}
> 
> on backup success:
>  drop old bitmap
> 
> on backup fail:
>  enable old bitmap
>  merge new bitmap to old bitmap
>  drop new bitmap
> 
> Vladimir Sementsov-Ogievskiy (5):
>   block/dirty-bitmap: add lock to bdrv_enable/disable_dirty_bitmap
>   qapi: add x-block-dirty-bitmap-enable/disable
>   qmp: transaction support for x-block-dirty-bitmap-enable/disable
>   qapi: add x-block-dirty-bitmap-merge
>   qapi: add disabled parameter to block-dirty-bitmap-add
> 
>  block/dirty-bitmap.c         |  24 ++++++-
>  blockdev.c                   | 163 ++++++++++++++++++++++++++++++++++++++++++-
>  include/block/dirty-bitmap.h |   3 +-
>  qapi/block-core.json         |  86 ++++++++++++++++++++++-
>  qapi/transaction.json        |   4 ++
>  5 files changed, 275 insertions(+), 5 deletions(-)
> 

Hmm, I sorta-maybe have jurisdiction on this, but it touches more
blockdev.c and qapi/block-core.json than it does block/dirty-bitmap.c.

I'm gonna send a PR for this and if I was wrong about that, Kevin, just
veto the PR thread.

--js
