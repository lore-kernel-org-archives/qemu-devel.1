Received: from eggs.gnu.org ([2001:4830:134:3::10]:53972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d8oms-0002kU-Iz
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d8omr-0007jj-Ee
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:09:50 -0400
Date: Thu, 11 May 2017 15:09:37 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170511140937.GK18715@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170425153858.25660-1-berrange@redhat.com>
	<20170425153858.25660-10-berrange@redhat.com>
	<w51a86jtrnc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w51a86jtrnc.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v6 09/18] qcow: convert QCow to use
 QCryptoBlock for encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Thu, May 11, 2017 at 04:05:59PM +0200, Alberto Garcia wrote:
> On Tue 25 Apr 2017 05:38:49 PM CEST, Daniel P. Berrange wrote:
> > @@ -181,8 +188,39 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
>   [...]
> > +            crypto_opts = block_crypto_open_opts_init(
> > +                Q_CRYPTO_BLOCK_FORMAT_QCOW, encryptopts, &local_err);
> > +            if (local_err) {
> > +                error_propagate(errp, local_err);
> > +                ret = -EINVAL;
> > +                goto fail;
> > +            }
> 
> Not very important, but if you check !crypto_opts for errors instead you
> can pass errp directly and avoid that error_propagate() call. Exactly
> the same that you do here in qcrypto_block_open():
> 
> > +            if (flags & BDRV_O_NO_IO) {
> > +                cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
> > +            }
> > +            s->crypto = qcrypto_block_open(crypto_opts, NULL, NULL,
> > +                                           cflags, errp);
> > +            if (!s->crypto) {
> > +                ret = -EINVAL;
> > +                goto fail;
> > +            }
> 
> 
> > @@ -792,6 +762,10 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
> >      int ret;
> >      BlockBackend *qcow_blk;
> >      const char *encryptfmt = NULL;
> > +    QDict *options;
> > +    QDict *encryptopts = NULL;
> > +    QCryptoBlockCreateOptions *crypto_opts = NULL;
> > +    QCryptoBlock *crypto = NULL;
> >  
> >      /* Read out options */
> >      total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
> > @@ -865,6 +839,10 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
> >      l1_size = (total_size + (1LL << shift) - 1) >> shift;
> >  
> >      header.l1_table_offset = cpu_to_be64(header_size);
> > +
> > +    options = qemu_opts_to_qdict(opts, NULL);
> > +    qdict_extract_subqdict(options, &encryptopts, "encrypt.");
> > +    QDECREF(options);
> 
> I think you're leaking encryptopts in this function.
> 
> >  ##
> > +# @BlockdevQcowEncryptionFormat:
> > +# @qcow: AES-CBC with plain64 initialization venctors
> > +#
> > +# Since: 2.10
> > +##
> > +{ 'enum': 'BlockdevQcowEncryptionFormat',
> > +  'data': [ 'qcow' ] }
> 
> Shouldn't this be 'aes' instead of 'qcow' ??

Opps, yes. I've been flipping back & forth about whether to call the
encryption format 'aes' or 'qcow' in the public API.  Internally
the crypto/ code calls it the 'qcow' encryption format, but from a
technical POV it is aes.

I see i've got the same mistake in the equivalent qcow2 patch too

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
