Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1F8C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6386206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDyGBDUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6386206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQomP-0001Id-Sm
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 05:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jQofk-0007wt-1s
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jQofi-0001JF-1J
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:54:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32099
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jQofh-0001Ee-8C
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587459262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWNorBYfar3WMb9elUru/Lr93DUggyUyRqR6DMBbnEc=;
 b=UDyGBDUVP6wV86Ft82lGbHXeh0vBJEIO3AC/1HGcu/e9KKPVJG539f7sDx9nBQZSNB3k5Q
 7bZY0hx90Mulsssw/J/uJA6JWL2lQjSUhYduyqeg3sO+Sy9DMR6Uz/SqVJgWatQyd0EhgB
 tXh8qE+YVaywdGI/Wu7S5m6u5hPr0Is=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-NZd9qpQsMIuspO-QoxqIFw-1; Tue, 21 Apr 2020 04:54:20 -0400
X-MC-Unique: NZd9qpQsMIuspO-QoxqIFw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BF1E802560;
 Tue, 21 Apr 2020 08:54:19 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-245.ams2.redhat.com [10.36.113.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82FDB1001B30;
 Tue, 21 Apr 2020 08:54:15 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/13] migration/ram: Simplify host page handling in
 ram_load_postcopy()
Date: Tue, 21 Apr 2020 10:52:55 +0200
Message-Id: <20200421085300.7734-9-david@redhat.com>
In-Reply-To: <20200421085300.7734-1-david@redhat.com>
References: <20200421085300.7734-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 04:54:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add two new helper functions. This will in come handy once we want to
handle ram block resizes while postcopy is active.

Note that ram_block_from_stream() will already print proper errors.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 migration/ram.c | 54 ++++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 2704d32def..2a2165b478 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2743,6 +2743,20 @@ static inline void *host_from_ram_block_offset(RAMBl=
ock *block,
     return block->host + offset;
 }
=20
+static void *host_page_from_ram_block_offset(RAMBlock *block,
+                                             ram_addr_t offset)
+{
+    /* Note: Explicitly no check against offset_in_ramblock(). */
+    return (void *)QEMU_ALIGN_DOWN((uintptr_t)block->host + offset,
+                                   block->page_size);
+}
+
+static ram_addr_t host_page_offset_from_ram_block_offset(RAMBlock *block,
+                                                         ram_addr_t offset=
)
+{
+    return ((uintptr_t)block->host + offset) & (block->page_size - 1);
+}
+
 static inline void *colo_cache_from_block_offset(RAMBlock *block,
                              ram_addr_t offset, bool record_bitmap)
 {
@@ -3135,13 +3149,12 @@ static int ram_load_postcopy(QEMUFile *f)
     MigrationIncomingState *mis =3D migration_incoming_get_current();
     /* Temporary page that is later 'placed' */
     void *postcopy_host_page =3D mis->postcopy_tmp_page;
-    void *this_host =3D NULL;
+    void *host_page =3D NULL;
     bool all_zero =3D false;
     int target_pages =3D 0;
=20
     while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
         ram_addr_t addr;
-        void *host =3D NULL;
         void *page_buffer =3D NULL;
         void *place_source =3D NULL;
         RAMBlock *block =3D NULL;
@@ -3167,9 +3180,12 @@ static int ram_load_postcopy(QEMUFile *f)
         if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
                      RAM_SAVE_FLAG_COMPRESS_PAGE)) {
             block =3D ram_block_from_stream(f, flags);
+            if (!block) {
+                ret =3D -EINVAL;
+                break;
+            }
=20
-            host =3D host_from_ram_block_offset(block, addr);
-            if (!host) {
+            if (!offset_in_ramblock(block, addr)) {
                 error_report("Illegal RAM offset " RAM_ADDR_FMT, addr);
                 ret =3D -EINVAL;
                 break;
@@ -3187,21 +3203,18 @@ static int ram_load_postcopy(QEMUFile *f)
              * of a host page in one chunk.
              */
             page_buffer =3D postcopy_host_page +
-                          ((uintptr_t)host & (block->page_size - 1));
+                          host_page_offset_from_ram_block_offset(block, ad=
dr);
             /* If all TP are zero then we can optimise the place */
             if (target_pages =3D=3D 1) {
                 all_zero =3D true;
-                this_host =3D (void *)QEMU_ALIGN_DOWN((uintptr_t)host,
-                                                    block->page_size);
-            } else {
+                host_page =3D host_page_from_ram_block_offset(block, addr)=
;
+            } else if (host_page !=3D host_page_from_ram_block_offset(bloc=
k,
+                                                                    addr))=
 {
                 /* not the 1st TP within the HP */
-                if (QEMU_ALIGN_DOWN((uintptr_t)host, block->page_size) !=
=3D
-                    (uintptr_t)this_host) {
-                    error_report("Non-same host page %p/%p",
-                                  host, this_host);
-                    ret =3D -EINVAL;
-                    break;
-                }
+                error_report("Non-same host page %p/%p", host_page,
+                             host_page_from_ram_block_offset(block, addr))=
;
+                ret =3D -EINVAL;
+                break;
             }
=20
             /*
@@ -3281,16 +3294,11 @@ static int ram_load_postcopy(QEMUFile *f)
         }
=20
         if (!ret && place_needed) {
-            /* This gets called at the last target page in the host page *=
/
-            void *place_dest =3D (void *)QEMU_ALIGN_DOWN((uintptr_t)host,
-                                                       block->page_size);
-
             if (all_zero) {
-                ret =3D postcopy_place_page_zero(mis, place_dest,
-                                               block);
+                ret =3D postcopy_place_page_zero(mis, host_page, block);
             } else {
-                ret =3D postcopy_place_page(mis, place_dest,
-                                          place_source, block);
+                ret =3D postcopy_place_page(mis, host_page, place_source,
+                                          block);
             }
         }
     }
--=20
2.25.1


