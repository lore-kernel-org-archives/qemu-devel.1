Received: from eggs.gnu.org ([2001:4830:134:3::10]:35674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciS3R-0006uU-6W
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 15:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciS3Q-0002wR-Cg
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 15:37:57 -0500
Date: Mon, 27 Feb 2017 21:37:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170227203744.GI6356@noname.redhat.com>
References: <1488193394-28453-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488193394-28453-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH V2] qemu-img: make convert async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@gmail.com, ct@flyingcircus.io, mreitz@redhat.com, famz@redhat.com, eblake@redhat.com

Am 27.02.2017 um 12:03 hat Peter Lieven geschrieben:
> the convert process is currently completely implemented with sync operations.
> That means it reads one buffer and then writes it. No parallelism and each sync
> request takes as long as it takes until it is completed.
> 
> This can be a big performance hit when the convert process reads and writes
> to devices which do not benefit from kernel readahead or pagecache.
> In our environment we heavily have the following two use cases when using
> qemu-img convert.
> 
> a) reading from NFS and writing to iSCSI for deploying templates
> b) reading from iSCSI and writing to NFS for backups
> 
> In both processes we use libiscsi and libnfs so we have no kernel cache.
> 
> This patch changes the convert process to work with parallel running coroutines
> which can significantly improve performance for network storage devices:
> 
> qemu-img (master)
>  nfs -> iscsi 22.8 secs
>  nfs -> ram   11.7 secs
>  ram -> iscsi 12.3 secs
> 
> qemu-img-async (8 coroutines, in-order write disabled)
>  nfs -> iscsi 11.0 secs
>  nfs -> ram   10.4 secs
>  ram -> iscsi  9.0 secs
> 
> This patches introduces 2 new cmdline parameters. The -m parameter to specify
> the number of coroutines running in parallel (defaults to 8). And the -W paremeter to
> allow qemu-img to write to the target out of order rather than sequential. This improves
> performance as the writes do not have to wait for each other to complete.
> 
> Signed-off-by: Peter Lieven <pl@kamp.de>

Thanks, applied to the block branch.

Kevin
