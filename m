Received: from eggs.gnu.org ([209.51.188.92]:60544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw3Ub-0002h9-2o
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:23:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw3Ua-0001L8-Bf
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:23:17 -0500
Date: Tue, 19 Feb 2019 12:23:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190219112308.GI4727@localhost.localdomain>
References: <20190218161822.3573-1-kwolf@redhat.com>
	<20190218161822.3573-12-kwolf@redhat.com>
	<3efe273b-16af-4927-b684-57cf71275923@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3efe273b-16af-4927-b684-57cf71275923@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/12] block: Use normal drain for
 bdrv_set_aio_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, berrange@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

Am 18.02.2019 um 21:57 hat Eric Blake geschrieben:
> On 2/18/19 10:18 AM, Kevin Wolf wrote:
> > Now that bdrv_set_aio_context() works inside drained sections, it can
> > also use the real drain function instead of open coding something
> > similar.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block.c | 14 +++++---------
> >  1 file changed, 5 insertions(+), 9 deletions(-)
> > 
> > diff --git a/block.c b/block.c
> > index aefb5701f5..7024172db8 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -5268,18 +5268,15 @@ void bdrv_attach_aio_context(BlockDriverState *bs,
> >      bs->walking_aio_notifiers = false;
> >  }
> >  
> > +/* The caller must own the AioContext lock for the old AioContext of bs, but it
> > + * must not own the AioContext lock for new_context. */
> 
> Is this comment still accurate, given
> 
> >  void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
> >  {
> > -    AioContext *ctx = bdrv_get_aio_context(bs);
> > -
> > -    if (ctx == new_context) {
> > +    if (bdrv_get_aio_context(bs) == new_context) {
> >          return;
> >      }
> 
> the short-circuiting when the old context is the new context?

Hm, yes, old == new is an exception where you quite obviously can't have
old locked and new unlocked at the same time.

So is adding this enough?

    (unless new_context is the same as the current context of bs)

Kevin
