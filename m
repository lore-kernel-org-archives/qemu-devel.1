Received: from eggs.gnu.org ([2001:4830:134:3::10]:60569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dMxAG-0000tf-TJ
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dMxAF-0002Lx-SZ
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:56:25 -0400
Date: Mon, 19 Jun 2017 14:56:14 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170619135614.GE2640@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170601172734.9039-1-berrange@redhat.com>
	<20170601172734.9039-8-berrange@redhat.com>
	<bcff6607-5095-4b98-54ca-b65ecbac0474@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bcff6607-5095-4b98-54ca-b65ecbac0474@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 07/20] block: deprecate "encryption=on"
 in favor of "encrypt.format=aes"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

On Wed, Jun 07, 2017 at 06:40:32PM +0200, Max Reitz wrote:
> On 2017-06-01 19:27, Daniel P. Berrange wrote:
> > Historically the qcow & qcow2 image formats supported a property
> > "encryption=on" to enable their built-in AES encryption. We'll
> > soon be supporting LUKS for qcow2, so need a more general purpose
> > way to enable encryption, with a choice of formats.
> > 
> > This introduces an "encrypt.format" option, which will later be
> > joined by a number of other "encrypt.XXX" options. The use of
> > a "encrypt." prefix instead of "encrypt-" is done to facilitate
> > mapping to a nested QAPI schema at later date.
> > 
> > e.g. the preferred syntax is now
> > 
> >   qemu-img create -f qcow2 -o encrypt.format=aes demo.qcow2
> > 
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Reviewed-by: Alberto Garcia <berto@igalia.com>
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  block/qcow.c               | 30 ++++++++++++++---
> >  block/qcow2.c              | 33 +++++++++++++++----
> >  include/block/block_int.h  |  2 +-
> >  qemu-img.c                 |  4 ++-
> >  tests/qemu-iotests/082.out | 81 ++++++++++++++++++++++++++++++----------------
> >  5 files changed, 110 insertions(+), 40 deletions(-)
> > 
> > diff --git a/block/qcow.c b/block/qcow.c
> > index 6738bc7..42f83b2 100644
> > --- a/block/qcow.c
> > +++ b/block/qcow.c
> 
> [...]
> 
> > @@ -818,8 +818,16 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
> >      }
> >  
> >      backing_file = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
> > -    if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
> > -        flags |= BLOCK_FLAG_ENCRYPT;
> > +    encryptfmt = qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
> > +    if (encryptfmt) {
> > +        if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
> 
> You should probably just use qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT)
> here, because otherwise you can do this:
> 
> $ ./qemu-img create -f qcow -o encryption=off,encrypt.format=aes \
>     foo.qcow 64M
> Formatting 'foo.qcow', fmt=qcow size=67108864 encryption=off
> encrypt.format=aes

Yes, will fix it as you suggest.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
