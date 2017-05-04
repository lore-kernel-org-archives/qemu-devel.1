Received: from eggs.gnu.org ([2001:4830:134:3::10]:56363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6AQ8-0006e4-9E
	for qemu-devel@nongnu.org; Thu, 04 May 2017 02:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6AQ7-0000jq-Dy
	for qemu-devel@nongnu.org; Thu, 04 May 2017 02:39:24 -0400
Date: Thu, 4 May 2017 14:39:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170504063912.GB19184@lemon.lan>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/17] block: access wakeup with atomic ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, 04/20 14:00, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/io.c                | 3 ++-
>  block/nfs.c               | 4 +++-
>  block/sheepdog.c          | 3 ++-
>  include/block/block.h     | 5 +++--
>  include/block/block_int.h | 4 ++--
>  5 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 869322a..3b2ede9 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -501,7 +501,8 @@ static void dummy_bh_cb(void *opaque)
>  
>  void bdrv_wakeup(BlockDriverState *bs)
>  {
> -    if (bs->wakeup) {
> +    /* The barrier (or an atomic op) is in the caller.  */

Why not add a barrier here so that callers don't need to worry about that?

> +    if (atomic_read(&bs->wakeup)) {
>          aio_bh_schedule_oneshot(qemu_get_aio_context(), dummy_bh_cb, NULL);
>      }
>  }

Fam
