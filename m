Received: from eggs.gnu.org ([2001:4830:134:3::10]:59966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxJ9X-0000m0-7V
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxJ9V-0004CJ-9C
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:41:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxJ9V-0004Bn-08
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:41:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2D7B13D9E9
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 20:41:51 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 27 Sep 2017 17:41:47 -0300
Message-Id: <20170927204148.2311-2-ehabkost@redhat.com>
In-Reply-To: <20170927204148.2311-1-ehabkost@redhat.com>
References: <20170927204148.2311-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/2] config: qemu_config_parse() return
 number of config groups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Change qemu_config_parse() to return the number of config groups
in success and -EINVAL on error. This will allow callers of
qemu_config_parse() to check if something was really loaded from
the config file.

All existing callers of qemu_config_parse() and
qemu_read_config_file() only check if the return value was
negative, so the change shouldn't affect them.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2 -> v3:
* None (rebase only)

Changes v1 -> v2:
* Remove unnecessary translation of qemu_config_parse()
  erros to -EINVAL at block/blkdebug.c:read_config()
  * Suggsted-by: Markus Armbruster <armbru@redhat.com>
---
 block/blkdebug.c   |  1 -
 util/qemu-config.c | 15 +++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 46e53f2f09..dfdf9b91aa 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -244,7 +244,6 @@ static int read_config(BDRVBlkdebugState *s, const char *filename,
         ret = qemu_config_parse(f, config_groups, filename);
         if (ret < 0) {
             error_setg(errp, "Could not parse blkdebug config file");
-            ret = -EINVAL;
             goto fail;
         }
     }
diff --git a/util/qemu-config.c b/util/qemu-config.c
index 405dd1a1d7..99b0e46fa3 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -385,6 +385,7 @@ void qemu_config_write(FILE *fp)
     }
 }
 
+/* Returns number of config groups on success, -errno on error */
 int qemu_config_parse(FILE *fp, QemuOptsList **lists, const char *fname)
 {
     char line[1024], group[64], id[64], arg[64], value[1024];
@@ -392,7 +393,8 @@ int qemu_config_parse(FILE *fp, QemuOptsList **lists, const char *fname)
     QemuOptsList *list = NULL;
     Error *local_err = NULL;
     QemuOpts *opts = NULL;
-    int res = -1, lno = 0;
+    int res = -EINVAL, lno = 0;
+    int count = 0;
 
     loc_push_none(&loc);
     while (fgets(line, sizeof(line), fp) != NULL) {
@@ -413,6 +415,7 @@ int qemu_config_parse(FILE *fp, QemuOptsList **lists, const char *fname)
                 goto out;
             }
             opts = qemu_opts_create(list, id, 1, NULL);
+            count++;
             continue;
         }
         if (sscanf(line, "[%63[^]]]", group) == 1) {
@@ -423,6 +426,7 @@ int qemu_config_parse(FILE *fp, QemuOptsList **lists, const char *fname)
                 goto out;
             }
             opts = qemu_opts_create(list, NULL, 0, &error_abort);
+            count++;
             continue;
         }
         value[0] = '\0';
@@ -447,7 +451,7 @@ int qemu_config_parse(FILE *fp, QemuOptsList **lists, const char *fname)
         error_report("error reading file");
         goto out;
     }
-    res = 0;
+    res = count;
 out:
     loc_pop(&loc);
     return res;
@@ -464,12 +468,7 @@ int qemu_read_config_file(const char *filename)
 
     ret = qemu_config_parse(f, vm_config_groups, filename);
     fclose(f);
-
-    if (ret == 0) {
-        return 0;
-    } else {
-        return -EINVAL;
-    }
+    return ret;
 }
 
 static void config_parse_qdict_section(QDict *options, QemuOptsList *opts,
-- 
2.13.5
