Received: from eggs.gnu.org ([2001:4830:134:3::10]:50341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehcmJ-0003vA-UH
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:57:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehcmJ-0001hu-3U
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:57:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ehcmI-0001hJ-RK
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:57:23 -0500
Date: Fri, 2 Feb 2018 10:08:43 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180202100843.GD13090@stefanha-x1.localdomain>
References: <CAPHFV4=P3viF0m0PtqFZZ8_JNxy7G6kXdysYAfSsOJZe=2j7gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline
In-Reply-To: <CAPHFV4=P3viF0m0PtqFZZ8_JNxy7G6kXdysYAfSsOJZe=2j7gw@mail.gmail.com>
Subject: Re: [Qemu-devel] Qemu Trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nesrine Zouari <nesrine.zouari@enis.tn>
Cc: qemu-devel@nongnu.org, vilanova@ac.upc.edu


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2018 at 04:30:10PM +0100, Nesrine Zouari wrote:
> I am a computer engineering student and I am actually working on my
> graduation project at Lauterbach company. The project is about Qemu Trace
> and as a future I would like to contribute this work to the main line.
>=20
> My project is divided into two parts:
>=20
> 1/ Collecting the Guest trace data : The trace solution should be able to
> provide:
>=20
>             a/ Instruction flow Trace
>=20
>             b/ Memory read/write access
>=20
>             c/ Time Stamps.
>=20
>             d/ For tracing rich operating systems that are using MMU, we
> additionally need to trace the task switches.

Llu=ECs has done the most instrumentation work in qemu.git and can explain
the current status.

The focus in QEMU is more on functional simulation than on low-level
instrumentation.  Therefore the instrumentation facilities aren't very
rich.  Code changes will be required to get the information you need.
In order to be suitable for upstream they should not be too invasive or
impact performance significantly.

Which CPU architecture are you targeting?

> 2/ Sending the collected data to a third party tool for analysis.
>=20
> My question is about the first part. I would like to know, which trace
> backend that better fit my use case.

LTTng UST has the highest performance tracing interface.  It uses shared
memory to efficiently export trace data to a collector or analysis
process.

It is probably not necessary to invent your own tracer or interface for
capturing trace data.  I suggest looking into LTTng UST and trying it
out.

The basic idea would be:

1. Add missing trace events to QEMU
2. Build with ./configure --enable-trace-backend=3Dust && make
3. Use LTTng tools or write your own collector using the LTTng libraries
4. Enable the trace events that you need for instruction flow, memory
   access, and task switching.

The QEMU code changes involved would be changes to trace-events and
placing those trace events into TCG and/or memory API code to record the
necessary information.

Stefan

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJadDirAAoJEJykq7OBq3PITZgH/iVNx07yukt1YLsA7A2Ewb6D
vpFFc5C6XmZPft2xp2qIYM2gCQ0unRMQZ7ggq+SoX6YcRxrK7jFZn0x8iM4aCd13
4bcV2XztaffJe7iJqU4H2i15lBrTCDMvMQgVyZIjFCAxti7TmBbcFkULHRLfRcy5
OwMjUZ7ESrYxKkpfLs1NiXfsGHTHdFdyUCZc5eF/mvdyqVooFGY6y9NB5VOHKA0n
pyjJv1/YCRi2eWTOJodGjrNA0bPfBnhXnmUsINBMOS+cP98yCz5RBgC2qo/nb7we
wznmijIryISi/Hcv9MuzzaLDS/rqeJ0V0e3wH/JBnQNWFSki1PSlayNepie+t10=
=G8q1
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--
