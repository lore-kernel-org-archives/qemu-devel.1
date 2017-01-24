Received: from eggs.gnu.org ([2001:4830:134:3::10]:51561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW064-00070p-FM
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW061-00060O-Af
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:21:12 -0500
Date: Tue, 24 Jan 2017 12:21:00 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170124122100.GK14563@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-9-berrange@redhat.com>
	<5d05da0d-e0f5-5fa6-6bd2-5cecc1834124@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d05da0d-e0f5-5fa6-6bd2-5cecc1834124@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 08/15] qcow: make encrypt_sectors
 encrypt in place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On Mon, Jan 16, 2017 at 09:25:55PM +0100, Max Reitz wrote:
> On 03.01.2017 19:27, Daniel P. Berrange wrote:
> > Instead of requiring separate input/output buffers for
> > encrypting data, change encrypt_sectors() to assume
> > use of a single buffer, encrypting in place. One current
> > caller all uses the same buffer for input/output already
> 
> -all?
> 
> > and the other two callers are easily converted todo so.
> 
> s/todo/to do/
> 
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  block/qcow.c | 36 +++++++++++-------------------------
> >  1 file changed, 11 insertions(+), 25 deletions(-)
> > 
> > diff --git a/block/qcow.c b/block/qcow.c
> > index 8133fda..bc9fa2f 100644
> > --- a/block/qcow.c
> > +++ b/block/qcow.c
> > @@ -310,11 +310,10 @@ static int qcow_set_key(BlockDriverState *bs, const char *key)
> >  }
> >  
> >  /* The crypt function is compatible with the linux cryptoloop
> > -   algorithm for < 4 GB images. NOTE: out_buf == in_buf is
> > -   supported */
> > +   algorithm for < 4 GB images. */
> >  static int encrypt_sectors(BDRVQcowState *s, int64_t sector_num,
> > -                           uint8_t *out_buf, const uint8_t *in_buf,
> > -                           int nb_sectors, bool enc, Error **errp)
> > +                           uint8_t *buf, int nb_sectors, bool enc,
> > +                           Error **errp)
> >  {
> >      union {
> >          uint64_t ll[2];
> > @@ -333,14 +332,12 @@ static int encrypt_sectors(BDRVQcowState *s, int64_t sector_num,
> >          }
> >          if (enc) {
> >              ret = qcrypto_cipher_encrypt(s->cipher,
> > -                                         in_buf,
> > -                                         out_buf,
> > +                                         buf, buf,
> >                                           512,
> >                                           errp);
> >          } else {
> >              ret = qcrypto_cipher_decrypt(s->cipher,
> > -                                         in_buf,
> > -                                         out_buf,
> > +                                         buf, buf,
> >                                           512,
> >                                           errp);
> >          }
> > @@ -348,8 +345,7 @@ static int encrypt_sectors(BDRVQcowState *s, int64_t sector_num,
> >              return -1;
> >          }
> >          sector_num++;
> > -        in_buf += 512;
> > -        out_buf += 512;
> > +        buf += 512;
> >      }
> >      return 0;
> >  }
> > @@ -469,13 +465,12 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
> >                      uint64_t start_sect;
> >                      assert(s->cipher);
> >                      start_sect = (offset & ~(s->cluster_size - 1)) >> 9;
> > -                    memset(s->cluster_data + 512, 0x00, 512);
> > +                    memset(s->cluster_data, 0x00, 512);
> >                      for(i = 0; i < s->cluster_sectors; i++) {
> >                          if (i < n_start || i >= n_end) {
> >                              Error *err = NULL;
> >                              if (encrypt_sectors(s, start_sect + i,
> > -                                                s->cluster_data,
> > -                                                s->cluster_data + 512, 1,
> > +                                                s->cluster_data, 1,
> >                                                  true, &err) < 0) {
> >                                  error_free(err);
> >                                  errno = EIO;
> 
> After the first iteration of the surrounding for () loop,
> s->cluster_data is unlikely to still be filled with zeros -- but I
> suspect the code intended to always write encrypted zeros.

Yep, we must push the memset down a level.

> > @@ -653,7 +648,7 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
> >              }
> >              if (bs->encrypted) {
> >                  assert(s->cipher);
> > -                if (encrypt_sectors(s, sector_num, buf, buf,
> > +                if (encrypt_sectors(s, sector_num, buf,
> >                                      n, false, &err) < 0) {
> >                      goto fail;
> >                  }
> > @@ -688,9 +683,7 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
> >      BDRVQcowState *s = bs->opaque;
> >      int index_in_cluster;
> >      uint64_t cluster_offset;
> > -    const uint8_t *src_buf;
> >      int ret = 0, n;
> > -    uint8_t *cluster_data = NULL;
> >      struct iovec hd_iov;
> >      QEMUIOVector hd_qiov;
> >      uint8_t *buf;
> > @@ -728,21 +721,15 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
> >          if (bs->encrypted) {
> >              Error *err = NULL;
> >              assert(s->cipher);
> > -            if (!cluster_data) {
> > -                cluster_data = g_malloc0(s->cluster_size);
> > -            }
> > -            if (encrypt_sectors(s, sector_num, cluster_data, buf,
> > +            if (encrypt_sectors(s, sector_num, buf,
> 
> If qiov->niov == 1, buf is not copied from the I/O vector but just the
> I/O vector base itself. Then, this will modify the data pointed to by
> that vector. I don't think that is a good idea.

Opps, yes, that is a bad idea. I'll force copying when bs->encrypted == true,
regardless of qiov->niov value.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
