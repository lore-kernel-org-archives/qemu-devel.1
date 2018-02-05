Received: from eggs.gnu.org ([2001:4830:134:3::10]:55033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eiieA-0005PM-IA
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eiie6-0000Ob-Cn
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:25:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eiie6-0000NJ-3g
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:25:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52165C058ECE
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 15:25:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon,  5 Feb 2018 15:24:46 +0000
Message-Id: <20180205152455.12088-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/9] Enable passing pre-opened chardev
 socket FD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

An update of:

  v1: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04618.html
  v2: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04706.html
  v3: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04892.html

This enables fixing a long standing problem that libvirt has with
starting up QEMU. It has to busy-wait retrying connect() on the QMP
monitor socket until QEMU finally creates & listens on it, but at same
time must be careful to not wait forever if QEMU exits.

With this patch series, libvirt can simply pass in a pre-opened UNIX doma=
in
socket file descriptor, which it can immediately connect to with no busy-=
wait.

NB, this will generate one expected failure with patchew / checkpatch.pl

  ERROR: consider using qemu_strtol in preference to strtol
  #729: FILE: util/cutils.c:338:
  +    lresult =3D strtol(nptr, &ep, base);

  ERROR: consider using qemu_strtol in preference to strtol
  #779: FILE: util/cutils.c:388:
  +    lresult =3D strtol(nptr, &ep, base);

This is ok to ignore, because the patch in question is introducing new
qemu_strtoXXX wrappers

Changed in v4:

  - Add test for fd_is_socket() API (Marc-Andre)

Changed in v3:

  - Introduce  qemu_strtoi & qemu_stroui functions.

  - Split patchs up into more pieces to better separate each logical
    change

  - Introduce a new test/test-sockets.c to directly test the
    SocketAddress FD handling, separately from chardev code.

  - Add qapi docs for FD passing syntax

  - Other misc fixes in tests

  - Reduce code duplication when getting pre-opened FDs in
    socket_connect/listen.

Changed in v2:

  - Drop 'fdset' property / address kind, and use 'fd' for both CLI and H=
MP
  - Add unit tests


Daniel P. Berrange (9):
  char: don't silently skip tn3270 protocol init when TLS is enabled
  cutils: add qemu_strtoi & qemu_strtoui parsers for int/unsigned int
    types
  sockets: pull code for testing IP availability out of specific test
  sockets: strengthen test suite IP protocol availability checks
  sockets: move fd_is_socket() into common sockets code
  sockets: check that the named file descriptor is a socket
  sockets: allow SocketAddress 'fd' to reference numeric file
    descriptors
  char: refactor parsing of socket address information
  char: allow passing pre-opened socket file descriptor at startup

 chardev/char-socket.c          |  34 ++-
 chardev/char.c                 |   3 +
 include/qemu/cutils.h          |   4 +
 include/qemu/sockets.h         |   1 +
 io/channel-util.c              |  13 -
 qapi/sockets.json              |   7 +
 tests/.gitignore               |   1 +
 tests/Makefile.include         |   5 +-
 tests/socket-helpers.c         | 153 ++++++++++
 tests/socket-helpers.h         |  42 +++
 tests/test-char.c              |  47 ++-
 tests/test-cutils.c            | 653 +++++++++++++++++++++++++++++++++++=
++++++
 tests/test-io-channel-socket.c |  72 +----
 tests/test-util-sockets.c      | 266 +++++++++++++++++
 util/cutils.c                  | 104 +++++++
 util/qemu-sockets.c            |  36 ++-
 16 files changed, 1343 insertions(+), 98 deletions(-)
 create mode 100644 tests/socket-helpers.c
 create mode 100644 tests/socket-helpers.h
 create mode 100644 tests/test-util-sockets.c

--=20
2.14.3
