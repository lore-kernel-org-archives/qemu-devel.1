Received: from eggs.gnu.org ([2001:4830:134:3::10]:60225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e5VwM-0005pG-1F
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e5VwI-0005AC-5S
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:58:14 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 20 Oct 2017 13:58:03 +0200
Message-Id: <20171020115803.14093-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] target/s390x: change CPU type name to
 "s390x-cpu"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, cohuck@redhat.com, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>

For now, e.g. host-s390-cpu wasn't exposed to the user. cpu-add, -cpu
and the CPU model qmp interfaces didn't care about the actual type,
as that information was hidden.

This changed with CPU hotplug via device_add. Now the type is visible to
the user. Before we get that supported in a stable version, this is our
last chance to change it.

So change it form "s390-cpu" to "s390x-cpu", to match the architecture
name. Example names are then e.g. z14-s390x-cpu or qemu-s390x-cpu.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 qapi-schema.json          | 4 ++--
 target/s390x/cpu-qom.h    | 2 +-
 target/s390x/cpu_models.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index a9dd043f65..18457954a8 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3159,12 +3159,12 @@
 # -> { "execute": "query-hotpluggable-cpus" }
 # <- {"return": [
 #      {
-#         "type": "qemu-s390-cpu", "vcpus-count": 1,
+#         "type": "qemu-s390x-cpu", "vcpus-count": 1,
 #         "props": { "core-id": 1 }
 #      },
 #      {
 #         "qom-path": "/machine/unattached/device[0]",
-#         "type": "qemu-s390-cpu", "vcpus-count": 1,
+#         "type": "qemu-s390x-cpu", "vcpus-count": 1,
 #         "props": { "core-id": 0 }
 #      }
 #    ]}
diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index 0510c49e07..b46217dc31 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -22,7 +22,7 @@
 
 #include "qom/cpu.h"
 
-#define TYPE_S390_CPU "s390-cpu"
+#define TYPE_S390_CPU "s390x-cpu"
 
 #define S390_CPU_CLASS(klass) \
     OBJECT_CLASS_CHECK(S390CPUClass, (klass), TYPE_S390_CPU)
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 9554f19eb4..c4c37b3b15 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -286,7 +286,7 @@ static void s390_print_cpu_model_list_entry(gpointer data, gpointer user_data)
         details = "(migration-safe)";
     }
 
-    /* strip off the -s390-cpu */
+    /* strip off the -s390x-cpu */
     g_strrstr(name, "-" TYPE_S390_CPU)[0] = 0;
     (*s->cpu_fprintf)(s->file, "s390 %-15s %-35s %s\n", name, scc->desc,
                       details);
@@ -390,7 +390,7 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
     char *name = g_strdup(object_class_get_name(klass));
     S390CPUClass *scc = S390_CPU_CLASS(klass);
 
-    /* strip off the -s390-cpu */
+    /* strip off the -s390x-cpu */
     g_strrstr(name, "-" TYPE_S390_CPU)[0] = 0;
     info = g_new0(CpuDefinitionInfo, 1);
     info->name = name;
-- 
2.13.6
