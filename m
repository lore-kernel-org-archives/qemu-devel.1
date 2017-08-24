Received: from eggs.gnu.org ([2001:4830:134:3::10]:54937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv2z-0000Yj-QS
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv2y-0007Ro-PL
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:31:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dkv2y-0007RF-HH
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:31:56 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 24 Aug 2017 18:31:27 +0200
Message-Id: <1503592308-93913-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
References: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.11 v3 04/25] sparc: convert cpu features
 to qdev properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

SPARC is the last target that uses legacy way of parsing
and initializing cpu features, drop legacy approach and
convert features to properties so that SPARC could as minimum
benefit from generic cpu_generic_init(), common with
x86 +-feat parser

PS:
the main purpose is to remove legacy way of cpu creation as
a blocker for unifying cpu creation code across targets.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/cpu.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 66 insertions(+)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 281a99f..82ab5ad 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -22,6 +22,8 @@
 #include "cpu.h"
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
+#include "hw/qdev-properties.h"
+#include "qapi/visitor.h"
=20
 //#define DEBUG_FEATURES
=20
@@ -852,6 +854,69 @@ static void sparc_cpu_initfn(Object *obj)
     }
 }
=20
+static void sparc_get_nwindows(Object *obj, Visitor *v, const char *name=
,
+                               void *opaque, Error **errp)
+{
+    SPARCCPU *cpu =3D SPARC_CPU(obj);
+    int64_t value =3D cpu->env.def.nwindows;
+
+    visit_type_int(v, name, &value, errp);
+}
+
+static void sparc_set_nwindows(Object *obj, Visitor *v, const char *name=
,
+                               void *opaque, Error **errp)
+{
+    const int64_t min =3D MIN_NWINDOWS;
+    const int64_t max =3D MAX_NWINDOWS;
+    SPARCCPU *cpu =3D SPARC_CPU(obj);
+    Error *err =3D NULL;
+    int64_t value;
+
+    visit_type_int(v, name, &value, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    if (value < min || value > max) {
+        error_setg(errp, "Property %s.%s doesn't take value %" PRId64
+                   " (minimum: %" PRId64 ", maximum: %" PRId64 ")",
+                   object_get_typename(obj), name ? name : "null",
+                   value, min, max);
+        return;
+    }
+    cpu->env.def.nwindows =3D value;
+}
+
+static PropertyInfo qdev_prop_nwindows =3D {
+    .name  =3D "int",
+    .get   =3D sparc_get_nwindows,
+    .set   =3D sparc_set_nwindows,
+};
+
+static Property sparc_cpu_properties[] =3D {
+    DEFINE_PROP_BIT("float",    SPARCCPU, env.def.features, 0, false),
+    DEFINE_PROP_BIT("float128", SPARCCPU, env.def.features, 1, false),
+    DEFINE_PROP_BIT("swap",     SPARCCPU, env.def.features, 2, false),
+    DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features, 3, false),
+    DEFINE_PROP_BIT("div",      SPARCCPU, env.def.features, 4, false),
+    DEFINE_PROP_BIT("flush",    SPARCCPU, env.def.features, 5, false),
+    DEFINE_PROP_BIT("fsqrt",    SPARCCPU, env.def.features, 6, false),
+    DEFINE_PROP_BIT("fmul",     SPARCCPU, env.def.features, 7, false),
+    DEFINE_PROP_BIT("vis1",     SPARCCPU, env.def.features, 8, false),
+    DEFINE_PROP_BIT("vis2",     SPARCCPU, env.def.features, 9, false),
+    DEFINE_PROP_BIT("fsmuld",   SPARCCPU, env.def.features, 10, false),
+    DEFINE_PROP_BIT("hypv",     SPARCCPU, env.def.features, 11, false),
+    DEFINE_PROP_BIT("cmt",      SPARCCPU, env.def.features, 12, false),
+    DEFINE_PROP_BIT("gl",       SPARCCPU, env.def.features, 13, false),
+    DEFINE_PROP_UNSIGNED("iu-version", SPARCCPU, env.def.iu_version, 0,
+                         qdev_prop_uint64, target_ulong),
+    DEFINE_PROP_UINT32("fpu-version", SPARCCPU, env.def.fpu_version, 0),
+    DEFINE_PROP_UINT32("mmu-version", SPARCCPU, env.def.mmu_version, 0),
+    { .name  =3D "nwindows", .info  =3D &qdev_prop_nwindows },
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void sparc_cpu_class_init(ObjectClass *oc, void *data)
 {
     SPARCCPUClass *scc =3D SPARC_CPU_CLASS(oc);
@@ -860,6 +925,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, voi=
d *data)
=20
     scc->parent_realize =3D dc->realize;
     dc->realize =3D sparc_cpu_realizefn;
+    dc->props =3D sparc_cpu_properties;
=20
     scc->parent_reset =3D cc->reset;
     cc->reset =3D sparc_cpu_reset;
--=20
2.7.4
