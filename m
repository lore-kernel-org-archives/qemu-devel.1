Received: from eggs.gnu.org ([2001:4830:134:3::10]:37600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dtxZE-0002oZ-9B
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dtxZ4-0002R5-N7
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:02:36 -0400
Date: Mon, 18 Sep 2017 16:02:13 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170918150213.GJ2951@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170912112855.24269-1-berrange@redhat.com>
	<20170912112855.24269-5-berrange@redhat.com>
	<c2731b1a-419e-d6cf-48a8-97755651bdf2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2731b1a-419e-d6cf-48a8-97755651bdf2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/7] block: don't use constant 512 as
 sector size in crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

On Sat, Sep 16, 2017 at 06:24:56PM +0200, Max Reitz wrote:
> On 2017-09-12 13:28, Daniel P. Berrange wrote:
> > Use the qcrypto_block_get_sector_size() value in the block
> > crypto driver instead of hardcoding 512 as the sector size.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  block/crypto.c | 34 ++++++++++++++++++----------------
> >  1 file changed, 18 insertions(+), 16 deletions(-)
> > 
> > diff --git a/block/crypto.c b/block/crypto.c
> > index d68cbac2ac..49d6d4c058 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -392,8 +392,9 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
> >      uint8_t *cipher_data = NULL;
> >      QEMUIOVector hd_qiov;
> >      int ret = 0;
> > +    uint64_t sector_size = qcrypto_block_get_sector_size(crypto->block);
> >      uint64_t payload_offset =
> > -        qcrypto_block_get_payload_offset(crypto->block) / 512;
> > +        qcrypto_block_get_payload_offset(crypto->block) / sector_size;
> >      assert(payload_offset < (INT64_MAX / 512));
> >  
> >      qemu_iovec_init(&hd_qiov, qiov->niov);
> > @@ -401,9 +402,9 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
> >      /* Bounce buffer because we don't wish to expose cipher text
> >       * in qiov which points to guest memory.
> >       */
> > -    cipher_data =
> > -        qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS * 512,
> > -                                              qiov->size));
> > +    cipher_data = qemu_try_blockalign(
> > +        bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS * sector_size,
> > +                          qiov->size));
> >      if (cipher_data == NULL) {
> >          ret = -ENOMEM;
> >          goto cleanup;
> > @@ -417,7 +418,7 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
> >          }
> >  
> >          qemu_iovec_reset(&hd_qiov);
> > -        qemu_iovec_add(&hd_qiov, cipher_data, cur_nr_sectors * 512);
> > +        qemu_iovec_add(&hd_qiov, cipher_data, cur_nr_sectors * sector_size);
> 
> cur_nr_sectors is based on remaining_sectors; which in turn is a
> parameter to this function and comes from the block layer.  Therefore
> its unit is BDRV_SECTOR_SIZE and not the crypto driver's sector size.
> 
> Same in the hunk below, and in block_crypto_co_writev().
> 
> >  
> >          ret = bdrv_co_readv(bs->file,
> >                              payload_offset + sector_num,
> 
> Same thing here, albeit in a different variation: The unit of this
> parameter of bdrv_co_readv() (start sector index) is a block layer
> sector, whose size is always BDRV_SECTOR_SIZE.
> 
> Therefore you cannot divide the result from
> qcrypto_block_get_payload_offset() by the crypto driver's sector size
> and then use it as a sector index here.
> 
> Same in block_crypto_co_writev().
> 
> 
> I assume that you fix this in the next patch, but for now it's just wrong.

Yeah, in retrospect I should have kept this patch using BDRV_SECTOR_SIZE
throughout as previous versions had it, so I'm going to go back to doing
that. Only use the encryption sector size in a later patch where we have
already switched to doing byte based I/O.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
