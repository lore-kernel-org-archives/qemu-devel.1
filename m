Received: from eggs.gnu.org ([2001:4830:134:3::10]:48466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCf-0001Vs-E0
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCc-0005ld-84
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55591
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCc-0005l8-36
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:22 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0ERDK087587
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:21 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmvhgaraa-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:21 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:21 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:28 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-54-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 53/79] target/ppc: fix memory leak in
 kvmppc_is_mem_backend_page_size_ok()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The string returned by object_property_get_str() is dynamically allocated.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 2d3e302ec2246d703ffa8d8f8769a3fa448d8145)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/ppc/kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 89f3586..b1dd41c 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -423,6 +423,7 @@ bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
 
     if (mempath) {
         pagesize = qemu_mempath_getpagesize(mempath);
+        g_free(mempath);
     } else {
         pagesize = getpagesize();
     }
-- 
2.7.4
