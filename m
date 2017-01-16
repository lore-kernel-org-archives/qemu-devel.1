Received: from eggs.gnu.org ([2001:4830:134:3::10]:43108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cT9Pa-0001tR-1C
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 10:41:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cT9PW-0007ue-4N
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 10:41:34 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:45223 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cT9PV-0007ta-Nl
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 10:41:30 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <148294246378.10801.8881527920302104439.stgit@fimbulvetr.bsc.es>
	<148294248013.10801.9410215722238543688.stgit@fimbulvetr.bsc.es>
	<5036a178-60eb-814a-5873-f82ed3453a82@twiddle.net>
Date: Mon, 16 Jan 2017 16:41:22 +0100
In-Reply-To: <5036a178-60eb-814a-5873-f82ed3453a82@twiddle.net> (Richard
	Henderson's message of "Tue, 10 Jan 2017 18:50:30 -0800")
Message-ID: <87inpff1wd.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/6] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Richard Henderson writes:

> On 12/28/2016 08:28 AM, Llu=C3=ADs Vilanova wrote:
>> +typedef enum DisasJumpType {
>> +    DJ_NEXT,
>> +    DJ_TOO_MANY,
>> +    DJ_TARGET,
>> +} DisasJumpType;

> I wonder if enums like DJ_TARGET_{0..N} wouldn't be better, rather than d=
oing
> addition in the target-specific names.

I'm not sure. ARM has 12 target-specific flags (while x86 only has 2), and
adding so many "unspecified" values to the generic enum does not seem right=
 to
me.

I you feel strongly against the current state, I'll change it; re-defining
existing enum values could, for example, have benefits in switch/case range=
s and
compiler warnings.


>> +typedef struct DisasContextBase {
>> +    TranslationBlock *tb;
>> +    bool singlestep_enabled;
>> +    target_ulong pc_first;
>> +    target_ulong pc_next;
>> +    DisasJumpType jmp_type;
>> +    unsigned int num_insns;
>> +} DisasContextBase;

> Sort the bool to the end to minimize padding.

Done.


>> +/* Get first breakpoint matching a PC */
>> +static inline CPUBreakpoint *cpu_breakpoint_get(CPUState *cpu, vaddr pc,
>> +                                                CPUBreakpoint *bp)
>> +{
>> +    if (likely(bp =3D=3D NULL)) {
>> +        if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
>> +            QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
>> +                if (bp->pc =3D=3D pc) {
>> +                    return bp;
>> +                }
>> +            }
>> +        }
>> +    } else {
>> +        QTAILQ_FOREACH_CONTINUE(bp, entry) {
>> +            if (bp->pc =3D=3D pc) {
>> +                return bp;
>> +            }
>> +        }
>> +    }
>> +    return NULL;
>> +}

> Any reason not to put the QTAILQ_FOREACH directly into gen_intermediate_c=
ode,
> rather than indirect it like this?  I don't see this abstraction as an
> improvement.

I thought this belonged here to maintain encapsulation of how breakpoint li=
sts
are implemented (just as we already have insert/remove/test functions right
above this one).

Having it as a separate function (wherever it is) also helps readability. A=
gain,
if you feel strongly against it, I can move that function into the translate
template header.


Thanks,
  Lluis
