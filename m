Received: from eggs.gnu.org ([2001:4830:134:3::10]:58624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtPv-0001vS-FT
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:43:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtPt-0000Sq-1j
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:43:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehtPs-0000Rk-Q7
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:43:20 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sat,  3 Feb 2018 09:43:14 +0100
Message-Id: <20180203084315.20497-14-armbru@redhat.com>
In-Reply-To: <20180203084315.20497-1-armbru@redhat.com>
References: <20180203084315.20497-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 13/14] tcg: Replace fprintf(stderr,
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
Cc: alistair.francis@xilinx.com, eblake@redhat.com, f4bug@amsat.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Stefan Weil <sw@weilnetz.de>

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

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Stefan Weil <sw@weilnetz.de>

Conversions that aren't followed by exit() dropped, because they might
be inappropriate.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 cpus.c | 10 +++++-----
 exec.c |  6 +++---
 vl.c   |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/cpus.c b/cpus.c
index 2cb0af9b22..5d3a165960 100644
--- a/cpus.c
+++ b/cpus.c
@@ -259,7 +259,7 @@ int64_t cpu_get_icount_raw(void)
=20
     if (cpu && cpu->running) {
         if (!cpu->can_do_io) {
-            fprintf(stderr, "Bad icount read\n");
+            error_report("Bad icount read");
             exit(1);
         }
         /* Take into account what has run */
@@ -1181,7 +1181,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
=20
     r =3D kvm_init_vcpu(cpu);
     if (r < 0) {
-        fprintf(stderr, "kvm_init_vcpu failed: %s\n", strerror(-r));
+        error_report("kvm_init_vcpu failed: %s", strerror(-r));
         exit(1);
     }
=20
@@ -1211,7 +1211,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
 static void *qemu_dummy_cpu_thread_fn(void *arg)
 {
 #ifdef _WIN32
-    fprintf(stderr, "qtest is not supported under Windows\n");
+    error_report("qtest is not supported under Windows");
     exit(1);
 #else
     CPUState *cpu =3D arg;
@@ -1631,8 +1631,8 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
 #else /* _WIN32 */
     if (!qemu_cpu_is_self(cpu)) {
         if (!QueueUserAPC(dummy_apc_func, cpu->hThread, 0)) {
-            fprintf(stderr, "%s: QueueUserAPC failed with error %lu\n",
-                    __func__, GetLastError());
+            error_report("%s: QueueUserAPC failed with error %lu", __fun=
c__,
+                         GetLastError());
             exit(1);
         }
     }
diff --git a/exec.c b/exec.c
index 629a508385..e8d7b335b6 100644
--- a/exec.c
+++ b/exec.c
@@ -2216,9 +2216,9 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t len=
gth)
                                 flags, -1, 0);
                 }
                 if (area !=3D vaddr) {
-                    fprintf(stderr, "Could not remap addr: "
-                            RAM_ADDR_FMT "@" RAM_ADDR_FMT "\n",
-                            length, addr);
+                    error_report("Could not remap addr: "
+                                 RAM_ADDR_FMT "@" RAM_ADDR_FMT "",
+                                 length, addr);
                     exit(1);
                 }
                 memory_try_enable_merging(vaddr, length);
diff --git a/vl.c b/vl.c
index e517a8d995..32db91da1e 100644
--- a/vl.c
+++ b/vl.c
@@ -2172,7 +2172,7 @@ static DisplayType select_display(const char *p)
         display_opengl =3D 1;
         display =3D DT_EGL;
 #else
-        fprintf(stderr, "egl support is disabled\n");
+        error_report("egl support is disabled");
         exit(1);
 #endif
     } else if (strstart(p, "curses", &opts)) {
--=20
2.13.6
