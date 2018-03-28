Received: from eggs.gnu.org ([2001:4830:134:3::10]:42715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1E0i-0004bX-ER
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 12:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1E0e-0005Z5-4c
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 12:33:16 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:40138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f1E0d-0005YP-Ph
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 12:33:12 -0400
Received: by mail-wr0-x243.google.com with SMTP id z8so2833731wrh.7
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 09:33:11 -0700 (PDT)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-3-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1519709965-29833-3-git-send-email-cota@braap.org>
Date: Wed, 28 Mar 2018 17:33:09 +0100
Message-ID: <87605g88je.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/16] qht: return existing entry when
 qht_insert fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> The meaning of "existing" is now changed to "matches in hash and
> ht->cmp result". This is saner than just checking the pointer value.
>
> Note that we now return NULL on insertion success, or the existing
> pointer on failure. We can do this because NULL pointers are not
> allowed to be inserted in QHT.
>
> Suggested-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qemu/qht.h |  7 ++++---
>  tests/qht-bench.c  |  4 ++--
>  tests/test-qht.c   |  5 ++++-
>  util/qht.c         | 17 +++++++++--------
>  4 files changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/include/qemu/qht.h b/include/qemu/qht.h
> index dd512bf..c320cb6 100644
> --- a/include/qemu/qht.h
> +++ b/include/qemu/qht.h
> @@ -77,10 +77,11 @@ void qht_destroy(struct qht *ht);
>   * In case of successful operation, smp_wmb() is implied before the poin=
ter is
>   * inserted into the hash table.
>   *
> - * Returns true on success.
> - * Returns false if the @p-@hash pair already exists in the hash table.
> + * On success, returns NULL.
> + * On failure, returns the pointer from an entry that is equivalent (i.e.
> + * ht->cmp matches and the hash is the same) to @p-@h.
>   */
> -bool qht_insert(struct qht *ht, void *p, uint32_t hash);
> +void *qht_insert(struct qht *ht, void *p, uint32_t hash);

Hmm this seems needlessly counter intuitive. I realise the potential
efficiency in overloading success/fail but wouldn't a:

  bool qht_insert(struct qht *ht, void *p, uint32_t hash, void **existing);

be conceptually nicer?

>
>  /**
>   * qht_lookup_custom - Look up a pointer using a custom comparison funct=
ion.
> diff --git a/tests/qht-bench.c b/tests/qht-bench.c
> index c94ac25..2f88400 100644
> --- a/tests/qht-bench.c
> +++ b/tests/qht-bench.c
> @@ -163,7 +163,7 @@ static void do_rw(struct thread_info *info)
>              bool written =3D false;
>
>              if (qht_lookup(&ht, p, hash) =3D=3D NULL) {
> -                written =3D qht_insert(&ht, p, hash);
> +                written =3D !qht_insert(&ht, p, hash);
>              }
>              if (written) {
>                  stats->in++;
> @@ -322,7 +322,7 @@ static void htable_init(void)
>              r =3D xorshift64star(r);
>              p =3D &keys[r & (init_range - 1)];
>              hash =3D h(*p);
> -            if (qht_insert(&ht, p, hash)) {
> +            if (qht_insert(&ht, p, hash) =3D=3D NULL) {
>                  break;
>              }
>              retries++;
> diff --git a/tests/test-qht.c b/tests/test-qht.c
> index f8f2886..7164ae4 100644
> --- a/tests/test-qht.c
> +++ b/tests/test-qht.c
> @@ -27,11 +27,14 @@ static void insert(int a, int b)
>
>      for (i =3D a; i < b; i++) {
>          uint32_t hash;
> +        void *existing;
>
>          arr[i] =3D i;
>          hash =3D i;
>
> -        qht_insert(&ht, &arr[i], hash);
> +        g_assert_true(!qht_insert(&ht, &arr[i], hash));
> +        existing =3D qht_insert(&ht, &arr[i], hash);
> +        g_assert_true(existing =3D=3D &arr[i]);
>      }
>  }
>
> diff --git a/util/qht.c b/util/qht.c
> index dcb3ee1..f9f49a9 100644
> --- a/util/qht.c
> +++ b/util/qht.c
> @@ -511,9 +511,9 @@ void *qht_lookup(struct qht *ht, const void *userp, u=
int32_t hash)
>  }
>
>  /* call with head->lock held */
> -static bool qht_insert__locked(struct qht *ht, struct qht_map *map,
> -                               struct qht_bucket *head, void *p, uint32_=
t hash,
> -                               bool *needs_resize)
> +static void *qht_insert__locked(struct qht *ht, struct qht_map *map,
> +                                struct qht_bucket *head, void *p, uint32=
_t hash,
> +                                bool *needs_resize)
>  {
>      struct qht_bucket *b =3D head;
>      struct qht_bucket *prev =3D NULL;
> @@ -523,8 +523,9 @@ static bool qht_insert__locked(struct qht *ht, struct=
 qht_map *map,
>      do {
>          for (i =3D 0; i < QHT_BUCKET_ENTRIES; i++) {
>              if (b->pointers[i]) {
> -                if (unlikely(b->pointers[i] =3D=3D p)) {
> -                    return false;
> +                if (unlikely(b->hashes[i] =3D=3D hash &&
> +                             ht->cmp(b->pointers[i], p))) {
> +                    return b->pointers[i];
>                  }
>              } else {
>                  goto found;
> @@ -553,7 +554,7 @@ static bool qht_insert__locked(struct qht *ht, struct=
 qht_map *map,
>      atomic_set(&b->hashes[i], hash);
>      atomic_set(&b->pointers[i], p);
>      seqlock_write_end(&head->sequence);
> -    return true;
> +    return NULL;
>  }
>
>  static __attribute__((noinline)) void qht_grow_maybe(struct qht *ht)
> @@ -577,12 +578,12 @@ static __attribute__((noinline)) void qht_grow_mayb=
e(struct qht *ht)
>      qemu_mutex_unlock(&ht->lock);
>  }
>
> -bool qht_insert(struct qht *ht, void *p, uint32_t hash)
> +void *qht_insert(struct qht *ht, void *p, uint32_t hash)
>  {
>      struct qht_bucket *b;
>      struct qht_map *map;
>      bool needs_resize =3D false;
> -    bool ret;
> +    void *ret;
>
>      /* NULL pointers are not supported */
>      qht_debug_assert(p);


--
Alex Benn=C3=A9e
