Received: from eggs.gnu.org ([2001:4830:134:3::10]:34045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fIaLx-00042q-WF
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fIaLu-0006Xk-R3
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:50:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1fIaLu-0006XM-Hs
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:50:54 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4FDkSbS036309
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 09:50:52 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hywq1s7cy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 09:50:52 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Tue, 15 May 2018 07:50:51 -0600
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Date: Tue, 15 May 2018 10:49:50 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20180515134950.3755-1-muriloo@linux.ibm.com>
Subject: [Qemu-devel] [PATCH] HACKING: document preference for g_new instead
 of g_malloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This patch documents the preference for g_new instead of g_malloc. The
reasons were adapted from commit b45c03f585ea9bb1af76c73e82195418c294919d.

Discussion in QEMU's mailing list:
  http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg03238.html

Cc: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 HACKING | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/HACKING b/HACKING
index 4125c97d8d..0fc3e0fc04 100644
--- a/HACKING
+++ b/HACKING
@@ -118,6 +118,15 @@ Please note that g_malloc will exit on allocation failure, so there
 is no need to test for failure (as you would have to with malloc).
 Calling g_malloc with a zero size is valid and will return NULL.
 
+Prefer g_new(T, n) instead of g_malloc(sizeof(T) * n) for the following
+reasons:
+
+  a. It catches multiplication overflowing size_t;
+  b. It returns T * instead of void *, letting compiler catch more type
+     errors.
+
+Declarations like T *v = g_malloc(sizeof(*v)) are acceptable, though.
+
 Memory allocated by qemu_memalign or qemu_blockalign must be freed with
 qemu_vfree, since breaking this will cause problems on Win32.
 
-- 
2.14.3
