Received: from eggs.gnu.org ([2001:4830:134:3::10]:43309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fv6bG-0003Yu-0d
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 15:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fv6bE-0004z1-IV
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 15:57:57 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:45564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fv6bE-0004yS-6B
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 15:57:56 -0400
Received: by mail-oi0-x243.google.com with SMTP id t68-v6so11324067oie.12
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 12:57:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000901d43f5a$ace71960$06b54c20$@ru>
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<CAFEAcA-3UPDD3muShM=yYgiwQcN-U+f_TyEiu-Z=EWb7_hFaCw@mail.gmail.com>
	<001d01d3fcc4$3dfd33f0$b9f79bd0$@ru>
	<20180710130630.GB30635@stefanha-x1.localdomain>
	<000901d43f5a$ace71960$06b54c20$@ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Aug 2018 20:57:33 +0100
Message-ID: <CAFEAcA8b4Et+3dRS2=Fi3uU_1J_V5AHXGQ9sw6fGkqg8L_X3Lw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>, maria.klimushenkova@ispras.ru, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

Alex, were you planning to look at this series ?

thanks
-- PMM

On 29 August 2018 at 06:39, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
> Ping?
>
>
>
> Pavel Dovgalyuk
>
>> -----Original Message-----
>> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
>> Sent: Tuesday, July 10, 2018 4:07 PM
>> To: Pavel Dovgalyuk
>> Cc: 'Peter Maydell'; 'Pavel Dovgalyuk'; 'Paolo Bonzini'; maria.klimushen=
kova@ispras.ru; 'QEMU
>> Developers'; 'Llu=C3=ADs Vilanova'
>> Subject: Re: [Qemu-devel] [RFC PATCH v2 0/7] QEMU binary instrumentation=
 prototype
>>
>> On Tue, Jun 05, 2018 at 02:56:29PM +0300, Pavel Dovgalyuk wrote:
>> > > From: Peter Maydell [mailto:peter.maydell@linaro.org]
>> > >
>> > > This series doesn't seem to add anything to Documentation/ that
>> > > describes the API we make available to plugins. I'm a lot more
>> > > interested in reviewing the API that will be used by plugins
>> > > than I am in the implementation at this stage. Can you provide
>> > > a description/documentation of the API for review, please?
>> >
>> >
>> > Here is the draft:
>>
>> I like the minimal interface that you are proposing and that it is
>> completely separate from QEMU-internal APIs.  This will make it easy to
>> keep this public API cleanly separated from private internal APIs.
>>
>> > Introduction
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >
>> > This document describes an API for creating the QEMU
>> > instrumentation plugins.
>> >
>> > It is based on the following prior sources:
>> >  - KVM Forum 2017 talk "Instrumenting, Introspection, and Debugging wi=
th QEMU"
>> >    https://www.linux-kvm.org/images/3/3d/Introspect.pdf
>> >  - Discussion on Lluis Vilanova instrumentation patch series
>> >    https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03357.html
>> >
>> > The aim of the instrumentation is implementing different runtime
>> > tracers that can track the executed instructions, memory and
>> > hardware operations.
>> >
>> > Instrumenting the code
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >
>> > Instrumentation subsystem exploits TCG helper mechanism to embed
>> > callbacks into the translation blocks. These callbacks may be inserted
>> > before the specific instructions, when the plugins require such filter=
ing.
>> >
>> > Translator uses two functions for embedding the callbacks:
>> >  - first function checks whether the current instruction should be
>> >    instrumented
>> >  - second function embeds the callback for executing the plugin-specif=
ic
>> >    code before that instruction
>> >
>> > The similar method may be used for memory access instrumentation.
>> >
>> > QEMU->Plugin API
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >
>> > Instrumentation layer passes the requests from the translator
>> > to the dynamically loaded plugins. Every plugin may provide
>> > the following functions to perform the instrumentation:
>> >
>> >  1. bool plugin_init(const char *args);
>> >     Initialization function. May return false if the plugin
>> >     can't work in the current environment.
>>
>> Please document how plugin loading and argument handling works.
>>
>> Do you think unloading is necessary?  For example, on a long-running
>> guest it could be useful to unload the plugin, modify and recompile it,
>> and then load it again during development.  And maybe unloading is also
>> useful in cases where a plugin produces a lot of data or slows down
>> execution of a long-running guest.
>>
>> >
>> >  2. bool plugin_needs_before_insn(uint64_t pc, void *cpu);
>> >     Returns true if the plugin needs to instrument the current instruc=
tion.
>> >     It may use the address (pc) for making the decision or the guest
>> >     CPU state (cpu), which can be passed back to QEMU core API
>> >     (e.g., for reading the guest memory).
>> >     This function is called at both translation and execution phases.
>>
>> What type of address is 'pc' - guest virtual or guest physical?
>>
>> Is the guest CPU state well-defined when this function is called?  For
>> example, is reading CPU registers meaningful in this function since it
>> could be called at pretty much any time?
>>
>> Why is this function called during execution?  I expected this to be
>> called at translation time only.  If a plugin decides at runtime to
>> instrument instructions that were previously not instrumented, then it
>> could flush the relevant TB(s) - that seems a lot more efficient than
>> calling this function for every instruction that gets executed.  But
>> maybe I am missing a use case for calling this at execution time...?
>>
>> >  3. void plugin_before_insn(uint64_t pc, void *cpu);
>> >     If the previous function returned true for some instruction,
>> >     then this function will be called. This process is repeated before
>> >     every execution of the instruction, if it was instrumented.
>>
>> Plugins that instrument multiple kinds of instructions will have to
>> first look up pc and decide which kind of instruction it is.  The plugin
>> could keep a list or hash table, or it could read memory to check the
>> guest code again.  This will be very repetitive - many plugins will need
>> to do this.
>>
>> A slightly different take on this API is:
>>
>>   /* Plugin->QEMU API */
>>
>>   /* Called by QEMU before translating an instruction
>>    * @pc: guest virtual address of instruction
>>    */
>>   void plugin_pre_translate(void *cpu, uint64_t pc);
>>
>>   /* QEMU->Plugin API */
>>
>>   /* A callback invoked by QEMU before executing an instrumented
>>    * instruction
>>    * @opaque: plugin-specific data
>>    */
>>   typedef void (*InstrumentCallback)(void *cpu, void *opaque);
>>
>>   /* Register a callback @cb each time the instruction at @pc is about
>>    * to be executed
>>    * @cpu: the cpu to instrument or NULL to instrument all cpus
>>    * @opaque: plugin-specific data that is passed to @cb
>>    */
>>   void instrument(void *cpu, uint64_t pc,
>>                   InstrumentCallback cb,
>>                   void *opaque);
>>
>>   /* Unregister a callback @cb previously registered using instrument()
>>    */
>>   void uninstrument(void *cpu, uint64_t pc,
>>                     InstrumentCallback cb,
>>                   void *opaque);
>>
>> Here plugin_pre_translate() is similar to plugin_needs_before_insn(),
>> but note it has no return value.  Instead of telling QEMU whether or not
>> to instrument an instruction, it must call instrument() if it wishes to
>> receive a callback immediately before a particular instruction is
>> executed.
>>
>> This is just an idea I wanted to share.  You understand the use cases
>> for binary instrumentation much better than me.  Feel free to disregard
>> if it doesn't fit.
>



--=20
123456789012345678901234567890123456789012345678901234567890123456789012345=
67890
         1         2         3         4         5         6         7     =
    8
