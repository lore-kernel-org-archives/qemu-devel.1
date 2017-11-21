Received: from eggs.gnu.org ([2001:4830:134:3::10]:46733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eH6Zk-0006jF-A4
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 06:18:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eH6Zg-00082b-6m
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 06:18:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eH6Zf-00081a-UE
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 06:18:44 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vALBI3qC034837
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 06:18:37 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ecjmvhyr8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 06:18:36 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 21 Nov 2017 11:18:30 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 21 Nov 2017 12:18:25 +0100
Message-Id: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
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

The default css 0xFE is currently restricted to virtual subchannel
devices. The hope when the decision was made was, that non-virtual
subchannel devices will come around when guest can exploit multiple
channel subsystems. Since the guests generally don't do, the pain
of the partitioned (cssid) namespace outweighs the gain.

Let us remove the corresponding restrictions (virtual devices
can be put only in 0xFE and non-virtual devices in any css except
the 0xFE), and inform management software property on all ccw
devices.

The adverse effect on migration should not be too severe as
vfio-ccw devices are not live-migratable yet, and for virtual
devices using the extra freedom would only make sense with
the aforementioned guest support in place.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

---
Hi!

About indicating this at the ccw devices instead of, e.g. as a machine
property (or otherwise globally), was requested by our libvirt guys. I
have no strong opinion regarding in this matter.

This patch is intended as a discussion starter. I would at least like to
get a Tested-by by Shalini before promoting it to non-RFC (provided the
discussion goes well).

TODOs:
* Consider adding a description for the new property.
* Consider renaming VIRTUAL_CSSID.
* Consider changing the bus-id generation scheme (when
devno is not specified by the user). his patch keep the current scheme in
place: they won't go into the default css (but slots are filled up
starting at cssid 0). This is theoretically good for migration
compatibility same command line same addresses.  Practically since there
is no migratable non-virtual ccw device, we should consider using the
same bus-id generation scheme for virtual and non-virtual devices.

---
 hw/s390x/ccw-device.c | 6 ++++++
 hw/s390x/css.c        | 9 ---------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index f9bfa154d6..2167ccea5d 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -40,6 +40,10 @@ static Property ccw_device_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static bool prop_get_true(Object *obj, Error **errp)
+{
+    return true;
+}
 static void ccw_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -48,6 +52,8 @@ static void ccw_device_class_init(ObjectClass *klass, void *data)
     k->realize = ccw_device_realize;
     k->refill_ids = ccw_device_refill_ids;
     dc->props = ccw_device_properties;
+    object_class_property_add_bool(klass, "cssid-unrestricted",
+                                   prop_get_true, NULL, NULL);
 }
 
 const VMStateDescription vmstate_ccw_dev = {
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index f6b5c807cd..957cb9ec90 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2377,15 +2377,6 @@ SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
     SubchDev *sch;
 
     if (bus_id.valid) {
-        if (is_virtual != (bus_id.cssid == VIRTUAL_CSSID)) {
-            error_setg(errp, "cssid %hhx not valid for %s devices",
-                       bus_id.cssid,
-                       (is_virtual ? "virtual" : "non-virtual"));
-            return NULL;
-        }
-    }
-
-    if (bus_id.valid) {
         if (squash_mcss) {
             bus_id.cssid = channel_subsys.default_cssid;
         } else if (!channel_subsys.css[bus_id.cssid]) {
-- 
2.13.5
