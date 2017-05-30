Received: from eggs.gnu.org ([2001:4830:134:3::10]:36788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dFdGo-0000wN-9m
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dFdGn-0000pz-6U
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:16:54 -0400
Date: Tue, 30 May 2017 10:16:48 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170530091648.GC21566@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170525163851.8047-1-berrange@redhat.com>
	<20170525163851.8047-20-berrange@redhat.com>
	<1acec55c-fd89-ee9d-0082-372a6e967036@redhat.com>
	<20170526140242.GK24484@redhat.com>
	<87fufo6lc2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fufo6lc2.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon, May 29, 2017 at 11:53:01AM +0200, Markus Armbruster wrote:
> "Daniel P. Berrange" <berrange@redhat.com> writes:
> 
> > On Thu, May 25, 2017 at 02:52:30PM -0500, Eric Blake wrote:
> >> On 05/25/2017 11:38 AM, Daniel P. Berrange wrote:
> >> > Currently 'qemu-img info' reports a simple "encrypted: yes"
> >> > field. This is not very useful now that qcow2 can support
> >> > multiple encryption formats. Users want to know which format
> >> > is in use and some data related to it.
> >> > 
> >> > Wire up usage of the qcrypto_block_get_info() method so that
> >> > 'qemu-img info' can report about the encryption format
> >> > and parameters in use
> >> > 
> >> 
> >> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> >> > ---
> >> >  block/qcow2.c        | 35 ++++++++++++++++++++++++++++++++++-
> >> >  qapi/block-core.json | 24 +++++++++++++++++++++++-
> >> >  2 files changed, 57 insertions(+), 2 deletions(-)
> >> > 
> >> > diff --git a/block/qcow2.c b/block/qcow2.c
> >> > index 38f9eb5..cb321a2 100644
> >> > --- a/block/qcow2.c
> >> > +++ b/block/qcow2.c
> >> > @@ -3196,8 +3196,17 @@ static int qcow2_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
> >> >  static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
> >> >  {
> >> >      BDRVQcow2State *s = bs->opaque;
> >> > -    ImageInfoSpecific *spec_info = g_new(ImageInfoSpecific, 1);
> >> > +    ImageInfoSpecific *spec_info;
> >> > +    QCryptoBlockInfo *encrypt_info = NULL;
> >> >  
> >> > +    if (s->crypto != NULL) {
> >> > +        encrypt_info = qcrypto_block_get_info(s->crypto, NULL);
> >> 
> >> Worth using &error_abort instead of silently ignoring the error?  Is an
> >> error even possible in our output visitor [adding Markus for reference]?
> >
> > In fact the qcrypto_block_get_info() will never return an error
> > right now as implemented. So I guess we could even just remove
> > the Error **errp parameter from that call
> 
> Do you still need advice on QAPI from me here?

No need, thanks.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
