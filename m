Received: from eggs.gnu.org ([209.51.188.92]:34456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw93O-0003P8-Te
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw93K-0000W2-E5
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:19:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gw93E-0008U6-3W
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:19:27 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1JHEUE6126718
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:19:09 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qrm1aya1c-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:19:09 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 19 Feb 2019 17:19:06 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 19 Feb 2019 18:18:59 +0100
In-Reply-To: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155059673939.1466090.14354001937819612724.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH v5 17/17] tests/device-plug: Add PHB unplug
 request test for spapr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

We can easily test this, just like PCI. PHB unplug is not supported
on s390x and x86 ACPI.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/device-plug-test.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/device-plug-test.c b/tests/device-plug-test.c
index 87593d9ecfda..318e422d518c 100644
--- a/tests/device-plug-test.c
+++ b/tests/device-plug-test.c
@@ -132,6 +132,20 @@ static void test_spapr_memory_unplug_request(void)
     qtest_quit(qtest);
 }
 
+static void test_spapr_phb_unplug_request(void)
+{
+    QTestState *qtest;
+
+    qtest = qtest_initf("-device spapr-pci-host-bridge,index=1,id=dev0");
+
+    /* similar to test_pci_unplug_request */
+    device_del_request(qtest, "dev0");
+    system_reset(qtest);
+    wait_device_deleted_event(qtest, "dev0");
+
+    qtest_quit(qtest);
+}
+
 int main(int argc, char **argv)
 {
     const char *arch = qtest_get_arch();
@@ -156,6 +170,8 @@ int main(int argc, char **argv)
                        test_spapr_cpu_unplug_request);
         qtest_add_func("/device-plug/spapr-memory-unplug-request",
                        test_spapr_memory_unplug_request);
+        qtest_add_func("/device-plug/spapr-phb-unplug-request",
+                       test_spapr_phb_unplug_request);
     }
 
     return g_test_run();
