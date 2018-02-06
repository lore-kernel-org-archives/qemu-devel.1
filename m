Received: from eggs.gnu.org ([2001:4830:134:3::10]:56568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ej9Gg-0003Cc-3y
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ej9Ge-000438-BI
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:51:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35244 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ej9Ge-00042D-3x
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:51:00 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  6 Feb 2018 20:50:43 +0100
Message-Id: <20180206195044.8347-14-armbru@redhat.com>
In-Reply-To: <20180206195044.8347-1-armbru@redhat.com>
References: <20180206195044.8347-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/14] hw/xen*: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

From: Alistair Francis <alistair.francis@xilinx.com>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|erro=
r_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_=
report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_repo=
rt("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report=
("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("=
\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1=
"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\=
2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2)=
;|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|=
Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig=
}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}'=
 \
    {} +

Some lines where then manually tweaked to pass checkpatch.

xen_pt_log() was left with an fprintf(stderr,

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>

Conversions that aren't followed by exit() dropped, because they might
be inappropriate.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180203084315.20497-13-armbru@redhat.com>
---
 hw/xen/xen-common.c       | 5 +++--
 hw/xenpv/xen_machine_pv.c | 9 +++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 632a938dcc..afa1e3f404 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -9,6 +9,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/xen/xen_backend.h"
 #include "qmp-commands.h"
 #include "chardev/char.h"
@@ -96,13 +97,13 @@ static void xenstore_record_dm_state(struct xs_handle=
 *xs, const char *state)
     char path[50];
=20
     if (xs =3D=3D NULL) {
-        fprintf(stderr, "xenstore connection not initialized\n");
+        error_report("xenstore connection not initialized");
         exit(1);
     }
=20
     snprintf(path, sizeof (path), "device-model/%u/state", xen_domid);
     if (!xs_write(xs, XBT_NULL, path, state, strlen(state))) {
-        fprintf(stderr, "error recording dm state\n");
+        error_report("error recording dm state");
         exit(1);
     }
 }
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 69a52a9f93..44d67b87c4 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
 #include "hw/xen/xen_backend.h"
@@ -36,7 +37,7 @@ static void xen_init_pv(MachineState *machine)
=20
     /* Initialize backend core & drivers */
     if (xen_be_init() !=3D 0) {
-        fprintf(stderr, "%s: xen backend core setup failed\n", __func__)=
;
+        error_report("%s: xen backend core setup failed", __func__);
         exit(1);
     }
=20
@@ -51,18 +52,18 @@ static void xen_init_pv(MachineState *machine)
         const char *initrd_filename =3D machine->initrd_filename;
         if (xen_domain_build_pv(kernel_filename, initrd_filename,
                                 kernel_cmdline) < 0) {
-            fprintf(stderr, "xen pv domain creation failed\n");
+            error_report("xen pv domain creation failed");
             exit(1);
         }
         break;
     }
 #endif
     case XEN_EMULATE:
-        fprintf(stderr, "xen emulation not implemented (yet)\n");
+        error_report("xen emulation not implemented (yet)");
         exit(1);
         break;
     default:
-        fprintf(stderr, "unhandled xen_mode %d\n", xen_mode);
+        error_report("unhandled xen_mode %d", xen_mode);
         exit(1);
         break;
     }
--=20
2.13.6
