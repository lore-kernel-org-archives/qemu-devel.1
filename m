Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA33CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0AA222C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0AA222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLPlU-0001t7-BQ
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 06:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iLPkW-0000ys-D3
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iLPkT-00042D-M4
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:44:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iLPkT-0003z5-GG; Fri, 18 Oct 2019 06:44:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ABE7310DCC96;
 Fri, 18 Oct 2019 10:44:44 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DD6860852;
 Fri, 18 Oct 2019 10:44:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Do not use %m in common code to print error messages
Date: Fri, 18 Oct 2019 12:44:38 +0200
Message-Id: <20191018104438.6158-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 18 Oct 2019 10:44:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The %m format specifier is an extension from glibc - and when compiling
QEMU for NetBSD, the compiler correctly complains, e.g.:

/home/qemu/qemu-test.ELjfrQ/src/util/main-loop.c: In function 'sigfd_handler':
/home/qemu/qemu-test.ELjfrQ/src/util/main-loop.c:64:13: warning: %m is only
 allowed in syslog(3) like functions [-Wformat=]
             printf("read from sigfd returned %zd: %m\n", len);
             ^
Let's use g_strerror() here instead, which is an easy-to-use wrapper
around the thread-safe strerror_r() function.

While we're at it, also convert the "printf()" in main-loop.c into
the preferred "error_report()".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/misc/tmp421.c | 8 ++++++--
 util/main-loop.c | 4 +++-
 util/systemd.c   | 5 +++--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
index 9f044705fa..f23c46a40a 100644
--- a/hw/misc/tmp421.c
+++ b/hw/misc/tmp421.c
@@ -120,7 +120,9 @@ static void tmp421_get_temperature(Object *obj, Visitor *v, const char *name,
     int tempid;
 
     if (sscanf(name, "temperature%d", &tempid) != 1) {
-        error_setg(errp, "error reading %s: %m", name);
+        const char *errmsg = g_strerror(errno);
+        error_setg(errp, "error reading %s: %s", name, errmsg);
+        g_free((gpointer)errmsg);
         return;
     }
 
@@ -160,7 +162,9 @@ static void tmp421_set_temperature(Object *obj, Visitor *v, const char *name,
     }
 
     if (sscanf(name, "temperature%d", &tempid) != 1) {
-        error_setg(errp, "error reading %s: %m", name);
+        const char *errmsg = g_strerror(errno);
+        error_setg(errp, "error reading %s: %s", errmsg);
+        g_free((gpointer)errmsg);
         return;
     }
 
diff --git a/util/main-loop.c b/util/main-loop.c
index e3eaa55866..e95d93fef3 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -61,7 +61,9 @@ static void sigfd_handler(void *opaque)
         }
 
         if (len != sizeof(info)) {
-            printf("read from sigfd returned %zd: %m\n", len);
+            const char *errmsg = g_strerror(errno);
+            error_report("read from sigfd returned %zd: %s", len, errmsg);
+            g_free((gpointer)errmsg);
             return;
         }
 
diff --git a/util/systemd.c b/util/systemd.c
index d22e86c707..17862c704f 100644
--- a/util/systemd.c
+++ b/util/systemd.c
@@ -59,9 +59,10 @@ unsigned int check_socket_activation(void)
              * descriptor is invalid, so socket activation has gone wrong
              * and we should exit.
              */
+            const char *errmsg = g_strerror(errno);
             error_report("Socket activation failed: "
-                         "invalid file descriptor fd = %d: %m",
-                         fd);
+                         "invalid file descriptor fd = %d: %s", fd, errmsg);
+            g_free((gpointer)errmsg);
             exit(EXIT_FAILURE);
         }
     }
-- 
2.18.1


