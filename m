Received: from eggs.gnu.org ([2001:4830:134:3::10]:51177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egCSu-0003CM-Fm
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:39:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egCSt-0005za-Mh
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:39:28 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1egCSt-0005z6-Ff
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:39:27 -0500
Received: by mail-ot0-x243.google.com with SMTP id x15so7120356ote.1
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 08:39:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171217055023.29225-1-pbonzini@redhat.com>
References: <20171217055023.29225-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2018 16:39:06 +0000
Message-ID: <CAFEAcA8t0kAx9mDNuEEU_-4J9x1XM=ZHP4m19fz0vL+DHzPXxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg: add cs_base and flags to -d exec
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 17 December 2017 at 05:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  accel/tcg/cpu-exec.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 4318441e4c..18c1a2aedb 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -146,8 +146,10 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
>      uint8_t *tb_ptr = itb->tc.ptr;
>
>      qemu_log_mask_and_addr(CPU_LOG_EXEC, itb->pc,
> -                           "Trace %p [%d: " TARGET_FMT_lx "] %s\n",
> -                           itb->tc.ptr, cpu->cpu_index, itb->pc,
> +                           "Trace %d: %p ["
> +                           TARGET_FMT_lx "/" TARGET_FMT_lx "/%d] %s\n",
> +                           cpu->cpu_index, itb->tc.ptr,
> +                           itb->cs_base, itb->pc, itb->flags,
>                             lookup_symbol(itb->pc));

At the risk of having to update my log-parsing scripts again, I
notice that the output now looks a bit odd:

Trace 0: 0x7f70942390c0 [00000000/6aa01000/0x51080001] someFunction

in that the first two items in the [] have no preceding 0x but the
last one does.

thanks
-- PMM
