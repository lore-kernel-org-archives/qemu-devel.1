Received: from eggs.gnu.org ([2001:4830:134:3::10]:35689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2hDo-0006gW-Be
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2hDn-0001fh-2K
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:52:20 -0400
Date: Mon, 24 Apr 2017 17:52:06 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170424165206.GC453@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170221115512.21918-1-berrange@redhat.com>
	<20170221115512.21918-14-berrange@redhat.com>
	<w51h93nbpjk.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w51h93nbpjk.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v5 13/18] qcow2: add support for LUKS
 encryption format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, Feb 21, 2017 at 03:13:03PM +0100, Alberto Garcia wrote:
> On Tue 21 Feb 2017 12:55:07 PM CET, Daniel P. Berrange wrote:
> >  static int qcow2_set_up_encryption(BlockDriverState *bs, QemuOpts *opts,
> > -                                   Error **errp)
> > +                                   const char *fmtstr, Error **errp)
> >  {
> >      BDRVQcow2State *s = bs->opaque;
> >      QCryptoBlockCreateOptions *cryptoopts = NULL;
> >      QCryptoBlock *crypto = NULL;
> >      int ret = -EINVAL;
> > +    int fmt = qcow2_crypt_method_from_format(fmtstr);
> >  
> > -    cryptoopts = block_crypto_create_opts_init(
> > -        Q_CRYPTO_BLOCK_FORMAT_QCOW, opts, "aes-", errp);
> > +    switch (fmt) {
> > +    case QCOW_CRYPT_LUKS:
> > +        cryptoopts = block_crypto_create_opts_init(
> > +            Q_CRYPTO_BLOCK_FORMAT_LUKS, opts, "luks-", errp);
> > +        break;
> > +    case QCOW_CRYPT_AES:
> > +        cryptoopts = block_crypto_create_opts_init(
> > +            Q_CRYPTO_BLOCK_FORMAT_QCOW, opts, "aes-", errp);
> > +        break;
> > +    default:
> > +        error_setg(errp, "Unknown encryption format %s", fmtstr);
> > +        break;
> > +    }
> > +    s->crypt_method_header = fmt;
> >      if (!cryptoopts) {
> >          ret = -EINVAL;
> >          goto out;
> >      }
> 
> I don't believe it has any practical effect in this case, but I think
> it's cleaner to set s->crypt_method_header = fmt after checking that
> everything went well. Otherwise an incorrect format string will result
> in s->crypt_method_header = -EINVAL, which doesn't make sense (it's not
> even the correct type: the variable is unsigned).

Yes, makes sense.

> Other than that, the patch looks good to me.
> 
> Reviewed-by: Alberto Garcia <berto@igalia.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
