Received: from eggs.gnu.org ([2001:4830:134:3::10]:59814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dufxb-0006Fo-8P
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dufxX-0001L1-Fc
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:26:43 -0400
Date: Wed, 20 Sep 2017 15:26:32 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170920142632.GC9409@stefanha-x1.localdomain>
References: <20170920102311.25736-1-el13635@mail.ntua.gr>
	<20170920102311.25736-2-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170920102311.25736-2-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH 1/3] block: add bdrv_co_drain_end callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

On Wed, Sep 20, 2017 at 01:23:09PM +0300, Manos Pitsidianakis wrote:
> @@ -188,7 +194,7 @@ static bool bdrv_drain_recurse(BlockDriverState *bs)
>      waited = BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
>  
>      /* Ensure any pending metadata writes are submitted to bs->file.  */
> -    bdrv_drain_invoke(bs);
> +    bdrv_drain_invoke(bs, begin);

Do you need to move bdrv_drain_invoke(bs, begin) before
BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0)?

This will ensure that throttling is disabled and the TGM restarted
before we wait for requests to complete.

Stefan
