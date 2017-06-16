Received: from eggs.gnu.org ([2001:4830:134:3::10]:33853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dLoFM-0005rt-3U
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dLoFI-0002XZ-Tv
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:12:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dLoFI-0002VA-L4
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:12:52 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 16 Jun 2017 11:12:41 +0100
Message-Id: <20170616101246.1550-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/5] Fix handling of IPv4/IPv6 dual stack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This is a followup to:

  v1: https://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg05659.h=
tml
  v2: https://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg04706.h=
tml
  v3: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg00027.html

This was posted as a pull request here:

  https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg01940.html

However, the fixes to patch 5 were non-trivial, so I need to get review
on patch 5 before I send a second pull request.

This series aims to fix a lot of bugs related to handling of IPv4 / IPv6
dual stack.

 - The VNC server mistakenly listened on two separate ports 5900+5901
   when the to=3D parameter was given
 - IPv6 sockets are accepting IPv4 clients even when IPv4 is set to
   be disabled
 - IPv6 sockets are failing to accept IPv4 clients when IPv4 is not set
   to be disabled
 - The VNC server was loosing the ipv4=3D/ipv6=3D settings due to a bug
   in the DNS resolver

The behaviour of all this is really subtle and hard to get working correc=
tly
across all the different network backends. Thus, the most important part =
of
this patch series is the last patch which adds a test case covering the
backends for -vnc, -chardev tcp, -net socket, and -incoming socket, with
a 120 entry matrix.

IOW, if you think any of the first 4 patches are applying the wrong logic=
,
then take a look at the last patch and indicate which test matrix entries
are believed to be defining wrong behaviour :-)

Changed in v4:

 - Change test suite so that it copes with differing getaddrinfo()
   ordering for IPv4 vs IPv6 results for hostname=3D=3DNULL
 - List test suite for all qtest arches, not only i386/ppc64
 - Use -machine none so test suite passes on aarch64 and other
   arches with no default machine type.

Changed in v3:

 - Clarified error message in commit message
 - Replace assert with exit (Eric)
 - Fix typo in test comment (Eric)
 - Fix wierd copyright line (Eric)

Daniel P. Berrange (5):
  sockets: ensure we can bind to both ipv4 & ipv6 separately
  sockets: don't block IPv4 clients when listening on "::"
  sockets: ensure we don't accept IPv4 clients when IPv4 is disabled
  io: preserve ipv4/ipv6 flags when resolving InetSocketAddress
  tests: add functional test validating ipv4/ipv6 address flag handling

 io/dns-resolver.c          |   6 +-
 tests/.gitignore           |   1 +
 tests/Makefile.include     |   3 +
 tests/test-sockets-proto.c | 921 +++++++++++++++++++++++++++++++++++++++=
++++++
 util/qemu-sockets.c        |  71 +++-
 5 files changed, 981 insertions(+), 21 deletions(-)
 create mode 100644 tests/test-sockets-proto.c

--=20
2.9.3
