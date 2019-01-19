Received: from eggs.gnu.org ([209.51.188.92]:55318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gknTa-0001Ms-Vg
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gknTZ-00083f-Qt
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:42 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gknTZ-0007zX-Hp
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:41 -0500
Received: by mail-wm1-x342.google.com with SMTP id m22so6695110wml.3
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 02:03:37 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 19 Jan 2019 12:03:15 +0200
Message-Id: <20190119100315.23985-11-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
References: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 10/10] contrib/rdmacm-mux: fix clang
 compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, kamalheib1@gmail.com, liq3ea@163.com, cohuck@redhat.com, philmd@redhat.com

Fix Commit a5d2f6f877 (contrib/rdmacm-mux: Add implementation
                       of RDMA User MAD multiplexer).

The above commit introduces a new contrib target, adding a global dependency
to libumad library in case pvrdma configuration option is enabled.
Clang forbids it:
    clang-6.0: error: -libumad: 'linker' input unused
              [-Werror,-Wunused-command-line-argument]

Fix by limiting the scope to the rdmacm-mux target itself.

Reported-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Tested-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190118124614.24548-4-marcel.apfelbaum@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 Makefile                         | 2 ++
 contrib/rdmacm-mux/Makefile.objs | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index dccba1dca2..c9bdb67274 100644
--- a/Makefile
+++ b/Makefile
@@ -581,6 +581,8 @@ vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a
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
