Received: from eggs.gnu.org ([2001:4830:134:3::10]:44210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eKpCV-00089N-GH
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eKpCR-0001JT-Bo
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:34:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59988
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eKpCR-0001JA-5g
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:34:07 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB1ENgaE143406
	for <qemu-devel@nongnu.org>; Fri, 1 Dec 2017 09:31:54 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ek8p88yay-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 09:31:54 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 1 Dec 2017 14:31:52 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri,  1 Dec 2017 15:31:35 +0100
In-Reply-To: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
Message-Id: <20171201143136.62497-3-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/3] s390x/css: advertise unrestricted cssids
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

Let us advertise the changes introduced by "s390x/css: unrestrict cssids"
to the management software (so it can tell are cssids unrestricted or
restricted).

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---

Boris says having the property on the virtual-css-bridge is good form
Libvirt PoV. @Shalini: could you verify that things work out fine
(provided we get at least a preliminary blessing from Connie).

Consider squashing into "s390x/css: unrestrict cssids".
---
 hw/s390x/css-bridge.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index c4a9735d71..c7e8998680 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -123,6 +123,11 @@ static Property virtual_css_bridge_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static bool prop_get_true(Object *obj, Error **errp)
+{
+    return true;
+}
+
 static void virtual_css_bridge_class_init(ObjectClass *klass, void *data)
 {
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
@@ -131,6 +136,12 @@ static void virtual_css_bridge_class_init(ObjectClass *klass, void *data)
     hc->unplug = ccw_device_unplug;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->props = virtual_css_bridge_properties;
+    object_class_property_add_bool(klass, "cssid-unrestricted",
+                                   prop_get_true, NULL, NULL);
+    object_class_property_set_description(klass, "cssid-unrestricted",
+            "A css device can use any  cssid, regardless whether virtual"
+            " or not (read only, always true)",
+            NULL);
 }
 
 static const TypeInfo virtual_css_bridge_info = {
-- 
2.13.5
