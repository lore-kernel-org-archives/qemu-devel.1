Received: from eggs.gnu.org ([2001:4830:134:3::10]:38396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMuqy-0005pH-2a
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:05:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMuqs-0007Jc-AO
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:05:06 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:44450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMuqq-0007G5-BC
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:05:02 -0500
Received: by mail-wr1-x431.google.com with SMTP id j17-v6so17179606wrq.11
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 05:04:59 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-5-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-5-cota@braap.org>
Date: Wed, 14 Nov 2018 13:04:56 +0000
Message-ID: <8736s3ernr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 04/48] exec: introduce qemu_xxhash{2, 4, 5, 6,
 7}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> Before moving them all to include/qemu/xxhash.h.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/tb-hash-xx.h | 41 +++++++++++++++++++++++++++++----------
>  include/exec/tb-hash.h    |  2 +-
>  tests/qht-bench.c         |  2 +-
>  util/qsp.c                | 12 ++++++------
>  4 files changed, 39 insertions(+), 18 deletions(-)
>
> diff --git a/include/exec/tb-hash-xx.h b/include/exec/tb-hash-xx.h
> index 747a9a612c..98ce4b628a 100644
> --- a/include/exec/tb-hash-xx.h
> +++ b/include/exec/tb-hash-xx.h
> @@ -42,23 +42,23 @@
>  #define PRIME32_4    668265263U
>  #define PRIME32_5    374761393U
>
> -#define TB_HASH_XX_SEED 1
> +#define QEMU_XXHASH_SEED 1
>
>  /*
>   * xxhash32, customized for input variables that are not guaranteed to be
>   * contiguous in memory.
>   */
>  static inline uint32_t
> -tb_hash_func7(uint64_t a0, uint64_t b0, uint32_t e, uint32_t f, uint32_t=
 g)
> +qemu_xxhash7(uint64_t ab, uint64_t cd, uint32_t e, uint32_t f, uint32_t =
g)
>  {
> -    uint32_t v1 =3D TB_HASH_XX_SEED + PRIME32_1 + PRIME32_2;
> -    uint32_t v2 =3D TB_HASH_XX_SEED + PRIME32_2;
> -    uint32_t v3 =3D TB_HASH_XX_SEED + 0;
> -    uint32_t v4 =3D TB_HASH_XX_SEED - PRIME32_1;
> -    uint32_t a =3D a0 >> 32;
> -    uint32_t b =3D a0;
> -    uint32_t c =3D b0 >> 32;
> -    uint32_t d =3D b0;
> +    uint32_t v1 =3D QEMU_XXHASH_SEED + PRIME32_1 + PRIME32_2;
> +    uint32_t v2 =3D QEMU_XXHASH_SEED + PRIME32_2;
> +    uint32_t v3 =3D QEMU_XXHASH_SEED + 0;
> +    uint32_t v4 =3D QEMU_XXHASH_SEED - PRIME32_1;
> +    uint32_t a =3D ab >> 32;
> +    uint32_t b =3D ab;
> +    uint32_t c =3D cd >> 32;
> +    uint32_t d =3D cd;
>      uint32_t h32;
>
>      v1 +=3D a * PRIME32_2;
> @@ -98,4 +98,25 @@ tb_hash_func7(uint64_t a0, uint64_t b0, uint32_t e, ui=
nt32_t f, uint32_t g)
>      return h32;
>  }
>
> +static inline uint32_t qemu_xxhash2(uint64_t ab)
> +{
> +    return qemu_xxhash7(ab, 0, 0, 0, 0);
> +}
> +
> +static inline uint32_t qemu_xxhash4(uint64_t ab, uint64_t cd)
> +{
> +    return qemu_xxhash7(ab, cd, 0, 0, 0);
> +}
> +
> +static inline uint32_t qemu_xxhash5(uint64_t ab, uint64_t cd, uint32_t e)
> +{
> +    return qemu_xxhash7(ab, cd, e, 0, 0);
> +}
> +
> +static inline uint32_t qemu_xxhash6(uint64_t ab, uint64_t cd, uint32_t e,
> +                                    uint32_t f)
> +{
> +    return qemu_xxhash7(ab, cd, e, f, 0);
> +}
> +
>  #endif /* EXEC_TB_HASH_XX_H */
> diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
> index 0526c4f678..731ba4c272 100644
> --- a/include/exec/tb-hash.h
> +++ b/include/exec/tb-hash.h
> @@ -61,7 +61,7 @@ static inline
>  uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t =
flags,
>                        uint32_t cf_mask, uint32_t trace_vcpu_dstate)
>  {
> -    return tb_hash_func7(phys_pc, pc, flags, cf_mask, trace_vcpu_dstate);
> +    return qemu_xxhash7(phys_pc, pc, flags, cf_mask, trace_vcpu_dstate);
>  }
>
>  #endif
> diff --git a/tests/qht-bench.c b/tests/qht-bench.c
> index 2089e2bed1..2ea132fe57 100644
> --- a/tests/qht-bench.c
> +++ b/tests/qht-bench.c
> @@ -104,7 +104,7 @@ static bool is_equal(const void *ap, const void *bp)
>
>  static uint32_t h(unsigned long v)
>  {
> -    return tb_hash_func7(v, 0, 0, 0, 0);
> +    return qemu_xxhash2(v);
>  }
>
>  static uint32_t hval(unsigned long v)
> diff --git a/util/qsp.c b/util/qsp.c
> index a848b09c6d..dc29c41fde 100644
> --- a/util/qsp.c
> +++ b/util/qsp.c
> @@ -135,13 +135,13 @@ QemuCondWaitFunc qemu_cond_wait_func =3D qemu_cond_=
wait_impl;
>   * without it we still get a pretty unique hash.
>   */
>  static inline
> -uint32_t do_qsp_callsite_hash(const QSPCallSite *callsite, uint64_t a)
> +uint32_t do_qsp_callsite_hash(const QSPCallSite *callsite, uint64_t ab)
>  {
> -    uint64_t b =3D (uint64_t)(uintptr_t)callsite->obj;
> +    uint64_t cd =3D (uint64_t)(uintptr_t)callsite->obj;
>      uint32_t e =3D callsite->line;
>      uint32_t f =3D callsite->type;
>
> -    return tb_hash_func7(a, b, e, f, 0);
> +    return qemu_xxhash6(ab, cd, e, f);
>  }
>
>  static inline
> @@ -169,11 +169,11 @@ static uint32_t qsp_entry_no_thread_hash(const QSPE=
ntry *entry)
>  static uint32_t qsp_entry_no_thread_obj_hash(const QSPEntry *entry)
>  {
>      const QSPCallSite *callsite =3D entry->callsite;
> -    uint64_t a =3D g_str_hash(callsite->file);
> -    uint64_t b =3D callsite->line;
> +    uint64_t ab =3D g_str_hash(callsite->file);
> +    uint64_t cd =3D callsite->line;
>      uint32_t e =3D callsite->type;
>
> -    return tb_hash_func7(a, b, e, 0, 0);
> +    return qemu_xxhash5(ab, cd, e);
>  }
>
>  static bool qsp_callsite_cmp(const void *ap, const void *bp)


--
Alex Benn=C3=A9e
