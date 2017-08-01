Received: from eggs.gnu.org ([2001:4830:134:3::10]:59087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcXXE-0004em-BE
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcXXB-0003T8-Kn
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:48:32 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:32901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dcXXB-0003S8-9V
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:48:29 -0400
Received: by mail-wm0-x230.google.com with SMTP id k20so23067573wmg.0
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 06:48:29 -0700 (PDT)
Date: Tue, 1 Aug 2017 14:48:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170801134825.GC22017@stefanha-x1.localdomain>
References: <CAFEAcA_pXX6ZCsBwAQnzQbTSbxzAh=nFpPeEzZoRBhBDt2r+vA@mail.gmail.com>
	<20170727104302.GI2555@redhat.com>
	<CAFEAcA8oyHi+7NVCE8YWHY+v0UXLbt2tWHGE4AP_V8TtDBc89g@mail.gmail.com>
	<20170727152137.GW2555@redhat.com>
	<CAFEAcA-eH7J+fFXYgFo6Wx58zgD8=kqhrGE5BqR+NrhHjipsFw@mail.gmail.com>
	<20170727154535.GY2555@redhat.com>
	<20170728133430.GS12364@stefanha-x1.localdomain>
	<CAFEAcA9p38P2x3s4grvFPkGaH+JEmwqyAC9SsLWqqFL8k+Eiww@mail.gmail.com>
	<20170728140623.GQ31495@redhat.com> <87vamclf6w.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <87vamclf6w.fsf@frigg.lan>
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
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: ale+qemu@clearmind.me, "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 07:05:43PM +0300, Llu=EDs Vilanova wrote:
> Daniel P Berrange writes:
>=20
> > On Fri, Jul 28, 2017 at 02:41:19PM +0100, Peter Maydell wrote:
> >> On 28 July 2017 at 14:34, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >> > Llu=EDs/Peter: What are the requirements for instrumentation code
> >> > interacting with the running QEMU instance?  simpletrace is
> >> > asynchronous, meaning it does not wait for anyone handle the trace e=
vent
> >> > before continuing execution, and is therefore not suitable for
> >> > SystemTap-style scripts that can interact with the program while
> >> > handling a trace event.
> >>=20
> >> I think you'd probably want synchronous -- it's pretty helpful
> >> to be able to say "register a trace event hook that doesn't
> >> fire very often, and use that to get to the region of
> >> execution that's of interest to you, then enable more hooks
> >> to get more detail at that point". (For instance, "wait til
> >> we've executed 5,000,000 instructions, then turn on the
> >> tracing of all instruction execution, register modification
> >> and memory accesses".)
>=20
> > Currently simpletrace probes have a fixed action when they are enabled,
> > namely to print state to the trace log file. Perhaps we can make the
> > action more flexible, if we create a more formal protocol for simpletra=
ce
> > to let it talk over a UNIX socket. By default it could send probe data
> > asynchronously as now, but you could mark probes such that they require
> > a synchronous ACK, thus pausing execution until that ACK is received
> > from the instrumenting program.
>=20
> > For that to be useful, we would need to have allow probes to be turned
> > on/off via this trace socket, since the normal HMP/QMP monitor execution
> > would be blocked while this probe is running.
>=20
> This sounds like much more work to me for much lower performance (copy th=
rough
> fifo/socket & process synchronization). Especially if many interesting ev=
ents
> become "synchronous". Also, with MTTCG using fifos becomes more complex o=
n both
> sides (select on the client & synchronization of events between streams o=
n both
> sides).
>=20
> As a performance example, I've used the approach of this series to perfor=
m some
> non-trivial instrumentation and I can get performance on par with PIN (a
> state-of-the-art tool from intel) on most SPEC benchmarks.
>=20
> Honestly, I would try to see if there's a GPL-preserving way to allow nat=
ive
> instrumentation libraries to run inside QEMU (either dynamic or static, t=
hat's
> less important to me).
>=20
> As for the (minimum) requirements I've collected:
>=20
> * Peek at register values and guest memory.
> * Enumerate guest cpus.
> * Control when events are raised to minimize overheads (e.g., avoid gener=
ating
>   TCG code to trace a guest code event we don't care about just now).
> * When a guest code event is raised at translation time, let instrumentor=
 decide
>   if it needs to be raised at execution time too (e.g., might be decided =
on
>   instruction opcode)
> * Minimum overhead when instrumenting (I think the proposed fifo/socket a=
pproach
>   does not meet this; point 2 helps a lot here, which is what the current
>   tracing code does)
> * Let instrumentor know when TBs are being freed (i.e., to free internal =
per-TB
>   structures; I have a patch queued adding this event).
>=20
> Nice to have:
>=20
> * Avoid recompilation for each new instrumentation logic.
> * Poke at register values and guest memory.
> * [synchronous for sure] Let user annotate guest programs to raise additi=
onal
>   events with guest-specified information (the hypertrace series I sent).
> * [synchronous for sure] Make guest breakpoints/watchpoints raise an even=
t (for
>   when we cannot annotate the guest code; I have some patches).
> * Trigger QEMU's event tracing routine when the instrumentation code
>   decides. This is what this series does now, as then lazy instrumentors =
don't
>   need to write their own tracing-to-disk code. Otherwise, per-event trac=
ing
>   states would need to be independent of instrumentation states (but the =
logic
>   is exactly the same).
> * Let instrumentor define additional arguments to execution-time events d=
uring
>   translation-time (e.g., to quickly index into an instrumentor struct wh=
en the
>   execution-time event comes that references info collected during transl=
ation).
> * Attach an instrumentor-specified value to each guest CPU (e.g., pointin=
g to
>   the instrumentor's cpu state). Might be less necessary if the point abo=
ve is
>   met (if we only look at overall performance).

Thanks for sharing the requirements.  A stable API is necessary for
providing these features.

We're essentially talking about libqemu.  That means QEMU in library
form with an API for JIT engine, reverse engineering, instrumentation,
etc tasks.

The user must write a driver program:

  #include <stdio.h>
  #include <libqemu.h>

  static void my_syscall(QemuVcpu *vcpu, uint64_t num, uint64_t arg1, ...)
  {
      if (num =3D=3D 0x123) {
          printf("r1 =3D %x\n", qemu_vcpu_get_reg32(vcpu, QEMU_REG_R1));
      }
  }

  int main(int argc, char **argv)
  {
      qemu_init(argc, argv);
      qemu_add_syscall_handler(my_syscall);
      qemu_run();
      return 0;
  }

There should be real C functions with API documentation instead of
hooking trace events by name.  Raw QEMU trace event arguments are not
suitable for libqemu users anyway (libqemu QemuVcpu and similar stable
API types are needed instead).

Maintaining libqemu will take ongoing effort and no one has committed.
The last discussion about libqemu was here:
https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg04847.html

I think think meets your requirements - native instrumentation code, no
recompiling QEMU, and flexible/powerful APIs possible.

Perhaps if you start with a focus on your use cases other people will
step in to help maintain and broaden the scope of libqemu for other
tasks.

What do you think?

Stefan

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgIapAAoJEJykq7OBq3PIPS8H/2fOMdqMNSFqr5EvYAVTTVGp
xPISNMDPjX7QPNKE82Iebv+q/vqsmI3Zf8hMsGqR5YbbL7tEfjw6MEMFED09c0w4
AGBtPWBctgCroEShlYoQMA5T0//2nXRJ8Zb37T3QceDiveKORFshBl2ldj2xsHVa
u2M5Jd5MZwj2FlKGKWaos3WHltCUt17HxmLwnr7/ZtGHXFAsbh4KG/5PZdwQ1pxr
4vKLHdnb/b25Iq/NGdVJ95t+OCei71B2Rfo+eYYvrncQ/eOkzIsWvRlaJQ4e4ZXO
MYEjKJZUVk3M2Xj1Ejf821bGJymAPM4wv+sO3HjJV1X5nuMdNMwTG/GIVwdQ7P8=
=qFaY
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
