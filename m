Received: from eggs.gnu.org ([2001:4830:134:3::10]:56914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fB0Er-00045I-V1
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fB0Er-00077E-14
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:52:18 -0400
Date: Tue, 24 Apr 2018 17:52:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180424155205.GD4080@localhost.localdomain>
References: <20180215192829.9944-1-eblake@redhat.com>
	<20180215192829.9944-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215192829.9944-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/6] null: Switch to byte-based read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 15.02.2018 um 20:28 hat Eric Blake geschrieben:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Make the change for the last few sector-based callbacks
> in the null-co and null-aio drivers.
> 
> Note that since the null driver does nothing on writes, it trivially
> supports the BDRV_REQ_FUA flag (all writes have already landed to
> the same bit-bucket without needing an extra flush call).  Furthermore,
> bdrv_refresh_limits() defaults the block size to 512 for any driver
> that does not support coroutines; while this is still correct for the
> other aio-based drivers, the null driver does just as well with
> byte-based requests, and being explicit means we can avoid cycles
> wasted on read-modify-write.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

> +static void null_refresh_limits(BlockDriverState *bs, Error **errp)
> +{
> +    bs->bl.request_alignment = 1;
> +}

I would rather modify bdrv_refresh_limits() so that it defaults to 1 for
drivers supporting either .bdrv_co_preadv or .bdrv_aio_preadv.

Kevin
