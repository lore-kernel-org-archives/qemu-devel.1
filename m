Received: from eggs.gnu.org ([2001:4830:134:3::10]:58899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1daLgM-0008A3-BI
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1daLgJ-0008Lk-Ke
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:44:54 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:51937)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1daLgJ-0008LL-7o
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:44:51 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<20170725131931.GC23343@stefanha-x1.localdomain>
	<CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
	<87o9s88sb4.fsf@frigg.lan>
	<20170726112210.GD18489@stefanha-x1.localdomain>
Date: Wed, 26 Jul 2017 15:44:39 +0300
In-Reply-To: <20170726112210.GD18489@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Wed, 26 Jul 2017 12:22:10 +0100")
Message-ID: <871sp34bbc.fsf@frigg.lan>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>

Stefan Hajnoczi writes:

> On Tue, Jul 25, 2017 at 06:11:43PM +0300, Llu=C3=ADs Vilanova wrote:
>> Peter Maydell writes:
>>=20
>> > On 25 July 2017 at 14:19, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> >> Instead I suggest adding a trace backend generates calls to registered
>> >> "callback" functions:
>> >>=20
>> >> $ cat >my-instrumentation.c
>> >> #include "trace/control.h"
>> >>=20
>> >> static void my_cpu_in(unsigned int addr, char size, unsigned int val)
>> >> {
>> >> printf("my_cpu_in\n");
>> >> }
>> >>=20
>> >> static void my_init(void)
>> >> {
>> >> trace_register_event_callback("cpu_in", my_cpu_in);
>> >> trace_enable_events("cpu_in");
>> >> }
>> >> trace_init(my_init);
>> >>=20
>> >> $ ./configure --enable-trace-backends=3Dlog,callback && make -j4
>> >>=20
>> >> This is still a clean interface that allows instrumentation code to be
>> >> kept separate from the trace event call sites.
>> >>=20
>> >> The instrumentation code gets compiled into QEMU, but that shouldn't =
be
>> >> a huge burden since QEMU's Makefiles only recompile changed source
>> >> files (only the first build is slow).
>>=20
>> > Is your proposal that my-instrumentation.c gets compiled into
>> > QEMU at this point? That doesn't seem like a great idea to
>> > me, because it means you can only use this tracing if you
>> > build QEMU yourself, and distros won't enable it and so
>> > lots of our users won't have convenient access to it.
>> > I'd much rather see a cleanly designed plugin interface
>> > (which we should be able to implement in a manner that doesn't
>> > let the plugin monkey patch arbitrary parts of QEMU beyond
>> > what can already be achieved via LD_PRELOAD).
>>=20
>> Just to be clear, what do you both mean by monkey-patching?
>>=20
>> * Accessing unintended symbols in QEMU from the library (and from there
>> modifying QEMU's behavior).
>> * QEMU using symbols on the library instead of its own just because they=
 have
>> the same name.
>>=20
>> As I said, the former can be accomplished by compiling QEMU with
>> "-fvisibility=3Dhidden".
>>=20
>> The latter is already achieved by using dlopen with RTLD_LOCAL (the defa=
ult).

> Instrumentation functions are invoked in the same memory space as QEMU,
> so pointer arguments can be modified.

> Think of all the void *s arguments we trace.  Instrumentation code can
> access those structs, hijack function pointers, etc.  No symbols are
> required.

And why exactly is this a threat? Because it can be used to "extend" QEMU
without touching its sources? Is this a realistic threat? (it's a rather br=
ittle
way to do it, so I'm not sure it's practical)

If that's the case, forcing instrumentation libraries to be exclusively GPL
seems like a solution to me, just as GPL protects QEMU itself.

Do we agree on that? Or did I miss something else?

As a side note, I find instrumentation to be most useful for guest code eve=
nts,
which mostly contain non-pointer values (except for the CPUState*).


Cheers,
  Lluis
