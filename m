Received: from eggs.gnu.org ([2001:4830:134:3::10]:55058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cgBBm-0007Q3-QF
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:13:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cgBBh-00032b-QL
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:13:10 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170221115512.21918-14-berrange@redhat.com>
References: <20170221115512.21918-1-berrange@redhat.com>
	<20170221115512.21918-14-berrange@redhat.com>
Date: Tue, 21 Feb 2017 15:13:03 +0100
Message-ID: <w51h93nbpjk.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 13/18] qcow2: add support for LUKS
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

On Tue 21 Feb 2017 12:55:07 PM CET, Daniel P. Berrange wrote:
>  static int qcow2_set_up_encryption(BlockDriverState *bs, QemuOpts *opts,
> -                                   Error **errp)
> +                                   const char *fmtstr, Error **errp)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      QCryptoBlockCreateOptions *cryptoopts = NULL;
>      QCryptoBlock *crypto = NULL;
>      int ret = -EINVAL;
> +    int fmt = qcow2_crypt_method_from_format(fmtstr);
>  
> -    cryptoopts = block_crypto_create_opts_init(
> -        Q_CRYPTO_BLOCK_FORMAT_QCOW, opts, "aes-", errp);
> +    switch (fmt) {
> +    case QCOW_CRYPT_LUKS:
> +        cryptoopts = block_crypto_create_opts_init(
> +            Q_CRYPTO_BLOCK_FORMAT_LUKS, opts, "luks-", errp);
> +        break;
> +    case QCOW_CRYPT_AES:
> +        cryptoopts = block_crypto_create_opts_init(
> +            Q_CRYPTO_BLOCK_FORMAT_QCOW, opts, "aes-", errp);
> +        break;
> +    default:
> +        error_setg(errp, "Unknown encryption format %s", fmtstr);
> +        break;
> +    }
> +    s->crypt_method_header = fmt;
>      if (!cryptoopts) {
>          ret = -EINVAL;
>          goto out;
>      }

I don't believe it has any practical effect in this case, but I think
it's cleaner to set s->crypt_method_header = fmt after checking that
everything went well. Otherwise an incorrect format string will result
in s->crypt_method_header = -EINVAL, which doesn't make sense (it's not
even the correct type: the variable is unsigned).

Other than that, the patch looks good to me.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
