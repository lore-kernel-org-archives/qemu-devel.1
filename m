Received: from eggs.gnu.org ([2001:4830:134:3::10]:48111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fn1ek-0000wq-Qn
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fn1eg-0006CV-RW
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:04:10 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fn1eg-00069l-HO
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:04:06 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Aug 2018 14:03:55 +0100
Message-Id: <20180807130355.29780-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] migration: Correctly handle subsections with
 no 'needed' function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Currently the vmstate subsection handling code treats a subsection
with no 'needed' function pointer as if it were the subsection
list terminator, so the subsection is never transferred and nor
is any subsection following it in the list.

Handle NULL 'needed' function pointers in subsections in the same
way that we do for top level VMStateDescription structures:
treat the subsection as always being needed.

This doesn't change behaviour for the current set of devices
in the tree, because all subsections declare a 'needed' function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
NB: last para in the commit message is only true once the
"Arm migration fixes for 3.0" patchset has been committed.
We could optionally drop some of the "use a dummy needed fn"
changes once this is in...

I thought I'd sent this out a few days back, but apparently not,
since it's not on-list...

 migration/vmstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 6b9079bb51e..0bc240a3175 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -418,7 +418,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 static const VMStateDescription *
 vmstate_get_subsection(const VMStateDescription **sub, char *idstr)
 {
-    while (sub && *sub && (*sub)->needed) {
+    while (sub && *sub) {
         if (strcmp(idstr, (*sub)->name) == 0) {
             return *sub;
         }
@@ -486,8 +486,8 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
     int ret = 0;
 
     trace_vmstate_subsection_save_top(vmsd->name);
-    while (sub && *sub && (*sub)->needed) {
-        if ((*sub)->needed(opaque)) {
+    while (sub && *sub) {
+        if (vmstate_save_needed(*sub, opaque)) {
             const VMStateDescription *vmsdsub = *sub;
             uint8_t len;
 
-- 
2.17.1
