Received: from eggs.gnu.org ([209.51.188.92]:47798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2G0Z-0004Pe-Cm
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2G0Y-0002sZ-Jc
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:57:55 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2G0Y-0002bF-CO
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:57:54 -0500
Received: by mail-wr1-x441.google.com with SMTP id o17so21480640wrw.3
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 05:57:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Mar 2019 13:57:44 +0000
Message-Id: <20190308135744.6480-4-peter.maydell@linaro.org>
In-Reply-To: <20190308135744.6480-1-peter.maydell@linaro.org>
References: <20190308135744.6480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/3] Makefile: Don't install non-sphinx files
 in sphinx docs install
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

If we're doing an out-of-tree build of Sphinx, then we
copy some extra spurious files to the install directory
as part of 'make install':
qemu-ga-qapi.texi
qemu-ga-ref.7
qemu-ga-ref.7.pod
qemu-ga-ref.html
qemu-ga-ref.txt
qemu-qmp-qapi.texi
qemu-qmp-ref.7
qemu-qmp-ref.7.pod
qemu-qmp-ref.html
qemu-qmp-ref.txt

because these have been built into build/docs/interop along
with the Sphinx interop documents. Filter them out of the
set of files we install when we're installing the Sphinx-built
manual files. (They are installed into their correct locations
as part of the main install-doc target already.)

Fixes: 5f71eac06e15b9a3fa1134d446f ("Makefile, configure: Support building rST documentation")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9fd7f3f9bfb..6ccb8639b08 100644
--- a/Makefile
+++ b/Makefile
@@ -727,9 +727,11 @@ else
 BLOBS=
 endif
 
+# Note that we manually filter-out the non-Sphinx documentation which
+# is currently built into the docs/interop directory in the build tree.
 define install-manual =
 for d in $$(cd $(MANUAL_BUILDDIR) && find $1 -type d); do $(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/$$d"; done
-for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
+for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f -a '!' '(' -name 'qemu-*-qapi.*' -o -name 'qemu-*-ref.*' ')' ); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
 endef
 
 # Note that we deliberately do not install the "devel" manual: it is
-- 
2.20.1
