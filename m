Received: from eggs.gnu.org ([2001:4830:134:3::10]:39811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVdII-00028u-UR
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVdII-0008U7-2d
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:32:34 -0400
Date: Thu, 13 Jul 2017 14:32:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170713123225.GE4139@noname.redhat.com>
References: <20170709210717.984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170709210717.984-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] block/vpc.c: Handle write failures in
 get_image_offset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 09.07.2017 um 23:07 hat Peter Maydell geschrieben:
> Coverity (CID 1355236) points out that get_image_offset() doesn't check that
> it actually succeeded in writing the updated block bitmap to the file.
> Check the error return from bdrv_pwrite_sync() and propagate an error
> response back up to the function which calls get_image_offset() for
> a write so that it can return the error to its caller.
> 
> get_sector_offset() is only used for reads, but we move it to the
> same API for consistency.
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Thanks, applied to the block branch.

> The new get_image_offset() API is pretty clunky, but I couldn't
> think of anything better -- we need to report one of 3 things:
>  * offset number (0..INT64_MAX)
>  * sector not allocated
>  * arbitrary errno
> and they won't all fit into one return value.
> I opted for "minimal change compared to current code".

Good enough for vpc. I guess I would have chosen to return the offset by
reference and use the actual return value for 1=allocated, 0=unallocated
and -errno on error.

get_sector_offset() has two useless parameters now instead of one, but
I'll just send a patch on top to remove them.

Kevin
