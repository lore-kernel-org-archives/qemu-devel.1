Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25ABC35658
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926982067D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCXVRpof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926982067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5BVY-00039D-L1
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j5BP1-0000PB-0p
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j5BP0-0007AF-1A
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:43:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53426
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j5BOz-0007A5-Tg
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582303425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbD2MWw/nLDVkxUemdyaLogLxwGW4nzWXsGitr5n5fs=;
 b=VCXVRpofGYt0lrW57zihnNHk9+Yy1NFl0UEjpuenevkMKjVs8xt/Aj5dp7QW4iQiCaitku
 irwePlPDf/IyoKpefZqXoytVtveIb+vmWFil+Eh3w1Xki2ls/WcIByYB0vKex0tmOzfDSi
 gWMw/wciTTc/oaNe/IIFlqd/jQ4VhP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-LNrgYfQrNs-tLFnWDnHEiA-1; Fri, 21 Feb 2020 11:43:43 -0500
X-MC-Unique: LNrgYfQrNs-tLFnWDnHEiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8868D1400;
 Fri, 21 Feb 2020 16:43:42 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-197.ams2.redhat.com [10.36.117.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B1A990F7C;
 Fri, 21 Feb 2020 16:43:37 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/13] migration/ram: Use offset_in_ramblock() in range
 checks
Date: Fri, 21 Feb 2020 17:42:03 +0100
Message-Id: <20200221164204.105570-13-david@redhat.com>
In-Reply-To: <20200221164204.105570-1-david@redhat.com>
References: <20200221164204.105570-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We never read or write beyond the used_length of memory blocks when
migrating. Make this clearer by using offset_in_ramblock() consistently.

Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 migration/ram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ee5c3d5784..5cc9993899 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1309,8 +1309,8 @@ static bool find_dirty_block(RAMState *rs, PageSearch=
Status *pss, bool *again)
         *again =3D false;
         return false;
     }
-    if ((((ram_addr_t)pss->page) << TARGET_PAGE_BITS)
-        >=3D pss->block->used_length) {
+    if (!offset_in_ramblock(pss->block,
+                            ((ram_addr_t)pss->page) << TARGET_PAGE_BITS)) =
{
         /* Didn't find anything in this RAM Block */
         pss->page =3D 0;
         pss->block =3D QLIST_NEXT_RCU(pss->block, next);
@@ -1514,7 +1514,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr=
_t start, ram_addr_t len)
         rs->last_req_rb =3D ramblock;
     }
     trace_ram_save_queue_pages(ramblock->idstr, start, len);
-    if (start+len > ramblock->used_length) {
+    if (!offset_in_ramblock(ramblock, start + len - 1)) {
         error_report("%s request overrun start=3D" RAM_ADDR_FMT " len=3D"
                      RAM_ADDR_FMT " blocklen=3D" RAM_ADDR_FMT,
                      __func__, start, len, ramblock->used_length);
@@ -3325,8 +3325,8 @@ static void colo_flush_ram_cache(void)
         while (block) {
             offset =3D migration_bitmap_find_dirty(ram_state, block, offse=
t);
=20
-            if (((ram_addr_t)offset) << TARGET_PAGE_BITS
-                >=3D block->used_length) {
+            if (!offset_in_ramblock(block,
+                                    ((ram_addr_t)offset) << TARGET_PAGE_BI=
TS)) {
                 offset =3D 0;
                 block =3D QLIST_NEXT_RCU(block, next);
             } else {
--=20
2.24.1


