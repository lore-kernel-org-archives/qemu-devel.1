Received: from eggs.gnu.org ([2001:4830:134:3::10]:41593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpoC-0003kL-Qs
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpo9-0005hp-7O
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:55:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dfpo8-0005gX-Se
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:55:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CBE576B5D
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 15:55:35 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 10 Aug 2017 16:55:07 +0100
Message-Id: <20170810155522.31099-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 00/15] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

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

Daniel P. Berrange (15):
  ui: add keycodemapdb repository as a GIT submodule
  ui: convert common input code to keycodemapdb
  ui: convert key events to QKeyCodes immediately
  ui: don't export qemu_input_event_new_key
  ui: use QKeyCode exclusively in InputKeyEvent
  input: convert virtio-input-hid device to keycodemapdb
  input: convert ps2 device to keycodemapdb
  input: convert the adb device to keycodemapdb
  char: convert the escc device to keycodemapdb
  ui: convert cocoa frontend to keycodemapdb
  ui: convert the SDL2 frontend to keycodemapdb
  ui: convert GTK and SDL1 frontends to keycodemapdb
  ui: remove qemu_input_qcode_to_number method
  ui: remove qemu_input_linux_to_qcode method
  display: convert XenInput keyboard to keycodemapdb

 .gitignore                  |   2 +
 .gitmodules                 |   3 +
 hw/char/escc.c              | 128 +-------------
 hw/display/xenfb.c          | 131 +++-----------
 hw/input/adb.c              | 126 +-------------
 hw/input/hid.c              |   6 +-
 hw/input/ps2.c              | 408 +-------------------------------------------
 hw/input/virtio-input-hid.c | 138 ++-------------
 include/hw/input/adb-keys.h | 141 ---------------
 include/ui/input.h          |  64 ++++++-
 qapi-schema.json            |   2 +-
 replay/replay-input.c       |  36 +---
 ui/Makefile.objs            |  41 ++++-
 ui/cocoa.m                  | 129 +-------------
 ui/gtk.c                    | 205 +++++++++++++---------
 ui/input-keymap.c           | 369 ++++-----------------------------------
 ui/input-legacy.c           |  31 ++--
 ui/input-linux.c            |   4 +-
 ui/input.c                  |  49 ++----
 ui/keycodemapdb             |   1 +
 ui/sdl.c                    | 103 ++++-------
 ui/sdl2-input.c             |  14 +-
 ui/sdl2-keymap.h            | 267 -----------------------------
 ui/trace-events             |  10 +-
 ui/x_keymap.c               | 247 ++++++++++-----------------
 ui/x_keymap.h               |   8 +-
 26 files changed, 495 insertions(+), 2168 deletions(-)
 delete mode 100644 include/hw/input/adb-keys.h
 create mode 160000 ui/keycodemapdb
 delete mode 100644 ui/sdl2-keymap.h

-- 
2.13.3
