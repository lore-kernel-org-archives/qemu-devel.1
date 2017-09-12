Received: from eggs.gnu.org ([2001:4830:134:3::10]:59847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1driDs-00087x-Gn
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1driDm-0006Su-Mu
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:15:16 -0400
Date: Tue, 12 Sep 2017 11:14:55 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170912101455.GD17633@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170831110518.10741-1-berrange@redhat.com>
	<20170831110518.10741-4-berrange@redhat.com>
	<3867f025-5d0b-5bed-d47f-a91c706cd3aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3867f025-5d0b-5bed-d47f-a91c706cd3aa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] block: convert crypto driver to
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

On Thu, Aug 31, 2017 at 10:08:00AM -0500, Eric Blake wrote:
> On 08/31/2017 06:05 AM, Daniel P. Berrange wrote:
> > Make the crypto driver implement the bdrv_co_preadv|pwritev
> > callbacks,  and also use bdrv_co_preadv|pwritev for I/O
> > with the protocol driver beneath.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  block/crypto.c | 103 +++++++++++++++++++++++++++++----------------------------
> >  1 file changed, 53 insertions(+), 50 deletions(-)
> > 
> 
> >  static coroutine_fn int
> > -block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
> > -                      int remaining_sectors, QEMUIOVector *qiov)
> > +block_crypto_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
> > +                       QEMUIOVector *qiov, int flags)
> 
> >  {
> >      BlockCrypto *crypto = bs->opaque;
> > -    int cur_nr_sectors; /* number of sectors in current iteration */
> > +    uint64_t cur_bytes; /* number of bytes in current iteration */
> >      uint64_t bytes_done = 0;
> >      uint8_t *cipher_data = NULL;
> >      QEMUIOVector hd_qiov;
> >      int ret = 0;
> > -    size_t payload_offset =
> > -        qcrypto_block_get_payload_offset(crypto->block) / BDRV_SECTOR_SIZE;
> > +    size_t payload_offset = qcrypto_block_get_payload_offset(crypto->block);
> 
> Pre-existing: is size_t the right type, or can we overflow a 64-bit
> offset on a 32-bit host?

No, it is bad. I'm fixing that as a separate patch, since it is a good
to cleanup.

> 
> > +    uint64_t sector_num = offset / BDRV_SECTOR_SIZE;
> > +
> > +    assert((offset % BDRV_SECTOR_SIZE) == 0);
> > +    assert((bytes % BDRV_SECTOR_SIZE) == 0);
> 
> The osdep.h macros might be nicer than open-coding; furthermore, if
> desired, you could shorten to:
> 
> assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));

Yep, makes sense.

> >  static coroutine_fn int
> > -block_crypto_co_writev(BlockDriverState *bs, int64_t sector_num,
> > -                       int remaining_sectors, QEMUIOVector *qiov)
> > +block_crypto_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
> > +                        QEMUIOVector *qiov, int flags)
> >  {
> 
> Hmm - you don't set supported_write_flags.  But presumably, if the
> underlying BDS supports BDRV_REQUEST_FUA, then crypto can likewise
> support that flag by passing it through to the underlying device after
> encryption.

Something to be added as a separate patch

> > @@ -611,8 +613,9 @@ BlockDriver bdrv_crypto_luks = {
> >      .bdrv_truncate      = block_crypto_truncate,
> >      .create_opts        = &block_crypto_create_opts_luks,
> >  
> > -    .bdrv_co_readv      = block_crypto_co_readv,
> > -    .bdrv_co_writev     = block_crypto_co_writev,
> > +    .bdrv_refresh_limits = block_crypto_refresh_limits,
> > +    .bdrv_co_preadv      = block_crypto_co_preadv,
> > +    .bdrv_co_pwritev     = block_crypto_co_pwritev,
> >      .bdrv_getlength     = block_crypto_getlength,
> >      .bdrv_get_info      = block_crypto_get_info_luks,
> >      .bdrv_get_specific_info = block_crypto_get_specific_info_luks,
> 
> Looks weird when = isn't consistently aligned, but we use more than one
> space.  My preference is to just use one space everywhere, as adding a
> longer name to the list doesn't require a mass re-format of all other
> entries; but I'm not opposed when people like the aligned = for
> legibility.  So up to you if you do anything in response to my nit.

Normally I stick with one space, so don't know what I was thinking
when i wrote this.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
