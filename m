Received: from eggs.gnu.org ([2001:4830:134:3::10]:60890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ce0ae-0002Bu-26
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:29:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ce0aa-0003jY-Vz
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:29:52 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170210170910.8867-12-berrange@redhat.com>
References: <20170210170910.8867-1-berrange@redhat.com>
	<20170210170910.8867-12-berrange@redhat.com>
Date: Wed, 15 Feb 2017 15:29:09 +0100
Message-ID: <w51fujfr0i2.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 11/18] qcow2: convert QCow2 to use
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

On Fri 10 Feb 2017 06:09:03 PM CET, Daniel P. Berrange wrote:
> @@ -578,6 +582,7 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
>      }
>  }
>  
> +
>  typedef struct Qcow2ReopenState {
>      Qcow2Cache *l2_table_cache;
>      Qcow2Cache *refcount_block_cache;

I don't know if you wanted add that empty line up there...

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
> +        break;
> +    }
> +    if (s->crypt_method_header && !r->crypto_opts) {
> +        error_setg(errp, "Unsupported encryption method %d",
> +                   s->crypt_method_header);

You cannot set errp here, because it's already set earlier if
block_crypto_open_opts_init() fails.

Berto
