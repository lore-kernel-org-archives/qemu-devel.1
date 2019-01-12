Received: from eggs.gnu.org ([209.51.188.92]:54408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1giKo1-0003n7-UR
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 10:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1giKo1-0002sV-7b
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 10:02:37 -0500
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 12 Jan 2019 17:02:25 +0200
Message-Id: <20190112150225.20294-4-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190112150225.20294-1-marcel.apfelbaum@gmail.com>
References: <20190112150225.20294-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH 3/3] contrib/rdmacm-mux: fix clang compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yuval.shaia@oracle.com, qemu-stable@nongnu.org, marcel.apfelbaum@gmail.com, cohuck@redhat.com

Fix Commit a5d2f6f877 (contrib/rdmacm-mux: Add implementation
                       of RDMA User MAD multiplexer).

The above commit introduces a new contrib target, adding a global dependency
to libumad library in case pvrdma configuration option is enabled.
Clang forbids it:
    clang-6.0: error: -libumad: 'linker' input unused
              [-Werror,-Wunused-command-line-argument]

Fix by limiting the scope to the rdmacm-mux target itself.

Reported-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 Makefile                         | 2 ++
 contrib/rdmacm-mux/Makefile.objs | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a9ac16d94e..31e87e0c2d 100644
--- a/Makefile
+++ b/Makefile
@@ -580,6 +580,8 @@ vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a
 	$(call LINK, $^)
 vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a
 	$(call LINK, $^)
+
+rdmacm-mux$(EXESUF): LIBS += "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 
diff --git a/contrib/rdmacm-mux/Makefile.objs b/contrib/rdmacm-mux/Makefile.objs
index e1ff4fe569..3df744af89 100644
--- a/contrib/rdmacm-mux/Makefile.objs
+++ b/contrib/rdmacm-mux/Makefile.objs
@@ -1,4 +1,3 @@
 ifdef CONFIG_PVRDMA
-CFLAGS += -libumad
 rdmacm-mux-obj-y = main.o
 endif
-- 
2.17.1
