Received: from eggs.gnu.org ([2001:4830:134:3::10]:49701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvB-0000lg-GI
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdv8-0007Ih-Bj
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdv8-0007I7-6V
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:50 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 300AF91FCC
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 10:30:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:30:22 +0100
Message-Id: <20171117103046.15943-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 00/24] RfC: rework display initialization
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

  Hi,

This series reworks the qemu display initialization.  Changes:

  * Create a QAPI DisplayOptions type for display configuration.
  * Switch all display initialization calls to accept DisplayOptions
    instead of a bunch of bools.
  * Add a registry for displays, and remove alot of #ifdefs from vl.c
  * Build sdl, gtk and curses as modules.

For now I'm looking for comments especially on the DisplayOptions QAPI
type.  Is there a more elegant way than the empty DisplayNoOpts struct
(see patch #5)?

cheers,
  Gerd

Gerd Hoffmann (24):
  sdl: remove -no-frame support
  sdl: remove -alt-grab and -ctrl-grab support
  sdl: use ctrl-alt-g as grab hotkey
  vl: rename DisplayType to LegacyDisplayType
  gtk: add and use DisplayOptions + DisplayGTK
  sdl: use DisplayOptions
  vl: drop no_quit variable
  egl-headless: use DisplayOptions
  curses: use DisplayOptions
  cocoa: use DisplayOptions
  vl: drop full_screen variable
  vl: drop display_type variable
  vl: drop request_opengl variable
  console: add qemu display registry, add gtk
  sdl: hook up to display registry
  cocoa: hook up to display registry
  curses: hook up to display registry
  egl-headless: hook up to display registry
  console: add and use qemu_display_find_default
  console: add ui module loading support
  sdl: build as module
  gtk: build as module
  curses: build as module
  build: opengl should not need X11

 configure             |  17 +++--
 Makefile.objs         |   1 +
 include/qemu/module.h |   1 +
 include/ui/console.h  |  77 +++------------------
 ui/console.c          |  59 ++++++++++++++++
 ui/curses.c           |  14 +++-
 ui/egl-headless.c     |  20 +++++-
 ui/gtk.c              |  45 ++++++++----
 ui/sdl.c              |  89 ++++++++++--------------
 ui/sdl2.c             |  92 ++++++++++++-------------
 vl.c                  | 186 +++++++++++++-------------------------------------
 qapi/ui.json          |  49 +++++++++++++
 ui/Makefile.objs      |  26 ++++---
 ui/cocoa.m            |  16 ++++-
 14 files changed, 348 insertions(+), 344 deletions(-)

-- 
2.9.3
