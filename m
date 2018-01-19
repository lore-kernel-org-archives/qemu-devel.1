Received: from eggs.gnu.org ([2001:4830:134:3::10]:36685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecSvQ-0003q6-Eq
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecSvP-0008R7-9g
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:25:28 -0500
Date: Fri, 19 Jan 2018 09:25:16 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180119092516.GB16798@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180118103143.11780-1-berrange@redhat.com>
	<11124de8-ece3-cad5-7e43-0b10ce5c097d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11124de8-ece3-cad5-7e43-0b10ce5c097d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: implement the bdrv_reopen_prepare
 helper for LUKS driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu, Jan 18, 2018 at 01:51:36PM -0600, Eric Blake wrote:
> On 01/18/2018 04:31 AM, Daniel P. Berrange wrote:
> > If the bdrv_reopen_prepare helper isn't provided, the qemu-img commit
> > command fails to re-open the base layer after committing changes into
> > it. Provide a no-op implementation for the LUKS driver, since there
> > is not any custom work that needs doing to re-open it.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  block/crypto.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> 
> I'm hoping another block-layer expert chimes in, as I'm not quite sure
> what the full reopen rules are; but the idea makes sense to me.

Yeah, likewise - it is hard to understand what is required, but I see
lots of other block drivers just put a no-op impl here. I'm relying on
Kevin/Max to tell me if i'm wrong here 

> > diff --git a/block/crypto.c b/block/crypto.c
> > index 60ddf8623e..bb9a8f5376 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -382,6 +382,12 @@ static void block_crypto_close(BlockDriverState *bs)
> >      qcrypto_block_free(crypto->block);
> >  }
> >  
> > +static int block_crypto_reopen_prepare(BDRVReopenState *state,
> > +                                       BlockReopenQueue *queue, Error **errp)
> > +{
> > +    /* nothing needs checking */
> 
> Are we sure that even changes such as moving from read-only to
> read-write need no checking?

LUKS doesn't do anything differently with ro vs rw images, so I'm assuming
any such checks are handled by the layer below.



> 
> > +    return 0;
> > +}
> >  
> >  /*
> >   * 1 MB bounce buffer gives good performance / memory tradeoff
> > @@ -620,6 +626,7 @@ BlockDriver bdrv_crypto_luks = {
> >      .bdrv_truncate      = block_crypto_truncate,
> >      .create_opts        = &block_crypto_create_opts_luks,
> >  
> > +    .bdrv_reopen_prepare = block_crypto_reopen_prepare,
> >      .bdrv_refresh_limits = block_crypto_refresh_limits,
> >      .bdrv_co_preadv     = block_crypto_co_preadv,
> >      .bdrv_co_pwritev    = block_crypto_co_pwritev,

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
