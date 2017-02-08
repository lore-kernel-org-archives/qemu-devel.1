Received: from eggs.gnu.org ([2001:4830:134:3::10]:56132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cbV1W-0005X0-Di
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:23:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cbV1V-0002X9-Df
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:23:14 -0500
Date: Wed, 8 Feb 2017 16:23:01 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170208162301.GP3129@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
	<20170126101827.22378-12-berrange@redhat.com>
	<w518tpgzmjd.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w518tpgzmjd.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 11/18] qcow2: convert QCow2
 to use QCryptoBlock for encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, Feb 08, 2017 at 05:15:34PM +0100, Alberto Garcia wrote:
> On Thu 26 Jan 2017 11:18:20 AM CET, "Daniel P. Berrange" <berrange@redhat.com> wrote:
> 
> > @@ -751,6 +757,23 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
> >      r->discard_passthrough[QCOW2_DISCARD_OTHER] =
> >          qemu_opt_get_bool(opts, QCOW2_OPT_DISCARD_OTHER, false);
> >  
> > +    switch (s->crypt_method_header) {
> > +    case QCOW_CRYPT_NONE:
> > +        break;
> > +
> > +    case QCOW_CRYPT_AES:
> > +        r->crypto_opts = block_crypto_open_opts_init(
> > +            Q_CRYPTO_BLOCK_FORMAT_QCOW, opts, "aes-", errp);
> > +        break;
> > +
> > +    default:
> > +        g_assert_not_reached();
> 
> This crashes QEMU if the qcow2 file uses an different method (or is
> corrupted).
> 
> > +    }
> > +    if (s->crypt_method_header && !r->crypto_opts) {
> > +        ret = -EINVAL;
> > +        goto fail;
> > +    }
> 
> Shouldn't you remove the assertion and set errp here to "Unsupported
> encryption method" instead?

Yep, I think this was left over from an earlier version of the patch
series where I had already validated crypto_method_header.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
