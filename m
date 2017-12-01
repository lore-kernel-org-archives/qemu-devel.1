Received: from eggs.gnu.org ([2001:4830:134:3::10]:35581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eKrZu-0006tP-HY
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:06:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eKrZr-0007GQ-CE
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:06:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eKrZr-0007Fe-3y
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:06:27 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB1EVZoO079584
	for <qemu-devel@nongnu.org>; Fri, 1 Dec 2017 09:31:57 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ek752x9sv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 09:31:57 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 1 Dec 2017 14:31:54 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri,  1 Dec 2017 15:31:36 +0100
In-Reply-To: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
Message-Id: <20171201143136.62497-4-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/3] s390x: deprecate s390-squash-mcss machine
 prop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

With the cssids unrestricted (commit <COMMIT HERE> "s390x/css: unrestrict
cssids") the s390-squash-mcss machine property should not be used.
Actually libvirt never supported this, so the expectation is that
removing it should be pretty painless.  But let's play nice and deprecate
it first.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---

I would like to reference a commit for "s390x/css: unrestrict cssids"
which is currently in RFC status on the list.
---
 hw/s390x/s390-virtio-ccw.c | 6 +++++-
 qemu-doc.texi              | 8 ++++++++
 qemu-options.hx            | 8 +++++++-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 4d65a50334..3796f666e6 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -553,6 +553,10 @@ static inline void machine_set_squash_mcss(Object *obj, bool value,
     S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
 
     ms->s390_squash_mcss = value;
+    if (ms->s390_squash_mcss) {
+        warn_report("The machine property 's390-squash-mcss' is deprecated"
+                    " (obsoleted by lifting the cssid restrictions).");
+    }
 }
 
 static inline void s390_machine_initfn(Object *obj)
@@ -582,7 +586,7 @@ static inline void s390_machine_initfn(Object *obj)
     object_property_add_bool(obj, "s390-squash-mcss",
                              machine_get_squash_mcss,
                              machine_set_squash_mcss, NULL);
-    object_property_set_description(obj, "s390-squash-mcss",
+    object_property_set_description(obj, "s390-squash-mcss", "(deprecated) "
             "enable/disable squashing subchannels into the default css",
             NULL);
     object_property_set_bool(obj, false, "s390-squash-mcss", NULL);
diff --git a/qemu-doc.texi b/qemu-doc.texi
index db2351c746..874432d87c 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2501,6 +2501,14 @@ enabled via the ``-machine usb=on'' argument.
 
 The ``-nodefconfig`` argument is a synonym for ``-no-user-config``.
 
+@subsection -machine virtio-ccw,s390-squash-mcss=on|off (since 2.12.0)
+
+The ``s390-squash-mcss=on`` property has been obsoleted by allowing the
+cssid to be chosen freely. Instead of squashing subchannels into the
+default channel subsystem image for guests that do not support multiple
+channel subsystems, all devices can be put into the default channel
+subsystem image.
+
 @section qemu-img command line arguments
 
 @subsection convert -s (since 2.0.0)
diff --git a/qemu-options.hx b/qemu-options.hx
index f11c4ac960..fe0c29271f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -43,7 +43,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
     "                enforce-config-section=on|off enforce configuration section migration (default=off)\n"
-    "                s390-squash-mcss=on|off controls support for squashing into default css (default=off)\n",
+    "                s390-squash-mcss=on|off (deprecated) controls support for squashing into default css (default=off)\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -machine [type=]@var{name}[,prop=@var{value}[,...]]
@@ -98,6 +98,12 @@ Enables or disables NVDIMM support. The default is off.
 @item s390-squash-mcss=on|off
 Enables or disables squashing subchannels into the default css.
 The default is off.
+NOTE: This property is deprecated and will be removed in future releases.
+The ``s390-squash-mcss=on`` property has been obsoleted by allowing the
+cssid to be chosen freely. Instead of squashing subchannels into the
+default channel subsystem image for guests that do not support multiple
+channel subsystems, all devices can be put into the default channel
+subsystem image.
 @item enforce-config-section=on|off
 If @option{enforce-config-section} is set to @var{on}, force migration
 code to send configuration section even if the machine-type sets the
-- 
2.13.5
