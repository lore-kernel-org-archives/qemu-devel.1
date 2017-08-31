Received: from eggs.gnu.org ([2001:4830:134:3::10]:34022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnRIt-0006p4-1R
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnRIo-0007ek-SI
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:22:47 -0400
Date: Thu, 31 Aug 2017 16:22:31 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170831152231.GO17315@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170831110518.10741-1-berrange@redhat.com>
	<20170831110518.10741-5-berrange@redhat.com>
	<3e86a5c7-dc18-ca28-3eed-40fc6221e84d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e86a5c7-dc18-ca28-3eed-40fc6221e84d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] block: convert
 qcrypto_block_encrypt|decrypt to take bytes offset
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

On Thu, Aug 31, 2017 at 10:17:43AM -0500, Eric Blake wrote:
> On 08/31/2017 06:05 AM, Daniel P. Berrange wrote:
> > Instead of sector offset, take the bytes offset when encrypting
> > or decrypting data.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  block/crypto.c         |  8 ++++----
> >  block/qcow.c           |  7 +++++--
> >  block/qcow2-cluster.c  |  8 +++-----
> >  block/qcow2.c          |  4 ++--
> >  crypto/block-luks.c    | 12 ++++++++----
> >  crypto/block-qcow.c    | 12 ++++++++----
> >  crypto/block.c         | 14 ++++++++------
> >  crypto/blockpriv.h     |  4 ++--
> >  include/crypto/block.h | 14 ++++++++------
> >  9 files changed, 48 insertions(+), 35 deletions(-)
> > 
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 40daa77188..6b8d88efbc 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -426,8 +426,8 @@ block_crypto_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
> >              goto cleanup;
> >          }
> >  
> > -        if (qcrypto_block_decrypt(crypto->block, sector_num, cipher_data,
> > -                                  cur_bytes, NULL) < 0) {
> > +        if (qcrypto_block_decrypt(crypto->block, offset + bytes_done,
> > +                                  cipher_data, cur_bytes, NULL) < 0) {
> 
> How close are we to getting rid of even needing 'sector_num' as a variable?

I thought there was more usage, but I just realized we can in fact
remove it in this patch.

> 
> > +++ b/block/qcow.c
> > @@ -456,7 +456,9 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
> >                          if (i < n_start || i >= n_end) {
> >                              Error *err = NULL;
> >                              memset(s->cluster_data, 0x00, 512);
> > -                            if (qcrypto_block_encrypt(s->crypto, start_sect + i,
> > +                            if (qcrypto_block_encrypt(s->crypto,
> > +                                                      start_sect + i *
> > +                                                      BDRV_SECTOR_SIZE,
> 
> Umm, not the same.  You want (start_sect + i) * BDRV_SECTOR_SIZE.

Heh, oppps.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
