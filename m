Received: from eggs.gnu.org ([2001:4830:134:3::10]:37032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dy37T-0004ib-GP
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dy37Q-0008SY-An
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:46:51 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:54242)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dy37P-0008QN-V0
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:46:48 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
	<150529666493.10902.14830445134051381968.stgit@frigg.lan>
	<CAFEAcA9p9B8AFaaSaSOOSsFsEhHW=XPLBFs5MrozWq=7p4_9Zg@mail.gmail.com>
	<87poasgjyh.fsf@frigg.lan>
	<CAFEAcA8XP+8Jz9Dn-mEQ3CCrVj00t3HA0praQ-OSggtQGAmQ5Q@mail.gmail.com>
	<87d16o53xr.fsf@frigg.lan>
	<CAFEAcA9FhXKVKe1E_pVDWX3u0W7WuKQmO54Z1Jgj-iL980yPew@mail.gmail.com>
	<87o9pywt8k.fsf@frigg.lan> <87shf5zlty.fsf@frigg.lan>
	<20170929175943.GA25038@flamenco>
Date: Sat, 30 Sep 2017 00:46:33 +0300
In-Reply-To: <20170929175943.GA25038@flamenco> (Emilio G. Cota's message of
	"Fri, 29 Sep 2017 13:59:43 -0400")
Message-ID: <87vak1w53a.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 01/22] instrument: Add documentation
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Emilio G Cota writes:

> On Fri, Sep 29, 2017 at 16:16:41 +0300, Llu=C3=ADs Vilanova wrote:
>> Llu=C3=ADs Vilanova writes:
>> [...]
>> > This was working on a much older version of instrumentation for QEMU, =
but I can
>> > implement something that does the first use-case point above and some =
filtering
>> > example (second use-case point) to see what's the performance differen=
ce.
>>=20
>> Ok, so here's some numbers for the discussion (booting Emilio's ARM full=
 system
>> image that immediately shuts down):
>>=20
>> * Without instrumentation
>>=20
>> real	0m10,099s
>> user	0m9,876s
>> sys	0m0,128s
>>=20
>> * Count number of memory access writes, by instrumenting only when they =
are
>> executed
>>=20
>> real	0m15,896s
>> user	0m15,752s
>> sys	0m0,108s
>>=20
>> * Counting same, but the filtering is done at translation time (i.e., not
>> generate an execute-time callback if it's not a write)
>>=20
>> real	0m11,084s
>> user	0m10,880s
>> sys	0m0,112s
>>=20
>> As Peter said, the filtering can be added into the API to take advantage=
 of
>> this "speedup", without exposing translation vs execution time callbacks.

> I'm not sure I understand this concept of filtering. Are you saying that =
in
> the first case, all memory accesses are instrumented, and then in the
> "access helper" we only call the user's callback if it's a memory write?
> And in the second case, we simply just generate a "write helper" instead
> of an "access helper". Am I understanding this correctly?

In the previous case (no filtering), the user callback is always called whe=
n a
memory access is *executed*, and the user then checks if the access mode is=
 a
write to decide whether to increment a counter.

In this case (with filtering), a user callback is called when a memory acce=
ss is
*translated*, and if the access mode is a write, the user generates a call =
to a
second callback that is executed every time a memory access is executed (on=
ly
that it is only generated for memory writes, the ones we care about).

Is this clearer?


>> * Counting number of executed instructions, by instrumenting the beginni=
ng of
>> each one of them
>>=20
>> real	0m24,583s
>> user	0m24,352s
>> sys	0m0,184s
>>=20
>> * Counting same, but per-TB numbers are collected at translation-time, a=
nd we
>> only generate a per-TB execution time callback to add the corresponding =
number
>> of instructions for that TB
>>=20
>> real	0m11,151s
>> user	0m10,952s
>> sys	0m0,092s
>>=20
>> This really needs to expose translation vs execution time callbacks to t=
ake
>> advantage of this "speedup".

> Clearly instrumenting per-TB is a significant net gain. I think we should
> definitely allow instrumenters to use this option.

> FWIW my experiments so far show similar numbers for instrumenting each
> instruction (haven't done the per-tb yet). The difference is that I'm
> exposing to instrumenters a copy of the guest instructions (const void *d=
ata,
> size_t size). These copies are kept around until TB's are flushed.
> Luckily there seems to be very little overhead in keeping these around,
> apart from the memory overhead -- but in terms of performance, the
> necessary allocations do not induce significant overhead.

To keep this use-case simpler, I added the memory access API I posted in th=
is
series, where instrumenters can read guest memory (more general than passin=
g a
copy of the current instruction).


Cheers,
  Lluis
