Received: from eggs.gnu.org ([2001:4830:134:3::10]:46934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1deuQy-0007cQ-AG
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 22:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1deuQt-0004i4-Gz
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 22:39:52 -0400
Date: Tue, 8 Aug 2017 10:39:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170808023929.GR14780@lemon>
References: <20170804105059.11941-1-berrange@redhat.com>
	<20170804140210.GD4108@localhost.localdomain>
	<20170804140630.GC14504@redhat.com>
	<9c9832bf-1e0e-6b3a-d962-5672cb96d323@redhat.com>
	<20170804154919.GI14504@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170804154919.GI14504@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: document semanatics of
 bdrv_co_preadv|pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri, 08/04 16:49, Daniel P. Berrange wrote:
> This is odd.  In the bdrv_aligned_readv() it looks very much like
> we'll reference qiov->niov, if bytes != 0, so if qiov was NULL we
> would crash.

It doesn't make sense if read doesn't have an iov, where should the data be
placed? :)

> 
> In bdrv_aligned_writev(), qiov->niov is also refernced if bytes != 0,
> *unless*  flags contains BDRV_REQ_ZERO_WRITE, in which case we'll
> invoke bdrv_co_do_pwrite_zeroes() instead.

This is intended. Zero-write doesn't need qiov, hence the BDRV_REQ_ZERO_WRITE
branch. Otherwise, we can assert qiov != NULL.

> 
> So unless I'm missing something, bdrv_co_preadv|writev cannot be
> called with a NULL  qiov, and bdrv_aligned_writev|readv might
> need their assertions tightened up.

bdrv_co_pwritev _is_ called with a NULL qiov from blk_aio_pwrite_zeroes. Your
other reasonings are right.

So for write we cannot remove the bytes parameter.

Fam
