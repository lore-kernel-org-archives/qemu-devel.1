Received: from eggs.gnu.org ([2001:4830:134:3::10]:49619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCY-0000ox-Fz
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCV-0000qL-S4
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCV-0000oz-Hx
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:47 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JECCk044598
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:46 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epmpw5eeu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:45 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:45 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:33 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-41-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 40/55] util/stats64: Fix min/max comparisons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Max Reitz <mreitz@redhat.com>

stat64_min_slow() and stat64_max_slow() compare the wrong way.  This
makes iotest 136 fail with clang and -m32.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20171114232223.25207-1-mreitz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 26a5db322be1e424a815d070ddd04442a5e5df50)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 util/stats64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/stats64.c b/util/stats64.c
index 9968fcceac..389c365a9e 100644
--- a/util/stats64.c
+++ b/util/stats64.c
@@ -91,7 +91,7 @@ bool stat64_min_slow(Stat64 *s, uint64_t value)
     low = atomic_read(&s->low);
 
     orig = ((uint64_t)high << 32) | low;
-    if (orig < value) {
+    if (value < orig) {
         /* We have to set low before high, just like stat64_min reads
          * high before low.  The value may become higher temporarily, but
          * stat64_get does not notice (it takes the lock) and the only ill
@@ -120,7 +120,7 @@ bool stat64_max_slow(Stat64 *s, uint64_t value)
     low = atomic_read(&s->low);
 
     orig = ((uint64_t)high << 32) | low;
-    if (orig > value) {
+    if (value > orig) {
         /* We have to set low before high, just like stat64_max reads
          * high before low.  The value may become lower temporarily, but
          * stat64_get does not notice (it takes the lock) and the only ill
-- 
2.11.0
