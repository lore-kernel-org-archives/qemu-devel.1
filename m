Received: from eggs.gnu.org ([2001:4830:134:3::10]:47465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1UTx-0003uh-Kg
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1UTw-0004ui-DU
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:08:33 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:37196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f1UTw-0004ua-6I
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:08:32 -0400
Received: by mail-wr0-x242.google.com with SMTP id l49so4870759wrl.4
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 03:08:32 -0700 (PDT)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-10-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1519709965-29833-10-git-send-email-cota@braap.org>
Date: Thu, 29 Mar 2018 11:08:29 +0100
Message-ID: <87zi2r6voi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/16] translate-all: move
 tb_invalidate_phys_page_range up in the file
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

> This greatly simplifies next commit's diff.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/translate-all.c | 77 ++++++++++++++++++++++++-----------------=
------
>  1 file changed, 39 insertions(+), 38 deletions(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index a98e182..4cb03f1 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1371,44 +1371,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>
>  /*
>   * Invalidate all TBs which intersect with the target physical address r=
ange
> - * [start;end[. NOTE: start and end may refer to *different* physical pa=
ges.
> - * 'is_cpu_write_access' should be true if called from a real cpu write
> - * access: the virtual CPU will exit the current TB if code is modified =
inside
> - * this TB.
> - *
> - * Called with mmap_lock held for user-mode emulation, grabs tb_lock
> - * Called with tb_lock held for system-mode emulation
> - */
> -static void tb_invalidate_phys_range_1(tb_page_addr_t start, tb_page_add=
r_t end)
> -{
> -    tb_page_addr_t next;
> -
> -    for (next =3D (start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
> -         start < end;
> -         start =3D next, next +=3D TARGET_PAGE_SIZE) {
> -        tb_page_addr_t bound =3D MIN(next, end);
> -
> -        tb_invalidate_phys_page_range(start, bound, 0);
> -    }
> -}
> -
> -#ifdef CONFIG_SOFTMMU
> -void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
> -{
> -    assert_tb_locked();
> -    tb_invalidate_phys_range_1(start, end);
> -}
> -#else
> -void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
> -{
> -    assert_memory_lock();
> -    tb_lock();
> -    tb_invalidate_phys_range_1(start, end);
> -    tb_unlock();
> -}
> -#endif
> -/*
> - * Invalidate all TBs which intersect with the target physical address r=
ange
>   * [start;end[. NOTE: start and end must refer to the *same* physical pa=
ge.
>   * 'is_cpu_write_access' should be true if called from a real cpu write
>   * access: the virtual CPU will exit the current TB if code is modified =
inside
> @@ -1505,6 +1467,45 @@ void tb_invalidate_phys_page_range(tb_page_addr_t =
start, tb_page_addr_t end,
>  #endif
>  }
>
> +/*
> + * Invalidate all TBs which intersect with the target physical address r=
ange
> + * [start;end[. NOTE: start and end may refer to *different* physical pa=
ges.
> + * 'is_cpu_write_access' should be true if called from a real cpu write
> + * access: the virtual CPU will exit the current TB if code is modified =
inside
> + * this TB.
> + *
> + * Called with mmap_lock held for user-mode emulation, grabs tb_lock
> + * Called with tb_lock held for system-mode emulation
> + */
> +static void tb_invalidate_phys_range_1(tb_page_addr_t start, tb_page_add=
r_t end)
> +{
> +    tb_page_addr_t next;
> +
> +    for (next =3D (start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
> +         start < end;
> +         start =3D next, next +=3D TARGET_PAGE_SIZE) {
> +        tb_page_addr_t bound =3D MIN(next, end);
> +
> +        tb_invalidate_phys_page_range(start, bound, 0);
> +    }
> +}
> +
> +#ifdef CONFIG_SOFTMMU
> +void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
> +{
> +    assert_tb_locked();
> +    tb_invalidate_phys_range_1(start, end);
> +}
> +#else
> +void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
> +{
> +    assert_memory_lock();
> +    tb_lock();
> +    tb_invalidate_phys_range_1(start, end);
> +    tb_unlock();
> +}
> +#endif
> +
>  #ifdef CONFIG_SOFTMMU
>  /* len must be <=3D 8 and start must be a multiple of len.
>   * Called via softmmu_template.h when code areas are written to with


--
Alex Benn=C3=A9e
