Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD80AC4727F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1930C206B5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2aFztUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1930C206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjmG-0005CT-6R
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 05:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kLjl3-000404-F1
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45555)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kLjl1-0007ss-RE
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:11:13 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601025070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=le/AFLjMKIUwwPTP9MPoIbrqeSSlGtYNtRO3yJzdnUk=;
 b=Z2aFztUGX/vELKVrV9dR+A7WBBqFSOx+IE6Vr3VBqywCYH8kkah+6iI4lrtPKDLwof6JqS
 lBhRPeXPHM+1Vp0CbSgyM9LkCjRwYfh2iC1aFoyMuozBwtdMQQMkMfZXui8JLa/L2JSSFU
 nF+KfWJnRnjmY7wpcjQOFIMqmFApTS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-mmIcUKKIMjuh8VWTM8yC4w-1; Fri, 25 Sep 2020 05:11:08 -0400
X-MC-Unique: mmIcUKKIMjuh8VWTM8yC4w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E61A1800597
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:11:07 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-112-16.ams2.redhat.com [10.36.112.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3482E1002C0F;
 Fri, 25 Sep 2020 09:11:05 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] util/hexdump: introduce qemu_hexdump_line()
Date: Fri, 25 Sep 2020 11:10:54 +0200
Message-Id: <20200925091055.186023-2-lvivier@redhat.com>
In-Reply-To: <20200925091055.186023-1-lvivier@redhat.com>
References: <20200925091055.186023-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dumping one line of hexadecimal/ASCII from a buffer is often needed.
Move this part from qemu_hexdump() and use it

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 include/qemu-common.h |  8 +++++++
 util/hexdump.c        | 54 +++++++++++++++++++++++++++----------------
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index 9cfd62669bf8..cc902b690db3 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -134,6 +134,14 @@ void os_setup_early_signal_handling(void);
 char *os_find_datadir(void);
 int os_parse_cmd_args(int index, const char *optarg);
 
+/*
+ * Hexdump a line of a byte buffer into a hexadecimal/ASCII buffer
+ */
+#define QEMU_HEXDUMP_LINE_BYTES 16 /* Number of bytes to dump */
+#define QEMU_HEXDUMP_LINE_LEN 75   /* Number of characters in line */
+void qemu_hexdump_line(char *line, unsigned int b, const void *bufptr,
+                       unsigned int len, bool ascii);
+
 /*
  * Hexdump a buffer to a file. An optional string prefix is added to every line
  */
diff --git a/util/hexdump.c b/util/hexdump.c
index 0b4662e701d8..2c105a884620 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -16,36 +16,50 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 
-void qemu_hexdump(FILE *fp, const char *prefix,
-                  const void *bufptr, size_t size)
+void qemu_hexdump_line(char *line, unsigned int b, const void *bufptr,
+                       unsigned int len, bool ascii)
 {
     const char *buf = bufptr;
-    unsigned int b, len, i, c;
+    int i, c;
 
-    for (b = 0; b < size; b += 16) {
-        len = size - b;
-        if (len > 16) {
-            len = 16;
+    if (len > QEMU_HEXDUMP_LINE_BYTES) {
+        len = QEMU_HEXDUMP_LINE_BYTES;
+    }
+
+    line += snprintf(line, 6, "%04x:", b);
+    for (i = 0; i < QEMU_HEXDUMP_LINE_BYTES; i++) {
+        if ((i % 4) == 0) {
+            *line++ = ' ';
         }
-        fprintf(fp, "%s: %04x:", prefix, b);
-        for (i = 0; i < 16; i++) {
-            if ((i % 4) == 0) {
-                fprintf(fp, " ");
-            }
-            if (i < len) {
-                fprintf(fp, " %02x", (unsigned char)buf[b + i]);
-            } else {
-                fprintf(fp, "   ");
-            }
+        if (i < len) {
+            line += sprintf(line, " %02x", (unsigned char)buf[b + i]);
+        } else {
+            line += sprintf(line, "   ");
         }
-        fprintf(fp, " ");
+    }
+    if (ascii) {
+        *line++ = ' ';
         for (i = 0; i < len; i++) {
             c = buf[b + i];
             if (c < ' ' || c > '~') {
                 c = '.';
             }
-            fprintf(fp, "%c", c);
+            *line++ = c;
         }
-        fprintf(fp, "\n");
     }
+    *line = '\0';
+}
+
+void qemu_hexdump(FILE *fp, const char *prefix,
+                  const void *bufptr, size_t size)
+{
+    unsigned int b, len;
+    char line[QEMU_HEXDUMP_LINE_LEN];
+
+    for (b = 0; b < size; b += QEMU_HEXDUMP_LINE_BYTES) {
+        len = size - b;
+        qemu_hexdump_line(line, b, bufptr, len, true);
+        fprintf(fp, "%s: %s\n", prefix, line);
+    }
+
 }
-- 
2.26.2


