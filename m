Received: from eggs.gnu.org ([2001:4830:134:3::10]:39317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecZJ6-0004q6-97
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecZJ5-0005uh-8E
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:14:20 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:45433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecZJ5-0005uW-2D
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:14:19 -0500
Received: by mail-io0-x244.google.com with SMTP id p188so2655655ioe.12
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 08:14:19 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20180119143951.5810-1-f4bug@amsat.org>
References: <20180119143951.5810-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 19 Jan 2018 13:14:17 -0300
Message-ID: <CAAdtpL5=FU=+vTz_p5fQCDdmOTYO-QQ+p6DuLw3ds6wEAN46jQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] migration: do not use
 atomic__nocheck() functions directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alexey Perevalov <a.perevalov@samsung.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, Jan 19, 2018 at 11:39 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> (incorrectly use in 3be98be4e9f)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> currently on ppc32 the linking fails:

Well armel and armhf hosts are also failing since 3be98be4e9f.

>
>   CC      migration/postcopy-ram.o
> ...
>   LINK    microblaze-softmmu/qemu-system-microblaze
> ../migration/postcopy-ram.o: In function `mark_postcopy_blocktime_end':
> migration/postcopy-ram.c:717: undefined reference to `__atomic_fetch_add_=
8'
> migration/postcopy-ram.c:738: undefined reference to `__atomic_fetch_add_=
8'
> ../migration/postcopy-ram.o: In function `mark_postcopy_blocktime_begin':
> migration/postcopy-ram.c:651: undefined reference to `__atomic_exchange_8=
'
> migration/postcopy-ram.c:652: undefined reference to `__atomic_exchange_8=
'
> migration/postcopy-ram.c:661: undefined reference to `__atomic_exchange_8=
'
> collect2: error: ld returned 1 exit status
> Makefile:193: recipe for target 'qemu-system-microblaze' failed
> make[1]: *** [qemu-system-microblaze] Error 1
>
> with this patch the compilation fails:
>
>   CC      migration/postcopy-ram.o
> In file included from include/qemu/osdep.h:36:0,
>                  from migration/postcopy-ram.c:19:
> migration/postcopy-ram.c: In function 'mark_postcopy_blocktime_begin':
> include/qemu/compiler.h:86:30: error: static assertion failed: "not expec=
ting: sizeof(*&dc->last_begin) > ATOMIC_REG_SIZE"
>  #define QEMU_BUILD_BUG_ON(x) _Static_assert(!(x), "not expecting: " #x)
>                               ^
> include/qemu/atomic.h:183:5: note: in expansion of macro 'QEMU_BUILD_BUG_=
ON'
>      QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE);      \
>      ^
> migration/postcopy-ram.c:651:5: note: in expansion of macro 'atomic_xchg'
>      atomic_xchg(&dc->last_begin, now_ms);
>      ^
>
>  migration/postcopy-ram.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 7814da5b4b..6ecc1aa820 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -648,17 +648,17 @@ static void mark_postcopy_blocktime_begin(uintptr_t=
 addr, uint32_t ptid,
>          atomic_inc(&dc->smp_cpus_down);
>      }
>
> -    atomic_xchg__nocheck(&dc->last_begin, now_ms);
> -    atomic_xchg__nocheck(&dc->page_fault_vcpu_time[cpu], now_ms);
> -    atomic_xchg__nocheck(&dc->vcpu_addr[cpu], addr);
> +    atomic_xchg(&dc->last_begin, now_ms);
> +    atomic_xchg(&dc->page_fault_vcpu_time[cpu], now_ms);
> +    atomic_xchg(&dc->vcpu_addr[cpu], addr);
>
>      /* check it here, not at the begining of the function,
>       * due to, check could accur early than bitmap_set in
>       * qemu_ufd_copy_ioctl */
>      already_received =3D ramblock_recv_bitmap_test(rb, (void *)addr);
>      if (already_received) {
> -        atomic_xchg__nocheck(&dc->vcpu_addr[cpu], 0);
> -        atomic_xchg__nocheck(&dc->page_fault_vcpu_time[cpu], 0);
> +        atomic_xchg(&dc->vcpu_addr[cpu], 0);
> +        atomic_xchg(&dc->page_fault_vcpu_time[cpu], 0);
>          atomic_dec(&dc->smp_cpus_down);
>      }
>      trace_mark_postcopy_blocktime_begin(addr, dc, dc->page_fault_vcpu_ti=
me[cpu],
> @@ -719,7 +719,7 @@ static void mark_postcopy_blocktime_end(uintptr_t add=
r)
>              read_vcpu_time =3D=3D 0) {
>              continue;
>          }
> -        atomic_xchg__nocheck(&dc->vcpu_addr[i], 0);
> +        atomic_xchg(&dc->vcpu_addr[i], 0);
>          vcpu_blocktime =3D now_ms - read_vcpu_time;
>          affected_cpu +=3D 1;
>          /* we need to know is that mark_postcopy_end was due to
> --
> 2.15.1
>
