Received: from eggs.gnu.org ([2001:4830:134:3::10]:36416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clanQ-0000dc-2E
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 07:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clanO-0006hF-SY
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 07:34:24 -0500
Date: Wed, 8 Mar 2017 13:34:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170308123410.GD5211@noname.redhat.com>
References: <20170308120814.29967-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308120814.29967-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v3] file-posix: Consider
 max_segments for BlockLimits.max_transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, eblake@redhat.com

Am 08.03.2017 um 13:08 hat Fam Zheng geschrieben:
> BlockLimits.max_transfer can be too high without this fix, guest will
> encounter I/O error or even get paused with werror=stop or rerror=stop. The
> cause is explained below.
> 
> Linux has a separate limit, /sys/block/.../queue/max_segments, which in
> the worst case can be more restrictive than the BLKSECTGET which we
> already consider (note that they are two different things). So, the
> failure scenario before this patch is:
> 
> 1) host device has max_sectors_kb = 4096 and max_segments = 64;
> 2) guest learns max_sectors_kb limit from QEMU, but doesn't know
>    max_segments;
> 3) guest issues e.g. a 512KB request thinking it's okay, but actually
>    it's not, because it will be passed through to host device as an
>    SG_IO req that has niov > 64;
> 4) host kernel doesn't like the segmenting of the request, and returns
>    -EINVAL;
> 
> This patch checks the max_segments sysfs entry for the host device and
> calculates a "conservative" bytes limit using the page size, which is
> then merged into the existing max_transfer limit. Guest will discover
> this from the usual virtual block device interfaces. (In the case of
> scsi-generic, it will be done in the INQUIRY reply interception in
> device model.)
> 
> The other possibility is to actually propagate it as a separate limit,
> but it's not better. On the one hand, there is a big complication: the
> limit is per-LUN in QEMU PoV (because we can attach LUNs from different
> host HBAs to the same virtio-scsi bus), but the channel to communicate
> it in a per-LUN manner is missing down the stack; on the other hand,
> two limits versus one doesn't change much about the valid size of I/O
> (because guest has no control over host segmenting).
> 
> Also, the idea to fall back to bounce buffering in QEMU, upon -EINVAL,
> was explored. Unfortunately there is no neat way to ensure the bounce
> buffer is less segmented (in terms of DMA addr) than the guest buffer.
> 
> Practically, this bug is not very common. It is only reported on a
> Emulex (lpfc), so it's okay to get it fixed in the easier way.
> 
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to the block branch.

Kevin
