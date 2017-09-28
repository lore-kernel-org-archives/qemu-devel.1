Received: from eggs.gnu.org ([2001:4830:134:3::10]:44454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxXaQ-0000Co-AR
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxXaK-0007iz-73
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:06:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxXaJ-0007iZ-V2
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:06:32 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 28 Sep 2017 13:06:15 +0100
Message-Id: <20170928120621.30288-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v7 0/6] Initial support for keycodemapdb GIT
 submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This patch series is an update to:

  v1: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02047.html
  v2: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02471.html
  v3: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02517.html
  v4: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02708.html
  v5: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02950.html
  v6: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg07673.html

The keycodemap project[1] provides a database mapping between many different
keysym/keycode/scancode sets, along with a tool to generate mapping/lookup
tables in various programming languages. It is already used by GTK-VNC,
SPICE-GTK and libvirt.

In this v6 posting I have dropped most of the conversion to keycodemapdb
across the devices / UI frontends. This only converts the core input
APIs, and wires up the git submodule build system mechanics. The remaining
patches from the v5 posting will be submitted separately, once this initial
conversion is mergable.

Changed in v7:

 - subdir-dtc and ui/input-keymap-* make rules must depend on
   the submodule status file to ensure build ordering (patchew)
 - Use 'git stash' to ensure archive-source.sh keeps non-committed
   changes for docker/vm testing (Fam)

Changed in v6:

 - Switched back to using a git submodule
 - Wire up Makefile rules so that git submodule is automatically
   refreshed when needed prior to build.
 - Fix source tarball creation for docker/vm tests wrt submodules

Changed in v5:

 - Don't try to initialize git submodule at all
 - Store generate keymap files in GIT

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

[1] https://gitlab.com/keycodemap/keycodemapdb/


Daniel P. Berrange (6):
  build: automatically handle GIT submodule checkout for dtc
  docker: don't rely on submodules existing in the main checkout
  ui: add keycodemapdb repository as a GIT submodule
  ui: convert common input code to keycodemapdb
  ui: convert key events to QKeyCodes immediately
  ui: don't export qemu_input_event_new_key

 .gitignore                |   2 +
 .gitmodules               |   3 +
 Makefile                  |  23 +++-
 configure                 |  52 +++++---
 include/ui/input.h        |  12 +-
 scripts/archive-source.sh |  30 ++++-
 scripts/git-submodule.sh  |  31 +++++
 ui/Makefile.objs          |  21 +++
 ui/input-keymap.c         | 326 +++-------------------------------------------
 ui/input.c                |  26 ++--
 ui/keycodemapdb           |   1 +
 11 files changed, 182 insertions(+), 345 deletions(-)
 create mode 100755 scripts/git-submodule.sh
 create mode 160000 ui/keycodemapdb

-- 
2.13.5
