Received: from eggs.gnu.org ([2001:4830:134:3::10]:43999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgWKG-00034N-6p
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgWKF-0003OH-Ce
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:47:20 -0500
Date: Wed, 22 Feb 2017 13:47:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170222124710.GL4112@noname.str.redhat.com>
References: <1487349541-10201-1-git-send-email-pl@kamp.de>
	<1487349541-10201-3-git-send-email-pl@kamp.de>
	<20170217213715.GJ19045@localhost.localdomain>
	<feb6aa92-5e7f-9af9-12cb-bd7beae47750@redhat.com>
	<20170217215117.GM19045@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170217215117.GM19045@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 2/2] block/nfs: try to avoid the bounce
 buffer in pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 17.02.2017 um 22:51 hat Jeff Cody geschrieben:
> On Fri, Feb 17, 2017 at 03:42:52PM -0600, Eric Blake wrote:
> > On 02/17/2017 03:37 PM, Jeff Cody wrote:
> > > On Fri, Feb 17, 2017 at 05:39:01PM +0100, Peter Lieven wrote:
> > >> if the passed qiov contains exactly one iov we can
> > >> pass the buffer directly.
> > >>
> > >> Signed-off-by: Peter Lieven <pl@kamp.de>
> > >> ---
> > >>  block/nfs.c | 23 ++++++++++++++++-------
> > >>  1 file changed, 16 insertions(+), 7 deletions(-)
> > >>
> > >> diff --git a/block/nfs.c b/block/nfs.c
> > >> index ab5dcc2..bb4b75f 100644
> > >> --- a/block/nfs.c
> > >> +++ b/block/nfs.c
> > >> @@ -295,20 +295,27 @@ static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, uint64_t offset,
> > >>      NFSClient *client = bs->opaque;
> > >>      NFSRPC task;
> > >>      char *buf = NULL;
> > >> +    bool my_buffer = false;
> > > 
> > > g_free() is a nop if buf is NULL, so there is no need for the my_buffer
> > > variable & check.
> > 
> > Umm, yes there is:
> > 
> > >> +    if (iov->niov != 1) {
> > >> +        buf = g_try_malloc(bytes);
> > >> +        if (bytes && buf == NULL) {
> > >> +            return -ENOMEM;
> > >> +        }
> > >> +        qemu_iovec_to_buf(iov, 0, buf, bytes);
> > >> +        my_buffer = true;
> > >> +    } else {
> > >> +        buf = iov->iov[0].iov_base;
> > 
> > If we took the else branch, then we definitely do not want to be calling
> > g_free(buf).
> 
> Doh!
> 
> > 
> > >>      }
> > >>  
> > >> -    qemu_iovec_to_buf(iov, 0, buf, bytes);
> > >> -
> > >>      if (nfs_pwrite_async(client->context, client->fh,
> > >>                           offset, bytes, buf,
> > >>                           nfs_co_generic_cb, &task) != 0) {
> > >> -        g_free(buf);
> > >> +        if (my_buffer) {
> > >> +            g_free(buf);
> > >> +        }
> > 
> > It looks correct as-is to me.
> 
> Indeed.
> 
> Reviewed-by: Jeff Cody <jcody@redhat.com>

You gave R-b for both patches, but did not merge it - who is supposed to
do that?

Kevin
