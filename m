Received: from eggs.gnu.org ([2001:4830:134:3::10]:42141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cEHs0-00087u-3L
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cEHru-00037u-DC
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:41:28 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:34005
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cEHru-00037e-4B
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:41:22 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB6Faefc031729
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 10:41:18 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 275x2agudf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 10:41:17 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 6 Dec 2016 08:41:17 -0700
From: Greg Kurz <groug@kaod.org>
Date: Tue, 06 Dec 2016 16:41:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148103887228.22326.478406873609299999.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH] qdev: fix the order compat and global
 properties are applied
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The current code recursively applies global properties from child up to
parent types. This can cause properties passed with the -global option to
be silently overridden by internal compat properties.

This is exactly what happens with virtio-*-pci drivers since commit:

"9a4c0e220d8a hw/virtio-pci: fix virtio behaviour"

Passing -device virtio-blk-pci.disable-modern=off has no effect on 2.6
machine types because the internal virtio-pci.disable-modern=on compat
property always prevail.

This patch fixes the issue by reversing the logic: we now go through the
global property list and, for each property, we check if it is applicable
to the device.

This result in compat properties being applied first, in the order they
appear in the HW_COMPAT_* macros, followed by global properties, in they
order appear on the command line.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/core/qdev-properties.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 5972108b2699..93a4dfeb0836 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1089,8 +1089,7 @@ int qdev_prop_check_globals(void)
     return ret;
 }
 
-static void qdev_prop_set_globals_for_type(DeviceState *dev,
-                                           const char *typename)
+void qdev_prop_set_globals(DeviceState *dev)
 {
     GList *l;
 
@@ -1098,7 +1097,7 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
         GlobalProperty *prop = l->data;
         Error *err = NULL;
 
-        if (strcmp(typename, prop->driver) != 0) {
+        if (object_dynamic_cast(OBJECT(dev), prop->driver) == NULL) {
             continue;
         }
         prop->used = true;
@@ -1120,16 +1119,6 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
     }
 }
 
-void qdev_prop_set_globals(DeviceState *dev)
-{
-    ObjectClass *class = object_get_class(OBJECT(dev));
-
-    do {
-        qdev_prop_set_globals_for_type(dev, object_class_get_name(class));
-        class = object_class_get_parent(class);
-    } while (class);
-}
-
 /* --- 64bit unsigned int 'size' type --- */
 
 static void get_size(Object *obj, Visitor *v, const char *name, void *opaque,
