Received: from eggs.gnu.org ([2001:4830:134:3::10]:39929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fldzx-0007kS-6v
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fldzu-00014Q-46
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fldzt-00013v-Uv
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 517B8401CB8A
	for <qemu-devel@nongnu.org>; Fri,  3 Aug 2018 17:36:17 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  3 Aug 2018 19:36:04 +0200
Message-Id: <20180803173614.12358-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/10] RFC: spice: add -display app to launch
 external UI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Hi,

One of the most featurefull UI that qemu has is the GTK one. Yet, it
doesn't provide many of the functionalities we can expect from a VM
desktop application (USB redirection, shared folders, drag and drop,
better multimonitor support etc.). Spice is able to export all the VM
details to a client, including QMP monitor, serial ports etc... It's
thus possible for a Spice client to provide a similar experience as
the current qemu -display gtk UI (while keeping similar performances).

In a related virt-viewer series, "[PATCH 00/22] Add QEMU-like UI: VT
console & basic VM state", I proposed to augment remote-viewer with
VTE consoles and basic QMP support to provide a UI similar to qemu
gtk.

With this series, starting qemu with "-display app" will setup a Spice
server in the background and launch the client application associated
with spice+unix:// uri handling to interact with qemu (the concept
could be extended to other protocols). The resulting user experience
should be very close to what qemu gtk display provides (it should be
possible to make it work on various platforms, although I only
tested/developped on Linux)

Marc-Andr=C3=A9 Lureau (10):
  char/spice: trigger HUP event
  char/spice: discard write() if backend is disconnected
  configure: bump spice-server required version to 0.12.6
  spice: avoid spice runtime assert
  spice: merge options lists
  spice: do not stop spice if VM is paused
  char: move SpiceChardev and open_spice_port() to spice.h header
  char: register spice ports after spice started
  build-sys: add gio-2.0 check
  display: add -display app launching external application

 qapi/ui.json            |   3 +-
 hw/display/qxl.h        |   2 -
 include/chardev/spice.h |  27 ++++++
 include/ui/qemu-spice.h |   9 --
 chardev/spice.c         |  66 +++++++--------
 hw/display/qxl.c        |   8 --
 ui/app.c                | 179 ++++++++++++++++++++++++++++++++++++++++
 ui/spice-core.c         |  19 +++--
 chardev/trace-events    |   1 +
 configure               |  17 +++-
 qemu-options.hx         |   5 ++
 ui/Makefile.objs        |   5 ++
 12 files changed, 274 insertions(+), 67 deletions(-)
 create mode 100644 include/chardev/spice.h
 create mode 100644 ui/app.c

--=20
2.18.0.547.g1d89318c48
