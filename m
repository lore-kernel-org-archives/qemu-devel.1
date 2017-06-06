Received: from eggs.gnu.org ([2001:4830:134:3::10]:50148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIGKD-0001VM-8E
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIGK7-0006Sh-8o
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:23:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIGK6-0006R4-Uk
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:23:11 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v56FJY3L027337
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 11:23:09 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2awxj1sdrr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 11:23:09 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 6 Jun 2017 16:23:03 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue, 06 Jun 2017 17:22:58 +0200
In-Reply-To: <149676256254.31274.13156728863519964419.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <149676256254.31274.13156728863519964419.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <149676257896.31274.8551304687945725648.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH 3/3] spapr: fix memory leak in
 spapr_memory_pre_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The string returned by object_property_get_str() is dynamically allocated.

(Spotted by Coverity, CID 1375942)

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 86e622834f63..f834a6a7dfac 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2617,8 +2617,11 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
         error_setg(errp, "Memory backend has bad page size. "
                    "Use 'memory-backend-file' with correct mem-path.");
-        return;
+        goto out;
     }
+
+out:
+    g_free(mem_dev);
 }
 
 struct sPAPRDIMMState {
