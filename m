Received: from eggs.gnu.org ([2001:4830:134:3::10]:54105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPQIS-0008HP-4B
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPQIN-0008WA-7n
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:27:04 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:60127)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPQIM-0008Uf-S5
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:26:59 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <CADR1n+V8R1LOGzbwdBDt5axeZ0mqh=WSCsfUo0Vr2nmE6BYqTQ@mail.gmail.com>
	<8760fqorbp.fsf@frigg.lan>
	<CAFEAcA-434=WhBxC=KB2HBhrPG9b+z1i3jqeFgiE=H8ceZJYzg@mail.gmail.com>
	<87mv91tn7d.fsf@linaro.org> <87r2y8gsy1.fsf@frigg.lan>
	<87efu89di5.fsf@linaro.org>
Date: Mon, 26 Jun 2017 12:26:45 +0300
In-Reply-To: <87efu89di5.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
	message of "Sun, 25 Jun 2017 18:35:30 +0100")
Message-ID: <87shindrqi.fsf@frigg.lan>
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
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jayanto Minocha <jayanto@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

Alex Benn=C3=A9e writes:

> Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> writes:

>> Alex Benn=C3=A9e writes:
>>=20
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>=20
>>>> On 20 June 2017 at 12:02, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wr=
ote:
>>>>> Jayanto Minocha writes:
>>>>>> But that is only used to instrument the cpu_ld/cpu_st macros, which =
is only
>>>>>> called in the case of a tlb miss.
>>>>>=20
>>>>>> I've been going over the archives, and it looks like I need to instr=
ument
>>>>>> tcg_out_tlb_load. Am I on the right path ?
>>>>>=20
>>>>> That event should trace all guest memory accesses performed by the CP=
U. If you
>>>>> found any case where this does not hold, it is likely a bug and I'd a=
ppreciate
>>>>> it if you can point me to the smallest possible failing example.
>>>>=20
>>>> Does it catch memory accesses that are performed via helper functions,
>>>> or only ones done by inline TCG code?
>>=20
>>> AFAICT it inserts a helper call on the TCG ld/st ops. I wonder why not
>>> just ensure we always take the slow path and put the helpers in the
>>> access functions there? You could even apply an address mask if you only
>>> want to look at certain address ranges.
>>=20
>> It also catches accesses performed by helpers.

> Don't helper accesses also pass through the SoftMMU? Or are we talking
> about user-space access as well here?

There's two places where memory access tracing is triggered:

* tcg_gen_qemu_ld/st_...
* ld/st templates (both softmmu and user)

AFAIK, helpers use the ld/st templates to access guest memory.

You can check for calls to trace_guest_mem_before_exec and
trace_guest_mem_before_tcg.


Thanks,
  Lluis
