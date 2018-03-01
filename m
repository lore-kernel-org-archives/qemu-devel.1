Received: from eggs.gnu.org ([2001:4830:134:3::10]:42626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1erL62-0005FY-K9
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1erL5z-000524-Ia
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:05:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38858 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1erL5z-00051d-Ep
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:05:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18CC0402291E
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 10:05:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  1 Mar 2018 11:05:34 +0100
Message-Id: <20180301100547.18962-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/13] ui: build sdl,
 gtk and curses as modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This patch series adds a registry for user interfaces (aka displays),
adds support for user interface modules and allows to build sdl, gtk
and curses as modules.  Especially gtk cuts down the number of shared
libraries qemu links against by a significant amount.

Note one: Modules are disabled by default, so configure with
          --enable-modules to test this.

Note two: Qemu build system doesn't rebuild object files when
          the compiler flags change.  You might see build failures
	  when enabling modules without "make clean" because of this,
          due to non-modular object files being built without -fPIC.

v2:
 - fix build issue for curses module (unicore32 uses curses directly).
 - fix build issue for sdl module (config symbol clash with sdl audio).

Gerd Hoffmann (13):
  console: add qemu display registry, add gtk
  sdl: switch over to new display registry
  cocoa: switch over to new display registry
  curses: switch over to new display registry
  egl-headless: switch over to new display registry
  console: add and use qemu_display_find_default
  console: add ui module loading support
  configure: add X11 vars to config-host.mak
  configure: opengl doesn't depend on x11
  ui/gtk: build as module
  ui/curses: build as module
  audio: rename CONFIG_* to CONFIG_AUDIO_*
  ui/sdl: build as module

 configure                      | 31 +++++++++--------
 Makefile.objs                  |  1 +
 audio/audio_int.h              |  2 +-
 include/qemu/module.h          |  1 +
 include/ui/console.h           | 75 +++++++-----------------------------------
 ui/console.c                   | 59 +++++++++++++++++++++++++++++++++
 ui/curses.c                    | 14 +++++++-
 ui/egl-headless.c              | 20 ++++++++++-
 ui/gtk.c                       | 17 ++++++++--
 ui/sdl.c                       | 24 +++++++-------
 ui/sdl2.c                      | 17 ++++++++--
 vl.c                           | 74 +++++++----------------------------------
 audio/Makefile.objs            | 12 +++----
 target/unicore32/Makefile.objs |  4 +++
 ui/Makefile.objs               | 31 ++++++++++-------
 ui/cocoa.m                     | 14 +++++++-
 16 files changed, 220 insertions(+), 176 deletions(-)

-- 
2.9.3
