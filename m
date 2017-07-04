Received: from eggs.gnu.org ([2001:4830:134:3::10]:53218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSILZ-00025M-9K
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSILY-0005qJ-I8
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:34:09 -0400
Date: Tue, 4 Jul 2017 15:33:52 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170704073352.GD10298@lemon.lan>
References: <20170703221456.30817-1-eblake@redhat.com>
	<20170703221456.30817-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170703221456.30817-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/15] block: Allow NULL file for
 bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

On Mon, 07/03 17:14, Eric Blake wrote:
> Not all callers care about which BDS owns the mapping for a given
> range of the file.  This patch merely simplifies the callers by
> consolidating the logic in the common call point, while guaranteeing
> a non-NULL file to all the driver callbacks, for no semantic change.
> The only caller that does not care about pnum is bdrv_is_allocated,
> as invoked by vvfat; we can likewise add assertions that the rest
> of the stack does not have to worry about a NULL pnum.
> 
> Furthermore, this will also set the stage for a future cleanup: when
> a caller does not care about which BDS owns an offset, it would be
> nice to allow the driver to optimize things to not have to return
> BDRV_BLOCK_OFFSET_VALID in the first place.  In the case of fragmented
> allocation (for example, it's fairly easy to create a qcow2 image
> where consecutive guest addresses are not at consecutive host
> addresses), the current contract requires bdrv_get_block_status()
> to clamp *pnum to the limit where host addresses are no longer
> consecutive, but allowing a NULL file means that *pnum could be
> set to the full length of known-allocated data.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
