Received: from eggs.gnu.org ([2001:4830:134:3::10]:34682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dder3-0002vU-M1
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dder2-0002Qu-Kh
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:49:37 -0400
Date: Fri, 4 Aug 2017 16:49:19 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170804154919.GI14504@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170804105059.11941-1-berrange@redhat.com>
	<20170804140210.GD4108@localhost.localdomain>
	<20170804140630.GC14504@redhat.com>
	<9c9832bf-1e0e-6b3a-d962-5672cb96d323@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9c9832bf-1e0e-6b3a-d962-5672cb96d323@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri, Aug 04, 2017 at 10:41:54AM -0500, Eric Blake wrote:
> On 08/04/2017 09:06 AM, Daniel P. Berrange wrote:
> > On Fri, Aug 04, 2017 at 04:02:10PM +0200, Kevin Wolf wrote:
> >> Am 04.08.2017 um 12:50 hat Daniel P. Berrange geschrieben:
> >>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> >>> ---
> 
> >> Really? We are asserting that they match in bdrv_aligned_preadv():
> >>
> >>     assert(!qiov || bytes == qiov->size);
> > 
> > Hmm, why do we pass @bytes at all then ? If they're always the same,
> > how about deleting it and just letting everyone read qiov->size
> > directly.
> 
> Read the assertion again: qiov can be NULL (generally, when writing
> zeroes).  So we can't rely on qiov->size in that scenario.

This is odd.  In the bdrv_aligned_readv() it looks very much like
we'll reference qiov->niov, if bytes != 0, so if qiov was NULL we
would crash.

In bdrv_aligned_writev(), qiov->niov is also refernced if bytes != 0,
*unless*  flags contains BDRV_REQ_ZERO_WRITE, in which case we'll
invoke bdrv_co_do_pwrite_zeroes() instead.

So unless I'm missing something, bdrv_co_preadv|writev cannot be
called with a NULL  qiov, and bdrv_aligned_writev|readv might
need their assertions tightened up.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
