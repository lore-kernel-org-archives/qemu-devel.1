Received: from eggs.gnu.org ([2001:4830:134:3::10]:40426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSJNf-0002KI-4M
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSJNa-0003fm-52
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:40:19 -0400
Date: Tue, 4 Jul 2017 16:40:06 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170704084006.GI10298@lemon.lan>
References: <20170703221456.30817-1-eblake@redhat.com>
	<20170703221456.30817-9-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170703221456.30817-9-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 08/15] block: Convert
 bdrv_get_block_status() to bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

On Mon, 07/03 17:14, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  In the common case, allocation is unlikely to ever use
> values that are not naturally sector-aligned, but it is possible
> that byte-based values will let us be more precise about allocation
> at the end of an unaligned file that can do byte-based access.
> 
> Changing the name of the function from bdrv_get_block_status() to
> bdrv_block_status() ensures that the compiler enforces that all
> callers are updated.  For now, the io.c layer still assert()s that
> all callers are sector-aligned, but that can be relaxed when a later
> patch implements byte-based block status in the drivers.
> 
> Note that we have an inherent limitation in the BDRV_BLOCK_* return
> values: BDRV_BLOCK_OFFSET_VALID can only return the start of a
> sector, even if we later relax the interface to query for the status
> starting at an intermediate byte; document the obvious interpretation
> that valid offsets are always sector-relative.
> 
> Therefore, for the most part this patch is just the addition of scaling
> at the callers followed by inverse scaling at bdrv_block_status().  But
> some code, particularly bdrv_is_allocated(), gets a lot simpler because
> it no longer has to mess with sectors.
> 
> For ease of review, bdrv_get_block_status_above() will be tackled
> separately.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
