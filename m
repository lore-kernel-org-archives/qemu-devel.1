Received: from eggs.gnu.org ([2001:4830:134:3::10]:46744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dwXjd-0005Ry-KI
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dwXja-0002RC-Eq
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:04:01 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:41609)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dwXjZ-0002PW-VF
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:03:58 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
	<150529666493.10902.14830445134051381968.stgit@frigg.lan>
	<CAFEAcA9p9B8AFaaSaSOOSsFsEhHW=XPLBFs5MrozWq=7p4_9Zg@mail.gmail.com>
	<87poasgjyh.fsf@frigg.lan>
	<CAFEAcA8XP+8Jz9Dn-mEQ3CCrVj00t3HA0praQ-OSggtQGAmQ5Q@mail.gmail.com>
	<87d16o53xr.fsf@frigg.lan>
	<CAFEAcA9FhXKVKe1E_pVDWX3u0W7WuKQmO54Z1Jgj-iL980yPew@mail.gmail.com>
Date: Mon, 25 Sep 2017 21:03:39 +0300
In-Reply-To: <CAFEAcA9FhXKVKe1E_pVDWX3u0W7WuKQmO54Z1Jgj-iL980yPew@mail.gmail.com>
	(Peter Maydell's message of "Mon, 18 Sep 2017 18:42:55 +0100")
Message-ID: <87o9pywt8k.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 01/22] instrument: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

First, sorry for the late response; I was away for a few days.


Peter Maydell writes:

> On 18 September 2017 at 18:09, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> =
wrote:
>> Peter Maydell writes:
>>> It's also exposing internal QEMU implementation detail.
>>> What if in future we decide to switch from our current
>>> setup to always interpreting guest instructions as a
>>> first pass with JITting done only in the background for
>>> hot code?
>>=20
>> TCI still has a separation of translation-time (translate.c) and executi=
on-time
>> (interpreting the TCG opcodes), and I don't think that's gonna go away a=
nytime
>> soon.

> I didn't mean TCI, which is nothing like what you'd use for
> this if you did it (TCI is slower than just JITting.)

My point is that even on the cold path you need to decode a guest instructi=
on
(equivalent to translating) and emulate it on the spot (equivalent to
executing).


>> Even if it did, I think there still will be a translation/execution sepa=
ration
>> easy enough to hook into (even if it's a "fake" one for the cold-path
>> interpreted instructions).

> But what would it mean? You don't have basic blocks any more.

Every instruction emulated on the spot can be seen as a newly translated bl=
ock
(of one instruction only), which is executed immediately after.


>>> Sticking to instrumentation events that correspond exactly to guest
>>> execution events means they won't break or expose internals.
>>=20
>> It also means we won't be able to "conditionally" instrument instruction=
s (e.g.,
>> based on their opcode, address range, etc.).

> You can still do that, it's just less efficient (your
> condition-check happens in the callout to the instrumentation
> plugin). We can add "filter" options later if we need them
> (which I would rather do than have translate-time callbacks).

Before answering, a short summary of when knowing about translate/execute m=
akes
a difference:

* Record some information only once when an instruction is translated, inst=
ead
  of recording it on every executed instruction (e.g., a study of opcode
  distribution, which you can get from a file of per-TB opcodes - generated=
 at
  translation time - and a list of executed TBs - generated at execution ti=
me
  -). The translate/execute separation makes this run faster *and* produces=
 much
  smaller files with the recorded info.

  Other typical examples that benefit from this are writing a simulator that
  feeds off a stream of instruction information (a common reason why people=
 want
  to trace memory accesses and information of executed instructions).

* Conditionally instrumenting instructions.

Adding filtering to the instrumentation API would only solve the second poi=
nt,
but not the first one.

Now, do we need/want to support the first point?


>> Of course we can add the translation/execution differentiation later if =
we find
>> it necessary for performance, but I would rather avoid leaving "historic=
al"
>> instrumentation points behind on the API.
>>=20
>> What are the use-cases you're aiming for?

> * I want to be able to point the small stream of people who come
> into qemu-devel asking "how do I trace all my guest's memory
> accesses" at a clean API for it.

> * I want to be able to have less ugly and confusing tracing
> than our current -d output (and perhaps emit tracing in formats
> that other analysis tools want as input)

> * I want to keep this initial tracing API simple enough that
> we can agree on it and get a first working useful version.

Fair enough.

I know it's not exactly the same we're discussing, but the plot in [1] comp=
ares
a few different ways to trace memory accesses on SPEC benchmarks:

* First bar is using a Intel's tool called PIN [2].
* Second is calling into an instrumentation function on every executed memo=
ry
  access in QEMU.
* Third is embedding the hot path of writing the memory access info to an a=
rray
  into the TCG opcode stream (more or less equivalent to supporting filteri=
ng;
  when the array is full, a user's callback is called - cold path -)
* Fourth bar can be ignored.

This was working on a much older version of instrumentation for QEMU, but I=
 can
implement something that does the first use-case point above and some filte=
ring
example (second use-case point) to see what's the performance difference.

[1] https://filetea.me/n3wy9WwyCCZR72E9OWXHArHDw
[2] https://software.intel.com/en-us/articles/pin-a-dynamic-binary-instrume=
ntation-tool


Thanks!
  Lluis
