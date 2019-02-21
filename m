Received: from eggs.gnu.org ([209.51.188.92]:34607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmC4-0001ll-QU
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmC4-0006hS-1S
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53381)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwmC3-0006gz-Rf
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:07 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E3E683F4C
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:07:07 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 Feb 2019 12:06:52 +0100
Message-Id: <20190221110703.5775-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/11] spice: add -display spice-app,
 setup and launch a Spice client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Hi,

The QEMU GTK UI is quite featurful. Yet, it doesn't provide many of
the functionalities one can expect from a VM desktop application (USB
redirection, shared folders, drag and drop, better multimonitor
support etc.).

Spice is able to export many of the VM controls to a client, including
QMP monitor, serial ports etc... It's thus possible for a Spice client
to provide a similar experience as the QEMU GTK UI (while keeping
similar display performances locally) and more.

This series provides "-display spice-app" to setup a Spice server and
launch a client (associated with the spice+unix:// URI). With
virt-viewer series "Add QEMU-like UI: VT console & basic VM state"
(under review), the resulting user experience is close to what qemu
GTK UI provides.

v3:
- Add hints on "default" selection in "qapi: document DisplayType enum"
- add tested-by tags
- rebased

v2:
- renamed -display app -> -display spice-app
- error if full-screen or window-close is provided (supports can be
  added later)
- use a stable URI when -name is provided
- print the URI at start
- added "qapi: document DisplayType enum"
- added "spice: use a default name for the server"
- commit message tweaks
- include previously reviewed "configure: bump spice-server required
  version to 0.12.5", to avoid conflicts
- rebased

Marc-Andr=C3=A9 Lureau (11):
  char/spice: trigger HUP event
  char/spice: discard write() if backend is disconnected
  spice: avoid spice runtime assert
  spice: merge options lists
  spice: do not stop spice if VM is paused
  char: move SpiceChardev and open_spice_port() to spice.h header
  char: register spice ports after spice started
  build-sys: add gio-2.0 check
  qapi: document DisplayType enum
  spice: use a default name for the server
  display: add -display spice-app launching a Spice client

 qapi/ui.json            |  32 ++++++-
 include/chardev/spice.h |  27 ++++++
 chardev/spice.c         |  60 +++++++-----
 ui/spice-app.c          | 200 ++++++++++++++++++++++++++++++++++++++++
 ui/spice-core.c         |  13 ++-
 chardev/trace-events    |   1 +
 configure               |  13 +++
 qemu-options.hx         |   5 +
 ui/Makefile.objs        |   5 +
 9 files changed, 329 insertions(+), 27 deletions(-)
 create mode 100644 include/chardev/spice.h
 create mode 100644 ui/spice-app.c

--=20
2.21.0.rc1
