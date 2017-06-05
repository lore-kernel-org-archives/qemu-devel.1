Received: from eggs.gnu.org ([2001:4830:134:3::10]:40155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dI0wl-0002s3-Nj
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 18:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dI0wk-0003VP-Pn
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 18:58:03 -0400
References: <20170511022036.32225-1-eblake@redhat.com>
	<20170511022036.32225-19-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <716ad328-06e7-7d87-eabf-60aecd6a1736@redhat.com>
Date: Mon, 5 Jun 2017 18:57:48 -0400
MIME-Version: 1.0
In-Reply-To: <20170511022036.32225-19-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 18/20] block: Make bdrv_is_allocated()
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Jeff Cody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 05/10/2017 10:20 PM, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  In the common case, allocation is unlikely to ever use
> values that are not naturally sector-aligned, but it is possible
> that byte-based values will let us be more precise about allocation
> at the end of an unaligned file that can do byte-based access.
> 
> Changing the signature of the function to use int64_t *pnum ensures
> that the compiler enforces that all callers are updated.  For now,
> the io.c layer still assert()s that all callers are sector-aligned
> on input and that *pnum is sector-aligned on return to the caller,
> but that can be relaxed when a later patch implements byte-based
> block status.  Therefore, this code adds usages like
> DIV_ROUND_UP(,BDRV_SECTOR_SIZE) to callers that still want aligned
> values, where the call might reasonbly give non-aligned results
> in the future; on the other hand, no rounding is needed for callers
> that should just continue to work with byte alignment.
> 
> For the most part this patch is just the addition of scaling at the
> callers followed by inverse scaling at bdrv_is_allocated().  But
> some code, particularly bdrv_commit(), gets a lot simpler because it
> no longer has to mess with sectors; also, it is now possible to pass
> NULL if the caller does not care how much of the image is allocated
> beyond the initial offset.
> 
> For ease of review, bdrv_is_allocated_above() will be tackled
> separately.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
> v2: rebase to earlier changes, tweak commit message
> ---
>  include/block/block.h |  4 +--
>  block/backup.c        | 17 ++++---------
>  block/commit.c        | 21 +++++++---------
>  block/io.c            | 49 +++++++++++++++++++++++++-----------
>  block/stream.c        |  5 ++--
>  block/vvfat.c         | 34 ++++++++++++++-----------
>  migration/block.c     |  9 ++++---
>  qemu-img.c            |  5 +++-
>  qemu-io-cmds.c        | 70 +++++++++++++++++++++++----------------------------
>  9 files changed, 114 insertions(+), 100 deletions(-)
> 
