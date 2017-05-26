Received: from eggs.gnu.org ([2001:4830:134:3::10]:52961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dEDy8-0002jy-Uq
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dEDy5-0008Dd-Lg
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:03:48 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170525163851.8047-10-berrange@redhat.com>
References: <20170525163851.8047-1-berrange@redhat.com>
	<20170525163851.8047-10-berrange@redhat.com>
Date: Fri, 26 May 2017 14:03:40 +0200
Message-ID: <w51bmqflt9f.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 09/20] qcow: convert QCow to use
 QCryptoBlock for encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Thu 25 May 2017 06:38:40 PM CEST, Daniel P. Berrange wrote:
> @@ -105,6 +116,13 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
>      int ret;
>      QCowHeader header;
>      Error *local_err = NULL;
> +    QCryptoBlockOpenOptions *crypto_opts = NULL;
> +    unsigned int cflags = 0;
> +    QDict *encryptopts = NULL;
> +    const char *encryptfmt;
> +
> +    qdict_extract_subqdict(options, &encryptopts, "encrypt.");
> +    encryptfmt = qdict_get_try_str(encryptopts, "format");
>  
>      bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
>                                 false, errp);
>      if (!bs->file) {
>          return -EINVAL;
>      }

You're leaking encryptopts if the function returns here.

> @@ -873,6 +850,20 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
>              goto exit;
>          }
>          header.crypt_method = cpu_to_be32(QCOW_CRYPT_AES);
> +
> +        crypto_opts = block_crypto_create_opts_init(
> +            Q_CRYPTO_BLOCK_FORMAT_QCOW, encryptopts, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            ret = -EINVAL;
> +            goto exit;
> +        }

Not very important, and my fault for not having pointed it out in my
previous review, but you can spare the error_propagate() call if you
pass errp directly to block_crypto_create_opts_init() and then check if
crypto_opts is NULL.

Actually none of the error_propagate() calls in qcow_create() is really
necessary, but that could be fixed in a separate patch, if at all (it's
not so important).

The leak however needs to be fixed. With that,

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
