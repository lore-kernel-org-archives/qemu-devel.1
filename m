Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBD6C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7BB1206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oz4m39nK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BB1206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQonu-0003CP-Uo
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 05:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jQofl-0007xP-OU
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jQofk-0001M2-9E
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:54:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21030
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jQofj-0001KI-Qj
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587459267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ek2o7jkqrCOq3tnDF+D8qeQ7NVH7+0m81v+G2i6NfUc=;
 b=Oz4m39nKJIHaENGHNX8xgcHjwKmuPQ6Ayl+QPjuZ61eOHTd/Y312Aw7qpGoLhX/IRn+YEf
 7KB1LEG9NPWpZX1iJYqZ81wwPnvOVxGaAOZUcp8WRMMacnsDoFmslq+ZOu2OeM+k8O/2UT
 DvEamkt5fdIi+pLIAKfBA3xxdYjenlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-UuzGtCelO5upyQeRtMmEEQ-1; Tue, 21 Apr 2020 04:54:25 -0400
X-MC-Unique: UuzGtCelO5upyQeRtMmEEQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3714E802562;
 Tue, 21 Apr 2020 08:54:24 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-245.ams2.redhat.com [10.36.113.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BA431001B30;
 Tue, 21 Apr 2020 08:54:19 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/13] migration/ram: Consolidate variable reset after
 placement in ram_load_postcopy()
Date: Tue, 21 Apr 2020 10:52:56 +0200
Message-Id: <20200421085300.7734-10-david@redhat.com>
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

Let's consolidate resetting the variables.

Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 migration/ram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 2a2165b478..7eca3165c8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3150,7 +3150,7 @@ static int ram_load_postcopy(QEMUFile *f)
     /* Temporary page that is later 'placed' */
     void *postcopy_host_page =3D mis->postcopy_tmp_page;
     void *host_page =3D NULL;
-    bool all_zero =3D false;
+    bool all_zero =3D true;
     int target_pages =3D 0;
=20
     while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
@@ -3176,7 +3176,6 @@ static int ram_load_postcopy(QEMUFile *f)
         addr &=3D TARGET_PAGE_MASK;
=20
         trace_ram_load_postcopy_loop((uint64_t)addr, flags);
-        place_needed =3D false;
         if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
                      RAM_SAVE_FLAG_COMPRESS_PAGE)) {
             block =3D ram_block_from_stream(f, flags);
@@ -3204,9 +3203,7 @@ static int ram_load_postcopy(QEMUFile *f)
              */
             page_buffer =3D postcopy_host_page +
                           host_page_offset_from_ram_block_offset(block, ad=
dr);
-            /* If all TP are zero then we can optimise the place */
             if (target_pages =3D=3D 1) {
-                all_zero =3D true;
                 host_page =3D host_page_from_ram_block_offset(block, addr)=
;
             } else if (host_page !=3D host_page_from_ram_block_offset(bloc=
k,
                                                                     addr))=
 {
@@ -3223,7 +3220,6 @@ static int ram_load_postcopy(QEMUFile *f)
              */
             if (target_pages =3D=3D (block->page_size / TARGET_PAGE_SIZE))=
 {
                 place_needed =3D true;
-                target_pages =3D 0;
             }
             place_source =3D postcopy_host_page;
         }
@@ -3300,6 +3296,10 @@ static int ram_load_postcopy(QEMUFile *f)
                 ret =3D postcopy_place_page(mis, host_page, place_source,
                                           block);
             }
+            place_needed =3D false;
+            target_pages =3D 0;
+            /* Assume we have a zero page until we detect something differ=
ent */
+            all_zero =3D true;
         }
     }
=20
--=20
2.25.1


