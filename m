Received: from eggs.gnu.org ([2001:4830:134:3::10]:35633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cDv5O-0002WJ-Vf
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cDv5L-0000H9-O3
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:21:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cDv5L-00008Z-Em
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:21:43 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB5FJ8RW146771
	for <qemu-devel@nongnu.org>; Mon, 5 Dec 2016 10:21:29 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2759qnv63t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Dec 2016 10:21:28 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 5 Dec 2016 08:21:27 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 05 Dec 2016 16:21:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148095126363.31351.4484514300033863622.stgit@bahia>
Subject: [Qemu-devel] [PATCH for-2.8] qdev: apply global properties in
 reverse order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

The current code recursively applies global properties from child up to
parent. So, if you have:

-global virtio-pci.disable-modern=on
-global virtio-blk-pci.disable-modern=off

Then the default value of disable-modern for a virtio-blk-pci device is on,
which looks wrong from an OOP perspective.

This patch reverses the logic, so that a child property always prevail.

This fixes a subtle bug that got introduced in 2.7 with commit "9a4c0e220d8a
hw/virtio-pci: fix virtio behaviour" for older (< 2.7) machine types: the
HW_COMPAT_2_6 macro contains global virtio-pci.disable-* properties which
would silently override global properties passed on the command line for
virtio subtypes.

Signed-off-by: Greg Kurz <groug@kaod.org>
---

AFAIK, libvirt's XML doesn't know about modern/legacy modes for virtio
devices. Early adopters of virtio 1.0 had to rely on the <qemu:commandline>
tag to pass global properties to QEMU. This patch ensures that XML files
used with older machine types remain valid with newer versions of QEMU.

FWIW I guess it could help to have this fix in 2.8, and also probably in
2.7.1.

Please advise.

 hw/core/qdev-properties.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 2a8276806721..1345f489d6b1 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1119,11 +1119,20 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
 void qdev_prop_set_globals(DeviceState *dev)
 {
     ObjectClass *class = object_get_class(OBJECT(dev));
+    GSList *class_list = NULL;
 
     do {
-        qdev_prop_set_globals_for_type(dev, object_class_get_name(class));
+        class_list = g_slist_prepend(class_list, class);
         class = object_class_get_parent(class);
     } while (class);
+
+    do {
+        GSList *head = class_list;
+
+        qdev_prop_set_globals_for_type(dev, object_class_get_name(head->data));
+        class_list = g_slist_next(head);
+        g_slist_free_1(head);
+    } while (class_list);
 }
 
 /* --- 64bit unsigned int 'size' type --- */
