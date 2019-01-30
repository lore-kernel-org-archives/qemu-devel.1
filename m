Received: from eggs.gnu.org ([209.51.188.92]:45306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gos84-0003qs-5C
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:50:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gos82-0003k5-6N
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:50:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gos80-0003ij-9g
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:50:18 -0500
Date: Wed, 30 Jan 2019 15:50:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190130155009.GV15904@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1548847315066.52692@radarservices.com>
	<ce2887d4-5e5d-bb33-77af-5ebb1e1c2463@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce2887d4-5e5d-bb33-77af-5ebb1e1c2463@msgid.tls.msk.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] SPICE session's connection_id's are not unique
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, Jan 30, 2019 at 06:29:04PM +0300, Michael Tokarev wrote:
> Forwarding to qemu-devel@ from http://bugs.debian.org/920897
>=20
> Thanks,
>=20
> /mjt
>=20
> -------- Forwarded message --------
> Subject: 	Bug#920897: SPICE session's connection_id's are not unique
> Date: 	Wed, 30 Jan 2019 11:21:54 +0000
> From: 	Philip Pum <Philip.Pum@radarservices.com>


> When creating a virtual machine with qemu (e.g. via libvirt) including =
a SPICE server,
> the client_id of the SPICE session is not unique. For example, starting=
 multiple
> virtual machines on the same libvirtd, the client_id is the same for al=
l virtual
> machine's SPICE sessions.
>=20
>=20
> A description of the client_id can be found in
>=20
> https://www.spice-space.org/static/docs/spice_protocol.pdf=C2=A0under s=
ection 2.11. c) :
>=20
>=20
> "UINT32 connection_id - In case of a new session (i.e., channel type is=
 RED_CHANNEL_MAIN)
>  this field is set to zero, and in response the server will allocate se=
ssion id and will
>  send it via the RedLinkReply message. In case of all other channel typ=
es, this field=20
>  will be equal to the allocated session id"

IIUC, that is just claiming that connection_id will be unique within the
scope of clients connected to a single SPICE server.

> The relevant code for generating client ids in libspice-server1 can be
> found here: https://gitlab.freedesktop.org/spice/spice/blob/v0.12.8/ser=
ver/reds.c#L1614
>=20
> This uses rand() to generate the random id, but qemu (at least in the
> case of qemu-system-x86) fails to initialize the RNG seed (with e.g. sr=
and()).
>=20
> The result is, that every SPICE session started (by e.g. libvirtd) has
> the same client_id. Usually, this is not a problem, but running somethi=
ng
> like a SPICE proxy, relying on the client_id to correctly route connect=
ions,
> this creates problems.

Presumably this means s/client_id/connection_id/ here given the quote
3 paragraphs earlier.

Each QEMU process has its own SPICE server, so the SPICE protocol spec
above does not guarantee that cconnection_id  is unique between
different QEMU process - only unique within multiple connections to
a single QEMU process, which I think is achieved even with the missing
srand() call.

Distinguishing different clients is a security critical task for a
SPICE proxy. I'm not sure I'd be comfortable with security of relying
on the 32-bit integer identifier to be unique across every SPICE server
in every QEMU when there are 100's of VMs on a host, even if QEMU did
call srand() correctly.

None the less, I'd suggest that spice server stop usin rand() entirely.
It already links to openssl, so I'd suggest they request a random value
from openssl which can provide cryptographically strong random values.

> Adding something like 'srand(time(NULL));' to qemu (in vl.c) solves thi=
s
> issue. Related (as seen in some VNC patches, e.g.
> 'CVE-2017-15124/04-ui-avoid-pointless-VNC-updates-if-framebuffer-isn-t-=
.patch/ui/vnc.c' ):=C2=A0 srand(time(NULL)+getpid()+getpid()*987654+rand(=
));

We should probably move the srand() call into vl.c in QEMU. At the same
time though, we should initialize it with a cryptoraphically strong
input we get from qcrypto_random_bytes(). Again though, we should purge
any code which uses rand() from QEMU, in favour of using qcrypto_random_b=
ytes
directly as that#s backed by a cryptographically strong source.

Fortnuately this use of rand() is not a security issue for VNC, since
the VNC authentication scheme is already fundamentally broken by
design and should never be used. The VNC TLS + SASL extensions
provide a real auth scheme for VNC.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
