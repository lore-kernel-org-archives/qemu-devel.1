Received: from eggs.gnu.org ([2001:4830:134:3::10]:35773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fFc2U-00059z-Ha
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fFc2R-0003PZ-FC
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:02:34 -0400
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:60046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fFc2R-0003KK-5O
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:02:31 -0400
Received: from player762.ha.ovh.net (unknown [10.109.105.99])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 73A551B6AF9
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 11:02:22 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 07 May 2018 11:02:09 +0200
Message-ID: <152568372989.443627.900708381919207053.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ppc: e500: use g_strdup_printf() instead of
 snprintf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Howard Spoelstra <hsp.cat7@gmail.com>

qemu-system-ppc fails to build with GCC 8.0.1:

/home/hsp/src/qemu-master/hw/ppc/e500.c: In function =E2=80=98ppce500_loa=
d_device_tree=E2=80=99:
/home/hsp/src/qemu-master/hw/ppc/e500.c:442:37: error: =E2=80=98/pic@=E2=80=
=99
directive output may be truncated writing 5 bytes into a region of
size between 1 and 128 [-Werror=3Dformat-truncation=3D]
     snprintf(mpic, sizeof(mpic), "%s/pic@%llx", soc, MPC8544_MPIC_REGS_O=
FFSET);
                                     ^~~~~
In file included from /usr/include/stdio.h:862,
                 from /home/hsp/src/qemu-master/include/qemu/osdep.h:68,
                 from /home/hsp/src/qemu-master/hw/ppc/e500.c:17:
/usr/include/bits/stdio2.h:64:10: note: =E2=80=98__builtin___snprintf_chk=
=E2=80=99
output between 11 and 138 bytes into a destination of size 128
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __bos (__s), __fmt, __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/hsp/src/qemu-master/hw/ppc/e500.c:470:39: error:
=E2=80=98/global-utilities@=E2=80=99 directive output may be truncated wr=
iting 18
bytes into a region of size between 1 and 128
[-Werror=3Dformat-truncation=3D]
     snprintf(gutil, sizeof(gutil), "%s/global-utilities@%llx", soc,
                                       ^~~~~~~~~~~~~~~~~~
In file included from /usr/include/stdio.h:862,
                 from /home/hsp/src/qemu-master/include/qemu/osdep.h:68,
                 from /home/hsp/src/qemu-master/hw/ppc/e500.c:17:
/usr/include/bits/stdio2.h:64:10: note: =E2=80=98__builtin___snprintf_chk=
=E2=80=99
output between 24 and 151 bytes into a destination of size 128
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __bos (__s), __fmt, __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/hsp/src/qemu-master/hw/ppc/e500.c:477:36: error: =E2=80=98/msi@=E2=80=
=99
directive output may be truncated writing 5 bytes into a region of
size between 0 and 127 [-Werror=3Dformat-truncation=3D]
     snprintf(msi, sizeof(msi), "/%s/msi@%llx", soc, MPC8544_MSI_REGS_OFF=
SET);
                                    ^~~~~
In file included from /usr/include/stdio.h:862,
                 from /home/hsp/src/qemu-master/include/qemu/osdep.h:68,
                 from /home/hsp/src/qemu-master/hw/ppc/e500.c:17:
/usr/include/bits/stdio2.h:64:10: note: =E2=80=98__builtin___snprintf_chk=
=E2=80=99
output between 12 and 139 bytes into a destination of size 128
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __bos (__s), __fmt, __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix this by converting e500 to use g_strdup_printf()+g_free() instead
of snprintf(). This is done globally, even for call sites that don't
break build, since this is the preferred practice in QEMU.

Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/e500.c |   39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 3e0923cfba7d..748a8d213b25 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -106,9 +106,9 @@ static void dt_serial_create(void *fdt, unsigned long=
 long offset,
                              const char *soc, const char *mpic,
                              const char *alias, int idx, bool defcon)
 {
-    char ser[128];
+    char *ser;
=20
-    snprintf(ser, sizeof(ser), "%s/serial@%llx", soc, offset);
+    ser =3D g_strdup_printf("%s/serial@%llx", soc, offset);
     qemu_fdt_add_subnode(fdt, ser);
     qemu_fdt_setprop_string(fdt, ser, "device_type", "serial");
     qemu_fdt_setprop_string(fdt, ser, "compatible", "ns16550");
@@ -129,6 +129,7 @@ static void dt_serial_create(void *fdt, unsigned long=
 long offset,
         qemu_fdt_setprop_string(fdt, "/chosen", "linux,stdout-path", ser=
);
         qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", ser);
     }
+    g_free(ser);
 }
=20
 static void create_dt_mpc8xxx_gpio(void *fdt, const char *soc, const cha=
r *mpic)
@@ -285,13 +286,13 @@ static int ppce500_load_device_tree(PPCE500MachineS=
tate *pms,
     uint32_t tb_freq =3D 400000000;
     int i;
     char compatible_sb[] =3D "fsl,mpc8544-immr\0simple-bus";
-    char soc[128];
-    char mpic[128];
+    char *soc;
+    char *mpic;
     uint32_t mpic_ph;
     uint32_t msi_ph;
-    char gutil[128];
-    char pci[128];
-    char msi[128];
+    char *gutil;
+    char *pci;
+    char *msi;
     uint32_t *pci_map =3D NULL;
     int len;
     uint32_t pci_ranges[14] =3D
@@ -391,7 +392,7 @@ static int ppce500_load_device_tree(PPCE500MachineSta=
te *pms,
        the first node as boot node and be happy */
     for (i =3D smp_cpus - 1; i >=3D 0; i--) {
         CPUState *cpu;
-        char cpu_name[128];
+        char *cpu_name;
         uint64_t cpu_release_addr =3D pmc->spin_base + (i * 0x20);
=20
         cpu =3D qemu_get_cpu(i);
@@ -400,7 +401,7 @@ static int ppce500_load_device_tree(PPCE500MachineSta=
te *pms,
         }
         env =3D cpu->env_ptr;
=20
-        snprintf(cpu_name, sizeof(cpu_name), "/cpus/PowerPC,8544@%x", i)=
;
+        cpu_name =3D g_strdup_printf("/cpus/PowerPC,8544@%x", i);
         qemu_fdt_add_subnode(fdt, cpu_name);
         qemu_fdt_setprop_cell(fdt, cpu_name, "clock-frequency", clock_fr=
eq);
         qemu_fdt_setprop_cell(fdt, cpu_name, "timebase-frequency", tb_fr=
eq);
@@ -422,11 +423,12 @@ static int ppce500_load_device_tree(PPCE500MachineS=
tate *pms,
         } else {
             qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
         }
+        g_free(cpu_name);
     }
=20
     qemu_fdt_add_subnode(fdt, "/aliases");
     /* XXX These should go into their respective devices' code */
-    snprintf(soc, sizeof(soc), "/soc@%"PRIx64, pmc->ccsrbar_base);
+    soc =3D g_strdup_printf("/soc@%"PRIx64, pmc->ccsrbar_base);
     qemu_fdt_add_subnode(fdt, soc);
     qemu_fdt_setprop_string(fdt, soc, "device_type", "soc");
     qemu_fdt_setprop(fdt, soc, "compatible", compatible_sb,
@@ -439,7 +441,7 @@ static int ppce500_load_device_tree(PPCE500MachineSta=
te *pms,
     /* XXX should contain a reasonable value */
     qemu_fdt_setprop_cell(fdt, soc, "bus-frequency", 0);
=20
-    snprintf(mpic, sizeof(mpic), "%s/pic@%llx", soc, MPC8544_MPIC_REGS_O=
FFSET);
+    mpic =3D g_strdup_printf("%s/pic@%llx", soc, MPC8544_MPIC_REGS_OFFSE=
T);
     qemu_fdt_add_subnode(fdt, mpic);
     qemu_fdt_setprop_string(fdt, mpic, "device_type", "open-pic");
     qemu_fdt_setprop_string(fdt, mpic, "compatible", "fsl,mpic");
@@ -467,14 +469,15 @@ static int ppce500_load_device_tree(PPCE500MachineS=
tate *pms,
                          soc, mpic, "serial0", 0, true);
     }
=20
-    snprintf(gutil, sizeof(gutil), "%s/global-utilities@%llx", soc,
-             MPC8544_UTIL_OFFSET);
+    gutil =3D g_strdup_printf("%s/global-utilities@%llx", soc,
+                            MPC8544_UTIL_OFFSET);
     qemu_fdt_add_subnode(fdt, gutil);
     qemu_fdt_setprop_string(fdt, gutil, "compatible", "fsl,mpc8544-guts"=
);
     qemu_fdt_setprop_cells(fdt, gutil, "reg", MPC8544_UTIL_OFFSET, 0x100=
0);
     qemu_fdt_setprop(fdt, gutil, "fsl,has-rstcr", NULL, 0);
+    g_free(gutil);
=20
-    snprintf(msi, sizeof(msi), "/%s/msi@%llx", soc, MPC8544_MSI_REGS_OFF=
SET);
+    msi =3D g_strdup_printf("/%s/msi@%llx", soc, MPC8544_MSI_REGS_OFFSET=
);
     qemu_fdt_add_subnode(fdt, msi);
     qemu_fdt_setprop_string(fdt, msi, "compatible", "fsl,mpic-msi");
     qemu_fdt_setprop_cells(fdt, msi, "reg", MPC8544_MSI_REGS_OFFSET, 0x2=
00);
@@ -492,9 +495,10 @@ static int ppce500_load_device_tree(PPCE500MachineSt=
ate *pms,
         0xe7, 0x0);
     qemu_fdt_setprop_cell(fdt, msi, "phandle", msi_ph);
     qemu_fdt_setprop_cell(fdt, msi, "linux,phandle", msi_ph);
+    g_free(msi);
=20
-    snprintf(pci, sizeof(pci), "/pci@%llx",
-             pmc->ccsrbar_base + MPC8544_PCI_REGS_OFFSET);
+    pci =3D g_strdup_printf("/pci@%llx",
+                          pmc->ccsrbar_base + MPC8544_PCI_REGS_OFFSET);
     qemu_fdt_add_subnode(fdt, pci);
     qemu_fdt_setprop_cell(fdt, pci, "cell-index", 0);
     qemu_fdt_setprop_string(fdt, pci, "compatible", "fsl,mpc8540-pci");
@@ -522,14 +526,17 @@ static int ppce500_load_device_tree(PPCE500MachineS=
tate *pms,
     qemu_fdt_setprop_cell(fdt, pci, "#size-cells", 2);
     qemu_fdt_setprop_cell(fdt, pci, "#address-cells", 3);
     qemu_fdt_setprop_string(fdt, "/aliases", "pci0", pci);
+    g_free(pci);
=20
     if (pmc->has_mpc8xxx_gpio) {
         create_dt_mpc8xxx_gpio(fdt, soc, mpic);
     }
+    g_free(soc);
=20
     if (pmc->has_platform_bus) {
         platform_bus_create_devtree(pmc, fdt, mpic);
     }
+    g_free(mpic);
=20
     pmc->fixup_devtree(fdt);
=20
