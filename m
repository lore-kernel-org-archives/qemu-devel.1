Received: from eggs.gnu.org ([2001:4830:134:3::10]:59120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGeO-0002Sk-SF
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGeA-0003RT-B6
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:40 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:52 +1000
Message-Id: <20170908103558.31632-35-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 34/40] ppc: make cpu_model translation to type
 consistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

PPC handles -cpu FOO rather incosistently,
i.e. it does case-insensitive matching of FOO to
a CPU type (see: ppc_cpu_compare_class_name) but
handles alias names as case-sensitive, as result:

 # qemu-system-ppc64 -M mac99 -cpu g3
 qemu-system-ppc64: unable to find CPU model ' kN=EF=BF=BDU'

 # qemu-system-ppc64 -cpu 970MP_V1.1
 qemu-system-ppc64: Unable to find sPAPR CPU Core definition

while

 # qemu-system-ppc64 -M mac99 -cpu G3
 # qemu-system-ppc64 -cpu 970MP_v1.1

start up just fine.

Considering we can't take case-insensitive matching away,
make it case-insensitive for  all alias/type/core_type
lookups.

As side effect it allows to remove duplicate core types
which are the same except of using different cased letters in name.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c     |  24 +-
 target/ppc/cpu-models.c     | 752 ++++++++++++++++++++++----------------=
------
 target/ppc/kvm.c            |   2 +-
 target/ppc/translate_init.c |   2 +-
 4 files changed, 390 insertions(+), 390 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index dd9232620d..92bec033b3 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -130,8 +130,10 @@ char *spapr_get_cpu_core_type(const char *model)
 {
     char *core_type;
     gchar **model_pieces =3D g_strsplit(model, ",", 2);
+    gchar *cpu_model =3D g_ascii_strdown(model_pieces[0], -1);
+    g_strfreev(model_pieces);
=20
-    core_type =3D g_strdup_printf("%s-%s", model_pieces[0], TYPE_SPAPR_C=
PU_CORE);
+    core_type =3D g_strdup_printf("%s-" TYPE_SPAPR_CPU_CORE, cpu_model);
=20
     /* Check whether it exists or whether we have to look up an alias na=
me */
     if (!object_class_by_name(core_type)) {
@@ -139,13 +141,13 @@ char *spapr_get_cpu_core_type(const char *model)
=20
         g_free(core_type);
         core_type =3D NULL;
-        realmodel =3D ppc_cpu_lookup_alias(model_pieces[0]);
+        realmodel =3D ppc_cpu_lookup_alias(cpu_model);
         if (realmodel) {
             core_type =3D spapr_get_cpu_core_type(realmodel);
         }
     }
+    g_free(cpu_model);
=20
-    g_strfreev(model_pieces);
     return core_type;
 }
=20
@@ -273,31 +275,29 @@ static const char *spapr_core_models[] =3D {
     "970_v2.2",
=20
     /* 970MP variants */
-    "970MP_v1.0",
     "970mp_v1.0",
-    "970MP_v1.1",
     "970mp_v1.1",
=20
     /* POWER5+ */
-    "POWER5+_v2.1",
+    "power5+_v2.1",
=20
     /* POWER7 */
-    "POWER7_v2.3",
+    "power7_v2.3",
=20
     /* POWER7+ */
-    "POWER7+_v2.1",
+    "power7+_v2.1",
=20
     /* POWER8 */
-    "POWER8_v2.0",
+    "power8_v2.0",
=20
     /* POWER8E */
-    "POWER8E_v2.1",
+    "power8e_v2.1",
=20
     /* POWER8NVL */
-    "POWER8NVL_v1.0",
+    "power8nvl_v1.0",
=20
     /* POWER9 */
-    "POWER9_v1.0",
+    "power9_v1.0",
 };
=20
 static Property spapr_cpu_core_properties[] =3D {
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 782977425b..07a48ca548 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -75,206 +75,206 @@
     POWERPC_DEF("401",           CPU_POWERPC_401,                    401=
,
                 "Generic PowerPC 401")
     /* PowerPC 401 cores                                                =
     */
-    POWERPC_DEF("401A1",         CPU_POWERPC_401A1,                  401=
,
+    POWERPC_DEF("401a1",         CPU_POWERPC_401A1,                  401=
,
                 "PowerPC 401A1")
-    POWERPC_DEF("401B2",         CPU_POWERPC_401B2,                  401=
x2,
+    POWERPC_DEF("401b2",         CPU_POWERPC_401B2,                  401=
x2,
                 "PowerPC 401B2")
 #if defined(TODO)
-    POWERPC_DEF("401B3",         CPU_POWERPC_401B3,                  401=
x3,
+    POWERPC_DEF("401b3",         CPU_POWERPC_401B3,                  401=
x3,
                 "PowerPC 401B3")
 #endif
-    POWERPC_DEF("401C2",         CPU_POWERPC_401C2,                  401=
x2,
+    POWERPC_DEF("401c2",         CPU_POWERPC_401C2,                  401=
x2,
                 "PowerPC 401C2")
-    POWERPC_DEF("401D2",         CPU_POWERPC_401D2,                  401=
x2,
+    POWERPC_DEF("401d2",         CPU_POWERPC_401D2,                  401=
x2,
                 "PowerPC 401D2")
-    POWERPC_DEF("401E2",         CPU_POWERPC_401E2,                  401=
x2,
+    POWERPC_DEF("401e2",         CPU_POWERPC_401E2,                  401=
x2,
                 "PowerPC 401E2")
-    POWERPC_DEF("401F2",         CPU_POWERPC_401F2,                  401=
x2,
+    POWERPC_DEF("401f2",         CPU_POWERPC_401F2,                  401=
x2,
                 "PowerPC 401F2")
     /* XXX: to be checked */
-    POWERPC_DEF("401G2",         CPU_POWERPC_401G2,                  401=
x2,
+    POWERPC_DEF("401g2",         CPU_POWERPC_401G2,                  401=
x2,
                 "PowerPC 401G2")
     /* PowerPC 401 microcontrollers                                     =
     */
 #if defined(TODO)
-    POWERPC_DEF("401GF",         CPU_POWERPC_401GF,                  401=
,
+    POWERPC_DEF("401gf",         CPU_POWERPC_401GF,                  401=
,
                 "PowerPC 401GF")
 #endif
-    POWERPC_DEF("IOP480",        CPU_POWERPC_IOP480,                 IOP=
480,
+    POWERPC_DEF("iop480",        CPU_POWERPC_IOP480,                 IOP=
480,
                 "IOP480 (401 microcontroller)")
-    POWERPC_DEF("Cobra",         CPU_POWERPC_COBRA,                  401=
,
+    POWERPC_DEF("cobra",         CPU_POWERPC_COBRA,                  401=
,
                 "IBM Processor for Network Resources")
 #if defined(TODO)
-    POWERPC_DEF("Xipchip",       CPU_POWERPC_XIPCHIP,                401=
,
+    POWERPC_DEF("xipchip",       CPU_POWERPC_XIPCHIP,                401=
,
                 NULL)
 #endif
     /* PowerPC 403 family                                               =
     */
     /* PowerPC 403 microcontrollers                                     =
     */
-    POWERPC_DEF("403GA",         CPU_POWERPC_403GA,                  403=
,
+    POWERPC_DEF("403ga",         CPU_POWERPC_403GA,                  403=
,
                 "PowerPC 403 GA")
-    POWERPC_DEF("403GB",         CPU_POWERPC_403GB,                  403=
,
+    POWERPC_DEF("403gb",         CPU_POWERPC_403GB,                  403=
,
                 "PowerPC 403 GB")
-    POWERPC_DEF("403GC",         CPU_POWERPC_403GC,                  403=
,
+    POWERPC_DEF("403gc",         CPU_POWERPC_403GC,                  403=
,
                 "PowerPC 403 GC")
-    POWERPC_DEF("403GCX",        CPU_POWERPC_403GCX,                 403=
GCX,
+    POWERPC_DEF("403gcx",        CPU_POWERPC_403GCX,                 403=
GCX,
                 "PowerPC 403 GCX")
 #if defined(TODO)
-    POWERPC_DEF("403GP",         CPU_POWERPC_403GP,                  403=
,
+    POWERPC_DEF("403gp",         CPU_POWERPC_403GP,                  403=
,
                 "PowerPC 403 GP")
 #endif
     /* PowerPC 405 family                                               =
     */
     /* PowerPC 405 cores                                                =
     */
 #if defined(TODO)
-    POWERPC_DEF("405A3",         CPU_POWERPC_405A3,                  405=
,
+    POWERPC_DEF("405a3",         CPU_POWERPC_405A3,                  405=
,
                 "PowerPC 405 A3")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("405A4",         CPU_POWERPC_405A4,                  405=
,
+    POWERPC_DEF("405a4",         CPU_POWERPC_405A4,                  405=
,
                 "PowerPC 405 A4")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("405B3",         CPU_POWERPC_405B3,                  405=
,
+    POWERPC_DEF("405b3",         CPU_POWERPC_405B3,                  405=
,
                 "PowerPC 405 B3")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("405B4",         CPU_POWERPC_405B4,                  405=
,
+    POWERPC_DEF("405b4",         CPU_POWERPC_405B4,                  405=
,
                 "PowerPC 405 B4")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("405C3",         CPU_POWERPC_405C3,                  405=
,
+    POWERPC_DEF("405c3",         CPU_POWERPC_405C3,                  405=
,
                 "PowerPC 405 C3")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("405C4",         CPU_POWERPC_405C4,                  405=
,
+    POWERPC_DEF("405c4",         CPU_POWERPC_405C4,                  405=
,
                 "PowerPC 405 C4")
 #endif
-    POWERPC_DEF("405D2",         CPU_POWERPC_405D2,                  405=
,
+    POWERPC_DEF("405d2",         CPU_POWERPC_405D2,                  405=
,
                 "PowerPC 405 D2")
 #if defined(TODO)
-    POWERPC_DEF("405D3",         CPU_POWERPC_405D3,                  405=
,
+    POWERPC_DEF("405d3",         CPU_POWERPC_405D3,                  405=
,
                 "PowerPC 405 D3")
 #endif
-    POWERPC_DEF("405D4",         CPU_POWERPC_405D4,                  405=
,
+    POWERPC_DEF("405d4",         CPU_POWERPC_405D4,                  405=
,
                 "PowerPC 405 D4")
 #if defined(TODO)
-    POWERPC_DEF("405D5",         CPU_POWERPC_405D5,                  405=
,
+    POWERPC_DEF("405d5",         CPU_POWERPC_405D5,                  405=
,
                 "PowerPC 405 D5")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("405E4",         CPU_POWERPC_405E4,                  405=
,
+    POWERPC_DEF("405e4",         CPU_POWERPC_405E4,                  405=
,
                 "PowerPC 405 E4")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("405F4",         CPU_POWERPC_405F4,                  405=
,
+    POWERPC_DEF("405f4",         CPU_POWERPC_405F4,                  405=
,
                 "PowerPC 405 F4")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("405F5",         CPU_POWERPC_405F5,                  405=
,
+    POWERPC_DEF("405f5",         CPU_POWERPC_405F5,                  405=
,
                 "PowerPC 405 F5")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("405F6",         CPU_POWERPC_405F6,                  405=
,
+    POWERPC_DEF("405f6",         CPU_POWERPC_405F6,                  405=
,
                 "PowerPC 405 F6")
 #endif
     /* PowerPC 405 microcontrollers                                     =
     */
-    POWERPC_DEF("405CRa",        CPU_POWERPC_405CRa,                 405=
,
+    POWERPC_DEF("405cra",        CPU_POWERPC_405CRa,                 405=
,
                 "PowerPC 405 CRa")
-    POWERPC_DEF("405CRb",        CPU_POWERPC_405CRb,                 405=
,
+    POWERPC_DEF("405crb",        CPU_POWERPC_405CRb,                 405=
,
                 "PowerPC 405 CRb")
-    POWERPC_DEF("405CRc",        CPU_POWERPC_405CRc,                 405=
,
+    POWERPC_DEF("405crc",        CPU_POWERPC_405CRc,                 405=
,
                 "PowerPC 405 CRc")
-    POWERPC_DEF("405EP",         CPU_POWERPC_405EP,                  405=
,
+    POWERPC_DEF("405ep",         CPU_POWERPC_405EP,                  405=
,
                 "PowerPC 405 EP")
 #if defined(TODO)
-    POWERPC_DEF("405EXr",        CPU_POWERPC_405EXr,                 405=
,
+    POWERPC_DEF("405exr",        CPU_POWERPC_405EXr,                 405=
,
                 "PowerPC 405 EXr")
 #endif
-    POWERPC_DEF("405EZ",         CPU_POWERPC_405EZ,                  405=
,
+    POWERPC_DEF("405ez",         CPU_POWERPC_405EZ,                  405=
,
                 "PowerPC 405 EZ")
 #if defined(TODO)
-    POWERPC_DEF("405FX",         CPU_POWERPC_405FX,                  405=
,
+    POWERPC_DEF("405fx",         CPU_POWERPC_405FX,                  405=
,
                 "PowerPC 405 FX")
 #endif
-    POWERPC_DEF("405GPa",        CPU_POWERPC_405GPa,                 405=
,
+    POWERPC_DEF("405gpa",        CPU_POWERPC_405GPa,                 405=
,
                 "PowerPC 405 GPa")
-    POWERPC_DEF("405GPb",        CPU_POWERPC_405GPb,                 405=
,
+    POWERPC_DEF("405gpb",        CPU_POWERPC_405GPb,                 405=
,
                 "PowerPC 405 GPb")
-    POWERPC_DEF("405GPc",        CPU_POWERPC_405GPc,                 405=
,
+    POWERPC_DEF("405gpc",        CPU_POWERPC_405GPc,                 405=
,
                 "PowerPC 405 GPc")
-    POWERPC_DEF("405GPd",        CPU_POWERPC_405GPd,                 405=
,
+    POWERPC_DEF("405gpd",        CPU_POWERPC_405GPd,                 405=
,
                 "PowerPC 405 GPd")
-    POWERPC_DEF("405GPR",        CPU_POWERPC_405GPR,                 405=
,
+    POWERPC_DEF("405gpr",        CPU_POWERPC_405GPR,                 405=
,
                 "PowerPC 405 GPR")
 #if defined(TODO)
-    POWERPC_DEF("405H",          CPU_POWERPC_405H,                   405=
,
+    POWERPC_DEF("405h",          CPU_POWERPC_405H,                   405=
,
                 "PowerPC 405 H")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("405L",          CPU_POWERPC_405L,                   405=
,
+    POWERPC_DEF("405l",          CPU_POWERPC_405L,                   405=
,
                 "PowerPC 405 L")
 #endif
-    POWERPC_DEF("405LP",         CPU_POWERPC_405LP,                  405=
,
+    POWERPC_DEF("405lp",         CPU_POWERPC_405LP,                  405=
,
                 "PowerPC 405 LP")
 #if defined(TODO)
-    POWERPC_DEF("405PM",         CPU_POWERPC_405PM,                  405=
,
+    POWERPC_DEF("405pm",         CPU_POWERPC_405PM,                  405=
,
                 "PowerPC 405 PM")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("405PS",         CPU_POWERPC_405PS,                  405=
,
+    POWERPC_DEF("405ps",         CPU_POWERPC_405PS,                  405=
,
                 "PowerPC 405 PS")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("405S",          CPU_POWERPC_405S,                   405=
,
+    POWERPC_DEF("405s",          CPU_POWERPC_405S,                   405=
,
                 "PowerPC 405 S")
 #endif
-    POWERPC_DEF("Npe405H",       CPU_POWERPC_NPE405H,                405=
,
+    POWERPC_DEF("npe405h",       CPU_POWERPC_NPE405H,                405=
,
                 "Npe405 H")
-    POWERPC_DEF("Npe405H2",      CPU_POWERPC_NPE405H2,               405=
,
+    POWERPC_DEF("npe405h2",      CPU_POWERPC_NPE405H2,               405=
,
                 "Npe405 H2")
-    POWERPC_DEF("Npe405L",       CPU_POWERPC_NPE405L,                405=
,
+    POWERPC_DEF("npe405l",       CPU_POWERPC_NPE405L,                405=
,
                 "Npe405 L")
-    POWERPC_DEF("Npe4GS3",       CPU_POWERPC_NPE4GS3,                405=
,
+    POWERPC_DEF("npe4gs3",       CPU_POWERPC_NPE4GS3,                405=
,
                 "Npe4GS3")
 #if defined(TODO)
-    POWERPC_DEF("Npcxx1",        CPU_POWERPC_NPCxx1,                 405=
,
+    POWERPC_DEF("npcxx1",        CPU_POWERPC_NPCxx1,                 405=
,
                 NULL)
 #endif
 #if defined(TODO)
-    POWERPC_DEF("Npr161",        CPU_POWERPC_NPR161,                 405=
,
+    POWERPC_DEF("npr161",        CPU_POWERPC_NPR161,                 405=
,
                 NULL)
 #endif
 #if defined(TODO)
-    POWERPC_DEF("LC77700",       CPU_POWERPC_LC77700,                405=
,
+    POWERPC_DEF("lc77700",       CPU_POWERPC_LC77700,                405=
,
                 "PowerPC LC77700 (Sanyo)")
 #endif
     /* PowerPC 401/403/405 based set-top-box microcontrollers           =
     */
 #if defined(TODO)
-    POWERPC_DEF("STB01000",      CPU_POWERPC_STB01000,               401=
x2,
+    POWERPC_DEF("stb01000",      CPU_POWERPC_STB01000,               401=
x2,
                 "STB010000")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("STB01010",      CPU_POWERPC_STB01010,               401=
x2,
+    POWERPC_DEF("stb01010",      CPU_POWERPC_STB01010,               401=
x2,
                 "STB01010")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("STB0210",       CPU_POWERPC_STB0210,                401=
x3,
+    POWERPC_DEF("stb0210",       CPU_POWERPC_STB0210,                401=
x3,
                 "STB0210")
 #endif
-    POWERPC_DEF("STB03",         CPU_POWERPC_STB03,                  405=
,
+    POWERPC_DEF("stb03",         CPU_POWERPC_STB03,                  405=
,
                 "STB03xx")
 #if defined(TODO)
-    POWERPC_DEF("STB043",        CPU_POWERPC_STB043,                 405=
,
+    POWERPC_DEF("stb043",        CPU_POWERPC_STB043,                 405=
,
                 "STB043x")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("STB045",        CPU_POWERPC_STB045,                 405=
,
+    POWERPC_DEF("stb045",        CPU_POWERPC_STB045,                 405=
,
                 "STB045x")
 #endif
-    POWERPC_DEF("STB04",         CPU_POWERPC_STB04,                  405=
,
+    POWERPC_DEF("stb04",         CPU_POWERPC_STB04,                  405=
,
                 "STB04xx")
-    POWERPC_DEF("STB25",         CPU_POWERPC_STB25,                  405=
,
+    POWERPC_DEF("stb25",         CPU_POWERPC_STB25,                  405=
,
                 "STB25xx")
 #if defined(TODO)
-    POWERPC_DEF("STB130",        CPU_POWERPC_STB130,                 405=
,
+    POWERPC_DEF("stb130",        CPU_POWERPC_STB130,                 405=
,
                 "STB130")
 #endif
     /* Xilinx PowerPC 405 cores                                         =
     */
@@ -305,95 +305,95 @@
 #endif
     /* PowerPC 440 cores                                                =
     */
 #if defined(TODO)
-    POWERPC_DEF("440A4",         CPU_POWERPC_440A4,                  440=
x4,
+    POWERPC_DEF("440a4",         CPU_POWERPC_440A4,                  440=
x4,
                 "PowerPC 440 A4")
 #endif
-    POWERPC_DEF("440-Xilinx",    CPU_POWERPC_440_XILINX,             440=
x5,
+    POWERPC_DEF("440-xilinx",    CPU_POWERPC_440_XILINX,             440=
x5,
                 "PowerPC 440 Xilinx 5")
=20
-    POWERPC_DEF("440-Xilinx-w-dfpu",    CPU_POWERPC_440_XILINX, 440x5wDF=
PU,
+    POWERPC_DEF("440-xilinx-w-dfpu",    CPU_POWERPC_440_XILINX, 440x5wDF=
PU,
                 "PowerPC 440 Xilinx 5 With a Double Prec. FPU")
 #if defined(TODO)
-    POWERPC_DEF("440A5",         CPU_POWERPC_440A5,                  440=
x5,
+    POWERPC_DEF("440a5",         CPU_POWERPC_440A5,                  440=
x5,
                 "PowerPC 440 A5")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("440B4",         CPU_POWERPC_440B4,                  440=
x4,
+    POWERPC_DEF("440b4",         CPU_POWERPC_440B4,                  440=
x4,
                 "PowerPC 440 B4")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("440G4",         CPU_POWERPC_440G4,                  440=
x4,
+    POWERPC_DEF("440g4",         CPU_POWERPC_440G4,                  440=
x4,
                 "PowerPC 440 G4")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("440F5",         CPU_POWERPC_440F5,                  440=
x5,
+    POWERPC_DEF("440f5",         CPU_POWERPC_440F5,                  440=
x5,
                 "PowerPC 440 F5")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("440G5",         CPU_POWERPC_440G5,                  440=
x5,
+    POWERPC_DEF("440g5",         CPU_POWERPC_440G5,                  440=
x5,
                 "PowerPC 440 G5")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("440H4",         CPU_POWERPC_440H4,                  440=
x4,
+    POWERPC_DEF("440h4",         CPU_POWERPC_440H4,                  440=
x4,
                 "PowerPC 440H4")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("440H6",         CPU_POWERPC_440H6,                  440=
Gx5,
+    POWERPC_DEF("440h6",         CPU_POWERPC_440H6,                  440=
Gx5,
                 "PowerPC 440H6")
 #endif
     /* PowerPC 440 microcontrollers                                     =
     */
-    POWERPC_DEF("440EPa",        CPU_POWERPC_440EPa,                 440=
EP,
+    POWERPC_DEF("440epa",        CPU_POWERPC_440EPa,                 440=
EP,
                 "PowerPC 440 EPa")
-    POWERPC_DEF("440EPb",        CPU_POWERPC_440EPb,                 440=
EP,
+    POWERPC_DEF("440epb",        CPU_POWERPC_440EPb,                 440=
EP,
                 "PowerPC 440 EPb")
-    POWERPC_DEF("440EPX",        CPU_POWERPC_440EPX,                 440=
EP,
+    POWERPC_DEF("440epx",        CPU_POWERPC_440EPX,                 440=
EP,
                 "PowerPC 440 EPX")
 #if defined(TODO_USER_ONLY)
-    POWERPC_DEF("440GPb",        CPU_POWERPC_440GPb,                 440=
GP,
+    POWERPC_DEF("440gpb",        CPU_POWERPC_440GPb,                 440=
GP,
                 "PowerPC 440 GPb")
 #endif
 #if defined(TODO_USER_ONLY)
-    POWERPC_DEF("440GPc",        CPU_POWERPC_440GPc,                 440=
GP,
+    POWERPC_DEF("440gpc",        CPU_POWERPC_440GPc,                 440=
GP,
                 "PowerPC 440 GPc")
 #endif
 #if defined(TODO_USER_ONLY)
-    POWERPC_DEF("440GRa",        CPU_POWERPC_440GRa,                 440=
x5,
+    POWERPC_DEF("440gra",        CPU_POWERPC_440GRa,                 440=
x5,
                 "PowerPC 440 GRa")
 #endif
 #if defined(TODO_USER_ONLY)
-    POWERPC_DEF("440GRX",        CPU_POWERPC_440GRX,                 440=
x5,
+    POWERPC_DEF("440grx",        CPU_POWERPC_440GRX,                 440=
x5,
                 "PowerPC 440 GRX")
 #endif
 #if defined(TODO_USER_ONLY)
-    POWERPC_DEF("440GXa",        CPU_POWERPC_440GXa,                 440=
EP,
+    POWERPC_DEF("440gxa",        CPU_POWERPC_440GXa,                 440=
EP,
                 "PowerPC 440 GXa")
 #endif
 #if defined(TODO_USER_ONLY)
-    POWERPC_DEF("440GXb",        CPU_POWERPC_440GXb,                 440=
EP,
+    POWERPC_DEF("440gxb",        CPU_POWERPC_440GXb,                 440=
EP,
                 "PowerPC 440 GXb")
 #endif
 #if defined(TODO_USER_ONLY)
-    POWERPC_DEF("440GXc",        CPU_POWERPC_440GXc,                 440=
EP,
+    POWERPC_DEF("440gxc",        CPU_POWERPC_440GXc,                 440=
EP,
                 "PowerPC 440 GXc")
 #endif
 #if defined(TODO_USER_ONLY)
-    POWERPC_DEF("440GXf",        CPU_POWERPC_440GXf,                 440=
EP,
+    POWERPC_DEF("440gxf",        CPU_POWERPC_440GXf,                 440=
EP,
                 "PowerPC 440 GXf")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("440S",          CPU_POWERPC_440S,                   440=
,
+    POWERPC_DEF("440s",          CPU_POWERPC_440S,                   440=
,
                 "PowerPC 440 S")
 #endif
 #if defined(TODO_USER_ONLY)
-    POWERPC_DEF("440SP",         CPU_POWERPC_440SP,                  440=
EP,
+    POWERPC_DEF("440sp",         CPU_POWERPC_440SP,                  440=
EP,
                 "PowerPC 440 SP")
 #endif
 #if defined(TODO_USER_ONLY)
-    POWERPC_DEF("440SP2",        CPU_POWERPC_440SP2,                 440=
EP,
+    POWERPC_DEF("440sp2",        CPU_POWERPC_440SP2,                 440=
EP,
                 "PowerPC 440 SP2")
 #endif
 #if defined(TODO_USER_ONLY)
-    POWERPC_DEF("440SPE",        CPU_POWERPC_440SPE,                 440=
EP,
+    POWERPC_DEF("440spe",        CPU_POWERPC_440SPE,                 440=
EP,
                 "PowerPC 440 SPE")
 #endif
     /* PowerPC 460 family                                               =
     */
@@ -403,67 +403,67 @@
 #endif
     /* PowerPC 464 microcontrollers                                     =
     */
 #if defined(TODO)
-    POWERPC_DEF("464H90",        CPU_POWERPC_464H90,                 460=
,
+    POWERPC_DEF("464h90",        CPU_POWERPC_464H90,                 460=
,
                 "PowerPC 464H90")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("464H90F",       CPU_POWERPC_464H90F,                460=
F,
+    POWERPC_DEF("464h90f",       CPU_POWERPC_464H90F,                460=
F,
                 "PowerPC 464H90F")
 #endif
     /* Freescale embedded PowerPC cores                                 =
     */
     /* MPC5xx family (aka RCPU)                                         =
     */
 #if defined(TODO_USER_ONLY)
-    POWERPC_DEF("MPC5xx",        CPU_POWERPC_MPC5xx,                 MPC=
5xx,
+    POWERPC_DEF("mpc5xx",        CPU_POWERPC_MPC5xx,                 MPC=
5xx,
                 "Generic MPC5xx core")
 #endif
     /* MPC8xx family (aka PowerQUICC)                                   =
     */
 #if defined(TODO_USER_ONLY)
-    POWERPC_DEF("MPC8xx",        CPU_POWERPC_MPC8xx,                 MPC=
8xx,
+    POWERPC_DEF("mpc8xx",        CPU_POWERPC_MPC8xx,                 MPC=
8xx,
                 "Generic MPC8xx core")
 #endif
     /* MPC82xx family (aka PowerQUICC-II)                               =
     */
-    POWERPC_DEF("G2",            CPU_POWERPC_G2,                     G2,
+    POWERPC_DEF("g2",            CPU_POWERPC_G2,                     G2,
                 "PowerPC G2 core")
-    POWERPC_DEF("G2H4",          CPU_POWERPC_G2H4,                   G2,
+    POWERPC_DEF("g2h4",          CPU_POWERPC_G2H4,                   G2,
                 "PowerPC G2 H4 core")
-    POWERPC_DEF("G2GP",          CPU_POWERPC_G2gp,                   G2,
+    POWERPC_DEF("g2gp",          CPU_POWERPC_G2gp,                   G2,
                 "PowerPC G2 GP core")
-    POWERPC_DEF("G2LS",          CPU_POWERPC_G2ls,                   G2,
+    POWERPC_DEF("g2ls",          CPU_POWERPC_G2ls,                   G2,
                 "PowerPC G2 LS core")
-    POWERPC_DEF("G2HiP3",        CPU_POWERPC_G2_HIP3,                G2,
+    POWERPC_DEF("g2hip3",        CPU_POWERPC_G2_HIP3,                G2,
                 "PowerPC G2 HiP3 core")
-    POWERPC_DEF("G2HiP4",        CPU_POWERPC_G2_HIP4,                G2,
+    POWERPC_DEF("g2hip4",        CPU_POWERPC_G2_HIP4,                G2,
                 "PowerPC G2 HiP4 core")
-    POWERPC_DEF("MPC603",        CPU_POWERPC_MPC603,                 603=
E,
+    POWERPC_DEF("mpc603",        CPU_POWERPC_MPC603,                 603=
E,
                 "PowerPC MPC603 core")
-    POWERPC_DEF("G2le",          CPU_POWERPC_G2LE,                   G2L=
E,
+    POWERPC_DEF("g2le",          CPU_POWERPC_G2LE,                   G2L=
E,
         "PowerPC G2le core (same as G2 plus little-endian mode support)"=
)
-    POWERPC_DEF("G2leGP",        CPU_POWERPC_G2LEgp,                 G2L=
E,
+    POWERPC_DEF("g2legp",        CPU_POWERPC_G2LEgp,                 G2L=
E,
                 "PowerPC G2LE GP core")
-    POWERPC_DEF("G2leLS",        CPU_POWERPC_G2LEls,                 G2L=
E,
+    POWERPC_DEF("g2lels",        CPU_POWERPC_G2LEls,                 G2L=
E,
                 "PowerPC G2LE LS core")
-    POWERPC_DEF("G2leGP1",       CPU_POWERPC_G2LEgp1,                G2L=
E,
+    POWERPC_DEF("g2legp1",       CPU_POWERPC_G2LEgp1,                G2L=
E,
                 "PowerPC G2LE GP1 core")
-    POWERPC_DEF("G2leGP3",       CPU_POWERPC_G2LEgp3,                G2L=
E,
+    POWERPC_DEF("g2legp3",       CPU_POWERPC_G2LEgp3,                G2L=
E,
                 "PowerPC G2LE GP3 core")
     /* PowerPC G2 microcontrollers                                      =
     */
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5121", "MPC5121",
+    POWERPC_DEF_SVR("mpc5121", "MPC5121",
                     CPU_POWERPC_MPC5121,      POWERPC_SVR_5121,      G2L=
E)
 #endif
-    POWERPC_DEF_SVR("MPC5200_v10", "MPC5200 v1.0",
+    POWERPC_DEF_SVR("mpc5200_v10", "MPC5200 v1.0",
                     CPU_POWERPC_MPC5200_v10,  POWERPC_SVR_5200_v10,  G2L=
E)
-    POWERPC_DEF_SVR("MPC5200_v11", "MPC5200 v1.1",
+    POWERPC_DEF_SVR("mpc5200_v11", "MPC5200 v1.1",
                     CPU_POWERPC_MPC5200_v11,  POWERPC_SVR_5200_v11,  G2L=
E)
-    POWERPC_DEF_SVR("MPC5200_v12", "MPC5200 v1.2",
+    POWERPC_DEF_SVR("mpc5200_v12", "MPC5200 v1.2",
                     CPU_POWERPC_MPC5200_v12,  POWERPC_SVR_5200_v12,  G2L=
E)
-    POWERPC_DEF_SVR("MPC5200B_v20", "MPC5200B v2.0",
+    POWERPC_DEF_SVR("mpc5200b_v20", "MPC5200B v2.0",
                     CPU_POWERPC_MPC5200B_v20, POWERPC_SVR_5200B_v20, G2L=
E)
-    POWERPC_DEF_SVR("MPC5200B_v21", "MPC5200B v2.1",
+    POWERPC_DEF_SVR("mpc5200b_v21", "MPC5200B v2.1",
                     CPU_POWERPC_MPC5200B_v21, POWERPC_SVR_5200B_v21, G2L=
E)
     /* e200 family                                                      =
     */
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC55xx", "Generic MPC55xx core",
+    POWERPC_DEF_SVR("mpc55xx", "Generic MPC55xx core",
                     CPU_POWERPC_MPC55xx,      POWERPC_SVR_55xx,      e20=
0)
 #endif
 #if defined(TODO)
@@ -484,91 +484,91 @@
                 "PowerPC e200z6 core")
     /* PowerPC e200 microcontrollers                                    =
     */
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5514E", "MPC5514E",
+    POWERPC_DEF_SVR("mpc5514e", "MPC5514E",
                     CPU_POWERPC_MPC5514E,     POWERPC_SVR_5514E,     e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5514E_v0", "MPC5514E v0",
+    POWERPC_DEF_SVR("mpc5514e_v0", "MPC5514E v0",
                     CPU_POWERPC_MPC5514E_v0,  POWERPC_SVR_5514E_v0,  e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5514E_v1", "MPC5514E v1",
+    POWERPC_DEF_SVR("mpc5514e_v1", "MPC5514E v1",
                     CPU_POWERPC_MPC5514E_v1,  POWERPC_SVR_5514E_v1,  e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5514G", "MPC5514G",
+    POWERPC_DEF_SVR("mpc5514g", "MPC5514G",
                     CPU_POWERPC_MPC5514G,     POWERPC_SVR_5514G,     e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5514G_v0", "MPC5514G v0",
+    POWERPC_DEF_SVR("mpc5514g_v0", "MPC5514G v0",
                     CPU_POWERPC_MPC5514G_v0,  POWERPC_SVR_5514G_v0,  e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5514G_v1", "MPC5514G v1",
+    POWERPC_DEF_SVR("mpc5514g_v1", "MPC5514G v1",
                     CPU_POWERPC_MPC5514G_v1,  POWERPC_SVR_5514G_v1,  e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5515S", "MPC5515S",
+    POWERPC_DEF_SVR("mpc5515s", "MPC5515S",
                     CPU_POWERPC_MPC5515S,     POWERPC_SVR_5515S,     e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5516E", "MPC5516E",
+    POWERPC_DEF_SVR("mpc5516e", "MPC5516E",
                     CPU_POWERPC_MPC5516E,     POWERPC_SVR_5516E,     e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5516E_v0", "MPC5516E v0",
+    POWERPC_DEF_SVR("mpc5516e_v0", "MPC5516E v0",
                     CPU_POWERPC_MPC5516E_v0,  POWERPC_SVR_5516E_v0,  e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5516E_v1", "MPC5516E v1",
+    POWERPC_DEF_SVR("mpc5516e_v1", "MPC5516E v1",
                     CPU_POWERPC_MPC5516E_v1,  POWERPC_SVR_5516E_v1,  e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5516G", "MPC5516G",
+    POWERPC_DEF_SVR("mpc5516g", "MPC5516G",
                     CPU_POWERPC_MPC5516G,     POWERPC_SVR_5516G,     e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5516G_v0", "MPC5516G v0",
+    POWERPC_DEF_SVR("mpc5516g_v0", "MPC5516G v0",
                     CPU_POWERPC_MPC5516G_v0,  POWERPC_SVR_5516G_v0,  e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5516G_v1", "MPC5516G v1",
+    POWERPC_DEF_SVR("mpc5516g_v1", "MPC5516G v1",
                     CPU_POWERPC_MPC5516G_v1,  POWERPC_SVR_5516G_v1,  e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5516S", "MPC5516S",
+    POWERPC_DEF_SVR("mpc5516s", "MPC5516S",
                     CPU_POWERPC_MPC5516S,     POWERPC_SVR_5516S,     e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5533", "MPC5533",
+    POWERPC_DEF_SVR("mpc5533", "MPC5533",
                     CPU_POWERPC_MPC5533,      POWERPC_SVR_5533,      e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5534", "MPC5534",
+    POWERPC_DEF_SVR("mpc5534", "MPC5534",
                     CPU_POWERPC_MPC5534,      POWERPC_SVR_5534,      e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5553", "MPC5553",
+    POWERPC_DEF_SVR("mpc5553", "MPC5553",
                     CPU_POWERPC_MPC5553,      POWERPC_SVR_5553,      e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5554", "MPC5554",
+    POWERPC_DEF_SVR("mpc5554", "MPC5554",
                     CPU_POWERPC_MPC5554,      POWERPC_SVR_5554,      e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5561", "MPC5561",
+    POWERPC_DEF_SVR("mpc5561", "MPC5561",
                     CPU_POWERPC_MPC5561,      POWERPC_SVR_5561,      e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5565", "MPC5565",
+    POWERPC_DEF_SVR("mpc5565", "MPC5565",
                     CPU_POWERPC_MPC5565,      POWERPC_SVR_5565,      e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5566", "MPC5566",
+    POWERPC_DEF_SVR("mpc5566", "MPC5566",
                     CPU_POWERPC_MPC5566,      POWERPC_SVR_5566,      e20=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC5567", "MPC5567",
+    POWERPC_DEF_SVR("mpc5567", "MPC5567",
                     CPU_POWERPC_MPC5567,      POWERPC_SVR_5567,      e20=
0)
 #endif
     /* e300 family                                                      =
     */
@@ -582,96 +582,96 @@
                 "PowerPC e300c4 core")
     /* PowerPC e300 microcontrollers                                    =
     */
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC8313", "MPC8313",
+    POWERPC_DEF_SVR("mpc8313", "MPC8313",
                     CPU_POWERPC_MPC831x,      POWERPC_SVR_8313,      e30=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC8313E", "MPC8313E",
+    POWERPC_DEF_SVR("mpc8313e", "MPC8313E",
                     CPU_POWERPC_MPC831x,      POWERPC_SVR_8313E,     e30=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC8314", "MPC8314",
+    POWERPC_DEF_SVR("mpc8314", "MPC8314",
                     CPU_POWERPC_MPC831x,      POWERPC_SVR_8314,      e30=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC8314E", "MPC8314E",
+    POWERPC_DEF_SVR("mpc8314e", "MPC8314E",
                     CPU_POWERPC_MPC831x,      POWERPC_SVR_8314E,     e30=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC8315", "MPC8315",
+    POWERPC_DEF_SVR("mpc8315", "MPC8315",
                     CPU_POWERPC_MPC831x,      POWERPC_SVR_8315,      e30=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC8315E", "MPC8315E",
+    POWERPC_DEF_SVR("mpc8315e", "MPC8315E",
                     CPU_POWERPC_MPC831x,      POWERPC_SVR_8315E,     e30=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC8321", "MPC8321",
+    POWERPC_DEF_SVR("mpc8321", "MPC8321",
                     CPU_POWERPC_MPC832x,      POWERPC_SVR_8321,      e30=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC8321E", "MPC8321E",
+    POWERPC_DEF_SVR("mpc8321e", "MPC8321E",
                     CPU_POWERPC_MPC832x,      POWERPC_SVR_8321E,     e30=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC8323", "MPC8323",
+    POWERPC_DEF_SVR("mpc8323", "MPC8323",
                     CPU_POWERPC_MPC832x,      POWERPC_SVR_8323,      e30=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC8323E", "MPC8323E",
+    POWERPC_DEF_SVR("mpc8323e", "MPC8323E",
                     CPU_POWERPC_MPC832x,      POWERPC_SVR_8323E,     e30=
0)
 #endif
-    POWERPC_DEF_SVR("MPC8343", "MPC8343",
+    POWERPC_DEF_SVR("mpc8343", "MPC8343",
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8343,      e30=
0)
-    POWERPC_DEF_SVR("MPC8343A", "MPC8343A",
+    POWERPC_DEF_SVR("mpc8343a", "MPC8343A",
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8343A,     e30=
0)
-    POWERPC_DEF_SVR("MPC8343E", "MPC8343E",
+    POWERPC_DEF_SVR("mpc8343e", "MPC8343E",
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8343E,     e30=
0)
-    POWERPC_DEF_SVR("MPC8343EA", "MPC8343EA",
+    POWERPC_DEF_SVR("mpc8343ea", "MPC8343EA",
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8343EA,    e30=
0)
-    POWERPC_DEF_SVR("MPC8347T", "MPC8347T",
+    POWERPC_DEF_SVR("mpc8347t", "MPC8347T",
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8347T,     e30=
0)
-    POWERPC_DEF_SVR("MPC8347P", "MPC8347P",
+    POWERPC_DEF_SVR("mpc8347p", "MPC8347P",
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8347P,     e30=
0)
-    POWERPC_DEF_SVR("MPC8347AT", "MPC8347AT",
+    POWERPC_DEF_SVR("mpc8347at", "MPC8347AT",
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8347AT,    e30=
0)
-    POWERPC_DEF_SVR("MPC8347AP", "MPC8347AP",
+    POWERPC_DEF_SVR("mpc8347ap", "MPC8347AP",
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8347AP,    e30=
0)
-    POWERPC_DEF_SVR("MPC8347ET", "MPC8347ET",
+    POWERPC_DEF_SVR("mpc8347et", "MPC8347ET",
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8347ET,    e30=
0)
-    POWERPC_DEF_SVR("MPC8347EP", "MPC8343EP",
+    POWERPC_DEF_SVR("mpc8347ep", "MPC8343EP",
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8347EP,    e30=
0)
-    POWERPC_DEF_SVR("MPC8347EAT", "MPC8347EAT",
+    POWERPC_DEF_SVR("mpc8347eat", "MPC8347EAT",
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8347EAT,   e30=
0)
-    POWERPC_DEF_SVR("MPC8347EAP", "MPC8343EAP",
+    POWERPC_DEF_SVR("mpc8347eap", "MPC8343EAP",
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8347EAP,   e30=
0)
-    POWERPC_DEF_SVR("MPC8349", "MPC8349",
+    POWERPC_DEF_SVR("mpc8349", "MPC8349",
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8349,      e30=
0)
-    POWERPC_DEF_SVR("MPC8349A", "MPC8349A",
+    POWERPC_DEF_SVR("mpc8349a", "MPC8349A",
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8349A,     e30=
0)
-    POWERPC_DEF_SVR("MPC8349E", "MPC8349E",
+    POWERPC_DEF_SVR("mpc8349e", "MPC8349E",
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8349E,     e30=
0)
-    POWERPC_DEF_SVR("MPC8349EA", "MPC8349EA",
+    POWERPC_DEF_SVR("mpc8349ea", "MPC8349EA",
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8349EA,    e30=
0)
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC8358E", "MPC8358E",
+    POWERPC_DEF_SVR("mpc8358e", "MPC8358E",
                     CPU_POWERPC_MPC835x,      POWERPC_SVR_8358E,     e30=
0)
 #endif
 #if defined(TODO)
-    POWERPC_DEF_SVR("MPC8360E", "MPC8360E",
+    POWERPC_DEF_SVR("mpc8360e", "MPC8360E",
                     CPU_POWERPC_MPC836x,      POWERPC_SVR_8360E,     e30=
0)
 #endif
-    POWERPC_DEF_SVR("MPC8377", "MPC8377",
+    POWERPC_DEF_SVR("mpc8377", "MPC8377",
                     CPU_POWERPC_MPC837x,      POWERPC_SVR_8377,      e30=
0)
-    POWERPC_DEF_SVR("MPC8377E", "MPC8377E",
+    POWERPC_DEF_SVR("mpc8377e", "MPC8377E",
                     CPU_POWERPC_MPC837x,      POWERPC_SVR_8377E,     e30=
0)
-    POWERPC_DEF_SVR("MPC8378", "MPC8378",
+    POWERPC_DEF_SVR("mpc8378", "MPC8378",
                     CPU_POWERPC_MPC837x,      POWERPC_SVR_8378,      e30=
0)
-    POWERPC_DEF_SVR("MPC8378E", "MPC8378E",
+    POWERPC_DEF_SVR("mpc8378e", "MPC8378E",
                     CPU_POWERPC_MPC837x,      POWERPC_SVR_8378E,     e30=
0)
-    POWERPC_DEF_SVR("MPC8379", "MPC8379",
+    POWERPC_DEF_SVR("mpc8379", "MPC8379",
                     CPU_POWERPC_MPC837x,      POWERPC_SVR_8379,      e30=
0)
-    POWERPC_DEF_SVR("MPC8379E", "MPC8379E",
+    POWERPC_DEF_SVR("mpc8379e", "MPC8379E",
                     CPU_POWERPC_MPC837x,      POWERPC_SVR_8379E,     e30=
0)
     /* e500 family                                                      =
     */
     POWERPC_DEF_SVR("e500_v10", "PowerPC e500 v1.0 core",
@@ -697,115 +697,115 @@
                     CPU_POWERPC_e6500,        POWERPC_SVR_E500,      e65=
00)
 #endif
     /* PowerPC e500 microcontrollers                                    =
     */
-    POWERPC_DEF_SVR("MPC8533_v10", "MPC8533 v1.0",
+    POWERPC_DEF_SVR("mpc8533_v10", "MPC8533 v1.0",
                     CPU_POWERPC_MPC8533_v10,  POWERPC_SVR_8533_v10,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8533_v11", "MPC8533 v1.1",
+    POWERPC_DEF_SVR("mpc8533_v11", "MPC8533 v1.1",
                     CPU_POWERPC_MPC8533_v11,  POWERPC_SVR_8533_v11,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8533E_v10", "MPC8533E v1.0",
+    POWERPC_DEF_SVR("mpc8533e_v10", "MPC8533E v1.0",
                     CPU_POWERPC_MPC8533E_v10, POWERPC_SVR_8533E_v10, e50=
0v2)
-    POWERPC_DEF_SVR("MPC8533E_v11", "MPC8533E v1.1",
+    POWERPC_DEF_SVR("mpc8533e_v11", "MPC8533E v1.1",
                     CPU_POWERPC_MPC8533E_v11, POWERPC_SVR_8533E_v11, e50=
0v2)
-    POWERPC_DEF_SVR("MPC8540_v10", "MPC8540 v1.0",
+    POWERPC_DEF_SVR("mpc8540_v10", "MPC8540 v1.0",
                     CPU_POWERPC_MPC8540_v10,  POWERPC_SVR_8540_v10,  e50=
0v1)
-    POWERPC_DEF_SVR("MPC8540_v20", "MPC8540 v2.0",
+    POWERPC_DEF_SVR("mpc8540_v20", "MPC8540 v2.0",
                     CPU_POWERPC_MPC8540_v20,  POWERPC_SVR_8540_v20,  e50=
0v1)
-    POWERPC_DEF_SVR("MPC8540_v21", "MPC8540 v2.1",
+    POWERPC_DEF_SVR("mpc8540_v21", "MPC8540 v2.1",
                     CPU_POWERPC_MPC8540_v21,  POWERPC_SVR_8540_v21,  e50=
0v1)
-    POWERPC_DEF_SVR("MPC8541_v10", "MPC8541 v1.0",
+    POWERPC_DEF_SVR("mpc8541_v10", "MPC8541 v1.0",
                     CPU_POWERPC_MPC8541_v10,  POWERPC_SVR_8541_v10,  e50=
0v1)
-    POWERPC_DEF_SVR("MPC8541_v11", "MPC8541 v1.1",
+    POWERPC_DEF_SVR("mpc8541_v11", "MPC8541 v1.1",
                     CPU_POWERPC_MPC8541_v11,  POWERPC_SVR_8541_v11,  e50=
0v1)
-    POWERPC_DEF_SVR("MPC8541E_v10", "MPC8541E v1.0",
+    POWERPC_DEF_SVR("mpc8541e_v10", "MPC8541E v1.0",
                     CPU_POWERPC_MPC8541E_v10, POWERPC_SVR_8541E_v10, e50=
0v1)
-    POWERPC_DEF_SVR("MPC8541E_v11", "MPC8541E v1.1",
+    POWERPC_DEF_SVR("mpc8541e_v11", "MPC8541E v1.1",
                     CPU_POWERPC_MPC8541E_v11, POWERPC_SVR_8541E_v11, e50=
0v1)
-    POWERPC_DEF_SVR("MPC8543_v10", "MPC8543 v1.0",
+    POWERPC_DEF_SVR("mpc8543_v10", "MPC8543 v1.0",
                     CPU_POWERPC_MPC8543_v10,  POWERPC_SVR_8543_v10,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8543_v11", "MPC8543 v1.1",
+    POWERPC_DEF_SVR("mpc8543_v11", "MPC8543 v1.1",
                     CPU_POWERPC_MPC8543_v11,  POWERPC_SVR_8543_v11,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8543_v20", "MPC8543 v2.0",
+    POWERPC_DEF_SVR("mpc8543_v20", "MPC8543 v2.0",
                     CPU_POWERPC_MPC8543_v20,  POWERPC_SVR_8543_v20,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8543_v21", "MPC8543 v2.1",
+    POWERPC_DEF_SVR("mpc8543_v21", "MPC8543 v2.1",
                     CPU_POWERPC_MPC8543_v21,  POWERPC_SVR_8543_v21,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8543E_v10", "MPC8543E v1.0",
+    POWERPC_DEF_SVR("mpc8543e_v10", "MPC8543E v1.0",
                     CPU_POWERPC_MPC8543E_v10, POWERPC_SVR_8543E_v10, e50=
0v2)
-    POWERPC_DEF_SVR("MPC8543E_v11", "MPC8543E v1.1",
+    POWERPC_DEF_SVR("mpc8543e_v11", "MPC8543E v1.1",
                     CPU_POWERPC_MPC8543E_v11, POWERPC_SVR_8543E_v11, e50=
0v2)
-    POWERPC_DEF_SVR("MPC8543E_v20", "MPC8543E v2.0",
+    POWERPC_DEF_SVR("mpc8543e_v20", "MPC8543E v2.0",
                     CPU_POWERPC_MPC8543E_v20, POWERPC_SVR_8543E_v20, e50=
0v2)
-    POWERPC_DEF_SVR("MPC8543E_v21", "MPC8543E v2.1",
+    POWERPC_DEF_SVR("mpc8543e_v21", "MPC8543E v2.1",
                     CPU_POWERPC_MPC8543E_v21, POWERPC_SVR_8543E_v21, e50=
0v2)
-    POWERPC_DEF_SVR("MPC8544_v10", "MPC8544 v1.0",
+    POWERPC_DEF_SVR("mpc8544_v10", "MPC8544 v1.0",
                     CPU_POWERPC_MPC8544_v10,  POWERPC_SVR_8544_v10,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8544_v11", "MPC8544 v1.1",
+    POWERPC_DEF_SVR("mpc8544_v11", "MPC8544 v1.1",
                     CPU_POWERPC_MPC8544_v11,  POWERPC_SVR_8544_v11,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8544E_v10", "MPC8544E v1.0",
+    POWERPC_DEF_SVR("mpc8544e_v10", "MPC8544E v1.0",
                     CPU_POWERPC_MPC8544E_v10, POWERPC_SVR_8544E_v10, e50=
0v2)
-    POWERPC_DEF_SVR("MPC8544E_v11", "MPC8544E v1.1",
+    POWERPC_DEF_SVR("mpc8544e_v11", "MPC8544E v1.1",
                     CPU_POWERPC_MPC8544E_v11, POWERPC_SVR_8544E_v11, e50=
0v2)
-    POWERPC_DEF_SVR("MPC8545_v20", "MPC8545 v2.0",
+    POWERPC_DEF_SVR("mpc8545_v20", "MPC8545 v2.0",
                     CPU_POWERPC_MPC8545_v20,  POWERPC_SVR_8545_v20,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8545_v21", "MPC8545 v2.1",
+    POWERPC_DEF_SVR("mpc8545_v21", "MPC8545 v2.1",
                     CPU_POWERPC_MPC8545_v21,  POWERPC_SVR_8545_v21,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8545E_v20", "MPC8545E v2.0",
+    POWERPC_DEF_SVR("mpc8545e_v20", "MPC8545E v2.0",
                     CPU_POWERPC_MPC8545E_v20, POWERPC_SVR_8545E_v20, e50=
0v2)
-    POWERPC_DEF_SVR("MPC8545E_v21", "MPC8545E v2.1",
+    POWERPC_DEF_SVR("mpc8545e_v21", "MPC8545E v2.1",
                     CPU_POWERPC_MPC8545E_v21, POWERPC_SVR_8545E_v21, e50=
0v2)
-    POWERPC_DEF_SVR("MPC8547E_v20", "MPC8547E v2.0",
+    POWERPC_DEF_SVR("mpc8547e_v20", "MPC8547E v2.0",
                     CPU_POWERPC_MPC8547E_v20, POWERPC_SVR_8547E_v20, e50=
0v2)
-    POWERPC_DEF_SVR("MPC8547E_v21", "MPC8547E v2.1",
+    POWERPC_DEF_SVR("mpc8547e_v21", "MPC8547E v2.1",
                     CPU_POWERPC_MPC8547E_v21, POWERPC_SVR_8547E_v21, e50=
0v2)
-    POWERPC_DEF_SVR("MPC8548_v10", "MPC8548 v1.0",
+    POWERPC_DEF_SVR("mpc8548_v10", "MPC8548 v1.0",
                     CPU_POWERPC_MPC8548_v10,  POWERPC_SVR_8548_v10,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8548_v11", "MPC8548 v1.1",
+    POWERPC_DEF_SVR("mpc8548_v11", "MPC8548 v1.1",
                     CPU_POWERPC_MPC8548_v11,  POWERPC_SVR_8548_v11,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8548_v20", "MPC8548 v2.0",
+    POWERPC_DEF_SVR("mpc8548_v20", "MPC8548 v2.0",
                     CPU_POWERPC_MPC8548_v20,  POWERPC_SVR_8548_v20,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8548_v21", "MPC8548 v2.1",
+    POWERPC_DEF_SVR("mpc8548_v21", "MPC8548 v2.1",
                     CPU_POWERPC_MPC8548_v21,  POWERPC_SVR_8548_v21,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8548E_v10", "MPC8548E v1.0",
+    POWERPC_DEF_SVR("mpc8548e_v10", "MPC8548E v1.0",
                     CPU_POWERPC_MPC8548E_v10, POWERPC_SVR_8548E_v10, e50=
0v2)
-    POWERPC_DEF_SVR("MPC8548E_v11", "MPC8548E v1.1",
+    POWERPC_DEF_SVR("mpc8548e_v11", "MPC8548E v1.1",
                     CPU_POWERPC_MPC8548E_v11, POWERPC_SVR_8548E_v11, e50=
0v2)
-    POWERPC_DEF_SVR("MPC8548E_v20", "MPC8548E v2.0",
+    POWERPC_DEF_SVR("mpc8548e_v20", "MPC8548E v2.0",
                     CPU_POWERPC_MPC8548E_v20, POWERPC_SVR_8548E_v20, e50=
0v2)
-    POWERPC_DEF_SVR("MPC8548E_v21", "MPC8548E v2.1",
+    POWERPC_DEF_SVR("mpc8548e_v21", "MPC8548E v2.1",
                     CPU_POWERPC_MPC8548E_v21, POWERPC_SVR_8548E_v21, e50=
0v2)
-    POWERPC_DEF_SVR("MPC8555_v10", "MPC8555 v1.0",
+    POWERPC_DEF_SVR("mpc8555_v10", "MPC8555 v1.0",
                     CPU_POWERPC_MPC8555_v10,  POWERPC_SVR_8555_v10,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8555_v11", "MPC8555 v1.1",
+    POWERPC_DEF_SVR("mpc8555_v11", "MPC8555 v1.1",
                     CPU_POWERPC_MPC8555_v11,  POWERPC_SVR_8555_v11,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8555E_v10", "MPC8555E v1.0",
+    POWERPC_DEF_SVR("mpc8555e_v10", "MPC8555E v1.0",
                     CPU_POWERPC_MPC8555E_v10, POWERPC_SVR_8555E_v10, e50=
0v2)
-    POWERPC_DEF_SVR("MPC8555E_v11", "MPC8555E v1.1",
+    POWERPC_DEF_SVR("mpc8555e_v11", "MPC8555E v1.1",
                     CPU_POWERPC_MPC8555E_v11, POWERPC_SVR_8555E_v11, e50=
0v2)
-    POWERPC_DEF_SVR("MPC8560_v10", "MPC8560 v1.0",
+    POWERPC_DEF_SVR("mpc8560_v10", "MPC8560 v1.0",
                     CPU_POWERPC_MPC8560_v10,  POWERPC_SVR_8560_v10,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8560_v20", "MPC8560 v2.0",
+    POWERPC_DEF_SVR("mpc8560_v20", "MPC8560 v2.0",
                     CPU_POWERPC_MPC8560_v20,  POWERPC_SVR_8560_v20,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8560_v21", "MPC8560 v2.1",
+    POWERPC_DEF_SVR("mpc8560_v21", "MPC8560 v2.1",
                     CPU_POWERPC_MPC8560_v21,  POWERPC_SVR_8560_v21,  e50=
0v2)
-    POWERPC_DEF_SVR("MPC8567", "MPC8567",
+    POWERPC_DEF_SVR("mpc8567", "MPC8567",
                     CPU_POWERPC_MPC8567,      POWERPC_SVR_8567,      e50=
0v2)
-    POWERPC_DEF_SVR("MPC8567E", "MPC8567E",
+    POWERPC_DEF_SVR("mpc8567e", "MPC8567E",
                     CPU_POWERPC_MPC8567E,     POWERPC_SVR_8567E,     e50=
0v2)
-    POWERPC_DEF_SVR("MPC8568", "MPC8568",
+    POWERPC_DEF_SVR("mpc8568", "MPC8568",
                     CPU_POWERPC_MPC8568,      POWERPC_SVR_8568,      e50=
0v2)
-    POWERPC_DEF_SVR("MPC8568E", "MPC8568E",
+    POWERPC_DEF_SVR("mpc8568e", "MPC8568E",
                     CPU_POWERPC_MPC8568E,     POWERPC_SVR_8568E,     e50=
0v2)
-    POWERPC_DEF_SVR("MPC8572", "MPC8572",
+    POWERPC_DEF_SVR("mpc8572", "MPC8572",
                     CPU_POWERPC_MPC8572,      POWERPC_SVR_8572,      e50=
0v2)
-    POWERPC_DEF_SVR("MPC8572E", "MPC8572E",
+    POWERPC_DEF_SVR("mpc8572e", "MPC8572E",
                     CPU_POWERPC_MPC8572E,     POWERPC_SVR_8572E,     e50=
0v2)
     /* e600 family                                                      =
     */
     POWERPC_DEF("e600",          CPU_POWERPC_e600,                   e60=
0,
                 "PowerPC e600 core")
     /* PowerPC e600 microcontrollers                                    =
     */
-    POWERPC_DEF_SVR("MPC8610", "MPC8610",
+    POWERPC_DEF_SVR("mpc8610", "MPC8610",
                     CPU_POWERPC_MPC8610,      POWERPC_SVR_8610,      e60=
0)
-    POWERPC_DEF_SVR("MPC8641", "MPC8641",
+    POWERPC_DEF_SVR("mpc8641", "MPC8641",
                     CPU_POWERPC_MPC8641,      POWERPC_SVR_8641,      e60=
0)
-    POWERPC_DEF_SVR("MPC8641D", "MPC8641D",
+    POWERPC_DEF_SVR("mpc8641d", "MPC8641D",
                     CPU_POWERPC_MPC8641D,     POWERPC_SVR_8641D,     e60=
0)
     /* 32 bits "classic" PowerPC                                        =
     */
     /* PowerPC 6xx family                                               =
     */
@@ -1091,17 +1091,17 @@
                 "PowerPC 7457 v1.1 (G4)")
     POWERPC_DEF("7457_v1.2",     CPU_POWERPC_74x7_v12,               745=
5,
                 "PowerPC 7457 v1.2 (G4)")
-    POWERPC_DEF("7447A_v1.0",    CPU_POWERPC_74x7A_v10,              744=
5,
+    POWERPC_DEF("7447a_v1.0",    CPU_POWERPC_74x7A_v10,              744=
5,
                 "PowerPC 7447A v1.0 (G4)")
-    POWERPC_DEF("7457A_v1.0",    CPU_POWERPC_74x7A_v10,              745=
5,
+    POWERPC_DEF("7457a_v1.0",    CPU_POWERPC_74x7A_v10,              745=
5,
                 "PowerPC 7457A v1.0 (G4)")
-    POWERPC_DEF("7447A_v1.1",    CPU_POWERPC_74x7A_v11,              744=
5,
+    POWERPC_DEF("7447a_v1.1",    CPU_POWERPC_74x7A_v11,              744=
5,
                 "PowerPC 7447A v1.1 (G4)")
-    POWERPC_DEF("7457A_v1.1",    CPU_POWERPC_74x7A_v11,              745=
5,
+    POWERPC_DEF("7457a_v1.1",    CPU_POWERPC_74x7A_v11,              745=
5,
                 "PowerPC 7457A v1.1 (G4)")
-    POWERPC_DEF("7447A_v1.2",    CPU_POWERPC_74x7A_v12,              744=
5,
+    POWERPC_DEF("7447a_v1.2",    CPU_POWERPC_74x7A_v12,              744=
5,
                 "PowerPC 7447A v1.2 (G4)")
-    POWERPC_DEF("7457A_v1.2",    CPU_POWERPC_74x7A_v12,              745=
5,
+    POWERPC_DEF("7457a_v1.2",    CPU_POWERPC_74x7A_v12,              745=
5,
                 "PowerPC 7457A v1.2 (G4)")
     /* 64 bits PowerPC                                                  =
     */
 #if defined (TARGET_PPC64)
@@ -1116,37 +1116,37 @@
                 "PowerPC 631 (Power 3+)")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("POWER4",        CPU_POWERPC_POWER4,                 POW=
ER4,
+    POWERPC_DEF("power4",        CPU_POWERPC_POWER4,                 POW=
ER4,
                 "POWER4")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("POWER4+",       CPU_POWERPC_POWER4P,                POW=
ER4P,
+    POWERPC_DEF("power4+",       CPU_POWERPC_POWER4P,                POW=
ER4P,
                 "POWER4p")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("POWER5",        CPU_POWERPC_POWER5,                 POW=
ER5,
+    POWERPC_DEF("power5",        CPU_POWERPC_POWER5,                 POW=
ER5,
                 "POWER5")
 #endif
-    POWERPC_DEF("POWER5+_v2.1",  CPU_POWERPC_POWER5P_v21,            POW=
ER5P,
+    POWERPC_DEF("power5+_v2.1",  CPU_POWERPC_POWER5P_v21,            POW=
ER5P,
                 "POWER5+ v2.1")
 #if defined(TODO)
-    POWERPC_DEF("POWER6",        CPU_POWERPC_POWER6,                 POW=
ER6,
+    POWERPC_DEF("power6",        CPU_POWERPC_POWER6,                 POW=
ER6,
                 "POWER6")
 #endif
-    POWERPC_DEF("POWER7_v2.3",   CPU_POWERPC_POWER7_v23,             POW=
ER7,
+    POWERPC_DEF("power7_v2.3",   CPU_POWERPC_POWER7_v23,             POW=
ER7,
                 "POWER7 v2.3")
-    POWERPC_DEF("POWER7+_v2.1",  CPU_POWERPC_POWER7P_v21,            POW=
ER7,
+    POWERPC_DEF("power7+_v2.1",  CPU_POWERPC_POWER7P_v21,            POW=
ER7,
                 "POWER7+ v2.1")
-    POWERPC_DEF("POWER8E_v2.1",  CPU_POWERPC_POWER8E_v21,            POW=
ER8,
+    POWERPC_DEF("power8e_v2.1",  CPU_POWERPC_POWER8E_v21,            POW=
ER8,
                 "POWER8E v2.1")
-    POWERPC_DEF("POWER8_v2.0",   CPU_POWERPC_POWER8_v20,             POW=
ER8,
+    POWERPC_DEF("power8_v2.0",   CPU_POWERPC_POWER8_v20,             POW=
ER8,
                 "POWER8 v2.0")
-    POWERPC_DEF("POWER8NVL_v1.0",CPU_POWERPC_POWER8NVL_v10,          POW=
ER8,
+    POWERPC_DEF("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10,         POW=
ER8,
                 "POWER8NVL v1.0")
     POWERPC_DEF("970_v2.2",      CPU_POWERPC_970_v22,                970=
,
                 "PowerPC 970 v2.2")
=20
-    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_BASE,            POW=
ER9,
+    POWERPC_DEF("power9_v1.0",   CPU_POWERPC_POWER9_BASE,            POW=
ER9,
                 "POWER9 v1.0")
=20
     POWERPC_DEF("970fx_v1.0",    CPU_POWERPC_970FX_v10,              970=
,
@@ -1164,27 +1164,27 @@
     POWERPC_DEF("970mp_v1.1",    CPU_POWERPC_970MP_v11,              970=
,
                 "PowerPC 970MP v1.1")
 #if defined(TODO)
-    POWERPC_DEF("Cell",          CPU_POWERPC_CELL,                   970=
,
+    POWERPC_DEF("cell",          CPU_POWERPC_CELL,                   970=
,
                 "PowerPC Cell")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("Cell_v1.0",     CPU_POWERPC_CELL_v10,               970=
,
+    POWERPC_DEF("cell_v1.0",     CPU_POWERPC_CELL_v10,               970=
,
                 "PowerPC Cell v1.0")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("Cell_v2.0",     CPU_POWERPC_CELL_v20,               970=
,
+    POWERPC_DEF("cell_v2.0",     CPU_POWERPC_CELL_v20,               970=
,
                 "PowerPC Cell v2.0")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("Cell_v3.0",     CPU_POWERPC_CELL_v30,               970=
,
+    POWERPC_DEF("cell_v3.0",     CPU_POWERPC_CELL_v30,               970=
,
                 "PowerPC Cell v3.0")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("Cell_v3.1",     CPU_POWERPC_CELL_v31,               970=
,
+    POWERPC_DEF("cell_v3.1",     CPU_POWERPC_CELL_v31,               970=
,
                 "PowerPC Cell v3.1")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("Cell_v3.2",     CPU_POWERPC_CELL_v32,               970=
,
+    POWERPC_DEF("cell_v3.2",     CPU_POWERPC_CELL_v32,               970=
,
                 "PowerPC Cell v3.2")
 #endif
 #if defined(TODO)
@@ -1192,34 +1192,34 @@
      * and the PowerPC 64 one.
      */
     /* What about A10 & A30 ? */
-    POWERPC_DEF("RS64",          CPU_POWERPC_RS64,                   RS6=
4,
+    POWERPC_DEF("rs64",          CPU_POWERPC_RS64,                   RS6=
4,
                 "RS64 (Apache/A35)")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("RS64-II",       CPU_POWERPC_RS64II,                 RS6=
4,
+    POWERPC_DEF("rs64-ii",       CPU_POWERPC_RS64II,                 RS6=
4,
                 "RS64-II (NorthStar/A50)")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("RS64-III",      CPU_POWERPC_RS64III,                RS6=
4,
+    POWERPC_DEF("rs64-iii",      CPU_POWERPC_RS64III,                RS6=
4,
                 "RS64-III (Pulsar)")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("RS64-IV",       CPU_POWERPC_RS64IV,                 RS6=
4,
+    POWERPC_DEF("rs64-iv",       CPU_POWERPC_RS64IV,                 RS6=
4,
                 "RS64-IV (IceStar/IStar/SStar)")
 #endif
 #endif /* defined (TARGET_PPC64) */
     /* POWER                                                            =
     */
 #if defined(TODO)
-    POWERPC_DEF("POWER",         CPU_POWERPC_POWER,                  POW=
ER,
+    POWERPC_DEF("power",         CPU_POWERPC_POWER,                  POW=
ER,
                 "Original POWER")
 #endif
 #if defined(TODO)
-    POWERPC_DEF("POWER2",        CPU_POWERPC_POWER2,                 POW=
ER,
+    POWERPC_DEF("power2",        CPU_POWERPC_POWER2,                 POW=
ER,
                 "POWER2")
 #endif
     /* PA semi cores                                                    =
     */
 #if defined(TODO)
-    POWERPC_DEF("PA6T",          CPU_POWERPC_PA6T,                   PA6=
T,
+    POWERPC_DEF("pa6t",          CPU_POWERPC_PA6T,                   PA6=
T,
                 "PA PA6T")
 #endif
=20
@@ -1228,172 +1228,172 @@
 /* PowerPC CPU aliases                                                  =
   */
=20
 PowerPCCPUAlias ppc_cpu_aliases[] =3D {
-    { "403", "403GC" },
-    { "405", "405D4" },
-    { "405CR", "405CRc" },
-    { "405GP", "405GPd" },
-    { "405GPe", "405CRc" },
+    { "403", "403gc" },
+    { "405", "405d4" },
+    { "405cr", "405crc" },
+    { "405gp", "405gpd" },
+    { "405gpe", "405crc" },
     { "x2vp7", "x2vp4" },
     { "x2vp50", "x2vp20" },
=20
-    { "440EP", "440EPb" },
-    { "440GP", "440GPc" },
-    { "440GR", "440GRa" },
-    { "440GX", "440GXf" },
+    { "440ep", "440epb" },
+    { "440gp", "440gpc" },
+    { "440gr", "440gra" },
+    { "440gx", "440gxf" },
=20
-    { "RCPU", "MPC5xx" },
+    { "rcpu", "mpc5xx" },
     /* MPC5xx microcontrollers */
-    { "MGT560", "MPC5xx" },
-    { "MPC509", "MPC5xx" },
-    { "MPC533", "MPC5xx" },
-    { "MPC534", "MPC5xx" },
-    { "MPC555", "MPC5xx" },
-    { "MPC556", "MPC5xx" },
-    { "MPC560", "MPC5xx" },
-    { "MPC561", "MPC5xx" },
-    { "MPC562", "MPC5xx" },
-    { "MPC563", "MPC5xx" },
-    { "MPC564", "MPC5xx" },
-    { "MPC565", "MPC5xx" },
-    { "MPC566", "MPC5xx" },
+    { "mgt560", "mpc5xx" },
+    { "mpc509", "mpc5xx" },
+    { "mpc533", "mpc5xx" },
+    { "mpc534", "mpc5xx" },
+    { "mpc555", "mpc5xx" },
+    { "mpc556", "mpc5xx" },
+    { "mpc560", "mpc5xx" },
+    { "mpc561", "mpc5xx" },
+    { "mpc562", "mpc5xx" },
+    { "mpc563", "mpc5xx" },
+    { "mpc564", "mpc5xx" },
+    { "mpc565", "mpc5xx" },
+    { "mpc566", "mpc5xx" },
=20
-    { "PowerQUICC", "MPC8xx" },
+    { "powerquicc", "mpc8xx" },
     /* MPC8xx microcontrollers */
-    { "MGT823", "MPC8xx" },
-    { "MPC821", "MPC8xx" },
-    { "MPC823", "MPC8xx" },
-    { "MPC850", "MPC8xx" },
-    { "MPC852T", "MPC8xx" },
-    { "MPC855T", "MPC8xx" },
-    { "MPC857", "MPC8xx" },
-    { "MPC859", "MPC8xx" },
-    { "MPC860", "MPC8xx" },
-    { "MPC862", "MPC8xx" },
-    { "MPC866", "MPC8xx" },
-    { "MPC870", "MPC8xx" },
-    { "MPC875", "MPC8xx" },
-    { "MPC880", "MPC8xx" },
-    { "MPC885", "MPC8xx" },
+    { "mgt823", "mpc8xx" },
+    { "mpc821", "mpc8xx" },
+    { "mpc823", "mpc8xx" },
+    { "mpc850", "mpc8xx" },
+    { "mpc852t", "mpc8xx" },
+    { "mpc855t", "mpc8xx" },
+    { "mpc857", "mpc8xx" },
+    { "mpc859", "mpc8xx" },
+    { "mpc860", "mpc8xx" },
+    { "mpc862", "mpc8xx" },
+    { "mpc866", "mpc8xx" },
+    { "mpc870", "mpc8xx" },
+    { "mpc875", "mpc8xx" },
+    { "mpc880", "mpc8xx" },
+    { "mpc885", "mpc8xx" },
=20
     /* PowerPC MPC603 microcontrollers */
-    { "MPC8240", "603" },
+    { "mpc8240", "603" },
=20
-    { "MPC52xx", "MPC5200" },
-    { "MPC5200", "MPC5200_v12" },
-    { "MPC5200B", "MPC5200B_v21" },
+    { "mpc52xx", "mpc5200" },
+    { "mpc5200", "mpc5200_v12" },
+    { "mpc5200b", "mpc5200b_v21" },
=20
-    { "MPC82xx", "MPC8280" },
-    { "PowerQUICC-II", "MPC82xx" },
-    { "MPC8241", "G2HiP4" },
-    { "MPC8245", "G2HiP4" },
-    { "MPC8247", "G2leGP3" },
-    { "MPC8248", "G2leGP3" },
-    { "MPC8250", "MPC8250_HiP4" },
-    { "MPC8250_HiP3", "G2HiP3" },
-    { "MPC8250_HiP4", "G2HiP4" },
-    { "MPC8255", "MPC8255_HiP4" },
-    { "MPC8255_HiP3", "G2HiP3" },
-    { "MPC8255_HiP4", "G2HiP4" },
-    { "MPC8260", "MPC8260_HiP4" },
-    { "MPC8260_HiP3", "G2HiP3" },
-    { "MPC8260_HiP4", "G2HiP4" },
-    { "MPC8264", "MPC8264_HiP4" },
-    { "MPC8264_HiP3", "G2HiP3" },
-    { "MPC8264_HiP4", "G2HiP4" },
-    { "MPC8265", "MPC8265_HiP4" },
-    { "MPC8265_HiP3", "G2HiP3" },
-    { "MPC8265_HiP4", "G2HiP4" },
-    { "MPC8266", "MPC8266_HiP4" },
-    { "MPC8266_HiP3", "G2HiP3" },
-    { "MPC8266_HiP4", "G2HiP4" },
-    { "MPC8270", "G2leGP3" },
-    { "MPC8271", "G2leGP3" },
-    { "MPC8272", "G2leGP3" },
-    { "MPC8275", "G2leGP3" },
-    { "MPC8280", "G2leGP3" },
+    { "mpc82xx", "mpc8280" },
+    { "powerquicc-ii", "mpc82xx" },
+    { "mpc8241", "g2hip4" },
+    { "mpc8245", "g2hip4" },
+    { "mpc8247", "g2legp3" },
+    { "mpc8248", "g2legp3" },
+    { "mpc8250", "mpc8250_hip4" },
+    { "mpc8250_hip3", "g2hip3" },
+    { "mpc8250_hip4", "g2hip4" },
+    { "mpc8255", "mpc8255_hip4" },
+    { "mpc8255_hip3", "g2hip3" },
+    { "mpc8255_hip4", "g2hip4" },
+    { "mpc8260", "mpc8260_hip4" },
+    { "mpc8260_hip3", "g2hip3" },
+    { "mpc8260_hip4", "g2hip4" },
+    { "mpc8264", "mpc8264_hip4" },
+    { "mpc8264_hip3", "g2hip3" },
+    { "mpc8264_hip4", "g2hip4" },
+    { "mpc8265", "mpc8265_hip4" },
+    { "mpc8265_hip3", "g2hip3" },
+    { "mpc8265_hip4", "g2hip4" },
+    { "mpc8266", "mpc8266_hip4" },
+    { "mpc8266_hip3", "g2hip3" },
+    { "mpc8266_hip4", "g2hip4" },
+    { "mpc8270", "g2legp3" },
+    { "mpc8271", "g2legp3" },
+    { "mpc8272", "g2legp3" },
+    { "mpc8275", "g2legp3" },
+    { "mpc8280", "g2legp3" },
     { "e200", "e200z6" },
     { "e300", "e300c3" },
-    { "MPC8347", "MPC8347T" },
-    { "MPC8347A", "MPC8347AT" },
-    { "MPC8347E", "MPC8347ET" },
-    { "MPC8347EA", "MPC8347EAT" },
+    { "mpc8347", "mpc8347t" },
+    { "mpc8347a", "mpc8347at" },
+    { "mpc8347e", "mpc8347et" },
+    { "mpc8347ea", "mpc8347eat" },
     { "e500", "e500v2_v22" },
     { "e500v1", "e500_v20" },
     { "e500v2", "e500v2_v22" },
-    { "MPC8533", "MPC8533_v11" },
-    { "MPC8533E", "MPC8533E_v11" },
-    { "MPC8540", "MPC8540_v21" },
-    { "MPC8541", "MPC8541_v11" },
-    { "MPC8541E", "MPC8541E_v11" },
-    { "MPC8543", "MPC8543_v21" },
-    { "MPC8543E", "MPC8543E_v21" },
-    { "MPC8544", "MPC8544_v11" },
-    { "MPC8544E", "MPC8544E_v11" },
-    { "MPC8545", "MPC8545_v21" },
-    { "MPC8545E", "MPC8545E_v21" },
-    { "MPC8547E", "MPC8547E_v21" },
-    { "MPC8548", "MPC8548_v21" },
-    { "MPC8548E", "MPC8548E_v21" },
-    { "MPC8555", "MPC8555_v11" },
-    { "MPC8555E", "MPC8555E_v11" },
-    { "MPC8560", "MPC8560_v21" },
+    { "mpc8533", "mpc8533_v11" },
+    { "mpc8533e", "mpc8533e_v11" },
+    { "mpc8540", "mpc8540_v21" },
+    { "mpc8541", "mpc8541_v11" },
+    { "mpc8541e", "mpc8541e_v11" },
+    { "mpc8543", "mpc8543_v21" },
+    { "mpc8543e", "mpc8543e_v21" },
+    { "mpc8544", "mpc8544_v11" },
+    { "mpc8544e", "mpc8544e_v11" },
+    { "mpc8545", "mpc8545_v21" },
+    { "mpc8545e", "mpc8545e_v21" },
+    { "mpc8547e", "mpc8547e_v21" },
+    { "mpc8548", "mpc8548_v21" },
+    { "mpc8548e", "mpc8548e_v21" },
+    { "mpc8555", "mpc8555_v11" },
+    { "mpc8555e", "mpc8555e_v11" },
+    { "mpc8560", "mpc8560_v21" },
     { "601",  "601_v2" },
     { "601v", "601_v2" },
-    { "Vanilla", "603" },
+    { "vanilla", "603" },
     { "603e", "603e_v4.1" },
-    { "Stretch", "603e" },
-    { "Vaillant", "603e7v" },
+    { "stretch", "603e" },
+    { "vaillant", "603e7v" },
     { "603r", "603e7t" },
-    { "Goldeneye", "603r" },
+    { "goldeneye", "603r" },
     { "604e", "604e_v2.4" },
-    { "Sirocco", "604e" },
-    { "Mach5", "604r" },
+    { "sirocco", "604e" },
+    { "mach5", "604r" },
     { "740", "740_v3.1" },
-    { "Arthur", "740" },
+    { "arthur", "740" },
     { "750", "750_v3.1" },
-    { "Typhoon", "750" },
-    { "G3",      "750" },
-    { "Conan/Doyle", "750p" },
+    { "typhoon", "750" },
+    { "g3",      "750" },
+    { "conan/doyle", "750p" },
     { "750cl", "750cl_v2.0" },
     { "750cx", "750cx_v2.2" },
     { "750cxe", "750cxe_v3.1b" },
     { "750fx", "750fx_v2.3" },
     { "750gx", "750gx_v1.2" },
     { "750l", "750l_v3.2" },
-    { "LoneStar", "750l" },
+    { "lonestar", "750l" },
     { "745", "745_v2.8" },
     { "755", "755_v2.8" },
-    { "Goldfinger", "755" },
+    { "goldfinger", "755" },
     { "7400", "7400_v2.9" },
-    { "Max", "7400" },
-    { "G4",  "7400" },
+    { "max", "7400" },
+    { "g4",  "7400" },
     { "7410", "7410_v1.4" },
-    { "Nitro", "7410" },
+    { "nitro", "7410" },
     { "7448", "7448_v2.1" },
     { "7450", "7450_v2.1" },
-    { "Vger", "7450" },
+    { "vger", "7450" },
     { "7441", "7441_v2.3" },
     { "7451", "7451_v2.3" },
     { "7445", "7445_v3.2" },
     { "7455", "7455_v3.2" },
-    { "Apollo6", "7455" },
+    { "apollo6", "7455" },
     { "7447", "7447_v1.1" },
     { "7457", "7457_v1.2" },
-    { "Apollo7", "7457" },
-    { "7447A", "7447A_v1.2" },
-    { "7457A", "7457A_v1.2" },
-    { "Apollo7PM", "7457A_v1.0" },
+    { "apollo7", "7457" },
+    { "7447a", "7447a_v1.2" },
+    { "7457a", "7457a_v1.2" },
+    { "apollo7pm", "7457a_v1.0" },
 #if defined(TARGET_PPC64)
-    { "POWER3", "630" },
-    { "POWER3+", "631" },
-    { "POWER5+", "POWER5+_v2.1" },
-    { "POWER5gs", "POWER5+_v2.1" },
-    { "POWER7", "POWER7_v2.3" },
-    { "POWER7+", "POWER7+_v2.1" },
-    { "POWER8E", "POWER8E_v2.1" },
-    { "POWER8", "POWER8_v2.0" },
-    { "POWER8NVL", "POWER8NVL_v1.0" },
-    { "POWER9", "POWER9_v1.0" },
+    { "power3", "630" },
+    { "power3+", "631" },
+    { "power5+", "power5+_v2.1" },
+    { "power5gs", "power5+_v2.1" },
+    { "power7", "power7_v2.3" },
+    { "power7+", "power7+_v2.1" },
+    { "power8e", "power8e_v2.1" },
+    { "power8", "power8_v2.0" },
+    { "power8nvl", "power8nvl_v1.0" },
+    { "power9", "power9_v1.0" },
     { "970", "970_v2.2" },
     { "970fx", "970fx_v3.1" },
     { "970mp", "970mp_v1.1" },
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index abcfe13b8a..6861f2f585 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2525,7 +2525,7 @@ static int kvm_ppc_register_host_cpu_type(void)
      */
     dc =3D DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
     for (i =3D 0; ppc_cpu_aliases[i].alias !=3D NULL; i++) {
-        if (strcmp(ppc_cpu_aliases[i].alias, dc->desc) =3D=3D 0) {
+        if (strcasecmp(ppc_cpu_aliases[i].alias, dc->desc) =3D=3D 0) {
             char *suffix;
=20
             ppc_cpu_aliases[i].model =3D g_strdup(object_class_get_name(=
oc));
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index ee42c56288..f392fa6ea9 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10326,7 +10326,7 @@ static ObjectClass *ppc_cpu_class_by_name(const c=
har *name)
     }
=20
     for (i =3D 0; ppc_cpu_aliases[i].alias !=3D NULL; i++) {
-        if (strcmp(ppc_cpu_aliases[i].alias, name) =3D=3D 0) {
+        if (strcasecmp(ppc_cpu_aliases[i].alias, name) =3D=3D 0) {
             return ppc_cpu_class_by_alias(&ppc_cpu_aliases[i]);
         }
     }
--=20
2.13.5
