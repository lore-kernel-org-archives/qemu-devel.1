Received: from eggs.gnu.org ([209.51.188.92]:55322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gknTb-0001Mw-2w
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gknTZ-00083a-Pu
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:42 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gknTZ-0007xI-HI
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:41 -0500
Received: by mail-wr1-x442.google.com with SMTP id t27so17911906wra.6
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 02:03:33 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 19 Jan 2019 12:03:13 +0200
Message-Id: <20190119100315.23985-9-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
References: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 08/10] contrib/rdmacm-mux: remove
 Wno-format-truncation flag
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

The flag is not recognized by some CLANG versions.
Add proper constraints in code instead.

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Tested-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190118124614.24548-2-marcel.apfelbaum@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 contrib/rdmacm-mux/Makefile.objs | 2 +-
 contrib/rdmacm-mux/main.c        | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/rdmacm-mux/Makefile.objs b/contrib/rdmacm-mux/Makefile.objs
index be3eacb6f7..e1ff4fe569 100644
--- a/contrib/rdmacm-mux/Makefile.objs
+++ b/contrib/rdmacm-mux/Makefile.objs
@@ -1,4 +1,4 @@
 ifdef CONFIG_PVRDMA
-CFLAGS += -libumad -Wno-format-truncation
+CFLAGS += -libumad
 rdmacm-mux-obj-y = main.o
 endif
diff --git a/contrib/rdmacm-mux/main.c b/contrib/rdmacm-mux/main.c
index 835a7f9214..64676030c5 100644
--- a/contrib/rdmacm-mux/main.c
+++ b/contrib/rdmacm-mux/main.c
@@ -42,6 +42,8 @@
 
 /* The below can be override by command line parameter */
 #define UNIX_SOCKET_PATH "/var/run/rdmacm-mux"
+/* Has format %s-%s-%d" <path>-<rdma-dev--name>-<port> */
+#define SOCKET_PATH_MAX (PATH_MAX - NAME_MAX - sizeof(int) - 2)
 #define RDMA_PORT_NUM 1
 
 typedef struct RdmaCmServerArgs {
@@ -95,7 +97,7 @@ static void help(const char *progname)
 static void parse_args(int argc, char *argv[])
 {
     int c;
-    char unix_socket_path[PATH_MAX];
+    char unix_socket_path[SOCKET_PATH_MAX];
 
     strcpy(server.args.rdma_dev_name, "");
     strcpy(unix_socket_path, UNIX_SOCKET_PATH);
@@ -113,7 +115,7 @@ static void parse_args(int argc, char *argv[])
 
         case 's':
             /* This is temporary, final name will build below */
-            strncpy(unix_socket_path, optarg, PATH_MAX);
+            strncpy(unix_socket_path, optarg, SOCKET_PATH_MAX);
             break;
 
         case 'p':
-- 
2.17.1
