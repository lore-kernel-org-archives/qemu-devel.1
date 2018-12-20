Received: from eggs.gnu.org ([2001:4830:134:3::10]:52525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ga1RB-0000E6-Jt
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 11:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ga1R9-0004C9-Fx
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 11:44:41 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 20 Dec 2018 17:44:32 +0100
Message-Id: <20181220164433.21705-2-cohuck@redhat.com>
In-Reply-To: <20181220164433.21705-1-cohuck@redhat.com>
References: <20181220164433.21705-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] hw/s390/ccw.c: Don't take address of packed
 members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Peter Maydell <peter.maydell@linaro.org>

Taking the address of a field in a packed struct is a bad idea, because
it might not be actually aligned enough for that pointer type (and
thus cause a crash on dereference on some host architectures). Newer
versions of clang warn about this.

Avoid the problem by using local copies of the PMCW and SCSW
struct fields in copy_schib_from_guest() and copy_schib_to_guest().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20181213120252.21697-1-peter.maydell@linaro.org>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 04ec5cc970..f92b046cd3 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1290,9 +1290,19 @@ void copy_scsw_to_guest(SCSW *dest, const SCSW *src)
 static void copy_schib_to_guest(SCHIB *dest, const SCHIB *src)
 {
     int i;
-
-    copy_pmcw_to_guest(&dest->pmcw, &src->pmcw);
-    copy_scsw_to_guest(&dest->scsw, &src->scsw);
+    /*
+     * We copy the PMCW and SCSW in and out of local variables to
+     * avoid taking the address of members of a packed struct.
+     */
+    PMCW src_pmcw, dest_pmcw;
+    SCSW src_scsw, dest_scsw;
+
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
-
-    copy_pmcw_from_guest(&dest->pmcw, &src->pmcw);
-    copy_scsw_from_guest(&dest->scsw, &src->scsw);
+    /*
+     * We copy the PMCW and SCSW in and out of local variables to
+     * avoid taking the address of members of a packed struct.
+     */
+    PMCW src_pmcw, dest_pmcw;
+    SCSW src_scsw, dest_scsw;
+
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
2.17.2
