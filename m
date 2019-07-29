Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454BEC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7ED2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7ED2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs71U-0000SE-DR
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 10:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36412)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hs70x-0007z7-LN
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hs70w-0000TQ-KR
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:52:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34478)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1hs70w-0000Sw-DR; Mon, 29 Jul 2019 10:52:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B990E307CDFC;
 Mon, 29 Jul 2019 14:52:37 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2F145D9C8;
 Mon, 29 Jul 2019 14:52:36 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 10:52:29 -0400
Message-Id: <20190729145229.4333-3-imammedo@redhat.com>
In-Reply-To: <20190729145229.4333-1-imammedo@redhat.com>
References: <20190729145229.4333-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 29 Jul 2019 14:52:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH RFC 2/2] s390: do not call
 memory_region_allocate_system_memory() multiple times
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
Cc: pbonzini@redhat.com, qemu-s390x@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

s390 was trying to solve limited KVM memslot size issue by abusing
memory_region_allocate_system_memory(), which breaks API contract
where the function might be called only once.

s390 should have used memory aliases to fragment inital memory into
smaller chunks to satisfy KVM's memslot limitation. But its a bit
late now, since allocated pieces are transfered in migration stream
separately, so it's not possible to just replace broken layout with
correct one. To workaround previous patch made MemoryRegion alases
migratable and this patch switches to use them to split big initial
RAM chunk into smaller pieces up to KVM_SLOT_MAX_BYTES each and
registers aliases for migration. That should keep migration and
guest ABI (RAM mapping) compatible with previous QEMU versions.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
I don't have access to a suitable system to test it, so I've simulated
it with smaller chunks on x84 host. Ping-pong migration between old
and new QEMU worked fine. KVM part should be fine as memslots
using mapped MemoryRegions (in this case it would be aliases) as
far as I know but is someone could test it on big enough host it
would be nice.
---
 hw/s390x/s390-virtio-ccw.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 5b6a9a4e55..77910419e6 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -163,21 +163,31 @@ static void virtio_ccw_register_hcalls(void)
 static void s390_memory_init(ram_addr_t mem_size)
 {
     MemoryRegion *sysmem = get_system_memory();
+    MemoryRegion *ram = g_new(MemoryRegion, 1);
     ram_addr_t chunk, offset = 0;
     unsigned int number = 0;
     Error *local_err = NULL;
     gchar *name;
 
     /* allocate RAM for core */
+    memory_region_allocate_system_memory(ram, NULL, "s390.whole.ram", mem_size);
+    /*
+     * memory_region_allocate_system_memory() registers allocated RAM for
+     * migration, however for compat reasons the RAM should be passed over
+     * as RAMBlocks of the size upto KVM_SLOT_MAX_BYTES. So unregister just
+     * allocated RAM so it won't be migrated directly. Aliases will take care
+     * of segmenting RAM into legacy chunks that migration and KVM compatible.
+     */
+    vmstate_unregister_ram(ram, NULL);
     name = g_strdup_printf("s390.ram");
     while (mem_size) {
-        MemoryRegion *ram = g_new(MemoryRegion, 1);
-        uint64_t size = mem_size;
+        MemoryRegion *alias = g_new(MemoryRegion, 1);
 
         /* KVM does not allow memslots >= 8 TB */
-        chunk = MIN(size, KVM_SLOT_MAX_BYTES);
-        memory_region_allocate_system_memory(ram, NULL, name, chunk);
-        memory_region_add_subregion(sysmem, offset, ram);
+        chunk = MIN(mem_size, KVM_SLOT_MAX_BYTES);
+        memory_region_init_alias(alias, NULL, name, ram, offset, chunk);
+        vmstate_register_ram_global(alias);
+        memory_region_add_subregion(sysmem, offset, alias);
         mem_size -= chunk;
         offset += chunk;
         g_free(name);
-- 
2.18.1


