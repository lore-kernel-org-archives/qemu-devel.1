Received: from eggs.gnu.org ([2001:4830:134:3::10]:41451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPV-00083F-DF
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPU-0005aE-5h
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:05 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:21 -0300
Message-Id: <20171006235023.11952-27-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 26/88] S390: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-s390x@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: more changes in hw/s390x/css.c, added target/s390x/cpu_models.c]
---
 hw/s390x/css.c            | 10 +++++-----
 hw/s390x/s390-pci-bus.c   |  4 ++--
 target/s390x/cpu_models.c | 12 ++++++------
 target/s390x/diag.c       |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 35683d7954..b6d4fcaf06 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -488,7 +488,7 @@ int css_create_css_image(uint8_t cssid, bool default_image)
     if (channel_subsys.css[cssid]) {
         return -EBUSY;
     }
-    channel_subsys.css[cssid] = g_malloc0(sizeof(CssImage));
+    channel_subsys.css[cssid] = g_new0(CssImage, 1);
     if (default_image) {
         channel_subsys.default_cssid = cssid;
     }
@@ -1778,7 +1778,7 @@ void css_undo_stcrw(CRW *crw)
 {
     CrwContainer *crw_cont;
 
-    crw_cont = g_try_malloc0(sizeof(CrwContainer));
+    crw_cont = g_try_new0(CrwContainer, 1);
     if (!crw_cont) {
         channel_subsys.crws_lost = true;
         return;
@@ -2185,7 +2185,7 @@ void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
     css = channel_subsys.css[cssid];
 
     if (!css->sch_set[ssid]) {
-        css->sch_set[ssid] = g_malloc0(sizeof(SubchSet));
+        css->sch_set[ssid] = g_new0(SubchSet, 1);
     }
     s_set = css->sch_set[ssid];
 
@@ -2206,7 +2206,7 @@ void css_queue_crw(uint8_t rsc, uint8_t erc, int solicited,
 
     trace_css_crw(rsc, erc, rsid, chain ? "(chained)" : "");
     /* TODO: Maybe use a static crw pool? */
-    crw_cont = g_try_malloc0(sizeof(CrwContainer));
+    crw_cont = g_try_new0(CrwContainer, 1);
     if (!crw_cont) {
         channel_subsys.crws_lost = true;
         return;
@@ -2498,7 +2498,7 @@ SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
         }
     }
 
-    sch = g_malloc0(sizeof(*sch));
+    sch = g_new0(SubchDev, 1);
     sch->cssid = bus_id.cssid;
     sch->ssid = bus_id.ssid;
     sch->devno = bus_id.devid;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 96116b7d1e..e7a58e81f7 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -240,7 +240,7 @@ static void s390_pci_generate_event(uint8_t cc, uint16_t pec, uint32_t fh,
     SeiContainer *sei_cont;
     S390pciState *s = s390_get_phb();
 
-    sei_cont = g_malloc0(sizeof(SeiContainer));
+    sei_cont = g_new0(SeiContainer, 1);
     sei_cont->fh = fh;
     sei_cont->fid = fid;
     sei_cont->cc = cc;
@@ -416,7 +416,7 @@ static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
     S390PCIIOMMU *iommu;
 
     if (!table) {
-        table = g_malloc0(sizeof(S390PCIIOMMUTable));
+        table = g_new0(S390PCIIOMMUTable, 1);
         table->key = key;
         g_hash_table_insert(s->iommu_table, &table->key, table);
     }
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 07ef8a3b6e..8c2d8851ae 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -392,7 +392,7 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
 
     /* strip off the -s390-cpu */
     g_strrstr(name, "-" TYPE_S390_CPU)[0] = 0;
-    info = g_malloc0(sizeof(*info));
+    info = g_new0(CpuDefinitionInfo, 1);
     info->name = name;
     info->has_migration_safe = true;
     info->migration_safe = scc->is_migration_safe;
@@ -412,7 +412,7 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
         object_unref(obj);
     }
 
-    entry = g_malloc0(sizeof(*entry));
+    entry = g_new0(CpuDefinitionInfoList, 1);
     entry->value = info;
     entry->next = *cpu_list;
     *cpu_list = entry;
@@ -574,7 +574,7 @@ CpuModelExpansionInfo *arch_query_cpu_model_expansion(CpuModelExpansionType type
     }
 
     /* convert it back to a static representation */
-    expansion_info = g_malloc0(sizeof(*expansion_info));
+    expansion_info = g_new0(CpuModelExpansionInfo, 1);
     expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
     cpu_info_from_model(expansion_info->model, &s390_model, delta_changes);
     return expansion_info;
@@ -585,7 +585,7 @@ static void list_add_feat(const char *name, void *opaque)
     strList **last = (strList **) opaque;
     strList *entry;
 
-    entry = g_malloc0(sizeof(*entry));
+    entry = g_new0(strList, 1);
     entry->value = g_strdup(name);
     entry->next = *last;
     *last = entry;
@@ -609,7 +609,7 @@ CpuModelCompareInfo *arch_query_cpu_model_comparison(CpuModelInfo *infoa,
     if (*errp) {
         return NULL;
     }
-    compare_info = g_malloc0(sizeof(*compare_info));
+    compare_info = g_new0(CpuModelCompareInfo, 1);
 
     /* check the cpu generation and ga level */
     if (modela.def->gen == modelb.def->gen) {
@@ -713,7 +713,7 @@ CpuModelBaselineInfo *arch_query_cpu_model_baseline(CpuModelInfo *infoa,
     bitmap_and(model.features, model.features, model.def->full_feat,
                S390_FEAT_MAX);
 
-    baseline_info = g_malloc0(sizeof(*baseline_info));
+    baseline_info = g_new0(CpuModelBaselineInfo, 1);
     baseline_info->model = g_malloc0(sizeof(*baseline_info->model));
     cpu_info_from_model(baseline_info->model, &model, true);
     return baseline_info;
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 82a623948d..dbbb9e886f 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -144,7 +144,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3)
             program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
             return;
         }
-        iplb = g_malloc0(sizeof(IplParameterBlock));
+        iplb = g_new0(IplParameterBlock, 1);
         cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
         if (!iplb_valid_len(iplb)) {
             env->regs[r1 + 1] = DIAG_308_RC_INVALID;
-- 
2.14.2
