Received: from eggs.gnu.org ([2001:4830:134:3::10]:52466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1duJTn-0005DG-Ed
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1duJTk-0003rW-OE
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:26:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1duJTk-0003r3-Fz
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:26:24 -0400
Message-ID: <1505831182.12708.10.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 19 Sep 2017 16:26:22 +0200
In-Reply-To: <20170919115511.GJ9536@redhat.com>
References: <20170912141910.GJ17633@redhat.com>
	<CAFEAcA-tdbzXBkyxXW_e15hVcbcfqSfKqke0PX6y-Cg6A62DzQ@mail.gmail.com>
	<20170912143007.GK17633@redhat.com>
	<1505390103.31557.11.camel@redhat.com>
	<CAFEAcA9JEGbiwKeSMyvnLrdE+2WrkRbYLcVJ+UpFnU1RymC1vQ@mail.gmail.com>
	<20170914124059.GD15518@redhat.com>
	<1505747575.4959.1.camel@redhat.com>
	<20170919100839.GH9536@redhat.com>
	<1505818700.12708.3.camel@redhat.com>
	<20170919112055.GI9536@redhat.com> <20170919115511.GJ9536@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> > The Makefile checks the output of this script, and if it indicates
> > that an submodule update is required, it uses an ifeq() to add a
> > dependancy between "Makefile" and a phony target that re-runs
> > configure (which in turns updates the submodules). If no update was
> > required, then no dependancy from Makefile gets added, so build
> > runs
> > normally.

Neat trick.  I think re-running configure should not be needed though.=20
Touching the Makefile should be enough to make make re-evaluating
things after updating submodules ...

cheers,
  Gerd

diff --git a/Makefile b/Makefile
index b53fc69a60..a9a0cea6d9 100644
--- a/Makefile
+++ b/Makefile
@@ -31,6 +31,27 @@ CONFIG_ALL=3Dy
=C2=A0-include config-all-devices.mak
=C2=A0-include config-all-disas.mak
=C2=A0
+ifeq (0,$(MAKELEVEL))
+=C2=A0=C2=A0git_module_status :=3D $(shell \
+=C2=A0=C2=A0=C2=A0=C2=A0cd '$(SRC_PATH)'; \
+=C2=A0=C2=A0=C2=A0=C2=A0test -d .git || { echo 0; exit; }; \
+=C2=A0=C2=A0=C2=A0=C2=A0./scripts/git-submodule.sh status; \
+=C2=A0=C2=A0=C2=A0=C2=A0echo $$?; \
+=C2=A0=C2=A0)
+
+ifeq (1,$(git_module_status))
+Makefile: git-submodule-update
+
+.PHONY: git-submodule-update
+
+git-submodule-update:
+	@echo "GIT submodules out of date, updating."
+	(cd $(SRC_PATH); ./scripts/git-submodule.sh update)
+	@touch Makefile
+endif
+endif
+
+
=C2=A0config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios
=C2=A0	@echo $@ is out-of-date, running configure
=C2=A0	@# TODO: The next lines include code which supports a smooth
diff --git a/.gitignore b/.gitignore
index cf65316863..0c5fda2fdb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -111,6 +111,7 @@
=C2=A0/docs/version.texi
=C2=A0*.tps
=C2=A0.stgit-*
+.git-submodule-status
=C2=A0cscope.*
=C2=A0tags
=C2=A0TAGS
diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
new file mode 100755
index 0000000000..07d36c2b82
--- /dev/null
+++ b/scripts/git-submodule.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+
+# config
+modules=3D"dtc"
+substat=3D".git-submodule-status"
+
+# drop modules not checked out
+modules=3D"$(git submodule status $modules | awk '/^[^-]/ { print $2
}')"
+
+case "$1" in
+status)
+	test -f "$substat" || exit 1
+	git submodule status $modules > "${substat}.tmp"
+	trap "rm -f ${substat}.tmp" EXIT
+	diff "${substat}" "${substat}.tmp" >/dev/null
+	exit $?
+	;;
+update)
+	git submodule update $modules
+	git submodule status $modules > "${substat}"
+	;;
+esac
