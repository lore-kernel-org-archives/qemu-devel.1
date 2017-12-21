Received: from eggs.gnu.org ([2001:4830:134:3::10]:43166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eS3Fo-0008N2-3i
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 10:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eS3Fk-0000Cx-5r
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 10:59:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eS3Fj-0000Co-Vt
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 10:59:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF4CD5D9E3
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 15:59:22 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 21 Dec 2017 15:59:03 +0000
Message-Id: <20171221155905.3793-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] Enable passing pre-opened chardev
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

Changed in v2:

  - Drop 'fdset' property / address kind, and use 'fd' for both CLI and HMP
  - Add unit tests

Daniel P. Berrange (2):
  io: move fd_is_socket() into common sockets code
  char: allow passing pre-opened socket file descriptor at startup

 chardev/char-socket.c  |  32 +++++++--
 chardev/char.c         |   3 +
 include/qemu/sockets.h |   1 +
 io/channel-util.c      |  13 ----
 tests/test-char.c      | 173 ++++++++++++++++++++++++++++++++++++++++++++++++-
 util/qemu-sockets.c    |  55 +++++++++++++++-
 6 files changed, 252 insertions(+), 25 deletions(-)

-- 
2.14.3
