Received: from eggs.gnu.org ([2001:4830:134:3::10]:35780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dMxLl-0005gR-11
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dMxLj-0000RR-M2
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:08:16 -0400
Date: Mon, 19 Jun 2017 15:08:02 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170619140802.GH2640@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170601172734.9039-1-berrange@redhat.com>
	<20170601172734.9039-20-berrange@redhat.com>
	<8e56eb6a-6e2e-41fa-80fd-59060fca6e51@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e56eb6a-6e2e-41fa-80fd-59060fca6e51@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 19/20] qcow2: report encryption specific
 image information
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

On Wed, Jun 07, 2017 at 07:38:44PM +0200, Max Reitz wrote:
> On 2017-06-01 19:27, Daniel P. Berrange wrote:
> > Currently 'qemu-img info' reports a simple "encrypted: yes"
> > field. This is not very useful now that qcow2 can support
> > multiple encryption formats. Users want to know which format
> > is in use and some data related to it.
> > 
> > Wire up usage of the qcrypto_block_get_info() method so that
> > 'qemu-img info' can report about the encryption format
> > and parameters in use
> > 
> >   $ qemu-img create \
> >       --object secret,id=sec0,data=123456 \
> >       -o encrypt.format=luks,encrypt.key-secret=sec0 \
> >       -f qcow2 demo.qcow2 1G
> >   Formatting 'demo.qcow2', fmt=qcow2 size=1073741824 \
> >   encryption=off encrypt.format=luks encrypt.key-secret=sec0 \
> >   cluster_size=65536 lazy_refcounts=off refcount_bits=16
> > 
> >   $ qemu-img info demo.qcow2
> >   image: demo.qcow2
> >   file format: qcow2
> >   virtual size: 1.0G (1073741824 bytes)
> >   disk size: 480K
> >   encrypted: yes
> >   cluster_size: 65536
> >   Format specific information:
> >       compat: 1.1
> >       lazy refcounts: false
> >       refcount bits: 16
> >       encrypt:
> >           ivgen alg: plain64
> >           hash alg: sha256
> >           cipher alg: aes-256
> >           uuid: 3fa930c4-58c8-4ef7-b3c5-314bb5af21f3
> >           format: luks
> >           cipher mode: xts
> >           slots:
> >               [0]:
> >                   active: true
> >                   iters: 1839058
> >                   key offset: 4096
> >                   stripes: 4000
> >               [1]:
> >                   active: false
> >                   key offset: 262144
> >               [2]:
> >                   active: false
> >                   key offset: 520192
> >               [3]:
> >                   active: false
> >                   key offset: 778240
> >               [4]:
> >                   active: false
> >                   key offset: 1036288
> >               [5]:
> >                   active: false
> >                   key offset: 1294336
> >               [6]:
> >                   active: false
> >                   key offset: 1552384
> >               [7]:
> >                   active: false
> >                   key offset: 1810432
> >           payload offset: 2068480
> >           master key iters: 438487
> >       corrupt: false
> > 
> > With the legacy "AES" encryption we just report the format
> > name
> > 
> >   $ qemu-img create \
> >       --object secret,id=sec0,data=123456 \
> >       -o encrypt.format=aes,encrypt.key-secret=sec0 \
> >       -f qcow2 demo.qcow2 1G
> >   Formatting 'demo.qcow2', fmt=qcow2 size=1073741824 \
> >   encryption=off encrypt.format=aes encrypt.key-secret=sec0 \
> >   cluster_size=65536 lazy_refcounts=off refcount_bits=16
> > 
> >   $ ./qemu-img info demo.qcow2
> >   image: demo.qcow2
> >   file format: qcow2
> >   virtual size: 1.0G (1073741824 bytes)
> >   disk size: 196K
> >   encrypted: yes
> >   cluster_size: 65536
> >   Format specific information:
> >       compat: 1.1
> >       lazy refcounts: false
> >       refcount bits: 16
> >       encrypt:
> >           format: aes
> >       corrupt: false
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  block/qcow2.c        | 32 +++++++++++++++++++++++++++++++-
> >  qapi/block-core.json | 27 ++++++++++++++++++++++++++-
> >  2 files changed, 57 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 58da658..a8a23af 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> 
> [...]
> 
> > @@ -3224,6 +3230,30 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
> >          assert(false);
> >      }
> >  
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
> 
> I'd rather like this to be either a plain abort() or a
> g_asert_not_reached(); the latter is more expressive, and the former
> will work even with NDEBUG.

Its very annoying that g_assert_not_reached() can be turned into
a no-op as that would lead to bad code, so I'll make it abort().

> I know we already have an assert(false) in this function, but I'd assert
> this is just wrong.

Agreed.

> With this changed (or with me convinced that we should just use
> assert(false)):
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
