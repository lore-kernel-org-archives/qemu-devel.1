Received: from eggs.gnu.org ([2001:4830:134:3::10]:49067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1Ubs-0001BL-7q
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1Ubn-0007Yp-PH
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:16:44 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:44627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f1Ubn-0007YW-HU
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:16:39 -0400
Received: by mail-wr0-x241.google.com with SMTP id u46so4877566wrc.11
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 03:16:39 -0700 (PDT)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-7-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1519709965-29833-7-git-send-email-cota@braap.org>
Date: Thu, 29 Mar 2018 11:16:37 +0100
Message-ID: <87woxv6vay.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/16] translate-all: make l1_map lockless
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

> Groundwork for supporting parallel TCG generation.
>
> We never remove entries from the radix tree, so we can use cmpxchg
> to implement lockless insertions.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/translate-all.c       | 24 ++++++++++++++----------
>  docs/devel/multi-thread-tcg.txt |  4 ++--
>  2 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 06aa905..f2bfa71 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -472,20 +472,12 @@ static void page_init(void)
>  #endif
>  }
>
> -/* If alloc=3D1:
> - * Called with tb_lock held for system emulation.
> - * Called with mmap_lock held for user-mode emulation.
> - */
>  static PageDesc *page_find_alloc(tb_page_addr_t index, int alloc)
>  {
>      PageDesc *pd;
>      void **lp;
>      int i;
>
> -    if (alloc) {
> -        assert_memory_lock();
> -    }
> -
>      /* Level 1.  Always allocated.  */
>      lp =3D l1_map + ((index >> v_l1_shift) & (v_l1_size - 1));
>
> @@ -494,11 +486,17 @@ static PageDesc *page_find_alloc(tb_page_addr_t ind=
ex, int alloc)
>          void **p =3D atomic_rcu_read(lp);
>
>          if (p =3D=3D NULL) {
> +            void *existing;
> +
>              if (!alloc) {
>                  return NULL;
>              }
>              p =3D g_new0(void *, V_L2_SIZE);
> -            atomic_rcu_set(lp, p);
> +            existing =3D atomic_cmpxchg(lp, NULL, p);
> +            if (unlikely(existing)) {
> +                g_free(p);
> +                p =3D existing;
> +            }
>          }
>
>          lp =3D p + ((index >> (i * V_L2_BITS)) & (V_L2_SIZE - 1));
> @@ -506,11 +504,17 @@ static PageDesc *page_find_alloc(tb_page_addr_t ind=
ex, int alloc)
>
>      pd =3D atomic_rcu_read(lp);
>      if (pd =3D=3D NULL) {
> +        void *existing;
> +
>          if (!alloc) {
>              return NULL;
>          }
>          pd =3D g_new0(PageDesc, V_L2_SIZE);
> -        atomic_rcu_set(lp, pd);
> +        existing =3D atomic_cmpxchg(lp, NULL, pd);
> +        if (unlikely(existing)) {
> +            g_free(pd);
> +            pd =3D existing;
> +        }
>      }
>
>      return pd + (index & (V_L2_SIZE - 1));
> diff --git a/docs/devel/multi-thread-tcg.txt b/docs/devel/multi-thread-tc=
g.txt
> index a99b456..faf8918 100644
> --- a/docs/devel/multi-thread-tcg.txt
> +++ b/docs/devel/multi-thread-tcg.txt
> @@ -134,8 +134,8 @@ tb_set_jmp_target() code. Modification to the linked =
lists that allow
>  searching for linked pages are done under the protect of the
>  tb_lock().
>
> -The global page table is protected by the tb_lock() in system-mode and
> -mmap_lock() in linux-user mode.
> +The global page table is a lockless radix tree; cmpxchg is used
> +to atomically insert new elements.
>
>  The lookup caches are updated atomically and the lookup hash uses QHT
>  which is designed for concurrent safe lookup.


--
Alex Benn=C3=A9e
