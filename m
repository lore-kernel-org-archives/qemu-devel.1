Received: from eggs.gnu.org ([2001:4830:134:3::10]:35506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsV1L-00025h-Nt
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsV1I-0004h5-GB
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:21:35 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:44608 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsV1I-0004eu-3R
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:21:32 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
	<150506010962.19604.7773376130922107594.stgit@frigg.lan>
	<c4f6b95c-e548-cd78-e3fa-345d534f273f@linaro.org>
Date: Thu, 14 Sep 2017 17:21:20 +0300
In-Reply-To: <c4f6b95c-e548-cd78-e3fa-345d534f273f@linaro.org> (Richard
	Henderson's message of "Wed, 13 Sep 2017 09:59:09 -0700")
Message-ID: <8760clqs2n.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] trace: Add event "guest_bbl_before"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Richard Henderson writes:

> On 09/10/2017 09:15 AM, Llu=C3=ADs Vilanova wrote:
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
>> accel/tcg/translator.c |    6 ++++++
>> trace-events           |   11 +++++++++++
>> 2 files changed, 17 insertions(+)
>>=20
>> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
>> index afa3af478a..91b3b0da32 100644
>> --- a/accel/tcg/translator.c
>> +++ b/accel/tcg/translator.c
>> @@ -13,6 +13,7 @@
>> #include "cpu.h"
>> #include "tcg/tcg.h"
>> #include "tcg/tcg-op.h"
>> +#include "trace-tcg.h"
>> #include "exec/exec-all.h"
>> #include "exec/gen-icount.h"
>> #include "exec/log.h"
>> @@ -91,6 +92,11 @@ void translator_loop(const TranslatorOps *ops, DisasC=
ontextBase *db,
>> }
>> }
>>=20
>> +        /* Tracing before */
>> +        if (db->num_insns =3D=3D 1) {
>> +            trace_guest_bbl_before_tcg(cpu, tcg_ctx.tcg_env, db->pc_fir=
st);
>> +        }

> Why not place this before the loop, so that you don't
> have to check num_insns =3D=3D 1?

In case the translation hits a breakpoint. I do not want the BBL/TB to appe=
ar
once before breaking, and then again after continuing.


>> +vcpu tcg guest_bbl_before(uint64_t vaddr) "vaddr=3D0x%016"PRIx64, "vadd=
r=3D0x%016"PRIx64

> You're really going to print both ENV and PC tagged with "vaddr"?
> That just seems confusing.

I'm not sure I follow. The ENV/CPUState is automatically added to the print
format (due to the "vcpu" property). The two format strings are necessary d=
ue to
the "tcg" property (translation-time format and execution-time format, since
TCGv arguments are not passed to the tracing function at translation time).

I'm not sure if this addresses your issue.


> Also, terminology.  A "basic block" ("bb" by preference, not "bbl"), has a
> specific meaning (https://en.wikipedia.org/wiki/Basic_block).  What we're
> generating here is a TranslationBlock (which may consist of many basic bl=
ocks),
> and oft contracted within the source as "tb".

Yes, I got carried away by the naming used by some binary analysis tools li=
ke
pin. I will change it to TB and that will probably make it clearer.


Thanks,
  Lluis
