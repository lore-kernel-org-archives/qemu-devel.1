Received: from eggs.gnu.org ([2001:4830:134:3::10]:33518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsSzZ-0003GQ-9N
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 09:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsSzX-0003Mf-T2
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 09:16:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44952 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fsSzW-0003Lf-Hq
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 09:16:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3B89804B9F2
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 13:16:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 22 Aug 2018 14:15:53 +0100
Message-Id: <20180822131554.3398-3-berrange@redhat.com>
In-Reply-To: <20180822131554.3398-1-berrange@redhat.com>
References: <20180822131554.3398-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/3] ui: increase min required GTK3 version
 to 3.14.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <famz@redhat.com>, libvir-list@redhat.com, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Per supported platforms doc[1], the various min GTK3 on relevant distros =
is:

  RHEL-7.0: 3.8.8
  RHEL-7.2: 3.14.13
  RHEL-7.4: 3.22.10
  RHEL-7.5: 3.22.26
  Debian (Stretch): 3.22.11
  Debian (Jessie): 3.14.5
  OpenBSD (Ports): 3.22.30
  FreeBSD (Ports): 3.22.29
  OpenSUSE Leap 15: 3.22.30
  SLE12-SP2: Unknown
  Ubuntu (Xenial): 3.18.9
  macOS (Homebrew): 3.22.30

This suggests that a minimum GTK3 of 3.14.0 is a reasonable target,
as users are unlikely to be stuck on RHEL-7.0/7.1 still

[1] https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 configure |  2 +-
 ui/gtk.c  | 10 ----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/configure b/configure
index f982d8bd61..eca30885d6 100755
--- a/configure
+++ b/configure
@@ -2646,7 +2646,7 @@ fi
 if test "$gtk" !=3D "no"; then
     gtkpackage=3D"gtk+-3.0"
     gtkx11package=3D"gtk+-x11-3.0"
-    gtkversion=3D"3.0.0"
+    gtkversion=3D"3.14.0"
     if $pkg_config --exists "$gtkpackage >=3D $gtkversion"; then
         gtk_cflags=3D$($pkg_config --cflags $gtkpackage)
         gtk_libs=3D$($pkg_config --libs $gtkpackage)
diff --git a/ui/gtk.c b/ui/gtk.c
index 9d09bc9e57..6d57558084 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -998,7 +998,6 @@ static gboolean gd_scroll_event(GtkWidget *widget, Gd=
kEventScroll *scroll,
         btn =3D INPUT_BUTTON_WHEEL_UP;
     } else if (scroll->direction =3D=3D GDK_SCROLL_DOWN) {
         btn =3D INPUT_BUTTON_WHEEL_DOWN;
-#if GTK_CHECK_VERSION(3, 4, 0)
     } else if (scroll->direction =3D=3D GDK_SCROLL_SMOOTH) {
         gdouble delta_x, delta_y;
         if (!gdk_event_get_scroll_deltas((GdkEvent *)scroll,
@@ -1010,7 +1009,6 @@ static gboolean gd_scroll_event(GtkWidget *widget, =
GdkEventScroll *scroll,
         } else {
             btn =3D INPUT_BUTTON_WHEEL_UP;
         }
-#endif
     } else {
         return TRUE;
     }
@@ -1672,11 +1670,9 @@ static GSList *gd_vc_menu_init(GtkDisplayState *s,=
 VirtualConsole *vc,
     gtk_accel_group_connect(s->accel_group, GDK_KEY_1 + idx,
             HOTKEY_MODIFIERS, 0,
             g_cclosure_new_swap(G_CALLBACK(gd_accel_switch_vc), vc, NULL=
));
-#if GTK_CHECK_VERSION(3, 8, 0)
     gtk_accel_label_set_accel(
             GTK_ACCEL_LABEL(gtk_bin_get_child(GTK_BIN(vc->menu_item))),
             GDK_KEY_1 + idx, HOTKEY_MODIFIERS);
-#endif
=20
     g_signal_connect(vc->menu_item, "activate",
                      G_CALLBACK(gd_menu_switch_vc), s);
@@ -2167,11 +2163,9 @@ static GtkWidget *gd_create_menu_view(GtkDisplaySt=
ate *s)
                                    TRUE);
     gtk_accel_group_connect(s->accel_group, GDK_KEY_m, HOTKEY_MODIFIERS,=
 0,
             g_cclosure_new_swap(G_CALLBACK(gd_accel_show_menubar), s, NU=
LL));
-#if GTK_CHECK_VERSION(3, 8, 0)
     gtk_accel_label_set_accel(
             GTK_ACCEL_LABEL(gtk_bin_get_child(GTK_BIN(s->show_menubar_it=
em))),
             GDK_KEY_m, HOTKEY_MODIFIERS);
-#endif
     gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), s->show_menubar_ite=
m);
=20
     return view_menu;
@@ -2221,11 +2215,7 @@ static void gtk_display_init(DisplayState *ds, Dis=
playOptions *opts)
     s->opts =3D opts;
=20
     s->window =3D gtk_window_new(GTK_WINDOW_TOPLEVEL);
-#if GTK_CHECK_VERSION(3, 2, 0)
     s->vbox =3D gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
-#else
-    s->vbox =3D gtk_vbox_new(FALSE, 0);
-#endif
     s->notebook =3D gtk_notebook_new();
     s->menu_bar =3D gtk_menu_bar_new();
=20
--=20
2.17.1
