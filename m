Received: from eggs.gnu.org ([2001:4830:134:3::10]:34243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8xnL-0000PT-66
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 21:23:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8xnI-0007DJ-2B
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 21:23:43 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60937)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g8xnH-0007Cy-P8
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 21:23:39 -0400
Date: Sat, 6 Oct 2018 21:23:37 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181007012337.GA23787@flamenco>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH  00/21] Trace updates and plugin RFC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu

On Fri, Oct 05, 2018 at 16:48:49 +0100, Alex Bennée wrote:
(snip)
> ==Known Limitations==
> 
> Currently there is only one hook allowed per trace event. We could
> make this more flexible or simply just error out if two plugins try
> and hook to the same point. What are the expectations of running
> multiple plugins hooking into the same point in QEMU?

It's very common. All popular instrumentation tools (e.g. PANDA,
DynamoRIO, Pin) support multiple plugins.

> ==TCG Hooks==
> 
> Thanks to Lluís' work the trace API already splits up TCG events into
> translation time and exec time events and provides the machinery for
> hooking a trace helper into the translation stream. Currently that
> helper is unconditionally added although perhaps we could expand the
> call convention a little for TCG events to allow the translation time
> event to filter out planting the execution time helper?

A TCG helper is suboptimal for these kind of events, e.g. instruction/TB/
mem callbacks, because (1) these events happen *very* often, and
(2) a helper then has to iterate over a list of callbacks (assuming
we support multiple plugins). That is, one TCG helper call,
plus cache misses for the callback pointers, plus function calls
to call the callbacks. That adds up to 2x average slowdown
for SPEC06int, instead of 1.5x slowdown when embedding the
callbacks directly into the generated code. Yes, you have to
flush the code when unsubscribing from the event, but that cost
is amortized by the savings you get when the callbacks occur,
which are way more frequent.

Besides performance, to provide a pleasant plugin experience we need
something better than the current tracing callbacks.

> ===Instruction Tracing===
> 
> Pavel's series had a specific hook for instrumenting individual
> instructions. I have not yet added it to this series but I think it be
> done in a slightly cleaner way now we have the ability to insert TCG
> ops into the instruction stream.

I thought Peter explicitly disallowed TCG generation from plugins.
Also, IIRC others also mentioned that exposing QEMU internals
(e.g. "struct TranslationBlock", or "struct CPUState") to plugins
was not on the table.

> If we add a tracepoint for post
> instruction generation which passes a buffer with the instruction
> translated and method to insert a helper before or after the
> instruction. This would avoid exposing the cpu_ldst macros to the
> plugins.

Again, for performance you'd avoid the tracepoint (i.e. calling
a helper to call another function) and embed directly the
callback from TCG. Same thing applies to TB's.

> So what do people think? Could this be a viable way to extend QEMU
> with plugins?

For frequent events such as the ones mentioned above, I am
not sure plugins can be efficiently implemented under
tracing. For others (e.g. cpu_init events), sure, they could.
But still, differently from tracers, plugins can come and go
anytime, so I am not convinced that merging the two features
is a good idea.

Thanks,

		Emilio
