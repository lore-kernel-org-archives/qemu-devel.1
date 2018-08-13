Received: from eggs.gnu.org ([2001:4830:134:3::10]:45212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fpHso-0001uk-OA
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 14:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fpHsn-0003za-Dk
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 14:48:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 13 Aug 2018 19:46:19 +0100
Message-Id: <20180813184624.12071-2-stefanha@redhat.com>
In-Reply-To: <20180813184624.12071-1-stefanha@redhat.com>
References: <20180813184624.12071-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 1/6] hw/arm: make bitbanded IO optional on
 ARMv7-M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ilg@livius.net, jusual@mail.ru, joel@jms.id.au, Peter Maydell <peter.maydell@linaro.org>, jim@groklearning.com, mail@steffen-goertz.de, qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>, Su Hang <suhang16@mails.ucas.ac.cn>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Steffen Gortz <qemu.ml@steffen-goertz.de>, Stefan Hajnoczi <stefanha@redhat.com>

Some ARM CPUs have bitbanded IO, a memory region that allows convenient
bit access via 32-bit memory loads/stores.  This eliminates the need for
read-modify-update instruction sequences.

This patch makes this optional feature an ARMv7MState qdev property,
allowing boards to choose whether they want bitbanding or not.

Status of boards:
 * iotkit (Cortex M33), no bitband
 * mps2 (Cortex M3), bitband
 * msf2 (Cortex M3), bitband
 * stellaris (Cortex M3), bitband
 * stm32f205 (Cortex M3), bitband

As a side-effect of this patch, Peter Maydell noted that the Ethernet
controller on mps2 board is now accessible.  Previously they were hidden
by the bitband region (which does not exist on the real board).

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 include/hw/arm/armv7m.h |  2 ++
 hw/arm/armv7m.c         | 37 ++++++++++++++++++++-----------------
 hw/arm/mps2.c           |  1 +
 hw/arm/msf2-soc.c       |  1 +
 hw/arm/stellaris.c      |  1 +
 hw/arm/stm32f205_soc.c  |  1 +
 6 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index 78308d1484..2ba24953b6 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -43,6 +43,7 @@ typedef struct {
  *   devices will be automatically layered on top of this view.)
  * + Property "idau": IDAU interface (forwarded to CPU object)
  * + Property "init-svtor": secure VTOR reset value (forwarded to CPU ob=
ject)
+ * + Property "enable-bitband": expose bitbanded IO
  */
 typedef struct ARMv7MState {
     /*< private >*/
@@ -63,6 +64,7 @@ typedef struct ARMv7MState {
     MemoryRegion *board_memory;
     Object *idau;
     uint32_t init_svtor;
+    bool enable_bitband;
 } ARMv7MState;
=20
 #endif
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 6b07666057..878613994d 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -211,25 +211,27 @@ static void armv7m_realize(DeviceState *dev, Error =
**errp)
     memory_region_add_subregion(&s->container, 0xe000e000,
                                 sysbus_mmio_get_region(sbd, 0));
=20
-    for (i =3D 0; i < ARRAY_SIZE(s->bitband); i++) {
-        Object *obj =3D OBJECT(&s->bitband[i]);
-        SysBusDevice *sbd =3D SYS_BUS_DEVICE(&s->bitband[i]);
+    if (s->enable_bitband) {
+        for (i =3D 0; i < ARRAY_SIZE(s->bitband); i++) {
+            Object *obj =3D OBJECT(&s->bitband[i]);
+            SysBusDevice *sbd =3D SYS_BUS_DEVICE(&s->bitband[i]);
=20
-        object_property_set_int(obj, bitband_input_addr[i], "base", &err=
);
-        if (err !=3D NULL) {
-            error_propagate(errp, err);
-            return;
-        }
-        object_property_set_link(obj, OBJECT(s->board_memory),
-                                 "source-memory", &error_abort);
-        object_property_set_bool(obj, true, "realized", &err);
-        if (err !=3D NULL) {
-            error_propagate(errp, err);
-            return;
-        }
+            object_property_set_int(obj, bitband_input_addr[i], "base", =
&err);
+            if (err !=3D NULL) {
+                error_propagate(errp, err);
+                return;
+            }
+            object_property_set_link(obj, OBJECT(s->board_memory),
+                                     "source-memory", &error_abort);
+            object_property_set_bool(obj, true, "realized", &err);
+            if (err !=3D NULL) {
+                error_propagate(errp, err);
+                return;
+            }
=20
-        memory_region_add_subregion(&s->container, bitband_output_addr[i=
],
-                                    sysbus_mmio_get_region(sbd, 0));
+            memory_region_add_subregion(&s->container, bitband_output_ad=
dr[i],
+                                        sysbus_mmio_get_region(sbd, 0));
+        }
     }
 }
=20
@@ -239,6 +241,7 @@ static Property armv7m_properties[] =3D {
                      MemoryRegion *),
     DEFINE_PROP_LINK("idau", ARMv7MState, idau, TYPE_IDAU_INTERFACE, Obj=
ect *),
     DEFINE_PROP_UINT32("init-svtor", ARMv7MState, init_svtor, 0),
+    DEFINE_PROP_BOOL("enable-bitband", ARMv7MState, enable_bitband, fals=
e),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index c3946da317..0a0ae867d9 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -186,6 +186,7 @@ static void mps2_common_init(MachineState *machine)
         g_assert_not_reached();
     }
     qdev_prop_set_string(armv7m, "cpu-type", machine->cpu_type);
+    qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&mms->armv7m), OBJECT(system_memory)=
,
                              "memory", &error_abort);
     object_property_set_bool(OBJECT(&mms->armv7m), true, "realized",
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index dbefade644..2702e90b45 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -117,6 +117,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, =
Error **errp)
     armv7m =3D DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 81);
     qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
+    qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memor=
y()),
                                      "memory", &error_abort);
     object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err)=
;
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index dc521b4a5a..6c69ce79b2 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1304,6 +1304,7 @@ static void stellaris_init(MachineState *ms, stella=
ris_board_info *board)
     nvic =3D qdev_create(NULL, TYPE_ARMV7M);
     qdev_prop_set_uint32(nvic, "num-irq", NUM_IRQ_LINES);
     qdev_prop_set_string(nvic, "cpu-type", ms->cpu_type);
+    qdev_prop_set_bit(nvic, "enable-bitband", true);
     object_property_set_link(OBJECT(nvic), OBJECT(get_system_memory()),
                                      "memory", &error_abort);
     /* This will exit with an error if the user passed us a bad cpu_type=
 */
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index c486d06a8b..980e5af13c 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -109,6 +109,7 @@ static void stm32f205_soc_realize(DeviceState *dev_so=
c, Error **errp)
     armv7m =3D DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 96);
     qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
+    qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memor=
y()),
                                      "memory", &error_abort);
     object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err)=
;
--=20
2.17.1
