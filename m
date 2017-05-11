Received: from eggs.gnu.org ([2001:4830:134:3::10]:52930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d8ojK-0001KV-9S
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d8ojE-0006Hc-J4
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:06:10 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170425153858.25660-10-berrange@redhat.com>
References: <20170425153858.25660-1-berrange@redhat.com>
	<20170425153858.25660-10-berrange@redhat.com>
Date: Thu, 11 May 2017 16:05:59 +0200
Message-ID: <w51a86jtrnc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 09/18] qcow: convert QCow to use
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

On Tue 25 Apr 2017 05:38:49 PM CEST, Daniel P. Berrange wrote:
> @@ -181,8 +188,39 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
  [...]
> +            crypto_opts = block_crypto_open_opts_init(
> +                Q_CRYPTO_BLOCK_FORMAT_QCOW, encryptopts, &local_err);
> +            if (local_err) {
> +                error_propagate(errp, local_err);
> +                ret = -EINVAL;
> +                goto fail;
> +            }

Not very important, but if you check !crypto_opts for errors instead you
can pass errp directly and avoid that error_propagate() call. Exactly
the same that you do here in qcrypto_block_open():

> +            if (flags & BDRV_O_NO_IO) {
> +                cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
> +            }
> +            s->crypto = qcrypto_block_open(crypto_opts, NULL, NULL,
> +                                           cflags, errp);
> +            if (!s->crypto) {
> +                ret = -EINVAL;
> +                goto fail;
> +            }


> @@ -792,6 +762,10 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
>      int ret;
>      BlockBackend *qcow_blk;
>      const char *encryptfmt = NULL;
> +    QDict *options;
> +    QDict *encryptopts = NULL;
> +    QCryptoBlockCreateOptions *crypto_opts = NULL;
> +    QCryptoBlock *crypto = NULL;
>  
>      /* Read out options */
>      total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
> @@ -865,6 +839,10 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
>      l1_size = (total_size + (1LL << shift) - 1) >> shift;
>  
>      header.l1_table_offset = cpu_to_be64(header_size);
> +
> +    options = qemu_opts_to_qdict(opts, NULL);
> +    qdict_extract_subqdict(options, &encryptopts, "encrypt.");
> +    QDECREF(options);

I think you're leaking encryptopts in this function.

>  ##
> +# @BlockdevQcowEncryptionFormat:
> +# @qcow: AES-CBC with plain64 initialization venctors
> +#
> +# Since: 2.10
> +##
> +{ 'enum': 'BlockdevQcowEncryptionFormat',
> +  'data': [ 'qcow' ] }

Shouldn't this be 'aes' instead of 'qcow' ??

Berto
