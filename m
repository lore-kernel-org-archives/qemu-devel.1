Received: from eggs.gnu.org ([209.51.188.92]:44932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gr0Vo-000336-5V
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gr0JU-0005SR-09
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:58:56 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  5 Feb 2019 13:58:45 +0100
Message-Id: <1549371525-29899-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/cpu/cluster: Mark the cpu-cluster device
 with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc.michel@greensocs.com>, Alistair Francis <alistair.francis@wdc.com>, qemu-trivial@nongnu.org

The device can not be instantiated by the user and QEMU currently
aborts when you try to use it:

$ x86_64-softmmu/qemu-system-x86_64 -device cpu-cluster
qemu-system-x86_64: hw/cpu/cluster.c:73: cpu_cluster_realize:
 Assertion `cbdata.cpu_count > 0' failed.
Aborted (core dumped)

Since this is an internal device only, mark it with user_creatable = false.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/cpu/cluster.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
index 25f9070..6f5f037 100644
--- a/hw/cpu/cluster.c
+++ b/hw/cpu/cluster.c
@@ -79,6 +79,9 @@ static void cpu_cluster_class_init(ObjectClass *klass, void *data)
 
     dc->props = cpu_cluster_properties;
     dc->realize = cpu_cluster_realize;
+
+    /* This is not directly for users, CPU children must be attached by code */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo cpu_cluster_type_info = {
-- 
1.8.3.1
