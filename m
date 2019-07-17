Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616C2C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 19:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34617217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 19:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34617217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnpGs-00055g-HD
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 15:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43259)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hnpGi-0004gk-VC
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 15:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hnpGh-0000cB-Sf
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 15:07:12 -0400
Received: from relay.sw.ru ([185.231.240.75]:40462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hnpGh-0000Xx-Lg
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 15:07:11 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hnpGd-0002Un-CF; Wed, 17 Jul 2019 22:07:07 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 22:06:56 +0300
Message-Id: <1563390416-751339-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH] make check-unit: use after free in
 test-opts-visitor
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
Cc: den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com,
 mdroth@linux.vnet.ibm.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In struct OptsVisitor, repeated_opts member points to a list in the
unprocessed_opts hash table after the list has been destroyed. A
subsequent call to visit_type_int() references the deleted list. It
results in use-after-free issue. Also, the Visitor object call back
functions are supposed to set the Error parameter in case of failure.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---

The issue was detected after running tests/test-opts-visitor under the Valgrind tool:

 Invalid read of size 8
   at 0x55ADB95: g_queue_peek_head (in /usr/lib64/libglib-2.0.so.0.5600.1)
   by 0x12FD97: lookup_scalar (opts-visitor.c:310)
   by 0x13008A: opts_type_int64 (opts-visitor.c:395)
   by 0x1299C8: visit_type_int (qapi-visit-core.c:149)
   by 0x119389: test_opts_range_beyond (test-opts-visitor.c:240)

after
 Address 0x9563b30 is 0 bytes inside a block of size 24 free'd
   at 0x4C2ACBD: free (vg_replace_malloc.c:530)
   by 0x55A179D: g_free (in /usr/lib64/libglib-2.0.so.0.5600.1)
   by 0x55B92BF: g_slice_free1 (in /usr/lib64/libglib-2.0.so.0.5600.1)
   by 0x12F615: destroy_list (opts-visitor.c:102)
   by 0x558A859: ??? (in /usr/lib64/libglib-2.0.so.0.5600.1)
   by 0x12FC37: opts_next_list (opts-visitor.c:260)
   by 0x1296B1: visit_next_list (qapi-visit-core.c:88)
   by 0x119341: test_opts_range_beyond (test-opts-visitor.c:238)

 qapi/opts-visitor.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 324b197..e95f766 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -228,6 +228,7 @@ opts_start_list(Visitor *v, const char *name, GenericList **list, size_t size,
         *list = g_malloc0(size);
     } else {
         *list = NULL;
+        error_setg(errp, QERR_MISSING_PARAMETER, name);
     }
 }
 
@@ -255,9 +256,14 @@ opts_next_list(Visitor *v, GenericList *tail, size_t size)
     case LM_IN_PROGRESS: {
         const QemuOpt *opt;
 
+        if (!ov->repeated_opts) {
+            return NULL;
+        }
+
         opt = g_queue_pop_head(ov->repeated_opts);
         if (g_queue_is_empty(ov->repeated_opts)) {
             g_hash_table_remove(ov->unprocessed_opts, opt->name);
+            ov->repeated_opts = NULL;
             return NULL;
         }
         break;
@@ -307,6 +313,10 @@ lookup_scalar(const OptsVisitor *ov, const char *name, Error **errp)
         return list ? g_queue_peek_tail(list) : NULL;
     }
     assert(ov->list_mode == LM_IN_PROGRESS);
+    if (!ov->repeated_opts) {
+        error_setg(errp, QERR_INVALID_PARAMETER, name);
+        return NULL;
+    }
     return g_queue_peek_head(ov->repeated_opts);
 }
 
-- 
1.8.3.1


