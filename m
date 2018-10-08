Received: from eggs.gnu.org ([2001:4830:134:3::10]:51931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9WJo-0004g2-3l
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9WJj-0002xM-Cj
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:15:32 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:43706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9WJi-0002wu-Pf
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:15:27 -0400
Received: by mail-wr1-x429.google.com with SMTP id n1-v6so21021905wrt.10
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 07:15:26 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181007012337.GA23787@flamenco> <875zycohpl.fsf@linaro.org>
	<20181008135953.GA19899@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181008135953.GA19899@flamenco>
Date: Mon, 08 Oct 2018 15:15:23 +0100
Message-ID: <87zhvomsn8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH  00/21] Trace updates and plugin RFC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu


Emilio G. Cota <cota@braap.org> writes:

> On Mon, Oct 08, 2018 at 11:28:38 +0100, Alex Benn=C3=A9e wrote:
>> Emilio G. Cota <cota@braap.org> writes:
>> > Again, for performance you'd avoid the tracepoint (i.e. calling
>> > a helper to call another function) and embed directly the
>> > callback from TCG. Same thing applies to TB's.
>>
>> OK I see what you mean. I think that is doable although it might take a
>> bit more tcg plumbing.
>
> I have patches to do it, it's not complicated.

Right that would be useful.

>
>> >> So what do people think? Could this be a viable way to extend QEMU
>> >> with plugins?
>> >
>> > For frequent events such as the ones mentioned above, I am
>> > not sure plugins can be efficiently implemented under
>> > tracing.
>>
>> I assume some form of helper-per-instrumented-event/insn is still going
>> to be needed though? We are not considering some sort of EBF craziness?
>
> Helper, yes. But one that points directly to plugin code.

It would be nice if the logic the inserts the trace helper vs a direct
call could be shared. I guess I'd have to see the implementation to see
how ugly it gets.

>
>> > For others (e.g. cpu_init events), sure, they could.
>> > But still, differently from tracers, plugins can come and go
>> > anytime, so I am not convinced that merging the two features
>> > is a good idea.
>>
>> I don't think we have to mirror tracepoints and plugin points but I'm in
>> favour of sharing the general mechanism and tooling rather than having a
>> whole separate set of hooks. We certainly don't want anything like:
>>
>>           trace_exec_tb(tb, pc);
>>           plugin_exec_tb(tb, pc);
>>
>> scattered throughout the code where the two do align.
>
> We could have something like
>
> 	plugin_trace_exec_tb(tb, pc);
>
> that would expand to the two lines above. Or similar.
>
> So I agree with you that in some cases the "trace points"
> for both tracing and plugin might be the same, perhaps
> identical. But that doesn't necessarily mean that making
> plugins a subset of tracing is a good idea.

But we can avoid having plugin-points and trace-events duplicating stuff
as well? I guess you want to avoid having the generated code fragments
for plugins?

The other nice property was avoiding re-duplicating output logic for
"filter" style operations. However I didn't actually included such an
example in the series. I was pondering a QEMU powered PLT/library call
tracer to demonstrate that sort of thing.

> I think sharing my plugin implementation will help the
> discussion. I'll share it as soon as I can (my QEMU plate
> is full already trying to merge a couple of other features
> first).

Sounds good.

>
> Thanks,
>
> 		Emilio


--
Alex Benn=C3=A9e
