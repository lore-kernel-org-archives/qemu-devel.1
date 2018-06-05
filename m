Received: from eggs.gnu.org ([2001:4830:134:3::10]:57312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fQC8F-0000QF-NQ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fQC8E-0006VK-Nn
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:36:15 -0400
Date: Tue, 5 Jun 2018 09:36:04 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180605133604.GB6435@localhost.localdomain>
References: <20180531205046.153256-1-eblake@redhat.com>
	<20180531205046.153256-6-eblake@redhat.com>
	<20180604213327.GF14298@localhost.localdomain>
	<49cdd9e3-11ba-1b82-5a5d-1813359bfdf7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49cdd9e3-11ba-1b82-5a5d-1813359bfdf7@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 5/8] qcow: Switch to a
 byte-based driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Tue, Jun 05, 2018 at 06:12:33AM -0500, Eric Blake wrote:
> On 06/04/2018 04:33 PM, Jeff Cody wrote:
> >On Thu, May 31, 2018 at 03:50:43PM -0500, Eric Blake wrote:
> >>We are gradually moving away from sector-based interfaces, towards
> >>byte-based.  The qcow driver is now ready to fully utilize the
> >>byte-based callback interface, as long as we override the default
> >>alignment to still be 512 (needed at least for asserts present
> >>because of encryption, but easier to do everywhere than to audit
> >>which sub-sector requests are handled correctly, especially since
> >>we no longer recommend qcow for new disk images).
> >>
> >>Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> >>-static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
> >>-                         int nb_sectors, QEMUIOVector *qiov)
> >>+static void qcow_refresh_limits(BlockDriverState *bs, Error **errp)
> >>+{
> >>+    /* At least encrypted images require 512-byte alignment. Apply the
> >>+     * limit universally, rather than just on encrypted images, as
> >>+     * it's easier to let the block layer handle rounding than to
> >>+     * audit this code further. */
> >>+    bs->bl.request_alignment = BDRV_SECTOR_SIZE;
> >>+}
> >>+
> >>+static coroutine_fn int qcow_co_preadv(BlockDriverState *bs, uint64_t offset,
> >>+                                       uint64_t bytes, QEMUIOVector *qiov,
> >>+                                       int flags)
> >>  {
> >>      BDRVQcowState *s = bs->opaque;
> >>      int offset_in_cluster;
> >>@@ -624,9 +632,8 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
> >>      QEMUIOVector hd_qiov;
> >>      uint8_t *buf;
> >>      void *orig_buf;
> >>-    int64_t offset = sector_num * BDRV_SECTOR_SIZE;
> >>-    int64_t bytes = nb_sectors * BDRV_SECTOR_SIZE;
> >>
> >>+    assert(!flags);
> >
> >Why this assert here and in the _pwritev()?
> 
> We're changing from an interface that didn't have flags to one that does,
> but we are not prepared to handle any flags, so the assert proves the block
> layer doesn't hand us any flags we aren't expecting (there are no block
> layer flags for pread at the moment; and no flags for pwrite because we
> didn't set bs->supported_write_flags).


Thanks.

Reviewed-by: Jeff Cody <jcody@redhat.com>
