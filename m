Received: from eggs.gnu.org ([2001:4830:134:3::10]:35240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cgAWH-00016p-TN
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cgAWD-000841-Aq
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:30:17 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170221115512.21918-12-berrange@redhat.com>
References: <20170221115512.21918-1-berrange@redhat.com>
	<20170221115512.21918-12-berrange@redhat.com>
Date: Tue, 21 Feb 2017 14:30:10 +0100
Message-ID: <w51mvdfbrj1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 11/18] qcow2: convert QCow2 to use
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue 21 Feb 2017 12:55:05 PM CET, Daniel P. Berrange wrote:
> +    switch (s->crypt_method_header) {
> +    case QCOW_CRYPT_NONE:
> +        break;
> +
> +    case QCOW_CRYPT_AES:
> +        r->crypto_opts = block_crypto_open_opts_init(
> +            Q_CRYPTO_BLOCK_FORMAT_QCOW, opts, "aes-", errp);
> +        break;
> +
> +    default:
> +        error_setg(errp, "Unsupported encryption method %d",
> +                   s->crypt_method_header);
> +        break;
> +    }
> +    if (s->crypt_method_header && !r->crypto_opts) {
> +        ret = -EINVAL;
> +        goto fail;
> +    }

This last condition relies on the assumption that QCOW_CRYPT_NONE == 0.

I think it's safe to assume that its value is never going to change and
therefore this isn't too important, but I'm just pointing it out in case
you want to make it explicit.

> @@ -1122,6 +1145,24 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
>          goto fail;
>      }
>  
> +    if (s->crypt_method_header == QCOW_CRYPT_AES) {
> +        unsigned int cflags = 0;
> +        if (flags & BDRV_O_NO_IO) {
> +            cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
> +        }
> +        /* TODO how do we pass the same crypto opts down to the
> +         * backing file by default, so we don't have to manually
> +         * provide the same key-secret property against the full
> +         * backing chain
> +         */
> +        s->crypto = qcrypto_block_open(s->crypto_opts, NULL, NULL,
> +                                       cflags, errp);
> +        if (!s->crypto) {
> +            ret = -EINVAL;
> +            goto fail;
> +        }
> +    }

Actually this has the same problem that I mentioned for patch 9: if
qcow2_open() fails then s->crypto is leaked.

Berto
