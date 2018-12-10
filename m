Received: from eggs.gnu.org ([2001:4830:134:3::10]:45961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gWM4Y-0000dj-F5
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gWM4X-0002fT-1q
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:58:10 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 13:58:03 +0000
Message-Id: <20181210135803.20208-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/s390/ccw.c: Don't take address of packed
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
Cc: patches@linaro.org, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Taking the address of a field in a packed struct is a bad idea, because
it might not be actually aligned enough for that pointer type (and
thus cause a crash on dereference on some host architectures). Newer
versions of clang warn about this.

Avoid the problem by using local copies of the PMCW and SCSW
struct fields in copy_schib_from_guest() and copy_schib_to_guest().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This seemed like a not totally ugly and reasonably localised fix
that satisfies clang. Oddly, this makes the generated object file
15K smaller (421K vs 406K), so it might even be better code...

 hw/s390x/css.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 04ec5cc9705..ef07691e36b 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1290,9 +1290,15 @@ void copy_scsw_to_guest(SCSW *dest, const SCSW *src)
 static void copy_schib_to_guest(SCHIB *dest, const SCHIB *src)
 {
     int i;
+    PMCW srcpmcw, destpmcw;
+    SCSW srcscsw, destscsw;
 
-    copy_pmcw_to_guest(&dest->pmcw, &src->pmcw);
-    copy_scsw_to_guest(&dest->scsw, &src->scsw);
+    srcpmcw = src->pmcw;
+    copy_pmcw_to_guest(&destpmcw, &srcpmcw);
+    dest->pmcw = destpmcw;
+    srcscsw = src->scsw;
+    copy_scsw_to_guest(&destscsw, &srcscsw);
+    dest->scsw = destscsw;
     dest->mba = cpu_to_be64(src->mba);
     for (i = 0; i < ARRAY_SIZE(dest->mda); i++) {
         dest->mda[i] = src->mda[i];
@@ -1339,9 +1345,15 @@ static void copy_scsw_from_guest(SCSW *dest, const SCSW *src)
 static void copy_schib_from_guest(SCHIB *dest, const SCHIB *src)
 {
     int i;
+    PMCW srcpmcw, destpmcw;
+    SCSW srcscsw, destscsw;
 
-    copy_pmcw_from_guest(&dest->pmcw, &src->pmcw);
-    copy_scsw_from_guest(&dest->scsw, &src->scsw);
+    srcpmcw = src->pmcw;
+    copy_pmcw_from_guest(&destpmcw, &srcpmcw);
+    dest->pmcw = destpmcw;
+    srcscsw = src->scsw;
+    copy_scsw_from_guest(&destscsw, &srcscsw);
+    dest->scsw = destscsw;
     dest->mba = be64_to_cpu(src->mba);
     for (i = 0; i < ARRAY_SIZE(dest->mda); i++) {
         dest->mda[i] = src->mda[i];
-- 
2.19.2
