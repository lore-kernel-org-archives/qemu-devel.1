Received: from eggs.gnu.org ([2001:4830:134:3::10]:33043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1db7m7-0006bd-Fj
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1db7m2-0000E4-H2
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:06:03 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:36134)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1db7m1-0000BZ-W2
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:05:58 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
	<20170726112633.GE18489@stefanha-x1.localdomain>
	<CAFEAcA_pXX6ZCsBwAQnzQbTSbxzAh=nFpPeEzZoRBhBDt2r+vA@mail.gmail.com>
	<20170727104302.GI2555@redhat.com>
	<CAFEAcA8oyHi+7NVCE8YWHY+v0UXLbt2tWHGE4AP_V8TtDBc89g@mail.gmail.com>
	<20170727152137.GW2555@redhat.com>
	<CAFEAcA-eH7J+fFXYgFo6Wx58zgD8=kqhrGE5BqR+NrhHjipsFw@mail.gmail.com>
	<20170727154535.GY2555@redhat.com>
	<20170728133430.GS12364@stefanha-x1.localdomain>
	<CAFEAcA9p38P2x3s4grvFPkGaH+JEmwqyAC9SsLWqqFL8k+Eiww@mail.gmail.com>
	<20170728140623.GQ31495@redhat.com>
Date: Fri, 28 Jul 2017 19:05:43 +0300
In-Reply-To: <20170728140623.GQ31495@redhat.com> (Daniel P. Berrange's message
	of "Fri, 28 Jul 2017 15:06:23 +0100")
Message-ID: <87vamclf6w.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Daniel P Berrange writes:

> On Fri, Jul 28, 2017 at 02:41:19PM +0100, Peter Maydell wrote:
>> On 28 July 2017 at 14:34, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> > Llu=C3=ADs/Peter: What are the requirements for instrumentation code
>> > interacting with the running QEMU instance?  simpletrace is
>> > asynchronous, meaning it does not wait for anyone handle the trace eve=
nt
>> > before continuing execution, and is therefore not suitable for
>> > SystemTap-style scripts that can interact with the program while
>> > handling a trace event.
>>=20
>> I think you'd probably want synchronous -- it's pretty helpful
>> to be able to say "register a trace event hook that doesn't
>> fire very often, and use that to get to the region of
>> execution that's of interest to you, then enable more hooks
>> to get more detail at that point". (For instance, "wait til
>> we've executed 5,000,000 instructions, then turn on the
>> tracing of all instruction execution, register modification
>> and memory accesses".)

> Currently simpletrace probes have a fixed action when they are enabled,
> namely to print state to the trace log file. Perhaps we can make the
> action more flexible, if we create a more formal protocol for simpletrace
> to let it talk over a UNIX socket. By default it could send probe data
> asynchronously as now, but you could mark probes such that they require
> a synchronous ACK, thus pausing execution until that ACK is received
> from the instrumenting program.

> For that to be useful, we would need to have allow probes to be turned
> on/off via this trace socket, since the normal HMP/QMP monitor execution
> would be blocked while this probe is running.

This sounds like much more work to me for much lower performance (copy thro=
ugh
fifo/socket & process synchronization). Especially if many interesting even=
ts
become "synchronous". Also, with MTTCG using fifos becomes more complex on =
both
sides (select on the client & synchronization of events between streams on =
both
sides).

As a performance example, I've used the approach of this series to perform =
some
non-trivial instrumentation and I can get performance on par with PIN (a
state-of-the-art tool from intel) on most SPEC benchmarks.

Honestly, I would try to see if there's a GPL-preserving way to allow native
instrumentation libraries to run inside QEMU (either dynamic or static, tha=
t's
less important to me).

As for the (minimum) requirements I've collected:

* Peek at register values and guest memory.
* Enumerate guest cpus.
* Control when events are raised to minimize overheads (e.g., avoid generat=
ing
  TCG code to trace a guest code event we don't care about just now).
* When a guest code event is raised at translation time, let instrumentor d=
ecide
  if it needs to be raised at execution time too (e.g., might be decided on
  instruction opcode)
* Minimum overhead when instrumenting (I think the proposed fifo/socket app=
roach
  does not meet this; point 2 helps a lot here, which is what the current
  tracing code does)
* Let instrumentor know when TBs are being freed (i.e., to free internal pe=
r-TB
  structures; I have a patch queued adding this event).

Nice to have:

* Avoid recompilation for each new instrumentation logic.
* Poke at register values and guest memory.
* [synchronous for sure] Let user annotate guest programs to raise addition=
al
  events with guest-specified information (the hypertrace series I sent).
* [synchronous for sure] Make guest breakpoints/watchpoints raise an event =
(for
  when we cannot annotate the guest code; I have some patches).
* Trigger QEMU's event tracing routine when the instrumentation code
  decides. This is what this series does now, as then lazy instrumentors do=
n't
  need to write their own tracing-to-disk code. Otherwise, per-event tracing
  states would need to be independent of instrumentation states (but the lo=
gic
  is exactly the same).
* Let instrumentor define additional arguments to execution-time events dur=
ing
  translation-time (e.g., to quickly index into an instrumentor struct when=
 the
  execution-time event comes that references info collected during translat=
ion).
* Attach an instrumentor-specified value to each guest CPU (e.g., pointing =
to
  the instrumentor's cpu state). Might be less necessary if the point above=
 is
  met (if we only look at overall performance).


Cheers,
  Lluis
