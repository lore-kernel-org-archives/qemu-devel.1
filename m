Received: from eggs.gnu.org ([2001:4830:134:3::10]:54250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCPQ-0003uV-Mf
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCPP-00076R-LL
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:51:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXCPP-00075t-AN
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:51:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ACE27307D840
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 21:51:10 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 01:48:47 +0400
Message-Id: <20181212214850.29953-26-marcandre.lureau@redhat.com>
In-Reply-To: <20181212214850.29953-1-marcandre.lureau@redhat.com>
References: <20181212214850.29953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 25/28] qdev-props: remove errp from
 GlobalProperty
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

All qdev_prop_register_global() set &error_fatal for errp, except
'-rtc driftfix=3Dslew', which arguably should also use &error_fatal, as
otherwise failing to apply the property would only report a warning.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/qdev-core.h    | 6 ------
 hw/core/qdev-properties.c | 4 ++--
 qom/cpu.c                 | 1 -
 target/i386/cpu.c         | 1 -
 target/sparc/cpu.c        | 1 -
 vl.c                      | 1 -
 6 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 86b05baeeb..b6ce69c4ac 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -250,18 +250,12 @@ struct PropertyInfo {
 /**
  * GlobalProperty:
  * @used: Set to true if property was used when initializing a device.
- * @errp: Error destination, used like first argument of error_setg()
- *        in case property setting fails later. If @errp is NULL, we
- *        print warnings instead of ignoring errors silently. For
- *        hotplugged devices, errp is always ignored and warnings are
- *        printed instead.
  */
 typedef struct GlobalProperty {
     const char *driver;
     const char *property;
     const char *value;
     bool used;
-    Error **errp;
 } GlobalProperty;
=20
 static inline void
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 3467e0485c..a2d25d3d37 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1238,8 +1238,8 @@ void qdev_prop_set_globals(DeviceState *dev)
         if (err !=3D NULL) {
             error_prepend(&err, "can't apply global %s.%s=3D%s: ",
                           prop->driver, prop->property, prop->value);
-            if (!dev->hotplugged && prop->errp) {
-                error_propagate(prop->errp, err);
+            if (!dev->hotplugged) {
+                error_propagate(&error_fatal, err);
             } else {
                 warn_report_err(err);
             }
diff --git a/qom/cpu.c b/qom/cpu.c
index 9ad1372d57..5442a7323b 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -312,7 +312,6 @@ static void cpu_common_parse_features(const char *typ=
ename, char *features,
             prop->driver =3D typename;
             prop->property =3D g_strdup(featurestr);
             prop->value =3D g_strdup(val);
-            prop->errp =3D &error_fatal;
             qdev_prop_register_global(prop);
         } else {
             error_setg(errp, "Expected key=3Dvalue format, found %s.",
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 748eaf8367..5ee48af53e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3568,7 +3568,6 @@ static void x86_cpu_parse_featurestr(const char *ty=
pename, char *features,
         prop->driver =3D typename;
         prop->property =3D g_strdup(name);
         prop->value =3D g_strdup(val);
-        prop->errp =3D &error_fatal;
         qdev_prop_register_global(prop);
     }
=20
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 0f090ece54..4a4445bdf5 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -111,7 +111,6 @@ cpu_add_feat_as_prop(const char *typename, const char=
 *name, const char *val)
     prop->driver =3D typename;
     prop->property =3D g_strdup(name);
     prop->value =3D g_strdup(val);
-    prop->errp =3D &error_fatal;
     qdev_prop_register_global(prop);
 }
=20
diff --git a/vl.c b/vl.c
index dfc100f51a..1b25cb3da2 100644
--- a/vl.c
+++ b/vl.c
@@ -2936,7 +2936,6 @@ static int global_init_func(void *opaque, QemuOpts =
*opts, Error **errp)
     g->driver   =3D qemu_opt_get(opts, "driver");
     g->property =3D qemu_opt_get(opts, "property");
     g->value    =3D qemu_opt_get(opts, "value");
-    g->errp =3D &error_fatal;
     qdev_prop_register_global(g);
     return 0;
 }
--=20
2.20.0
