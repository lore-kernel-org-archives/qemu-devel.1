Received: from eggs.gnu.org ([2001:4830:134:3::10]:56826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyPF-0008Uj-4s
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyPD-00047z-TP
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:05:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVyPD-00045W-Jk
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:05:07 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EB52e1037468
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:05:06 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpsv8em2y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:05:05 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 12:04:50 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:40:43 +0200
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500028867-134709-17-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 16/40] s390x/css: activate ChannelSubSys
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Turn on migration for the channel subsystem for the next machine.  For
legacy machines we still have to do things the old way.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Message-Id: <20170711145441.33925-6-pasic@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/css.c             | 5 +++++
 hw/s390x/s390-virtio-ccw.c | 9 ++++-----
 include/hw/s390x/css.h     | 4 ++++
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 0768fec..62db7f6 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -408,6 +408,11 @@ static int subch_dev_post_load(void *opaque, int version_id)
     return 0;
 }
 
+void css_register_vmstate(void)
+{
+    vmstate_register(NULL, 0, &vmstate_css, &channel_subsys);
+}
+
 IndAddr *get_indicator(hwaddr ind_addr, int len)
 {
     IndAddr *indicator;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 75bce6b..e086cb5 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -209,7 +209,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
 
     s390mc->ri_allowed = true;
     s390mc->cpu_model_allowed = true;
-    s390mc->css_migration_enabled = false; /* TODO: set to true */
+    s390mc->css_migration_enabled = true;
     mc->init = ccw_init;
     mc->reset = s390_machine_reset;
     mc->hot_add_cpu = s390_hot_add_cpu;
@@ -490,10 +490,9 @@ bool css_migration_enabled(void)
 
 static void ccw_machine_2_10_instance_options(MachineState *machine)
 {
-    /*
-     * TODO Once preparations are done register vmstate for the css if
-     * css_migration_enabled().
-     */
+    if (css_migration_enabled()) {
+        css_register_vmstate();
+    }
 }
 
 static void ccw_machine_2_10_class_options(MachineClass *mc)
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 8f08126..71076cb 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -234,4 +234,8 @@ extern PropertyInfo css_devid_ro_propinfo;
  */
 SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
                          Error **errp);
+
+/** Turn on css migration */
+void css_register_vmstate(void);
+
 #endif
-- 
2.7.4
