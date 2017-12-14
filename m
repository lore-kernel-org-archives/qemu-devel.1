Received: from eggs.gnu.org ([2001:4830:134:3::10]:55898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX3a-0000zv-D3
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX3Z-0007yg-8h
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:12:26 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:48 +0100
Message-Id: <20171214171004.25058-31-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 30/46] s390x: deprecate s390-squash-mcss machine
 prop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

With the cssids unrestricted (commit "s390x/css: unrestrict cssids") the
s390-squash-mcss machine property should not be used.  Actually Libvirt
never supported this, so the expectation is that removing it should be
pretty painless.  But let's play nice and deprecate it first.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Message-Id: <20171206144438.28908-3-pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 7 ++++++-
 qemu-doc.texi              | 8 ++++++++
 qemu-options.hx            | 8 +++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 5d4aaaf158..fe3f3b2ad6 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -308,6 +308,11 @@ static void ccw_init(MachineState *machine)
     } else {
         ret = css_create_css_image(VIRTUAL_CSSID, true);
     }
+    if (qemu_opt_get(qemu_get_machine_opts(), "s390-squash-mcss")) {
+        warn_report("The machine property 's390-squash-mcss' is deprecated"
+                    " (obsoleted by lifting the cssid restrictions).");
+    }
+
     assert(ret == 0);
     if (css_migration_enabled()) {
         css_register_vmstate();
@@ -582,7 +587,7 @@ static inline void s390_machine_initfn(Object *obj)
     object_property_add_bool(obj, "s390-squash-mcss",
                              machine_get_squash_mcss,
                              machine_set_squash_mcss, NULL);
-    object_property_set_description(obj, "s390-squash-mcss",
+    object_property_set_description(obj, "s390-squash-mcss", "(deprecated) "
             "enable/disable squashing subchannels into the default css",
             NULL);
     object_property_set_bool(obj, false, "s390-squash-mcss", NULL);
diff --git a/qemu-doc.texi b/qemu-doc.texi
index ee206b8cba..f7317dfc66 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2501,6 +2501,14 @@ enabled via the ``-machine usb=on'' argument.
 
 The ``-nodefconfig`` argument is a synonym for ``-no-user-config``.
 
+@subsection -machine s390-squash-mcss=on|off (since 2.12.0)
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
2.13.6
