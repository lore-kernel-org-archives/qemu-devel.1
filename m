Received: from eggs.gnu.org ([209.51.188.92]:48372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxiwell@linux.ibm.com>) id 1gz2jg-0007Cb-Ik
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxiwell@linux.ibm.com>) id 1gz2je-0005VW-H2
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:11:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxiwell@linux.ibm.com>)
	id 1gz2jc-0005Hw-LA
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:11:09 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1RH9i3Z078512
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 12:10:26 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qwxeh8y44-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 12:10:25 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <maxiwell@linux.ibm.com>;
	Wed, 27 Feb 2019 17:10:24 -0000
From: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Date: Wed, 27 Feb 2019 14:10:09 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190227171009.12894-1-maxiwell@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3] spapr-rtas: add ibm, get-vpd RTAS interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "open list:sPAPR" <qemu-ppc@nongnu.org>

This adds a handler for ibm,get-vpd RTAS calls, allowing pseries guest
to collect host information. It is disabled by default to avoid unwanted
information leakage. To enable it, use:

=E2=80=98-M pseries,host-serial=3D{passthrough|string},host-model=3D{pass=
through|string}=E2=80=99

Only the SE and TM keywords are returned at the moment.
SE for Machine or Cabinet Serial Number and
TM for Machine Type and Model

The SE and TM keywords are controlled by 'host-serial' and 'host-model'
options, respectively. In the case of 'passthrough', the SE shows the
host 'system-id' information and the TM shows the host 'model' informatio=
n.

Powerpc-utils tools can dispatch RTAS calls to retrieve host
information using this ibm,get-vpd interface. The 'host-serial'
and 'host-model' nodes of device-tree hold the same information but
in a static manner, which is useless after a migration operation.

Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
---
 hw/ppc/spapr_rtas.c    | 103 +++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  16 ++++++-
 2 files changed, 118 insertions(+), 1 deletion(-)

Update v3:
    * Use 'host-serial' and 'host-model' options to enable/disable ibm,ge=
t-vpd
    * Remove 'export-vpd' option

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index d6a0952154..fb23a8f50f 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -287,6 +287,107 @@ static void rtas_ibm_set_system_parameter(PowerPCCP=
U *cpu,
     rtas_st(rets, 0, ret);
 }
=20
+static inline int vpd_st(target_ulong addr, target_ulong len,
+                         const void *val, uint16_t val_len)
+{
+    hwaddr phys =3D ppc64_phys_to_real(addr);
+    if (len < val_len) {
+        return RTAS_OUT_PARAM_ERROR;
+    }
+    cpu_physical_memory_write(phys, val, val_len);
+    return RTAS_OUT_SUCCESS;
+}
+
+static inline void vpd_ret(target_ulong rets, const int status,
+                           const int next_seq_number, const int bytes_re=
turned)
+{
+    rtas_st(rets, 0, status);
+    rtas_st(rets, 1, next_seq_number);
+    rtas_st(rets, 2, bytes_returned);
+}
+
+static void rtas_ibm_get_vpd(PowerPCCPU *cpu,
+                             sPAPRMachineState *spapr,
+                             uint32_t token, uint32_t nargs,
+                             target_ulong args,
+                             uint32_t nret, target_ulong rets)
+{
+    sPAPRMachineState *sm =3D SPAPR_MACHINE(spapr);
+    target_ulong loc_code_addr;
+    target_ulong work_area_addr;
+    target_ulong work_area_size;
+    target_ulong seq_number;
+    unsigned char loc_code =3D 0;
+    unsigned int next_seq_number =3D 1;
+    int status =3D RTAS_IBM_GET_VPD_PARAMETER_ERROR;
+    int ret =3D RTAS_OUT_PARAM_ERROR;
+    char *buf =3D NULL;
+    char *vpd_field =3D NULL;
+    unsigned int vpd_field_len =3D 0;
+
+    /* Enable individual Keywords is not supported */
+    if ((!sm->host_serial || g_str_equal(sm->host_serial, "none")) ||
+        (!sm->host_model || g_str_equal(sm->host_model, "none"))) {
+        vpd_ret(rets, RTAS_OUT_NOT_AUTHORIZED, 1, 0);
+        return;
+    }
+
+    /* Specific Location Code is not supported */
+    loc_code_addr =3D rtas_ld(args, 0);
+    cpu_physical_memory_read(loc_code_addr, &loc_code, 1);
+    if (loc_code !=3D 0) {
+        vpd_ret(rets, RTAS_IBM_GET_VPD_PARAMETER_ERROR, 1, 0);
+        return;
+    }
+
+    work_area_addr =3D rtas_ld(args, 1);
+    work_area_size =3D rtas_ld(args, 2);
+    seq_number =3D rtas_ld(args, 3);
+    switch (seq_number) {
+    case RTAS_IBM_VPD_KEYWORD_SE:
+        if (g_str_equal(sm->host_serial, "passthrough")) {
+            /* -M host-serial=3Dpassthrough */
+            if (kvmppc_get_host_serial(&buf)) {
+                /* LoPAPR: SE for Machine or Cabinet Serial Number */
+                vpd_field =3D g_strdup_printf("SE %s", buf);
+            }
+        } else {
+            vpd_field =3D g_strdup_printf("SE %s", sm->host_serial);
+        }
+        break;
+    case RTAS_IBM_VPD_KEYWORD_TM:
+        if (g_str_equal(sm->host_model, "passthrough")) {
+            /* -M host-model=3Dpassthrough */
+            if (kvmppc_get_host_model(&buf)) {
+                /* LoPAPR: TM for Machine Type and Model */
+                vpd_field =3D g_strdup_printf("TM %s", buf);
+            }
+        } else {
+            vpd_field =3D g_strdup_printf("TM %s", sm->host_model);
+        }
+        break;
+    }
+
+    if (vpd_field) {
+        vpd_field_len =3D strlen(vpd_field);
+        ret =3D vpd_st(work_area_addr, work_area_size,
+                     vpd_field, vpd_field_len + 1);
+
+        if (ret =3D=3D 0) {
+            if (seq_number =3D=3D RTAS_IBM_VPD_KEYWORD_LAST) {
+                status =3D RTAS_IBM_GET_VPD_SUCCESS;
+            } else {
+                status =3D RTAS_IBM_GET_VPD_CONTINUE;
+                next_seq_number =3D seq_number + 1;
+            }
+        }
+    }
+
+    vpd_ret(rets, status, next_seq_number, vpd_field_len);
+    g_free(vpd_field);
+    g_free(buf);
+}
+
 static void rtas_ibm_os_term(PowerPCCPU *cpu,
                             sPAPRMachineState *spapr,
                             uint32_t token, uint32_t nargs,
@@ -485,6 +586,8 @@ static void core_rtas_register_types(void)
                         rtas_ibm_set_system_parameter);
     spapr_rtas_register(RTAS_IBM_OS_TERM, "ibm,os-term",
                         rtas_ibm_os_term);
+    spapr_rtas_register(RTAS_IBM_GET_VPD, "ibm,get-vpd",
+                        rtas_ibm_get_vpd);
     spapr_rtas_register(RTAS_SET_POWER_LEVEL, "set-power-level",
                         rtas_set_power_level);
     spapr_rtas_register(RTAS_GET_POWER_LEVEL, "get-power-level",
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index fec0f26f49..3654c3ccf3 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -607,14 +607,28 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, targe=
t_ulong opcode,
 #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x27)
 #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
 #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
+#define RTAS_IBM_GET_VPD                        (RTAS_TOKEN_BASE + 0x2A)
=20
-#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2A)
+#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2B)
=20
 /* RTAS ibm,get-system-parameter token values */
 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
 #define RTAS_SYSPARM_DIAGNOSTICS_RUN_MODE        42
 #define RTAS_SYSPARM_UUID                        48
=20
+/* RTAS ibm,get-vpd status values */
+#define RTAS_IBM_GET_VPD_VPD_CHANGED     -4
+#define RTAS_IBM_GET_VPD_PARAMETER_ERROR -3
+#define RTAS_IBM_GET_VPD_HARDWARE_ERROR  -1
+#define RTAS_IBM_GET_VPD_SUCCESS          0
+#define RTAS_IBM_GET_VPD_CONTINUE         1
+
+/* RTAS ibm,get-vpd keywords index */
+#define RTAS_IBM_VPD_KEYWORD_SE     1
+#define RTAS_IBM_VPD_KEYWORD_TM     2
+
+#define RTAS_IBM_VPD_KEYWORD_LAST   2
+
 /* RTAS indicator/sensor types
  *
  * as defined by PAPR+ 2.7 7.3.5.4, Table 41
--=20
2.20.1
