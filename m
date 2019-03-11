Received: from eggs.gnu.org ([209.51.188.92]:45998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxiwell@linux.ibm.com>) id 1h3Tu4-0000lV-6A
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 19:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxiwell@linux.ibm.com>) id 1h3Tra-0004Ka-VU
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:57:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52028
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxiwell@linux.ibm.com>)
	id 1h3Tra-0004JT-2A
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:57:42 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x2BMsjNg101179
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 18:57:41 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r5x8w6e18-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 18:57:40 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <maxiwell@linux.ibm.com>;
	Mon, 11 Mar 2019 22:57:39 -0000
From: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Date: Mon, 11 Mar 2019 19:57:08 -0300
In-Reply-To: <20190311225709.5535-1-maxiwell@linux.ibm.com>
References: <20190311225709.5535-1-maxiwell@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190311225709.5535-2-maxiwell@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v5 1/2] spapr: helper functions to get valid
 host fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org, "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>

The pseries options 'host-serial' and 'host-model' accepts
'none', 'passthrough', or <string> content. The helper
functions in this commit return a valid host field based on
user options.

Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
---
 hw/ppc/spapr.c         | 58 ++++++++++++++++++++++++++----------------
 include/hw/ppc/spapr.h |  3 +++
 2 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9e01226e18..a3078f0261 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1202,6 +1202,34 @@ static void spapr_dt_chosen(sPAPRMachineState *spapr, void *fdt)
     g_free(bootlist);
 }
 
+char *spapr_get_valid_host_serial(sPAPRMachineState *spapr)
+{
+    char *host_serial = NULL;
+    if (spapr->host_serial && !g_str_equal(spapr->host_serial, "none")) {
+        if (g_str_equal(spapr->host_serial, "passthrough")) {
+            /* -M host-serial=passthrough */
+            kvmppc_get_host_serial(&host_serial);
+        } else {
+            host_serial = g_strdup(spapr->host_serial);
+        }
+    }
+    return host_serial;
+}
+
+char *spapr_get_valid_host_model(sPAPRMachineState *spapr)
+{
+    char *host_model = NULL;
+    if (spapr->host_model && !g_str_equal(spapr->host_model, "none")) {
+        if (g_str_equal(spapr->host_model, "passthrough")) {
+            /* -M host-model=passthrough */
+            kvmppc_get_host_model(&host_model);
+        } else {
+            host_model = g_strdup(spapr->host_model);
+        }
+    }
+    return host_model;
+}
+
 static void spapr_dt_hypervisor(sPAPRMachineState *spapr, void *fdt)
 {
     /* The /hypervisor node isn't in PAPR - this is a hack to allow PR
@@ -1247,30 +1275,16 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr)
      * Add info to guest to indentify which host is it being run on
      * and what is the uuid of the guest
      */
-    if (spapr->host_model && !g_str_equal(spapr->host_model, "none")) {
-        if (g_str_equal(spapr->host_model, "passthrough")) {
-            /* -M host-model=passthrough */
-            if (kvmppc_get_host_model(&buf)) {
-                _FDT(fdt_setprop_string(fdt, 0, "host-model", buf));
-                g_free(buf);
-            }
-        } else {
-            /* -M host-model=<user-string> */
-            _FDT(fdt_setprop_string(fdt, 0, "host-model", spapr->host_model));
-        }
+    buf = spapr_get_valid_host_model(spapr);
+    if (buf) {
+        _FDT(fdt_setprop_string(fdt, 0, "host-model", buf));
+        g_free(buf);
     }
 
-    if (spapr->host_serial && !g_str_equal(spapr->host_serial, "none")) {
-        if (g_str_equal(spapr->host_serial, "passthrough")) {
-            /* -M host-serial=passthrough */
-            if (kvmppc_get_host_serial(&buf)) {
-                _FDT(fdt_setprop_string(fdt, 0, "host-serial", buf));
-                g_free(buf);
-            }
-        } else {
-            /* -M host-serial=<user-string> */
-            _FDT(fdt_setprop_string(fdt, 0, "host-serial", spapr->host_serial));
-        }
+    buf = spapr_get_valid_host_serial(spapr);
+    if (buf) {
+        _FDT(fdt_setprop_string(fdt, 0, "host-serial", buf));
+        g_free(buf);
     }
 
     buf = qemu_uuid_unparse_strdup(&qemu_uuid);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 59073a7579..f7ea99dc69 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -842,6 +842,9 @@ int spapr_caps_post_migration(sPAPRMachineState *spapr);
 
 void spapr_check_pagesize(sPAPRMachineState *spapr, hwaddr pagesize,
                           Error **errp);
+
+char *spapr_get_valid_host_serial(sPAPRMachineState *spapr);
+char *spapr_get_valid_host_model(sPAPRMachineState *spapr);
 /*
  * XIVE definitions
  */
-- 
2.20.1
