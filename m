Received: from eggs.gnu.org ([2001:4830:134:3::10]:57709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoUFS-0003Fz-0U
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoUFO-0007UH-Sk
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:15:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55777 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoUFO-0007Sv-Ky
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:15:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 595A5407A9AA
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 13:15:42 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Feb 2018 14:15:25 +0100
Message-Id: <20180221131537.31341-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 00/12] ui: build sdl, gtk and curses as modules
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

Gerd Hoffmann (12):
  console: add qemu display registry, add gtk
  sdl: switch over to new display registry
  cocoa: switch over to new display registry
  curses: switch over to new display registry
  egl-headless: switch over to new display registry
  console: add and use qemu_display_find_default
  console: add ui module loading support
  configure: add X11 vars to config-host.mak
  configure: opengl doesn't depend on x11
  sdl: build as ui module
  gtk: build as ui module
  curses: build as ui module

 configure             | 29 +++++++++++---------
 Makefile.objs         |  1 +
 include/qemu/module.h |  1 +
 include/ui/console.h  | 75 ++++++++-------------------------------------------
 ui/console.c          | 59 ++++++++++++++++++++++++++++++++++++++++
 ui/curses.c           | 14 +++++++++-
 ui/egl-headless.c     | 20 +++++++++++++-
 ui/gtk.c              | 17 ++++++++++--
 ui/sdl.c              | 24 +++++++++--------
 ui/sdl2.c             | 17 ++++++++++--
 vl.c                  | 74 ++++++++------------------------------------------
 ui/Makefile.objs      | 31 +++++++++++++--------
 ui/cocoa.m            | 14 +++++++++-
 13 files changed, 208 insertions(+), 168 deletions(-)

-- 
2.9.3
