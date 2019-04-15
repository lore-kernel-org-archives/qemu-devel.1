Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61306C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3237F20833
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3237F20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50342 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG1kg-0000xV-He
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 09:34:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG1e0-0004rt-B8
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG1dy-00059s-Ew
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:27:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hG1dw-00058E-FX; Mon, 15 Apr 2019 09:27:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA5BE307EA98;
	Mon, 15 Apr 2019 13:27:26 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E7D0A1001DDD;
	Mon, 15 Apr 2019 13:27:21 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Apr 2019 15:27:22 +0200
Message-Id: <1555334842-195718-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Mon, 15 Apr 2019 13:27:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 5/5] s390: do not call
 memory_region_allocate_system_memory() multiple times
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
	Helge Deller <deller@gmx.de>, Cornelia Huck <cohuck@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
	=?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415132722.uA3bHhHsvD3dRhugzZcUZTr6NlkQHIYfaZzOt4DFuoE@z>

s390 was trying to solve limited memslot size issue by abusing
memory_region_allocate_system_memory(), which breaks API contract
where the function might be called only once.

s390 should have used memory aliases to fragment inital memory into
smaller chunks to satisfy KVM's memslot limitation. But its a bit
late now, since allocated pieces are transfered in migration stream
separately, so it's not possible to just replace broken layout with
correct one. Previous patch made MemoryRegion alases migratable and
this patch switches to use them to split big initial RAM chunk into
smaller pieces up to KVM_SLOT_MAX_BYTES each and registers aliases
for migration.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
A don't have access to a suitable system to test it, so I've simulated
it with smaller chunks on x84 host. Ping-pong migration between old
and new QEMU worked fine.  KVM part should be fine as memslots
using mapped MemoryRegions (in this case it would be aliases) as
far as I know but is someone could test it on big enough host it
would be nice.
---
 hw/s390x/s390-virtio-ccw.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d11069b..12ca3a9 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -161,20 +161,30 @@ static void virtio_ccw_register_hcalls(void)
 static void s390_memory_init(ram_addr_t mem_size)
 {
     MemoryRegion *sysmem = get_system_memory();
+    MemoryRegion *ram = g_new(MemoryRegion, 1);
     ram_addr_t chunk, offset = 0;
     unsigned int number = 0;
     gchar *name;
 
     /* allocate RAM for core */
+    memory_region_allocate_system_memory(ram, NULL, "s390.whole.ram", mem_size);
+    /*
+     * memory_region_allocate_system_memory() registers allocated RAM for
+     * migration, however for compat reasons the RAM should be passed over
+     * as RAMBlocks of the size upto KVM_SLOT_MAX_BYTES. So unregister just
+     * allocated RAM so it won't be migrated directly. Aliases will take
+     * of segmenting RAM into legacy chunks.
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
2.7.4


