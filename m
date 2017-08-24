Received: from eggs.gnu.org ([2001:4830:134:3::10]:55044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv37-0000gv-TG
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv36-0007WM-Tc
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dkv36-0007VU-LF
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA8527E455
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 16:32:03 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2FFE0413D
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 16:32:03 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 24 Aug 2017 18:31:35 +0200
Message-Id: <1503592308-93913-13-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
References: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.11 v3 12/25] microblaze: replace
 cpu_mb_init() with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

cpu_mb_init() always falls back to TYPE_MICROBLAZE_CPU object
regardless of cpu_model. Put fallback logic into
mb_cpu_class_by_name() which would translate any cpu_model
into TYPE_MICROBLAZE_CPU class and replace cpu_mb_init()
with cpu_generic_init().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 target/microblaze/cpu.h       |  3 +--
 target/microblaze/cpu.c       |  6 ++++++
 target/microblaze/translate.c | 11 -----------
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 5ce4c82..52b6b6a 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -331,7 +331,6 @@ int mb_cpu_gdb_read_register(CPUState *cpu, uint8_t *=
buf, int reg);
 int mb_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
=20
 void mb_tcg_init(void);
-MicroBlazeCPU *cpu_mb_init(const char *cpu_model);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
    signal handlers to inform the virtual CPU of exceptions. non zero
    is returned if the signal was handled by the virtual CPU.  */
@@ -344,7 +343,7 @@ int cpu_mb_signal_handler(int host_signum, void *pinf=
o,
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
=20
-#define cpu_init(cpu_model) CPU(cpu_mb_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_MICROBLAZE_CPU, cpu_mo=
del)
=20
 #define cpu_signal_handler cpu_mb_signal_handler
=20
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index f85ff01..ddffe86 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -253,6 +253,11 @@ static Property mb_properties[] =3D {
     DEFINE_PROP_END_OF_LIST(),
 };
=20
+static ObjectClass *mb_cpu_class_by_name(const char *cpu_model)
+{
+    return object_class_by_name(TYPE_MICROBLAZE_CPU);
+}
+
 static void mb_cpu_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(oc);
@@ -265,6 +270,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *=
data)
     mcc->parent_reset =3D cc->reset;
     cc->reset =3D mb_cpu_reset;
=20
+    cc->class_by_name =3D mb_cpu_class_by_name;
     cc->has_work =3D mb_cpu_has_work;
     cc->do_interrupt =3D mb_cpu_do_interrupt;
     cc->cpu_exec_interrupt =3D mb_cpu_exec_interrupt;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
index a24373c..83e2ef4 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1845,17 +1845,6 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, fpri=
ntf_function cpu_fprintf,
     cpu_fprintf(f, "\n\n");
 }
=20
-MicroBlazeCPU *cpu_mb_init(const char *cpu_model)
-{
-    MicroBlazeCPU *cpu;
-
-    cpu =3D MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
-
-    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
-
-    return cpu;
-}
-
 void mb_tcg_init(void)
 {
     int i;
--=20
2.7.4
