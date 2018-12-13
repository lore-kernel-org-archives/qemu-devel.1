Received: from eggs.gnu.org ([2001:4830:134:3::10]:59527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXPhs-0005lt-O0
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:03:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXPhm-0006tG-Li
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:03:08 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 12:02:52 +0000
Message-Id: <20181213120252.21697-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] hw/s390/ccw.c: Don't take address of packed
 members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Farhan Ali <alifm@linux.ibm.com>

Taking the address of a field in a packed struct is a bad idea, because
it might not be actually aligned enough for that pointer type (and
thus cause a crash on dereference on some host architectures). Newer
versions of clang warn about this.

Avoid the problem by using local copies of the PMCW and SCSW
struct fields in copy_schib_from_guest() and copy_schib_to_guest().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v1->v2 changes:
 * add comment about why we're using locals
 * name locals with underscores, as QEMU's naming conventions recommend


 hw/s390x/css.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 04ec5cc9705..f92b046cd33 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1290,9 +1290,19 @@ void copy_scsw_to_guest(SCSW *dest, const SCSW *src)
 static void copy_schib_to_guest(SCHIB *dest, const SCHIB *src)
 {
     int i;
+    /*
+     * We copy the PMCW and SCSW in and out of local variables to
+     * avoid taking the address of members of a packed struct.
+     */
+    PMCW src_pmcw, dest_pmcw;
+    SCSW src_scsw, dest_scsw;
 
-    copy_pmcw_to_guest(&dest->pmcw, &src->pmcw);
-    copy_scsw_to_guest(&dest->scsw, &src->scsw);
+    src_pmcw = src->pmcw;
+    copy_pmcw_to_guest(&dest_pmcw, &src_pmcw);
+    dest->pmcw = dest_pmcw;
+    src_scsw = src->scsw;
+    copy_scsw_to_guest(&dest_scsw, &src_scsw);
+    dest->scsw = dest_scsw;
     dest->mba = cpu_to_be64(src->mba);
     for (i = 0; i < ARRAY_SIZE(dest->mda); i++) {
         dest->mda[i] = src->mda[i];
@@ -1339,9 +1349,19 @@ static void copy_scsw_from_guest(SCSW *dest, const SCSW *src)
 static void copy_schib_from_guest(SCHIB *dest, const SCHIB *src)
 {
     int i;
+    /*
+     * We copy the PMCW and SCSW in and out of local variables to
+     * avoid taking the address of members of a packed struct.
+     */
+    PMCW src_pmcw, dest_pmcw;
+    SCSW src_scsw, dest_scsw;
 
-    copy_pmcw_from_guest(&dest->pmcw, &src->pmcw);
-    copy_scsw_from_guest(&dest->scsw, &src->scsw);
+    src_pmcw = src->pmcw;
+    copy_pmcw_from_guest(&dest_pmcw, &src_pmcw);
+    dest->pmcw = dest_pmcw;
+    src_scsw = src->scsw;
+    copy_scsw_from_guest(&dest_scsw, &src_scsw);
+    dest->scsw = dest_scsw;
     dest->mba = be64_to_cpu(src->mba);
     for (i = 0; i < ARRAY_SIZE(dest->mda); i++) {
         dest->mda[i] = src->mda[i];
-- 
2.19.2
