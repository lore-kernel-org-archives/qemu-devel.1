Received: from eggs.gnu.org ([2001:4830:134:3::10]:55740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpum-0005fV-ET
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpug-0000PG-Gb
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:46:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebpug-0000Nj-7E
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:46:06 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:33 +0100
Message-Id: <1516203816-19374-22-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 21/24] linux/bsd-user: drop cpu_init() and use
 cpu_create() instead
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

*-user were the last users of cpu_init() macro, which were
used to create a cpu instance using cpu_model name.

Now since all targets provide TARGET_DEFAULT_CPU_TYPE,
cpu_init() can be replaced with one call:
   cpu_type = cpu_parse_cpu_model(TARGET_DEFAULT_CPU_TYPE, cpu_model)
when '-cpu' CLI option is parsed and
   cpu = create_cpu(cpu_type)
whenever a cpu instance needs to be created.

Also drop ifdef-ed definitions of default cpu_model and use
target provided TARGET_DEFAULT_CPU_TYPE for it, this way
linux/bsd-user targets will become consistent in handling
defaults and won't go out off sync as it happened current
code.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
---
 bsd-user/main.c   | 26 ++++----------------------
 linux-user/main.c | 46 +++++-----------------------------------------
 2 files changed, 9 insertions(+), 63 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index efef5ff..d52ff22 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -722,7 +722,7 @@ void init_task_state(TaskState *ts)
 int main(int argc, char **argv)
 {
     const char *filename;
-    const char *cpu_model;
+    const char *cpu_type = TARGET_DEFAULT_CPU_TYPE;
     const char *log_file = NULL;
     const char *log_mask = NULL;
     struct target_pt_regs regs1, *regs = &regs1;
@@ -752,8 +752,6 @@ int main(int argc, char **argv)
         (void) envlist_setenv(envlist, *wrk);
     }
 
-    cpu_model = NULL;
-
     qemu_add_opts(&qemu_trace_opts);
 
     optind = 1;
@@ -811,7 +809,7 @@ int main(int argc, char **argv)
         } else if (!strcmp(r, "r")) {
             qemu_uname_release = argv[optind++];
         } else if (!strcmp(r, "cpu")) {
-            cpu_model = argv[optind++];
+            const char *cpu_model = argv[optind++];
             if (is_help_option(cpu_model)) {
 /* XXX: implement xxx_cpu_list for targets that still miss it */
 #if defined(cpu_list)
@@ -819,6 +817,7 @@ int main(int argc, char **argv)
 #endif
                 exit(1);
             }
+            cpu_type = cpu_parse_cpu_model(TARGET_DEFAULT_CPU_TYPE, cpu_model);
         } else if (!strcmp(r, "B")) {
            guest_base = strtol(argv[optind++], NULL, 0);
            have_guest_base = 1;
@@ -880,27 +879,10 @@ int main(int argc, char **argv)
     /* Scan interp_prefix dir for replacement files. */
     init_paths(interp_prefix);
 
-    if (cpu_model == NULL) {
-#if defined(TARGET_I386)
-#ifdef TARGET_X86_64
-        cpu_model = "qemu64";
-#else
-        cpu_model = "qemu32";
-#endif
-#elif defined(TARGET_SPARC)
-#ifdef TARGET_SPARC64
-        cpu_model = "TI UltraSparc II";
-#else
-        cpu_model = "Fujitsu MB86904";
-#endif
-#else
-        cpu_model = "any";
-#endif
-    }
     tcg_exec_init(0);
     /* NOTE: we need to init the CPU at this stage to get
        qemu_host_page_size */
-    cpu = cpu_init(cpu_model);
+    cpu = cpu_create(cpu_type);
     env = cpu->env_ptr;
 #if defined(TARGET_SPARC) || defined(TARGET_PPC)
     cpu_reset(cpu);
diff --git a/linux-user/main.c b/linux-user/main.c
index 1cd5033..4624cc9 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -43,7 +43,7 @@ static const char *filename;
 static const char *argv0;
 static int gdbstub_port;
 static envlist_t *envlist;
-static const char *cpu_model;
+static const char *cpu_type = TARGET_DEFAULT_CPU_TYPE;
 unsigned long mmap_min_addr;
 unsigned long guest_base;
 int have_guest_base;
@@ -3847,7 +3847,7 @@ void init_task_state(TaskState *ts)
 CPUArchState *cpu_copy(CPUArchState *env)
 {
     CPUState *cpu = ENV_GET_CPU(env);
-    CPUState *new_cpu = cpu_init(cpu_model);
+    CPUState *new_cpu = cpu_create(cpu_type);
     CPUArchState *new_env = new_cpu->env_ptr;
     CPUBreakpoint *bp;
     CPUWatchpoint *wp;
@@ -3982,7 +3982,7 @@ static void handle_arg_uname(const char *arg)
 
 static void handle_arg_cpu(const char *arg)
 {
-    cpu_model = strdup(arg);
+    const char *cpu_model = strdup(arg);
     if (cpu_model == NULL || is_help_option(cpu_model)) {
         /* XXX: implement xxx_cpu_list for targets that still miss it */
 #if defined(cpu_list)
@@ -3990,6 +3990,7 @@ static void handle_arg_cpu(const char *arg)
 #endif
         exit(EXIT_FAILURE);
     }
+    cpu_type = cpu_parse_cpu_model(TARGET_DEFAULT_CPU_TYPE, cpu_model);
 }
 
 static void handle_arg_guest_base(const char *arg)
@@ -4292,8 +4293,6 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
-    cpu_model = NULL;
-
     srand(time(NULL));
 
     qemu_add_opts(&qemu_trace_opts);
@@ -4318,45 +4317,10 @@ int main(int argc, char **argv, char **envp)
 
     init_qemu_uname_release();
 
-    if (cpu_model == NULL) {
-#if defined(TARGET_I386)
-#ifdef TARGET_X86_64
-        cpu_model = "qemu64";
-#else
-        cpu_model = "qemu32";
-#endif
-#elif defined(TARGET_SPARC)
-#ifdef TARGET_SPARC64
-        cpu_model = "TI UltraSparc II";
-#else
-        cpu_model = "Fujitsu MB86904";
-#endif
-#elif defined(TARGET_MIPS)
-#if defined(TARGET_ABI_MIPSN32) || defined(TARGET_ABI_MIPSN64)
-        cpu_model = "5KEf";
-#else
-        cpu_model = "24Kf";
-#endif
-#elif defined TARGET_OPENRISC
-        cpu_model = "or1200";
-#elif defined(TARGET_PPC)
-# ifdef TARGET_PPC64
-        cpu_model = "power8_v2.0";
-# else
-        cpu_model = "750_v3.1";
-# endif
-#elif defined TARGET_SH4
-        cpu_model = "sh7785";
-#elif defined TARGET_S390X
-        cpu_model = "qemu";
-#else
-        cpu_model = "any";
-#endif
-    }
     tcg_exec_init(0);
     /* NOTE: we need to init the CPU at this stage to get
        qemu_host_page_size */
-    cpu = cpu_init(cpu_model);
+    cpu = cpu_create(cpu_type);
     env = cpu->env_ptr;
     cpu_reset(cpu);
 
-- 
2.7.4
