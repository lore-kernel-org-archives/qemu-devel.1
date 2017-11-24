Received: from eggs.gnu.org ([2001:4830:134:3::10]:33326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eI5Wh-0002Rr-Qv
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 23:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eI5Wh-0005Xd-2F
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 23:23:43 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 24 Nov 2017 15:23:25 +1100
Message-Id: <20171124042325.28012-3-sjitindarsingh@gmail.com>
In-Reply-To: <20171124042325.28012-1-sjitindarsingh@gmail.com>
References: <20171124042325.28012-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 2/2] target/ppc: Fix setting of
 cpu->compat_pvr on incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, sjitindarsingh@gmail.com, groug@kaod.org

cpu->compat_pvr is used to store the current compat mode of the cpu.

On the receiving side during incoming migration we check compatibility
with the compat mode by calling ppc_set_compat(). However we fail to set
the compat mode with the hypervisor since the "new" compat mode doesn't
differ from the current (due to a "cpu->compat_pvr != compat_pvr" check).
This means that kvm runs the vcpus without a compat mode, which is the
incorrect behaviour. The implication being that a compatibility mode
will never be in effect after migration.

To fix this so that the compat mode is correctly set with the
hypervisor, store the desired compat mode and reset cpu->compat_pvr to
zero before calling ppc_set_compat().

Fixes: 5dfaa532 ("ppc: fix ppc_set_compat() with KVM PR")

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

---

It is worth noting that another option was to add a force flag to the
ppc_set_compat() function, but the enacted solution seemed cleaner with
fewer code changes.
---
 target/ppc/machine.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 384caee800..24117e8f31 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -237,9 +237,11 @@ static int cpu_post_load(void *opaque, int version_id)
 
 #if defined(TARGET_PPC64)
     if (cpu->compat_pvr) {
+        uint32_t compat_pvr = cpu->compat_pvr;
         Error *local_err = NULL;
 
-        ppc_set_compat(cpu, cpu->compat_pvr, &local_err);
+        cpu->compat_pvr = 0;
+        ppc_set_compat(cpu, compat_pvr, &local_err);
         if (local_err) {
             error_report_err(local_err);
             return -1;
-- 
2.13.6
