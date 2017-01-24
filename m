Received: from eggs.gnu.org ([2001:4830:134:3::10]:49859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW00U-0001w5-To
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW00T-0004Fc-QK
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:15:26 -0500
Date: Tue, 24 Jan 2017 12:15:17 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170124121517.GJ14563@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-3-berrange@redhat.com>
	<b1934b89-173d-9622-5cd6-4ec938fd011c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1934b89-173d-9622-5cd6-4ec938fd011c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 02/15] block: add ability to set a
 prefix for opt names
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

On Mon, Jan 16, 2017 at 08:31:55PM +0100, Max Reitz wrote:
> On 03.01.2017 19:27, Daniel P. Berrange wrote:
> > When integrating the crypto support with qcow/qcow2, we don't
> > want to use the bare LUKS option names "hash-alg", "key-secret",
> > etc. We want to namespace them "luks-hash-alg", "luks-key-secret"
> > so that they don't clash with any general qcow options at a later
> > date.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  block/crypto.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++--------
> >  block/crypto.h |  42 +++++++++++-----------
> >  2 files changed, 118 insertions(+), 34 deletions(-)
> > 
> > diff --git a/block/crypto.c b/block/crypto.c
> > index d281de6..1037c70 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> 
> [...]
> 
> > +static int block_crypto_copy_value(void *opaque, const char *name,
> > +                                   const char *value, Error **errp)
> > +{
> > +    struct BlockCryptoCopyData *data = opaque;
> > +
> > +    if (g_str_has_prefix(name, data->prefix)) {
> > +        Error *local_err = NULL;
> > +        const char *newname = name + strlen(data->prefix);
> 
> strstart() would be shorter:
> 
> const char *newname;
> 
> if (strstart(name, data->prefix, &newname)) {
>     /* ... */
> }

Ah, didn't know that function existed.

> 
> > +
> > +        qemu_opt_set(data->opts, newname, value, &local_err);
> > +        if (local_err) {
> > +            error_propagate(errp, local_err);
> > +            return 1;
> 
> I'd prefer -1, because 0/1 looks more like false/true to me, which in
> turn looks like failure/success.

Yes, that makes more sense.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
