Received: from eggs.gnu.org ([2001:4830:134:3::10]:38171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEZPo-0002PD-OD
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEZPm-0003Bo-AP
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gEZPl-0002wZ-R1
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CFCD89E3
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 12:34:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-34.ams2.redhat.com
	[10.36.117.34])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CBCC268884
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 12:34:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 22 Oct 2018 14:33:59 +0200
Message-Id: <20181022123413.28044-27-armbru@redhat.com>
In-Reply-To: <20181022123413.28044-1-armbru@redhat.com>
References: <20181022123413.28044-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/40] vl: Clean up error reporting in
 device_init_func()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Calling error_report() in a function that takes an Error ** argument
is suspicious.  device_init_func() does that, and then fails without
setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
with it, but clean it up anyway.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20181017082702.5581-25-armbru@redhat.com>
---
 vl.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/vl.c b/vl.c
index 92d15711a5..1fa1e14853 100644
--- a/vl.c
+++ b/vl.c
@@ -2222,12 +2222,10 @@ static int device_help_func(void *opaque, QemuOpt=
s *opts, Error **errp)
=20
 static int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
-    Error *err =3D NULL;
     DeviceState *dev;
=20
-    dev =3D qdev_device_add(opts, &err);
+    dev =3D qdev_device_add(opts, errp);
     if (!dev) {
-        error_report_err(err);
         return -1;
     }
     object_unref(OBJECT(dev));
@@ -4492,10 +4490,8 @@ int main(int argc, char **argv, char **envp)
=20
     /* init generic devices */
     rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
-    if (qemu_opts_foreach(qemu_find_opts("device"),
-                          device_init_func, NULL, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("device"),
+                      device_init_func, NULL, &error_fatal);
=20
     cpu_synchronize_all_post_init();
=20
--=20
2.17.2
