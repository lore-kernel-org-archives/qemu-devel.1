Received: from eggs.gnu.org ([2001:4830:134:3::10]:46151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dNunu-0000E6-Fm
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 01:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dNunp-0002Ml-JB
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 01:37:18 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:35629)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dNunp-0002M2-6S
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 01:37:13 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <CADR1n+V8R1LOGzbwdBDt5axeZ0mqh=WSCsfUo0Vr2nmE6BYqTQ@mail.gmail.com>
	<8760fqorbp.fsf@frigg.lan> <20170620172002.GA23332@flamenco>
	<CADR1n+Uw1Yg+0PdsaPwViXUFO7gGkW6ET_oSM86YQL+HRfM=0w@mail.gmail.com>
Date: Thu, 22 Jun 2017 08:36:53 +0300
In-Reply-To: <CADR1n+Uw1Yg+0PdsaPwViXUFO7gGkW6ET_oSM86YQL+HRfM=0w@mail.gmail.com>
	(Jayanto Minocha's message of "Tue, 20 Jun 2017 15:30:43 -0700")
Message-ID: <87lgokpoqy.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Tracing guest virtual addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jayanto Minocha <jayanto@gmail.com>
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

Jayanto Minocha writes:

> Lluis,
> My modifications were almost the same as those done by Emilio. There were
> no memory trace events in the trace file.

I'll take a look at it after I finish revamping the generic translation loop
series (hopefully today).

Thanks,
  Lluis


> -J

> On Tue, Jun 20, 2017 at 10:20 AM, Emilio G. Cota <cota@braap.org> wrote:

>> On Tue, Jun 20, 2017 at 14:02:02 +0300, Llu=C3=ADs Vilanova wrote:
>> > Jayanto Minocha writes:
>> >
>> > > Hi,
>> > > I think there have been a few threads on the mailing list regarding
>> tracing
>> > > guest virtual addresses for load and store instructions, but I have
>> been
>> > > unable to get it to work. I am trying this for an AArch64 machine, a=
nd
>> am
>> > > using the softmmu.
>> >
>> > > The tracing infrastructure provides the following event:
>> >
>> > > vcpu tcg guest_mem_before(...).
>> >
>> > > But that is only used to instrument the cpu_ld/cpu_st macros, which =
is
>> only
>> > > called in the case of a tlb miss.
>> >
>> > > I've been going over the archives, and it looks like I need to
>> instrument
>> > > tcg_out_tlb_load. Am I on the right path ?
>> >
>> > That event should trace all guest memory accesses performed by the CPU.
>> If you
>> > found any case where this does not hold, it is likely a bug and I'd
>> appreciate
>> > it if you can point me to the smallest possible failing example.
>>=20
>> I'm having trouble with this as well, although I'm pretty sure I must be
>> doing
>> something wrong (never used the tracing infrastructure before). Here's w=
hat
>> I'm doing:
>>=20
>> $ git show --pretty=3Dshort
>> commit e85c0d14014514a2f0faeae5b4c23fab5b234de4
>> Merge: 65a0e3e 7f3cf2d
>> Author: Peter Maydell <peter.maydell@linaro.org>
>>=20
>> Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into
>> staging
>>=20
>>=20
>> $ git diff
>> diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
>> index 2de8359..385a462 100644
>> --- a/accel/tcg/trace-events
>> +++ b/accel/tcg/trace-events
>> @@ -2,7 +2,7 @@
>>=20
>> # TCG related tracing (mostly disabled by default)
>> # cpu-exec.c
>> -disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=3D0x%"PRIxPTR
>> +exec_tb(void *tb, uintptr_t pc) "tb:%p pc=3D0x%"PRIxPTR
>> disable exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=3D0x%"PRIxPTR
>> disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=3D%=
x"
>>=20
>> diff --git a/trace-events b/trace-events
>> index bae63fd..7df49a3 100644
>> --- a/trace-events
>> +++ b/trace-events
>> @@ -106,7 +106,7 @@ vcpu guest_cpu_reset(void)
>> #
>> # Mode: user, softmmu
>> # Targets: TCG(all)
>> -disable vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=3D%d",
>> "vaddr=3D0x%016"PRIx64" info=3D%d"
>> +vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=3D%d",
>> "vaddr=3D0x%016"PRIx64" info=3D%d"
>>=20
>> # @num: System call number.
>> # @arg*: System call argument value.
>>=20
>> $ mkdir build
>> $ cd build
>> $ ../configure --target-list=3Darm-softmmu,x86_64-linux-user
>> --enable-trace-backends=3Dsimple && make -j 12
>> [...]
>>=20
>> $ cat ../ev
>> guest_mem_before_exec
>> guest_mem_before_trans
>> exec_tb
>>=20
>> $ x86_64-linux-user/qemu-x86_64 -trace events=3D../ev /bin/date
>> Tue Jun 20 13:11:49 EDT 2017
>>=20
>> $ ls -lt | head | grep trace
>> -rw-rw-r--  1 cota cota   169721 Jun 20 13:11 trace-2150
>>=20
>> $ scripts/simpletrace.py trace-events-all trace-2150
>> exec_tb 0.000 pid=3D2150 tb=3D0x7f5896667010 pc=3D0x4000801cc0
>> exec_tb 21.648 pid=3D2150 tb=3D0x7f5896667088 pc=3D0x4000805c00
>> [...]
>>=20
>> 100% of the file is exec_tb lines, i.e. no memory references whatsoever.
>>=20
>> Similar results with arm-softmmu.
>>=20
>> Thanks,
>>=20
>> Emilio
>>=20
>>=20
