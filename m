Received: from eggs.gnu.org ([2001:4830:134:3::10]:43283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRx-0001oW-NH
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRw-0007Zp-Tw
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:37 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:50:04 -0300
Message-Id: <20171006235023.11952-70-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 69/88] virtio-9p: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: added 2 more uses in hw/9pfs/9p-synth.c]
---
 hw/9pfs/9p-handle.c | 2 +-
 hw/9pfs/9p-proxy.c  | 2 +-
 hw/9pfs/9p-synth.c  | 8 ++++----
 hw/9pfs/9p.c        | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/9p-handle.c b/hw/9pfs/9p-handle.c
index 9875f1894c..357ced3079 100644
--- a/hw/9pfs/9p-handle.c
+++ b/hw/9pfs/9p-handle.c
@@ -609,7 +609,7 @@ static int handle_init(FsContext *ctx)
     int ret, mnt_id;
     struct statfs stbuf;
     struct file_handle fh;
-    struct handle_data *data = g_malloc(sizeof(struct handle_data));
+    struct handle_data *data = g_new(struct handle_data, 1);
 
     data->mountfd = open(ctx->fs_root, O_DIRECTORY);
     if (data->mountfd < 0) {
diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index 28b20a7c3d..2de303d713 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -1136,7 +1136,7 @@ static int proxy_parse_opts(QemuOpts *opts, struct FsDriverEntry *fs)
 
 static int proxy_init(FsContext *ctx)
 {
-    V9fsProxy *proxy = g_malloc(sizeof(V9fsProxy));
+    V9fsProxy *proxy = g_new(V9fsProxy, 1);
     int sock_id;
 
     if (ctx->export_flags & V9FS_PROXY_SOCK_NAME) {
diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index df0a8de08a..3aa69cf465 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -43,7 +43,7 @@ static V9fsSynthNode *v9fs_add_dir_node(V9fsSynthNode *parent, int mode,
 
     /* Add directory type and remove write bits */
     mode = ((mode & 0777) | S_IFDIR) & ~(S_IWUSR | S_IWGRP | S_IWOTH);
-    node = g_malloc0(sizeof(V9fsSynthNode));
+    node = g_new0(V9fsSynthNode, 1);
     if (attr) {
         /* We are adding .. or . entries */
         node->attr = attr;
@@ -124,7 +124,7 @@ int qemu_v9fs_synth_add_file(V9fsSynthNode *parent, int mode,
     }
     /* Add file type and remove write bits */
     mode = ((mode & 0777) | S_IFREG);
-    node = g_malloc0(sizeof(V9fsSynthNode));
+    node = g_new0(V9fsSynthNode, 1);
     node->attr         = &node->actual_attr;
     node->attr->inode  = synth_node_count++;
     node->attr->nlink  = 1;
@@ -180,7 +180,7 @@ static int synth_opendir(FsContext *ctx,
     V9fsSynthOpenState *synth_open;
     V9fsSynthNode *node = *(V9fsSynthNode **)fs_path->data;
 
-    synth_open = g_malloc(sizeof(*synth_open));
+    synth_open = g_new(V9fsSynthOpenState, 1);
     synth_open->node = node;
     node->open_count++;
     fs->private = synth_open;
@@ -264,7 +264,7 @@ static int synth_open(FsContext *ctx, V9fsPath *fs_path,
     V9fsSynthOpenState *synth_open;
     V9fsSynthNode *node = *(V9fsSynthNode **)fs_path->data;
 
-    synth_open = g_malloc(sizeof(*synth_open));
+    synth_open = g_new(V9fsSynthOpenState, 1);
     synth_open->node = node;
     node->open_count++;
     fs->private = synth_open;
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 23ac7bb532..510867b4dc 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -298,7 +298,7 @@ static V9fsFidState *alloc_fid(V9fsState *s, int32_t fid)
             return NULL;
         }
     }
-    f = g_malloc0(sizeof(V9fsFidState));
+    f = g_new0(V9fsFidState, 1);
     f->fid = fid;
     f->fid_type = P9_FID_NONE;
     f->ref = 1;
-- 
2.14.2
