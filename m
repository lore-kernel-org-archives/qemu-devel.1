Received: from eggs.gnu.org ([2001:4830:134:3::10]:55485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9SrE-0003dy-FS
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 06:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9SmQ-0005Dg-IH
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 06:28:54 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9SmL-0005B2-0a
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 06:28:48 -0400
Received: by mail-wr1-x443.google.com with SMTP id 63-v6so20177026wra.11
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 03:28:41 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181007012337.GA23787@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181007012337.GA23787@flamenco>
Date: Mon, 08 Oct 2018 11:28:38 +0100
Message-ID: <875zycohpl.fsf@linaro.org>
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

> On Fri, Oct 05, 2018 at 16:48:49 +0100, Alex Benn=C3=A9e wrote:
> (snip)
>> =3D=3DKnown Limitations=3D=3D
>>
>> Currently there is only one hook allowed per trace event. We could
>> make this more flexible or simply just error out if two plugins try
>> and hook to the same point. What are the expectations of running
>> multiple plugins hooking into the same point in QEMU?
>
> It's very common. All popular instrumentation tools (e.g. PANDA,
> DynamoRIO, Pin) support multiple plugins.

Fair enough.

>
>> =3D=3DTCG Hooks=3D=3D
>>
>> Thanks to Llu=C3=ADs' work the trace API already splits up TCG events in=
to
>> translation time and exec time events and provides the machinery for
>> hooking a trace helper into the translation stream. Currently that
>> helper is unconditionally added although perhaps we could expand the
>> call convention a little for TCG events to allow the translation time
>> event to filter out planting the execution time helper?
>
> A TCG helper is suboptimal for these kind of events, e.g. instruction/TB/
> mem callbacks, because (1) these events happen *very* often, and
> (2) a helper then has to iterate over a list of callbacks (assuming
> we support multiple plugins). That is, one TCG helper call,
> plus cache misses for the callback pointers, plus function calls
> to call the callbacks. That adds up to 2x average slowdown
> for SPEC06int, instead of 1.5x slowdown when embedding the
> callbacks directly into the generated code. Yes, you have to
> flush the code when unsubscribing from the event, but that cost
> is amortized by the savings you get when the callbacks occur,
> which are way more frequent.

What would you want instead of a TCG helper? But certainly being able be
selective about which instances of each trace point are instrumented
will be valuable.

> Besides performance, to provide a pleasant plugin experience we need
> something better than the current tracing callbacks.

What I hope to avoid in re-using trace points is having a whole bunch of
a additional hook points just for plugins. However nothing stops us
adding more tracepoints at more useful places for instrumentation. We
could also do it on a whitelist basis similar to the way the tcg events
are marked.

>
>> =3D=3D=3DInstruction Tracing=3D=3D=3D
>>
>> Pavel's series had a specific hook for instrumenting individual
>> instructions. I have not yet added it to this series but I think it be
>> done in a slightly cleaner way now we have the ability to insert TCG
>> ops into the instruction stream.
>
> I thought Peter explicitly disallowed TCG generation from plugins.
> Also, IIRC others also mentioned that exposing QEMU internals
> (e.g. "struct TranslationBlock", or "struct CPUState") to plugins
> was not on the table.

We definitely want to avoid plugin controlled code generation but the
tcg tracepoint mechanism is transparent to the plugin itself. I think
the pointers should really be treated as anonymous handles rather than
windows into QEMU's internals. Arguably some of the tracepoints should
be exporting more useful numbers (I used cpu->cpu_index in the TLB trace
points) but I don't know if we can change existing trace point
definitions to clean that up.

Again if we whitelist tracepoints for plugins we can be more careful
about the data exported.

>
>> If we add a tracepoint for post
>> instruction generation which passes a buffer with the instruction
>> translated and method to insert a helper before or after the
>> instruction. This would avoid exposing the cpu_ldst macros to the
>> plugins.
>
> Again, for performance you'd avoid the tracepoint (i.e. calling
> a helper to call another function) and embed directly the
> callback from TCG. Same thing applies to TB's.

OK I see what you mean. I think that is doable although it might take a
bit more tcg plumbing.

>
>> So what do people think? Could this be a viable way to extend QEMU
>> with plugins?
>
> For frequent events such as the ones mentioned above, I am
> not sure plugins can be efficiently implemented under
> tracing.

I assume some form of helper-per-instrumented-event/insn is still going
to be needed though? We are not considering some sort of EBF craziness?

> For others (e.g. cpu_init events), sure, they could.
> But still, differently from tracers, plugins can come and go
> anytime, so I am not convinced that merging the two features
> is a good idea.

I don't think we have to mirror tracepoints and plugin points but I'm in
favour of sharing the general mechanism and tooling rather than having a
whole separate set of hooks. We certainly don't want anything like:

          trace_exec_tb(tb, pc);
          plugin_exec_tb(tb, pc);

scattered throughout the code where the two do align.

>
> Thanks,
>
> 		Emilio


--
Alex Benn=C3=A9e
