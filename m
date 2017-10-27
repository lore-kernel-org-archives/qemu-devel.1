Received: from eggs.gnu.org ([2001:4830:134:3::10]:34049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85WQ-0005Ks-8A
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85WP-0000HD-4u
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:22:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e85WO-0000GH-Ux
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:22:05 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 27 Oct 2017 16:20:39 +0200
Message-Id: <20171027142107.15542-12-ehabkost@redhat.com>
In-Reply-To: <20171027142107.15542-1-ehabkost@redhat.com>
References: <20171027142107.15542-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 11/39] moxie: fix qemu-system-moxie failing
 to start with CLI "-cpu MoxieLite"
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

It 'works' with default CPU only because of bug in
moxie_cpu_class_by_name() where it treats cpu_model
as type name and default cpu_model also happens to be
type name. But specifying explicitly cpu on CLI,
ex: '-cpu MoxieLite', makes QEMU fail since
moxie_cpu_class_by_name() doesn't traslate cpu_model
to cpu type and fails to find corresponding object class.

Fix moxie_cpu_class_by_name() to do proper
   cpu_model -> cpu type
translation and fix default cpu_model to be cpu_model
instead of being typename.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1507211474-188400-15-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/moxie/moxiesim.c | 2 +-
 target/moxie/cpu.c  | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index 5ea8dd3a93..01b9f34f87 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -116,7 +116,7 @@ static void moxiesim_init(MachineState *machine)
=20
     /* Init CPUs. */
     if (cpu_model =3D=3D NULL) {
-        cpu_model =3D "MoxieLite-moxie-cpu";
+        cpu_model =3D "MoxieLite";
     }
     cpu =3D MOXIE_CPU(cpu_generic_init(TYPE_MOXIE_CPU, cpu_model));
     env =3D &cpu->env;
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 24ab3f3708..44441b2cf2 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -83,7 +83,12 @@ static void moxie_cpu_initfn(Object *obj)
=20
 static ObjectClass *moxie_cpu_class_by_name(const char *cpu_model)
 {
-    ObjectClass *oc =3D object_class_by_name(cpu_model);
+    ObjectClass *oc;
+    char *typename;
+
+    typename =3D g_strdup_printf("%s-" TYPE_MOXIE_CPU, cpu_model);
+    oc =3D object_class_by_name(typename);
+    g_free(typename);
     if (oc !=3D NULL && (!object_class_dynamic_cast(oc, TYPE_MOXIE_CPU) =
||
                        object_class_is_abstract(oc))) {
         return NULL;
--=20
2.13.6
