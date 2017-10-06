Received: from eggs.gnu.org ([2001:4830:134:3::10]:42613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRD-000163-4r
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRC-0006x4-16
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:51 -0300
Message-Id: <20171006235023.11952-57-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 56/88] PowerPC: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-ppc@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: one more change in target/ppc/translate_init.c, added target/ppc/kvm.c]
---
 hw/ppc/ppc.c                |  8 ++++----
 hw/ppc/ppc_booke.c          |  4 ++--
 target/ppc/kvm.c            |  2 +-
 target/ppc/translate_init.c | 14 +++++++-------
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 05da316e0b..647d70fc13 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -965,7 +965,7 @@ clk_setup_cb cpu_ppc_tb_init (CPUPPCState *env, uint32_t freq)
     PowerPCCPU *cpu = ppc_env_get_cpu(env);
     ppc_tb_t *tb_env;
 
-    tb_env = g_malloc0(sizeof(ppc_tb_t));
+    tb_env = g_new0(ppc_tb_t, 1);
     env->tb_env = tb_env;
     tb_env->flags = PPC_DECR_UNDERFLOW_TRIGGERED;
     if (env->insns_flags & PPC_SEGMENT_64B) {
@@ -1224,10 +1224,10 @@ clk_setup_cb ppc_40x_timers_init (CPUPPCState *env, uint32_t freq,
     ppc_tb_t *tb_env;
     ppc40x_timer_t *ppc40x_timer;
 
-    tb_env = g_malloc0(sizeof(ppc_tb_t));
+    tb_env = g_new0(ppc_tb_t, 1);
     env->tb_env = tb_env;
     tb_env->flags = PPC_DECR_UNDERFLOW_TRIGGERED;
-    ppc40x_timer = g_malloc0(sizeof(ppc40x_timer_t));
+    ppc40x_timer = g_new0(ppc40x_timer_t, 1);
     tb_env->tb_freq = freq;
     tb_env->decr_freq = freq;
     tb_env->opaque = ppc40x_timer;
@@ -1332,7 +1332,7 @@ int ppc_dcr_init (CPUPPCState *env, int (*read_error)(int dcrn),
 {
     ppc_dcr_t *dcr_env;
 
-    dcr_env = g_malloc0(sizeof(ppc_dcr_t));
+    dcr_env = g_new0(ppc_dcr_t, 1);
     dcr_env->read_error = read_error;
     dcr_env->write_error = write_error;
     env->dcr_env = dcr_env;
diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index 23bcf1b138..dafc6aa3fc 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -339,8 +339,8 @@ void ppc_booke_timers_init(PowerPCCPU *cpu, uint32_t freq, uint32_t flags)
     booke_timer_t *booke_timer;
     int ret = 0;
 
-    tb_env      = g_malloc0(sizeof(ppc_tb_t));
-    booke_timer = g_malloc0(sizeof(booke_timer_t));
+    tb_env      = g_new0(ppc_tb_t, 1);
+    booke_timer = g_new0(booke_timer_t, 1);
 
     cpu->env.tb_env = tb_env;
     tb_env->flags = flags | PPC_TIMER_BOOKE | PPC_DECR_ZERO_TRIGGERED;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 171d3d8040..d8565fd4a3 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -364,7 +364,7 @@ struct ppc_radix_page_info *kvm_get_radix_page_info(void)
     if (kvm_vm_ioctl(s, KVM_PPC_GET_RMMU_INFO, &rmmu_info)) {
         return NULL;
     }
-    radix_page_info = g_malloc0(sizeof(*radix_page_info));
+    radix_page_info = g_new0(struct ppc_radix_page_info, 1);
     radix_page_info->count = 0;
     for (i = 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
         if (rmmu_info.ap_encodings[i]) {
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index c6399a3a0d..850ff038ca 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9341,13 +9341,13 @@ static void init_ppc_proc(PowerPCCPU *cpu)
             nb_tlb *= 2;
         switch (env->tlb_type) {
         case TLB_6XX:
-            env->tlb.tlb6 = g_malloc0(nb_tlb * sizeof(ppc6xx_tlb_t));
+            env->tlb.tlb6 = g_new0(ppc6xx_tlb_t, nb_tlb);
             break;
         case TLB_EMB:
-            env->tlb.tlbe = g_malloc0(nb_tlb * sizeof(ppcemb_tlb_t));
+            env->tlb.tlbe = g_new0(ppcemb_tlb_t, nb_tlb);
             break;
         case TLB_MAS:
-            env->tlb.tlbm = g_malloc0(nb_tlb * sizeof(ppcmas_tlb_t));
+            env->tlb.tlbm = g_new0(ppcmas_tlb_t, nb_tlb);
             break;
         }
         /* Pre-compute some useful values */
@@ -10442,11 +10442,11 @@ static void ppc_cpu_defs_entry(gpointer data, gpointer user_data)
     }
 
     typename = object_class_get_name(oc);
-    info = g_malloc0(sizeof(*info));
+    info = g_new0(CpuDefinitionInfo, 1);
     info->name = g_strndup(typename,
                            strlen(typename) - strlen(POWERPC_CPU_TYPE_SUFFIX));
 
-    entry = g_malloc0(sizeof(*entry));
+    entry = g_new0(CpuDefinitionInfoList, 1);
     entry->value = info;
     entry->next = *first;
     *first = entry;
@@ -10473,11 +10473,11 @@ CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
             continue;
         }
 
-        info = g_malloc0(sizeof(*info));
+        info = g_new0(CpuDefinitionInfo, 1);
         info->name = g_strdup(alias->alias);
         info->q_typename = g_strdup(object_class_get_name(oc));
 
-        entry = g_malloc0(sizeof(*entry));
+        entry = g_new0(CpuDefinitionInfoList, 1);
         entry->value = info;
         entry->next = cpu_list;
         cpu_list = entry;
-- 
2.14.2
