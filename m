Received: from eggs.gnu.org ([2001:4830:134:3::10]:54068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dlOYf-00047m-QJ
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 20:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dlOYc-0001zR-Ky
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 20:02:37 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47059)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dlOYc-0001yz-CH
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 20:02:34 -0400
Date: Fri, 25 Aug 2017 20:02:32 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170826000232.GB29654@flamenco>
References: <CAFEAcA_pXX6ZCsBwAQnzQbTSbxzAh=nFpPeEzZoRBhBDt2r+vA@mail.gmail.com>
	<20170727104302.GI2555@redhat.com>
	<CAFEAcA8oyHi+7NVCE8YWHY+v0UXLbt2tWHGE4AP_V8TtDBc89g@mail.gmail.com>
	<20170727152137.GW2555@redhat.com>
	<CAFEAcA-eH7J+fFXYgFo6Wx58zgD8=kqhrGE5BqR+NrhHjipsFw@mail.gmail.com>
	<20170727154535.GY2555@redhat.com>
	<20170728133430.GS12364@stefanha-x1.localdomain>
	<CAFEAcA9p38P2x3s4grvFPkGaH+JEmwqyAC9SsLWqqFL8k+Eiww@mail.gmail.com>
	<20170728140623.GQ31495@redhat.com> <87vamclf6w.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87vamclf6w.fsf@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH 00/13] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jul 28, 2017 at 19:05:43 +0300, Lluís Vilanova wrote:
> As for the (minimum) requirements I've collected:
> 
> * Peek at register values and guest memory.
> * Enumerate guest cpus.
> * Control when events are raised to minimize overheads (e.g., avoid generating
>   TCG code to trace a guest code event we don't care about just now).
> * When a guest code event is raised at translation time, let instrumentor decide
>   if it needs to be raised at execution time too (e.g., might be decided on
>   instruction opcode)
> * Minimum overhead when instrumenting (I think the proposed fifo/socket approach
>   does not meet this; point 2 helps a lot here, which is what the current
>   tracing code does)
> * Let instrumentor know when TBs are being freed (i.e., to free internal per-TB
>   structures; I have a patch queued adding this event).
> 
> Nice to have:
> 
> * Avoid recompilation for each new instrumentation logic.
> * Poke at register values and guest memory.
> * [synchronous for sure] Let user annotate guest programs to raise additional
>   events with guest-specified information (the hypertrace series I sent).
> * [synchronous for sure] Make guest breakpoints/watchpoints raise an event (for
>   when we cannot annotate the guest code; I have some patches).
> * Trigger QEMU's event tracing routine when the instrumentation code
>   decides. This is what this series does now, as then lazy instrumentors don't
>   need to write their own tracing-to-disk code. Otherwise, per-event tracing
>   states would need to be independent of instrumentation states (but the logic
>   is exactly the same).
> * Let instrumentor define additional arguments to execution-time events during
>   translation-time (e.g., to quickly index into an instrumentor struct when the
>   execution-time event comes that references info collected during translation).
> * Attach an instrumentor-specified value to each guest CPU (e.g., pointing to
>   the instrumentor's cpu state). Might be less necessary if the point above is
>   met (if we only look at overall performance).

Agreed.

An additional "nice to have" would be:

* Allow inlining of TCG code by the instrumenter. Example use case:
  the instrumenter wants to increment a counter every time a
  basic block is executed. Instead of calling a callback function on every block's
  execution, we could just have a translation-time callback to emit at the beginning
  of the translated block the counter increment. This would be much faster, and
  is something that all other tools (e.g. DynamoRIO/Pin) implement.

		E.
