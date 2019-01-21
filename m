Received: from eggs.gnu.org ([209.51.188.92]:50874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1glZtq-0003vZ-BC
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:46:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1glZtp-0000fQ-78
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:46:02 -0500
Date: Mon, 21 Jan 2019 13:45:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190121134544.GC3683@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190115111007.27159-1-stefanha@redhat.com>
	<20190115111007.27159-2-stefanha@redhat.com>
	<7c29009e-2332-0901-3e00-8aa4c6b28796@redhat.com>
	<5786786a-1389-81a3-2c9a-fbeca0be10a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5786786a-1389-81a3-2c9a-fbeca0be10a9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: include LUKS payload overhead
 in qemu-img measure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Mon, Jan 21, 2019 at 02:15:03PM +0100, Max Reitz wrote:
> On 21.01.19 14:08, Max Reitz wrote:
> > On 15.01.19 12:10, Stefan Hajnoczi wrote:
> >> LUKS encryption reserves clusters for its own payload data.  The size of
> >> this area must be included in the qemu-img measure calculation so that
> >> we arrive at the correct minimum required image size.
> >>
> >> (Ab)use the qcrypto_block_create() API to determine the payload
> >> overhead.  We discard the payload data that qcrypto thinks will be
> >> written to the image.
> >>
> >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> ---
> >>  block/qcow2.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 50 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/block/qcow2.c b/block/qcow2.c
> >> index 4897abae5e..7ab93a5d2f 100644
> >> --- a/block/qcow2.c
> >> +++ b/block/qcow2.c
> > 
> > [...]
> > 
> >> @@ -4274,6 +4294,35 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
> >>      has_backing_file = !!optstr;
> >>      g_free(optstr);
> >>  
> >> +    optstr = qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
> >> +    has_luks = optstr && strcmp(optstr, "luks") == 0;
> >> +    g_free(optstr);
> >> +
> >> +    if (has_luks) {
> >> +        QCryptoBlockCreateOptions cryptoopts = {
> >> +            .format = Q_CRYPTO_BLOCK_FORMAT_LUKS,
> >> +        };
> >> +        QCryptoBlock *crypto;
> >> +        size_t headerlen;
> >> +
> >> +        optstr = qemu_opt_get_del(opts, "encrypt.key-secret");
> >> +        cryptoopts.u.luks.has_key_secret = !!optstr;
> >> +        cryptoopts.u.luks.key_secret = optstr;
> > 
> > I wonder if you couldn't just make some secret up here (if the user
> > doesn't specify anything).  Its content shouldn't matter, right?
> 
> And now I wonder whether other options may not have actual influence on
> the crypto header size.  I suppose in theory the cipher algorithm may
> cause a difference, although it's probably not enough to warrant another
> cluster...

The LUKS header comprises three parts

 - A field size initial header with general config properties
 - A series of fixed size key slot headers, one per slot, fixed
   at 8 slots in the code
 - A series of regions of key material, one per slot.

The last one is a problem - the size of the key slot regions is
the number of anti-forensic stripes (4096) multipled by the size
of the master key. The latter depends on the size of the cipher
key. This is referred to as "splitkeylen" in the code creating
this. The overall space reserved for headers is then determined
by:

    luks->header.payload_offset =
        (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
         QCRYPTO_BLOCK_LUKS_SECTOR_SIZE) +
        (ROUND_UP(DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE),
                  (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
                   QCRYPTO_BLOCK_LUKS_SECTOR_SIZE)) *
         QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);

So for AES-128  key materials takes 0.5 MB, while for AES-256 key material
takes 1 MB, so adding together you get 1052672 byte for header in AES-128
and 2068480 bytes for AES-256, rounded up to qcow2 cluster size (whatever
that is configured to be)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
