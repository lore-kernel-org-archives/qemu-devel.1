Received: from eggs.gnu.org ([2001:4830:134:3::10]:33515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f1TZe-0001zS-Vi
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f1TZa-000697-9G
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:10:22 -0400
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:39561)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f1TZZ-00066k-Qe
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:10:18 -0400
Received: from player729.ha.ovh.net (unknown [10.109.122.92])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 4D4CFA6C4F
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 11:10:16 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 29 Mar 2018 11:10:06 +0200
Message-ID: <152231460685.69730.14860451936216690693.stgit@bahia.lan>
In-Reply-To: <152231456507.69730.15601462044394150786.stgit@bahia.lan>
References: <152231456507.69730.15601462044394150786.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2/3] hw/s390x: fix memory leak in
 s390_init_ipl_dev()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

The string returned by object_property_get_str() is dynamically allocated.

Fixes: 3c4e9baacf4d9
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/s390x/s390-virtio-ccw.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 864145a7c6f3..435f7c99e77c 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -246,6 +246,7 @@ static void s390_init_ipl_dev(const char *kernel_filename,
 {
     Object *new = object_new(TYPE_S390_IPL);
     DeviceState *dev = DEVICE(new);
+    char *netboot_fw_prop;
 
     if (kernel_filename) {
         qdev_prop_set_string(dev, "kernel", kernel_filename);
@@ -256,9 +257,11 @@ static void s390_init_ipl_dev(const char *kernel_filename,
     qdev_prop_set_string(dev, "cmdline", kernel_cmdline);
     qdev_prop_set_string(dev, "firmware", firmware);
     qdev_prop_set_bit(dev, "enforce_bios", enforce_bios);
-    if (!strlen(object_property_get_str(new, "netboot_fw", &error_abort))) {
+    netboot_fw_prop = object_property_get_str(new, "netboot_fw", &error_abort);
+    if (!strlen(netboot_fw_prop)) {
         qdev_prop_set_string(dev, "netboot_fw", netboot_fw);
     }
+    g_free(netboot_fw_prop);
     object_property_add_child(qdev_get_machine(), TYPE_S390_IPL,
                               new, NULL);
     object_unref(new);
