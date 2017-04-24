Received: from eggs.gnu.org ([2001:4830:134:3::10]:59310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2h15-0001Tg-RN
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2h12-0004iS-Nj
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:39:11 -0400
Date: Mon, 24 Apr 2017 17:38:51 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170424163851.GA453@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170221115512.21918-1-berrange@redhat.com>
	<20170221115512.21918-10-berrange@redhat.com>
	<w51poibbs0d.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w51poibbs0d.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v5 09/18] qcow: convert QCow to use
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, Feb 21, 2017 at 02:19:46PM +0100, Alberto Garcia wrote:
> On Tue 21 Feb 2017 12:55:03 PM CET, Daniel P. Berrange wrote:
> > @@ -175,8 +185,31 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
> >              ret = -ENOSYS;
> >              goto fail;
> >          }
> > +        if (s->crypt_method_header == QCOW_CRYPT_AES) {
> > +            crypto_opts = block_crypto_open_opts_init(
> > +                Q_CRYPTO_BLOCK_FORMAT_QCOW, opts, "aes-", &local_err);
> > +            if (local_err) {
> > +                error_propagate(errp, local_err);
> > +                ret = -EINVAL;
> > +                goto fail;
> > +            }
> >
> > +            if (flags & BDRV_O_NO_IO) {
> > +                cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
> > +            }
> > +            s->crypto = qcrypto_block_open(crypto_opts, NULL, NULL,
> > +                                           cflags, errp);
> 
> You don't call qcrypto_block_free() if qcow_open() eventually fails.
> Although qcow_close() takes care of that, a failure to open the image
> sets bs->drv = NULL in bdrv_open_common(), preventing qcow_close() from
> being called.

Yes, I'll fix that leak.

> 
> > @@ -260,14 +293,17 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
> >          goto fail;
> >      }
> >  
> > +    qapi_free_QCryptoBlockOpenOptions(crypto_opts);
> >      qemu_co_mutex_init(&s->lock);
> >      return 0;
> >  
> >   fail:
> > +    qemu_opts_del(opts);
> 
> You need to delete opts as well if this function succeeds, don't you?

New version will avoid the use of QemuOpts entirely - using the QDict
APIs instead, but I'll have equiv cleanup todo.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
