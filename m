Received: from eggs.gnu.org ([208.118.235.92]:55990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fvEAq-0002KF-0I
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 00:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fvEAm-0002gx-PQ
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 00:03:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fvEAm-0002gN-D7
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 00:03:08 -0400
Received: by mail-wr1-x444.google.com with SMTP id v16-v6so6663552wro.11
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 21:03:07 -0700 (PDT)
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<CAFEAcA-3UPDD3muShM=yYgiwQcN-U+f_TyEiu-Z=EWb7_hFaCw@mail.gmail.com>
	<001d01d3fcc4$3dfd33f0$b9f79bd0$@ru>
	<20180710130630.GB30635@stefanha-x1.localdomain>
	<000901d43f5a$ace71960$06b54c20$@ru>
	<CAFEAcA8b4Et+3dRS2=Fi3uU_1J_V5AHXGQ9sw6fGkqg8L_X3Lw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8b4Et+3dRS2=Fi3uU_1J_V5AHXGQ9sw6fGkqg8L_X3Lw@mail.gmail.com>
Date: Thu, 30 Aug 2018 05:03:05 +0100
Message-ID: <87ftyw1oxy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 0/7] QEMU binary instrumentation
 prototype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, Stefan Hajnoczi <stefanha@gmail.com>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>, maria.klimushenkova@ispras.ru, QEMU Developers <qemu-devel@nongnu.org>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>


Peter Maydell <peter.maydell@linaro.org> writes:

> Alex, were you planning to look at this series ?

Yes it's in my queue. I'll be looking at it as part of the presentation
I'm doing for Connect.

>
> thanks
> -- PMM
>
> On 29 August 2018 at 06:39, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
>> Ping?
>>
>>
>>
>> Pavel Dovgalyuk
>>
>>> -----Original Message-----
>>> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
>>> Sent: Tuesday, July 10, 2018 4:07 PM
>>> To: Pavel Dovgalyuk
>>> Cc: 'Peter Maydell'; 'Pavel Dovgalyuk'; 'Paolo Bonzini'; maria.klimushe=
nkova@ispras.ru; 'QEMU
>>> Developers'; 'Llu=C3=ADs Vilanova'
>>> Subject: Re: [Qemu-devel] [RFC PATCH v2 0/7] QEMU binary instrumentatio=
n prototype
>>>
>>> On Tue, Jun 05, 2018 at 02:56:29PM +0300, Pavel Dovgalyuk wrote:
>>> > > From: Peter Maydell [mailto:peter.maydell@linaro.org]
>>> > >
>>> > > This series doesn't seem to add anything to Documentation/ that
>>> > > describes the API we make available to plugins. I'm a lot more
>>> > > interested in reviewing the API that will be used by plugins
>>> > > than I am in the implementation at this stage. Can you provide
>>> > > a description/documentation of the API for review, please?
>>> >
>>> >
>>> > Here is the draft:
>>>
>>> I like the minimal interface that you are proposing and that it is
>>> completely separate from QEMU-internal APIs.  This will make it easy to
>>> keep this public API cleanly separated from private internal APIs.
>>>
>>> > Introduction
>>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> >
>>> > This document describes an API for creating the QEMU
>>> > instrumentation plugins.
>>> >
>>> > It is based on the following prior sources:
>>> >  - KVM Forum 2017 talk "Instrumenting, Introspection, and Debugging w=
ith QEMU"
>>> >    https://www.linux-kvm.org/images/3/3d/Introspect.pdf
>>> >  - Discussion on Lluis Vilanova instrumentation patch series
>>> >    https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03357.html
>>> >
>>> > The aim of the instrumentation is implementing different runtime
>>> > tracers that can track the executed instructions, memory and
>>> > hardware operations.
>>> >
>>> > Instrumenting the code
>>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> >
>>> > Instrumentation subsystem exploits TCG helper mechanism to embed
>>> > callbacks into the translation blocks. These callbacks may be inserted
>>> > before the specific instructions, when the plugins require such filte=
ring.
>>> >
>>> > Translator uses two functions for embedding the callbacks:
>>> >  - first function checks whether the current instruction should be
>>> >    instrumented
>>> >  - second function embeds the callback for executing the plugin-speci=
fic
>>> >    code before that instruction
>>> >
>>> > The similar method may be used for memory access instrumentation.
>>> >
>>> > QEMU->Plugin API
>>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> >
>>> > Instrumentation layer passes the requests from the translator
>>> > to the dynamically loaded plugins. Every plugin may provide
>>> > the following functions to perform the instrumentation:
>>> >
>>> >  1. bool plugin_init(const char *args);
>>> >     Initialization function. May return false if the plugin
>>> >     can't work in the current environment.
>>>
>>> Please document how plugin loading and argument handling works.
>>>
>>> Do you think unloading is necessary?  For example, on a long-running
>>> guest it could be useful to unload the plugin, modify and recompile it,
>>> and then load it again during development.  And maybe unloading is also
>>> useful in cases where a plugin produces a lot of data or slows down
>>> execution of a long-running guest.
>>>
>>> >
>>> >  2. bool plugin_needs_before_insn(uint64_t pc, void *cpu);
>>> >     Returns true if the plugin needs to instrument the current instru=
ction.
>>> >     It may use the address (pc) for making the decision or the guest
>>> >     CPU state (cpu), which can be passed back to QEMU core API
>>> >     (e.g., for reading the guest memory).
>>> >     This function is called at both translation and execution phases.
>>>
>>> What type of address is 'pc' - guest virtual or guest physical?
>>>
>>> Is the guest CPU state well-defined when this function is called?  For
>>> example, is reading CPU registers meaningful in this function since it
>>> could be called at pretty much any time?
>>>
>>> Why is this function called during execution?  I expected this to be
>>> called at translation time only.  If a plugin decides at runtime to
>>> instrument instructions that were previously not instrumented, then it
>>> could flush the relevant TB(s) - that seems a lot more efficient than
>>> calling this function for every instruction that gets executed.  But
>>> maybe I am missing a use case for calling this at execution time...?
>>>
>>> >  3. void plugin_before_insn(uint64_t pc, void *cpu);
>>> >     If the previous function returned true for some instruction,
>>> >     then this function will be called. This process is repeated before
>>> >     every execution of the instruction, if it was instrumented.
>>>
>>> Plugins that instrument multiple kinds of instructions will have to
>>> first look up pc and decide which kind of instruction it is.  The plugin
>>> could keep a list or hash table, or it could read memory to check the
>>> guest code again.  This will be very repetitive - many plugins will need
>>> to do this.
>>>
>>> A slightly different take on this API is:
>>>
>>>   /* Plugin->QEMU API */
>>>
>>>   /* Called by QEMU before translating an instruction
>>>    * @pc: guest virtual address of instruction
>>>    */
>>>   void plugin_pre_translate(void *cpu, uint64_t pc);
>>>
>>>   /* QEMU->Plugin API */
>>>
>>>   /* A callback invoked by QEMU before executing an instrumented
>>>    * instruction
>>>    * @opaque: plugin-specific data
>>>    */
>>>   typedef void (*InstrumentCallback)(void *cpu, void *opaque);
>>>
>>>   /* Register a callback @cb each time the instruction at @pc is about
>>>    * to be executed
>>>    * @cpu: the cpu to instrument or NULL to instrument all cpus
>>>    * @opaque: plugin-specific data that is passed to @cb
>>>    */
>>>   void instrument(void *cpu, uint64_t pc,
>>>                   InstrumentCallback cb,
>>>                   void *opaque);
>>>
>>>   /* Unregister a callback @cb previously registered using instrument()
>>>    */
>>>   void uninstrument(void *cpu, uint64_t pc,
>>>                     InstrumentCallback cb,
>>>                   void *opaque);
>>>
>>> Here plugin_pre_translate() is similar to plugin_needs_before_insn(),
>>> but note it has no return value.  Instead of telling QEMU whether or not
>>> to instrument an instruction, it must call instrument() if it wishes to
>>> receive a callback immediately before a particular instruction is
>>> executed.
>>>
>>> This is just an idea I wanted to share.  You understand the use cases
>>> for binary instrumentation much better than me.  Feel free to disregard
>>> if it doesn't fit.
>>


--
Alex Benn=C3=A9e
