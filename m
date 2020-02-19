Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1FFC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B6652464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYWbkq5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B6652464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Saf-0005i2-CN
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j4S4C-0002QT-Mu
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:19:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j4S4B-0004bZ-NP
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:19:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47161
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j4S4B-0004bK-Jo
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582129155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LRZMmaOFT+YLkw4fQRIK/kcLZ/z8kwYDIvkYZGH+oZ4=;
 b=MYWbkq5yUehVc5FGbWV7WR726bWk72zMp6tx5HUC/Wdyqvms7/7tBfQAbLnr4vnc6VZxSM
 v50j0e++a6DdIXvFBFbJXXRGqBdiwEnW0GFzZailiM7Bd+X5r0cEDBjIVVdx6UvSOhOSrM
 S6XDKMKmjWRahGO3mdDIuoKHJMQcBJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-bkErZ9HwP1e2veukG39ceg-1; Wed, 19 Feb 2020 11:19:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A7D195BBE;
 Wed, 19 Feb 2020 16:19:09 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-151.ams2.redhat.com [10.36.116.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B016B811F8;
 Wed, 19 Feb 2020 16:19:07 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 12/13] migrate/ram: Use offset_in_ramblock() in range checks
Date: Wed, 19 Feb 2020 17:17:24 +0100
Message-Id: <20200219161725.115218-13-david@redhat.com>
In-Reply-To: <20200219161725.115218-1-david@redhat.com>
References: <20200219161725.115218-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: bkErZ9HwP1e2veukG39ceg-1
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
index 6d1dcb362c..891dcd687a 100644
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
@@ -3323,8 +3323,8 @@ static void colo_flush_ram_cache(void)
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


