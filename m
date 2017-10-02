Received: from eggs.gnu.org ([2001:4830:134:3::10]:59667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dyxSs-0007YO-Da
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dyxSo-0007Uq-TD
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:56:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dyxSo-0007UR-K4
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:56:38 -0400
Date: Mon, 2 Oct 2017 10:56:27 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171002095627.GD27086@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170929101201.21039-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170929101201.21039-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 0/6] Initial support for keycodemapdb
 GIT submodule
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

FYI, in case people were wondering, patchew successfully passed all
tests. So it looks like 8th time lucky for getting submodules working
correctly unless someone can break it again.....

  http://patchew.org/QEMU/20170929101201.21039-1-berrange@redhat.com/

On Fri, Sep 29, 2017 at 11:11:55AM +0100, Daniel P. Berrange wrote:
> This patch series is an update to:
> 
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02047.html
>   v2: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02471.html
>   v3: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02517.html
>   v4: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02708.html
>   v5: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02950.html
>   v6: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg07673.html
>   v7: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg07740.html
> 
> The keycodemap project[1] provides a database mapping between many different
> keysym/keycode/scancode sets, along with a tool to generate mapping/lookup
> tables in various programming languages. It is already used by GTK-VNC,
> SPICE-GTK and libvirt.
> 
> In this v6 posting I have dropped most of the conversion to keycodemapdb
> across the devices / UI frontends. This only converts the core input
> APIs, and wires up the git submodule build system mechanics. The remaining
> patches from the v5 posting will be submitted separately, once this initial
> conversion is mergable.
> 
> Changed in v8:
> 
>  - Fix error checking in archive-source.sh changes (Eric)
>  - Use -e instead of -d to check for .git (Eric)
>  - Misc typos (Eric)
>  - Use && instead of ; in make shell rules (Eric)
>  - Fully quote $source_path usage (Eric)
>  - Fix position of trap statement for cleanup (Eric)
>  - Added missing dependnacy for Makefile (Patchew)
>  - Moved build rules from ui/Makefile.objs into Makefile because
>    we must not have those rules defined in the target specific
>    Makefiles
> 
> Changed in v7:
> 
>  - subdir-dtc and ui/input-keymap-* make rules must depend on
>    the submodule status file to ensure build ordering (patchew)
>  - Use 'git stash' to ensure archive-source.sh keeps non-committed
>    changes for docker/vm testing (Fam)
> 
> Changed in v6:
> 
>  - Switched back to using a git submodule
>  - Wire up Makefile rules so that git submodule is automatically
>    refreshed when needed prior to build.
>  - Fix source tarball creation for docker/vm tests wrt submodules
> 
> Changed in v5:
> 
>  - Don't try to initialize git submodule at all
>  - Store generate keymap files in GIT
> 
> Changed in v4:
> 
>  - Run submodule update in source_dir for vpath builds (patchew)
>  - Force submodule update in docker rules in case they
>    are run without configure (patchew)
> 
> Changed in v3:
> 
>  - Ensure docker builds pull in keycodemapdb submodule (patchew)
>  - Add compat with py26 for RHEL-6 in keycodemapdb tools (patchew)
>  - Initialize submodule in configure script (patchew)
> 
> Changed in v2:
> 
>  - Change filename pattern to 'ui/input-keymap-$SRC-to-$DST.c'
>    and map names 'qemu_input_map_$SRC_to_$DST'  (Eric)
>  - Fix typos (Eric)
>  - Drop changes to InputKeyEvent struct (Eric)
>  - Fix VPATH build (patchew)
>  - Fix code style errors (patchew)
> 
> [1] https://gitlab.com/keycodemap/keycodemapdb/
> 
> Daniel P. Berrange (6):
>   build: automatically handle GIT submodule checkout for dtc
>   docker: don't rely on submodules existing in the main checkout
>   ui: add keycodemapdb repository as a GIT submodule
>   ui: convert common input code to keycodemapdb
>   ui: convert key events to QKeyCodes immediately
>   ui: don't export qemu_input_event_new_key
> 
>  .gitignore                |   2 +
>  .gitmodules               |   3 +
>  MAINTAINERS               |   6 +
>  Makefile                  |  46 ++++++-
>  configure                 |  52 +++++---
>  include/ui/input.h        |  12 +-
>  scripts/archive-source.sh |  34 ++++-
>  scripts/git-submodule.sh  |  38 ++++++
>  ui/input-keymap.c         | 326 +++-------------------------------------------
>  ui/input.c                |  26 ++--
>  ui/keycodemapdb           |   1 +
>  11 files changed, 198 insertions(+), 348 deletions(-)
>  create mode 100755 scripts/git-submodule.sh
>  create mode 160000 ui/keycodemapdb
> 
> -- 
> 2.13.5
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
