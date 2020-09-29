Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1997C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67127207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUPW9tkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67127207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNA1X-0008B2-Ij
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xD-00035I-CH
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xB-0001bh-Bd
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:39 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vL6e+MeW+Nv0E1LF2S75siP/B/2vecSaAD0WcRAqZJg=;
 b=BUPW9tkYGlXPhXOGMgQNgOXAc8+1Hi0nswblvHM+uF5GspicYwSwAJ374Ln/lqxoWi7UBs
 fTRJSwuxqDdalBqFyV6dH8RqZJfX4bVjGejROjR+3AXervDTXL3Ef/Sr3yAaK89CIkUWET
 HyEsMH+wGX1oab0q75mhdYDYBuWi9Gw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-7Pm3p_cLP8aSMZLxSvoJIQ-1; Tue, 29 Sep 2020 03:21:30 -0400
X-MC-Unique: 7Pm3p_cLP8aSMZLxSvoJIQ-1
Received: by mail-wm1-f72.google.com with SMTP id c200so1454284wmd.5
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vL6e+MeW+Nv0E1LF2S75siP/B/2vecSaAD0WcRAqZJg=;
 b=Hjt7ZBbvCi/gBh+cPxjCF5lifHbhdCCWq0oRr2XBZUA1C/cu2RdLUQEQiKdhDLTLMb
 alCkBi8U8audbnc+miBroTht+Imm5I0NhsZmf0hTlUjSpzOsKjW8MxHWmVeR8vQhWord
 TCuSs+n1Wy4Lgadv0ODjraQtR0iRiCynBhwSQbGG7LWKMlY1wvxZc12BsUxgFArRvsM7
 X0IZL8LmCvahynQjD+672gin/nc2jO6lGpfKTq6RVQwKPB43vgV7qVH+/8d5rWXZuw36
 paLNgq4m5mGbMwn+mzIvabBLxvyuQupNWSakYOqymbz7ykT5S2dKZ0UYCLwBiQSfEfBc
 WGmg==
X-Gm-Message-State: AOAM532divM1xKAEZobapOoDcs7u3KxmDWpwlzRPbh2TkgzYpA6ebK8q
 bj7XXOn92Q6IpcOTLQP0qgC7btrzcc8P0VMOxOz5NMF1JDlpzTV9212fNFwlEIlRXmif1/yV5ty
 bfg4WuGQFxlue3b0=
X-Received: by 2002:a05:600c:2246:: with SMTP id
 a6mr3103593wmm.38.1601364088479; 
 Tue, 29 Sep 2020 00:21:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwB+ys3EkYfbJNmxhvAIYyRZ2kP1ZdnqYeSkAh+yWSBZ621U2BT7PAO5dZTujZu4+1PZyxrPA==
X-Received: by 2002:a05:600c:2246:: with SMTP id
 a6mr3103577wmm.38.1601364088308; 
 Tue, 29 Sep 2020 00:21:28 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id e1sm4910976wrp.49.2020.09.29.00.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:27 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 13/48] util/hexdump: introduce qemu_hexdump_line()
Message-ID: <20200929071948.281157-14-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Li Qiang <liq3ea@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

Dumping one line of hexadecimal/ASCII from a buffer is often needed.
Move this part from qemu_hexdump() and use it

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20200925091055.186023-2-lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/qemu-common.h |  8 +++++++
 util/hexdump.c        | 54 +++++++++++++++++++++++++++----------------
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index 9cfd62669b..cc902b690d 100644
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
index 0b4662e701..2c105a8846 100644
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
MST


