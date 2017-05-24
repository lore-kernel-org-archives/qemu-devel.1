Received: from eggs.gnu.org ([2001:4830:134:3::10]:35960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dDZQp-0004l7-EM
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dDZQo-00021s-8n
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:46:43 -0400
Date: Wed, 24 May 2017 17:46:31 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170524164631.GA8855@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170425153858.25660-1-berrange@redhat.com>
	<20170425153858.25660-12-berrange@redhat.com>
	<w517f1ntqko.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w517f1ntqko.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v6 11/18] qcow2: convert QCow2 to use
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

On Thu, May 11, 2017 at 04:29:11PM +0200, Alberto Garcia wrote:
> On Tue 25 Apr 2017 05:38:51 PM CEST, Daniel P. Berrange wrote:
> > +    switch (s->crypt_method_header) {
> > +    case QCOW_CRYPT_NONE:
> > +        if (encryptfmt) {
> > +            error_setg(errp, "No encryption in image header, but options "
> > +                       "specified format '%s'", encryptfmt);
> > +            goto fail;
> > +        }
> > +        break;
> 
> You forgot to set the return value here (it is undefined at this
> point)...

Opps, yes.

> 
> > +
> > +    case QCOW_CRYPT_AES:
> > +        if (encryptfmt && !g_str_equal(encryptfmt, "aes")) {
> > +            error_setg(errp,
> > +                       "Header reported 'aes' encryption format but "
> > +                       "options specify '%s'", encryptfmt);
> > +            ret = -EINVAL;
> > +            goto fail;
> > +        }
> 
> ...and here you could break instead, the condition immediately after the
> switch sets ret to -EINVAL and returns.

In thi case I think its clearer to set it right here, rather than having
to follow the code paths through & read the later logic

> > +# Since: 2.10
> > +##
> > +{ 'enum': 'BlockdevQcow2EncryptionFormat',
> > +  'data': [ 'qcow' ] }
> > +
> 
> Same question here, isn't this supposed to be 'aes' ?

Yes

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
