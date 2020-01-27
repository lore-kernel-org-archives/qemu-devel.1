Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C11DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 22:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66FAF206A2
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 22:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTMszmPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FAF206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwD3s-0003mS-I9
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 17:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iwCxC-0000Q5-9k
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iwCxB-0003M7-0N
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:33:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29119
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iwCxA-0003Lt-Tg
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580164436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y4GJ6yH7oYiMs8WOW08S8XjjieCCrNxqcouWxDNYfQ0=;
 b=dTMszmPUN2JW8DUrn3LuqAfe2dbYwmO/KZLONi9ZrTK52Gu/May2Dp98ij6kP1oo27ELSS
 1IlRvAzVS+myaAhhUcyTgNy7rETin8cl8B68UpY0BDKBQClw4LRPUVmxF+6kYieV9iwPcY
 4NPF0MCO8UbVdFGp49DKoWt9if8Fa+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-P8K7ek64NLGoTJ6L8JcZAQ-1; Mon, 27 Jan 2020 17:33:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16E9C8010C4
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 22:33:54 +0000 (UTC)
Received: from secure.mitica (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C633C3B7;
 Mon, 27 Jan 2020 22:33:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/19] ram_addr: Split RAMBlock definition
Date: Mon, 27 Jan 2020 23:33:10 +0100
Message-Id: <20200127223321.2742-9-quintela@redhat.com>
In-Reply-To: <20200127223321.2742-1-quintela@redhat.com>
References: <20200127223321.2742-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: P8K7ek64NLGoTJ6L8JcZAQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need some of the fields without having to poison everything else.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 MAINTAINERS             |  1 +
 include/exec/ram_addr.h | 40 +-------------------------
 include/exec/ramblock.h | 64 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 39 deletions(-)
 create mode 100644 include/exec/ramblock.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f6511d5120..b570a24d4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1973,6 +1973,7 @@ F: ioport.c
 F: include/exec/memop.h
 F: include/exec/memory.h
 F: include/exec/ram_addr.h
+F: include/exec/ramblock.h
 F: memory.c
 F: include/exec/memory-internal.h
 F: exec.c
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 5adebb0bc7..5e59a3d8d7 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -24,45 +24,7 @@
 #include "hw/xen/xen.h"
 #include "sysemu/tcg.h"
 #include "exec/ramlist.h"
-
-struct RAMBlock {
-    struct rcu_head rcu;
-    struct MemoryRegion *mr;
-    uint8_t *host;
-    uint8_t *colo_cache; /* For colo, VM's ram cache */
-    ram_addr_t offset;
-    ram_addr_t used_length;
-    ram_addr_t max_length;
-    void (*resized)(const char*, uint64_t length, void *host);
-    uint32_t flags;
-    /* Protected by iothread lock.  */
-    char idstr[256];
-    /* RCU-enabled, writes protected by the ramlist lock */
-    QLIST_ENTRY(RAMBlock) next;
-    QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
-    int fd;
-    size_t page_size;
-    /* dirty bitmap used during migration */
-    unsigned long *bmap;
-    /* bitmap of already received pages in postcopy */
-    unsigned long *receivedmap;
-
-    /*
-     * bitmap to track already cleared dirty bitmap.  When the bit is
-     * set, it means the corresponding memory chunk needs a log-clear.
-     * Set this up to non-NULL to enable the capability to postpone
-     * and split clearing of dirty bitmap on the remote node (e.g.,
-     * KVM).  The bitmap will be set only when doing global sync.
-     *
-     * NOTE: this bitmap is different comparing to the other bitmaps
-     * in that one bit can represent multiple guest pages (which is
-     * decided by the `clear_bmap_shift' variable below).  On
-     * destination side, this should always be NULL, and the variable
-     * `clear_bmap_shift' is meaningless.
-     */
-    unsigned long *clear_bmap;
-    uint8_t clear_bmap_shift;
-};
+#include "exec/ramblock.h"
=20
 /**
  * clear_bmap_size: calculate clear bitmap size
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
new file mode 100644
index 0000000000..07d50864d8
--- /dev/null
+++ b/include/exec/ramblock.h
@@ -0,0 +1,64 @@
+/*
+ * Declarations for cpu physical memory functions
+ *
+ * Copyright 2011 Red Hat, Inc. and/or its affiliates
+ *
+ * Authors:
+ *  Avi Kivity <avi@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ *
+ */
+
+/*
+ * This header is for use by exec.c and memory.c ONLY.  Do not include it.
+ * The functions declared here will be removed soon.
+ */
+
+#ifndef QEMU_EXEC_RAMBLOCK_H
+#define QEMU_EXEC_RAMBLOCK_H
+
+#ifndef CONFIG_USER_ONLY
+#include "cpu-common.h"
+
+struct RAMBlock {
+    struct rcu_head rcu;
+    struct MemoryRegion *mr;
+    uint8_t *host;
+    uint8_t *colo_cache; /* For colo, VM's ram cache */
+    ram_addr_t offset;
+    ram_addr_t used_length;
+    ram_addr_t max_length;
+    void (*resized)(const char*, uint64_t length, void *host);
+    uint32_t flags;
+    /* Protected by iothread lock.  */
+    char idstr[256];
+    /* RCU-enabled, writes protected by the ramlist lock */
+    QLIST_ENTRY(RAMBlock) next;
+    QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
+    int fd;
+    size_t page_size;
+    /* dirty bitmap used during migration */
+    unsigned long *bmap;
+    /* bitmap of already received pages in postcopy */
+    unsigned long *receivedmap;
+
+    /*
+     * bitmap to track already cleared dirty bitmap.  When the bit is
+     * set, it means the corresponding memory chunk needs a log-clear.
+     * Set this up to non-NULL to enable the capability to postpone
+     * and split clearing of dirty bitmap on the remote node (e.g.,
+     * KVM).  The bitmap will be set only when doing global sync.
+     *
+     * NOTE: this bitmap is different comparing to the other bitmaps
+     * in that one bit can represent multiple guest pages (which is
+     * decided by the `clear_bmap_shift' variable below).  On
+     * destination side, this should always be NULL, and the variable
+     * `clear_bmap_shift' is meaningless.
+     */
+    unsigned long *clear_bmap;
+    uint8_t clear_bmap_shift;
+};
+#endif
+#endif
--=20
2.24.1


