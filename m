Received: from eggs.gnu.org ([2001:4830:134:3::10]:49194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1Ucg-0001es-6O
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1Ucc-0007ql-0Z
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:17:34 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:39015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f1Ucb-0007qZ-QW
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:17:29 -0400
Received: by mail-wr0-x244.google.com with SMTP id c24so4885937wrc.6
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 03:17:29 -0700 (PDT)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-9-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1519709965-29833-9-git-send-email-cota@braap.org>
Date: Thu, 29 Mar 2018 11:17:27 +0100
Message-ID: <87tvsz6v9k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/16] translate-all: work page-by-page in
 tb_invalidate_phys_range_1
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

> So that we pass a same-page range to tb_invalidate_phys_page_range,
> instead of always passing an end address that could be on a different
> page.
>
> As discussed with Peter Maydell on the list [1], tb_invalidate_phys_page_=
range
> doesn't actually do much with 'end', which explains why we have never
> hit a bug despite going against what the comment on top of
> tb_invalidate_phys_page_range requires:
>
>> * Invalidate all TBs which intersect with the target physical address ra=
nge
>> * [start;end[. NOTE: start and end must refer to the *same* physical pag=
e.
>
> The appended honours the comment, which avoids confusion.
>
> While at it, rework the loop into a for loop, which is less error prone
> (e.g. "continue" won't result in an infinite loop).
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg09165.html
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/translate-all.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 816419a..a98e182 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1381,10 +1381,14 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>   */
>  static void tb_invalidate_phys_range_1(tb_page_addr_t start, tb_page_add=
r_t end)
>  {
> -    while (start < end) {
> -        tb_invalidate_phys_page_range(start, end, 0);
> -        start &=3D TARGET_PAGE_MASK;
> -        start +=3D TARGET_PAGE_SIZE;
> +    tb_page_addr_t next;
> +
> +    for (next =3D (start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
> +         start < end;
> +         start =3D next, next +=3D TARGET_PAGE_SIZE) {
> +        tb_page_addr_t bound =3D MIN(next, end);
> +
> +        tb_invalidate_phys_page_range(start, bound, 0);
>      }
>  }


--
Alex Benn=C3=A9e
