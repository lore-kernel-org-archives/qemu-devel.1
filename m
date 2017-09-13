Received: from eggs.gnu.org ([2001:4830:134:3::10]:45119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4kE-0000wR-PO
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4k8-0000u7-Ma
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:18:10 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:33743)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4k8-0000tl-BY
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:18:04 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 13 Sep 2017 13:17:54 +0300
Message-Id: <150529787476.10902.6384634683395635747.stgit@frigg.lan>
In-Reply-To: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 06/22] instrument: [softmmu] Add command
 line library loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 qemu-options.hx |   19 +++++++++++++++++++
 vl.c            |   15 +++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 9f6e2adfff..6947388aab 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4077,6 +4077,25 @@ HXCOMM HX does not support conditional compilation=
 of text.
 @findex -trace
 @include qemu-option-trace.texi
 ETEXI
+#if defined(CONFIG_INSTRUMENT)
+DEF("instr", HAS_ARG, QEMU_OPTION_instr,
+    "-instr [file=3D]<file>[,arg=3D<string>]\n"
+    "                load an instrumentation library\n",
+    QEMU_ARCH_ALL)
+#endif
+STEXI
+@item -instr file=3D@var{file}[,arg=3D@var{string}]
+@findex -instr
+
+Load a dynamic trace instrumentation library.
+
+@table @option
+@item file=3D@var{file}
+Load the given dynamic trace instrumentation library.
+@item arg=3D@var{string}
+String argument passed as to the library's @code{qi_init} routine (can b=
e given multiple times).
+@end table
+ETEXI
=20
 HXCOMM Internal use
 DEF("qtest", HAS_ARG, QEMU_OPTION_qtest, "", QEMU_ARCH_ALL)
diff --git a/vl.c b/vl.c
index fb1f05b937..aea05ed4cc 100644
--- a/vl.c
+++ b/vl.c
@@ -118,6 +118,7 @@ int main(int argc, char **argv)
=20
 #include "trace-root.h"
 #include "trace/control.h"
+#include "instrument/cmdline.h"
 #include "qemu/queue.h"
 #include "sysemu/arch_init.h"
=20
@@ -3037,6 +3038,9 @@ int main(int argc, char **argv, char **envp)
     } BlockdevOptions_queue;
     QSIMPLEQ_HEAD(, BlockdevOptions_queue) bdo_queue
         =3D QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
+    char *instrument_path =3D NULL;
+    int instrument_argc =3D 0;
+    const char **instrument_argv =3D NULL;
=20
     module_call_init(MODULE_INIT_TRACE);
=20
@@ -3064,6 +3068,9 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_global_opts);
     qemu_add_opts(&qemu_mon_opts);
     qemu_add_opts(&qemu_trace_opts);
+#if defined(CONFIG_INSTRUMENT)
+    qemu_add_opts(&qemu_instr_opts);
+#endif
     qemu_add_opts(&qemu_option_rom_opts);
     qemu_add_opts(&qemu_machine_opts);
     qemu_add_opts(&qemu_accel_opts);
@@ -4009,6 +4016,12 @@ int main(int argc, char **argv, char **envp)
                 g_free(trace_file);
                 trace_file =3D trace_opt_parse(optarg);
                 break;
+#if defined(CONFIG_INSTRUMENT)
+            case QEMU_OPTION_instr:
+                instr_opt_parse(optarg, &instrument_path,
+                                &instrument_argc, &instrument_argv);
+                break;
+#endif
             case QEMU_OPTION_readconfig:
                 {
                     int ret =3D qemu_read_config_file(optarg);
@@ -4196,6 +4209,8 @@ int main(int argc, char **argv, char **envp)
     }
     trace_init_file(trace_file);
=20
+    instr_init(instrument_path, instrument_argc, instrument_argv);
+
     /* Open the logfile at this point and set the log mask if necessary.
      */
     if (log_file) {
