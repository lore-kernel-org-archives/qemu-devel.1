Received: from eggs.gnu.org ([2001:4830:134:3::10]:46274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1da1VC-0001Vz-Iw
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1da1V9-0007CI-EG
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:12:02 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:33272 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1da1V9-0007Bq-1a
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:11:59 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<20170725131931.GC23343@stefanha-x1.localdomain>
	<CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
Date: Tue, 25 Jul 2017 18:11:43 +0300
In-Reply-To: <CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
	(Peter Maydell's message of "Tue, 25 Jul 2017 14:30:06 +0100")
Message-ID: <87o9s88sb4.fsf@frigg.lan>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell writes:

> On 25 July 2017 at 14:19, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> Instead I suggest adding a trace backend generates calls to registered
>> "callback" functions:
>> 
>> $ cat >my-instrumentation.c
>> #include "trace/control.h"
>> 
>> static void my_cpu_in(unsigned int addr, char size, unsigned int val)
>> {
>> printf("my_cpu_in\n");
>> }
>> 
>> static void my_init(void)
>> {
>> trace_register_event_callback("cpu_in", my_cpu_in);
>> trace_enable_events("cpu_in");
>> }
>> trace_init(my_init);
>> 
>> $ ./configure --enable-trace-backends=log,callback && make -j4
>> 
>> This is still a clean interface that allows instrumentation code to be
>> kept separate from the trace event call sites.
>> 
>> The instrumentation code gets compiled into QEMU, but that shouldn't be
>> a huge burden since QEMU's Makefiles only recompile changed source
>> files (only the first build is slow).

> Is your proposal that my-instrumentation.c gets compiled into
> QEMU at this point? That doesn't seem like a great idea to
> me, because it means you can only use this tracing if you
> build QEMU yourself, and distros won't enable it and so
> lots of our users won't have convenient access to it.
> I'd much rather see a cleanly designed plugin interface
> (which we should be able to implement in a manner that doesn't
> let the plugin monkey patch arbitrary parts of QEMU beyond
> what can already be achieved via LD_PRELOAD).

Just to be clear, what do you both mean by monkey-patching?

* Accessing unintended symbols in QEMU from the library (and from there
  modifying QEMU's behavior).
* QEMU using symbols on the library instead of its own just because they have
  the same name.

As I said, the former can be accomplished by compiling QEMU with
"-fvisibility=hidden".

The latter is already achieved by using dlopen with RTLD_LOCAL (the default).


Cheers,
  Lluis
