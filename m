Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121BBCA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA7C222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA7C222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLRzO-0003lc-Rs
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iLRyW-0003CP-7J
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iLRyU-0000gh-AI
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:07:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41050)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iLRyU-0000ff-56; Fri, 18 Oct 2019 09:07:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1F196307D9D0;
 Fri, 18 Oct 2019 13:07:21 +0000 (UTC)
Received: from thuth.com (reserved-198-128.str.redhat.com [10.33.198.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6986D5D772;
 Fri, 18 Oct 2019 13:07:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] Do not use %m in common code to print error messages
Date: Fri, 18 Oct 2019 15:07:16 +0200
Message-Id: <20191018130716.25438-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 18 Oct 2019 13:07:21 +0000 (UTC)
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
 v2: Do not try to g_free() the strings

 hw/misc/tmp421.c | 4 ++--
 util/main-loop.c | 3 ++-
 util/systemd.c   | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
index 9f044705fa..c0bc150bca 100644
--- a/hw/misc/tmp421.c
+++ b/hw/misc/tmp421.c
@@ -120,7 +120,7 @@ static void tmp421_get_temperature(Object *obj, Visitor *v, const char *name,
     int tempid;
 
     if (sscanf(name, "temperature%d", &tempid) != 1) {
-        error_setg(errp, "error reading %s: %m", name);
+        error_setg(errp, "error reading %s: %s", name, g_strerror(errno));
         return;
     }
 
@@ -160,7 +160,7 @@ static void tmp421_set_temperature(Object *obj, Visitor *v, const char *name,
     }
 
     if (sscanf(name, "temperature%d", &tempid) != 1) {
-        error_setg(errp, "error reading %s: %m", name);
+        error_setg(errp, "error reading %s: %s", name, g_strerror(errno));
         return;
     }
 
diff --git a/util/main-loop.c b/util/main-loop.c
index e3eaa55866..eda63fe4e0 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -61,7 +61,8 @@ static void sigfd_handler(void *opaque)
         }
 
         if (len != sizeof(info)) {
-            printf("read from sigfd returned %zd: %m\n", len);
+            error_report("read from sigfd returned %zd: %s", len,
+                         g_strerror(errno));
             return;
         }
 
diff --git a/util/systemd.c b/util/systemd.c
index d22e86c707..1dd0367d9a 100644
--- a/util/systemd.c
+++ b/util/systemd.c
@@ -60,8 +60,8 @@ unsigned int check_socket_activation(void)
              * and we should exit.
              */
             error_report("Socket activation failed: "
-                         "invalid file descriptor fd = %d: %m",
-                         fd);
+                         "invalid file descriptor fd = %d: %s",
+                         fd, g_strerror(errno));
             exit(EXIT_FAILURE);
         }
     }
-- 
2.18.1


