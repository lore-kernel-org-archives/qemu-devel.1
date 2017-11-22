Received: from eggs.gnu.org ([2001:4830:134:3::10]:39455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eHVrW-0006qj-3X
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eHVrS-0002HQ-Ux
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:18:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34410
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eHVrS-0002HD-Ow
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:18:46 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAMEIUPQ108243
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 09:18:43 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ed9xgbv9k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 09:18:41 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 22 Nov 2017 14:18:37 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 22 Nov 2017 15:18:32 +0100
Message-Id: <20171122141832.94779-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 1/1] s390x: deprecate s390-squash-mcss
 machine prop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

With the cssids unrestricted (commit <COMMIT HERE> "s390x/css: unrestrict
cssids") the s390-squash-mcss machine property should not be used.
Actually libvirt never supported this, so the expectation is that
removing it should be pretty painless.  But let's play nice and deprecate
it first.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---

I'm not sure about the warnig I generate if 's390-squash-mcss'
is set to 'on':
* There is prior art where we don't warn_report but info_report
(commit 83926ad527) 
* Warning iff specified on the command line regardless of value
would probably be cleaner. Yet I'm not sure where would I need
to hook in to do that.

I would like to reference a commit for "s390x/css: unrestrict cssids"
which is currently in RFC status on the list.
---
 hw/s390x/s390-virtio-ccw.c | 5 ++++-
 qemu-doc.texi              | 6 ++++++
 qemu-options.hx            | 6 +++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 6a57f94197..c71e1d7e55 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -554,6 +554,9 @@ static inline void machine_set_squash_mcss(Object *obj, bool value,
     S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
 
     ms->s390_squash_mcss = value;
+    if (ms->s390_squash_mcss) {
+        warn_report("the machine property 's390-squash-mcss' is deprecated");
+    }
 }
 
 static inline void s390_machine_initfn(Object *obj)
@@ -583,7 +586,7 @@ static inline void s390_machine_initfn(Object *obj)
     object_property_add_bool(obj, "s390-squash-mcss",
                              machine_get_squash_mcss,
                              machine_set_squash_mcss, NULL);
-    object_property_set_description(obj, "s390-squash-mcss",
+    object_property_set_description(obj, "s390-squash-mcss", "(deprecated) "
             "enable/disable squashing subchannels into the default css",
             NULL);
     object_property_set_bool(obj, false, "s390-squash-mcss", NULL);
diff --git a/qemu-doc.texi b/qemu-doc.texi
index d383ac44d4..90aa92d8b9 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2500,6 +2500,12 @@ enabled via the ``-machine usb=on'' argument.
 
 The ``-nodefconfig`` argument is a synonym for ``-no-user-config``.
 
+@subsection -machine virtio-ccw,s390-squash-mcss=on|off (since 2.12.0)
+
+Since version 2.12.0 the cssid can be chosen freely. Instead of squashing
+mcss for guest that don't support multiple channel subsystems we recommend
+putting all devices into the default channel subsystem (that is 0xfe).
+
 @section qemu-img command line arguments
 
 @subsection convert -s (since 2.0.0)
diff --git a/qemu-options.hx b/qemu-options.hx
index 3728e9b4dd..53b13ec203 100644
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
@@ -98,6 +98,10 @@ Enables or disables NVDIMM support. The default is off.
 @item s390-squash-mcss=on|off
 Enables or disables squashing subchannels into the default css.
 The default is off.
+NOTE: This property is deprecated and may be removed in future releases.
+Since version 2.12.0 the cssid can be chosen freely. Instead of squashing
+mcss for guest that don't support multiple channel subsystems we recommend
+putting all devices into the default channel subsystem (that is 0xfe).
 @item enforce-config-section=on|off
 If @option{enforce-config-section} is set to @var{on}, force migration
 code to send configuration section even if the machine-type sets the
-- 
2.13.5
