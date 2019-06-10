Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DF0C468BE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 03:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34212067C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 03:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34212067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40164 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haAkJ-0007kQ-6P
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 23:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39037)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1haAgv-0004aJ-Kn
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 23:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1haAgu-0005sr-DJ
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 23:09:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:49683)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1haAgu-0005rt-5p
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 23:09:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jun 2019 20:09:47 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga006.fm.intel.com with ESMTP; 09 Jun 2019 20:09:46 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 11:08:52 +0800
Message-Id: <20190610030852.16039-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190610030852.16039-1-richardw.yang@linux.intel.com>
References: <20190610030852.16039-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
Subject: [Qemu-devel] [PATCH 2/2] migration/xbzrle: make
 xbzrle_encode_buffer little easier to read
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The encoding process could be described below:

    for [content]
        get length of a run
        encode this run

By refactoring the code with this logic, it maybe a little easier to
understand.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/xbzrle.c | 153 +++++++++++++++++++++------------------------
 1 file changed, 73 insertions(+), 80 deletions(-)

diff --git a/migration/xbzrle.c b/migration/xbzrle.c
index 1ba482ded9..25c69708ec 100644
--- a/migration/xbzrle.c
+++ b/migration/xbzrle.c
@@ -14,6 +14,59 @@
 #include "qemu/cutils.h"
 #include "xbzrle.h"
 
+static int next_run(uint8_t *old_buf, uint8_t *new_buf, int off, int slen,
+                    bool zrun)
+{
+    uint32_t len = 0;
+    long res;
+
+    res = (slen - off) % sizeof(long);
+
+    /* first unaligned bytes */
+    while (res) {
+        uint8_t xor = old_buf[off + len] ^ new_buf[off + len];
+
+        if (!(zrun ^ !!xor)) {
+            break;
+        }
+        len++;
+        res--;
+    }
+
+    if (res) {
+        return len;
+    }
+
+    /* word at a time for speed, use of 32-bit long okay */
+    while (off + len < slen) {
+        /* truncation to 32-bit long okay */
+        unsigned long mask = (unsigned long)0x0101010101010101ULL;
+        long xor = (*(long *)(old_buf + off + len)) ^
+                   (*(long *)(new_buf + off + len));
+
+        if (zrun && !(zrun ^ !!xor)) {
+            break;
+        } else if (!zrun && ((xor - mask) & ~xor & (mask << 7))) {
+            break;
+        }
+
+        len += sizeof(long);
+    }
+
+    /* go over the rest */
+    while (off + len < slen) {
+        uint8_t xor = old_buf[off + len] ^ new_buf[off + len];
+
+        if (!(zrun ^ !!xor)) {
+            break;
+        }
+
+        len++;
+    }
+
+    return len;
+}
+
 /*
   page = zrun nzrun
        | zrun nzrun page
@@ -27,103 +80,43 @@
 int xbzrle_encode_buffer(uint8_t *old_buf, uint8_t *new_buf, int slen,
                          uint8_t *dst, int dlen)
 {
-    uint32_t zrun_len = 0, nzrun_len = 0;
-    int d = 0, i = 0;
-    long res;
-    uint8_t *nzrun_start = NULL;
+    bool zrun = true;
+    int len, src_off = 0, dst_off = 0;
 
     g_assert(!(((uintptr_t)old_buf | (uintptr_t)new_buf | slen) %
                sizeof(long)));
 
-    while (i < slen) {
+    for (; src_off < slen; src_off += len, zrun = !zrun) {
         /* overflow */
-        if (d + 2 > dlen) {
+        if (dst_off + 2 > dlen) {
             return -1;
         }
 
-        /* not aligned to sizeof(long) */
-        res = (slen - i) % sizeof(long);
-        while (res && old_buf[i] == new_buf[i]) {
-            zrun_len++;
-            i++;
-            res--;
-        }
+        len = next_run(old_buf, new_buf, src_off, slen, zrun);
 
-        /* word at a time for speed */
-        if (!res) {
-            while (i < slen &&
-                   (*(long *)(old_buf + i)) == (*(long *)(new_buf + i))) {
-                i += sizeof(long);
-                zrun_len += sizeof(long);
+        if (zrun) {
+            /* buffer unchanged */
+            if (len == slen) {
+                return 0;
             }
-
-            /* go over the rest */
-            while (i < slen && old_buf[i] == new_buf[i]) {
-                zrun_len++;
-                i++;
+            /* skip last zero run */
+            if (src_off + len == slen) {
+                return dst_off;
             }
         }
 
-        /* buffer unchanged */
-        if (zrun_len == slen) {
-            return 0;
-        }
-
-        /* skip last zero run */
-        if (i == slen) {
-            return d;
-        }
-
-        d += uleb128_encode_small(dst + d, zrun_len);
-
-        zrun_len = 0;
-        nzrun_start = new_buf + i;
-
-        /* overflow */
-        if (d + 2 > dlen) {
-            return -1;
-        }
-        /* not aligned to sizeof(long) */
-        res = (slen - i) % sizeof(long);
-        while (res && old_buf[i] != new_buf[i]) {
-            i++;
-            nzrun_len++;
-            res--;
-        }
-
-        /* word at a time for speed, use of 32-bit long okay */
-        if (!res) {
-            /* truncation to 32-bit long okay */
-            unsigned long mask = (unsigned long)0x0101010101010101ULL;
-            while (i < slen) {
-                unsigned long xor;
-                xor = *(unsigned long *)(old_buf + i)
-                    ^ *(unsigned long *)(new_buf + i);
-                if ((xor - mask) & ~xor & (mask << 7)) {
-                    /* found the end of an nzrun within the current long */
-                    while (old_buf[i] != new_buf[i]) {
-                        nzrun_len++;
-                        i++;
-                    }
-                    break;
-                } else {
-                    i += sizeof(long);
-                    nzrun_len += sizeof(long);
-                }
+        dst_off += uleb128_encode_small(dst + dst_off, len);
+        if (!zrun) {
+            /* overflow */
+            if (dst_off + len > dlen) {
+                return -1;
             }
+            memcpy(dst + dst_off, new_buf + src_off, len);
+            dst_off += len;
         }
-
-        d += uleb128_encode_small(dst + d, nzrun_len);
-        /* overflow */
-        if (d + nzrun_len > dlen) {
-            return -1;
-        }
-        memcpy(dst + d, nzrun_start, nzrun_len);
-        d += nzrun_len;
-        nzrun_len = 0;
     }
 
-    return d;
+    return dst_off;
 }
 
 int xbzrle_decode_buffer(uint8_t *src, int slen, uint8_t *dst, int dlen)
-- 
2.19.1


