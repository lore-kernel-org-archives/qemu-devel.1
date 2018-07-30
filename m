Received: from eggs.gnu.org ([2001:4830:134:3::10]:44462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fk8C6-0006RZ-5s
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fk8C1-0002kz-Ll
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:26:38 -0400
Received: from mail.ispras.ru ([83.149.199.45]:53862)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fk8C1-0002kb-5y
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:26:33 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<CAFEAcA-3UPDD3muShM=yYgiwQcN-U+f_TyEiu-Z=EWb7_hFaCw@mail.gmail.com>
	<001d01d3fcc4$3dfd33f0$b9f79bd0$@ru>
	<20180710130630.GB30635@stefanha-x1.localdomain>
	<000601d418dc$cbd606a0$638213e0$@ru>
In-Reply-To: <000601d418dc$cbd606a0$638213e0$@ru>
Date: Mon, 30 Jul 2018 16:26:30 +0300
Message-ID: <002d01d42808$edcb9aa0$c962cfe0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
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
To: 'Pavel Dovgalyuk' <dovgaluk@ispras.ru>, 'Stefan Hajnoczi' <stefanha@gmail.com>
Cc: 'Peter Maydell' <peter.maydell@linaro.org>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, 'Paolo Bonzini' <pbonzini@redhat.com>, maria.klimushenkova@ispras.ru, 'QEMU Developers' <qemu-devel@nongnu.org>, =?iso-8859-1?Q?'Llu=EDs_Vilanova'?= <vilanova@ac.upc.edu>

Ping?

Pavel Dovgalyuk

> -----Original Message-----
> From: Pavel Dovgalyuk [mailto:dovgaluk@ispras.ru]
> Sent: Wednesday, July 11, 2018 9:03 AM
> To: 'Stefan Hajnoczi'
> Cc: 'Peter Maydell'; 'Pavel Dovgalyuk'; 'Paolo Bonzini'; =
maria.klimushenkova@ispras.ru; 'QEMU
> Developers'; 'Llu=EDs Vilanova'
> Subject: RE: [Qemu-devel] [RFC PATCH v2 0/7] QEMU binary =
instrumentation prototype
>=20
> > From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> > On Tue, Jun 05, 2018 at 02:56:29PM +0300, Pavel Dovgalyuk wrote:
> > > > From: Peter Maydell [mailto:peter.maydell@linaro.org]
> > > >
> > > > This series doesn't seem to add anything to Documentation/ that
> > > > describes the API we make available to plugins. I'm a lot more
> > > > interested in reviewing the API that will be used by plugins
> > > > than I am in the implementation at this stage. Can you provide
> > > > a description/documentation of the API for review, please?
> > >
> > >
> > > Here is the draft:
> >
> > I like the minimal interface that you are proposing and that it is
> > completely separate from QEMU-internal APIs.  This will make it easy =
to
> > keep this public API cleanly separated from private internal APIs.
> >
> > > Introduction
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > This document describes an API for creating the QEMU
> > > instrumentation plugins.
> > >
> > > It is based on the following prior sources:
> > >  - KVM Forum 2017 talk "Instrumenting, Introspection, and =
Debugging with QEMU"
> > >    https://www.linux-kvm.org/images/3/3d/Introspect.pdf
> > >  - Discussion on Lluis Vilanova instrumentation patch series
> > >    =
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03357.html
> > >
> > > The aim of the instrumentation is implementing different runtime
> > > tracers that can track the executed instructions, memory and
> > > hardware operations.
> > >
> > > Instrumenting the code
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Instrumentation subsystem exploits TCG helper mechanism to embed
> > > callbacks into the translation blocks. These callbacks may be =
inserted
> > > before the specific instructions, when the plugins require such =
filtering.
> > >
> > > Translator uses two functions for embedding the callbacks:
> > >  - first function checks whether the current instruction should be
> > >    instrumented
> > >  - second function embeds the callback for executing the =
plugin-specific
> > >    code before that instruction
> > >
> > > The similar method may be used for memory access instrumentation.
> > >
> > > QEMU->Plugin API
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Instrumentation layer passes the requests from the translator
> > > to the dynamically loaded plugins. Every plugin may provide
> > > the following functions to perform the instrumentation:
> > >
> > >  1. bool plugin_init(const char *args);
> > >     Initialization function. May return false if the plugin
> > >     can't work in the current environment.
> >
> > Please document how plugin loading and argument handling works.
> >
> > Do you think unloading is necessary?
>=20
> Yes, I think we'll need it, but I omitted it in the draft.
> Will fix in the next version.
>=20
> > >  2. bool plugin_needs_before_insn(uint64_t pc, void *cpu);
> > >     Returns true if the plugin needs to instrument the current =
instruction.
> > >     It may use the address (pc) for making the decision or the =
guest
> > >     CPU state (cpu), which can be passed back to QEMU core API
> > >     (e.g., for reading the guest memory).
> > >     This function is called at both translation and execution =
phases.
> >
> > What type of address is 'pc' - guest virtual or guest physical?
>=20
> It is a guest virtual address. We can expose a function for address =
translation
> to let the plugin obtain physical address.
>=20
> > Is the guest CPU state well-defined when this function is called?  =
For
> > example, is reading CPU registers meaningful in this function since =
it
> > could be called at pretty much any time?
>=20
> It is not. The guest state is the same as in translate.c.
> Therefore such functions are limited in accessing the registers.
>=20
> > Why is this function called during execution?  I expected this to be
> > called at translation time only.  If a plugin decides at runtime to
> > instrument instructions that were previously not instrumented, then =
it
> > could flush the relevant TB(s) - that seems a lot more efficient =
than
> > calling this function for every instruction that gets executed.  But
> > maybe I am missing a use case for calling this at execution time...?
>=20
> It isn't called for every executed instruction. It is called for =
instructions
> that was marked by the same function to instrument.
> I had a choice of two options:
>  - insert many callbacks in case of multiple plugins, but call 'needs' =
only once.
>  - insert one callback to dispatch function and call 'needs' for every =
plugin again,
>    because there is no information which plugin caused the =
instrumentation.
>=20
> Anyway, we can switch to the first option, if you don't see any other =
pitfalls
> except the larger generated code.
>=20
> > >  3. void plugin_before_insn(uint64_t pc, void *cpu);
> > >     If the previous function returned true for some instruction,
> > >     then this function will be called. This process is repeated =
before
> > >     every execution of the instruction, if it was instrumented.
> >
> > Plugins that instrument multiple kinds of instructions will have to
> > first look up pc and decide which kind of instruction it is.  The =
plugin
> > could keep a list or hash table, or it could read memory to check =
the
> > guest code again.  This will be very repetitive - many plugins will =
need
> > to do this.
>=20
> Right.
>=20
> > A slightly different take on this API is:
> >
> >   /* Plugin->QEMU API */
> >
> >   /* Called by QEMU before translating an instruction
> >    * @pc: guest virtual address of instruction
> >    */
> >   void plugin_pre_translate(void *cpu, uint64_t pc);
> >
> >   /* QEMU->Plugin API */
> >
> >   /* A callback invoked by QEMU before executing an instrumented
> >    * instruction
> >    * @opaque: plugin-specific data
> >    */
> >   typedef void (*InstrumentCallback)(void *cpu, void *opaque);
> >
> >   /* Register a callback @cb each time the instruction at @pc is =
about
> >    * to be executed
> >    * @cpu: the cpu to instrument or NULL to instrument all cpus
>=20
> This is interesting point I missed.
> As far, as I understand, current version translates TB only once for =
all CPUs.
> And we could need to instrument only some of them, which means that =
translation
> should be somehow extended for that.
>=20
> >    * @opaque: plugin-specific data that is passed to @cb
> >    */
> >   void instrument(void *cpu, uint64_t pc,
> >                   InstrumentCallback cb,
> >                   void *opaque);
> >
> >   /* Unregister a callback @cb previously registered using =
instrument()
> >    */
> >   void uninstrument(void *cpu, uint64_t pc,
> >                     InstrumentCallback cb,
> > 		    void *opaque);
> >
> > Here plugin_pre_translate() is similar to =
plugin_needs_before_insn(),
> > but note it has no return value.  Instead of telling QEMU whether or =
not
> > to instrument an instruction, it must call instrument() if it wishes =
to
> > receive a callback immediately before a particular instruction is
> > executed.
>=20
> This is similar to our current approach here: =
https://github.com/ispras/qemu/tree/plugins
>=20
> But it has some issues:
>  - You can't switch QEMU core from translation to interpretation, =
because this interface
>    is targeted to translation.
>  - Callbacks can't be inserted without registering them in tcg
>    (this in needed at least for debug output).
>    Therefore someone should maintain already registered callbacks, or =
we should
>    expose the registration interface to the plugins (as we do in our =
projects now),
>    which also nail them to the translation-based emulation.
>=20
> Pavel Dovgalyuk
