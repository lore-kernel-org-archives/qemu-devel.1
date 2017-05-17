Received: from eggs.gnu.org ([2001:4830:134:3::10]:56275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dApyv-0004Dz-QB
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dApyr-0000mQ-DN
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:50:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34802
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dApyr-0000m3-6f
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:50:33 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4H3hi2t172539
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 23:50:32 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2agemcrpmv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 23:50:32 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 17 May 2017 13:50:29 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Wed, 17 May 2017 09:19:17 +0530
In-Reply-To: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1494992962-6929-2-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v1 1/6] migration: Fix unregister_savevm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

In unregister_savevm(), free se->compat only if it was allocated earlier.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 migration/savevm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 352a8f2..7a268ec 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -648,7 +648,9 @@ void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque)
     QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se) {
         if (strcmp(se->idstr, id) == 0 && se->opaque == opaque) {
             QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
-            g_free(se->compat);
+            if (dev) {
+                g_free(se->compat);
+            }
             g_free(se->ops);
             g_free(se);
         }
-- 
2.7.4
