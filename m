Received: from eggs.gnu.org ([2001:4830:134:3::10]:41807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ddcym-0003RV-CU
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ddboH-0001sE-BA
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:35:39 -0400
Date: Fri, 4 Aug 2017 13:32:29 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170804123229.GA14504@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170804105136.12061-1-berrange@redhat.com>
	<5ffc4c4c-35be-4d99-94f0-d0f3a3d43521@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ffc4c4c-35be-4d99-94f0-d0f3a3d43521@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for 2.10] block: use 1 MB
 bounce buffers for crypto instead of 16KB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

On Fri, Aug 04, 2017 at 07:08:54AM -0500, Eric Blake wrote:
> On 08/04/2017 05:51 AM, Daniel P. Berrange wrote:
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
> 
> The comment updates are accurate (and in line with your other patch for
> improving documentation of the callback semantics), but slightly
> unrelated to the fix at hand. However, I have no problem keeping it in
> the patch.
> 
> (To make sure I understand the importance of the bounce buffer: On
> reads, we can't store into the buffer until we have decrypted, so that
> the guest can't transiently spy on the encrypted form; on writes, we
> must read from the buffer at most once before encrypting, so that the
> guest can't change the buffer under our feet while we are encrypting.)

For writes it is even more critical - if we encrypted in place, and the
guest tried to serve a later read from its cache, it'd return cipher
text instead of plain text.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
