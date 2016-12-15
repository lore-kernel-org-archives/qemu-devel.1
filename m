Received: from eggs.gnu.org ([2001:4830:134:3::10]:43581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCS-00056f-Fw
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCP-0001jt-Bn
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCP-0001jK-1K
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:05 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hb8e056498
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:47:04 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm90wx4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:47:03 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:47:03 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:58 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-65-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 64/67] vl: Delay initialization of memory
 backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

Initialization of memory backends may take a while when
prealloc=yes is used, depending on their size. Initializing
memory backends before chardevs may delay the creation of monitor
sockets, and trigger timeouts on management software that waits
until the monitor socket is created by QEMU. See, for example,
the bug report at:
https://bugzilla.redhat.com/show_bug.cgi?id=1371211

In addition to that, allocating memory before calling
configure_accelerator() breaks the tcg_enabled() checks at
memory_region_init_*().

This patch fixes those problems by adding "memory-backend-*"
classes to the delayed-initialization list.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
(cherry picked from commit 6546d0dba6c211c1a3eac1252a4f50a0c151a08a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 vl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/vl.c b/vl.c
index 3414e1a..6a218ce 100644
--- a/vl.c
+++ b/vl.c
@@ -2811,6 +2811,19 @@ static bool object_create_initial(const char *type)
         return false;
     }
 
+    /* Memory allocation by backends needs to be done
+     * after configure_accelerator() (due to the tcg_enabled()
+     * checks at memory_region_init_*()).
+     *
+     * Also, allocation of large amounts of memory may delay
+     * chardev initialization for too long, and trigger timeouts
+     * on software that waits for a monitor socket to be created
+     * (e.g. libvirt).
+     */
+    if (g_str_has_prefix(type, "memory-backend-")) {
+        return false;
+    }
+
     return true;
 }
 
-- 
1.9.1
