Received: from eggs.gnu.org ([2001:4830:134:3::10]:58844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5XyX-0001Hg-Kg
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5XyU-0001np-G8
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57302
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d5XyU-0001nQ-9Y
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:18 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42DYHgA083154
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 09:36:12 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a6smcmw72-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 09:36:12 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 2 May 2017 14:36:09 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue,  2 May 2017 15:35:53 +0200
In-Reply-To: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
References: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
Message-Id: <20170502133604.17735-2-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 01/12] hw/s390x: provide loadparm property for
 the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Farhan Ali <alifm@linux.vnet.ibm.com>, Eugene Dvurechenski <jno@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

In order to specify the LOADPARM value one may now add ",loadparm=xxx"
parameter to the "-machine s390-ccw-virtio" option.

The property setter will normalize and check the value provided much
like the way the HMC does.

The value is stored, but not used at the moment.

Initial patch from Eugene (jno) Dvurechenski.

Signed-off-by: Eugene (jno) Dvurechenski <jno@linux.vnet.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c         | 37 +++++++++++++++++++++++++++++++++++++
 include/hw/s390x/s390-virtio-ccw.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 04bd0ebe40..fdd4384ff0 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -274,6 +274,36 @@ bool cpu_model_allowed(void)
     return true;
 }
 
+static char *machine_get_loadparm(Object *obj, Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+
+    return g_memdup(ms->loadparm, sizeof(ms->loadparm));
+}
+
+static void machine_set_loadparm(Object *obj, const char *val, Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+    int i;
+
+    for (i = 0; i < sizeof(ms->loadparm) && val[i]; i++) {
+        uint8_t c = toupper(val[i]); /* mimic HMC */
+
+        if (('A' <= c && c <= 'Z') || ('0' <= c && c <= '9') || (c == '.') ||
+            (c == ' ')) {
+            ms->loadparm[i] = c;
+        } else {
+            error_setg(errp, "LOADPARM: invalid character '%c' (ASCII 0x%02x)",
+                       c, c);
+            return;
+        }
+    }
+
+    for (; i < sizeof(ms->loadparm); i++) {
+        ms->loadparm[i] = ' '; /* pad right with spaces */
+    }
+}
+
 static inline void s390_machine_initfn(Object *obj)
 {
     object_property_add_bool(obj, "aes-key-wrap",
@@ -291,6 +321,13 @@ static inline void s390_machine_initfn(Object *obj)
             "enable/disable DEA key wrapping using the CPACF wrapping key",
             NULL);
     object_property_set_bool(obj, true, "dea-key-wrap", NULL);
+    object_property_add_str(obj, "loadparm",
+            machine_get_loadparm, machine_set_loadparm, NULL);
+    object_property_set_description(obj, "loadparm",
+            "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars converted"
+            " to upper case) to pass to machine loader, boot manager,"
+            " and guest kernel",
+            NULL);
 }
 
 static const TypeInfo ccw_machine_info = {
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 6ecae00386..7b8a3e4d74 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -28,6 +28,7 @@ typedef struct S390CcwMachineState {
     /*< public >*/
     bool aes_key_wrap;
     bool dea_key_wrap;
+    uint8_t loadparm[8];
 } S390CcwMachineState;
 
 typedef struct S390CcwMachineClass {
-- 
2.11.0
