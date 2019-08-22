Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C84C3A59E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 01:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC7922DD3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 01:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC7922DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0blX-0006AS-MG
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 21:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1i0bik-0003aV-NK
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 21:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1i0bii-0002UM-TT
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 21:16:58 -0400
Received: from ozlabs.ru ([107.173.13.209]:42962)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1i0bii-0002Tn-NF
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 21:16:56 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 5F817AE80024;
 Wed, 21 Aug 2019 21:16:04 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 11:16:20 +1000
Message-Id: <20190822011620.106337-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 107.173.13.209
Subject: [Qemu-devel] [RFC PATCH qemu] qapi: Add query-memory-checksum
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This returns MD5 checksum of all RAM blocks for migration debugging
as this is way faster than saving the entire RAM to a file and checking
that.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---


I am actually wondering if there is an easier way of getting these
checksums and I just do not see it, it cannot be that we fixed all
memory migration bugs :)


---
 qapi/misc.json            | 27 +++++++++++++++++++++++++++
 include/exec/cpu-common.h |  1 +
 exec.c                    | 16 ++++++++++++++++
 monitor/qmp-cmds.c        |  9 +++++++++
 4 files changed, 53 insertions(+)

diff --git a/qapi/misc.json b/qapi/misc.json
index a7fba7230cfa..e7475f30a844 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1194,6 +1194,33 @@
 ##
 { 'command': 'query-memory-size-summary', 'returns': 'MemoryInfo' }
 
+##
+# @MemoryChecksum:
+#
+# A string with MD5 checksum of all RAMBlocks.
+#
+# @checksum: the checksum.
+#
+# Since: 3.2.0
+##
+{ 'struct': 'MemoryChecksum',
+  'data'  : { 'checksum': 'str' } }
+
+##
+# @query-memory-checksum:
+#
+# Return the MD5 checksum of all RAMBlocks.
+#
+# Example:
+#
+# -> { "execute": "query-memory-checksum" }
+# <- { "return": { "checksum": "a0880304994f64cb2edad77b9a1cd58f" } }
+#
+# Since: 3.2.0
+##
+{ 'command': 'query-memory-checksum',
+  'returns': 'MemoryChecksum' }
+
 
 ##
 # @AddfdInfo:
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index f7dbe75fbc38..15dbf18c2d5d 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -57,6 +57,7 @@ void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
 void qemu_ram_unset_idstr(RAMBlock *block);
 const char *qemu_ram_get_idstr(RAMBlock *rb);
 void *qemu_ram_get_host_addr(RAMBlock *rb);
+gchar *qemu_ram_chksum(void);
 ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
 ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
 bool qemu_ram_is_shared(RAMBlock *rb);
diff --git a/exec.c b/exec.c
index 3e78de3b8f8b..76f7f63cf71b 100644
--- a/exec.c
+++ b/exec.c
@@ -2050,6 +2050,22 @@ void *qemu_ram_get_host_addr(RAMBlock *rb)
     return rb->host;
 }
 
+gchar *qemu_ram_chksum(void)
+{
+    struct RAMBlock *rb;
+    GChecksum *chksum = g_checksum_new(G_CHECKSUM_MD5);
+    gchar *ret;
+
+    RAMBLOCK_FOREACH(rb) {
+        g_checksum_update(chksum, qemu_ram_get_host_addr(rb),
+                          qemu_ram_get_used_length(rb));
+    }
+    ret = g_strdup(g_checksum_get_string(chksum));
+    g_checksum_free(chksum);
+
+    return ret;
+}
+
 ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
 {
     return rb->offset;
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index b9ae40eec751..ec52bd82588e 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -413,3 +413,12 @@ MemoryInfo *qmp_query_memory_size_summary(Error **errp)
 
     return mem_info;
 }
+
+MemoryChecksum *qmp_query_memory_checksum(Error **errp)
+{
+    MemoryChecksum *chk = g_malloc0(sizeof(MemoryChecksum));
+
+    chk->checksum = qemu_ram_chksum();
+
+    return chk;
+}
-- 
2.17.1


