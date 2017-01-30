Received: from eggs.gnu.org ([2001:4830:134:3::10]:43471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cYAeY-00083E-FY
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cYAeS-0004xN-RF
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:01:46 -0500
From: Nir Soffer <nirsof@gmail.com>
Date: Mon, 30 Jan 2017 13:55:49 +0200
Message-Id: <20170130115551.27254-1-nirsof@gmail.com>
Subject: [Qemu-devel] [PATCH v3 1/3] qemu-io: Return non-zero exit code on
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Nir Soffer <nsoffer@redhat.com>, Nir Soffer <nirsof@gmail.com>

From: Nir Soffer <nsoffer@redhat.com>

The result of openfile was not checked, leading to failure deep in the
actual command with confusing error message, and exiting with exit code 0.

Here is a simple example - trying to read with the wrong format:

    $ touch file
    $ qemu-io -f qcow2 -c 'read -P 1 0 1024' file; echo $?
    can't open device file: Image is not in qcow2 format
    no file open, try 'help open'
    0

With this patch, we fail earlier with exit code 1:

    $ ./qemu-io -f qcow2 -c 'read -P 1 0 1024' file; echo $?
    can't open device file: Image is not in qcow2 format
    1

Signed-off-by: Nir Soffer <nirsof@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---

Changes since v2:
- Adding missing signed-off-by
- Fix tests expecting the wrong output

 qemu-io.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index 23a229f..427cbae 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -595,13 +595,17 @@ int main(int argc, char **argv)
                 exit(1);
             }
             opts = qemu_opts_to_qdict(qopts, NULL);
-            openfile(NULL, flags, writethrough, opts);
+            if (openfile(NULL, flags, writethrough, opts)) {
+                exit(1);
+            }
         } else {
             if (format) {
                 opts = qdict_new();
                 qdict_put(opts, "driver", qstring_from_str(format));
             }
-            openfile(argv[optind], flags, writethrough, opts);
+            if (openfile(argv[optind], flags, writethrough, opts)) {
+                exit(1);
+            }
         }
     }
     command_loop();
-- 
2.9.3
