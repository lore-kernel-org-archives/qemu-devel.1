Received: from eggs.gnu.org ([2001:4830:134:3::10]:52860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1fNyQr-0008G4-ME
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1fNyQq-0001k1-BL
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:34:17 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:46194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1fNyQq-0001jh-4d
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:34:16 -0400
Received: by mail-ot0-x234.google.com with SMTP id t1-v6so20508647ott.13
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 03:34:15 -0700 (PDT)
MIME-Version: 1.0
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Wed, 30 May 2018 16:34:03 +0600
Message-ID: <CANzW0mv3x1Hxje9fPEAExOb_kmCg2HU9jE_nwpLMqQk2Wh+KQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] "socket" host network backend: suggested improvements
 and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi to all.

I'm working on integrating QEMU networking to simulation environment and
found socket backend very convenient: it's simple, easy to use (i.e no
intermediate things required, such as tap/tun adapter, vde switch, etc.)
and transparent to host environment (i.e. it doesn't pollutes system with
bunch of virtual devices, etc.).

Although, it have some problems, closely related to each other. I've
investigated source code and played with it a little, but I'm not ready
submit a complete patch. So, here are my thoughts...

1. Internal protocol (only qemu instances can join its network devices
between). I suggest to make it available to plug with external software,
i.e freeze communication protocol at current state and document it in
docs/interop/ directory.

2. Transport options wrongly documented. Section "2.3.6 Network options"
lists "-netdev socket,..." entries. It gives very different basic
understanding of how it works from actual one.
 2.1. It has two entries: listen/connect (TCP connecton) and mcast
(multicast UDP), but 'qemu --help' outputs additional one - udp (UDP
tunnel), which is undocumented, but looks like working.
 2.2. Each entry has fd=3Dh parameter, which looks like it's an optional
parameter, but code analysis (net/socket.c) shows that, in fact, it's a
separate transport option exclusive to listed ones. It used as follows:
user creates/opens whatever (almost) custom socket/file it wants, connects
it with other endpoint and passes file descriptor (handle) to qemu, which
just recv/send over it and nothing more.
 2.3. As a consequence, if you try to invoke any transport/variant option
with "fd=3D", you'll get an error: "exactly one of listen=3D, connect=3D, m=
cast=3D
or udp=3D is required". And again, error message is incomplete - it misses
"fd=3D" option.

3. "fd=3D" transport doesn't work with SOCK_DGRAM type sockets. It's due to
an implementation error in net/socket.c. Function
net_socket_receive_dgram() uses sendo() call with s->dgram_dst value which
is undefined for this case (and, of course, cannot be defined).
Although net_socket_fd_init() execution branch is smart enough to detect
type of socket passed with "fd=3D", but its "connected" state forgotten
afterwards. Suggested fix: replace sendto() with send(), which correctly
assumes already connected socket, and add corresponding connect() calls for
"mcast=3D" and "udp=3D" init sequences.

(For those, who interested, currently I've got working network
communication with unmodified qemu 2.12.0 in Linux using UNIX domain
sockets created by socketpair(AF_LOCAL, SOCK_STREAM, ...), one of which
passed to spawned child qemu process via -netdev socket,fd=3D... and other
one, used in parent application process to send/receive packets. Protocol,
used by qemu, is simple and implements only data plane: it just transfers
raw ethernet frames in binary form, for datagram-type sockets it's
straightforward, and for stream-type sockets each frame prepended with
uint32 length in network byte order, without any delimiters and escaping.)
--=20

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=
=D0=BA=D0=BE
