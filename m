Received: from eggs.gnu.org ([2001:4830:134:3::10]:42737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEumi-0001qV-3o
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEumc-0007dZ-B6
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1gEuma-0007W1-Ki
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id w5-v6so1273741wrt.2
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 04:23:26 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue, 23 Oct 2018 13:23:09 +0200
Message-Id: <cover.1540293795.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 00/14] qga: report serial number and disk
 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Sameeh Jubran <sjubran@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Note that PCI controller reporting on Windows was and still is broken.
Unfortunately I don't know how to fix it at the momemnt. See commit message and
code comment. If anyone has environment where the original code works let me
know. CCing author of the code In case I missed something obvious.

v5:
  - return -1 in PCI info
    I have cherry-picked three commits from Sameeh Jubran and Michael Roth:
    https://github.com/mdroth/qemu/commit/89f145d7e90d721dbc7c9d0082e564bad7e88247
    https://github.com/mdroth/qemu/commit/d5f5f7e7dc265a9e62e5f4c2ee342ab7e56cca53
    https://github.com/mdroth/qemu/commit/201db36b56d7d1ba5ff720eedcb3b62b75306fde
  - remove == TRUE from if-conditions
  - separate Linux and Windows changes so that the Linux part can be pushed
    independently; the relevant commits are ordered first.
  - fixed several typos

v4:
  - split changes into more patches
  - fixed UNC for physical drive to use device namespace
  - renamed g_debug_err() to debug_error()
  - fixed build without libudev

v3:
  - fix typos
  - add configure test for libudev
  - change order of patches fixing PCI controller info and build fix to avoid
    exposing broken code
  - split reporting of serial number and device node into two separate patches

v2:
  - fix checkpatch error

Michael Roth (1):
  *additonal fixup for NULL pci_controller field

Sameeh Jubran (2):
  qga-win: prevent crash when executing fsinfo command
  qga-win: fsinfo: pci-info: allow partial info

Tomáš Golembiovský (11):
  configure: add test for libudev
  qga: linux: report disk serial number
  qga: linux: return disk device in guest-get-fsinfo
  build: rename CONFIG_QGA_NTDDDISK to CONFIG_QGA_NTDDSCSI
  qga-win: add debugging information
  qga-win: refactor disk properties (bus)
  qga-win: report disk serial number
  qga-win: refactor disk info
  qga-win: handle multi-disk volumes
  qga-win: return disk device in guest-get-fsinfo
  qga-win: demystify namespace stripping

 configure            |  24 +++-
 dtc                  |   2 +-
 qga/Makefile.objs    |   1 +
 qga/commands-posix.c |  37 +++++-
 qga/commands-win32.c | 269 +++++++++++++++++++++++++++++++++++--------
 qga/qapi-schema.json |   5 +-
 6 files changed, 287 insertions(+), 51 deletions(-)

-- 
2.19.0
