Received: from eggs.gnu.org ([2001:4830:134:3::10]:38831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fcsLm-0004bt-5B
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fcsLh-0007bC-Vi
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:06:38 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:39001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fcsLh-0007b0-L8
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:06:33 -0400
Received: by mail-wm0-x244.google.com with SMTP id h20-v6so8343496wmb.4
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 06:06:33 -0700 (PDT)
Date: Tue, 10 Jul 2018 14:06:30 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180710130630.GB30635@stefanha-x1.localdomain>
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<CAFEAcA-3UPDD3muShM=yYgiwQcN-U+f_TyEiu-Z=EWb7_hFaCw@mail.gmail.com>
	<001d01d3fcc4$3dfd33f0$b9f79bd0$@ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <001d01d3fcc4$3dfd33f0$b9f79bd0$@ru>
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
Cc: 'Peter Maydell' <peter.maydell@linaro.org>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, 'Paolo Bonzini' <pbonzini@redhat.com>, maria.klimushenkova@ispras.ru, 'QEMU Developers' <qemu-devel@nongnu.org>, =?iso-8859-1?Q?'Llu=EDs?= Vilanova' <vilanova@ac.upc.edu>


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 02:56:29PM +0300, Pavel Dovgalyuk wrote:
> > From: Peter Maydell [mailto:peter.maydell@linaro.org]
> >=20
> > This series doesn't seem to add anything to Documentation/ that
> > describes the API we make available to plugins. I'm a lot more
> > interested in reviewing the API that will be used by plugins
> > than I am in the implementation at this stage. Can you provide
> > a description/documentation of the API for review, please?
>=20
>=20
> Here is the draft:

I like the minimal interface that you are proposing and that it is
completely separate from QEMU-internal APIs.  This will make it easy to
keep this public API cleanly separated from private internal APIs.

> Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> This document describes an API for creating the QEMU
> instrumentation plugins.
>=20
> It is based on the following prior sources:
>  - KVM Forum 2017 talk "Instrumenting, Introspection, and Debugging with =
QEMU"
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
> before the specific instructions, when the plugins require such filtering.
>=20
> Translator uses two functions for embedding the callbacks:
>  - first function checks whether the current instruction should be
>    instrumented
>  - second function embeds the callback for executing the plugin-specific
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

Please document how plugin loading and argument handling works.

Do you think unloading is necessary?  For example, on a long-running
guest it could be useful to unload the plugin, modify and recompile it,
and then load it again during development.  And maybe unloading is also
useful in cases where a plugin produces a lot of data or slows down
execution of a long-running guest.

>=20
>  2. bool plugin_needs_before_insn(uint64_t pc, void *cpu);
>     Returns true if the plugin needs to instrument the current instructio=
n.
>     It may use the address (pc) for making the decision or the guest
>     CPU state (cpu), which can be passed back to QEMU core API
>     (e.g., for reading the guest memory).
>     This function is called at both translation and execution phases.

What type of address is 'pc' - guest virtual or guest physical?

Is the guest CPU state well-defined when this function is called?  For
example, is reading CPU registers meaningful in this function since it
could be called at pretty much any time?

Why is this function called during execution?  I expected this to be
called at translation time only.  If a plugin decides at runtime to
instrument instructions that were previously not instrumented, then it
could flush the relevant TB(s) - that seems a lot more efficient than
calling this function for every instruction that gets executed.  But
maybe I am missing a use case for calling this at execution time...?

>  3. void plugin_before_insn(uint64_t pc, void *cpu);
>     If the previous function returned true for some instruction,
>     then this function will be called. This process is repeated before
>     every execution of the instruction, if it was instrumented.

Plugins that instrument multiple kinds of instructions will have to
first look up pc and decide which kind of instruction it is.  The plugin
could keep a list or hash table, or it could read memory to check the
guest code again.  This will be very repetitive - many plugins will need
to do this.

A slightly different take on this API is:

  /* Plugin->QEMU API */

  /* Called by QEMU before translating an instruction
   * @pc: guest virtual address of instruction
   */
  void plugin_pre_translate(void *cpu, uint64_t pc);

  /* QEMU->Plugin API */

  /* A callback invoked by QEMU before executing an instrumented
   * instruction
   * @opaque: plugin-specific data
   */
  typedef void (*InstrumentCallback)(void *cpu, void *opaque);

  /* Register a callback @cb each time the instruction at @pc is about
   * to be executed
   * @cpu: the cpu to instrument or NULL to instrument all cpus
   * @opaque: plugin-specific data that is passed to @cb
   */
  void instrument(void *cpu, uint64_t pc,
                  InstrumentCallback cb,
                  void *opaque);

  /* Unregister a callback @cb previously registered using instrument()
   */
  void uninstrument(void *cpu, uint64_t pc,
                    InstrumentCallback cb,
		    void *opaque);

Here plugin_pre_translate() is similar to plugin_needs_before_insn(),
but note it has no return value.  Instead of telling QEMU whether or not
to instrument an instruction, it must call instrument() if it wishes to
receive a callback immediately before a particular instruction is
executed.

This is just an idea I wanted to share.  You understand the use cases
for binary instrumentation much better than me.  Feel free to disregard
if it doesn't fit.

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRK9WAAoJEJykq7OBq3PIpq4H/2eEUfm9nHTiBzdOUXjgsfOx
KSsbQ81PFPce0aUMArADx9YmdEqumYcIqZ+GX1qkMHAfSPsEQ706tuHvnFHjyyqY
JjZjbAnm79wjxeVb18ocGELT5ygrXFweG3Bh72+6CZ247VH4+FCqqWe+gTccbNSN
ny3RWsRmy8pe19YqTL+cuYt9INAS3e8LOu+9Rs3BWdcmpJPWE/loI7LTutyOGeOb
Qlm9F2cOeM8nkCaX8Niv/dWNSZSXk/YQG1UF3dVvhM5fyaz5ucXXhZr0CvXeUjqi
Kc69ZuQhPWbY07UjPwdSJr3AgsyhnjcVo9vmyIN3ZWBMKTqZ1KmC2IRPeJJyp04=
=Rv9H
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
