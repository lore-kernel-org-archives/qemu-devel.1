Received: from eggs.gnu.org ([2001:4830:134:3::10]:48854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gWMDH-0002ml-Sq
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:07:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gWMDB-0007EV-Vb
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:07:11 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181207161351.4380-6-vsementsov@virtuozzo.com>
References: <20181207161351.4380-1-vsementsov@virtuozzo.com>
	<20181207161351.4380-6-vsementsov@virtuozzo.com>
Date: Mon, 10 Dec 2018 15:06:59 +0100
Message-ID: <w514lbllblo.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 5/5] crypto: support multiple threads
 accessing one QCryptoBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On Fri 07 Dec 2018 05:13:51 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> @@ -148,12 +154,97 @@ int qcrypto_block_encrypt(QCryptoBlock *block,
>  
>  QCryptoCipher *qcrypto_block_get_cipher(QCryptoBlock *block)
>  {
> -    return block->cipher;
> +    /* Ciphers should be accessed through pop/push method to be thread-safe.
> +     * Better, they should not be accessed externally at all (note, that
> +     * pop/push are static functions)
> +     * This function is used only in test with one thread (it's safe to skip
> +     * pop/push interface), so it's enough to assert it here:
> +     */
> +    assert(block->n_ciphers <= 1);
> +    return block->ciphers ? block->ciphers[0] : NULL;

If this is only supposed to be called in test mode I think you can also
assert that g_test_initialized() is true.

And the same with qcrypto_block_get_ivgen() later in this patch.

> +int qcrypto_block_init_cipher(QCryptoBlock *block,
> +                              QCryptoCipherAlgorithm alg,
> +                              QCryptoCipherMode mode,
> +                              const uint8_t *key, size_t nkey,
> +                              size_t n_threads, Error **errp)
> +{
> +    size_t i;
> +
> +    assert(!block->ciphers && !block->n_ciphers && !block->n_free_ciphers);
> +
> +    block->ciphers = g_new0(QCryptoCipher *, n_threads);

You can use g_new() instead of g_new0() because you're anyway
overwriting all elements of the array.

But these are minor nits, the patchs looks good to me else.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
