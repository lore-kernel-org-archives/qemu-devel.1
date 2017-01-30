Received: from eggs.gnu.org ([2001:4830:134:3::10]:37798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCBe-0003SQ-2K
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCBa-0006NG-Ub
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:40:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYCBa-0006My-LQ
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:39:58 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AFB0780475
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 13:39:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Jan 2017 17:39:13 +0400
Message-Id: <20170130133954.31353-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/41] chardev: qom clean-up and split in
 various backend files
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

Finish qom-ification by using instance finalizers and split the big
qemu-char.c file in many backend-specific units.

This is part of a larger refactoring series that I try to keep up to date=
 here:
https://github.com/elmarco/qemu/commits/chrfe

v2: (after Eric's review)
- replace win32 BOOL with bool
- use a chardev_name_foreach() helper to avoid unnecessary list creation
- back copyright blurbs to new files
- fix osdep.h inclusion in header
- long lines split, fixed some code churn
- add a-b/r-b tags
- propose myself as qemu-char maintainer

Marc-Andr=C3=A9 Lureau (41):
  MAINTAINERS: add myself to qemu-char.c
  spice-qemu-char: convert to finalize
  baum: convert to finalize
  msmouse: convert to finalize
  mux: convert to finalize
  char-udp: convert to finalize
  char-socket: convert to finalize
  char-pty: convert to finalize
  char-ringbuf: convert to finalize
  char-parallel: convert parallel to finalize
  char-stdio: convert to finalize
  char-win-stdio: convert to finalize
  char-win: do not override chr_free
  char-win: convert to finalize
  char-fd: convert to finalize
  char: remove chr_free
  char: get rid of CharDriver
  char: rename remaining CharDriver to Chardev
  char: remove class kind field
  char: move to chardev/
  char: create chardev-obj-y
  char: make null_chr_write() the default method
  char: move null chardev to its own file
  char: move mux to its own file
  char: move ringbuf/memory to its own file
  char: rename and move to header CHR_READ_BUF_LEN
  char: remove unused READ_RETRIES
  char: move QIOChannel-related stuff to char-io.h
  char: move fd chardev in its own file
  char: move win chardev base class in its own file
  char: move win-stdio into its own file
  char: move socket chardev to its own file
  char: move udp chardev in its own file
  char: move file chardev in its own file
  char: move stdio in its own file
  char: move console in its own file
  char: move pipe chardev in its own file
  char: move pty chardev in its own file
  char: move serial chardev to its own file
  char: move parallel chardev in its own file
  char: headers clean-up

 chardev/char-fd.h        |   44 +
 chardev/char-io.h        |   46 +
 chardev/char-mux.h       |   63 +
 chardev/char-parallel.h  |   32 +
 chardev/char-serial.h    |   35 +
 chardev/char-win-stdio.h |   29 +
 chardev/char-win.h       |   53 +
 include/sysemu/char.h    |   69 +-
 backends/baum.c          |   11 +-
 backends/msmouse.c       |   11 +-
 backends/testdev.c       |    5 -
 chardev/char-console.c   |   53 +
 chardev/char-fd.c        |  170 ++
 chardev/char-file.c      |  139 ++
 chardev/char-io.c        |  192 ++
 chardev/char-mux.c       |  358 ++++
 chardev/char-null.c      |   54 +
 chardev/char-parallel.c  |  316 +++
 chardev/char-pipe.c      |  191 ++
 chardev/char-pty.c       |  300 +++
 chardev/char-ringbuf.c   |  249 +++
 chardev/char-serial.c    |  318 +++
 chardev/char-socket.c    | 1017 +++++++++
 chardev/char-stdio.c     |  164 ++
 chardev/char-udp.c       |  233 +++
 chardev/char-win-stdio.c |  266 +++
 chardev/char-win.c       |  265 +++
 chardev/char.c           | 1334 ++++++++++++
 hmp.c                    |    1 +
 monitor.c                |    1 +
 qemu-char.c              | 5171 ----------------------------------------=
------
 qmp.c                    |    1 +
 spice-qemu-char.c        |   21 +-
 tests/vhost-user-test.c  |    1 +
 ui/console.c             |   10 +-
 ui/gtk.c                 |    9 +-
 MAINTAINERS              |    3 +-
 Makefile                 |    4 +-
 Makefile.objs            |    5 +-
 Makefile.target          |    3 +
 chardev/Makefile.objs    |   17 +
 tests/Makefile.include   |    9 +-
 42 files changed, 5999 insertions(+), 5274 deletions(-)
 create mode 100644 chardev/char-fd.h
 create mode 100644 chardev/char-io.h
 create mode 100644 chardev/char-mux.h
 create mode 100644 chardev/char-parallel.h
 create mode 100644 chardev/char-serial.h
 create mode 100644 chardev/char-win-stdio.h
 create mode 100644 chardev/char-win.h
 create mode 100644 chardev/char-console.c
 create mode 100644 chardev/char-fd.c
 create mode 100644 chardev/char-file.c
 create mode 100644 chardev/char-io.c
 create mode 100644 chardev/char-mux.c
 create mode 100644 chardev/char-null.c
 create mode 100644 chardev/char-parallel.c
 create mode 100644 chardev/char-pipe.c
 create mode 100644 chardev/char-pty.c
 create mode 100644 chardev/char-ringbuf.c
 create mode 100644 chardev/char-serial.c
 create mode 100644 chardev/char-socket.c
 create mode 100644 chardev/char-stdio.c
 create mode 100644 chardev/char-udp.c
 create mode 100644 chardev/char-win-stdio.c
 create mode 100644 chardev/char-win.c
 create mode 100644 chardev/char.c
 delete mode 100644 qemu-char.c
 create mode 100644 chardev/Makefile.objs

--=20
2.11.0.295.gd7dffce1c.dirty
