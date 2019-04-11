Received: from eggs.gnu.org ([209.51.188.92]:38965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEb4b-0003Kw-1b
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEb4X-0000lu-42
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hEb4W-0000l0-QP
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:01 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 11 Apr 2019 16:52:51 +0200
Message-Id: <20190411145256.8614-11-armbru@redhat.com>
In-Reply-To: <20190411145256.8614-1-armbru@redhat.com>
References: <20190411145256.8614-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/15] vl: Make -machine $TYPE,
 help and -accel help print to stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Command line help help explicitly requested by the user should be
printed to stdout, not stderr.  We do elsewhere.  Adjust -machine
$TYPE,help and -accel help to match: use printf() instead of
error_printf().

Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 vl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/vl.c b/vl.c
index c696ad2a13..fdfa1c7453 100644
--- a/vl.c
+++ b/vl.c
@@ -1556,12 +1556,12 @@ static int machine_help_func(QemuOpts *opts, MachineState *machine)
             continue;
         }
 
-        error_printf("%s.%s=%s", MACHINE_GET_CLASS(machine)->name,
-                     prop->name, prop->type);
+        printf("%s.%s=%s", MACHINE_GET_CLASS(machine)->name,
+               prop->name, prop->type);
         if (prop->description) {
-            error_printf(" (%s)\n", prop->description);
+            printf(" (%s)\n", prop->description);
         } else {
-            error_printf("\n");
+            printf("\n");
         }
     }
 
@@ -3643,7 +3643,7 @@ int main(int argc, char **argv, char **envp)
                                                      optarg, true);
                 optarg = qemu_opt_get(accel_opts, "accel");
                 if (!optarg || is_help_option(optarg)) {
-                    error_printf("Possible accelerators: kvm, xen, hax, tcg\n");
+                    printf("Possible accelerators: kvm, xen, hax, tcg\n");
                     exit(0);
                 }
                 opts = qemu_opts_create(qemu_find_opts("machine"), NULL,
-- 
2.17.2
