Received: from eggs.gnu.org ([2001:4830:134:3::10]:34612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1e3loG-0005kM-85
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1e3loB-0000lJ-9r
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:30:40 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:35069 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1e3loA-0000jp-Ra
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:30:35 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <87d16o53xr.fsf@frigg.lan>
	<CAFEAcA9FhXKVKe1E_pVDWX3u0W7WuKQmO54Z1Jgj-iL980yPew@mail.gmail.com>
	<87o9pywt8k.fsf@frigg.lan> <87shf5zlty.fsf@frigg.lan>
	<20170929175943.GA25038@flamenco> <87vak1w53a.fsf@frigg.lan>
	<20170930180941.GA22048@flamenco> <8760bu333n.fsf@frigg.lan>
	<20171005005043.GA20425@flamenco> <87vajsl3h7.fsf@frigg.lan>
	<20171006175929.GA28281@flamenco>
Date: Sun, 15 Oct 2017 19:30:20 +0300
In-Reply-To: <20171006175929.GA28281@flamenco> (Emilio G. Cota's message of
	"Fri, 6 Oct 2017 13:59:29 -0400")
Message-ID: <87tvz08jc3.fsf@frigg.lan>
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

> On Fri, Oct 06, 2017 at 18:07:16 +0300, Llu=C3=ADs Vilanova wrote:
>> Emilio G Cota writes:
>> > On Thu, Oct 05, 2017 at 02:28:12 +0300, Llu=C3=ADs Vilanova wrote:
>> >> The API takes care of telling you if the access could be performed
>> >> successfully. If you access the instruction's memory representation at
>> >> translation time, it should be able to perform the access, since QEMU=
's
>> >> translation loop just had to do so in order to access that instructio=
n (I should
>> >> check what happens in the corner case where another guest CPU changes=
 the page
>> >> table, since I'm not sure if the address translation functions I'm us=
ing in QEMU
>> >> will use the per-vCPU TLB cache or always traverse the page table).
>>=20
>> > That was my concern, I'd rather just perform the read once, that is, t=
he read(s)
>> > done by ops->insn_translate.
>>=20
>> If your concern is on performance, that should not be an issue, since yo=
u'd be
>> using the memory peek functions at translation-time. Furthermore, since =
others
>> suggested having memory peek anyway, that's a nicer way (to me) to compo=
se APIs
>> (and is less complex to implement).

> My concern was the same as yours, correctness -- what happens if something
> changes between the two reads? Because the two reads should always return
> the same thing.

Thinking about it, shouldn't this always be the same given QEMU's TLB/page =
table
consistency assurances? Otherwise, QEMU could read bytes from different phy=
sical
pages while translating an instruction from the same virtual page.

Therefore, this leads me to believe it is safe to use the memory read opera=
tions
during translation to let instrumentation libraries know what exactly they =
are
dealing with.



>> > I see. I implemented what I suggested above, i.e. tb_trans_cb
>> > (i.e. post_trans) passes an opaque descriptor of the TB (which can
>> > be iterated over insn by insn) and the return value (void *) of this
>> > cb will be passed by tb_exec_cb (i.e. pre_exec).  Perf-wise this
>> > is pretty OK, turns out even if we don't end up caring about the
>> > TB, the additional per-TB helper (which might not end up calling
>> > a callback) does not introduce significant overhead at execution time.
>>=20
>> So you build this structure after translating the whole TB, and the user=
 can
>> iterate it to check the translated instructions. This is closer to other
>> existing tools: you iterate the structure and then decide which/how to
>> instrument instructions, memory accesses, etc within it.

> Correct. I suspect they went with this design because it makes sense to
> do this preprocessing once, instead of having each plugin do it
> themselves. I'm not sure how much we should care about supporting multiple
> plugins, but the impression I get from DynamoRIO is that it seems importa=
nt
> to users.

If that can be built into a "helper" instrumentation library / header that
others can use, I would rather keep this functionality outside QEMU.


>> My only concern is that this is much more complex than the simpler API I=
 propose
>> (you must build the informational structures, generate calls to every po=
ssible
>> instrumentation call, which will be optimized-out by TCG if the user dec=
ides not
>> to use them, and overall pay in performance for any unused functionality=
),
>> whereas your approach can be implemented on top of it.

> It's pretty simple; tr_ops->translate_insn has to copy each insn.
> For instance, on aarch64 (disas_a64 is called from tr_translate_insn):

> -static void disas_a64_insn(CPUARMState *env, DisasContext *s)
> +static void disas_a64_insn(CPUARMState *env, DisasContext *s, struct qem=
u_plugin_insn *q_insn)
>  {
>      uint32_t insn;

>      insn =3D arm_ldl_code(env, s->pc, s->sctlr_b);
> +    if (q_insn) {
> +        qemu_plugin_insn_append(q_insn, &insn, sizeof(insn));
> +    }

> It takes some memory though (we duplicate the guest code), but perf-wise =
this
> isn't a big deal (an empty callback on every TB execution incurs only a 1=
0-15%
> perf slowdown).

> I don't understand the part where you say that the instrumentation call c=
an
> be optimized out. Is there a special value of a "TCG promise" (at tb_tran=
s_post
> time) that removes the previously generated callback (at tb_trans_pre tim=
e)?
> Otherwise I don't see how selective TB instrumentation can work at tb_tra=
ns_pre
> time.

With the approach you propose, the instrumentation library is only called at
translation-time after the whole TB has been generated. If the instrumentor=
 now
decides to instrument each instruction, this means QEMU must inject an
instrumentation call to every instruction while translating the TB *just in
case* the instrumentor will need it later. In case the instrumentor decides=
 some
instructions don't need to be instrumented, now QEMU needs to eliminate them
from the TB before generating the host code (in order to eliminate unnecess=
ary
overheads).

Hope it's clearer now.


Thanks!
  Lluis
