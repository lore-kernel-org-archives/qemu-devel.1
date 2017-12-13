Received: from eggs.gnu.org ([2001:4830:134:3::10]:45560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eOyPp-0001jj-IF
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 23:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eOyPo-0004o3-RI
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 23:13:05 -0500
Date: Wed, 13 Dec 2017 12:12:48 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171213041248.GB31040@lemon>
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171113162053.58795-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com

On Mon, 11/13 19:20, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
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
> Question: it may be better to make one command instead of two:
> block-dirty-bitmap-set-enabled(bool enabled)
> 
> Vladimir Sementsov-Ogievskiy (4):
>   block/dirty-bitmap: add lock to bdrv_enable/disable_dirty_bitmap
>   qapi: add block-dirty-bitmap-enable/disable
>   qmp: transaction support for block-dirty-bitmap-enable/disable
>   qapi: add block-dirty-bitmap-merge
> 
>  qapi/block-core.json         |  80 +++++++++++++++++++++++
>  qapi/transaction.json        |   4 ++
>  include/block/dirty-bitmap.h |   2 +
>  block/dirty-bitmap.c         |  21 ++++++
>  blockdev.c                   | 151 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 258 insertions(+)
> 

I think tests are required to merge new features/commands.  Can we include tests
on these new code please?  We should cover error handling, and also write tests
that demonstrate the intended real world use cases.

Also should we add new sections to docs/interop/bitmaps.rst?

Meta: John started a long discussion about the API design but I think after all
it turns out exposing dirty bitmap objects and the primitives is a reasonable
approach to implement incremental backup functionalities. The comment I have is
that we should ensure we have also reviewed it from a higher level (e.g. all the
potential user requirements) to make sure this low level API is both sound and
flexible. We shouldn't introduce a minimal set of low level commands just to
support one particular use case, but look a bit further and broader and come up
with a more complete design? Writing docs and tests might force us to think in
this direction, which I think is a good thing to have for this series, too.

Fam
