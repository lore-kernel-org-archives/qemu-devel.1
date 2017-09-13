Received: from eggs.gnu.org ([2001:4830:134:3::10]:46243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsA9z-0002PX-4C
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsA9t-0006YQ-Bo
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:05:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dsA9t-0006Xm-3R
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:05:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 36B6C356C0
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 16:05:00 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AE5075D963
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 16:04:59 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 13 Sep 2017 18:04:53 +0200
Message-Id: <1505318697-77161-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1505318697-77161-1-git-send-email-imammedo@redhat.com>
References: <1505318697-77161-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/5] qom: cpus: split cpu_generic_init() on
 feature parsing and cpu creation parts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

it would allow to reuse feature parsing part in various machines
that have CPU features instead of re-implementing the same feature
parsing each time.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
v2:
 - squash in "cpu: rename cpu_parse_features() to cpu_parse_cpu_model()"
---
 include/qom/cpu.h | 21 +++++++++++++++++++++
 qom/cpu.c         | 46 ++++++++++++++++++++++++++++++----------------
 2 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 995a7be..885276c 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -645,6 +645,27 @@ void cpu_reset(CPUState *cpu);
 ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_mod=
el);
=20
 /**
+ * cpu_create:
+ * @typename: The CPU type.
+ *
+ * Instantiates a CPU and realizes the CPU.
+ *
+ * Returns: A #CPUState or %NULL if an error occurred.
+ */
+CPUState *cpu_create(const char *typename);
+
+/**
+ * cpu_parse_cpu_model:
+ * @typename: The CPU base type or CPU type.
+ * @cpu_model: The model string including optional parameters.
+ *
+ * processes optional parameters and registers them as global properties
+ *
+ * Returns: type of CPU to create or %NULL if an error occurred.
+ */
+const char *cpu_parse_cpu_model(const char *typename, const char *cpu_mo=
del);
+
+/**
  * cpu_generic_init:
  * @typename: The CPU base type.
  * @cpu_model: The model string including optional parameters.
diff --git a/qom/cpu.c b/qom/cpu.c
index dc5392d..483f26a 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -54,13 +54,26 @@ bool cpu_exists(int64_t id)
     return !!cpu_by_arch_id(id);
 }
=20
-CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
+CPUState *cpu_create(const char *typename)
+{
+    Error *err =3D NULL;
+    CPUState *cpu =3D CPU(object_new(typename));
+    object_property_set_bool(OBJECT(cpu), true, "realized", &err);
+    if (err !=3D NULL) {
+        error_report_err(err);
+        object_unref(OBJECT(cpu));
+        return NULL;
+    }
+    return cpu;
+}
+
+const char *cpu_parse_cpu_model(const char *typename, const char *cpu_mo=
del)
 {
-    CPUState *cpu =3D NULL;
     ObjectClass *oc;
     CPUClass *cc;
     Error *err =3D NULL;
     gchar **model_pieces;
+    const char *cpu_type;
=20
     model_pieces =3D g_strsplit(cpu_model, ",", 2);
=20
@@ -70,27 +83,28 @@ CPUState *cpu_generic_init(const char *typename, cons=
t char *cpu_model)
         return NULL;
     }
=20
+    cpu_type =3D object_class_get_name(oc);
     cc =3D CPU_CLASS(oc);
-    /* TODO: all callers of cpu_generic_init() need to be converted to
-     * call parse_features() only once, before calling cpu_generic_init(=
).
-     */
-    cc->parse_features(object_class_get_name(oc), model_pieces[1], &err)=
;
+    cc->parse_features(cpu_type, model_pieces[1], &err);
     g_strfreev(model_pieces);
     if (err !=3D NULL) {
-        goto out;
-    }
-
-    cpu =3D CPU(object_new(object_class_get_name(oc)));
-    object_property_set_bool(OBJECT(cpu), true, "realized", &err);
-
-out:
-    if (err !=3D NULL) {
         error_report_err(err);
-        object_unref(OBJECT(cpu));
         return NULL;
     }
+    return cpu_type;
+}
=20
-    return cpu;
+CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
+{
+    /* TODO: all callers of cpu_generic_init() need to be converted to
+     * call cpu_parse_features() only once, before calling cpu_generic_i=
nit().
+     */
+    const char *cpu_type =3D cpu_parse_cpu_model(typename, cpu_model);
+
+    if (cpu_type) {
+        return cpu_create(cpu_type);
+    }
+    return NULL;
 }
=20
 bool cpu_paging_enabled(const CPUState *cpu)
--=20
2.7.4
