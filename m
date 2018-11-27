Received: from eggs.gnu.org ([2001:4830:134:3::10]:40241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gReev-0006Z6-Fu
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRees-0003cX-6B
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:48:17 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:50946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gReer-0003bu-VD
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:48:14 -0500
Received: by mail-wm1-x336.google.com with SMTP id 125so22172747wmh.0
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 06:48:13 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-39-cota@braap.org>
	<87k1kz50pb.fsf@linaro.org> <20181127021612.GF22108@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181127021612.GF22108@flamenco>
Date: Tue, 27 Nov 2018 14:48:11 +0000
Message-ID: <87ftvm4lw4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 38/48] translator: implement 2-pass
 translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> On Mon, Nov 26, 2018 at 15:16:00 +0000, Alex Benn=C3=A9e wrote:
>> Emilio G. Cota <cota@braap.org> writes:
> (snip)
>> > +    if (tb_trans_cb && first_pass) {
>> > +        qemu_plugin_tb_trans_cb(cpu, plugin_tb);
>> > +        first_pass =3D false;
>> > +        goto translate;
>> > +    }
>>
>> So the only reason we are doing this two pass tango is to ensure the
>> plugin can insert TCG ops before the actual translation has occurred?
>
> Not only. The idea is to provide plugins with well-defined TBs,
> i.e. the instruction sizes and contents can be queried by the plugin
> before the plugin decides how/where to instrument the TB.

Hmmm, this seems a little to close to internal knowledge of the TCG. Is
the idea that a plugin might make a different decision based on the
number of a particular type of instruction in the translation block?

This seems like it would get broken if we wanted to implement other
types of TranslationBlock (e.g. hot-blocks with multiple exits for the
non-hot case).

That said looking at the examples using it so far it doesn't seem to be
doing more than looking at the total number of instructions for a given
translation block.

> Since in the targets we generate TCG code and also generate
> host code in a single shot (TranslatorOps.translate_insn),
> the 2-pass approach is a workaround to first get the
> well-defined TB, and in the second pass inject the instrumentation
> in the appropriate places.

Richard's suggestion of providing a central translator_ldl_code could
keep the book keeping of each instruction location and contents in the
core translator. With a little tweaking to the TCG we could then insert
our instrumentation at the end of the pass with all the knowledge we
want to export to the plugin.

Inserting instrumentation after instructions have executed will be
trickier though due to reasons Peter mentioned on IRC.

> This is a bit of a waste but given that it only happens at
> translate time, it can have negligible performance impact --
> I measured a 0.13% gmean slowdown for SPEC06int.

I'm less concerned about efficiency as complicating the code, especially
if we are baking in concepts that restrict our freedom to change code
generation around going forward.

>
>> I think we can do better, especially as the internal structures of
>> TCGops are implemented as a list so ops and be inserted before and after
>> other ops. This is currently only done by the optimiser at the moment,
>> see:
>>
>>   TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op, TCGOpcode opc, i=
nt narg);
>>   TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op, TCGOpcode opc, in=
t narg);
>>
>> and all the base tcg ops end up going to tcg_emit_op which just appends
>> to the tail. But if we can come up with a neater way to track the op
>> used before the current translated expression we could do away with two
>> phases translation completely.
>
> This list of ops is generated via TranslatorOps.translate_insn.
> Unfortunately, this function also defines the guest insns that form the T=
B.
> Decoupling the two actions ("define the TB" and "translate to TCG ops")
> would be ideal, but I didn't want to rewrite all the target translators
> in QEMU, and opted instead for the 2-pass approach as a compromise.

I don't quite follow. When we've done all our translation into TCG ops
haven't we by definition defined the TB?

Maybe the interface shouldn't be per-insn and per-TB but just an
arbitrary chunk of instructions. We could call the plugin with a list of
instructions with some opaque data that can be passed back to the plugin
APIs to allow insertion of instrumentation at the appropriate points.
The initial implementation would be a single-pass and called after the
TCG op generation. An instruction counter plugin would then be free to
insert counter instrumentation as frequently or infrequently as it
wants. These chunks wouldn't have to be tied to the internals of TCG and
in the worst case we could just inform the plugin in 1 insn chunks
without having to change the API?

What do you think?


--
Alex Benn=C3=A9e
