Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6611C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916522082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="x2cFeCgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916522082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Ao7-0006e7-Qi
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdJ-0007Kh-Bu
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdH-00028y-5e
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXcEf152601;
 Thu, 30 Jul 2020 15:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=OOANDamxT/8UjVbukusZVM3EHUd5XIA23EDjTuSw9PA=;
 b=x2cFeCgrSHq5pOZc51DK+4PxT5AyGmJa1UYZI4GZodfMOVbP/3yQi7y1zdgMjw5V5GY9
 DJY4TjNOpceEDJ9WBZ6o12fvW3MsGZfSJirah7kD6RysIrBZYfRzNHpGCYBSASDEHZS0
 gTuRco46r+9tGku9RH4Q+ILsi8tse3Y/M/cI5T4OjAl7Fv1nhT/yLoZXZX6/DS5130j3
 xGQNOcg/LhFziRfoVW5p9c5RR6ACBCPdiD4OiBQVagmgqrpyrA92q5JOk659eaIMLgE1
 r8F2vP+Nf0moGMJsi0nRCv9Nyq3lIbUb2qgTZqO2BRm1rqWqjiSyASC/CCeiKzMV8mqw 8Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 32hu1jvdyk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:38:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFWYbh176052;
 Thu, 30 Jul 2020 15:38:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 32hu61a1h0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:38:07 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06UFc60G020470;
 Thu, 30 Jul 2020 15:38:06 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:38:05 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 17/32] util: env var helpers
Date: Thu, 30 Jul 2020 08:14:21 -0700
Message-Id: <1596122076-341293-18-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=1 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=steven.sistare@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 11:38:02
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add functions for saving fd's and ram extents in the environment via
setenv, and for reading them back via getenv.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
---
 MAINTAINERS           |   7 +++
 include/qemu/cutils.h |   1 +
 include/qemu/env.h    |  31 ++++++++++++
 util/Makefile.objs    |   2 +-
 util/env.c            | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100644 include/qemu/env.h
 create mode 100644 util/env.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3395abd..8d377a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3115,3 +3115,10 @@ Performance Tools and Tests
 M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
 S: Maintained
 F: scripts/performance/
+
+Environment variable helpers
+M: Steve Sistare <steven.sistare@oracle.com>
+M: Mark Kanda <mark.kanda@oracle.com>
+S: Maintained
+F: include/qemu/env.h
+F: util/env.c
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index eb59852..d4c7d70 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -1,6 +1,7 @@
 #ifndef QEMU_CUTILS_H
 #define QEMU_CUTILS_H
 
+#include "qemu/env.h"
 /**
  * pstrcpy:
  * @buf: buffer to copy string into
diff --git a/include/qemu/env.h b/include/qemu/env.h
new file mode 100644
index 0000000..53cc121
--- /dev/null
+++ b/include/qemu/env.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_ENV_H
+#define QEMU_ENV_H
+
+#define FD_PREFIX "QEMU_FD_"
+#define ADDR_PREFIX "QEMU_ADDR_"
+#define LEN_PREFIX "QEMU_LEN_"
+#define BOOL_PREFIX "QEMU_BOOL_"
+
+typedef int (*walkenv_cb)(const char *name, const char *val, void *handle);
+
+bool getenv_ram(const char *name, void **addrp, size_t *lenp);
+void setenv_ram(const char *name, void *addr, size_t len);
+void unsetenv_ram(const char *name);
+int getenv_fd(const char *name);
+void setenv_fd(const char *name, int fd);
+void unsetenv_fd(const char *name);
+bool getenv_bool(const char *name);
+void setenv_bool(const char *name, bool val);
+void unsetenv_bool(const char *name);
+int walkenv(const char *prefix, walkenv_cb cb, void *handle);
+void printenv(void);
+
+#endif
diff --git a/util/Makefile.objs b/util/Makefile.objs
index cc5e371..d357932 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -1,4 +1,4 @@
-util-obj-y = osdep.o cutils.o unicode.o qemu-timer-common.o
+util-obj-y = osdep.o cutils.o unicode.o qemu-timer-common.o env.o
 util-obj-$(call lnot,$(CONFIG_ATOMIC64)) += atomic64.o
 util-obj-$(CONFIG_POSIX) += aio-posix.o
 util-obj-$(CONFIG_POSIX) += fdmon-poll.o
diff --git a/util/env.c b/util/env.c
new file mode 100644
index 0000000..0cc4a9f
--- /dev/null
+++ b/util/env.c
@@ -0,0 +1,132 @@
+/*
+ * Copyright (c) 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/env.h"
+
+static uint64_t getenv_ulong(const char *prefix, const char *name, bool *found)
+{
+    char var[80], *val;
+    uint64_t res;
+
+    snprintf(var, sizeof(var), "%s%s", prefix, name);
+    val = getenv(var);
+    if (val) {
+        *found = true;
+        res = strtol(val, 0, 10);
+    } else {
+        *found = false;
+        res = 0;
+    }
+    return res;
+}
+
+static void setenv_ulong(const char *prefix, const char *name, uint64_t val)
+{
+    char var[80], val_str[80];
+    snprintf(var, sizeof(var), "%s%s", prefix, name);
+    snprintf(val_str, sizeof(val_str), "%"PRIu64, val);
+    setenv(var, val_str, 1);
+}
+
+static void unsetenv_ulong(const char *prefix, const char *name)
+{
+    char var[80];
+    snprintf(var, sizeof(var), "%s%s", prefix, name);
+    unsetenv(var);
+}
+
+bool getenv_ram(const char *name, void **addrp, size_t *lenp)
+{
+    bool found1, found2;
+    *addrp = (void *) getenv_ulong(ADDR_PREFIX, name, &found1);
+    *lenp = getenv_ulong(LEN_PREFIX, name, &found2);
+    assert(found1 == found2);
+    return found1;
+}
+
+void setenv_ram(const char *name, void *addr, size_t len)
+{
+    setenv_ulong(ADDR_PREFIX, name, (uint64_t)addr);
+    setenv_ulong(LEN_PREFIX, name, len);
+}
+
+void unsetenv_ram(const char *name)
+{
+    unsetenv_ulong(ADDR_PREFIX, name);
+    unsetenv_ulong(LEN_PREFIX, name);
+}
+
+int getenv_fd(const char *name)
+{
+    bool found;
+    int fd = getenv_ulong(FD_PREFIX, name, &found);
+    if (!found) {
+        fd = -1;
+    }
+    return fd;
+}
+
+void setenv_fd(const char *name, int fd)
+{
+    setenv_ulong(FD_PREFIX, name, fd);
+}
+
+void unsetenv_fd(const char *name)
+{
+    unsetenv_ulong(FD_PREFIX, name);
+}
+
+bool getenv_bool(const char *name)
+{
+    bool found;
+    bool val = getenv_ulong(BOOL_PREFIX, name, &found);
+    if (!found) {
+        val = -1;
+    }
+    return val;
+}
+
+void setenv_bool(const char *name, bool val)
+{
+    setenv_ulong(BOOL_PREFIX, name, val);
+}
+
+void unsetenv_bool(const char *name)
+{
+    unsetenv_ulong(BOOL_PREFIX, name);
+}
+
+int walkenv(const char *prefix, walkenv_cb cb, void *handle)
+{
+    char *str, name[128];
+    char **envp = environ;
+    size_t prefix_len = strlen(prefix);
+
+    while (*envp) {
+        str = *envp++;
+        if (!strncmp(str, prefix, prefix_len)) {
+            char *val = strchr(str, '=');
+            str += prefix_len;
+            strncpy(name, str, val - str);
+            name[val - str] = 0;
+            if (cb(name, val + 1, handle)) {
+                return 1;
+            }
+        }
+    }
+    return 0;
+}
+
+void printenv(void)
+{
+    char **ptr = environ;
+    while (*ptr) {
+        puts(*ptr++);
+    }
+}
-- 
1.8.3.1


