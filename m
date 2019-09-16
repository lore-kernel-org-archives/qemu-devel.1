Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AAAC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 13:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5723120644
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 13:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5723120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9r35-0007yp-Ew
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 09:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1i9qz4-0004vm-Jq
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1i9qz3-00009t-DH
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:24:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52702)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1i9qz3-00009b-7i; Mon, 16 Sep 2019 09:24:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D2662A09AE;
 Mon, 16 Sep 2019 13:24:00 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B55C10013A1;
 Mon, 16 Sep 2019 13:23:59 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 09:23:47 -0400
Message-Id: <20190916132347.30676-3-imammedo@redhat.com>
In-Reply-To: <20190916132347.30676-1-imammedo@redhat.com>
References: <20190916132347.30676-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 16 Sep 2019 13:24:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 2/2] s390: do not call
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
Cc: pbonzini@redhat.com, thuth@redhat.com, cohuck@redhat.com,
 qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

s390 was trying to solve limited KVM memslot size issue by abusing
memory_region_allocate_system_memory(), which breaks API contract
where the function might be called only once.

Beside an invalid use of API, the approach also introduced migration
issue, since RAM chunks for each KVM_SLOT_MAX_BYTES are transferred in
migration stream as separate RAMBlocks.

After discussion [1], it was agreed to break migration from older
QEMU for guest with RAM >8Tb (as it was relatively new (since 2.12)
and considered to be not actually used downstream).
Migration should keep working for guests with less than 8TB and for
more than 8TB with QEMU 4.2 and newer binary.
In case user tries to migrate more than 8TB guest, between incompatible
QEMU versions, migration should fail gracefully due to non-exiting
RAMBlock ID or RAMBlock size mismatch.

Taking in account above and that now KVM code is able to split too
big MemorySection into several memslots, stop abusing
  memory_region_allocate_system_memory()
and use only one memory region for RAM.

1) [PATCH RFC v2 4/4] s390: do not call  memory_region_allocate_system_memory() multiple times

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
v3:
  - drop migration compat code

PS:
I don't have access to a suitable system to test it.
---
 hw/s390x/s390-virtio-ccw.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index baa95aad38..18ad279a00 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -157,27 +157,12 @@ static void virtio_ccw_register_hcalls(void)
 static void s390_memory_init(ram_addr_t mem_size)
 {
     MemoryRegion *sysmem = get_system_memory();
-    ram_addr_t chunk, offset = 0;
-    unsigned int number = 0;
+    MemoryRegion *ram = g_new(MemoryRegion, 1);
     Error *local_err = NULL;
-    gchar *name;
 
     /* allocate RAM for core */
-    name = g_strdup_printf("s390.ram");
-    while (mem_size) {
-        MemoryRegion *ram = g_new(MemoryRegion, 1);
-        uint64_t size = mem_size;
-
-        /* KVM does not allow memslots >= 8 TB */
-        chunk = MIN(size, KVM_SLOT_MAX_BYTES);
-        memory_region_allocate_system_memory(ram, NULL, name, chunk);
-        memory_region_add_subregion(sysmem, offset, ram);
-        mem_size -= chunk;
-        offset += chunk;
-        g_free(name);
-        name = g_strdup_printf("s390.ram.%u", ++number);
-    }
-    g_free(name);
+    memory_region_allocate_system_memory(ram, NULL, "s390.ram", mem_size);
+    memory_region_add_subregion(sysmem, 0, ram);
 
     /*
      * Configure the maximum page size. As no memory devices were created
-- 
2.18.1


