Received: from eggs.gnu.org ([2001:4830:134:3::10]:54611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW1cm-0007zZ-Ao
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 08:59:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW1ck-0002XV-8K
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 08:59:04 -0500
Date: Tue, 24 Jan 2017 13:58:48 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170124135848.GA28745@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-13-berrange@redhat.com>
	<fdf48e56-2b65-b0cd-39da-010ca751cc02@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fdf48e56-2b65-b0cd-39da-010ca751cc02@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 12/15] qcow2: add support for LUKS
 encryption format
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

On Sat, Jan 21, 2017 at 07:57:45PM +0100, Max Reitz wrote:
> On 03.01.2017 19:27, Daniel P. Berrange wrote:
> > This adds support for using LUKS as an encryption format
> > with the qcow2 file. The use of the existing 'encryption=on'
> > parameter is replaced by a new parameter 'encryption-format'
> > which takes the values 'aes' or 'luks'. e.g.
> > 
> >   # qemu-img create --object secret,data=123456,id=sec0 \
> >        -f qcow2 -o encryption-format=luks,luks-key-secret=sec0 \
> >        test.qcow2 10G
> > 
> > results in the creation of an image using the LUKS format.
> > Use of the legacy 'encryption=on' parameter still results
> > in creation of the old qcow2 AES format, and is equivalent
> > to the new 'encryption-format=aes'. e.g. the following are
> > equivalent:
> > 
> >   # qemu-img create --object secret,data=123456,id=sec0 \
> >        -f qcow2 -o encryption=on,aes-key-secret=sec0 \
> >        test.qcow2 10G
> > 
> >  # qemu-img create --object secret,data=123456,id=sec0 \
> >        -f qcow2 -o encryption-format=aes,aes-key-secret=sec0 \
> >        test.qcow2 10G
> > 
> > With the LUKS format it is necessary to store the LUKS
> > partition header and key material in the QCow2 file. This
> > data can be many MB in size, so cannot go into the QCow2
> > header region directly. Thus the spec defines a FDE
> > (Full Disk Encryption) header extension that specifies
> > the offset of a set of clusters to hold the FDE headers,
> > as well as the length of that region. The LUKS header is
> > thus stored in these extra allocated clusters before the
> > main image payload.
> > 
> > Aside from all the cryptographic differences implied by
> > use of the LUKS format, there is one further key difference
> > between the use of legacy AES and LUKS encryption in qcow2.
> > For LUKS, the initialiazation vectors are generated using
> > the host physical sector as the input, rather than the
> > guest virtual sector. This guarantees unique initialization
> > vectors for all sectors when qcow2 internal snapshots are
> > used, thus giving stronger protection against watermarking
> > attacks.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  block/qcow2-cluster.c      |   4 +-
> >  block/qcow2-refcount.c     |  10 ++
> >  block/qcow2.c              | 236 ++++++++++++++++++++++++++++++++++++++-------
> >  block/qcow2.h              |   9 ++
> >  docs/specs/qcow2.txt       |  99 +++++++++++++++++++
> 
> I'd personally rather have specification changes separate from the
> implementation.
> 
> >  qapi/block-core.json       |   6 +-
> >  tests/qemu-iotests/049     |   2 +-
> >  tests/qemu-iotests/082.out | 216 +++++++++++++++++++++++++++++++++++++++++
> >  tests/qemu-iotests/087     |  65 ++++++++++++-
> >  tests/qemu-iotests/087.out |  22 ++++-
> >  tests/qemu-iotests/134     |   4 +-
> >  tests/qemu-iotests/158     |   8 +-
> >  tests/qemu-iotests/174     |  76 +++++++++++++++
> >  tests/qemu-iotests/174.out |  19 ++++
> >  tests/qemu-iotests/175     |  85 ++++++++++++++++
> >  tests/qemu-iotests/175.out |  26 +++++
> >  tests/qemu-iotests/group   |   2 +
> >  17 files changed, 840 insertions(+), 49 deletions(-)
> >  create mode 100755 tests/qemu-iotests/174
> >  create mode 100644 tests/qemu-iotests/174.out
> >  create mode 100755 tests/qemu-iotests/175
> >  create mode 100644 tests/qemu-iotests/175.out
> 
> Also, in order to help reviewing by making this patch less scary (840
> insertions are kind of... Urgh.), it would make sense to add these two
> tests in one or two separate patches.

Ok, will split it in three - spec change, code change and test
additions.


> > @@ -80,6 +81,73 @@ static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
> 
> [...]
> 
> > +static ssize_t qcow2_crypto_hdr_init_func(QCryptoBlock *block, size_t headerlen,
> > +                                          Error **errp, void *opaque)
> > +{
> > +    BlockDriverState *bs = opaque;
> > +    BDRVQcow2State *s = bs->opaque;
> > +    int64_t ret;
> > +
> > +    ret = qcow2_alloc_clusters(bs, headerlen);
> > +    if (ret < 0) {
> > +        error_setg_errno(errp, -ret,
> > +                         "Cannot allocate cluster for LUKS header size %zu",
> > +                         headerlen);
> > +        return -1;
> > +    }
> > +
> > +    s->crypto_header.length = headerlen;
> > +    s->crypto_header.offset = ret;
> 
> The specification says any unused space in the last cluster has to be
> set to zero. This isn't done here.
> 
> I don't have a preference whether you write zeroes to the range in
> question here or whether you simply relax the specification to say that
> anything beyond crypto_header.length is undefined.

I'll explicitly fill it with zeros.

> > +static ssize_t qcow2_crypto_hdr_write_func(QCryptoBlock *block, size_t offset,
> > +                                           const uint8_t *buf, size_t buflen,
> > +                                           Error **errp, void *opaque)
> > +{
> > +    BlockDriverState *bs = opaque;
> > +    BDRVQcow2State *s = bs->opaque;
> > +    ssize_t ret;
> > +
> > +    if ((offset + buflen) > s->crypto_header.length) {
> > +        error_setg(errp, "Request for data outside of extension header");
> > +        return -1;
> > +    }
> > +
> > +    ret = bdrv_pwrite(bs->file,
> > +                      s->crypto_header.offset + offset, buf, buflen);
> 
> Theoretically, there should be a qcow2_pre_write_overlap_check() here.
> But in theory, qcow2_check_metadata_overlap() should also check overlaps
> with this new block of metadata.
> 
> I'll leave it up to you as the discussion about the future of those
> overlap checks is still up in the air. I really don't have a preference
> on what to do in this patch.

Ok, i'll leave as is for now.

> > @@ -165,6 +233,45 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
> >              }
> >              break;
> >  
> > +        case QCOW2_EXT_MAGIC_CRYPTO_HEADER: {
> > +            unsigned int cflags = 0;
> > +            if (s->crypt_method_header != QCOW_CRYPT_LUKS) {
> > +                error_setg(errp, "CRYPTO header extension only "
> > +                           "expected with LUKS encryption method");
> > +                return -EINVAL;
> > +            }
> > +            if (ext.len != sizeof(Qcow2CryptoHeaderExtension)) {
> > +                error_setg(errp, "CRYPTO header extension size %u, "
> > +                           "but expected size %zu", ext.len,
> > +                           sizeof(Qcow2CryptoHeaderExtension));
> > +                return -EINVAL;
> > +            }
> > +
> > +            ret = bdrv_pread(bs->file, offset, &s->crypto_header, ext.len);
> > +            if (ret < 0) {
> > +                error_setg_errno(errp, -ret,
> > +                                 "Unable to read CRYPTO header extension");
> > +                return ret;
> > +            }
> > +            be64_to_cpu(s->crypto_header.offset);
> > +            be64_to_cpu(s->crypto_header.length);
> 
> Shouldn't you use the result somehow (or use be64_to_cpus)...?

Sigh, yes, intention was to modify in-place

> Also, you should check the validity of s->crypto_header.offset here,
> i.e. whether it is indeed aligned to a cluster boundary.

Ok, wil add that.

> 
> > +
> > +            if (flags & BDRV_O_NO_IO) {
> > +                cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
> > +            }
> > +            /* XXX how do we pass the same crypto opts down to the
> 
> Just as in the previous patch, a TODO would probably be sufficient here.

Yes

> > +             * backing file by default, so we don't have to manually
> > +             * provide the same key-secret property against the full
> > +             * backing chain
> > +             */
> > +            s->crypto = qcrypto_block_open(s->crypto_opts,
> > +                                           qcow2_crypto_hdr_read_func,
> > +                                           bs, cflags, errp);
> > +            if (!s->crypto) {
> > +                return -EINVAL;
> > +            }
> > +            s->crypt_physical_offset = true;
> 
> I think this should be set depending on the crypt_method_header (i.e. in
> qcow2_open()), not depending on whether this extension exists or not.

Yes, makes sense.

> > @@ -988,12 +1101,6 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
> >      s->refcount_max = UINT64_C(1) << (s->refcount_bits - 1);
> >      s->refcount_max += s->refcount_max - 1;
> >  
> > -    if (header.crypt_method > QCOW_CRYPT_AES) {
> > -        error_setg(errp, "Unsupported encryption method: %" PRIu32,
> > -                   header.crypt_method);
> > -        ret = -EINVAL;
> > -        goto fail;
> > -    }
> >      s->crypt_method_header = header.crypt_method;
> >      if (s->crypt_method_header) {
> >          if (bdrv_uses_whitelist() &&
> 
> You could put the assignment of crypt_physical_offset into this block
> (at its bottom where bs->encrypted is set).

Yep will do.


> > @@ -1929,6 +2053,22 @@ int qcow2_update_header(BlockDriverState *bs)
> >          buflen -= ret;
> >      }
> >  
> > +    /* Full disk encryption header pointer extension */
> > +    if (s->crypto_header.offset != 0) {
> > +        cpu_to_be64(s->crypto_header.offset);
> > +        cpu_to_be64(s->crypto_header.length);
> 
> Should be cpu_to_be64s() or you should store the result somewhere.
> 
> > +        ret = header_ext_add(buf, QCOW2_EXT_MAGIC_CRYPTO_HEADER,
> > +                             &s->crypto_header, sizeof(s->crypto_header),
> > +                             buflen);
> > +        be64_to_cpu(s->crypto_header.offset);
> > +        be64_to_cpu(s->crypto_header.length);
> 
> The same with be64_to_cpus().

Yes intention was obviously to modify in-place.

> > @@ -3426,7 +3582,19 @@ static QemuOptsList qcow2_create_opts = {
> >              .help = "Width of a reference count entry in bits",
> >              .def_value_str = "16"
> >          },
> > +        {
> > +            .name = QCOW2_OPT_ENCRYPTION_FORMAT,
> > +            .type = QEMU_OPT_STRING,
> > +            .help = "Encryption data format 'luks' (default) or 'aes'",
> 
> In what way is LUKS the default? No encryption is the default; and the
> default encryption is the old AES-CBC because that is what you get when
> specifying encryption=on.

This is left-over language from a previous approach.

> I would agree if you replaced "default" by "recommended". In addition,
> the help text for the "encryption" option should probably now simply say:
> 
> "Deprecated, use the " QCOW2_OPT_ENCRYPTION_FORMAT " option instead"

Yes, will do that.


> > diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
> > index fe30383..6690715 100755
> > --- a/tests/qemu-iotests/087
> > +++ b/tests/qemu-iotests/087
> 
> [...]
> 
> > @@ -169,7 +169,62 @@ run_qemu <<EOF
> >            "driver": "file",
> >            "filename": "$TEST_IMG"
> >        },
> > -      "qcow-key-secret": "sec0"
> > +      "aes-key-secret": "sec0"
> > +    }
> > +  }
> > +{ "execute": "quit" }
> > +EOF
> > +
> > +echo
> > +echo === Encrypted image LUKS ===
> > +echo
> > +
> > +_make_test_img --object secret,id=sec0,data=123456 -o encryption-format=luks,luks-key-secret=sec0 $size
> > +run_qemu -S <<EOF
> > +{ "execute": "qmp_capabilities" }
> > +{ "execute": "object-add",
> > +  "arguments": {
> > +      "qom-type": "secret",
> > +      "id": "sec0",
> > +      "props": {
> > +          "data": "123456"
> > +      }
> > +  }
> > +}
> > +{ "execute": "blockdev-add",
> > +  "arguments": {
> > +      "driver": "$IMGFMT",
> > +      "node-name": "disk",
> > +      "file": {
> > +          "driver": "file",
> > +          "filename": "$TEST_IMG"
> > +      },
> > +      "luks-key-secret": "sec0"
> > +    }
> > +  }
> > +{ "execute": "quit" }
> > +EOF
> > +
> > +run_qemu <<EOF
> 
> I think we can drop one of the duplicated test cases with and without -S
> now. The reason for having two originally was, as far as I can remember,
> to test that you could blockdev-add encrypted images when the VM was not
> paused. However, that is no longer the case since we are no longer
> relying on that old infrastructure (as of this series at least).

Yes, and in fact I can drop the existing one for qcow2 AES in the
earlier patch where I remove prompting for passwords.


> > diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
> > new file mode 100755
> > index 0000000..27d4870
> > --- /dev/null
> > +++ b/tests/qemu-iotests/174

> > +_supported_fmt qcow2
> > +_supported_proto generic
> > +_supported_os Linux
> > +
> > +
> > +size=128M
> > +
> > +SECRET="secret,id=sec0,data=astrochicken"
> > +SECRETALT="secret,id=sec0,data=platypus"
> > +
> > +_make_test_img --object $SECRET -o "encryption-format=luks,luks-key-secret=sec0" $size
> > +
> > +IMGSPEC="driver=$IMGFMT,file.filename=$TEST_IMG,luks-key-secret=sec0"
> > +
> > +QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
> > +
> > +echo
> > +echo "== reading whole image =="
> > +$QEMU_IO --object $SECRET -c "read 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
> 
> Shouldn't "read -P 0 0 $size" work here, too?

The underlying disk image contents will be zeros, but we'll then decrypt
those zeros and get random garbage.

We could only use -P 0 if we explicitly fill with encrypted-zeros.

> > +echo
> > +echo "== rewriting whole image =="
> > +$QEMU_IO --object $SECRET -c "write -P 0xa 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
> > +
> > +echo
> > +echo "== verify pattern =="
> > +$QEMU_IO --object $SECRET -c "read -P 0xa 0 $size"  --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
> 
> But do you really want to read and write 128 MB...? I mean, even on an
> HDD, it will only take a couple of seconds at most, but won't 16 or 32
> MB suffice? That way, it should always take less than a second.

I'll drop it to 16 MB, but this reminds me the real performance
benefit comes from telling luks to not force 1 second running
time for the PBKDF algorithm. So I'll drop PBKDK down to 10ms
instead of 1sec


> > +== verify pattern failure with wrong password ==
> > +can't open: Invalid password, cannot unlock any keyslot
> 
> Well, that's not quite a pattern failure. It's the result we want, but
> you should probably change the heading for this test case.

Good point.


> > +# get standard environment, filters and checks
> > +. ./common.rc
> > +. ./common.filter
> > +
> > +_supported_fmt qcow2
> > +_supported_proto generic
> > +_supported_os Linux
> > +
> > +
> > +size=128M
> 
> Same as in last test, I'm not sure 128 MB are actually necessary.
> 
> > +TEST_IMG_BASE=$TEST_IMG.base
> 
> Hmmm, does this work with spaces in $TEST_IMG?
> 
> > +SECRET="secret,id=sec0,data=astrochicken"
> 
> How about using different secrets for the base and the overlay?

Yes, that's a good idea.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
