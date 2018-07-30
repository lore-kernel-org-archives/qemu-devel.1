Received: from eggs.gnu.org ([2001:4830:134:3::10]:47255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fkDrv-00064p-Em
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 15:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fkDrs-00037O-QH
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 15:30:11 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:37806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1fkDrs-00037B-L3
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 15:30:08 -0400
Received: by mail-io0-x244.google.com with SMTP id z19-v6so10855472ioh.4
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 12:30:08 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Mon, 30 Jul 2018 15:29:55 -0400
Message-Id: <20180730192955.14291-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] Add interactive mode to qemu-img command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Changes qemu-img so if the user runs it without any
arguments, it will walk the user thru making an image
file.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 qemu-img.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 9b7506b8ae..aa3df3b431 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4873,6 +4873,32 @@ out:
     return ret;
 }
 
+/* Guides the user on making an image file */
+static int interactive_mode()
+{
+    char format[100];
+    char size[100];
+    char name[1000];
+
+    printf("\nInteractive mode (Enter Control-C to cancel)\n");
+    printf("Please select a format (qcow, qcow2, raw, vdi, vhdx, vmdk, vpc): ");
+    scanf("%100s", format);
+    printf("Please enter a size (e.g. 100M, 10G): ");
+    scanf("%100s", size);
+    printf("Please enter a name: ");
+    scanf("%1000s", name);
+
+    const char *arguments[] = {"create", "-f", format, name, size};
+    int arg_count = 5;
+    int return_value;
+    return_value = img_create(arg_count, (char **)arguments);
+    if (return_value == 0) {
+        printf("Done creating image file\n");
+    }
+
+    return return_value;
+}
+
 static const img_cmd_t img_cmds[] = {
 #define DEF(option, callback, arg_string)        \
     { option, callback },
@@ -4912,8 +4938,9 @@ int main(int argc, char **argv)
 
     module_call_init(MODULE_INIT_QOM);
     bdrv_init();
-    if (argc < 2) {
-        error_exit("Not enough arguments");
+
+    if (argc == 1) { /* If no arguments passed to qemu-img */
+        return interactive_mode();
     }
 
     qemu_add_opts(&qemu_object_opts);
-- 
2.14.3 (Apple Git-98)
