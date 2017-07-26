Received: from eggs.gnu.org ([2001:4830:134:3::10]:51980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1daLTx-0004E0-Kj
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1daLTt-0000xZ-Dk
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:32:05 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:50487)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1daLTt-0000x6-1j
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:32:01 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<20170725131931.GC23343@stefanha-x1.localdomain>
	<87wp6wa80j.fsf@frigg.lan>
	<20170726112915.GF18489@stefanha-x1.localdomain>
Date: Wed, 26 Jul 2017 15:31:51 +0300
In-Reply-To: <20170726112915.GF18489@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Wed, 26 Jul 2017 12:29:15 +0100")
Message-ID: <87r2x34bwo.fsf@frigg.lan>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>

Stefan Hajnoczi writes:

> On Tue, Jul 25, 2017 at 05:47:08PM +0300, Llu=C3=ADs Vilanova wrote:
>> Stefan Hajnoczi writes:
>>=20
>> > On Mon, Jul 24, 2017 at 08:02:24PM +0300, Llu=C3=ADs Vilanova wrote:
>> >> This series adds a basic interface to instrument tracing events and c=
ontrol
>> >> their tracing state.
>> >>=20
>> >> The instrumentation code is dynamically loaded into QEMU (either when=
 it starts
>> >> or later using its remote control interfaces).
>> >>=20
>> >> All events can be instrumented, but the instrumentable events must be=
 explicitly
>> >> specified at configure time.
>> >>=20
>> >> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>>=20
>> > Hi Llu=C3=ADs,
>> > I'm concerned that the shared library interface will be abused to monk=
ey
>> > patch code into QEMU far beyond instrumentation use cases and/or avoid
>> > the responsibilities of the GPL license.
>>=20
>> > Instead I suggest adding a trace backend generates calls to registered
>> > "callback" functions:
>>=20
>> >   $ cat >my-instrumentation.c
>> >   #include "trace/control.h"
>>=20
>> >   static void my_cpu_in(unsigned int addr, char size, unsigned int val)
>> >   {
>> >       printf("my_cpu_in\n");
>> >   }
>>=20
>> >   static void my_init(void)
>> >   {
>> >       trace_register_event_callback("cpu_in", my_cpu_in);
>> >       trace_enable_events("cpu_in");
>> >   }
>> >   trace_init(my_init);
>>=20
>> >   $ ./configure --enable-trace-backends=3Dlog,callback && make -j4
>>=20
>> > This is still a clean interface that allows instrumentation code to be
>> > kept separate from the trace event call sites.
>>=20
>> > The instrumentation code gets compiled into QEMU, but that shouldn't be
>> > a huge burden since QEMU's Makefiles only recompile changed source
>> > files (only the first build is slow).
>>=20
>> > Does this alternative sound reasonable to you?
>>=20
>> You mean to add a user-provided .c file to QEMU at compile-time? (I'm as=
suming
>> we can keep the "user API" proposed in this series, instead of the one y=
ou
>> showed).
>>=20
>> First, a user might want to provide more than just a .c, so we might hav=
e to
>> accept a directory that produces a library that is included into QEMU at=
 link
>> time (a bit more complicated to do portably).
>>=20
>> Second, the user can still do the same actions you want to shield from,
>> regardless of whether it's a dynamically loaded library (i.e., access any
>> fuction in QEMU).
>>=20
>> What I propose to do instead is:
>>=20
>> * For the monkey-patch part, we can limit symbol resolution to the
>> instrumentation API functions when loading the library (e.g., compile QE=
MU
>> with -fvisibility=3Dhidden).
>>=20
>> * For the license part, that is a legal issue that can be handled by the=
 API
>> header license, right? (the "public" headers I added are GPL, not
>> LGPL). Besides, if only the intended API is available, I'm not sure if t=
hat
>> matters (e.g., we don't care about the license of a dtrace script, since=
 it
>> only has the API provided by QEMU+dtrace).
>>=20
>> This would be similar to Linux's module support; only selected functions=
 are
>> available to modules, and we could add a license check (e.g., QI_LICENSE=
("GPL")
>> must be on the instrumentation library or it won't be loaded).

> Proprietary Linux kernel modules are controversial and some still
> consider them license violations - especially when an "open source" shim
> module is used to interface between proprietary code and the kernel.

> What is the use case for this instrumentation?

As I said, we can require instrumentation libraries to be GPL (and nothing
else), so no proprietary code is possible without a license violation (then
we're on the same field as if someone ships a modified QEMU binary, which
technically is just as doable).

As for use-cases, see Peter's email and my response.


Cheers,
  Lluis
