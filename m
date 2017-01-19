Received: from eggs.gnu.org ([2001:4830:134:3::10]:43472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cU9C9-0007Qz-DS
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cU9C8-00088x-1C
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:39:49 -0500
Date: Thu, 19 Jan 2017 09:39:33 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170119093933.GD10906@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-12-berrange@redhat.com>
	<f8f66036-e59d-2b37-bd5c-86f693fdf9f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8f66036-e59d-2b37-bd5c-86f693fdf9f9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 11/15] qcow2: convert QCow2 to use
 QCryptoBlock for encryption
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

On Wed, Jan 18, 2017 at 07:13:19PM +0100, Max Reitz wrote:
> On 03.01.2017 19:27, Daniel P. Berrange wrote:
> > This converts the qcow2 driver to make use of the QCryptoBlock
> > APIs for encrypting image content, using the legacyy QCow2 AES
> > scheme.
> > 
> > With this change it is now required to use the QCryptoSecret
> > object for providing passwords, instead of the current block
> > password APIs / interactive prompting.
> > 
> >   $QEMU \
> >     -object secret,id=sec0,filename=/home/berrange/encrypted.pw \
> >     -drive file=/home/berrange/encrypted.qcow2,aes-key-secret=sec0
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  block/qcow2-cluster.c      |  47 +----------
> >  block/qcow2.c              | 190 +++++++++++++++++++++++++++++----------------
> >  block/qcow2.h              |   5 +-
> >  qapi/block-core.json       |   7 +-
> >  tests/qemu-iotests/049     |   2 +-
> >  tests/qemu-iotests/049.out |   4 +-
> >  tests/qemu-iotests/082.out |  27 +++++++
> >  tests/qemu-iotests/087     |  28 ++++++-
> >  tests/qemu-iotests/087.out |   6 +-
> >  tests/qemu-iotests/134     |  18 +++--
> >  tests/qemu-iotests/134.out |  10 +--
> >  tests/qemu-iotests/158     |  19 +++--
> >  tests/qemu-iotests/158.out |  14 +---
> >  13 files changed, 219 insertions(+), 158 deletions(-)
> 
> [...]
> 
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 3c14c86..5c9e196 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> 
> [...]
> 
> > @@ -1122,6 +1144,24 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
> >          goto fail;
> >      }
> >  
> > +    if (s->crypt_method_header == QCOW_CRYPT_AES) {
> > +        unsigned int cflags = 0;
> > +        if (flags & BDRV_O_NO_IO) {
> > +            cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
> > +        }
> > +        /* XXX how do we pass the same crypto opts down to the
> 
> I think a TODO instead of an XXX would have been sufficient, but it's
> your call.

Sure, I can put TODO.

> > +         * backing file by default, so we don't have to manually
> > +         * provide the same key-secret property against the full
> > +         * backing chain
> > +         */
> > +        s->crypto = qcrypto_block_open(s->crypto_opts, NULL, NULL,
> > +                                       cflags, errp);
> > +        if (!s->crypto) {
> > +            ret = -EINVAL;
> > +            goto fail;
> > +        }
> 
> [...]
> 
> > @@ -2022,6 +2027,44 @@ static int qcow2_change_backing_file(BlockDriverState *bs,
> >      return qcow2_update_header(bs);
> >  }
> >  
> > +
> > +static int qcow2_change_encryption(BlockDriverState *bs, QemuOpts *opts,
> > +                                   Error **errp)
> 
> I think this name is not quite appropriate, since this doesn't change
> the format of the file if it is already encrypted (and it will not
> encrypt any existing data).
> 
> Maybe set_up instead of change?

Yep, will change to that

> > diff --git a/block/qcow2.h b/block/qcow2.h
> > index 033d8c0..f4cb171 100644
> > --- a/block/qcow2.h
> > +++ b/block/qcow2.h
> > @@ -25,7 +25,7 @@
> >  #ifndef BLOCK_QCOW2_H
> >  #define BLOCK_QCOW2_H
> >  
> > -#include "crypto/cipher.h"
> > +#include "crypto/block.h"
> >  #include "qemu/coroutine.h"
> >  
> >  //#define DEBUG_ALLOC
> > @@ -256,7 +256,8 @@ typedef struct BDRVQcow2State {
> >  
> >      CoMutex lock;
> >  
> > -    QCryptoCipher *cipher; /* current cipher, NULL if no key yet */
> > +    QCryptoBlockOpenOptions *crypto_opts; /* Disk encryption runtime options */
> > +    QCryptoBlock *crypto; /* Disk encryption format driver */
> >      uint32_t crypt_method_header;
> >      uint64_t snapshots_offset;
> >      int snapshots_size;
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index c2b70e8..2ca5674 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -1935,6 +1935,9 @@
> >  # @cache-clean-interval:  #optional clean unused entries in the L2 and refcount
> >  #                         caches. The interval is in seconds. The default value
> >  #                         is 0 and it disables this feature (since 2.5)
> > +# @aes-key-secret:        #optional the ID of a QCryptoSecret object providing
> > +#                         the AES decryption key (since 2.9) Mandatory except
> 
> Missing full stop after the closing parenthesis.
> 
> Also, it's mandatory only for encrypted images. I know it's obvious but
> that's not what it says here.

True, I'll clarify

> 
> > +#                         when doing a metadata-only probe of the image.
> >  #
> >  # Since: 1.7
> >  ##
> > @@ -1948,8 +1951,8 @@
> >              '*cache-size': 'int',
> >              '*l2-cache-size': 'int',
> >              '*refcount-cache-size': 'int',
> > -            '*cache-clean-interval': 'int' } }
> > -
> > +            '*cache-clean-interval': 'int',
> > +            '*aes-key-secret': 'str' } }
> >  
> >  ##
> >  # @BlockdevOptionsArchipelago:
> > diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
> > index fff0760..7da4ac8 100755
> > --- a/tests/qemu-iotests/049
> > +++ b/tests/qemu-iotests/049
> > @@ -106,7 +106,7 @@ test_qemu_img create -f $IMGFMT -o preallocation=1234 "$TEST_IMG" 64M
> >  echo "== Check encryption option =="
> >  echo
> >  test_qemu_img create -f $IMGFMT -o encryption=off "$TEST_IMG" 64M
> > -test_qemu_img create -f $IMGFMT -o encryption=on "$TEST_IMG" 64M
> > +test_qemu_img create -f $IMGFMT --object secret,id=sec0,data=123456 -o encryption=on,qcow-key-secret=sec0 "$TEST_IMG" 64M
> 
> s/qcow-key-secret/aes-key-secret/

Opps, that change accidentally got squashed into the next patch instead
of this one.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
