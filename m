Received: from eggs.gnu.org ([2001:4830:134:3::10]:46644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ecaz2-0003BV-4K
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ecayx-0005SI-8j
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:01:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ecayw-0005S0-Ve
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:01:39 -0500
Date: Fri, 19 Jan 2018 18:01:33 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180119180133.GG2430@work-vm>
References: <20180119143951.5810-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180119143951.5810-1-f4bug@amsat.org>
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
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Juan Quintela <quintela@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org

* Philippe Mathieu-Daud=E9 (f4bug@amsat.org) wrote:
> (incorrectly use in 3be98be4e9f)
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

I'm a bit confused; isnt the only difference between the nocheck
versions that it'll fail at compile time instead of link?

Dave

> ---
> currently on ppc32 the linking fails:
>=20
>   CC      migration/postcopy-ram.o
> ...
>   LINK    microblaze-softmmu/qemu-system-microblaze
> ../migration/postcopy-ram.o: In function `mark_postcopy_blocktime_end':
> migration/postcopy-ram.c:717: undefined reference to `__atomic_fetch_ad=
d_8'
> migration/postcopy-ram.c:738: undefined reference to `__atomic_fetch_ad=
d_8'
> ../migration/postcopy-ram.o: In function `mark_postcopy_blocktime_begin=
':
> migration/postcopy-ram.c:651: undefined reference to `__atomic_exchange=
_8'
> migration/postcopy-ram.c:652: undefined reference to `__atomic_exchange=
_8'
> migration/postcopy-ram.c:661: undefined reference to `__atomic_exchange=
_8'
> collect2: error: ld returned 1 exit status
> Makefile:193: recipe for target 'qemu-system-microblaze' failed
> make[1]: *** [qemu-system-microblaze] Error 1
>=20
> with this patch the compilation fails:
>=20
>   CC      migration/postcopy-ram.o
> In file included from include/qemu/osdep.h:36:0,
>                  from migration/postcopy-ram.c:19:
> migration/postcopy-ram.c: In function 'mark_postcopy_blocktime_begin':
> include/qemu/compiler.h:86:30: error: static assertion failed: "not exp=
ecting: sizeof(*&dc->last_begin) > ATOMIC_REG_SIZE"
>  #define QEMU_BUILD_BUG_ON(x) _Static_assert(!(x), "not expecting: " #x=
)
>                               ^
> include/qemu/atomic.h:183:5: note: in expansion of macro 'QEMU_BUILD_BU=
G_ON'
>      QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE);      \
>      ^
> migration/postcopy-ram.c:651:5: note: in expansion of macro 'atomic_xch=
g'
>      atomic_xchg(&dc->last_begin, now_ms);
>      ^
>=20
>  migration/postcopy-ram.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 7814da5b4b..6ecc1aa820 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -648,17 +648,17 @@ static void mark_postcopy_blocktime_begin(uintptr=
_t addr, uint32_t ptid,
>          atomic_inc(&dc->smp_cpus_down);
>      }
> =20
> -    atomic_xchg__nocheck(&dc->last_begin, now_ms);
> -    atomic_xchg__nocheck(&dc->page_fault_vcpu_time[cpu], now_ms);
> -    atomic_xchg__nocheck(&dc->vcpu_addr[cpu], addr);
> +    atomic_xchg(&dc->last_begin, now_ms);
> +    atomic_xchg(&dc->page_fault_vcpu_time[cpu], now_ms);
> +    atomic_xchg(&dc->vcpu_addr[cpu], addr);
> =20
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
>      trace_mark_postcopy_blocktime_begin(addr, dc, dc->page_fault_vcpu_=
time[cpu],
> @@ -719,7 +719,7 @@ static void mark_postcopy_blocktime_end(uintptr_t a=
ddr)
>              read_vcpu_time =3D=3D 0) {
>              continue;
>          }
> -        atomic_xchg__nocheck(&dc->vcpu_addr[i], 0);
> +        atomic_xchg(&dc->vcpu_addr[i], 0);
>          vcpu_blocktime =3D now_ms - read_vcpu_time;
>          affected_cpu +=3D 1;
>          /* we need to know is that mark_postcopy_end was due to
> --=20
> 2.15.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
