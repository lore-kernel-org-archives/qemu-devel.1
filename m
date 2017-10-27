Received: from eggs.gnu.org ([2001:4830:134:3::10]:34352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85X8-0006ZK-Di
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85X5-0001Gw-8Y
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:22:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e85X4-0001FY-Vm
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:22:47 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 27 Oct 2017 16:20:48 +0200
Message-Id: <20171027142107.15542-21-ehabkost@redhat.com>
In-Reply-To: <20171027142107.15542-1-ehabkost@redhat.com>
References: <20171027142107.15542-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 20/39] sh4: remove SuperHCPUClass::name field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

the field contains upper-cased cpu model name and is used
for printing supported cpu model names for '-cpu help'.

Considering that cpu model lookup in superh_cpu_class_by_name()
is case-insensitive, we can drop upper-casing when
printing supported cpus list and use cpu type directly
to do the same by cutting out SUPERH_CPU_TYPE_SUFFIX from
typename.

It allows to remove SuperHCPUClass::name, which practically
duplicates names defined by TYPE_SH*_CPU definitions and
simplify sh*_class_init()/SuperHCPUClass a bit.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1507211474-188400-24-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/sh4/cpu-qom.h |  2 --
 target/sh4/cpu.c     | 10 +++-------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/sh4/cpu-qom.h b/target/sh4/cpu-qom.h
index 17deeb661b..0f9fb4dd31 100644
--- a/target/sh4/cpu-qom.h
+++ b/target/sh4/cpu-qom.h
@@ -39,7 +39,6 @@
  * SuperHCPUClass:
  * @parent_realize: The parent class' realize handler.
  * @parent_reset: The parent class' reset handler.
- * @name: The name.
  * @pvr: Processor Version Register
  * @prr: Processor Revision Register
  * @cvr: Cache Version Register
@@ -54,7 +53,6 @@ typedef struct SuperHCPUClass {
     DeviceRealize parent_realize;
     void (*parent_reset)(CPUState *cpu);
=20
-    const char *name;
     uint32_t pvr;
     uint32_t prr;
     uint32_t cvr;
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 972c809d8c..e0b99fbc89 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -98,12 +98,11 @@ static gint superh_cpu_list_compare(gconstpointer a, =
gconstpointer b)
=20
 static void superh_cpu_list_entry(gpointer data, gpointer user_data)
 {
-    ObjectClass *oc =3D data;
-    SuperHCPUClass *scc =3D SUPERH_CPU_CLASS(oc);
     SuperHCPUListState *s =3D user_data;
+    const char *typename =3D object_class_get_name(OBJECT_CLASS(data));
+    int len =3D strlen(typename) - strlen(SUPERH_CPU_TYPE_SUFFIX);
=20
-    (*s->cpu_fprintf)(s->file, "%s\n",
-                      scc->name);
+    (*s->cpu_fprintf)(s->file, "%.*s\n", len, typename);
 }
=20
 void sh4_cpu_list(FILE *f, fprintf_function cpu_fprintf)
@@ -156,7 +155,6 @@ static void sh7750r_class_init(ObjectClass *oc, void =
*data)
 {
     SuperHCPUClass *scc =3D SUPERH_CPU_CLASS(oc);
=20
-    scc->name =3D "SH7750R";
     scc->pvr =3D 0x00050000;
     scc->prr =3D 0x00000100;
     scc->cvr =3D 0x00110000;
@@ -175,7 +173,6 @@ static void sh7751r_class_init(ObjectClass *oc, void =
*data)
 {
     SuperHCPUClass *scc =3D SUPERH_CPU_CLASS(oc);
=20
-    scc->name =3D "SH7751R";
     scc->pvr =3D 0x04050005;
     scc->prr =3D 0x00000113;
     scc->cvr =3D 0x00110000; /* Neutered caches, should be 0x20480000 */
@@ -194,7 +191,6 @@ static void sh7785_class_init(ObjectClass *oc, void *=
data)
 {
     SuperHCPUClass *scc =3D SUPERH_CPU_CLASS(oc);
=20
-    scc->name =3D "SH7785";
     scc->pvr =3D 0x10300700;
     scc->prr =3D 0x00000200;
     scc->cvr =3D 0x71440211;
--=20
2.13.6
