Received: from eggs.gnu.org ([209.51.188.92]:38888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpa9c-0008MN-7N
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpa9a-0004AG-Ta
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:52 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:36877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpa9a-00049b-LT
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:50 -0500
Received: by mail-wr1-x435.google.com with SMTP id s12so7396945wrt.4
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 06:50:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 14:50:32 +0000
Message-Id: <20190201145035.22739-9-peter.maydell@linaro.org>
In-Reply-To: <20190201145035.22739-1-peter.maydell@linaro.org>
References: <20190201145035.22739-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 08/11] Separate conf.py for each manual we want
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

---
 docs/conf.py           | 37 +++++++++++++++++++++++++++++++------
 docs/devel/conf.py     | 15 +++++++++++++++
 docs/devel/index.rst   | 21 +++++++++++++++++++++
 docs/index.rst         |  9 ++-------
 docs/interop/conf.py   | 15 +++++++++++++++
 docs/interop/index.rst | 18 ++++++++++++++++++
 6 files changed, 102 insertions(+), 13 deletions(-)
 create mode 100644 docs/devel/conf.py
 create mode 100644 docs/devel/index.rst
 create mode 100644 docs/interop/conf.py
 create mode 100644 docs/interop/index.rst

diff --git a/docs/conf.py b/docs/conf.py
index c04000e78e4..6a334f545ec 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -3,6 +3,20 @@
 # QEMU documentation build configuration file, created by
 # sphinx-quickstart on Thu Jan 31 16:40:14 2019.
 #
+# This config file can be used in one of two ways:
+# (1) as a common config file which is included by the conf.py
+# for each of QEMU's manuals: in this case sphinx-build is run multiple
+# times, once per subdirectory.
+# (2) as a top level conf file which will result in building all
+# the manuals into a single document: in this case sphinx-build is
+# run once, on the top-level docs directory.
+#
+# QEMU's makefiles take option (1), which allows us to install
+# only the ones the user cares about (in particular we don't want
+# to ship the 'devel' manual to end-users).
+# Third-party sites such as readthedocs.org will take option (2).
+#
+#
 # This file is execfile()d with the current directory set to its
 # containing dir.
 #
@@ -12,13 +26,22 @@
 # All configuration values have a default; values that are commented out
 # serve to show the default.
 
+import os
+import sys
+
+# The per-manual conf.py will set qemu_docdir for a single-manual build;
+# otherwise set it here if this is an entire-manual-set build.
+# This is always the absolute path of the docs/ directory in the source tree.
+try:
+    qemu_docdir
+except NameError:
+    qemu_docdir = os.path.abspath(".")
+
 # If extensions (or modules to document with autodoc) are in another directory,
 # add these directories to sys.path here. If the directory is relative to the
-# documentation root, use os.path.abspath to make it absolute, like shown here.
+# documentation root, use an absolute path starting from qemu_docdir.
 #
-# import os
-# import sys
-# sys.path.insert(0, os.path.abspath('.'))
+# sys.path.insert(0, os.path.join(qemu_docdir, "my_subdir"))
 
 
 # -- General configuration ------------------------------------------------
@@ -90,8 +113,10 @@ html_theme = 'alabaster'
 # Theme options are theme-specific and customize the look and feel of a theme
 # further.  For a list of options available for each theme, see the
 # documentation.
-#
-# html_theme_options = {}
+# We initialize this to empty here, so the per-manual conf.py can just
+# add individual key/value entries.
+html_theme_options = {
+}
 
 # Add any paths that contain custom static files (such as style sheets) here,
 # relative to this directory. They are copied after the builtin static files,
diff --git a/docs/devel/conf.py b/docs/devel/conf.py
new file mode 100644
index 00000000000..7441f87e7f5
--- /dev/null
+++ b/docs/devel/conf.py
@@ -0,0 +1,15 @@
+# -*- coding: utf-8 -*-
+#
+# QEMU documentation build configuration file for the 'devel' manual.
+#
+# This includes the top level conf file and then makes any necessary tweaks.
+import sys
+import os
+
+qemu_docdir = os.path.abspath("..")
+parent_config = os.path.join(qemu_docdir, "conf.py")
+exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
+
+# This slightly misuses the 'description', but is the best way to get
+# the manual title to appear in the sidebar.
+html_theme_options['description'] = u'Developer''s Guide'
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
new file mode 100644
index 00000000000..cd0fa6c9ba2
--- /dev/null
+++ b/docs/devel/index.rst
@@ -0,0 +1,21 @@
+.. This is the top level page for the 'devel' manual.
+
+
+QEMU Developer's Guide
+======================
+
+This manual documents various parts of the internals of QEMU.
+You only need to read it if you are interested in reading or
+modifying QEMU's source code.
+
+Contents:
+
+.. toctree::
+   :maxdepth: 2
+
+   loads-stores
+   memory
+   migration
+   stable-process
+   testing
+
diff --git a/docs/index.rst b/docs/index.rst
index 93f82228310..3690955dd1f 100644
--- a/docs/index.rst
+++ b/docs/index.rst
@@ -10,11 +10,6 @@ Welcome to QEMU's documentation!
    :maxdepth: 2
    :caption: Contents:
 
+   interop/index
+   devel/index
 
-
-Indices and tables
-==================
-
-* :ref:`genindex`
-* :ref:`modindex`
-* :ref:`search`
diff --git a/docs/interop/conf.py b/docs/interop/conf.py
new file mode 100644
index 00000000000..cf3c69d4a7e
--- /dev/null
+++ b/docs/interop/conf.py
@@ -0,0 +1,15 @@
+# -*- coding: utf-8 -*-
+#
+# QEMU documentation build configuration file for the 'interop' manual.
+#
+# This includes the top level conf file and then makes any necessary tweaks.
+import sys
+import os
+
+qemu_docdir = os.path.abspath("..")
+parent_config = os.path.join(qemu_docdir, "conf.py")
+exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
+
+# This slightly misuses the 'description', but is the best way to get
+# the manual title to appear in the sidebar.
+html_theme_options['description'] = u'System Emulation Management and Interoperability Guide'
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
new file mode 100644
index 00000000000..2df977dd529
--- /dev/null
+++ b/docs/interop/index.rst
@@ -0,0 +1,18 @@
+.. This is the top level page for the 'interop' manual.
+
+
+QEMU System Emulation Management and Interoperability Guide
+===========================================================
+
+This manual contains documents and specifications that are useful
+for making QEMU interoperate with other software.
+
+Contents:
+
+.. toctree::
+   :maxdepth: 2
+
+   bitmaps
+   live-block-operations
+   pr-helper
+
-- 
2.20.1
