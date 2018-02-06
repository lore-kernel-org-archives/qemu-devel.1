Received: from eggs.gnu.org ([2001:4830:134:3::10]:55462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eizNG-0000zX-CN
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eizNB-0004eT-9e
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:17:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eizNB-0004df-1t
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:17:05 -0500
Date: Tue, 6 Feb 2018 09:17:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180206091700.GB4942@stefanha-x1.localdomain>
References: <CAPHFV4=P3viF0m0PtqFZZ8_JNxy7G6kXdysYAfSsOJZe=2j7gw@mail.gmail.com>
	<20180202100843.GD13090@stefanha-x1.localdomain>
	<CAFEAcA-5PwhJw9epXh+0_oe3E-vsVKkQDX3s1Go-FBzO=FA3zA@mail.gmail.com>
	<20180205155108.GF28241@stefanha-x1.localdomain>
	<CAFEAcA-vd3vEJ0i=2LtaR-NQjHoJVYWCNDHOmh3iREPcQsqR4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-vd3vEJ0i=2LtaR-NQjHoJVYWCNDHOmh3iREPcQsqR4A@mail.gmail.com>
Subject: Re: [Qemu-devel] Qemu Trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Nesrine Zouari <nesrine.zouari@enis.tn>, QEMU Developers <qemu-devel@nongnu.org>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2018 at 03:55:01PM +0000, Peter Maydell wrote:
> On 5 February 2018 at 15:51, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > The point of the instrumentation plugin API is for online analysis
> > (stuff that cannot be post-processed offline) with the ability for the
> > plugin to control QEMU (e.g. affect translation during a run).  That is
> > not necessary for Nesrine's use case.
>=20
> ...but it hugely overlaps, because the most interesting
> reason for having a trace plugin is to be able to do things
> like tracing instruction flow, memory access and so on.
>=20
> > I see two main requirements in Nesrine's use case:
> >
> > 1. Instruction flow, memory access, and task switch trace.  This doesn't
> > exist today and requires adding new trace events.
> >
> > 2. An external interface for processing traces.  There seems to be a
> > requirement for doing it online and not by post-processing trace files.
> > Therefore I suggested looking into LTTng UST, which has an efficient
> > interface and libraries for tracing processes.  I think no QEMU changes
> > are necessary here.
>=20
> ...and "online processing of traces" is pretty much exactly
> what an instrumentation plugin API is for.

There are two cases for online processing:

1. Synchronous - this is what the instrumentation plugins will be able
   to do.  It means that QEMU waits until the event has been processed,
   and the plugin is therefore able to control QEMU.

2. Asynchronous - this is what LTTng UST does.  It means that the
   process analyzing the trace does not hold up QEMU, but it cannot
   control QEMU without some delay between trace events firing and
   reacting to them.  I think Nesrine's use case is this one.

#2 is useful for "real-time" graphs, for example.  That is still
"oneline" but it doesn't require instrumentation plugins.

Given that the instrumentation plugin API is still in early development,
it would delay Nesrine's work and I recommend against depending on it.

> It would also let you put the logic of "how do we know what a
> guest OS task switch is anyway" somewhere other than QEMU,
> which is nice because that's very guest-OS specific.

How do you envision that instrumentation plugins will monitor guest OS
task switches if QEMU does not know about them?

Without instrumentation plugins I would add a guest_x86_cr3_write trace
event, for example.  Then the trace consumer can interpret that event as
a task switch if it knows the guest OS always writes to the cr3 register
on a task switch.  No instrumentation plugins are necessary in order to
do this and it doesn't hardcode knowledge of guest OS task switching
into QEMU either.

Stefan

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaeXKLAAoJEJykq7OBq3PIk7sIALCfoL/M7T1PrAzTz7ibSrIA
yHXvqcLk8y3l1men5/pBgb4oUtggOYnOVrj+EmMEverGFzRPMg2zAPCmr/Y4HV4P
toLbwTvGmmHkqQwY4yjNeBE/Nvz+3qo1Mzq09qR0QuS+621Wfww6s9VPXMDTQWyD
q74K+TT9UyLWLKGf/Tmc+2CAWKulIyQtm6QsHiO37ATUeK8oV+X6KV4haemlXtZ3
+L+bRX7B+Rd6EnrO08mxD1oyIraXDGBEIwGuEVWs8SiuK5nf6Bpbh8Wwra2LF2Ux
2Xd4VQv92+OUTmbpLUD22EFOw1NREAeGi5Nc4/kE06SJGDrmXGDquBWOziY5jlM=
=5/4A
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
