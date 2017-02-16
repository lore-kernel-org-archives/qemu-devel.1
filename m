Received: from eggs.gnu.org ([2001:4830:134:3::10]:36932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ceMK4-0006HP-9U
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ceMJz-0003C6-Hu
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:42:12 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170210170910.8867-14-berrange@redhat.com>
References: <20170210170910.8867-1-berrange@redhat.com>
	<20170210170910.8867-14-berrange@redhat.com>
Date: Thu, 16 Feb 2017 14:42:04 +0100
Message-ID: <w5160kackwj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 13/18] qcow2: add support for LUKS
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri 10 Feb 2017 06:09:05 PM CET, Daniel P. Berrange wrote:
> @@ -990,12 +1123,6 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
>      s->refcount_max = UINT64_C(1) << (s->refcount_bits - 1);
>      s->refcount_max += s->refcount_max - 1;
>  
> -    if (header.crypt_method > QCOW_CRYPT_AES) {
> -        error_setg(errp, "Unsupported encryption method: %" PRIu32,
> -                   header.crypt_method);
> -        ret = -EINVAL;
> -        goto fail;
> -    }

Here you remove the check for a valid encryption method...

>      s->crypt_method_header = header.crypt_method;
>      if (s->crypt_method_header) {
>          if (bdrv_uses_whitelist() &&
> @@ -1012,6 +1139,12 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
>              goto fail;
>          }
>  
> +        if (s->crypt_method_header == QCOW_CRYPT_AES) {
> +            s->crypt_physical_offset = false;
> +        } else {
> +            s->crypt_physical_offset = true;
> +        }
> +

...and here you assume that if it's not AES then it must be LUKS.
However at this point crypt_method_header hasn't been verified yet and
can have any value.

The image will fail to open anyway because of the qcow2_update_options()
call later in this function, but I think it wouldn't hurt to have an
explicit check here, or at least an explanatory comment.

> +static int qcow2_crypt_method_from_format(const char *format)
> +{
> +    if (g_str_equal(format, "luks")) {
> +        return QCOW_CRYPT_LUKS;
> +    } else if (g_str_equal(format, "aes")) {
> +        return QCOW_CRYPT_AES;
> +    } else {
> +        return -EINVAL;
> +    }
> +}
>  
>  static int qcow2_set_up_encryption(BlockDriverState *bs, QemuOpts *opts,
> -                                   Error **errp)
> +                                   const char *format, Error **errp)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      QCryptoBlockCreateOptions *cryptoopts = NULL;
>      QCryptoBlock *crypto = NULL;
>      int ret = -EINVAL;
>  
> -    cryptoopts = block_crypto_create_opts_init(
> -        Q_CRYPTO_BLOCK_FORMAT_QCOW, opts, "aes-", errp);
> +    if (g_str_equal(format, "luks")) {
> +        cryptoopts = block_crypto_create_opts_init(
> +            Q_CRYPTO_BLOCK_FORMAT_LUKS, opts, "luks-", errp);
> +        s->crypt_method_header = QCOW_CRYPT_LUKS;
> +    } else if (g_str_equal(format, "aes")) {
> +        cryptoopts = block_crypto_create_opts_init(
> +            Q_CRYPTO_BLOCK_FORMAT_QCOW, opts, "aes-", errp);
> +        s->crypt_method_header = QCOW_CRYPT_AES;
> +    } else {

You just added a nice qcow2_crypt_method_from_format() function
immediately before this one, I think this one would be more readable if
you use it here.

Berto
