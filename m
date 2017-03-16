Received: from eggs.gnu.org ([2001:4830:134:3::10]:46936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRbA-0003xC-9S
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRb5-00009y-Gn
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1coRb5-00009r-B2
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA8E164D8A
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:21:26 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Mar 2017 13:21:00 +0400
Message-Id: <20170316092121.25672-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/21] chardev clean-ups & tests (after 2.9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

The following series contains various patches:
- replace "chardevs" list for a /chardevs container object
- add a few read-only socket properties mainly useful for testing
- some chardev related clean-ups
- add various chardev tests

This series is part of a larger refactoring series that I try to keep
up to date here: https://github.com/elmarco/qemu/commits/chrfe

v3:
- open code object_new_with_props() as suggest by Paolo
- added some r-b tags
- rebased

v2:
- replaced root container unref with a TODO
- call object_unparent() directly instead of qemu_chr_delete()
- remove bad qcow2 NULL check removal
- rebased

Marc-Andr=C3=A9 Lureau (21):
  char: remove qemu_chr_be_generic_open
  mux: simplfy muxes_realize_done
  xen: use a better chardev type check
  container: don't leak container reference
  char: add a /chardevs container
  vl: add todo note about root container cleanup
  char: use /chardevs container instead of chardevs list
  char: remove qemu_chardev_add
  char: remove chardevs list
  char: useless NULL check
  char-socket: introduce update_disconnected_filename()
  char-socket: update local address after listen
  char-socket: add 'addr' property
  char-socket: add 'connected' property
  char-udp: flush as much buffer as possible
  tests: add alias check in /char/ringbuf
  tests: add /char/pipe test
  tests: add /char/file test
  tests: add /char/socket test
  tests: add /char/udp test
  tests: add /char/console test

 chardev/char-mux.h          |   2 +-
 include/sysemu/char.h       |  10 --
 chardev/char-mux.c          |  11 +-
 chardev/char-pty.c          |   2 +-
 chardev/char-socket.c       |  46 +++++-
 chardev/char-udp.c          |  26 ++--
 chardev/char.c              | 148 ++++++++----------
 gdbstub.c                   |   4 +-
 hw/usb/ccid-card-passthru.c |   2 +-
 hw/usb/redirect.c           |   2 +-
 net/vhost-user.c            |   2 +-
 qom/container.c             |   1 +
 tests/test-char.c           | 366 ++++++++++++++++++++++++++++++++++++++=
+++++-
 tests/vhost-user-test.c     |   2 +-
 ui/console.c                |   2 +-
 ui/gtk.c                    |   2 +-
 vl.c                        |   1 +
 xen-common.c                |   2 +-
 18 files changed, 504 insertions(+), 127 deletions(-)

--=20
2.12.0.191.gc5d8de91d
