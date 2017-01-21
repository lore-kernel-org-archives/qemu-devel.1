Received: from eggs.gnu.org ([2001:4830:134:3::10]:40519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cV0rT-0003Ev-7k
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 13:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cV0rP-00027J-NU
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 13:58:03 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-13-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fdf48e56-2b65-b0cd-39da-010ca751cc02@redhat.com>
Date: Sat, 21 Jan 2017 19:57:45 +0100
MIME-Version: 1.0
In-Reply-To: <20170103182801.9638-13-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1Bj5EWWxRfbKmh6g3Lko5vGc0APTKoQpF"
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
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1Bj5EWWxRfbKmh6g3Lko5vGc0APTKoQpF
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <fdf48e56-2b65-b0cd-39da-010ca751cc02@redhat.com>
Subject: Re: [PATCH v1 12/15] qcow2: add support for LUKS encryption format
References: <20170103182801.9638-1-berrange@redhat.com>
 <20170103182801.9638-13-berrange@redhat.com>
In-Reply-To: <20170103182801.9638-13-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.01.2017 19:27, Daniel P. Berrange wrote:
> This adds support for using LUKS as an encryption format
> with the qcow2 file. The use of the existing 'encryption=3Don'
> parameter is replaced by a new parameter 'encryption-format'
> which takes the values 'aes' or 'luks'. e.g.
>=20
>   # qemu-img create --object secret,data=3D123456,id=3Dsec0 \
>        -f qcow2 -o encryption-format=3Dluks,luks-key-secret=3Dsec0 \
>        test.qcow2 10G
>=20
> results in the creation of an image using the LUKS format.
> Use of the legacy 'encryption=3Don' parameter still results
> in creation of the old qcow2 AES format, and is equivalent
> to the new 'encryption-format=3Daes'. e.g. the following are
> equivalent:
>=20
>   # qemu-img create --object secret,data=3D123456,id=3Dsec0 \
>        -f qcow2 -o encryption=3Don,aes-key-secret=3Dsec0 \
>        test.qcow2 10G
>=20
>  # qemu-img create --object secret,data=3D123456,id=3Dsec0 \
>        -f qcow2 -o encryption-format=3Daes,aes-key-secret=3Dsec0 \
>        test.qcow2 10G
>=20
> With the LUKS format it is necessary to store the LUKS
> partition header and key material in the QCow2 file. This
> data can be many MB in size, so cannot go into the QCow2
> header region directly. Thus the spec defines a FDE
> (Full Disk Encryption) header extension that specifies
> the offset of a set of clusters to hold the FDE headers,
> as well as the length of that region. The LUKS header is
> thus stored in these extra allocated clusters before the
> main image payload.
>=20
> Aside from all the cryptographic differences implied by
> use of the LUKS format, there is one further key difference
> between the use of legacy AES and LUKS encryption in qcow2.
> For LUKS, the initialiazation vectors are generated using
> the host physical sector as the input, rather than the
> guest virtual sector. This guarantees unique initialization
> vectors for all sectors when qcow2 internal snapshots are
> used, thus giving stronger protection against watermarking
> attacks.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/qcow2-cluster.c      |   4 +-
>  block/qcow2-refcount.c     |  10 ++
>  block/qcow2.c              | 236 +++++++++++++++++++++++++++++++++++++=
+-------
>  block/qcow2.h              |   9 ++
>  docs/specs/qcow2.txt       |  99 +++++++++++++++++++

I'd personally rather have specification changes separate from the
implementation.

>  qapi/block-core.json       |   6 +-
>  tests/qemu-iotests/049     |   2 +-
>  tests/qemu-iotests/082.out | 216 +++++++++++++++++++++++++++++++++++++=
++++
>  tests/qemu-iotests/087     |  65 ++++++++++++-
>  tests/qemu-iotests/087.out |  22 ++++-
>  tests/qemu-iotests/134     |   4 +-
>  tests/qemu-iotests/158     |   8 +-
>  tests/qemu-iotests/174     |  76 +++++++++++++++
>  tests/qemu-iotests/174.out |  19 ++++
>  tests/qemu-iotests/175     |  85 ++++++++++++++++
>  tests/qemu-iotests/175.out |  26 +++++
>  tests/qemu-iotests/group   |   2 +
>  17 files changed, 840 insertions(+), 49 deletions(-)
>  create mode 100755 tests/qemu-iotests/174
>  create mode 100644 tests/qemu-iotests/174.out
>  create mode 100755 tests/qemu-iotests/175
>  create mode 100644 tests/qemu-iotests/175.out

Also, in order to help reviewing by making this patch less scary (840
insertions are kind of... Urgh.), it would make sense to add these two
tests in one or two separate patches.

> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index a2103dc..866b122 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -383,7 +383,9 @@ static int coroutine_fn do_perform_cow(BlockDriverS=
tate *bs,
> =20
>      if (bs->encrypted) {
>          Error *err =3D NULL;
> -        int64_t sector =3D (src_cluster_offset + offset_in_cluster)
> +        int64_t sector =3D (s->crypt_physical_offset ?
> +                          (cluster_offset + offset_in_cluster) :
> +                          (src_cluster_offset + offset_in_cluster))
>                           >> BDRV_SECTOR_BITS;
>          assert((offset_in_cluster & ~BDRV_SECTOR_MASK) =3D=3D 0);
>          assert((bytes & ~BDRV_SECTOR_MASK) =3D=3D 0);
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index cbfb3fe..afa4636 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c

[...]

> @@ -80,6 +81,73 @@ static int qcow2_probe(const uint8_t *buf, int buf_s=
ize, const char *filename)

[...]

> +static ssize_t qcow2_crypto_hdr_init_func(QCryptoBlock *block, size_t =
headerlen,
> +                                          Error **errp, void *opaque)
> +{
> +    BlockDriverState *bs =3D opaque;
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int64_t ret;
> +
> +    ret =3D qcow2_alloc_clusters(bs, headerlen);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret,
> +                         "Cannot allocate cluster for LUKS header size=
 %zu",
> +                         headerlen);
> +        return -1;
> +    }
> +
> +    s->crypto_header.length =3D headerlen;
> +    s->crypto_header.offset =3D ret;

The specification says any unused space in the last cluster has to be
set to zero. This isn't done here.

I don't have a preference whether you write zeroes to the range in
question here or whether you simply relax the specification to say that
anything beyond crypto_header.length is undefined.

> +    return ret;
> +}
> +
> +
> +static ssize_t qcow2_crypto_hdr_write_func(QCryptoBlock *block, size_t=
 offset,
> +                                           const uint8_t *buf, size_t =
buflen,
> +                                           Error **errp, void *opaque)=

> +{
> +    BlockDriverState *bs =3D opaque;
> +    BDRVQcow2State *s =3D bs->opaque;
> +    ssize_t ret;
> +
> +    if ((offset + buflen) > s->crypto_header.length) {
> +        error_setg(errp, "Request for data outside of extension header=
");
> +        return -1;
> +    }
> +
> +    ret =3D bdrv_pwrite(bs->file,
> +                      s->crypto_header.offset + offset, buf, buflen);

Theoretically, there should be a qcow2_pre_write_overlap_check() here.
But in theory, qcow2_check_metadata_overlap() should also check overlaps
with this new block of metadata.

I'll leave it up to you as the discussion about the future of those
overlap checks is still up in the air. I really don't have a preference
on what to do in this patch.

> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Could not read encryption header=
");
> +        return -1;
> +    }
> +    return ret;
> +}
> +
> +
>  /*=20
>   * read qcow2 extension and fill bs
>   * start reading from start_offset

[...]

> @@ -165,6 +233,45 @@ static int qcow2_read_extensions(BlockDriverState =
*bs, uint64_t start_offset,
>              }
>              break;
> =20
> +        case QCOW2_EXT_MAGIC_CRYPTO_HEADER: {
> +            unsigned int cflags =3D 0;
> +            if (s->crypt_method_header !=3D QCOW_CRYPT_LUKS) {
> +                error_setg(errp, "CRYPTO header extension only "
> +                           "expected with LUKS encryption method");
> +                return -EINVAL;
> +            }
> +            if (ext.len !=3D sizeof(Qcow2CryptoHeaderExtension)) {
> +                error_setg(errp, "CRYPTO header extension size %u, "
> +                           "but expected size %zu", ext.len,
> +                           sizeof(Qcow2CryptoHeaderExtension));
> +                return -EINVAL;
> +            }
> +
> +            ret =3D bdrv_pread(bs->file, offset, &s->crypto_header, ex=
t.len);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret,
> +                                 "Unable to read CRYPTO header extensi=
on");
> +                return ret;
> +            }
> +            be64_to_cpu(s->crypto_header.offset);
> +            be64_to_cpu(s->crypto_header.length);

Shouldn't you use the result somehow (or use be64_to_cpus)...?

Also, you should check the validity of s->crypto_header.offset here,
i.e. whether it is indeed aligned to a cluster boundary.

> +
> +            if (flags & BDRV_O_NO_IO) {
> +                cflags |=3D QCRYPTO_BLOCK_OPEN_NO_IO;
> +            }
> +            /* XXX how do we pass the same crypto opts down to the

Just as in the previous patch, a TODO would probably be sufficient here.

> +             * backing file by default, so we don't have to manually
> +             * provide the same key-secret property against the full
> +             * backing chain
> +             */
> +            s->crypto =3D qcrypto_block_open(s->crypto_opts,
> +                                           qcow2_crypto_hdr_read_func,=

> +                                           bs, cflags, errp);
> +            if (!s->crypto) {
> +                return -EINVAL;
> +            }
> +            s->crypt_physical_offset =3D true;

I think this should be set depending on the crypt_method_header (i.e. in
qcow2_open()), not depending on whether this extension exists or not.

> +        }   break;

I'd put an empty line here (because all the other cases do so).

>          default:
>              /* unknown magic - save it in case we need to rewrite the =
header */
>              {

[...]

> @@ -988,12 +1101,6 @@ static int qcow2_open(BlockDriverState *bs, QDict=
 *options, int flags,
>      s->refcount_max =3D UINT64_C(1) << (s->refcount_bits - 1);
>      s->refcount_max +=3D s->refcount_max - 1;
> =20
> -    if (header.crypt_method > QCOW_CRYPT_AES) {
> -        error_setg(errp, "Unsupported encryption method: %" PRIu32,
> -                   header.crypt_method);
> -        ret =3D -EINVAL;
> -        goto fail;
> -    }
>      s->crypt_method_header =3D header.crypt_method;
>      if (s->crypt_method_header) {
>          if (bdrv_uses_whitelist() &&

You could put the assignment of crypt_physical_offset into this block
(at its bottom where bs->encrypted is set).

> @@ -1138,25 +1245,37 @@ static int qcow2_open(BlockDriverState *bs, QDi=
ct *options, int flags,
> =20
>      /* read qcow2 extensions */
>      if (qcow2_read_extensions(bs, header.header_length, ext_end, NULL,=

> -        &local_err)) {
> +                              flags, &local_err)) {
>          error_propagate(errp, local_err);
>          ret =3D -EINVAL;
>          goto fail;
>      }
> =20
> -    if (s->crypt_method_header =3D=3D QCOW_CRYPT_AES) {
> -        unsigned int cflags =3D 0;
> -        if (flags & BDRV_O_NO_IO) {
> -            cflags |=3D QCRYPTO_BLOCK_OPEN_NO_IO;
> -        }
> -        /* XXX how do we pass the same crypto opts down to the
> -         * backing file by default, so we don't have to manually
> -         * provide the same key-secret property against the full
> -         * backing chain
> -         */
> -        s->crypto =3D qcrypto_block_open(s->crypto_opts, NULL, NULL,
> -                                       cflags, errp);
> -        if (!s->crypto) {
> +    /* qcow2_read_extension may have set up the crypto context
> +     * if the crypt method needs a header region, some methods
> +     * don't need header extensions, so must check here
> +     */
> +    if (s->crypt_method_header && !s->crypto) {
> +        if (s->crypt_method_header =3D=3D QCOW_CRYPT_AES) {
> +            unsigned int cflags =3D 0;
> +            if (flags & BDRV_O_NO_IO) {
> +                cflags |=3D QCRYPTO_BLOCK_OPEN_NO_IO;
> +            }
> +            /* XXX how do we pass the same crypto opts down to the

The XXX-vs-TODO thing again, even though here it's pre-existing...

> +             * backing file by default, so we don't have to manually
> +             * provide the same key-secret property against the full
> +             * backing chain
> +             */
> +            s->crypto =3D qcrypto_block_open(s->crypto_opts, NULL, NUL=
L,
> +                                           cflags, errp);
> +            if (!s->crypto) {
> +                ret =3D -EINVAL;
> +                goto fail;
> +            }
> +            s->crypt_physical_offset =3D false;
> +        } else if (!(flags & BDRV_O_NO_IO)) {
> +            error_setg(errp, "Missing CRYPTO header for crypt method %=
d",
> +                       s->crypt_method_header);
>              ret =3D -EINVAL;
>              goto fail;
>          }

[...]

> @@ -1929,6 +2053,22 @@ int qcow2_update_header(BlockDriverState *bs)
>          buflen -=3D ret;
>      }
> =20
> +    /* Full disk encryption header pointer extension */
> +    if (s->crypto_header.offset !=3D 0) {
> +        cpu_to_be64(s->crypto_header.offset);
> +        cpu_to_be64(s->crypto_header.length);

Should be cpu_to_be64s() or you should store the result somewhere.

> +        ret =3D header_ext_add(buf, QCOW2_EXT_MAGIC_CRYPTO_HEADER,
> +                             &s->crypto_header, sizeof(s->crypto_heade=
r),
> +                             buflen);
> +        be64_to_cpu(s->crypto_header.offset);
> +        be64_to_cpu(s->crypto_header.length);

The same with be64_to_cpus().

> +        if (ret < 0) {
> +            goto fail;
> +        }
> +        buf +=3D ret;
> +        buflen -=3D ret;
> +    }
> +
>      /* Feature table */
>      if (s->qcow_version >=3D 3) {
>          Qcow2Feature features[] =3D {

[...]

> @@ -3426,7 +3582,19 @@ static QemuOptsList qcow2_create_opts =3D {
>              .help =3D "Width of a reference count entry in bits",
>              .def_value_str =3D "16"
>          },
> +        {
> +            .name =3D QCOW2_OPT_ENCRYPTION_FORMAT,
> +            .type =3D QEMU_OPT_STRING,
> +            .help =3D "Encryption data format 'luks' (default) or 'aes=
'",

In what way is LUKS the default? No encryption is the default; and the
default encryption is the old AES-CBC because that is what you get when
specifying encryption=3Don.

I would agree if you replaced "default" by "recommended". In addition,
the help text for the "encryption" option should probably now simply say:=


"Deprecated, use the " QCOW2_OPT_ENCRYPTION_FORMAT " option instead"

(Otherwise, it would have to explain that the encryption you get is the
plain old qcow2 AES encryption, which is strongly not recommended, and
that you have to use encryption-format to get LUKS, which is what you wan=
t.)

> +        },
>          BLOCK_CRYPTO_OPT_DEF_QCOW_KEY_SECRET("aes-"),
> +        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET("luks-"),
> +        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG("luks-"),
> +        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE("luks-"),
> +        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG("luks-"),
> +        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("luks-"),
> +        BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("luks-"),
> +        BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("luks-"),
>          { /* end of list */ }
>      }
>  };

[...]

> diff --git a/docs/specs/qcow2.txt b/docs/specs/qcow2.txt
> index 80cdfd0..cc90276 100644
> --- a/docs/specs/qcow2.txt
> +++ b/docs/specs/qcow2.txt

[...]

> @@ -207,6 +209,103 @@ The fields of the bitmaps extension are:
>                     Offset into the image file at which the bitmap dire=
ctory
>                     starts. Must be aligned to a cluster boundary.
> =20
> +=3D=3D Full disk encryption header pointer =3D=3D
> +
> +The full disk encryption header must be present if, and only if, the
> +'crypt_method' header requires metadata. Currently this is only true
> +of the 'LUKS' crypt method. The header extension must be absent for
> +other methods.
> +
> +This header provides the offset at which the crypt method can store
> +its additional data, as well as the length of such data.
> +
> +    Byte  0 -  7:   Offset into the image file at which the encryption=

> +                    header starts in bytes. Must be aligned to a clust=
er
> +		    boundary.
> +    Byte  8 - 16:   Length of the written encryption header in bytes.

s/16/15/

> +                    Note actual space allocated in the qcow2 file may
> +		    be larger than this value, since it will be rounded
> +		    to the nearest multiple of the cluster size. Any
> +		    unused bytes in the allocated space will be initialized
> +		    to 0.
> +
> +For the LUKS crypt method, the encryption header works as follows.
> +
> +The first 592 bytes of the header clusters will contain the LUKS
> +partition header. This is then followed by the key material data areas=
=2E
> +The size of the key material data areas is determined by the number of=

> +stripes in the key slot and key size. Refer to the LUKS format
> +specification ('docs/on-disk-format.pdf' in the cryptsetup source
> +package) for details of the LUKS partition header format.
> +
> +In the LUKS partition header, the "payload-offset" field will be
> +calculated as normal for the LUKS spec. ie the size of the LUKS
> +header, plus key material regions, plus padding. Its value is not
> +used, however, since the qcow2 file format itself defines where
> +the real payload offset is.
> +
> +In the LUKS key slots header, the "key-material-offset" is relative
> +to the start of the LUKS header clusters in the qcow2 container,
> +not the start of the qcow2 file.
> +
> +Logically the layout looks like
> +
> +  +-----------------------------+
> +  | QCow2 header                |
> +  +-----------------------------+
> +  | QCow2 header extension X    |
> +  +-----------------------------+
> +  | QCow2 header extension FDE  |
> +  +-----------------------------+
> +  | QCow2 header extension ...  |
> +  +-----------------------------+
> +  | QCow2 header extension Z    |
> +  +-----------------------------+
> +  | ....other QCow2 tables....  |

This makes it look like as if all the header extensions are in their own
specific cluster, which they are not.

> +  .                             .
> +  .                             .
> +  +-----------------------------+
> +  | +-------------------------+ |
> +  | | LUKS partition header   | |
> +  | +-------------------------+ |
> +  | | LUKS key material 1     | |
> +  | +-------------------------+ |
> +  | | LUKS key material 2     | |
> +  | +-------------------------+ |
> +  | | LUKS key material ...   | |
> +  | +-------------------------+ |
> +  | | LUKS key material 8     | |
> +  | +-------------------------+ |
> +  +-----------------------------+
> +  | QCow2 cluster payload       |
> +  .                             .
> +  .                             .
> +  .                             .
> +  |                             |
> +  +-----------------------------+

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 2ca5674..08bc3e4 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1938,6 +1938,9 @@
>  # @aes-key-secret:        #optional the ID of a QCryptoSecret object p=
roviding
>  #                         the AES decryption key (since 2.9) Mandatory=
 except
>  #                         when doing a metadata-only probe of the imag=
e.
> +# @luks-key-secret:       #optional the ID of a QCryptoSecret object p=
roviding
> +#                         the LUKS keyslot passphrase (since 2.9) Mand=
atory

Missing full stop after the closing parenthesis.

> +#                         except when doing a metadata-only probe of t=
he image.
>  #
>  # Since: 1.7
>  ##

[...]

> diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
> index fe30383..6690715 100755
> --- a/tests/qemu-iotests/087
> +++ b/tests/qemu-iotests/087

[...]

> @@ -169,7 +169,62 @@ run_qemu <<EOF
>            "driver": "file",
>            "filename": "$TEST_IMG"
>        },
> -      "qcow-key-secret": "sec0"
> +      "aes-key-secret": "sec0"
> +    }
> +  }
> +{ "execute": "quit" }
> +EOF
> +
> +echo
> +echo =3D=3D=3D Encrypted image LUKS =3D=3D=3D
> +echo
> +
> +_make_test_img --object secret,id=3Dsec0,data=3D123456 -o encryption-f=
ormat=3Dluks,luks-key-secret=3Dsec0 $size
> +run_qemu -S <<EOF
> +{ "execute": "qmp_capabilities" }
> +{ "execute": "object-add",
> +  "arguments": {
> +      "qom-type": "secret",
> +      "id": "sec0",
> +      "props": {
> +          "data": "123456"
> +      }
> +  }
> +}
> +{ "execute": "blockdev-add",
> +  "arguments": {
> +      "driver": "$IMGFMT",
> +      "node-name": "disk",
> +      "file": {
> +          "driver": "file",
> +          "filename": "$TEST_IMG"
> +      },
> +      "luks-key-secret": "sec0"
> +    }
> +  }
> +{ "execute": "quit" }
> +EOF
> +
> +run_qemu <<EOF

I think we can drop one of the duplicated test cases with and without -S
now. The reason for having two originally was, as far as I can remember,
to test that you could blockdev-add encrypted images when the VM was not
paused. However, that is no longer the case since we are no longer
relying on that old infrastructure (as of this series at least).

> +{ "execute": "qmp_capabilities" }
> +{ "execute": "object-add",
> +  "arguments": {
> +      "qom-type": "secret",
> +      "id": "sec0",
> +      "props": {
> +          "data": "123456"
> +      }
> +  }
> +}
> +{ "execute": "blockdev-add",
> +  "arguments": {
> +      "driver": "$IMGFMT",
> +      "node-name": "disk",
> +      "file": {
> +          "driver": "file",
> +          "filename": "$TEST_IMG"
> +      },
> +      "luks-key-secret": "sec0"
>      }
>    }
>  { "execute": "quit" }

[...]

> diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
> new file mode 100755
> index 0000000..27d4870
> --- /dev/null
> +++ b/tests/qemu-iotests/174
> @@ -0,0 +1,76 @@
> +#!/bin/bash
> +#
> +# Test encrypted read/write using plain bdrv_read/bdrv_write
> +#
> +# Copyright (C) 2015 Red Hat, Inc.

*2017

> +#
> +# This program is free software; you can redistribute it and/or modify=

> +# it under the terms of the GNU General Public License as published by=

> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>=
=2E
> +#
> +
> +# creator
> +owner=3Dberrange@redhat.com
> +
> +seq=3D`basename $0`
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +status=3D1	# failure is the default!
> +
> +_cleanup()
> +{
> +	_cleanup_test_img
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +
> +_supported_fmt qcow2
> +_supported_proto generic
> +_supported_os Linux
> +
> +
> +size=3D128M
> +
> +SECRET=3D"secret,id=3Dsec0,data=3Dastrochicken"
> +SECRETALT=3D"secret,id=3Dsec0,data=3Dplatypus"
> +
> +_make_test_img --object $SECRET -o "encryption-format=3Dluks,luks-key-=
secret=3Dsec0" $size
> +
> +IMGSPEC=3D"driver=3D$IMGFMT,file.filename=3D$TEST_IMG,luks-key-secret=3D=
sec0"
> +
> +QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
> +
> +echo
> +echo "=3D=3D reading whole image =3D=3D"
> +$QEMU_IO --object $SECRET -c "read 0 $size" --image-opts $IMGSPEC | _f=
ilter_qemu_io | _filter_testdir

Shouldn't "read -P 0 0 $size" work here, too?

> +
> +echo
> +echo "=3D=3D rewriting whole image =3D=3D"
> +$QEMU_IO --object $SECRET -c "write -P 0xa 0 $size" --image-opts $IMGS=
PEC | _filter_qemu_io | _filter_testdir
> +
> +echo
> +echo "=3D=3D verify pattern =3D=3D"
> +$QEMU_IO --object $SECRET -c "read -P 0xa 0 $size"  --image-opts $IMGS=
PEC | _filter_qemu_io | _filter_testdir

But do you really want to read and write 128 MB...? I mean, even on an
HDD, it will only take a couple of seconds at most, but won't 16 or 32
MB suffice? That way, it should always take less than a second.

> +
> +echo
> +echo "=3D=3D verify pattern failure with wrong password =3D=3D"
> +$QEMU_IO --object $SECRETALT -c "read -P 0xa 0 $size" --image-opts $IM=
GSPEC | _filter_qemu_io | _filter_testdir
> +
> +
> +# success, all done
> +echo "*** done"
> +rm -f $seq.full
> +status=3D0
> diff --git a/tests/qemu-iotests/174.out b/tests/qemu-iotests/174.out
> new file mode 100644
> index 0000000..c96d0e4
> --- /dev/null
> +++ b/tests/qemu-iotests/174.out
> @@ -0,0 +1,19 @@
> +QA output created by 174
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encrypti=
on-format=3Dluks luks-key-secret=3Dsec0
> +
> +=3D=3D reading whole image =3D=3D
> +read 134217728/134217728 bytes at offset 0
> +128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +=3D=3D rewriting whole image =3D=3D
> +wrote 134217728/134217728 bytes at offset 0
> +128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +=3D=3D verify pattern =3D=3D
> +read 134217728/134217728 bytes at offset 0
> +128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +=3D=3D verify pattern failure with wrong password =3D=3D
> +can't open: Invalid password, cannot unlock any keyslot

Well, that's not quite a pattern failure. It's the result we want, but
you should probably change the heading for this test case.

> +no file open, try 'help open'
> +*** done
> diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
> new file mode 100755
> index 0000000..f8a629d
> --- /dev/null
> +++ b/tests/qemu-iotests/175
> @@ -0,0 +1,85 @@
> +#!/bin/bash
> +#
> +# Test encrypted read/write using backing files
> +#
> +# Copyright (C) 2015 Red Hat, Inc.

*2017

> +#
> +# This program is free software; you can redistribute it and/or modify=

> +# it under the terms of the GNU General Public License as published by=

> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>=
=2E
> +#
> +
> +# creator
> +owner=3Dberrange@redhat.com
> +
> +seq=3D`basename $0`
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +status=3D1	# failure is the default!
> +
> +_cleanup()
> +{
> +	_cleanup_test_img
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +
> +_supported_fmt qcow2
> +_supported_proto generic
> +_supported_os Linux
> +
> +
> +size=3D128M

Same as in last test, I'm not sure 128 MB are actually necessary.

> +TEST_IMG_BASE=3D$TEST_IMG.base

Hmmm, does this work with spaces in $TEST_IMG?

> +SECRET=3D"secret,id=3Dsec0,data=3Dastrochicken"

How about using different secrets for the base and the overlay?

Max


--1Bj5EWWxRfbKmh6g3Lko5vGc0APTKoQpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliDrykSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ae3YH/0vJlni38tujh1A53qmM1kPs33uqqvY9
kSvi/Hs9AUubITGdShH+88yaKU6hb9zAFQ905IJaO5Cs+LdTKYTGFTu4dcMKSXQt
MiEX8CgFI+aNXKRdz83Zap1w/QCKnc6ZsfpV4BJYTt6Krumy8UVMg/1+3AhGHweO
4fSPndZESyPLwvGKRLsdB39YW5kU70cr1GikKTQ7vqeurR/qBdI0zV6IXbAP2Raq
44lDbx5gEjkvwyMI/sfsLNpz7fhs/QDwKc7LlXsG8DaWsuO0Krn/DFNR21FxuwuF
aWfmDullBz7nBQagjgtTfPleCb0orxvVWg4l1khSSCUAHHEYi2/Iv58=
=lfUA
-----END PGP SIGNATURE-----

--1Bj5EWWxRfbKmh6g3Lko5vGc0APTKoQpF--
