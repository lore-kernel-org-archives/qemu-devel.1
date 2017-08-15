Received: from eggs.gnu.org ([2001:4830:134:3::10]:43934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhYGu-0002Mw-It
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhYGt-0000nT-16
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:36:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhYGs-0000my-Nq
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:36:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8048F19D00A
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 09:36:21 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 15 Aug 2017 10:36:03 +0100
Message-Id: <20170815093615.16453-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

An update of:

  v1: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02047.html
  v2: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02471.html
  v3: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02517.html

The keycodemap project[1] provides a database mapping between
many different keysym/keycode/scancode sets, along with a
tool to generate mapping/lookup tables in various programming
languages. It is already used by GTK-VNC, SPICE-GTK and
libvirt.

This series enables its use in QEMU, thus fixing a great
many bugs/ommissions in the 15+ key mapping tables people
have manually written for QEMU.

The keycodemapdb code is designed to be used as a git
sub-module, it is not an external dependancy you need
installed before use.

This series converts all the front ends and all the input
devices which are using the new InputEvent framework. A
handful of devices still use the legacy kbd handler

  $ git grep -l add_kbd_event_handler hw
  hw/arm/musicpal.c
  hw/arm/nseries.c
  hw/arm/palm.c
  hw/arm/spitz.c
  hw/input/pxa2xx_keypad.c
  hw/input/stellaris_input.c

and could be usefully converted too.

I've not done much realworld testing of this yet. I did
however write code that compared the mapping tables before
and after conversion to identify what mapping changes have
resulted in each frontend/backend.  What I still need to
go back and validate is the Print/Sysrq handling, because
that is special everywhere and I'm not entirely sure I've
done that correctly yet. The GTK frontend should now work
correctly when run on X11 servers on Win32 and OS-X, as
well as when run on native Win32/OS-X display backends.

[1] https://gitlab.com/keycodemap/keycodemapdb/

Changed in v4:

 - Run submodule update in source_dir for vpath builds (patchew)
 - Force submodule update in docker rules in case they
   are run without configure (patchew)

Changed in v3:

 - Ensure docker builds pull in keycodemapdb submodule (patchew)
 - Add compat with py26 for RHEL-6 in keycodemapdb tools (patchew)
 - Initialize submodule in configure script (patchew)

Changed in v2:

 - Change filename pattern to 'ui/input-keymap-$SRC-to-$DST.c'
   and map names 'qemu_input_map_$SRC_to_$DST'  (Eric)
 - Fix typos (Eric)
 - Drop changes to InputKeyEvent struct (Eric)
 - Fix VPATH build (patchew)
 - Fix code style errors (patchew)


Daniel P. Berrange (12):
  ui: add keycodemapdb repository as a GIT submodule
  ui: convert common input code to keycodemapdb
  ui: convert key events to QKeyCodes immediately
  ui: don't export qemu_input_event_new_key
  input: convert virtio-input-hid device to keycodemapdb
  input: convert ps2 device to keycodemapdb
  input: convert the adb device to keycodemapdb
  char: convert the escc device to keycodemapdb
  ui: convert cocoa frontend to keycodemapdb
  ui: convert the SDL2 frontend to keycodemapdb
  ui: convert GTK and SDL1 frontends to keycodemapdb
  display: convert XenInput keyboard to keycodemapdb

 .gitignore                    |   2 +
 .gitmodules                   |   3 +
 configure                     |   2 +
 hw/char/escc.c                | 126 +------------
 hw/display/xenfb.c            | 133 ++++----------
 hw/input/adb.c                | 124 +------------
 hw/input/ps2.c                | 406 +-----------------------------------------
 hw/input/virtio-input-hid.c   | 136 +-------------
 include/hw/input/adb-keys.h   | 141 ---------------
 include/ui/input.h            |  57 +++++-
 tests/docker/Makefile.include |  11 +-
 tests/docker/run              |   4 +-
 ui/Makefile.objs              |  41 ++++-
 ui/cocoa.m                    | 129 +-------------
 ui/gtk.c                      | 205 ++++++++++++---------
 ui/input-keymap.c             | 341 ++++-------------------------------
 ui/input.c                    |   8 +-
 ui/keycodemapdb               |   1 +
 ui/sdl.c                      | 105 ++++-------
 ui/sdl2-input.c               |  16 +-
 ui/sdl2-keymap.h              | 267 ---------------------------
 ui/trace-events               |   9 +-
 ui/x_keymap.c                 | 250 ++++++++++----------------
 ui/x_keymap.h                 |   8 +-
 24 files changed, 473 insertions(+), 2052 deletions(-)
 delete mode 100644 include/hw/input/adb-keys.h
 create mode 160000 ui/keycodemapdb
 delete mode 100644 ui/sdl2-keymap.h

-- 
2.13.3
