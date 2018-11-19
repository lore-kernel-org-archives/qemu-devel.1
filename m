Received: from eggs.gnu.org ([2001:4830:134:3::10]:43824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gOf2o-00089K-4Y
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 03:36:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gOf2m-0003L4-4W
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 03:36:34 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181116164526.31487-2-mreitz@redhat.com>
References: <20181116164526.31487-1-mreitz@redhat.com>
	<20181116164526.31487-2-mreitz@redhat.com>
Date: Mon, 19 Nov 2018 09:35:41 +0100
Message-ID: <w51y39psbvm.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1? v2 1/3] block: Always abort reopen
 after prepare succeeded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

On Fri 16 Nov 2018 05:45:24 PM CET, Max Reitz wrote:
> bdrv_reopen_multiple() does not invoke bdrv_reopen_abort() for the
> element of the reopen queue for which bdrv_reopen_prepare() failed,
> because it assumes that the prepare function will have rolled back all
> changes already.
>
> However, bdrv_reopen_prepare() does not do this in every case: It may
> notice an error after BlockDriver.bdrv_reopen_prepare() succeeded, and
> it will not invoke BlockDriver.bdrv_reopen_abort() then; and neither
> will bdrv_reopen_multiple(), as explained above.
>
> This is wrong because we must always call .bdrv_reopen_commit() or
> .bdrv_reopen_abort() after .bdrv_reopen_prepare() has succeeded.
> Otherwise, the block driver has no chance to undo what it has done in
> its implementation of .bdrv_reopen_prepare().
>
> To fix this, bdrv_reopen_prepare() has to call .bdrv_reopen_abort() if
> it wants to return an error after .bdrv_reopen_prepare() has succeeded.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
