Received: from eggs.gnu.org ([2001:4830:134:3::10]:58893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWMuu-0004gN-08
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:52:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWMut-0001AZ-3G
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:52:15 -0500
Date: Mon, 10 Dec 2018 14:52:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181210145203.GM20272@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181207161351.4380-1-vsementsov@virtuozzo.com>
	<20181207161351.4380-6-vsementsov@virtuozzo.com>
	<w514lbllblo.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w514lbllblo.fsf@maestria.local.igalia.com>
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
To: Alberto Garcia <berto@igalia.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On Mon, Dec 10, 2018 at 03:06:59PM +0100, Alberto Garcia wrote:
> On Fri 07 Dec 2018 05:13:51 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> > @@ -148,12 +154,97 @@ int qcrypto_block_encrypt(QCryptoBlock *block,
> >  
> >  QCryptoCipher *qcrypto_block_get_cipher(QCryptoBlock *block)
> >  {
> > -    return block->cipher;
> > +    /* Ciphers should be accessed through pop/push method to be thread-safe.
> > +     * Better, they should not be accessed externally at all (note, that
> > +     * pop/push are static functions)
> > +     * This function is used only in test with one thread (it's safe to skip
> > +     * pop/push interface), so it's enough to assert it here:
> > +     */
> > +    assert(block->n_ciphers <= 1);
> > +    return block->ciphers ? block->ciphers[0] : NULL;
> 
> If this is only supposed to be called in test mode I think you can also
> assert that g_test_initialized() is true.
> 
> And the same with qcrypto_block_get_ivgen() later in this patch.

I consider these APIs as being valid for use anywhere - it just
happens it is only used in the tests right now. So I think it is
ok to assert on n_cipers here.

> > +int qcrypto_block_init_cipher(QCryptoBlock *block,
> > +                              QCryptoCipherAlgorithm alg,
> > +                              QCryptoCipherMode mode,
> > +                              const uint8_t *key, size_t nkey,
> > +                              size_t n_threads, Error **errp)
> > +{
> > +    size_t i;
> > +
> > +    assert(!block->ciphers && !block->n_ciphers && !block->n_free_ciphers);
> > +
> > +    block->ciphers = g_new0(QCryptoCipher *, n_threads);
> 
> You can use g_new() instead of g_new0() because you're anyway
> overwriting all elements of the array.

I'd rather have it initialized to zero upfront, so if creating any
cipher in the array fails, we don't have uninitialized array elements
during later cleanup code.

> But these are minor nits, the patchs looks good to me else.
> 
> Reviewed-by: Alberto Garcia <berto@igalia.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
