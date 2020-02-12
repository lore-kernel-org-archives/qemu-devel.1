Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872A0C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 534D020724
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ip4nLi8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534D020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sDw-0006bV-G6
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1sBs-00024E-Oy
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1sBr-0006Ha-G0
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50963
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1sBr-0006HJ-Bw
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581514590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BBNasa56TtnVAjj/4k9eShjYigwuq4zSyA2Tmtxnj24=;
 b=Ip4nLi8ir7hDdqfYzfcavhxCs8+B5PE3RByAu7cuOfmLZtPLQvFbQ8GBRRBy+Y9IgIm1ik
 8Ceg/fYqxezpFxxE5999GzyBSDeLFzpUd+yH5sdjLVahDLAXStxAX4dzvuswJiYew+Egdi
 qFlkdeH6EdZxLqWLAsdgR2l2MbDCFck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-rNmESfL9NKODpGuY5UtgpA-1; Wed, 12 Feb 2020 08:36:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CCDD19057A1;
 Wed, 12 Feb 2020 13:36:28 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDD7819C69;
 Wed, 12 Feb 2020 13:36:21 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/16] exec: Provide owner when resizing memory region
Date: Wed, 12 Feb 2020 14:35:51 +0100
Message-Id: <20200212133601.10555-7-david@redhat.com>
In-Reply-To: <20200212133601.10555-1-david@redhat.com>
References: <20200212133601.10555-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: rNmESfL9NKODpGuY5UtgpA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's pass the owner in the callback. While touching it, introduce a
typedef for the callback.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 exec.c                  | 13 +++++--------
 hw/core/loader.c        |  3 ++-
 include/exec/memory.h   |  7 ++++---
 include/exec/ram_addr.h |  4 +---
 include/exec/ramblock.h |  3 ++-
 memory.c                |  4 +---
 6 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/exec.c b/exec.c
index 71e32dcc11..5bc9b231c4 100644
--- a/exec.c
+++ b/exec.c
@@ -2193,7 +2193,8 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsi=
ze, Error **errp)
=20
     memory_region_set_size(block->mr, newsize);
     if (block->resized) {
-        block->resized(block->idstr, newsize, block->host);
+        block->resized(memory_region_owner(block->mr), block->idstr, newsi=
ze,
+                       block->host);
     }
=20
     /*
@@ -2476,9 +2477,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, M=
emoryRegion *mr,
=20
 static
 RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
-                                  void (*resized)(const char*,
-                                                  uint64_t length,
-                                                  void *host),
+                                  memory_region_resized_fn resized,
                                   void *host, bool resizeable, bool share,
                                   MemoryRegion *mr, Error **errp)
 {
@@ -2529,10 +2528,8 @@ RAMBlock *qemu_ram_alloc(ram_addr_t size, bool share=
,
 }
=20
 RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t maxsz,
-                                     void (*resized)(const char*,
-                                                     uint64_t length,
-                                                     void *host),
-                                     MemoryRegion *mr, Error **errp)
+                                    memory_region_resized_fn resized,
+                                    MemoryRegion *mr, Error **errp)
 {
     return qemu_ram_alloc_internal(size, maxsz, resized, NULL, true,
                                    false, mr, errp);
diff --git a/hw/core/loader.c b/hw/core/loader.c
index d1b78f60cd..59fb1620f1 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -912,7 +912,8 @@ static void rom_insert(Rom *rom)
     QTAILQ_INSERT_TAIL(&roms, rom, next);
 }
=20
-static void fw_cfg_resized(const char *id, uint64_t length, void *host)
+static void fw_cfg_resized(Object *owner, const char *id, uint64_t length,
+                           void *host)
 {
     if (fw_cfg) {
         fw_cfg_modify_file(fw_cfg, id + strlen("/rom@"), host, length);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 19417943a2..9f02bb7830 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -846,6 +846,9 @@ void memory_region_init_ram_shared_nomigrate(MemoryRegi=
on *mr,
                                              bool share,
                                              Error **errp);
=20
+typedef void (*memory_region_resized_fn)(Object *owner, const char*id,
+                                         uint64_t length, void *host);
+
 /**
  * memory_region_init_resizeable_ram:  Initialize memory region with resiz=
eable
  *                                     RAM.  Accesses into the region will
@@ -870,9 +873,7 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr=
,
                                        const char *name,
                                        uint64_t size,
                                        uint64_t max_size,
-                                       void (*resized)(const char*,
-                                                       uint64_t length,
-                                                       void *host),
+                                       memory_region_resized_fn resized,
                                        Error **errp);
 #ifdef CONFIG_POSIX
=20
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 5e59a3d8d7..0ee3126361 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -128,9 +128,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void=
 *host,
 RAMBlock *qemu_ram_alloc(ram_addr_t size, bool share, MemoryRegion *mr,
                          Error **errp);
 RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t max_size,
-                                    void (*resized)(const char*,
-                                                    uint64_t length,
-                                                    void *host),
+                                    memory_region_resized_fn resized,
                                     MemoryRegion *mr, Error **errp);
 void qemu_ram_free(RAMBlock *block);
=20
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 07d50864d8..437b8f82ea 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -21,6 +21,7 @@
=20
 #ifndef CONFIG_USER_ONLY
 #include "cpu-common.h"
+#include "exec/memory.h"
=20
 struct RAMBlock {
     struct rcu_head rcu;
@@ -30,7 +31,7 @@ struct RAMBlock {
     ram_addr_t offset;
     ram_addr_t used_length;
     ram_addr_t max_length;
-    void (*resized)(const char*, uint64_t length, void *host);
+    memory_region_resized_fn resized;
     uint32_t flags;
     /* Protected by iothread lock.  */
     char idstr[256];
diff --git a/memory.c b/memory.c
index aeaa8dcc9e..cb09a8ee59 100644
--- a/memory.c
+++ b/memory.c
@@ -1535,9 +1535,7 @@ void memory_region_init_resizeable_ram(MemoryRegion *=
mr,
                                        const char *name,
                                        uint64_t size,
                                        uint64_t max_size,
-                                       void (*resized)(const char*,
-                                                       uint64_t length,
-                                                       void *host),
+                                       memory_region_resized_fn resized,
                                        Error **errp)
 {
     Error *err =3D NULL;
--=20
2.24.1


