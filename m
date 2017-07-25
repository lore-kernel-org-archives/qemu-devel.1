Received: from eggs.gnu.org ([2001:4830:134:3::10]:39143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dZzkR-00045R-Oo
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dZzkM-0004hD-Rn
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:19:39 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:36805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dZzkM-0004gu-Kp
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:19:34 -0400
Received: by mail-wm0-x22f.google.com with SMTP id t201so45684824wmt.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 06:19:34 -0700 (PDT)
Date: Tue, 25 Jul 2017 14:19:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725131931.GC23343@stefanha-x1.localdomain>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
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
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 08:02:24PM +0300, Llu=EDs Vilanova wrote:
> This series adds a basic interface to instrument tracing events and contr=
ol
> their tracing state.
>=20
> The instrumentation code is dynamically loaded into QEMU (either when it =
starts
> or later using its remote control interfaces).
>=20
> All events can be instrumented, but the instrumentable events must be exp=
licitly
> specified at configure time.
>=20
> Signed-off-by: Llu=EDs Vilanova <vilanova@ac.upc.edu>

Hi Llu=EDs,
I'm concerned that the shared library interface will be abused to monkey
patch code into QEMU far beyond instrumentation use cases and/or avoid
the responsibilities of the GPL license.

Instead I suggest adding a trace backend generates calls to registered
"callback" functions:

  $ cat >my-instrumentation.c
  #include "trace/control.h"

  static void my_cpu_in(unsigned int addr, char size, unsigned int val)
  {
      printf("my_cpu_in\n");
  }

  static void my_init(void)
  {
      trace_register_event_callback("cpu_in", my_cpu_in);
      trace_enable_events("cpu_in");
  }
  trace_init(my_init);

  $ ./configure --enable-trace-backends=3Dlog,callback && make -j4

This is still a clean interface that allows instrumentation code to be
kept separate from the trace event call sites.

The instrumentation code gets compiled into QEMU, but that shouldn't be
a huge burden since QEMU's Makefiles only recompile changed source
files (only the first build is slow).

Does this alternative sound reasonable to you?

Stefan

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZd0VjAAoJEJykq7OBq3PIRwsIAIfnyrEfARmrzaKgNZ1KHNat
Kh84PWcSB3cwHTZje2c2gsQ8a2kv8mZeMPN7ZnoIJeizXs24Xax54eDK5dsDKgTS
ZYGAXTf3U9off188A/tnuoTqqynPm+jE477Oj58YaGss2iQio9di+YGbXRHI7dX6
KCFtL+hSWqydUk4fL5N8ODyq9D9ynFch+wEfYq/7kf2KpdPaBBs6+uLdre7pQW3S
mo+WJqVj4oK2kuE/EqsS3uRFVjdo+U8EueRoZ3Tk/rMcpiuVK9qm9WAf7yASsi1K
4qlGW6LUYCu3hp8vScALnBas3dn64Jj8G4gA2T7OI8S0vAod5Pj+iWvbDiIfjdA=
=q/RC
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
