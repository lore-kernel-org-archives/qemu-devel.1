Received: from eggs.gnu.org ([2001:4830:134:3::10]:54304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dEFpW-0007qe-KX
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dEFpT-0008G3-H4
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:03:02 -0400
Date: Fri, 26 May 2017 15:02:42 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170526140242.GK24484@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170525163851.8047-1-berrange@redhat.com>
	<20170525163851.8047-20-berrange@redhat.com>
	<1acec55c-fd89-ee9d-0082-372a6e967036@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1acec55c-fd89-ee9d-0082-372a6e967036@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 19/20] qcow2: report encryption specific
 image information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>

On Thu, May 25, 2017 at 02:52:30PM -0500, Eric Blake wrote:
> On 05/25/2017 11:38 AM, Daniel P. Berrange wrote:
> > Currently 'qemu-img info' reports a simple "encrypted: yes"
> > field. This is not very useful now that qcow2 can support
> > multiple encryption formats. Users want to know which format
> > is in use and some data related to it.
> > 
> > Wire up usage of the qcrypto_block_get_info() method so that
> > 'qemu-img info' can report about the encryption format
> > and parameters in use
> > 
> 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  block/qcow2.c        | 35 ++++++++++++++++++++++++++++++++++-
> >  qapi/block-core.json | 24 +++++++++++++++++++++++-
> >  2 files changed, 57 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 38f9eb5..cb321a2 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -3196,8 +3196,17 @@ static int qcow2_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
> >  static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
> >  {
> >      BDRVQcow2State *s = bs->opaque;
> > -    ImageInfoSpecific *spec_info = g_new(ImageInfoSpecific, 1);
> > +    ImageInfoSpecific *spec_info;
> > +    QCryptoBlockInfo *encrypt_info = NULL;
> >  
> > +    if (s->crypto != NULL) {
> > +        encrypt_info = qcrypto_block_get_info(s->crypto, NULL);
> 
> Worth using &error_abort instead of silently ignoring the error?  Is an
> error even possible in our output visitor [adding Markus for reference]?

In fact the qcrypto_block_get_info() will never return an error
right now as implemented. So I guess we could even just remove
the Error **errp parameter from that call

> 
> > +        if (!encrypt_info) {
> > +            return NULL;
> > +        }
> 
> If you use &error_abort, this is a dead check.
> 
> > +    }
> > +
> > +    spec_info = g_new(ImageInfoSpecific, 1);

> > +    if (encrypt_info) {
> > +        ImageInfoSpecificQCow2Encryption *qencrypt =
> > +            g_new(ImageInfoSpecificQCow2Encryption, 1);
> > +        switch (encrypt_info->format) {
> > +        case Q_CRYPTO_BLOCK_FORMAT_QCOW:
> > +            qencrypt->format = BLOCKDEV_QCOW2_ENCRYPTION_FORMAT_AES;
> > +            qencrypt->u.aes = encrypt_info->u.qcow;
> > +            break;
> > +        case Q_CRYPTO_BLOCK_FORMAT_LUKS:
> > +            qencrypt->format = BLOCKDEV_QCOW2_ENCRYPTION_FORMAT_LUKS;
> > +            qencrypt->u.luks = encrypt_info->u.luks;
> > +            break;
> > +        default:
> > +            assert(false);
> > +        }
> > +        /* Since we did shallow copy above, erase any pointers
> > +         * in the original info */
> > +        memset(&encrypt_info->u, 0, sizeof(encrypt_info->u));
> > +        qapi_free_QCryptoBlockInfo(encrypt_info);
> 
> Does QAPI_CLONE_MEMBERS (commit 4626a19c) make this code any easier to
> write?  Then again, malloc'ing duplicates to then free the unchanged
> original is a bit slower than stealing references from the original then
> making sure the original can be freed without problem.

I don't think CLONE would make a signijficant difference to the size
of the code, since we have to remap the enum constants regardless.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
