Received: from eggs.gnu.org ([209.51.188.92]:59301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hBDto-0004sP-Lm
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:32:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hBDtn-0006wc-A9
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:32:00 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hBDtl-0006dx-Co
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:31:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id j9so15209724wrn.6
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 00:31:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	z14sm14276796wrv.78.2019.04.02.00.31.51 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 02 Apr 2019 00:31:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id EFE591FF87
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 07:31:50 +0000 (UTC)
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190328230404.12909-2-richard.henderson@linaro.org>
Date: Tue, 02 Apr 2019 07:31:50 +0000
Message-ID: <87y34s6exl.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 01/36] tcg: Fold CPUTLBWindow
 into CPUTLBDesc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/cpu-defs.h | 17 ++++-------------
>  accel/tcg/cputlb.c      | 24 ++++++++++++------------
>  2 files changed, 16 insertions(+), 25 deletions(-)
>
> diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
> index 8f2a848bf5..52d150aaf1 100644
> --- a/include/exec/cpu-defs.h
> +++ b/include/exec/cpu-defs.h
> @@ -127,18 +127,6 @@ typedef struct CPUIOTLBEntry {
>      MemTxAttrs attrs;
>  } CPUIOTLBEntry;
>
> -/**
> - * struct CPUTLBWindow
> - * @begin_ns: host time (in ns) at the beginning of the time window
> - * @max_entries: maximum number of entries observed in the window
> - *
> - * See also: tlb_mmu_resize_locked()
> - */
> -typedef struct CPUTLBWindow {
> -    int64_t begin_ns;
> -    size_t max_entries;
> -} CPUTLBWindow;
> -
>  typedef struct CPUTLBDesc {
>      /*
>       * Describe a region covering all of the large pages allocated
> @@ -148,9 +136,12 @@ typedef struct CPUTLBDesc {
>       */
>      target_ulong large_page_addr;
>      target_ulong large_page_mask;
> +    /* host time (in ns) at the beginning of the time window */
> +    int64_t window_begin_ns;
> +    /* maximum number of entries observed in the window */
> +    size_t window_max_entries;
>      /* The next index to use in the tlb victim table.  */
>      size_t vindex;
> -    CPUTLBWindow window;
>      size_t n_used_entries;
>  } CPUTLBDesc;
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 88cc8389e9..23586f9974 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -79,11 +79,11 @@ static inline size_t sizeof_tlb(CPUArchState *env, ui=
ntptr_t mmu_idx)
>      return env->tlb_mask[mmu_idx] + (1 << CPU_TLB_ENTRY_BITS);
>  }
>
> -static void tlb_window_reset(CPUTLBWindow *window, int64_t ns,
> +static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
>                               size_t max_entries)
>  {
> -    window->begin_ns =3D ns;
> -    window->max_entries =3D max_entries;
> +    desc->window_begin_ns =3D ns;
> +    desc->window_max_entries =3D max_entries;
>  }
>
>  static void tlb_dyn_init(CPUArchState *env)
> @@ -94,7 +94,7 @@ static void tlb_dyn_init(CPUArchState *env)
>          CPUTLBDesc *desc =3D &env->tlb_d[i];
>          size_t n_entries =3D 1 << CPU_TLB_DYN_DEFAULT_BITS;
>
> -        tlb_window_reset(&desc->window, get_clock_realtime(), 0);
> +        tlb_window_reset(desc, get_clock_realtime(), 0);
>          desc->n_used_entries =3D 0;
>          env->tlb_mask[i] =3D (n_entries - 1) << CPU_TLB_ENTRY_BITS;
>          env->tlb_table[i] =3D g_new(CPUTLBEntry, n_entries);
> @@ -151,18 +151,18 @@ static void tlb_mmu_resize_locked(CPUArchState *env=
, int mmu_idx)
>      int64_t now =3D get_clock_realtime();
>      int64_t window_len_ms =3D 100;
>      int64_t window_len_ns =3D window_len_ms * 1000 * 1000;
> -    bool window_expired =3D now > desc->window.begin_ns + window_len_ns;
> +    bool window_expired =3D now > desc->window_begin_ns + window_len_ns;
>
> -    if (desc->n_used_entries > desc->window.max_entries) {
> -        desc->window.max_entries =3D desc->n_used_entries;
> +    if (desc->n_used_entries > desc->window_max_entries) {
> +        desc->window_max_entries =3D desc->n_used_entries;
>      }
> -    rate =3D desc->window.max_entries * 100 / old_size;
> +    rate =3D desc->window_max_entries * 100 / old_size;
>
>      if (rate > 70) {
>          new_size =3D MIN(old_size << 1, 1 << CPU_TLB_DYN_MAX_BITS);
>      } else if (rate < 30 && window_expired) {
> -        size_t ceil =3D pow2ceil(desc->window.max_entries);
> -        size_t expected_rate =3D desc->window.max_entries * 100 / ceil;
> +        size_t ceil =3D pow2ceil(desc->window_max_entries);
> +        size_t expected_rate =3D desc->window_max_entries * 100 / ceil;
>
>          /*
>           * Avoid undersizing when the max number of entries seen is just=
 below
> @@ -182,7 +182,7 @@ static void tlb_mmu_resize_locked(CPUArchState *env, =
int mmu_idx)
>
>      if (new_size =3D=3D old_size) {
>          if (window_expired) {
> -            tlb_window_reset(&desc->window, now, desc->n_used_entries);
> +            tlb_window_reset(desc, now, desc->n_used_entries);
>          }
>          return;
>      }
> @@ -190,7 +190,7 @@ static void tlb_mmu_resize_locked(CPUArchState *env, =
int mmu_idx)
>      g_free(env->tlb_table[mmu_idx]);
>      g_free(env->iotlb[mmu_idx]);
>
> -    tlb_window_reset(&desc->window, now, 0);
> +    tlb_window_reset(desc, now, 0);
>      /* desc->n_used_entries is cleared by the caller */
>      env->tlb_mask[mmu_idx] =3D (new_size - 1) << CPU_TLB_ENTRY_BITS;
>      env->tlb_table[mmu_idx] =3D g_try_new(CPUTLBEntry, new_size);


--
Alex Benn=C3=A9e
