Received: from eggs.gnu.org ([2001:4830:134:3::10]:39268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dq3CN-0004kC-11
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dq3CI-0002Y6-6u
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:14:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dq3CH-0002Xm-Ue
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:14:46 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Sep 2017 22:13:34 +0200
Message-Id: <20170907201335.13956-21-david@redhat.com>
In-Reply-To: <20170907201335.13956-1-david@redhat.com>
References: <20170907201335.13956-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 20/21] s390x: generate sclp cpu information
 from possible_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>

This is the first step to allow hot plugging of CPUs in a non-sequential
order. If a cpu is available ("plugged") can directly be decided by
looking at the cpu state pointer.

This makes sure, that really only cpus attached to the machine are
reported.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/sclp.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index fd097262c7..30aefbfd15 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -34,16 +34,21 @@ static inline SCLPDevice *get_sclp_device(void)
     return sclp;
 }
 
-static void prepare_cpu_entries(SCLPDevice *sclp, CPUEntry *entry, int count)
+static void prepare_cpu_entries(SCLPDevice *sclp, CPUEntry *entry, int *count)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     uint8_t features[SCCB_CPU_FEATURE_LEN] = { 0 };
     int i;
 
     s390_get_feat_block(S390_FEAT_TYPE_SCLP_CPU, features);
-    for (i = 0; i < count; i++) {
-        entry[i].address = i;
-        entry[i].type = 0;
-        memcpy(entry[i].features, features, sizeof(entry[i].features));
+    for (i = 0, *count = 0; i < ms->possible_cpus->len; i++) {
+        if (!ms->possible_cpus->cpus[i].cpu) {
+            continue;
+        }
+        entry[*count].address = ms->possible_cpus->cpus[i].arch_id;
+        entry[*count].type = 0;
+        memcpy(entry[*count].features, features, sizeof(features));
+        (*count)++;
     }
 }
 
@@ -53,17 +58,13 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     ReadInfo *read_info = (ReadInfo *) sccb;
     MachineState *machine = MACHINE(qdev_get_machine());
     sclpMemoryHotplugDev *mhd = get_sclp_memory_hotplug_dev();
-    CPUState *cpu;
-    int cpu_count = 0;
+    int cpu_count;
     int rnsize, rnmax;
     int slots = MIN(machine->ram_slots, s390_get_memslot_count());
     IplParameterBlock *ipib = s390_ipl_get_iplb();
 
-    CPU_FOREACH(cpu) {
-        cpu_count++;
-    }
-
     /* CPU information */
+    prepare_cpu_entries(sclp, read_info->entries, &cpu_count);
     read_info->entries_cpu = cpu_to_be16(cpu_count);
     read_info->offset_cpu = cpu_to_be16(offsetof(ReadInfo, entries));
     read_info->highest_cpu = cpu_to_be16(max_cpus);
@@ -76,8 +77,6 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
                          read_info->conf_char_ext);
 
-    prepare_cpu_entries(sclp, read_info->entries, cpu_count);
-
     read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
                                         SCLP_HAS_IOA_RECONFIG);
 
@@ -333,13 +332,9 @@ static void unassign_storage(SCLPDevice *sclp, SCCB *sccb)
 static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
 {
     ReadCpuInfo *cpu_info = (ReadCpuInfo *) sccb;
-    CPUState *cpu;
-    int cpu_count = 0;
-
-    CPU_FOREACH(cpu) {
-        cpu_count++;
-    }
+    int cpu_count;
 
+    prepare_cpu_entries(sclp, cpu_info->entries, &cpu_count);
     cpu_info->nr_configured = cpu_to_be16(cpu_count);
     cpu_info->offset_configured = cpu_to_be16(offsetof(ReadCpuInfo, entries));
     cpu_info->nr_standby = cpu_to_be16(0);
@@ -348,7 +343,6 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
     cpu_info->offset_standby = cpu_to_be16(cpu_info->offset_configured
         + cpu_info->nr_configured*sizeof(CPUEntry));
 
-    prepare_cpu_entries(sclp, cpu_info->entries, cpu_count);
 
     sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_READ_COMPLETION);
 }
-- 
2.13.5
