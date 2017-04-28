Received: from eggs.gnu.org ([2001:4830:134:3::10]:51132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d45fA-0002fC-B5
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d45f5-0005n0-7X
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:10:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38765
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d45f5-0005ma-0Y
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:10:15 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3SDA6t2070813
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 09:10:13 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a416k6wdf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 09:10:13 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Fri, 28 Apr 2017 07:10:11 -0600
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Fri, 28 Apr 2017 15:09:41 +0200
In-Reply-To: <20170428130951.44771-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170428130951.44771-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170428130951.44771-4-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v6 03/13] s390x/css: add s390-squash-mcss
 machine option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>

From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>

We want to support real (i.e. not virtual) channel devices
even for guests that do not support MCSS-E (where guests may
see devices from any channel subsystem image at once). As all
virtio-ccw devices are in css 0xfe (and show up in the default
css 0 for guests not activating MCSS-E), we need an option to
squash both the virtio subchannels and e.g. passed-through
subchannels from their real css (0-3, or 0 for hosts not
activating MCSS-E) into the default css. This will be
exploited in a later patch.

Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c         | 21 +++++++++++++++++++++
 include/hw/s390x/s390-virtio-ccw.h |  1 +
 qemu-options.hx                    |  6 +++++-
 target/s390x/cpu.h                 | 10 ++++++++++
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index fdd4384..cd007ca 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -303,6 +303,20 @@ static void machine_set_loadparm(Object *obj, const char *val, Error **errp)
         ms->loadparm[i] = ' '; /* pad right with spaces */
     }
 }
+static inline bool machine_get_squash_mcss(Object *obj, Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+
+    return ms->s390_squash_mcss;
+}
+
+static inline void machine_set_squash_mcss(Object *obj, bool value,
+                                           Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+
+    ms->s390_squash_mcss = value;
+}
 
 static inline void s390_machine_initfn(Object *obj)
 {
@@ -328,6 +342,13 @@ static inline void s390_machine_initfn(Object *obj)
             " to upper case) to pass to machine loader, boot manager,"
             " and guest kernel",
             NULL);
+    object_property_add_bool(obj, "s390-squash-mcss",
+                             machine_get_squash_mcss,
+                             machine_set_squash_mcss, NULL);
+    object_property_set_description(obj, "s390-squash-mcss",
+            "enable/disable squashing subchannels into the default css",
+            NULL);
+    object_property_set_bool(obj, false, "s390-squash-mcss", NULL);
 }
 
 static const TypeInfo ccw_machine_info = {
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 7b8a3e4..3027555 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -29,6 +29,7 @@ typedef struct S390CcwMachineState {
     bool aes_key_wrap;
     bool dea_key_wrap;
     uint8_t loadparm[8];
+    bool s390_squash_mcss;
 } S390CcwMachineState;
 
 typedef struct S390CcwMachineClass {
diff --git a/qemu-options.hx b/qemu-options.hx
index 9171bd5..2ba4379 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -42,7 +42,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
     "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
-    "                enforce-config-section=on|off enforce configuration section migration (default=off)\n",
+    "                enforce-config-section=on|off enforce configuration section migration (default=off)\n"
+    "                s390-squash-mcss=on|off controls support for squashing into default css (default=off)\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -machine [type=]@var{name}[,prop=@var{value}[,...]]
@@ -81,6 +82,9 @@ controls whether DEA wrapping keys will be created to allow
 execution of DEA cryptographic functions.  The default is on.
 @item nvdimm=on|off
 Enables or disables NVDIMM support. The default is off.
+@item s390-squash-mcss=on|off
+Enables or disables squashing subchannels into the default css.
+The default is off.
 @end table
 ETEXI
 
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 058ddad..c367891 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -1250,6 +1250,16 @@ static inline void s390_crypto_reset(void)
     }
 }
 
+static inline bool s390_get_squash_mcss(void)
+{
+    if (object_property_get_bool(OBJECT(qdev_get_machine()), "s390-squash-mcss",
+                                 NULL)) {
+        return true;
+    }
+
+    return false;
+}
+
 /* machine check interruption code */
 
 /* subclasses */
-- 
2.10.2
