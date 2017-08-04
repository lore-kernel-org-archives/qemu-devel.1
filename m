Received: from eggs.gnu.org ([2001:4830:134:3::10]:50143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ddcHz-00005r-RP
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ddcGt-0000X0-El
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:05:15 -0400
Date: Fri, 4 Aug 2017 14:02:08 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170804130208.GB14504@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170804105136.12061-1-berrange@redhat.com>
	<20170804124801.GB14565@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170804124801.GB14565@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH for 2.10] block: use 1 MB bounce buffers
 for crypto instead of 16KB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Fri, Aug 04, 2017 at 01:48:01PM +0100, Stefan Hajnoczi wrote:
> On Fri, Aug 04, 2017 at 11:51:36AM +0100, Daniel P. Berrange wrote:
> > Using 16KB bounce buffers creates a significant performance
> > penalty for I/O to encrypted volumes on storage with high
> > I/O latency (rotating rust & network drives), because it
> > triggers lots of fairly small I/O operations.
> > 
> > On tests with rotating rust, and cache=none|directsync,
> > write speed increased from 2MiB/s to 32MiB/s, on a par
> > with that achieved by the in-kernel luks driver.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  block/crypto.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 58ef6f2f52..207941db9a 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -379,7 +379,7 @@ static void block_crypto_close(BlockDriverState *bs)
> >  }
> >  
> >  
> > -#define BLOCK_CRYPTO_MAX_SECTORS 32
> > +#define BLOCK_CRYPTO_MAX_SECTORS 2048
> >  
> >  static coroutine_fn int
> >  block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
> > @@ -396,9 +396,8 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
> >  
> >      qemu_iovec_init(&hd_qiov, qiov->niov);
> >  
> > -    /* Bounce buffer so we have a linear mem region for
> > -     * entire sector. XXX optimize so we avoid bounce
> > -     * buffer in case that qiov->niov == 1
> > +    /* Bounce buffer because we're not permitted to touch
> > +     * contents of qiov - it points to guest memory.
> >       */
> >      cipher_data =
> >          qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS * 512,
> 
> In the *read* case you can modify the data buffers in-place.  But the
> guest might see intermediate states in its buffers - not sure whether
> this could pose a security problem.

Whether its a risk or not depends on the choice of crypto parameters, as
exposing ciphertext to the guest might make watermarking attacks easier
to perform. Probably not a problem in practice, but I prefer to err on
the side of caution since I can't be sure it is safe.

> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
