Received: from eggs.gnu.org ([2001:4830:134:3::10]:37121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOjCN-0007CW-D1
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOjCG-0006TD-JB
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:30:27 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fOjCF-0006SN-PV
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:30:20 -0400
Received: by mail-wr0-x241.google.com with SMTP id y15-v6so36178504wrg.11
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 05:30:19 -0700 (PDT)
Date: Fri, 1 Jun 2018 13:30:16 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180601123016.GP8687@stefanha-x1.localdomain>
References: <CANzW0mv3x1Hxje9fPEAExOb_kmCg2HU9jE_nwpLMqQk2Wh+KQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kOdvwer/5gjFgNo6"
Content-Disposition: inline
In-Reply-To: <CANzW0mv3x1Hxje9fPEAExOb_kmCg2HU9jE_nwpLMqQk2Wh+KQQ@mail.gmail.com>
Subject: Re: [Qemu-devel] "socket" host network backend: suggested
 improvements and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com


--kOdvwer/5gjFgNo6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2018 at 04:34:03PM +0600, Artem Pisarenko wrote:
> Hi to all.

Hi Artem,
I have CCed Jason Wang, the QEMU networking maintainer, so your email
gets attention.  QEMU is a high-traffic mailing list and you may not get
responses unless you CC relevant people (use scripts/get_maintainer.pl
-f path/to/source.c to look up maintainers).

> I'm working on integrating QEMU networking to simulation environment and
> found socket backend very convenient: it's simple, easy to use (i.e no
> intermediate things required, such as tap/tun adapter, vde switch, etc.)
> and transparent to host environment (i.e. it doesn't pollutes system with
> bunch of virtual devices, etc.).
>=20
> Although, it have some problems, closely related to each other. I've
> investigated source code and played with it a little, but I'm not ready
> submit a complete patch. So, here are my thoughts...
>=20
> 1. Internal protocol (only qemu instances can join its network devices
> between). I suggest to make it available to plug with external software,
> i.e freeze communication protocol at current state and document it in
> docs/interop/ directory.
>=20
> 2. Transport options wrongly documented. Section "2.3.6 Network options"
> lists "-netdev socket,..." entries. It gives very different basic
> understanding of how it works from actual one.
>  2.1. It has two entries: listen/connect (TCP connecton) and mcast
> (multicast UDP), but 'qemu --help' outputs additional one - udp (UDP
> tunnel), which is undocumented, but looks like working.
>  2.2. Each entry has fd=3Dh parameter, which looks like it's an optional
> parameter, but code analysis (net/socket.c) shows that, in fact, it's a
> separate transport option exclusive to listed ones. It used as follows:
> user creates/opens whatever (almost) custom socket/file it wants, connects
> it with other endpoint and passes file descriptor (handle) to qemu, which
> just recv/send over it and nothing more.
>  2.3. As a consequence, if you try to invoke any transport/variant option
> with "fd=3D", you'll get an error: "exactly one of listen=3D, connect=3D,=
 mcast=3D
> or udp=3D is required". And again, error message is incomplete - it misses
> "fd=3D" option.
>=20
> 3. "fd=3D" transport doesn't work with SOCK_DGRAM type sockets. It's due =
to
> an implementation error in net/socket.c. Function
> net_socket_receive_dgram() uses sendo() call with s->dgram_dst value which
> is undefined for this case (and, of course, cannot be defined).
> Although net_socket_fd_init() execution branch is smart enough to detect
> type of socket passed with "fd=3D", but its "connected" state forgotten
> afterwards. Suggested fix: replace sendto() with send(), which correctly
> assumes already connected socket, and add corresponding connect() calls f=
or
> "mcast=3D" and "udp=3D" init sequences.
>=20
> (For those, who interested, currently I've got working network
> communication with unmodified qemu 2.12.0 in Linux using UNIX domain
> sockets created by socketpair(AF_LOCAL, SOCK_STREAM, ...), one of which
> passed to spawned child qemu process via -netdev socket,fd=3D... and other
> one, used in parent application process to send/receive packets. Protocol,
> used by qemu, is simple and implements only data plane: it just transfers
> raw ethernet frames in binary form, for datagram-type sockets it's
> straightforward, and for stream-type sockets each frame prepended with
> uint32 length in network byte order, without any delimiters and escaping.)
> --=20
>=20
> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
>   =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=
=BD=D0=BA=D0=BE

--kOdvwer/5gjFgNo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbETxYAAoJEJykq7OBq3PIqXEH/1lV1UsFtfwrs0dVeSR14UUy
mngeIA3/bTo8b86YcW7bIwnefLQWAaRDI0AqrtYTyZdNAqFbR4Mu6g0lnzGzSBzT
aPXuNyazNs77VqLBFJFwSc3AcQRJZMQiuYP22Ef0bOL4nPMMwIpDz7YiPzcZsWPW
er8x8yfll3pO8CeC2uWtrEai/Z8i9WubrxJSqyTgJuM9QJAYdyiguTDUEgEMwaXU
IMcafEJW9JHNiLt7Xmmov2dHV6FNm8cpKuND0tooAbtrfVcdXuCtwCJclu7RhHyp
73NdQqy4BpKulS7JnUOXLfLwJ1afBPEVSemrSrYxcgivb1KMOWg6aoCI0l/bHzU=
=Rfpr
-----END PGP SIGNATURE-----

--kOdvwer/5gjFgNo6--
