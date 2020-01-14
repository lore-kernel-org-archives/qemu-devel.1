Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8982C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741C42084D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jM0tTnfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741C42084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irIdT-0001K3-Bc
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 04:37:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1irIVw-0000ON-2a
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1irIVt-0006xb-FY
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:29:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23810
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1irIVt-0006xN-Az
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578994168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bUpSs16sfRN2CEtPjACS0gftqpvp1N70X+Vg3Et2BU=;
 b=jM0tTnfOeBSOtNhDZusUGEFkKF7vXVDYR8tMI3d+x42I9b0GVN66ht/i1HsvCoablOsNZl
 h8zMBCLkT2S4GxCyIfx3pAp2ch4O7UIW+OtMRJMtjSUILEQ27k/QO+XChY+EHvtvzVBQtr
 YAcpsv0XaHBHY8HO3QvlpqshCDRGRIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-3OgSkqZ7NdGiHhzMK9ANcg-1; Tue, 14 Jan 2020 04:29:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D31C801E72;
 Tue, 14 Jan 2020 09:29:25 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3595B19757;
 Tue, 14 Jan 2020 09:29:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/29] Bug #1829242 correction.
Date: Tue, 14 Jan 2020 10:26:02 +0100
Message-Id: <20200114092606.1761-26-quintela@redhat.com>
In-Reply-To: <20200114092606.1761-1-quintela@redhat.com>
References: <20200114092606.1761-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 3OgSkqZ7NdGiHhzMK9ANcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Alexey Romko <nevilad@yahoo.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Romko <nevilad@yahoo.com>

Added type conversions to ram_addr_t before all left shifts of page
indexes to TARGET_PAGE_BITS, to correct overflows when the page
address was 4Gb and more.

Signed-off-by: Alexey Romko <nevilad@yahoo.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 7221f54139..d0940387d1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1768,7 +1768,7 @@ static inline bool migration_bitmap_clear_dirty(RAMSt=
ate *rs,
     if (rb->clear_bmap && clear_bmap_test_and_clear(rb, page)) {
         uint8_t shift =3D rb->clear_bmap_shift;
         hwaddr size =3D 1ULL << (TARGET_PAGE_BITS + shift);
-        hwaddr start =3D (page << TARGET_PAGE_BITS) & (-size);
+        hwaddr start =3D (((ram_addr_t)page) << TARGET_PAGE_BITS) & (-size=
);
=20
         /*
          * CLEAR_BITMAP_SHIFT_MIN should always guarantee this... this
@@ -2005,7 +2005,7 @@ static void ram_release_pages(const char *rbname, uin=
t64_t offset, int pages)
         return;
     }
=20
-    ram_discard_range(rbname, offset, pages << TARGET_PAGE_BITS);
+    ram_discard_range(rbname, offset, ((ram_addr_t)pages) << TARGET_PAGE_B=
ITS);
 }
=20
 /*
@@ -2093,7 +2093,7 @@ static int ram_save_page(RAMState *rs, PageSearchStat=
us *pss, bool last_stage)
     uint8_t *p;
     bool send_async =3D true;
     RAMBlock *block =3D pss->block;
-    ram_addr_t offset =3D pss->page << TARGET_PAGE_BITS;
+    ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
     ram_addr_t current_addr =3D block->offset + offset;
=20
     p =3D block->host + offset;
@@ -2280,7 +2280,8 @@ static bool find_dirty_block(RAMState *rs, PageSearch=
Status *pss, bool *again)
         *again =3D false;
         return false;
     }
-    if ((pss->page << TARGET_PAGE_BITS) >=3D pss->block->used_length) {
+    if ((((ram_addr_t)pss->page) << TARGET_PAGE_BITS)
+        >=3D pss->block->used_length) {
         /* Didn't find anything in this RAM Block */
         pss->page =3D 0;
         pss->block =3D QLIST_NEXT_RCU(pss->block, next);
@@ -2571,7 +2572,7 @@ static int ram_save_target_page(RAMState *rs, PageSea=
rchStatus *pss,
                                 bool last_stage)
 {
     RAMBlock *block =3D pss->block;
-    ram_addr_t offset =3D pss->page << TARGET_PAGE_BITS;
+    ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
     int res;
=20
     if (control_save_page(rs, block, offset, &res)) {
@@ -2657,7 +2658,8 @@ static int ram_save_host_page(RAMState *rs, PageSearc=
hStatus *pss,
         /* Allow rate limiting to happen in the middle of huge pages */
         migration_rate_limit();
     } while ((pss->page & (pagesize_bits - 1)) &&
-             offset_in_ramblock(pss->block, pss->page << TARGET_PAGE_BITS)=
);
+             offset_in_ramblock(pss->block,
+                                ((ram_addr_t)pss->page) << TARGET_PAGE_BIT=
S));
=20
     /* The offset we leave with is the last one we looked at */
     pss->page--;
@@ -2874,8 +2876,10 @@ void ram_postcopy_migrated_memory_release(MigrationS=
tate *ms)
=20
         while (run_start < range) {
             unsigned long run_end =3D find_next_bit(bitmap, range, run_sta=
rt + 1);
-            ram_discard_range(block->idstr, run_start << TARGET_PAGE_BITS,
-                              (run_end - run_start) << TARGET_PAGE_BITS);
+            ram_discard_range(block->idstr,
+                              ((ram_addr_t)run_start) << TARGET_PAGE_BITS,
+                              ((ram_addr_t)(run_end - run_start))
+                                << TARGET_PAGE_BITS);
             run_start =3D find_next_zero_bit(bitmap, range, run_end + 1);
         }
     }
@@ -4273,13 +4277,16 @@ static void colo_flush_ram_cache(void)
         while (block) {
             offset =3D migration_bitmap_find_dirty(ram_state, block, offse=
t);
=20
-            if (offset << TARGET_PAGE_BITS >=3D block->used_length) {
+            if (((ram_addr_t)offset) << TARGET_PAGE_BITS
+                >=3D block->used_length) {
                 offset =3D 0;
                 block =3D QLIST_NEXT_RCU(block, next);
             } else {
                 migration_bitmap_clear_dirty(ram_state, block, offset);
-                dst_host =3D block->host + (offset << TARGET_PAGE_BITS);
-                src_host =3D block->colo_cache + (offset << TARGET_PAGE_BI=
TS);
+                dst_host =3D block->host
+                         + (((ram_addr_t)offset) << TARGET_PAGE_BITS);
+                src_host =3D block->colo_cache
+                         + (((ram_addr_t)offset) << TARGET_PAGE_BITS);
                 memcpy(dst_host, src_host, TARGET_PAGE_SIZE);
             }
         }
--=20
2.24.1


