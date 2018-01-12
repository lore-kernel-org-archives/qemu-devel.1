Received: from eggs.gnu.org ([2001:4830:134:3::10]:40997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ea0hd-0003lV-Mb
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ea0hc-0005fS-9k
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ea0hc-0005eg-4c
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:04 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 266DE5D685
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 14:53:03 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Jan 2018 15:52:51 +0100
Message-Id: <20180112145258.10578-3-kraxel@redhat.com>
In-Reply-To: <20180112145258.10578-1-kraxel@redhat.com>
References: <20180112145258.10578-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/9] ui: deprecate use of GTK 2.x in favour of
 3.x series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The GTK 3.0 release was made in Feb, 2011:

  https://blog.gtk.org/2011/02/10/gtk-3-0-released/

That will soon be 7 years ago, which is enough time to consider
the 3.x series widely supported.

Thus we deprecate the GTK 2.x support, which will allow us to
delete it in the last release of 2018. By this time, GTK 3.x
will be almost 8 years old.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20171212113440.16483-1-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure     | 6 ++++++
 ui/gtk.c      | 5 +++++
 qemu-doc.texi | 9 +++++++++
 3 files changed, 20 insertions(+)

diff --git a/configure b/configure
index 89bd662a6a..b272a0336b 100755
--- a/configure
+++ b/configure
@@ -5629,6 +5629,12 @@ if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
 fi
 
+if test "$gtkabi" = "2.0"; then
+    echo
+    echo "WARNING: Use of GTK 2.0 is deprecated and will be removed in"
+    echo "WARNING: future releases. Please switch to using GTK 3.0"
+fi
+
 if test "$supported_cpu" = "no"; then
     echo
     echo "WARNING: SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RELEASES!"
diff --git a/ui/gtk.c b/ui/gtk.c
index 342e96fbe9..f3b7567984 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2248,6 +2248,11 @@ void gtk_display_init(DisplayState *ds, bool full_screen, bool grab_on_hover)
         exit(1);
     }
 
+#if !GTK_CHECK_VERSION(3, 0, 0)
+    g_printerr("Running QEMU with GTK 2.x is deprecated, and will be removed\n"
+               "in a future release. Please switch to GTK 3.x instead\n");
+#endif
+
     s->window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
 #if GTK_CHECK_VERSION(3, 2, 0)
     s->vbox = gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
diff --git a/qemu-doc.texi b/qemu-doc.texi
index a3d2054c90..3e9eb819a6 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2587,6 +2587,15 @@ they were first deprecated in the 2.10.0 release.
 What follows is a list of all features currently marked as
 deprecated.
 
+@section Build options
+
+@subsection GTK 2.x
+
+Previously QEMU has supported building against both GTK 2.x
+and 3.x series APIs. Support for the GTK 2.x builds will be
+discontinued, so maintainers should switch to using GTK 3.x,
+which is the default.
+
 @section System emulator command line arguments
 
 @subsection -tdf (since 1.3.0)
-- 
2.9.3
