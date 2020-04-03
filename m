Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C356C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219B720737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FrXp8cJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219B720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKRpH-00039m-AY
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 15:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjY-0003O7-Hr
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjW-0002M9-VG
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:04 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jKRjW-0002Ir-LB
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:02 -0400
Received: by mail-wr1-x443.google.com with SMTP id k1so386448wrm.3
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DQHtt4SCEmnNGJRjmTOgUWPksbgm0tCqnL6/z7xrXlo=;
 b=FrXp8cJk0jkbd76O4lmqq6FtWFs19W9KdWxGOHmkqJAceS6srTsPEt2ylJiL9MB7L/
 HHGdH8W/BkcqF+TmRm1N6k24FCOJhGLy6P87WW57DKyx0XpykmnS8vRO/EFgMUE6i0hD
 Z3klBJQTjevHMpNILrpHOgUIJrYcuIkZJLrudX7EOlT+RMTYOQ23u9v1PJVS4VtyIlc/
 xDFfQDJdZiIL6qpYG91Se/rjRNSUwOeS5vDjd/jltQZBwk9lziBu+eqGq9qk1kYMvxVV
 BayRvZrEIgVFbvNFv885oxAliAcyw3F8KOhRumTpC4SlMCCLQpsiVAoQHaICKuJ/ePy1
 Aftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DQHtt4SCEmnNGJRjmTOgUWPksbgm0tCqnL6/z7xrXlo=;
 b=Zfr7MIEbnyiRgqMUYJtErkJyNz9T1VVAoMtFY1FXhJB1U/n8BKsc+6YRp3XeF2mEOE
 sGCYoA1mk+vSCgrKKa4OKtNN1OJtL7WGf6fN+1uyvYKGKfwq2CEXF/WfmWh7cku7ZLJC
 zOqdsE+Z/901ecRpwbspEOVN1zxOKnS2V1QPlt3CZpjl/Qu0UtN65VKNop+9L0pjoogz
 B3/hXPoT//Tjn6STteoDnzcZU3E6UlT5XITmCcIV+AVD5pLlzFyLdt3eRGzLpLo1bV1J
 m7nqntNIJQWPxomTOTVijN4Yc9LqceoGiR0WO1iDs6EZqvQkBLsL9j1Un05gQ0NIq0NM
 xJnA==
X-Gm-Message-State: AGi0Pubt2L8gA0/C3UgQXemYFyWfYYBqxBrlydFPGy4H6Zwzghb5jkI9
 zerEb1LUlgKrN1oKq0I2pFHUeQ==
X-Google-Smtp-Source: APiQypIzXJARcJMjU+AbYfFTUiVnNMAYdLkpV1dKDG0xFO3s5+AThrBYfxl6z/4lQUN/KDDkIqgaEA==
X-Received: by 2002:adf:f401:: with SMTP id g1mr10172141wro.140.1585941121628; 
 Fri, 03 Apr 2020 12:12:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q9sm14726320wrp.84.2020.04.03.12.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 12:11:57 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 648381FF96;
 Fri,  3 Apr 2020 20:11:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 08/12] linux-user: factor out reading of /proc/self/maps
Date: Fri,  3 Apr 2020 20:11:46 +0100
Message-Id: <20200403191150.863-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200403191150.863-1-alex.bennee@linaro.org>
References: <20200403191150.863-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unfortunately reading /proc/self/maps is still considered the gold
standard for a process finding out about it's own memory layout. As we
will want this data in other contexts soon factor out the code to read
and parse the data. Rather than just blindly copying the existing
sscanf based code we use a more modern glib version of the parsing
code to make a more general purpose map structure.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - s/uint64_t/unsigned long/ for MapInfo structure
  - limit to 6 fields and strip leading spaces
---
 include/qemu/selfmap.h | 44 ++++++++++++++++++++++++
 linux-user/syscall.c   | 58 +++++++++++++++----------------
 util/selfmap.c         | 77 ++++++++++++++++++++++++++++++++++++++++++
 util/Makefile.objs     |  1 +
 4 files changed, 150 insertions(+), 30 deletions(-)
 create mode 100644 include/qemu/selfmap.h
 create mode 100644 util/selfmap.c

diff --git a/include/qemu/selfmap.h b/include/qemu/selfmap.h
new file mode 100644
index 00000000000..302c459d695
--- /dev/null
+++ b/include/qemu/selfmap.h
@@ -0,0 +1,44 @@
+/*
+ * Utility functions to read our own memory map
+ *
+ * Copyright (c) 2020 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef _SELFMAP_H_
+#define _SELFMAP_H_
+
+typedef struct {
+    unsigned long start;
+    unsigned long end;
+
+    /* flags */
+    bool is_read;
+    bool is_write;
+    bool is_exec;
+    bool is_priv;
+
+    unsigned long offset;
+    gchar *dev;
+    int   inode;
+    gchar *path;
+} MapInfo;
+
+
+/**
+ * read_self_maps:
+ *
+ * Read /proc/self/maps and return a list of MapInfo structures.
+ */
+GSList *read_self_maps(void);
+
+/**
+ * free_self_maps:
+ * @info: a GSlist
+ *
+ * Free a list of MapInfo structures.
+ */
+void free_self_maps(GSList *info);
+
+#endif /* _SELFMAP_H_ */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b679bc6b136..666be20f3ff 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -117,6 +117,7 @@
 
 #include "qemu.h"
 #include "qemu/guest-random.h"
+#include "qemu/selfmap.h"
 #include "user/syscall-trace.h"
 #include "qapi/error.h"
 #include "fd-trans.h"
@@ -7232,45 +7233,45 @@ static int open_self_maps(void *cpu_env, int fd)
 {
     CPUState *cpu = env_cpu((CPUArchState *)cpu_env);
     TaskState *ts = cpu->opaque;
-    FILE *fp;
-    char *line = NULL;
-    size_t len = 0;
-    ssize_t read;
+    GSList *map_info = read_self_maps();
+    GSList *s;
 
-    fp = fopen("/proc/self/maps", "r");
-    if (fp == NULL) {
-        return -1;
-    }
+    for (s = map_info; s; s = g_slist_next(s)) {
+        MapInfo *e = (MapInfo *) s->data;
 
-    while ((read = getline(&line, &len, fp)) != -1) {
-        int fields, dev_maj, dev_min, inode;
-        uint64_t min, max, offset;
-        char flag_r, flag_w, flag_x, flag_p;
-        char path[512] = "";
-        fields = sscanf(line, "%"PRIx64"-%"PRIx64" %c%c%c%c %"PRIx64" %x:%x %d"
-                        " %512s", &min, &max, &flag_r, &flag_w, &flag_x,
-                        &flag_p, &offset, &dev_maj, &dev_min, &inode, path);
-
-        if ((fields < 10) || (fields > 11)) {
-            continue;
-        }
-        if (h2g_valid(min)) {
+        if (h2g_valid(e->start)) {
+            unsigned long min = e->start;
+            unsigned long max = e->end;
             int flags = page_get_flags(h2g(min));
-            max = h2g_valid(max - 1) ? max : (uintptr_t)g2h(GUEST_ADDR_MAX) + 1;
+            const char *path;
+
+            max = h2g_valid(max - 1) ?
+                max : (uintptr_t) g2h(GUEST_ADDR_MAX) + 1;
+
             if (page_check_range(h2g(min), max - min, flags) == -1) {
                 continue;
             }
+
             if (h2g(min) == ts->info->stack_limit) {
-                pstrcpy(path, sizeof(path), "      [stack]");
+                path = "      [stack]";
+            } else {
+                path = e->path;
             }
+
             dprintf(fd, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
-                    " %c%c%c%c %08" PRIx64 " %02x:%02x %d %s%s\n",
-                    h2g(min), h2g(max - 1) + 1, flag_r, flag_w,
-                    flag_x, flag_p, offset, dev_maj, dev_min, inode,
-                    path[0] ? "         " : "", path);
+                    " %c%c%c%c %08" PRIx64 " %s %d %s%s\n",
+                    h2g(min), h2g(max - 1) + 1,
+                    e->is_read ? 'r' : '-',
+                    e->is_write ? 'w' : '-',
+                    e->is_exec ? 'x' : '-',
+                    e->is_priv ? 'p' : '-',
+                    (uint64_t) e->offset, e->dev, e->inode,
+                    path ? "         " : "", path ? path : "");
         }
     }
 
+    free_self_maps(map_info);
+
 #ifdef TARGET_VSYSCALL_PAGE
     /*
      * We only support execution from the vsyscall page.
@@ -7281,9 +7282,6 @@ static int open_self_maps(void *cpu_env, int fd)
             TARGET_VSYSCALL_PAGE, TARGET_VSYSCALL_PAGE + TARGET_PAGE_SIZE);
 #endif
 
-    free(line);
-    fclose(fp);
-
     return 0;
 }
 
diff --git a/util/selfmap.c b/util/selfmap.c
new file mode 100644
index 00000000000..15d0acdb437
--- /dev/null
+++ b/util/selfmap.c
@@ -0,0 +1,77 @@
+/*
+ * Utility function to get QEMU's own process map
+ *
+ * Copyright (c) 2020 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/selfmap.h"
+
+GSList *read_self_maps(void)
+{
+    gchar *maps;
+    GSList *map_info = NULL;
+
+    if (g_file_get_contents("/proc/self/maps", &maps, NULL, NULL)) {
+        gchar **lines = g_strsplit(maps, "\n", 0);
+        int i, entries = g_strv_length(lines);
+
+        for (i = 0; i < entries; i++) {
+            gchar **fields = g_strsplit(lines[i], " ", 6);
+            if (g_strv_length(fields) > 4) {
+                MapInfo *e = g_new0(MapInfo, 1);
+                int errors;
+                const char *end;
+
+                errors  = qemu_strtoul(fields[0], &end, 16, &e->start);
+                errors += qemu_strtoul(end + 1, NULL, 16, &e->end);
+
+                e->is_read  = fields[1][0] == 'r' ? true : false;
+                e->is_write = fields[1][1] == 'w' ? true : false;
+                e->is_exec  = fields[1][2] == 'x' ? true : false;
+                e->is_priv  = fields[1][3] == 'p' ? true : false;
+
+                errors += qemu_strtoul(fields[2], NULL, 16, &e->offset);
+                e->dev = g_strdup(fields[3]);
+                errors += qemu_strtoi(fields[4], NULL, 10, &e->inode);
+
+                /*
+                 * The last field may have leading spaces which we
+                 * need to strip.
+                 */
+                if (g_strv_length(fields) == 6) {
+                    e->path = g_strdup(g_strchug(fields[5]));
+                }
+                map_info = g_slist_prepend(map_info, e);
+            }
+
+            g_strfreev(fields);
+        }
+        g_strfreev(lines);
+        g_free(maps);
+    }
+
+    /* ensure the map data is in the same order we collected it */
+    return g_slist_reverse(map_info);
+}
+
+/**
+ * free_self_maps:
+ * @info: a GSlist
+ *
+ * Free a list of MapInfo structures.
+ */
+static void free_info(gpointer data)
+{
+    MapInfo *e = (MapInfo *) data;
+    g_free(e->dev);
+    g_free(e->path);
+}
+
+void free_self_maps(GSList *info)
+{
+    g_slist_free_full(info, &free_info);
+}
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 6718a38b616..fe339c2636b 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -63,3 +63,4 @@ util-obj-y += guest-random.o
 util-obj-$(CONFIG_GIO) += dbus.o
 dbus.o-cflags = $(GIO_CFLAGS)
 dbus.o-libs = $(GIO_LIBS)
+util-obj-$(CONFIG_USER_ONLY) += selfmap.o
-- 
2.20.1


