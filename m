Received: from eggs.gnu.org ([2001:4830:134:3::10]:58508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cw6Ab-0008RD-Gf
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cw6AV-0002R0-K7
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:05:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cw6AV-0002QW-CI
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:05:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40F73BB0D
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 12:05:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  6 Apr 2017 14:05:13 +0200
Message-Id: <20170406120513.638-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170406120513.638-1-marcandre.lureau@redhat.com>
References: <20170406120513.638-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] qxl: switch display on entering VGA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, dgilbert@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Since commit cd958edb1fae85d, same size console resize is skipped. This
change broke QXL incoming migration in VGA mode,
qemu_spice_display_switch() is no longer called during qxl_post_load(),
because default message surface is of the same size, and during
displaychangelistener registration, PCIQXLDevice.mode is
QXL_MODE_UNDEFINED. This triggers a later crash on refresh:

=3D=3D2634=3D=3D Invalid read of size 4
=3D=3D3516=3D=3D at 0x65F3050: pixman_image_get_data (in /usr/lib64/libpi=
xman-1.so.0.34.0)
=3D=3D3516=3D=3D by 0x6F0CEB: qemu_spice_create_update (spice-display.c:2=
15)
=3D=3D3516=3D=3D by 0x6F1CC7: qemu_spice_display_refresh (spice-display.c=
:502)
=3D=3D3516=3D=3D by 0x58CF77: display_refresh (qxl.c:1948)
=3D=3D3516=3D=3D by 0x6E8084: do_safe_dpy_refresh (console.c:1591)
=3D=3D3516=3D=3D by 0x6E80D5: dpy_refresh (console.c:1604)
=3D=3D3516=3D=3D by 0x6E4508: gui_update (console.c:201)
=3D=3D3516=3D=3D by 0x81898E: timerlist_run_timers (qemu-timer.c:536)
=3D=3D3516=3D=3D by 0x8189D6: qemu_clock_run_timers (qemu-timer.c:547)
=3D=3D3516=3D=3D by 0x818D98: qemu_clock_run_all_timers (qemu-timer.c:662=
)
=3D=3D3516=3D=3D by 0x81952A: main_loop_wait (main-loop.c:514)
=3D=3D3516=3D=3D by 0x4ADD29: main_loop (vl.c:1898)

One way to solve this is to explicitely call qemu_spice_display_switch()
on entering VGA mode, which is called during qxl_post_load().

Fixes:
"null pointer access on migration resume of systemrescuecd boot menu with=
 qxl-vga"
https://bugs.launchpad.net/qemu/+bug/1679126
https://bugzilla.redhat.com/show_bug.cgi?id=3D1438566

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/display/qxl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 0d02f0efe6..c31b293bb7 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1146,6 +1146,7 @@ static void qxl_enter_vga_mode(PCIQXLDevice *d)
     update_displaychangelistener(&d->ssd.dcl, GUI_REFRESH_INTERVAL_DEFAU=
LT);
     qemu_spice_create_host_primary(&d->ssd);
     d->mode =3D QXL_MODE_VGA;
+    qemu_spice_display_switch(&d->ssd, d->ssd.ds);
     vga_dirty_log_start(&d->vga);
     graphic_hw_update(d->vga.con);
 }
--=20
2.12.0.191.gc5d8de91d
