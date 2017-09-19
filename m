Received: from eggs.gnu.org ([2001:4830:134:3::10]:38607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duH7X-00053f-Ot
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duH7U-00007C-Le
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:55:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1duH7U-00006X-DB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:55:16 -0400
Date: Tue, 19 Sep 2017 12:55:11 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170919115511.GJ9536@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170912141910.GJ17633@redhat.com>
	<CAFEAcA-tdbzXBkyxXW_e15hVcbcfqSfKqke0PX6y-Cg6A62DzQ@mail.gmail.com>
	<20170912143007.GK17633@redhat.com>
	<1505390103.31557.11.camel@redhat.com>
	<CAFEAcA9JEGbiwKeSMyvnLrdE+2WrkRbYLcVJ+UpFnU1RymC1vQ@mail.gmail.com>
	<20170914124059.GD15518@redhat.com>
	<1505747575.4959.1.camel@redhat.com>
	<20170919100839.GH9536@redhat.com>
	<1505818700.12708.3.camel@redhat.com>
	<20170919112055.GI9536@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170919112055.GI9536@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Sep 19, 2017 at 12:20:55PM +0100, Daniel P. Berrange wrote:
> On Tue, Sep 19, 2017 at 12:58:20PM +0200, Gerd Hoffmann wrote:
> >   Hi,
> > 
> > > > So I did the keymaps build with a recursive make call too, which
> > > > doesn't look that pretty ...
> > > 
> > > I don't think that's too ugly, but I wonder if there's some way to
> > > avoid
> > > the recursive make call.
> > > 
> > > It feels like this is a similar scenario to 'config-host.mak' being
> > > outdated. I don't entirely understand the logic yet, but we manage to
> > > automatically re-run configure and rebuild config-host.make, when
> > > configure changes, and that in turn affects which dependancies need
> > > rebuild.
> > 
> > Can't spot anything special in the Makefile.  Maybe make is clever
> > enough to figure that a rule updates a include file and starts over
> > then.
> > 
> > > I wonder if we can somehow integrate into that process, so
> > > that configure is responsible for checking out the git submodules,
> > > then make the re-running of configure trigger when .gitmodules
> > > changes content.
> > 
> > .gitmodules only has the repo links, not the checkout hashes.  So it
> > wouldn't be touched on updates.
> > 
> > I can't see an easy way for make to figure a submodule has changed,
> > other than running "git submodule update".
> 
> So I think I figured out the trick libvirt/gnulib uses for this. It
> runs an external script to check the submodule status. This runs
> 'git submodule' to get a list of expected hashes, and compares this
> to a file .git-submodule-status that it previously created (might be
> missing on fresh checkout). If the expected & stores hashes don't
> match this script runs an error.
> 
> The Makefile checks the output of this script, and if it indicates
> that an submodule update is required, it uses an ifeq() to add a
> dependancy between "Makefile" and a phony target that re-runs
> configure (which in turns updates the submodules). If no update was
> required, then no dependancy from Makefile gets added, so build runs
> normally.

Here is an example of integrating this approach with QEMU that seems
like it should work:

diff --git a/.gitmodules b/.gitmodules
index 84c54cdc49..f3bbc01f82 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -34,3 +34,6 @@
 [submodule "roms/QemuMacDrivers"]
 	path = roms/QemuMacDrivers
 	url = git://git.qemu.org/QemuMacDrivers.git
+[submodule "ui/keycodemapdb"]
+	path = ui/keycodemapdb
+	url = https://gitlab.com/keycodemap/keycodemapdb.git
diff --git a/Makefile b/Makefile
index b53fc69a60..62f17d2db5 100644
--- a/Makefile
+++ b/Makefile
@@ -803,6 +803,25 @@ Makefile: $(GENERATED_FILES)
 endif
 endif
 
+ifeq (0,$(MAKELEVEL))
+  git_module_status := $(shell \
+      cd '$(SRC_PATH)'; \
+      test -d .git || test -f .git || { echo 0; exit; }; \
+      ./scripts/git-submodule-status.sh; \
+      echo $$?; \
+  )
+
+ifeq (1,$(git_module_status))
+Makefile: reconfig
+
+.PHONY: reconfig
+
+reconfig:
+	@echo "GIT submodules out of date, re-running configure"
+	./config.status
+endif
+endif
+
 .SECONDARY: $(TRACE_HEADERS) $(TRACE_HEADERS:%=%-timestamp) \
 	$(TRACE_SOURCES) $(TRACE_SOURCES:%=%-timestamp) \
 	$(TRACE_DTRACE) $(TRACE_DTRACE:%=%-timestamp)
diff --git a/configure b/configure
index 94db2d103e..eb29a95ff9 100755
--- a/configure
+++ b/configure
@@ -3583,6 +3583,15 @@ fi
 libs_softmmu="$libs_softmmu $fdt_libs"
 
 ##########################################
+# initialize keycodemapdb module
+
+if test -d "${source_path}/.git"
+then
+    git submodule update --init ui/keycodemapdb
+    git submodule status ui/keycodemapdb | awk '{print $1 " " $2}' > .git-submodule-status
+fi
+
+##########################################
 # opengl probe (for sdl2, gtk, milkymist-tmu2)
 
 if test "$opengl" != "no" ; then
diff --git a/scripts/git-submodule-status.sh b/scripts/git-submodule-status.sh
new file mode 100755
index 0000000000..1a28118ee6
--- /dev/null
+++ b/scripts/git-submodule-status.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+if ! test -f .git-submodule-status
+then
+   exit 1
+fi
+
+git submodule status ui/keycodemapdb | awk '{print $1 " " $2}' > .git-submodule-status.tmp
+
+diff .git-submodule-status .git-submodule-status.tmp >/dev/null
+
+ret=$?
+
+rm -f .git-submodule-status.tmp
+
+exit $ret
diff --git a/ui/keycodemapdb b/ui/keycodemapdb
new file mode 160000
index 0000000000..56ce5650d2
--- /dev/null
+++ b/ui/keycodemapdb
@@ -0,0 +1 @@
+Subproject commit 56ce5650d2c6ea216b4580df44b9a6dd3bc92c3b
-- 
2.13.5



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
