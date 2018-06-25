Received: from eggs.gnu.org ([2001:4830:134:3::10]:50737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fXKKG-0004LU-U0
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 01:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fXKKC-0007qU-W7
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 01:46:08 -0400
Received: from mail.ispras.ru ([83.149.199.45]:37504)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fXKKC-0007o0-Jk
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 01:46:04 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<CAFEAcA-3UPDD3muShM=yYgiwQcN-U+f_TyEiu-Z=EWb7_hFaCw@mail.gmail.com>
	<001d01d3fcc4$3dfd33f0$b9f79bd0$@ru>
In-Reply-To: <001d01d3fcc4$3dfd33f0$b9f79bd0$@ru>
Date: Mon, 25 Jun 2018 08:46:00 +0300
Message-ID: <007e01d40c47$cc465640$64d302c0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
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
To: 'Pavel Dovgalyuk' <dovgaluk@ispras.ru>, 'Peter Maydell' <peter.maydell@linaro.org>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>
Cc: 'QEMU Developers' <qemu-devel@nongnu.org>, maria.klimushenkova@ispras.ru, 'Paolo Bonzini' <pbonzini@redhat.com>, =?utf-8?Q?'Llu=C3=ADs_Vilanova'?= <vilanova@ac.upc.edu>

Peter, what about this one?

Pavel Dovgalyuk

> -----Original Message-----
> From: Pavel Dovgalyuk [mailto:dovgaluk@ispras.ru]
> Sent: Tuesday, June 05, 2018 2:56 PM
> To: 'Peter Maydell'; 'Pavel Dovgalyuk'
> Cc: 'QEMU Developers'; maria.klimushenkova@ispras.ru; 'Paolo Bonzini'; =
'Llu=C3=ADs Vilanova'
> Subject: RE: [RFC PATCH v2 0/7] QEMU binary instrumentation prototype
>=20
> > From: Peter Maydell [mailto:peter.maydell@linaro.org]
> >
> > This series doesn't seem to add anything to Documentation/ that
> > describes the API we make available to plugins. I'm a lot more
> > interested in reviewing the API that will be used by plugins
> > than I am in the implementation at this stage. Can you provide
> > a description/documentation of the API for review, please?
>=20
>=20
> Here is the draft:
>=20
> Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> This document describes an API for creating the QEMU
> instrumentation plugins.
>=20
> It is based on the following prior sources:
>  - KVM Forum 2017 talk "Instrumenting, Introspection, and Debugging =
with QEMU"
>    https://www.linux-kvm.org/images/3/3d/Introspect.pdf
>  - Discussion on Lluis Vilanova instrumentation patch series
>    https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03357.html
>=20
> The aim of the instrumentation is implementing different runtime
> tracers that can track the executed instructions, memory and
> hardware operations.
>=20
> Instrumenting the code
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Instrumentation subsystem exploits TCG helper mechanism to embed
> callbacks into the translation blocks. These callbacks may be inserted
> before the specific instructions, when the plugins require such =
filtering.
>=20
> Translator uses two functions for embedding the callbacks:
>  - first function checks whether the current instruction should be
>    instrumented
>  - second function embeds the callback for executing the =
plugin-specific
>    code before that instruction
>=20
> The similar method may be used for memory access instrumentation.
>=20
> QEMU->Plugin API
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Instrumentation layer passes the requests from the translator
> to the dynamically loaded plugins. Every plugin may provide
> the following functions to perform the instrumentation:
>=20
>  1. bool plugin_init(const char *args);
>     Initialization function. May return false if the plugin
>     can't work in the current environment.
>=20
>  2. bool plugin_needs_before_insn(uint64_t pc, void *cpu);
>     Returns true if the plugin needs to instrument the current =
instruction.
>     It may use the address (pc) for making the decision or the guest
>     CPU state (cpu), which can be passed back to QEMU core API
>     (e.g., for reading the guest memory).
>     This function is called at both translation and execution phases.
>=20
>  3. void plugin_before_insn(uint64_t pc, void *cpu);
>     If the previous function returned true for some instruction,
>     then this function will be called. This process is repeated before
>     every execution of the instruction, if it was instrumented.
>=20
> The similar pair of functions will also be added for the memory
> operations.
>=20
> Plugin->QEMU API
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> QEMU core exports some functions to let the plugins introspect the =
guest
> or perform some interaction with other QEMU services (e.g., logging).
> API doesn't contain any data structures, because their memory layout =
depend
> on the compilation settings.
>=20
> QEMU exports the following functions that may be called from the =
plugins:
>=20
>  1. void qemulib_log(const char *fmt, ...);
>     Wrapper for qemu_log.
>=20
>  2. int qemulib_read_memory(void *cpu, uint64_t addr, uint8_t *buf, =
int len);
>     Reads guest memory into the buffer. Wrapper for =
cpu_memory_rw_debug.
>=20
>  3. int qemulib_read_register(void *cpu, uint8_t *mem_buf, int reg);
>     Uses target gdb interface for accessing the guest registers.
>     'reg' is the id of the desired register as it is coded by gdb.
>=20
> There also should be a function for flushing the translated blocks to
> ensure that the instrumentation will occur in the case of changing
> the internal plugin state.
>=20
