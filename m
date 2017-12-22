Received: from eggs.gnu.org ([2001:4830:134:3::10]:47247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSNe0-0006C9-E9
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:45:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSNdx-0002jW-AJ
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:45:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18077)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eSNdx-0002ii-3k
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:45:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DC4672FF4
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 13:45:44 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 22 Dec 2017 13:45:19 +0000
Message-Id: <20171222134527.14467-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/8] Enable passing pre-opened chardev
 socket FDs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This fixes a long standing problem that libvirt has with starting up QEMU.

We have to busy-wait retrying connect() on the QMP monitor socket until QEMU
finally creates & listens on it, but at same time must be careful to not wait
forever if QEMU exits.

This this patch series, libvirt can simply pass in a pre-opened UNIX domain
socket file descriptor, which it can immediately connect to with no busy-wait.

Changed in v3:

  - Introduce  qemu_strtoi & qemu_stroui functions. NB, patchew and
    checkpatch.pl complain about this patch because it calls strtol,
    but that is valid in this case.

  - Split patchs up into more pieces to better separate each logical
    change

  - Introduce a new test/test-sockets.c to directly test the
    SocketAddress FD handling, separately from chardev code.

  - Add qapi docs for FD passing syntax

  - Other misc fixes in tests

  - Reduce code duplication when getting pre-opened FDs in
    socket_connect/listen.

Changed in v2:

  - Drop 'fdset' property / address kind, and use 'fd' for both CLI and HMP
  - Add unit tests

Daniel P. Berrange (8):
  cutils: add qemu_strtoi & qemu_strtoui parsers for int/unsigned int
    types
  sockets: move fd_is_socket() into common sockets code
  sockets: pull code for testing IP availability out of specific test
  sockets: strengthen test suite IP protocol availability checks
  sockets: check that the named file descriptor is a socket
  sockets: allow SocketAddress 'fd' to reference numeric file
    descriptors
  char: refactor parsing of socket address information
  char: allow passing pre-opened socket file descriptor at startup

 chardev/char-socket.c          |  31 +-
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
 tests/test-cutils.c            | 653 +++++++++++++++++++++++++++++++++++++++++
 tests/test-io-channel-socket.c |  72 +----
 tests/test-sockets.c           | 239 +++++++++++++++
 util/cutils.c                  | 104 +++++++
 util/qemu-sockets.c            |  36 ++-
 16 files changed, 1315 insertions(+), 96 deletions(-)
 create mode 100644 tests/socket-helpers.c
 create mode 100644 tests/socket-helpers.h
 create mode 100644 tests/test-sockets.c

-- 
2.14.3
