Received: from eggs.gnu.org ([2001:4830:134:3::10]:51950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBLww-0001DX-Ml
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBLws-00006P-Oj
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:58:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dBLws-00005k-Dl
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:58:38 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4IDrfsL024985
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 09:58:36 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahbsfktgy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 09:58:36 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 18 May 2017 07:58:35 -0600
From: Greg Kurz <groug@kaod.org>
Date: Thu, 18 May 2017 15:58:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <149511591185.8828.11947901967942107196.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH] spapr: ensure core_slot isn't NULL in
 spapr_core_unplug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

If we go that far on the path of hot-removing a core and we find out that
the core-id is invalid, then we have a serious bug.

Let's make it explicit with an assert() instead of dereferencing a NULL
pointer.

This fixes Coverity issue CID 1375404.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0980d733cd7a..1c5b814fc0bf 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2715,6 +2715,7 @@ static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     CPUCore *cc = CPU_CORE(dev);
     CPUArchId *core_slot = spapr_find_cpu_slot(ms, cc->core_id, NULL);
 
+    assert(core_slot);
     core_slot->cpu = NULL;
     object_unparent(OBJECT(dev));
 }
