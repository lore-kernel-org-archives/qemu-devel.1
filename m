Received: from eggs.gnu.org ([2001:4830:134:3::10]:38513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dZdvM-0003F6-VN
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dZdvJ-0005q1-63
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:01:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dZdvI-0005p1-WC
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:01:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C22927EA8E
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:01:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Jul 2017 16:01:14 +0200
Message-Id: <20170724140117.27651-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] Fix qemu keymaps, part one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

qemu carries a bunch of reverse keymaps in pc-bios/keymaps/, to map
keysyms it receives from vnc clients back to keycodes.  These keymaps
seem to be buggy and incomplete at times.  So, to tackle the issue once
for all, I've written a tool to generate those maps from xkb keyboard
layout data using libxkbcommon.

This patch series only adds the tool, it doesn't touch the maps in
pc-bios/keymaps/ yet.  I want some testing feedback first ...

How to test:
  (1) generate a map: "qemu-keymap -f testmap -l $layout"
  (2) use the map: "qemu -vnc $display -k testmap"

Gerd Hoffmann (3):
  keysym: add next and prior
  ui: move qemu_input_linux_to_qcode()
  Add qemu-keymap tool.

 configure          |  23 +++++
 Makefile           |   5 ++
 include/ui/input.h |   1 +
 ui/curses_keys.h   |   2 +
 ui/vnc_keysym.h    |   2 +
 qemu-keymap.c      | 243 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 ui/input-keymap.c  | 115 +++++++++++++++++++++++++
 ui/input-linux.c   | 113 -------------------------
 8 files changed, 391 insertions(+), 113 deletions(-)
 create mode 100644 qemu-keymap.c

-- 
2.9.3
