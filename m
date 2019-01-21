Received: from eggs.gnu.org ([209.51.188.92]:55541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glaJ1-0008EP-Un
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glaJ0-0000jw-UV
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:12:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glaJ0-0000jX-KZ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:12:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF4A587649
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 14:12:01 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 21 Jan 2019 15:11:48 +0100
Message-Id: <20190121141152.948-3-kraxel@redhat.com>
In-Reply-To: <20190121141152.948-1-kraxel@redhat.com>
References: <20190121141152.948-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/5] ui: fix icon display for GTK frontend under
 GNOME Shell with Wayland
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The icon associated with a GtkWindow is just a hint to window managers
and not all of them will honour it. Some will instead want to show the
icon listed by the .desktop file. The desktop file is located based on
the application ID, which is set using g_set_prgname. QEMU has not
historically provided a desktop file or set its app ID, so it got a
broken icon in GNOME shell, which is now fixed.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20190110120047.25369-3-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure       | 2 ++
 Makefile        | 3 +++
 ui/gtk.c        | 1 +
 ui/qemu.desktop | 8 ++++++++
 4 files changed, 14 insertions(+)
 create mode 100644 ui/qemu.desktop

diff --git a/configure b/configure
index ce54cd2bdc..7f1426ed0c 100755
--- a/configure
+++ b/configure
@@ -5746,6 +5746,7 @@ qemu_moddir=3D$libdir$confsuffix
 qemu_datadir=3D$datadir$confsuffix
 qemu_localedir=3D"$datadir/locale"
 qemu_icondir=3D"$datadir/icons"
+qemu_desktopdir=3D"$datadir/applications"
=20
 # We can only support ivshmem if we have eventfd
 if [ "$eventfd" =3D "yes" ]; then
@@ -6212,6 +6213,7 @@ fi
 echo "qemu_helperdir=3D$libexecdir" >> $config_host_mak
 echo "qemu_localedir=3D$qemu_localedir" >> $config_host_mak
 echo "qemu_icondir=3D$qemu_icondir" >> $config_host_mak
+echo "qemu_desktopdir=3D$qemu_desktopdir" >> $config_host_mak
 echo "libs_softmmu=3D$libs_softmmu" >> $config_host_mak
 echo "GIT=3D$git" >> $config_host_mak
 echo "GIT_SUBMODULES=3D$git_submodules" >> $config_host_mak
diff --git a/Makefile b/Makefile
index e4218d1192..e944f77eae 100644
--- a/Makefile
+++ b/Makefile
@@ -752,6 +752,9 @@ endif
 	mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/scalable/apps"; \
 	$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu.svg \
 		"$(DESTDIR)/$(qemu_icondir)/hicolor/scalable/apps/qemu.svg"
+	mkdir -p "$(DESTDIR)/$(qemu_desktopdir)"
+	$(INSTALL_DATA) $(SRC_PATH)/ui/qemu.desktop \
+		"$(DESTDIR)/$(qemu_desktopdir)/qemu.desktop"
 ifdef CONFIG_GTK
 	$(MAKE) -C po $@
 endif
diff --git a/ui/gtk.c b/ui/gtk.c
index ec63befa16..87c0e33d2a 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2226,6 +2226,7 @@ static void gtk_display_init(DisplayState *ds, Disp=
layOptions *opts)
=20
     theme =3D gtk_icon_theme_get_default();
     gtk_icon_theme_prepend_search_path(theme, CONFIG_QEMU_ICONDIR);
+    g_set_prgname("qemu");
=20
     s->window =3D gtk_window_new(GTK_WINDOW_TOPLEVEL);
     s->vbox =3D gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
diff --git a/ui/qemu.desktop b/ui/qemu.desktop
new file mode 100644
index 0000000000..20f09f56be
--- /dev/null
+++ b/ui/qemu.desktop
@@ -0,0 +1,8 @@
+[Desktop Entry]
+Version=3D1.0
+Name=3DQEMU
+Icon=3Dqemu
+Type=3DApplication
+Terminal=3Dfalse
+Keywords=3DEmulators;Virtualization;KVM;
+NoDisplay=3Dtrue
--=20
2.9.3
