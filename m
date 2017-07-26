Received: from eggs.gnu.org ([2001:4830:134:3::10]:49122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1daLOw-0001Pb-8l
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1daLOs-0006M9-Ru
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:26:54 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:40311)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1daLOs-0006L6-FW
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:26:50 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<20170725131931.GC23343@stefanha-x1.localdomain>
	<CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
	<20170726112633.GE18489@stefanha-x1.localdomain>
	<CAFEAcA_pXX6ZCsBwAQnzQbTSbxzAh=nFpPeEzZoRBhBDt2r+vA@mail.gmail.com>
Date: Wed, 26 Jul 2017 15:26:32 +0300
In-Reply-To: <CAFEAcA_pXX6ZCsBwAQnzQbTSbxzAh=nFpPeEzZoRBhBDt2r+vA@mail.gmail.com>
	(Peter Maydell's message of "Wed, 26 Jul 2017 12:49:00 +0100")
Message-ID: <87379j5qpz.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell writes:

> On 26 July 2017 at 12:26, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> On Tue, Jul 25, 2017 at 02:30:06PM +0100, Peter Maydell wrote:
>>> Is your proposal that my-instrumentation.c gets compiled into
>>> QEMU at this point? That doesn't seem like a great idea to
>>> me, because it means you can only use this tracing if you
>>> build QEMU yourself, and distros won't enable it and so
>>> lots of our users won't have convenient access to it.
>>> I'd much rather see a cleanly designed plugin interface
>>> (which we should be able to implement in a manner that doesn't
>>> let the plugin monkey patch arbitrary parts of QEMU beyond
>>> what can already be achieved via LD_PRELOAD).
>> 
>> Trace events are not a stable public API.  They change between releases
>> and need to be interpreted together with the QEMU source code.
>> 
>> It doesn't make sense to be doing instrumentation inside the QEMU
>> process but not want to compile QEMU.
>> 
>> What is the use case?

> I want the continuous stream of people who come along
> and want to do interesting things (or even just straightforward
> things like "show me all the memory accesses") with tracing
> their guest binary to be able to do so without having to
> rebuild QEMU. We don't require people to rebuild QEMU
> themselves to attach gdb to it, and tracing of guest
> behaviour is a similar "I just want to introspect what
> my guest is doing" use case.

> I think this is distinct from use of the trace API
> for qemu-internal events as used in a lot of the C
> code.

> Some simple use cases:
>  * a plugin which prints out instruction execution traces
> by hooking into "insn executed" and printing something
> helpful (you can extend this into producing traces
> in whatever standard format some other program wants
> to inhale, but at a minimum it would be something we
> could point people at that makes more sense than our
> current "only print insns at translate time" debug);
> it's also easy to add bells and whistles for "start
> tracing at time T" and so on
>  * a plugin that make cachegrind-style guesses about
> cache usage by tracking memory accesses and simulating
> cache effects
>  * a plugin that prints all the system calls the
> guest makes (by hooking into "insn executed" and
> printing info when the insn is an SVC)
>  * trivial statistics like "count executed instructions
> and branches taken"

> (I also think that we should aim for that API for
> things like guest register changes and guest memory
> changes to not be particularly unstable even if we
> allow ourselves to make non-back-compatible changes
> to it.)

That's what I was thinking about (i.e., try to keep a minimally useful and
stable set of guest_* tracepoints). And I guess this also answer's Stefan's
other email about instrumentation use-cases.

Cheers,
  Lluis
