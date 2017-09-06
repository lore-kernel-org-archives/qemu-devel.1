Received: from eggs.gnu.org ([2001:4830:134:3::10]:40119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpeLz-0006Gg-KB
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpeLw-0001X8-IW
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:43:07 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:58762)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpeLw-0001Wh-7E
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:43:04 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed,  6 Sep 2017 20:42:53 +0300
Message-Id: <150471977282.24907.9071837694091118220.stgit@frigg.lan>
In-Reply-To: <150471856141.24907.274176769201097378.stgit@frigg.lan>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 05/20] instrument: [bsd-user] Add command
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
Cc: Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 bsd-user/main.c    |   15 +++++++++++++++
 bsd-user/syscall.c |    5 +++++
 2 files changed, 20 insertions(+)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 8a6706a1c8..2cf75290cd 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -33,6 +33,7 @@
 #include "exec/log.h"
 #include "trace/control.h"
 #include "glib-compat.h"
+#include "instrument/cmdline.h"
=20
 int singlestep;
 unsigned long mmap_min_addr;
@@ -667,6 +668,11 @@ static void usage(void)
            "-B address        set guest_base address to address\n"
            "-bsd type         select emulated BSD type FreeBSD/NetBSD/Op=
enBSD (default)\n"
            "\n"
+#if defined(CONFIG_INSTRUMENT)
+           "-instr [file=3D]<file>[,arg=3D<string>]\n"
+           "                  load an instrumentation library\n"
+           "\n"
+#endif
            "Debug options:\n"
            "-d item1[,...]    enable logging of specified items\n"
            "                  (use '-d help' for a list of log items)\n"
@@ -738,6 +744,9 @@ int main(int argc, char **argv)
     envlist_t *envlist =3D NULL;
     char *trace_file =3D NULL;
     bsd_type =3D target_openbsd;
+    char *instrument_path =3D NULL;
+    int instrument_argc =3D 0;
+    const char **instrument_argv =3D NULL;
=20
     if (argc <=3D 1)
         usage();
@@ -756,6 +765,7 @@ int main(int argc, char **argv)
     cpu_model =3D NULL;
=20
     qemu_add_opts(&qemu_trace_opts);
+    qemu_add_opts(&qemu_instr_opts);
=20
     optind =3D 1;
     for (;;) {
@@ -843,6 +853,9 @@ int main(int argc, char **argv)
         } else if (!strcmp(r, "trace")) {
             g_free(trace_file);
             trace_file =3D trace_opt_parse(optarg);
+        } else if (!strcmp(r, "instr")) {
+            instr_opt_parse(optarg, &instrument_path,
+                            &instrument_argc, &instrument_argv);
         } else {
             usage();
         }
@@ -872,6 +885,8 @@ int main(int argc, char **argv)
     }
     trace_init_file(trace_file);
=20
+    instr_init(instrument_path, instrument_argc, instrument_argv);
+
     /* Zero out regs */
     memset(regs, 0, sizeof(struct target_pt_regs));
=20
diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
index 66492aaf5d..3230f722f3 100644
--- a/bsd-user/syscall.c
+++ b/bsd-user/syscall.c
@@ -26,6 +26,8 @@
=20
 #include "qemu.h"
 #include "qemu-common.h"
+#include "instrument/cmdline.h"
+
=20
 //#define DEBUG
=20
@@ -332,6 +334,7 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
+        instr_fini();
         /* XXX: should free thread stack and CPU env */
         _exit(arg1);
         ret =3D 0; /* avoid warning */
@@ -430,6 +433,7 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, ab=
i_long arg1,
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
+        instr_fini();
         /* XXX: should free thread stack and CPU env */
         _exit(arg1);
         ret =3D 0; /* avoid warning */
@@ -505,6 +509,7 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
+        instr_fini();
         /* XXX: should free thread stack and CPU env */
         _exit(arg1);
         ret =3D 0; /* avoid warning */
