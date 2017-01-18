Received: from eggs.gnu.org ([2001:4830:134:3::10]:34455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTqj4-0006H8-CT
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTqj2-00089a-7C
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:56:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTqj2-00089N-1J
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:56:32 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 259A7C14D042
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 13:56:32 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 18 Jan 2017 11:56:23 -0200
Message-Id: <20170118135624.17368-2-ehabkost@redhat.com>
In-Reply-To: <20170118135624.17368-1-ehabkost@redhat.com>
References: <20170118135624.17368-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] config: qemu_config_parse() return number
 of config groups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

Change qemu_config_parse() to return the number of config groups
in success and -EINVAL on error. This will allow callers of
qemu_config_parse() to check if something was really loaded from
the config file.

All existing callers of qemu_config_parse() and
qemu_read_config_file() only check if the return value was
negative, so the change shouldn't affect them.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 util/qemu-config.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/util/qemu-config.c b/util/qemu-config.c
index 5527100a01..560c201bd3 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -379,6 +379,7 @@ void qemu_config_write(FILE *fp)
     }
 }
 
+/* Returns number of config groups on success, -errno on error */
 int qemu_config_parse(FILE *fp, QemuOptsList **lists, const char *fname)
 {
     char line[1024], group[64], id[64], arg[64], value[1024];
@@ -386,7 +387,8 @@ int qemu_config_parse(FILE *fp, QemuOptsList **lists, const char *fname)
     QemuOptsList *list = NULL;
     Error *local_err = NULL;
     QemuOpts *opts = NULL;
-    int res = -1, lno = 0;
+    int res = -EINVAL, lno = 0;
+    int count = 0;
 
     loc_push_none(&loc);
     while (fgets(line, sizeof(line), fp) != NULL) {
@@ -407,6 +409,7 @@ int qemu_config_parse(FILE *fp, QemuOptsList **lists, const char *fname)
                 goto out;
             }
             opts = qemu_opts_create(list, id, 1, NULL);
+            count++;
             continue;
         }
         if (sscanf(line, "[%63[^]]]", group) == 1) {
@@ -417,6 +420,7 @@ int qemu_config_parse(FILE *fp, QemuOptsList **lists, const char *fname)
                 goto out;
             }
             opts = qemu_opts_create(list, NULL, 0, &error_abort);
+            count++;
             continue;
         }
         value[0] = '\0';
@@ -441,7 +445,7 @@ int qemu_config_parse(FILE *fp, QemuOptsList **lists, const char *fname)
         error_report("error reading file");
         goto out;
     }
-    res = 0;
+    res = count;
 out:
     loc_pop(&loc);
     return res;
@@ -458,12 +462,7 @@ int qemu_read_config_file(const char *filename)
 
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
2.11.0.259.g40922b1
