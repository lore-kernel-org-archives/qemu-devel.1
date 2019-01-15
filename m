Received: from eggs.gnu.org ([209.51.188.92]:48068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjQBK-00016t-U3
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:59:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjQBE-0006md-Ku
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:59:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gjQBE-0006m7-25
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:59:04 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 15 Jan 2019 14:52:44 +0000
Message-Id: <20190115145256.9593-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/12] chardev: refactoring & many bugfixes
 related tcp_chr_wait_connected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Yongji Xie <elohimes@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This series comes out of a discussion between myself & Yongji Xie in:

  https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg01881.html

I eventually understood that the problem faced was that
tcp_chr_wait_connected was racing with the background connection attempt
previously started, causing two connections to be established. This
broke because some vhost user servers only allow a single connection.

After messing around with the code alot the final solution was in fact
very easy. We simply have to delay the first background connection
attempt until the main loop is running. It will then automatically
turn into a no-op if tcp_chr_wait_connected has been run. This is
dealt with in the last patch in this series

I believe this should solve the problem Yongji Xie faced, and thus not
require us to add support for "nowait" option with client sockets at
all. The reconnect=3D1 option effectively already implements nowait
semantics, and now plays nicely with tcp_chr_wait_connected.

In investigating this I found various other bugs that needed fixing and
identified some useful refactoring to simplify / clarify the code, hence
this very long series.

This series passes make check-unit & check-qtest (for x86_64 target).

I did a test with tests/vhost-user-bridge too, which was in fact already
broken for the same reason Yongji Xie found - it only accepts a single
connection. This series fixes use of reconnect=3D1 with vhost-user-bridge=
.

Despite me not adding new functionality in this series, I think we could
probably do with further unit test cover for the socket chardev backend.
I'll investigate this while waiting for reviews on this series so far.

Daniel P. Berrang=C3=A9 (12):
  chardev: fix validation of options for QMP created chardevs
  chardev: forbid 'reconnect' option with server sockets
  chardev: forbid 'wait' option with client sockets
  chardev: remove many local variables in qemu_chr_parse_socket
  chardev: ensure qemu_chr_parse_compat reports missing driver error
  chardev: remove unused 'sioc' variable & cleanup paths
  chardev: split tcp_chr_wait_connected into two methods
  chardev: split up qmp_chardev_open_socket connection code
  chardev: use a state machine for socket connection state
  chardev: honour the reconnect setting in tcp_chr_wait_connected
  chardev: disallow TLS/telnet/websocket with tcp_chr_wait_connected
  chardev: fix race with client connections in tcp_chr_wait_connected

 chardev/char-socket.c          | 428 +++++++++++++++++++++++----------
 chardev/char.c                 |   2 +
 tests/ivshmem-test.c           |   2 +-
 tests/libqtest.c               |   4 +-
 tests/test-filter-redirector.c |   4 +-
 5 files changed, 303 insertions(+), 137 deletions(-)

--=20
2.20.1
