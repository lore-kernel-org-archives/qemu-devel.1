Received: from eggs.gnu.org ([2001:4830:134:3::10]:56091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dzt5k-0003p5-Uk
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 19:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dzt5f-0004Fc-Ou
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 19:28:40 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:35742 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dzt5f-0004Cy-9x
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 19:28:35 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150529666493.10902.14830445134051381968.stgit@frigg.lan>
	<CAFEAcA9p9B8AFaaSaSOOSsFsEhHW=XPLBFs5MrozWq=7p4_9Zg@mail.gmail.com>
	<87poasgjyh.fsf@frigg.lan>
	<CAFEAcA8XP+8Jz9Dn-mEQ3CCrVj00t3HA0praQ-OSggtQGAmQ5Q@mail.gmail.com>
	<87d16o53xr.fsf@frigg.lan>
	<CAFEAcA9FhXKVKe1E_pVDWX3u0W7WuKQmO54Z1Jgj-iL980yPew@mail.gmail.com>
	<87o9pywt8k.fsf@frigg.lan> <87shf5zlty.fsf@frigg.lan>
	<20170929175943.GA25038@flamenco> <87vak1w53a.fsf@frigg.lan>
	<20170930180941.GA22048@flamenco>
Date: Thu, 05 Oct 2017 02:28:12 +0300
In-Reply-To: <20170930180941.GA22048@flamenco> (Emilio G. Cota's message of
	"Sat, 30 Sep 2017 14:09:41 -0400")
Message-ID: <8760bu333n.fsf@frigg.lan>
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

Emilio G Cota writes:

> On Sat, Sep 30, 2017 at 00:46:33 +0300, Llu=C3=ADs Vilanova wrote:
>> Emilio G Cota writes:
>> > I'm not sure I understand this concept of filtering. Are you saying th=
at in
>> > the first case, all memory accesses are instrumented, and then in the
>> > "access helper" we only call the user's callback if it's a memory writ=
e?
>> > And in the second case, we simply just generate a "write helper" inste=
ad
>> > of an "access helper". Am I understanding this correctly?
>>=20
>> In the previous case (no filtering), the user callback is always called =
when a
>> memory access is *executed*, and the user then checks if the access mode=
 is a
>> write to decide whether to increment a counter.
>>=20
>> In this case (with filtering), a user callback is called when a memory a=
ccess is
>> *translated*, and if the access mode is a write, the user generates a ca=
ll to a
>> second callback that is executed every time a memory access is executed =
(only
>> that it is only generated for memory writes, the ones we care about).
>>=20
>> Is this clearer?

> I get it now, thanks!

>> > FWIW my experiments so far show similar numbers for instrumenting each
>> > instruction (haven't done the per-tb yet). The difference is that I'm
>> > exposing to instrumenters a copy of the guest instructions (const void=
 *data,
>> > size_t size). These copies are kept around until TB's are flushed.
>> > Luckily there seems to be very little overhead in keeping these around,
>> > apart from the memory overhead -- but in terms of performance, the
>> > necessary allocations do not induce significant overhead.
>>=20
>> To keep this use-case simpler, I added the memory access API I posted in=
 this
>> series, where instrumenters can read guest memory (more general than pas=
sing a
>> copy of the current instruction).

> I see some potential problems with this:
> 1. Instrumenters' accesses could generate exceptions. I presume we'd want=
 to avoid
>    this, or leave it as a debug-only kind of option.

The API takes care of telling you if the access could be performed
successfully. If you access the instruction's memory representation at
translation time, it should be able to perform the access, since QEMU's
translation loop just had to do so in order to access that instruction (I s=
hould
check what happens in the corner case where another guest CPU changes the p=
age
table, since I'm not sure if the address translation functions I'm using in=
 QEMU
will use the per-vCPU TLB cache or always traverse the page table).


> 2. Instrumenters won't know where the end of an instruction (for variable=
-length
>   ISAs) or of a TB is (TB !=3D basic block). For instructions one could h=
ave a loop
>   where we read byte-by-byte and pass it to the decoder, something simila=
r to
>   what we have in the capstone code recently posted to the list (v4). For=
 TBs,
>   we really should have a way to delimit the length of the TB. This is fu=
rther
>   complicated if we want instrumentation to be inserted *before* a TB is
>   translated.

> Some thoughts on the latter problem: if we want a tb_trans_pre callback, =
like
> Pin/DynamoRIO provide, instead of doing two passes (one to delimit the TB=
 and
> call the tb_trans_pre callback, to then generate the translated TB), we c=
ould:
>   - have a tb_trans_pre callback. This callback inserts an exec-time call=
back
>     with a user-defined pointer (let's call it **tb_info). The callback h=
as
>     no arguments, perhaps just the pc.
>   - have a tb_trans_post callback. This one passes a copy of the guest
>     instructions. The instrumenter then can allocate whatever data struct=
ure
>     to represent the TB (*tb_info), and copies this pointer to **tb_info,=
 so
>     that at execution time, we can obtain tb_info _before_ the TB is exec=
uted.
>     After the callback returns, the copy of the guest instructions can be=
 freed.
>   This has two disadvantages:
>   - We have an extra dereference to find tb_info
>   - If it turns out that the TB should not be instrumented, we have gener=
ated
>     a callback for nothing.

That's precisely one of the reasons why I proposed adding instrumentation p=
oints
before and after events happen (e.g., instrument right after translating an
instruction, where you know its size).

What you propose is actually a broader issue, how to allow instrumentors to=
 pass
their own data to execution-time functions "after the fact". For this, I
implemented "promises", a kind of generalization of what gen_icount() does =
(you
pass a value to the execution-time callback that is computed later during
translation-time).


Cheers,
  Lluis
