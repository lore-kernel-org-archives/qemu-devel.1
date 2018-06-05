Received: from eggs.gnu.org ([2001:4830:134:3::10]:45637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9ND-0005Za-BJ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9NA-0006D0-4v
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:31 -0400
Received: from mail.ispras.ru ([83.149.199.45]:55908)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9N9-0006Bi-P0
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:28 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 05 Jun 2018 13:39:26 +0300
Message-ID: <152819516675.30857.9162557650483931182.stgit@pasha-ThinkPad-T60>
In-Reply-To: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v2 2/7] Add plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, vilanova@ac.upc.edu

This patch adds support for dynamically loaded plugins.
Every plugin is a dynamic library with a set of optional exported
functions that will be called from QEMU.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 Makefile.target           |    1 
 configure                 |   14 ++++++-
 include/qemu/plugins.h    |    8 ++++
 plugins/include/plugins.h |   12 ++++++
 plugins/plugins.c         |   91 +++++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx           |   10 +++++
 vl.c                      |    8 ++++
 7 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 include/qemu/plugins.h
 create mode 100644 plugins/include/plugins.h
 create mode 100644 plugins/plugins.c

diff --git a/Makefile.target b/Makefile.target
index dad2cf8..4cffd96 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -93,6 +93,7 @@ all: $(PROGS) stap
 # cpu emulator library
 obj-y += exec.o
 obj-y += accel/
+obj-$(CONFIG_PLUGINS) += plugins/plugins.o
 obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-op-gvec.o
 obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/optimize.o
 obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
diff --git a/configure b/configure
index a71bf9b..34e6f00 100755
--- a/configure
+++ b/configure
@@ -373,6 +373,7 @@ EXESUF=""
 DSOSUF=".so"
 LDFLAGS_SHARED="-shared"
 modules="no"
+plugins="no"
 prefix="/usr/local"
 mandir="\${prefix}/share/man"
 datadir="\${prefix}/share"
@@ -922,6 +923,12 @@ for opt do
   --disable-modules)
       modules="no"
   ;;
+  --enable-plugins)
+      plugins="yes"
+  ;;
+  --disable-plugins)
+      plugins="no"
+  ;;
   --cpu=*)
   ;;
   --target-list=*) target_list="$optarg"
@@ -1567,6 +1574,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   guest-agent-msi build guest agent Windows MSI installation package
   pie             Position Independent Executables
   modules         modules support
+  plugins         plugins support
   debug-tcg       TCG debugging (default is disabled)
   debug-info      debugging information
   sparse          sparse checker
@@ -3392,7 +3400,7 @@ else
     glib_req_ver=2.22
 fi
 glib_modules=gthread-2.0
-if test "$modules" = yes; then
+if test "$modules" = yes || test "$plugins" = yes; then
     glib_modules="$glib_modules gmodule-export-2.0"
 fi
 
@@ -5777,6 +5785,7 @@ if test "$slirp" = "yes" ; then
     echo "smbd              $smbd"
 fi
 echo "module support    $modules"
+echo "plugin support    $plugins"
 echo "host CPU          $cpu"
 echo "host big endian   $bigendian"
 echo "target list       $target_list"
@@ -6111,6 +6120,9 @@ if test "$modules" = "yes"; then
   echo "CONFIG_STAMP=_$( (echo $qemu_version; echo $pkgversion; cat $0) | $shacmd - | cut -f1 -d\ )" >> $config_host_mak
   echo "CONFIG_MODULES=y" >> $config_host_mak
 fi
+if test "$plugins" = "yes"; then
+  echo "CONFIG_PLUGINS=y" >> $config_host_mak
+fi
 if test "$have_x11" = "yes" -a "$need_x11" = "yes"; then
   echo "CONFIG_X11=y" >> $config_host_mak
   echo "X11_CFLAGS=$x11_cflags" >> $config_host_mak
diff --git a/include/qemu/plugins.h b/include/qemu/plugins.h
new file mode 100644
index 0000000..4464822
--- /dev/null
+++ b/include/qemu/plugins.h
@@ -0,0 +1,8 @@
+#ifndef PLUGINS_H
+#define PLUGINS_H
+
+void qemu_plugin_parse_cmd_args(const char *optarg);
+void qemu_plugin_load(const char *filename, const char *args);
+void qemu_plugins_init(void);
+
+#endif /* PLUGINS_H */
diff --git a/plugins/include/plugins.h b/plugins/include/plugins.h
new file mode 100644
index 0000000..100a786
--- /dev/null
+++ b/plugins/include/plugins.h
@@ -0,0 +1,12 @@
+#ifndef PLUGINS_INTERFACE_H
+#define PLUGINS_INTERFACE_H
+
+#include <stdbool.h>
+
+/* Plugin interface */
+
+bool plugin_init(const char *args);
+bool plugin_needs_before_insn(uint64_t pc, void *cpu);
+void plugin_before_insn(uint64_t pc, void *cpu);
+
+#endif /* PLUGINS_INTERFACE_H */
diff --git a/plugins/plugins.c b/plugins/plugins.c
new file mode 100644
index 0000000..eabc931
--- /dev/null
+++ b/plugins/plugins.c
@@ -0,0 +1,91 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/error-report.h"
+#include "qemu/plugins.h"
+#include "qemu/queue.h"
+#include <gmodule.h>
+
+typedef bool (*PluginInitFunc)(const char *);
+typedef bool (*PluginNeedsBeforeInsnFunc)(uint64_t, void *);
+typedef void (*PluginBeforeInsnFunc)(uint64_t, void *);
+
+typedef struct QemuPluginInfo {
+    const char *filename;
+    const char *args;
+    GModule *g_module;
+
+    PluginInitFunc init;
+    PluginNeedsBeforeInsnFunc needs_before_insn;
+    PluginBeforeInsnFunc before_insn;
+
+    QLIST_ENTRY(QemuPluginInfo) next;
+} QemuPluginInfo;
+
+static QLIST_HEAD(, QemuPluginInfo) qemu_plugins
+                                = QLIST_HEAD_INITIALIZER(qemu_plugins);
+
+static QemuOptsList qemu_plugin_opts = {
+    .name = "plugin",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_plugin_opts.head),
+    .desc = {
+        {
+            .name = "file",
+            .type = QEMU_OPT_STRING,
+        },{
+            .name = "args",
+            .type = QEMU_OPT_STRING,
+        },
+        { /* end of list */ }
+    },
+};
+
+void qemu_plugin_parse_cmd_args(const char *optarg)
+{
+    QemuOpts *opts = qemu_opts_parse_noisily(&qemu_plugin_opts, optarg, false);
+    qemu_plugin_load(qemu_opt_get(opts, "file"),
+        qemu_opt_get(opts, "args"));
+}
+
+void qemu_plugin_load(const char *filename, const char *args)
+{
+    GModule *g_module;
+    QemuPluginInfo *info = NULL;
+    if (!filename) {
+        error_report("plugin name was not specified");
+        return;
+    }
+    g_module = g_module_open(filename,
+        G_MODULE_BIND_LAZY | G_MODULE_BIND_LOCAL);
+    if (!g_module) {
+        error_report("can't load plugin '%s'", filename);
+        return;
+    }
+    info = g_new0(QemuPluginInfo, 1);
+    info->filename = g_strdup(filename);
+    info->g_module = g_module;
+    if (args) {
+        info->args = g_strdup(args);
+    }
+
+    g_module_symbol(g_module, "plugin_init", (gpointer*)&info->init);
+
+    /* Get the instrumentation callbacks */
+    g_module_symbol(g_module, "plugin_needs_before_insn",
+        (gpointer*)&info->needs_before_insn);
+    g_module_symbol(g_module, "plugin_before_insn",
+        (gpointer*)&info->before_insn);
+
+    QLIST_INSERT_HEAD(&qemu_plugins, info, next);
+
+    return;
+}
+
+void qemu_plugins_init(void)
+{
+    QemuPluginInfo *info;
+    QLIST_FOREACH(info, &qemu_plugins, next) {
+        if (info->init) {
+            info->init(info->args);
+        }
+    }
+}
diff --git a/qemu-options.hx b/qemu-options.hx
index c0d3951..d171544 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3950,6 +3950,16 @@ Dump json-encoded vmstate information for current machine type to file
 in @var{file}
 ETEXI
 
+#ifdef CONFIG_PLUGINS
+DEF("plugin", HAS_ARG, QEMU_OPTION_plugin, \
+           "-plugin file=<file>[,args=<args>] load <dso> plugin with <args>\n", QEMU_ARCH_ALL)
+STEXI
+@item -plugin file=@var{file}[,args=@var{args}]
+@findex -plugin
+Load @var{file} plugin passing @var{args} arguments.
+ETEXI
+#endif
+
 STEXI
 @end table
 ETEXI
diff --git a/vl.c b/vl.c
index 0603171..05420bf 100644
--- a/vl.c
+++ b/vl.c
@@ -129,6 +129,7 @@ int main(int argc, char **argv)
 #include "qapi/qapi-commands-run-state.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/iothread.h"
+#include "qemu/plugins.h"
 
 #define MAX_VIRTIO_CONSOLES 1
 
@@ -3925,6 +3926,11 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+#ifdef CONFIG_PLUGINS
+            case QEMU_OPTION_plugin:
+                qemu_plugin_parse_cmd_args(optarg);
+                break;
+#endif
             case QEMU_OPTION_nodefconfig:
             case QEMU_OPTION_nouserconfig:
                 /* Nothing to be parsed here. Especially, do not error out below. */
@@ -4470,6 +4476,8 @@ int main(int argc, char **argv, char **envp)
     }
     parse_numa_opts(current_machine);
 
+    qemu_plugins_init();
+
     /* do monitor/qmp handling at preconfig state if requested */
     main_loop();
 
