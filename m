Received: from eggs.gnu.org ([2001:4830:134:3::10]:40799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4cW-0006HB-T1
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4cS-0003Ua-PL
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:10:12 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:59112)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4cS-0003T6-Dd
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:10:08 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 13 Sep 2017 13:09:51 +0300
Message-Id: <150529739097.10902.15025735917991693713.stgit@frigg.lan>
In-Reply-To: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 04/22] instrument: [linux-user] Add command
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
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 linux-user/main.c    |   21 +++++++++++++++++++++
 linux-user/syscall.c |    4 ++++
 2 files changed, 25 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 03666ef657..ac5c30c1fb 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -36,6 +36,7 @@
 #include "exec/log.h"
 #include "trace/control.h"
 #include "glib-compat.h"
+#include "instrument/cmdline.h"
=20
 char *exec_path;
=20
@@ -4017,6 +4018,17 @@ static void handle_arg_trace(const char *arg)
     trace_file =3D trace_opt_parse(arg);
 }
=20
+static char *instrument_path;
+static int instrument_argc;
+static const char **instrument_argv;
+#if defined(CONFIG_INSTRUMENT)
+static void handle_arg_instrument(const char *arg)
+{
+    instr_opt_parse(arg, &instrument_path,
+                    &instrument_argc, &instrument_argv);
+}
+#endif
+
 struct qemu_argument {
     const char *argv;
     const char *env;
@@ -4066,6 +4078,10 @@ static const struct qemu_argument arg_table[] =3D =
{
      "",           "Seed for pseudo-random number generator"},
     {"trace",      "QEMU_TRACE",       true,  handle_arg_trace,
      "",           "[[enable=3D]<pattern>][,events=3D<file>][,file=3D<fi=
le>]"},
+#if defined(CONFIG_INSTRUMENT)
+    {"instr",      "QEMU_INSTR",       true,  handle_arg_instrument,
+     "",           "[file=3D]<file>[,arg=3D<string>]"},
+#endif
     {"version",    "QEMU_VERSION",     false, handle_arg_version,
      "",           "display version information and exit"},
     {NULL, NULL, false, NULL, NULL, NULL}
@@ -4257,6 +4273,9 @@ int main(int argc, char **argv, char **envp)
     srand(time(NULL));
=20
     qemu_add_opts(&qemu_trace_opts);
+#if defined(CONFIG_INSTRUMENT)
+    qemu_add_opts(&qemu_instr_opts);
+#endif
=20
     optind =3D parse_args(argc, argv);
=20
@@ -4265,6 +4284,8 @@ int main(int argc, char **argv, char **envp)
     }
     trace_init_file(trace_file);
=20
+    instr_init(instrument_path, instrument_argc, instrument_argv);
+
     /* Zero out regs */
     memset(regs, 0, sizeof(struct target_pt_regs));
=20
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9b6364a266..e73a07fa6f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -115,6 +115,8 @@ int __clone2(int (*fn)(void *), void *child_stack_bas=
e,
 #include "uname.h"
=20
 #include "qemu.h"
+#include "instrument/cmdline.h"
+
=20
 #ifndef CLONE_IO
 #define CLONE_IO                0x80000000      /* Clone io context */
@@ -7765,6 +7767,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_lon=
g arg1,
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
+        instr_fini();
         _exit(arg1);
         ret =3D 0; /* avoid warning */
         break;
@@ -9821,6 +9824,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_lon=
g arg1,
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
+        instr_fini();
         ret =3D get_errno(exit_group(arg1));
         break;
 #endif
