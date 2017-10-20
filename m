Received: from eggs.gnu.org ([2001:4830:134:3::10]:58341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vss-00023C-I7
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vso-0002jD-1r
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:54:38 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:33 +0200
Message-Id: <20171020115418.2050-2-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/46] S390: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cornelia Huck <cohuck@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
[PMD: more changes in hw/s390x/css.c, added target/s390x/cpu_models.c]
Message-Id: <20171006235023.11952-27-f4bug@amsat.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
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
@@ -488,7 +488,7 @@ int css_create_css_image(uint8_t cssid, bool default_=
image)
     if (channel_subsys.css[cssid]) {
         return -EBUSY;
     }
-    channel_subsys.css[cssid] =3D g_malloc0(sizeof(CssImage));
+    channel_subsys.css[cssid] =3D g_new0(CssImage, 1);
     if (default_image) {
         channel_subsys.default_cssid =3D cssid;
     }
@@ -1778,7 +1778,7 @@ void css_undo_stcrw(CRW *crw)
 {
     CrwContainer *crw_cont;
=20
-    crw_cont =3D g_try_malloc0(sizeof(CrwContainer));
+    crw_cont =3D g_try_new0(CrwContainer, 1);
     if (!crw_cont) {
         channel_subsys.crws_lost =3D true;
         return;
@@ -2185,7 +2185,7 @@ void css_subch_assign(uint8_t cssid, uint8_t ssid, =
uint16_t schid,
     css =3D channel_subsys.css[cssid];
=20
     if (!css->sch_set[ssid]) {
-        css->sch_set[ssid] =3D g_malloc0(sizeof(SubchSet));
+        css->sch_set[ssid] =3D g_new0(SubchSet, 1);
     }
     s_set =3D css->sch_set[ssid];
=20
@@ -2206,7 +2206,7 @@ void css_queue_crw(uint8_t rsc, uint8_t erc, int so=
licited,
=20
     trace_css_crw(rsc, erc, rsid, chain ? "(chained)" : "");
     /* TODO: Maybe use a static crw pool? */
-    crw_cont =3D g_try_malloc0(sizeof(CrwContainer));
+    crw_cont =3D g_try_new0(CrwContainer, 1);
     if (!crw_cont) {
         channel_subsys.crws_lost =3D true;
         return;
@@ -2498,7 +2498,7 @@ SubchDev *css_create_sch(CssDevId bus_id, bool is_v=
irtual, bool squash_mcss,
         }
     }
=20
-    sch =3D g_malloc0(sizeof(*sch));
+    sch =3D g_new0(SubchDev, 1);
     sch->cssid =3D bus_id.cssid;
     sch->ssid =3D bus_id.ssid;
     sch->devno =3D bus_id.devid;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 96116b7d1e..e7a58e81f7 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -240,7 +240,7 @@ static void s390_pci_generate_event(uint8_t cc, uint1=
6_t pec, uint32_t fh,
     SeiContainer *sei_cont;
     S390pciState *s =3D s390_get_phb();
=20
-    sei_cont =3D g_malloc0(sizeof(SeiContainer));
+    sei_cont =3D g_new0(SeiContainer, 1);
     sei_cont->fh =3D fh;
     sei_cont->fid =3D fid;
     sei_cont->cc =3D cc;
@@ -416,7 +416,7 @@ static S390PCIIOMMU *s390_pci_get_iommu(S390pciState =
*s, PCIBus *bus,
     S390PCIIOMMU *iommu;
=20
     if (!table) {
-        table =3D g_malloc0(sizeof(S390PCIIOMMUTable));
+        table =3D g_new0(S390PCIIOMMUTable, 1);
         table->key =3D key;
         g_hash_table_insert(s->iommu_table, &table->key, table);
     }
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 07ef8a3b6e..8c2d8851ae 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -392,7 +392,7 @@ static void create_cpu_model_list(ObjectClass *klass,=
 void *opaque)
=20
     /* strip off the -s390-cpu */
     g_strrstr(name, "-" TYPE_S390_CPU)[0] =3D 0;
-    info =3D g_malloc0(sizeof(*info));
+    info =3D g_new0(CpuDefinitionInfo, 1);
     info->name =3D name;
     info->has_migration_safe =3D true;
     info->migration_safe =3D scc->is_migration_safe;
@@ -412,7 +412,7 @@ static void create_cpu_model_list(ObjectClass *klass,=
 void *opaque)
         object_unref(obj);
     }
=20
-    entry =3D g_malloc0(sizeof(*entry));
+    entry =3D g_new0(CpuDefinitionInfoList, 1);
     entry->value =3D info;
     entry->next =3D *cpu_list;
     *cpu_list =3D entry;
@@ -574,7 +574,7 @@ CpuModelExpansionInfo *arch_query_cpu_model_expansion=
(CpuModelExpansionType type
     }
=20
     /* convert it back to a static representation */
-    expansion_info =3D g_malloc0(sizeof(*expansion_info));
+    expansion_info =3D g_new0(CpuModelExpansionInfo, 1);
     expansion_info->model =3D g_malloc0(sizeof(*expansion_info->model));
     cpu_info_from_model(expansion_info->model, &s390_model, delta_change=
s);
     return expansion_info;
@@ -585,7 +585,7 @@ static void list_add_feat(const char *name, void *opa=
que)
     strList **last =3D (strList **) opaque;
     strList *entry;
=20
-    entry =3D g_malloc0(sizeof(*entry));
+    entry =3D g_new0(strList, 1);
     entry->value =3D g_strdup(name);
     entry->next =3D *last;
     *last =3D entry;
@@ -609,7 +609,7 @@ CpuModelCompareInfo *arch_query_cpu_model_comparison(=
CpuModelInfo *infoa,
     if (*errp) {
         return NULL;
     }
-    compare_info =3D g_malloc0(sizeof(*compare_info));
+    compare_info =3D g_new0(CpuModelCompareInfo, 1);
=20
     /* check the cpu generation and ga level */
     if (modela.def->gen =3D=3D modelb.def->gen) {
@@ -713,7 +713,7 @@ CpuModelBaselineInfo *arch_query_cpu_model_baseline(C=
puModelInfo *infoa,
     bitmap_and(model.features, model.features, model.def->full_feat,
                S390_FEAT_MAX);
=20
-    baseline_info =3D g_malloc0(sizeof(*baseline_info));
+    baseline_info =3D g_new0(CpuModelBaselineInfo, 1);
     baseline_info->model =3D g_malloc0(sizeof(*baseline_info->model));
     cpu_info_from_model(baseline_info->model, &model, true);
     return baseline_info;
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 82a623948d..dbbb9e886f 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -144,7 +144,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1,=
 uint64_t r3)
             program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
             return;
         }
-        iplb =3D g_malloc0(sizeof(IplParameterBlock));
+        iplb =3D g_new0(IplParameterBlock, 1);
         cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
         if (!iplb_valid_len(iplb)) {
             env->regs[r1 + 1] =3D DIAG_308_RC_INVALID;
--=20
2.13.6
