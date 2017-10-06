Received: from eggs.gnu.org ([2001:4830:134:3::10]:42025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQN-0000Lu-V8
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQK-0006Dv-U5
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:00 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:36 -0300
Message-Id: <20171006235023.11952-42-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 41/88] target/i386: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: added more changes and hax]
---
 target/i386/cpu.c     | 6 +++---
 target/i386/hax-all.c | 4 ++--
 target/i386/hax-mem.c | 2 +-
 target/i386/hyperv.c  | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 98732cd65f..236a4115cd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2344,7 +2344,7 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
     CpuDefinitionInfoList *entry;
     CpuDefinitionInfo *info;
 
-    info = g_malloc0(sizeof(*info));
+    info = g_new0(CpuDefinitionInfo, 1);
     info->name = x86_cpu_class_get_model_name(cc);
     x86_cpu_class_check_missing_features(cc, &info->unavailable_features);
     info->has_unavailable_features = true;
@@ -2353,7 +2353,7 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
     info->has_migration_safe = true;
     info->q_static = cc->static_model;
 
-    entry = g_malloc0(sizeof(*entry));
+    entry = g_new0(CpuDefinitionInfoList, 1);
     entry->value = info;
     entry->next = *cpu_list;
     *cpu_list = entry;
@@ -3933,7 +3933,7 @@ static GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
     GuestPanicInformation *panic_info = NULL;
 
     if (env->features[FEAT_HYPERV_EDX] & HV_GUEST_CRASH_MSR_AVAILABLE) {
-        panic_info = g_malloc0(sizeof(GuestPanicInformation));
+        panic_info = g_new0(GuestPanicInformation, 1);
 
         panic_info->type = GUEST_PANIC_INFORMATION_TYPE_HYPER_V;
 
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 3ce6950296..8f4368fe01 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -155,7 +155,7 @@ int hax_vcpu_create(int id)
         return 0;
     }
 
-    vcpu = g_malloc(sizeof(struct hax_vcpu_state));
+    vcpu = g_new(struct hax_vcpu_state, 1);
     if (!vcpu) {
         fprintf(stderr, "Failed to alloc vcpu state\n");
         return -ENOMEM;
@@ -251,7 +251,7 @@ struct hax_vm *hax_vm_create(struct hax_state *hax)
         return hax->vm;
     }
 
-    vm = g_malloc(sizeof(struct hax_vm));
+    vm = g_new(struct hax_vm, 1);
     if (!vm) {
         return NULL;
     }
diff --git a/target/i386/hax-mem.c b/target/i386/hax-mem.c
index 27a0d214f2..826f7ca501 100644
--- a/target/i386/hax-mem.c
+++ b/target/i386/hax-mem.c
@@ -82,7 +82,7 @@ static void hax_insert_mapping_before(HAXMapping *next, uint64_t start_pa,
 {
     HAXMapping *entry;
 
-    entry = g_malloc0(sizeof(*entry));
+    entry = g_new0(HAXMapping, 1);
     entry->start_pa = start_pa;
     entry->size = size;
     entry->host_va = host_va;
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index a050c9d2d1..a427602e58 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -78,7 +78,7 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vcpu_id, uint32_t sint,
     HvSintRoute *sint_route;
     int r, gsi;
 
-    sint_route = g_malloc0(sizeof(*sint_route));
+    sint_route = g_new0(HvSintRoute, 1);
     r = event_notifier_init(&sint_route->sint_set_notifier, false);
     if (r) {
         goto err;
-- 
2.14.2
