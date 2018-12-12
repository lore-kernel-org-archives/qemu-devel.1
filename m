Received: from eggs.gnu.org ([2001:4830:134:3::10]:54130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCPH-0003eb-CP
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:51:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCPG-0006zo-5j
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:51:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXCPE-0006ws-Ls
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:51:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 559C72D808
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 21:50:56 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 01:48:44 +0400
Message-Id: <20181212214850.29953-23-marcandre.lureau@redhat.com>
In-Reply-To: <20181212214850.29953-1-marcandre.lureau@redhat.com>
References: <20181212214850.29953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 22/28] qdev: make a separate helper function
 to apply compat properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com

This will allow to apply compat properties on other objects than QDev eas=
ily.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/qdev-core.h | 2 ++
 hw/core/qdev.c         | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 84e612f473..5989fb6565 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -422,6 +422,8 @@ const char *qdev_fw_name(DeviceState *dev);
=20
 Object *qdev_get_machine(void);
=20
+void object_apply_compat_props(Object *obj);
+
 /* FIXME: make this a link<> */
 void qdev_set_parent_bus(DeviceState *dev, BusState *bus);
=20
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index d510340bac..3769a2bccb 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -970,7 +970,7 @@ static void device_initfn(Object *obj)
     QLIST_INIT(&dev->gpios);
 }
=20
-static void device_post_init(Object *obj)
+void object_apply_compat_props(Object *obj)
 {
     if (object_dynamic_cast(qdev_get_machine(), TYPE_MACHINE)) {
         MachineState *m =3D MACHINE(qdev_get_machine());
@@ -982,7 +982,11 @@ static void device_post_init(Object *obj)
         }
         object_apply_global_props(obj, mc->compat_props, &error_abort);
     }
+}
=20
+static void device_post_init(Object *obj)
+{
+    object_apply_compat_props(obj);
     qdev_prop_set_globals(DEVICE(obj));
 }
=20
--=20
2.20.0
