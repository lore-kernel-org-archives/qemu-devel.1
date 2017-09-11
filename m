Received: from eggs.gnu.org ([2001:4830:134:3::10]:46303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drWOq-0004UC-1t
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drWOp-0000tx-4C
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:37:48 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:44151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drWOo-0000tH-SD
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:37:47 -0400
Received: by mail-wm0-x22d.google.com with SMTP id 189so11906163wmh.1
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 14:37:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170911204936.5020-1-f4bug@amsat.org>
References: <20170911204936.5020-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2017 22:37:24 +0100
Message-ID: <CAFEAcA_61iw+u7aMp+vA-CNpmAPjvJ_ynUfHu8Y+p8jmgvbcdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg/ppc: disable atomic write check on
 ppc32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>

On 11 September 2017 at 21:49, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> this fixes building for ppc64 on ppc32 (changed in 5964fca8a12c):
>
>   qemu/tcg/ppc/tcg-target.inc.c: In function 'tb_target_set_jmp_target':
>   qemu/include/qemu/compiler.h:86:30: error: static assertion failed: "no=
t expecting: sizeof(*(uint64_t *)jmp_addr) > ATOMIC_REG_SIZE"
>        QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
>        ^
>   qemu/tcg/ppc/tcg-target.inc.c:1377:9: note: in expansion of macro 'atom=
ic_set'
>            atomic_set((uint64_t *)jmp_addr, pair);
>            ^
>
> Suggested-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> This fixes Shippable builds, see:
> https://app.shippable.com/github/qemu/qemu/runs/434/10/console
>
>  tcg/ppc/tcg-target.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index 21d764c102..0417901289 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -1374,7 +1374,7 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uin=
tptr_t jmp_addr,
>          pair =3D (uint64_t)i2 << 32 | i1;
>  #endif
>
> -        atomic_set((uint64_t *)jmp_addr, pair);
> +        atomic_set__nocheck((uint64_t *)jmp_addr, pair);
>          flush_icache_range(jmp_addr, jmp_addr + 8);
>      } else {
>          intptr_t diff =3D addr - jmp_addr;

Can you explain why this is the right thing? On the
face of it it looks correct to insist that we don't
try to do an atomic set of something that's bigger
than the host can actually handle...

thanks
-- PMM
