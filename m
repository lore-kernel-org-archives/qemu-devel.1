Received: from eggs.gnu.org ([2001:4830:134:3::10]:46373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cytcj-0001GC-Fd
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 01:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cytce-00038L-MA
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 01:18:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cytce-00037K-Fs
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 01:18:16 -0400
References: <20170411105031.28904-1-alex.bennee@linaro.org>
	<20170411105031.28904-3-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5280a17f-833c-33b8-256f-3083482d58b9@redhat.com>
Date: Fri, 14 Apr 2017 13:18:07 +0800
MIME-Version: 1.0
In-Reply-To: <20170411105031.28904-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/3] cpus: dump TLB flush counts as
 trace event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, bobby.prani@gmail.com, rth@twiddle.net, stefanha@redhat.com
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 11/04/2017 18:50, Alex Benn=C3=A9e wrote:
> This can be pre-processed later from the trace file.

What about skipping this patch, and instead adding five trace points

trace_tlb_flush_self(int vcpu)
trace_tlb_flush_async_schedule(int from, int to)
trace_tlb_flush_async_work(int vcpu)
trace_tlb_flush_synced_schedule(int vcpu)
trace_tlb_flush_synced_work(int vcpu)

The disadvantage is that the TLB flush counts are not emitted in "info
tcg", but the resulting information is finer-grained and the offline
accumulation of tracepoints can provide the same information.

Paolo

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  cpus.c       | 6 ++++++
>  trace-events | 3 +++
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/cpus.c b/cpus.c
> index 740b8dc3f8..fae7344df5 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -50,6 +50,8 @@
>  #include "qapi-event.h"
>  #include "hw/nmi.h"
>  #include "sysemu/replay.h"
> +#include "exec/cputlb.h"
> +#include "trace-root.h"
> =20
>  #ifdef CONFIG_LINUX
> =20
> @@ -1252,6 +1254,10 @@ static int tcg_cpu_exec(CPUState *cpu)
>      int64_t ti;
>  #endif
> =20
> +    trace_tlb_flush_stats(tlb_self_flush_count,
> +                          tlb_async_flush_count,
> +                          tlb_synced_flush_count);
> +
>  #ifdef CONFIG_PROFILER
>      ti =3D profile_getclock();
>  #endif
> diff --git a/trace-events b/trace-events
> index b07a09ba95..fc23e15d25 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -94,6 +94,9 @@ disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=3D0=
x%"PRIxPTR
>  disable exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=3D0x%"PRIxPT=
R
>  disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=3D=
%x"
> =20
> +# cpus.c
> +tlb_flush_stats(int self, int async, int synced) "self:%d async:%d syn=
ced:%d"
> +
>  # translate-all.c
>  translate_block(void *tb, uintptr_t pc, uint8_t *tb_code) "tb:%p, pc:0=
x%"PRIxPTR", tb_code:%p"
> =20
>=20
