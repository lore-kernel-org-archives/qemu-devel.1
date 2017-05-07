Received: from eggs.gnu.org ([2001:4830:134:3::10]:58093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7Go1-0001Pe-FN
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7Gnz-00072Z-6n
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:40:37 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  7 May 2017 10:02:19 +0300
Message-Id: <5e78979d471f1fd49217155d4c6481c585c51ff1.1494140528.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 16/23] virtfs: allow a device id to be specified
 in the -virtfs option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Chris Webb <chris@arachsys.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Chris Webb <chris@arachsys.com>

When using a virtfs root filesystem, the mount_tag needs to be set to
/dev/root. This can be done long-hand as

  -fsdev local,id=root,path=/path/to/rootfs,...
  -device virtio-9p-pci,fsdev=root,mount_tag=/dev/root

but the -virtfs shortcut cannot be used as it hard-codes the device identifier
to match the mount_tag, and device identifiers may not contain '/':

  $ qemu-system-x86_64 -virtfs local,path=/foo,mount_tag=/dev/root,security_model=passthrough
  qemu-system-x86_64: -virtfs local,path=/foo,mount_tag=/dev/root,security_model=passthrough: duplicate fsdev id: /dev/root

To support this case using -virtfs, we allow the device identifier to be
specified explicitly when the mount_tag is not suitable:

  -virtfs local,id=root,path=/path/to/rootfs,mount_tag=/dev/root,...

Signed-off-by: Chris Webb <chris@arachsys.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-options.hx | 2 +-
 vl.c            | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index a24fef2107..a5b0589cb7 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -876,7 +876,7 @@ ETEXI
 
 DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
     "-virtfs local,path=path,mount_tag=tag,security_model=[mapped-xattr|mapped-file|passthrough|none]\n"
-    "        [,writeout=immediate][,readonly][,socket=socket|sock_fd=sock_fd]\n",
+    "        [,id=id][,writeout=immediate][,readonly][,socket=socket|sock_fd=sock_fd]\n",
     QEMU_ARCH_ALL)
 
 STEXI
diff --git a/vl.c b/vl.c
index 42d4bce439..10f3afd860 100644
--- a/vl.c
+++ b/vl.c
@@ -3524,10 +3524,11 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 fsdev = qemu_opts_create(qemu_find_opts("fsdev"),
+                                         qemu_opts_id(opts) ?:
                                          qemu_opt_get(opts, "mount_tag"),
                                          1, NULL);
                 if (!fsdev) {
-                    error_report("duplicate fsdev id: %s",
+                    error_report("duplicate or invalid fsdev id: %s",
                                  qemu_opt_get(opts, "mount_tag"));
                     exit(1);
                 }
@@ -3565,7 +3566,7 @@ int main(int argc, char **argv, char **envp)
                                           &error_abort);
                 qemu_opt_set(device, "driver", "virtio-9p-pci", &error_abort);
                 qemu_opt_set(device, "fsdev",
-                             qemu_opt_get(opts, "mount_tag"), &error_abort);
+                             qemu_opts_id(fsdev), &error_abort);
                 qemu_opt_set(device, "mount_tag",
                              qemu_opt_get(opts, "mount_tag"), &error_abort);
                 break;
-- 
2.11.0
