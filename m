Received: from eggs.gnu.org ([2001:4830:134:3::10]:36784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1e0UDy-0007w4-LG
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1e0UDu-0008Sf-GD
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:07:38 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:34496 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1e0UDt-0008Kz-Sv
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:07:34 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <87poasgjyh.fsf@frigg.lan>
	<CAFEAcA8XP+8Jz9Dn-mEQ3CCrVj00t3HA0praQ-OSggtQGAmQ5Q@mail.gmail.com>
	<87d16o53xr.fsf@frigg.lan>
	<CAFEAcA9FhXKVKe1E_pVDWX3u0W7WuKQmO54Z1Jgj-iL980yPew@mail.gmail.com>
	<87o9pywt8k.fsf@frigg.lan> <87shf5zlty.fsf@frigg.lan>
	<20170929175943.GA25038@flamenco> <87vak1w53a.fsf@frigg.lan>
	<20170930180941.GA22048@flamenco> <8760bu333n.fsf@frigg.lan>
	<20171005005043.GA20425@flamenco>
Date: Fri, 06 Oct 2017 18:07:16 +0300
In-Reply-To: <20171005005043.GA20425@flamenco> (Emilio G. Cota's message of
	"Wed, 4 Oct 2017 20:50:43 -0400")
Message-ID: <87vajsl3h7.fsf@frigg.lan>
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

> On Thu, Oct 05, 2017 at 02:28:12 +0300, Llu=C3=ADs Vilanova wrote:
>> Emilio G Cota writes:
>> > I see some potential problems with this:
>> > 1. Instrumenters' accesses could generate exceptions. I presume we'd w=
ant to avoid
>> >    this, or leave it as a debug-only kind of option.
>>=20
>> The API takes care of telling you if the access could be performed
>> successfully. If you access the instruction's memory representation at
>> translation time, it should be able to perform the access, since QEMU's
>> translation loop just had to do so in order to access that instruction (=
I should
>> check what happens in the corner case where another guest CPU changes th=
e page
>> table, since I'm not sure if the address translation functions I'm using=
 in QEMU
>> will use the per-vCPU TLB cache or always traverse the page table).

> That was my concern, I'd rather just perform the read once, that is, the =
read(s)
> done by ops->insn_translate.

If your concern is on performance, that should not be an issue, since you'd=
 be
using the memory peek functions at translation-time. Furthermore, since oth=
ers
suggested having memory peek anyway, that's a nicer way (to me) to compose =
APIs
(and is less complex to implement).


>> > 2. Instrumenters won't know where the end of an instruction (for varia=
ble-length
>> >   ISAs) or of a TB is (TB !=3D basic block). For instructions one coul=
d have a loop
>> >   where we read byte-by-byte and pass it to the decoder, something sim=
ilar to
>> >   what we have in the capstone code recently posted to the list (v4). =
For TBs,
>> >   we really should have a way to delimit the length of the TB. This is=
 further
>> >   complicated if we want instrumentation to be inserted *before* a TB =
is
>> >   translated.
>>=20
>> > Some thoughts on the latter problem: if we want a tb_trans_pre callbac=
k, like
>> > Pin/DynamoRIO provide, instead of doing two passes (one to delimit the=
 TB and
>> > call the tb_trans_pre callback, to then generate the translated TB), w=
e could:
>> >   - have a tb_trans_pre callback. This callback inserts an exec-time c=
allback
>> >     with a user-defined pointer (let's call it **tb_info). The callbac=
k has
>> >     no arguments, perhaps just the pc.
>> >   - have a tb_trans_post callback. This one passes a copy of the guest
>> >     instructions. The instrumenter then can allocate whatever data str=
ucture
>> >     to represent the TB (*tb_info), and copies this pointer to **tb_in=
fo, so
>> >     that at execution time, we can obtain tb_info _before_ the TB is e=
xecuted.
>> >     After the callback returns, the copy of the guest instructions can=
 be freed.
>> >   This has two disadvantages:
>> >   - We have an extra dereference to find tb_info
>> >   - If it turns out that the TB should not be instrumented, we have ge=
nerated
>> >     a callback for nothing.
>>=20
>> That's precisely one of the reasons why I proposed adding instrumentatio=
n points
>> before and after events happen (e.g., instrument right after translating=
 an
>> instruction, where you know its size).
>>=20
>> What you propose is actually a broader issue, how to allow instrumentors=
 to pass
>> their own data to execution-time functions "after the fact". For this, I
>> implemented "promises", a kind of generalization of what gen_icount() do=
es (you
>> pass a value to the execution-time callback that is computed later during
>> translation-time).

> I see. I implemented what I suggested above, i.e. tb_trans_cb
> (i.e. post_trans) passes an opaque descriptor of the TB (which can
> be iterated over insn by insn) and the return value (void *) of this
> cb will be passed by tb_exec_cb (i.e. pre_exec).  Perf-wise this
> is pretty OK, turns out even if we don't end up caring about the
> TB, the additional per-TB helper (which might not end up calling
> a callback) does not introduce significant overhead at execution time.

So you build this structure after translating the whole TB, and the user can
iterate it to check the translated instructions. This is closer to other
existing tools: you iterate the structure and then decide which/how to
instrument instructions, memory accesses, etc within it.

My only concern is that this is much more complex than the simpler API I pr=
opose
(you must build the informational structures, generate calls to every possi=
ble
instrumentation call, which will be optimized-out by TCG if the user decide=
s not
to use them, and overall pay in performance for any unused functionality),
whereas your approach can be implemented on top of it.


> The major hurdle I found is what to do when removing a plugin,
> so that we avoid flushing potentially all translated code. What I ended up
> doing is adding a per-TB list of "plugin_tb" descriptors, which
> track these user pointers so that (1) each plugin gets the right
> pointer, and (2) if n_plugins > 1, we still have a single helper
> that dispatches the callbacks instead of n_plugin helpers.

I'm not sure it's worth optimising for the multiple plugin case.


> If I understand correctly, with promises we directly generate
> a callback, which has the promise(s) as one (or more) of its
> arguments. This is neat and very flexible. However, it forces us to
> retranslate the TB when the plugin is removed (if we're lazy we could
> flush all TBs), and if we have several plugins, we end up with one
> helper per callback, instead of a single one.
> None of this is a huge deal though, I just think is worth considering.

Yes, that happens seldomly enough that the flush cost is negligible.

> Also, I'm not sure Peter and others would be happy with allowing
> plugin code to generate arbitrary callbacks (IIRC arbitrary code
> has already been ruled out). So perhaps a more restrictive option
> like what I suggested above would be more palatable.

AFAIU, arbitrary access to QEMU's structures was ruled out, but not generat=
ing
calls to arbitrary user functions.


Cheers,
  Lluis
