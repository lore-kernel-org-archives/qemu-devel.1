Received: from eggs.gnu.org ([2001:4830:134:3::10]:37669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN6t-0007qQ-QD
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:39:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN6p-00079K-9u
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:39:01 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Nov 2018 16:36:47 +0400
Message-Id: <20181107123652.23417-10-marcandre.lureau@redhat.com>
In-Reply-To: <20181107123652.23417-1-marcandre.lureau@redhat.com>
References: <20181107123652.23417-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v3 09/14] qdev-props: remove errp from
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, dgilbert@redhat.com, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, Artyom Tarasenko <atar4qemu@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Amit Shah <amit@kernel.org>, Stefan Berger <stefanb@linux.ibm.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

All qdev_prop_register_global() set &error_fatal for errp, except
'-rtc driftfix=3Dslew', which arguably should also use &error_fatal, as
otherwise failing to apply the property would only report a warning.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/qdev-core.h    | 6 ------
 hw/core/qdev-properties.c | 4 ++--
 qom/cpu.c                 | 1 -
 target/i386/cpu.c         | 1 -
 target/sparc/cpu.c        | 1 -
 vl.c                      | 1 -
 6 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index baaf097212..3a45889c34 100644
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
 /*** Board API.  This should go away once we have a machine config file.=
  ***/
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 353e67c05a..8728cbab9f 100644
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
index af7e9f09cc..1d2dba671e 100644
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
index d11b070e70..8ee6f7a688 100644
--- a/vl.c
+++ b/vl.c
@@ -2931,7 +2931,6 @@ static int global_init_func(void *opaque, QemuOpts =
*opts, Error **errp)
     g->driver   =3D qemu_opt_get(opts, "driver");
     g->property =3D qemu_opt_get(opts, "property");
     g->value    =3D qemu_opt_get(opts, "value");
-    g->errp =3D &error_fatal;
     qdev_prop_register_global(g);
     return 0;
 }
--=20
2.19.1.708.g4ede3d42df
