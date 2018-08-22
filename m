Received: from eggs.gnu.org ([2001:4830:134:3::10]:38821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRp3-0006e9-BX
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRot-0008CW-7j
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57296 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsRos-0008BQ-Tf
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:03 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 14:00:32 +0200
Message-Id: <20180822120050.12694-3-quintela@redhat.com>
In-Reply-To: <20180822120050.12694-1-quintela@redhat.com>
References: <20180822120050.12694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 02/20] migration: Correctly handle subsections
 with no 'needed' function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/vmstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 6b9079bb51..0bc240a317 100644
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
