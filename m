Received: from eggs.gnu.org ([2001:4830:134:3::10]:38926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOL2y-0000bF-92
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOL2t-0000UA-S9
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:43:08 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:34334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fOL2t-0000TT-9j
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:43:03 -0400
Received: by mail-wm0-x232.google.com with SMTP id q4-v6so2327063wmq.1
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 03:43:02 -0700 (PDT)
References: <1526945967-9687-1-git-send-email-cota@braap.org>
	<1526945967-9687-3-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1526945967-9687-3-git-send-email-cota@braap.org>
Date: Thu, 31 May 2018 11:43:00 +0100
Message-ID: <87603414y3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 02/17] qht: return existing entry when
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
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>


Emilio G. Cota <cota@braap.org> writes:

> The meaning of "existing" is now changed to "matches in hash and
> ht->cmp result". This is saner than just checking the pointer value.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by:  Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/qemu/qht.h        |  7 +++++--
>  accel/tcg/translate-all.c |  2 +-
>  tests/qht-bench.c         |  4 ++--
>  tests/test-qht.c          |  8 +++++++-
>  util/qht.c                | 27 +++++++++++++++++----------
>  5 files changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/include/qemu/qht.h b/include/qemu/qht.h
> index 5f03a0f..1fb9116 100644
> --- a/include/qemu/qht.h
> +++ b/include/qemu/qht.h
> @@ -70,6 +70,7 @@ void qht_destroy(struct qht *ht);
>   * @ht: QHT to insert to
>   * @p: pointer to be inserted
>   * @hash: hash corresponding to @p
> + * @existing: address where the pointer to an existing entry can be copi=
ed to
>   *
>   * Attempting to insert a NULL @p is a bug.
>   * Inserting the same pointer @p with different @hash values is a bug.
> @@ -78,9 +79,11 @@ void qht_destroy(struct qht *ht);
>   * inserted into the hash table.
>   *
>   * Returns true on success.
> - * Returns false if the @p-@hash pair already exists in the hash table.
> + * Returns false if there is an existing entry in the table that is equi=
valent
> + * (i.e. ht->cmp matches and the hash is the same) to @p-@h. If @existing
> + * is !NULL, a pointer to this existing entry is copied to it.
>   */
> -bool qht_insert(struct qht *ht, void *p, uint32_t hash);
> +bool qht_insert(struct qht *ht, void *p, uint32_t hash, void **existing);
>
>  /**
>   * qht_lookup_custom - Look up a pointer using a custom comparison funct=
ion.
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 5b7b91d..8080eb7 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1242,7 +1242,7 @@ static void tb_link_page(TranslationBlock *tb, tb_p=
age_addr_t phys_pc,
>      /* add in the hash table */
>      h =3D tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_=
MASK,
>                       tb->trace_vcpu_dstate);
> -    qht_insert(&tb_ctx.htable, tb, h);
> +    qht_insert(&tb_ctx.htable, tb, h, NULL);
>
>  #ifdef CONFIG_USER_ONLY
>      if (DEBUG_TB_CHECK_GATE) {
> diff --git a/tests/qht-bench.c b/tests/qht-bench.c
> index c94ac25..f492b3a 100644
> --- a/tests/qht-bench.c
> +++ b/tests/qht-bench.c
> @@ -163,7 +163,7 @@ static void do_rw(struct thread_info *info)
>              bool written =3D false;
>
>              if (qht_lookup(&ht, p, hash) =3D=3D NULL) {
> -                written =3D qht_insert(&ht, p, hash);
> +                written =3D qht_insert(&ht, p, hash, NULL);
>              }
>              if (written) {
>                  stats->in++;
> @@ -322,7 +322,7 @@ static void htable_init(void)
>              r =3D xorshift64star(r);
>              p =3D &keys[r & (init_range - 1)];
>              hash =3D h(*p);
> -            if (qht_insert(&ht, p, hash)) {
> +            if (qht_insert(&ht, p, hash, NULL)) {
>                  break;
>              }
>              retries++;
> diff --git a/tests/test-qht.c b/tests/test-qht.c
> index b069881..dda6a06 100644
> --- a/tests/test-qht.c
> +++ b/tests/test-qht.c
> @@ -27,11 +27,17 @@ static void insert(int a, int b)
>
>      for (i =3D a; i < b; i++) {
>          uint32_t hash;
> +        void *existing;
> +        bool inserted;
>
>          arr[i] =3D i;
>          hash =3D i;
>
> -        qht_insert(&ht, &arr[i], hash);
> +        inserted =3D qht_insert(&ht, &arr[i], hash, NULL);
> +        g_assert_true(inserted);
> +        inserted =3D qht_insert(&ht, &arr[i], hash, &existing);
> +        g_assert_false(inserted);
> +        g_assert_true(existing =3D=3D &arr[i]);
>      }
>  }
>
> diff --git a/util/qht.c b/util/qht.c
> index 8610ce3..9d030e7 100644
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
> @@ -577,25 +578,31 @@ static __attribute__((noinline)) void qht_grow_mayb=
e(struct qht *ht)
>      qemu_mutex_unlock(&ht->lock);
>  }
>
> -bool qht_insert(struct qht *ht, void *p, uint32_t hash)
> +bool qht_insert(struct qht *ht, void *p, uint32_t hash, void **existing)
>  {
>      struct qht_bucket *b;
>      struct qht_map *map;
>      bool needs_resize =3D false;
> -    bool ret;
> +    void *prev;
>
>      /* NULL pointers are not supported */
>      qht_debug_assert(p);
>
>      b =3D qht_bucket_lock__no_stale(ht, hash, &map);
> -    ret =3D qht_insert__locked(ht, map, b, p, hash, &needs_resize);
> +    prev =3D qht_insert__locked(ht, map, b, p, hash, &needs_resize);
>      qht_bucket_debug__locked(b);
>      qemu_spin_unlock(&b->lock);
>
>      if (unlikely(needs_resize) && ht->mode & QHT_MODE_AUTO_RESIZE) {
>          qht_grow_maybe(ht);
>      }
> -    return ret;
> +    if (likely(prev =3D=3D NULL)) {
> +        return true;
> +    }
> +    if (existing) {
> +        *existing =3D prev;
> +    }
> +    return false;
>  }
>
>  static inline bool qht_entry_is_last(struct qht_bucket *b, int pos)


--
Alex Benn=C3=A9e
