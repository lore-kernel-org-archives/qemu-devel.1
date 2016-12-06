Received: from eggs.gnu.org ([2001:4830:134:3::10]:37282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cELKE-0005h0-4X
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cELKA-00076i-1U
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:22:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cELK9-00076b-Rj
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:22:45 -0500
Date: Tue, 6 Dec 2016 21:22:43 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20161206211034-mutt-send-email-mst@kernel.org>
References: <1481016553-69252-1-git-send-email-arei.gonglei@huawei.com>
	<20161206153945-mutt-send-email-mst@kernel.org>
	<20161206173337.GB30363@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161206173337.GB30363@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-2.8] virtio-crypto: zeroize the key
 material before free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org

On Tue, Dec 06, 2016 at 05:33:37PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 06, 2016 at 03:40:49PM +0200, Michael S. Tsirkin wrote:
> > On Tue, Dec 06, 2016 at 05:29:13PM +0800, Gonglei wrote:
> > > Zeroize the memory of CryptoDevBackendSymOpInfo structure pointed
> > > for key material security.
> > > 
> > > Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> > > ---
> > >  hw/virtio/virtio-crypto.c | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> > > index 2f2467e..ecb19b6 100644
> > > --- a/hw/virtio/virtio-crypto.c
> > > +++ b/hw/virtio/virtio-crypto.c
> > > @@ -337,7 +337,18 @@ static void virtio_crypto_free_request(VirtIOCryptoReq *req)
> > >  {
> > >      if (req) {
> > >          if (req->flags == CRYPTODEV_BACKEND_ALG_SYM) {
> > > -            g_free(req->u.sym_op_info);
> > > +            size_t max_len;
> > > +            CryptoDevBackendSymOpInfo *op_info = req->u.sym_op_info;
> > > +
> > > +            max_len = op_info->iv_len +
> > > +                      op_info->aad_len +
> > > +                      op_info->src_len +
> > > +                      op_info->dst_len +
> > > +                      op_info->digest_result_len;
> > > +
> > > +            /* Zeroize and free request data structure */
> > > +            memset(op_info, 0, sizeof(*op_info) + max_len);
> > > +            g_free(op_info);
> > 
> > Write into memory, then free it?  This looks rather strange. Why are we
> > doing this?
> 
> Common practice with sensitive information (key material, passwords,
> etc).

Some kind of explanation about what makes this one
more sensitive than others would be nice.

Also, what makes it 2.8 material? Considering the pointer math
involved, it's not risk-free.

> coredumps, memory disclosure bugs when heap memory is reused, etc.
>
> Sensitive information is sometimes also held in mlocked pages to prevent
> it being swapped to disk but that's not being done here.
> 
> Perhaps the comment should be more explicit but this patch seems
> reasonable.

Right.  One can see memset and free at a glance.
The comment and the commit log should explain the why,
not the what.

> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
