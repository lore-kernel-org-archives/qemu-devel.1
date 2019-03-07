Received: from eggs.gnu.org ([209.51.188.92]:37564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1wkr-0005Xl-Tv
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:24:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1wkr-0003Tb-5u
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:24:25 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  7 Mar 2019 18:23:56 +0100
Message-Id: <20190307172401.29451-8-armbru@redhat.com>
In-Reply-To: <20190307172401.29451-1-armbru@redhat.com>
References: <20190307172401.29451-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/12] vl: Create block backends before
 setting machine properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com

qemu-system-FOO's main() acts on command line arguments in its own
idiosyncratic order.  There's not much method to its madness.
Whenever we find a case where one kind of command line argument needs
to refer to something created for another kind later, we rejigger the
order.

Block devices get created long after machine properties get processed.
Therefore, block device machine properties can be created, but not
set.  No such properties exist.  But the next commit will create some.
Time to rejigger again: create block devices earlier.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index 5a19d2a8ec..c250483fc1 100644
--- a/vl.c
+++ b/vl.c
@@ -4272,6 +4272,13 @@ int main(int argc, char **argv, char **envp)
         exit(0);
     }
 
+    /*
+     * Note: we need to create block backends before
+     * machine_set_property(), so machine properties can refer to
+     * them.
+     */
+    configure_blockdev(&bdo_queue, machine_class, snapshot);
+
     machine_opts = qemu_get_machine_opts();
     qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
                      &error_fatal);
@@ -4398,8 +4405,6 @@ int main(int argc, char **argv, char **envp)
     ram_mig_init();
     dirty_bitmap_mig_init();
 
-    configure_blockdev(&bdo_queue, machine_class, snapshot);
-
     qemu_opts_foreach(qemu_find_opts("mon"),
                       mon_init_func, NULL, &error_fatal);
 
-- 
2.17.2
