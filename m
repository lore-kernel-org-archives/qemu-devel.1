Received: from eggs.gnu.org ([2001:4830:134:3::10]:35992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gWNBm-00075q-LZ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gWNBj-000744-BM
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:09:42 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181210145203.GM20272@redhat.com>
References: <20181207161351.4380-1-vsementsov@virtuozzo.com>
	<20181207161351.4380-6-vsementsov@virtuozzo.com>
	<w514lbllblo.fsf@maestria.local.igalia.com>
	<20181210145203.GM20272@redhat.com>
Date: Mon, 10 Dec 2018 16:09:31 +0100
Message-ID: <w511s6pl8pg.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On Mon 10 Dec 2018 03:52:03 PM CET, Daniel P. Berrang=C3=A9 wrote:
>> > +int qcrypto_block_init_cipher(QCryptoBlock *block,
>> > +                              QCryptoCipherAlgorithm alg,
>> > +                              QCryptoCipherMode mode,
>> > +                              const uint8_t *key, size_t nkey,
>> > +                              size_t n_threads, Error **errp)
>> > +{
>> > +    size_t i;
>> > +
>> > +    assert(!block->ciphers && !block->n_ciphers && !block->n_free_cip=
hers);
>> > +
>> > +    block->ciphers =3D g_new0(QCryptoCipher *, n_threads);
>>=20
>> You can use g_new() instead of g_new0() because you're anyway
>> overwriting all elements of the array.
>
> I'd rather have it initialized to zero upfront, so if creating any
> cipher in the array fails, we don't have uninitialized array elements
> during later cleanup code.

But it is the value of block->n_ciphers that determines the size of the
array, and that is only incremented after each successful iteration:

  for (i =3D 0; i < n_threads; i++) {
      block->ciphers[i] =3D qcrypto_cipher_new(alg, mode, key, nkey, errp);
      /* ... error handling ... */
      block->n_ciphers++;
      block->n_free_ciphers++;
  }

In other words, the cleanup code won't touch uninitialized elements
because it cannot even tell the difference between an index that points
to an uninitialized element of the array and an index that points beyond
the allocated memory.

Berto
