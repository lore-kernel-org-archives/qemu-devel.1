Received: from eggs.gnu.org ([209.51.188.92]:58566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gpL09-0002ks-Lm
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:40:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gpL05-00076U-S8
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:40:05 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:45868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1gpL05-00076I-JZ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:40:01 -0500
Received: by mail-vk1-f193.google.com with SMTP id n126so1129114vke.12
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 14:40:01 -0800 (PST)
MIME-Version: 1.0
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-11-kwolf@redhat.com>
In-Reply-To: <20190131175549.11691-11-kwolf@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Fri, 1 Feb 2019 00:39:47 +0200
Message-ID: <CAMRbyyuzFfRgRLiKthXNXvnZ1fBbh=x-=F+xUYQDp+EbT2go6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH 10/11] qcow2: Store data file name in
 the image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Thu, Jan 31, 2019 at 8:20 PM Kevin Wolf <kwolf@redhat.com> wrote:

> Rather than requiring that the external data file node is passed
> explicitly when creating the qcow2 node, store the filename in the
> designated header extension during .bdrv_create and read it from there
> as a default during .bdrv_open.
>

If the data file is the backing file, we don't need this change.



>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.h              |  1 +
>  block/qcow2.c              | 69 +++++++++++++++++++++++++++++++++++++-
>  tests/qemu-iotests/082.out | 27 +++++++++++++++
>  3 files changed, 96 insertions(+), 1 deletion(-)
>
> diff --git a/block/qcow2.h b/block/qcow2.h
> index e2114900b4..a1e2600643 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -341,6 +341,7 @@ typedef struct BDRVQcow2State {
>       * override) */
>      char *image_backing_file;
>      char *image_backing_format;
> +    char *image_data_file;
>
>      CoQueue compress_wait_queue;
>      int nb_compress_threads;
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 6cf862e8b9..4959bf16a4 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -398,6 +398,20 @@ static int qcow2_read_extensions(BlockDriverState
> *bs, uint64_t start_offset,
>  #endif
>              break;
>
> +        case QCOW2_EXT_MAGIC_DATA_FILE:
> +        {
> +            s->image_data_file = g_malloc0(ext.len + 1);
> +            ret = bdrv_pread(bs->file, offset, s->image_data_file,
> ext.len);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret, "ERROR: Could not data file
> name");
> +                return ret;
> +            }
> +#ifdef DEBUG_EXT
> +            printf("Qcow2: Got external data file %s\n",
> s->image_data_file);
> +#endif
> +            break;
> +        }
> +
>          default:
>              /* unknown magic - save it in case we need to rewrite the
> header */
>              /* If you add a new feature, make sure to also update the fast
> @@ -1444,7 +1458,18 @@ static int coroutine_fn
> qcow2_do_open(BlockDriverState *bs, QDict *options,
>      /* Open external data file */
>      if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
>          s->data_file = bdrv_open_child(NULL, options, "data-file", bs,
> -                                       &child_file, false, errp);
> +                                       &child_file, false, &local_err);
> +        if (!s->data_file) {
> +            if (s->image_data_file) {
> +                error_free(local_err);
> +                local_err = NULL;
> +                s->data_file = bdrv_open_child(s->image_data_file,
> options,
> +                                               "data-file", bs,
> &child_file,
> +                                               false, errp);
> +            } else {
> +                error_propagate(errp, local_err);
> +            }
> +        }
>          if (!s->data_file) {
>              ret = -EINVAL;
>              goto fail;
> @@ -1627,6 +1652,7 @@ static int coroutine_fn
> qcow2_do_open(BlockDriverState *bs, QDict *options,
>      return ret;
>
>   fail:
> +    g_free(s->image_data_file);
>      if (has_data_file(bs)) {
>          bdrv_unref_child(bs, s->data_file);
>      }
> @@ -2246,6 +2272,7 @@ static void qcow2_close(BlockDriverState *bs)
>      g_free(s->unknown_header_fields);
>      cleanup_unknown_header_ext(bs);
>
> +    g_free(s->image_data_file);
>      g_free(s->image_backing_file);
>      g_free(s->image_backing_format);
>
> @@ -2422,6 +2449,19 @@ int qcow2_update_header(BlockDriverState *bs)
>          buflen -= ret;
>      }
>
> +    /* External data file header extension */
> +    if (has_data_file(bs) && s->image_data_file) {
> +        ret = header_ext_add(buf, QCOW2_EXT_MAGIC_DATA_FILE,
> +                             s->image_data_file,
> strlen(s->image_data_file),
> +                             buflen);
> +        if (ret < 0) {
> +            goto fail;
> +        }
> +
> +        buf += ret;
> +        buflen -= ret;
> +    }
> +
>      /* Full disk encryption header pointer extension */
>      if (s->crypto_header.offset != 0) {
>          s->crypto_header.offset = cpu_to_be64(s->crypto_header.offset);
> @@ -3166,6 +3206,7 @@ static int coroutine_fn qcow2_co_create_opts(const
> char *filename, QemuOpts *opt
>      QDict *qdict;
>      Visitor *v;
>      BlockDriverState *bs = NULL;
> +    BlockDriverState *data_bs = NULL;
>      Error *local_err = NULL;
>      const char *val;
>      int ret;
> @@ -3229,6 +3270,26 @@ static int coroutine_fn qcow2_co_create_opts(const
> char *filename, QemuOpts *opt
>          goto finish;
>      }
>
> +    /* Create and open an external data file (protocol layer) */
> +    val = qdict_get_try_str(qdict, BLOCK_OPT_DATA_FILE);
> +    if (val) {
> +        ret = bdrv_create_file(val, opts, errp);
> +        if (ret < 0) {
> +            goto finish;
> +        }
> +
> +        data_bs = bdrv_open(val, NULL, NULL,
> +                            BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
> +                            errp);
> +        if (data_bs == NULL) {
> +            ret = -EIO;
> +            goto finish;
> +        }
> +
> +        qdict_del(qdict, BLOCK_OPT_DATA_FILE);
> +        qdict_put_str(qdict, "data-file", data_bs->node_name);
> +    }
> +
>      /* Set 'driver' and 'node' options */
>      qdict_put_str(qdict, "driver", "qcow2");
>      qdict_put_str(qdict, "file", bs->node_name);
> @@ -3263,6 +3324,7 @@ static int coroutine_fn qcow2_co_create_opts(const
> char *filename, QemuOpts *opt
>  finish:
>      qobject_unref(qdict);
>      bdrv_unref(bs);
> +    bdrv_unref(data_bs);
>      qapi_free_BlockdevCreateOptions(create_options);
>      return ret;
>  }
> @@ -4943,6 +5005,11 @@ static QemuOptsList qcow2_create_opts = {
>              .type = QEMU_OPT_STRING,
>              .help = "Image format of the base image"
>          },
> +        {
> +            .name = BLOCK_OPT_DATA_FILE,
> +            .type = QEMU_OPT_STRING,
> +            .help = "File name of an external data file"
> +        },
>          {
>              .name = BLOCK_OPT_ENCRYPT,
>              .type = QEMU_OPT_BOOL,
> diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
> index 0ce18c075b..7dc59f6075 100644
> --- a/tests/qemu-iotests/082.out
> +++ b/tests/qemu-iotests/082.out
> @@ -48,6 +48,7 @@ Supported options:
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -69,6 +70,7 @@ Supported options:
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -90,6 +92,7 @@ Supported options:
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -111,6 +114,7 @@ Supported options:
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -132,6 +136,7 @@ Supported options:
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -153,6 +158,7 @@ Supported options:
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -174,6 +180,7 @@ Supported options:
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -195,6 +202,7 @@ Supported options:
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -231,6 +239,7 @@ Supported options:
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -304,6 +313,7 @@ Supported options:
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -325,6 +335,7 @@ Supported options:
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -346,6 +357,7 @@ Supported options:
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -367,6 +379,7 @@ Supported options:
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -388,6 +401,7 @@ Supported options:
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -409,6 +423,7 @@ Supported options:
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -430,6 +445,7 @@ Supported options:
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -451,6 +467,7 @@ Supported options:
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -487,6 +504,7 @@ Supported options:
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -568,6 +586,7 @@ Creation options for 'qcow2':
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -590,6 +609,7 @@ Creation options for 'qcow2':
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -612,6 +632,7 @@ Creation options for 'qcow2':
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -634,6 +655,7 @@ Creation options for 'qcow2':
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -656,6 +678,7 @@ Creation options for 'qcow2':
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -678,6 +701,7 @@ Creation options for 'qcow2':
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -700,6 +724,7 @@ Creation options for 'qcow2':
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -722,6 +747,7 @@ Creation options for 'qcow2':
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> @@ -761,6 +787,7 @@ Creation options for 'qcow2':
>    backing_fmt=<str>      - Image format of the base image
>    cluster_size=<size>    - qcow2 cluster size
>    compat=<str>           - Compatibility level (0.10 or 1.1)
> +  data_file=<str>        - File name of an external data file
>    encrypt.cipher-alg=<str> - Name of encryption cipher algorithm
>    encrypt.cipher-mode=<str> - Name of encryption cipher mode
>    encrypt.format=<str>   - Encrypt the image, format choices: 'aes',
> 'luks'
> --
> 2.20.1
>
>
>
