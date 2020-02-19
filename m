Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A73C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DFC2464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/SDG44Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DFC2464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Sdb-0004Ry-ER
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j4S3x-00020l-Ql
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:19:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j4S3w-0004Wy-8P
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:19:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37540
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j4S3w-0004WS-4A
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582129139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZ/wGCtgh7Hvp5+b2Eld1rQrfaDOLbdsxZ+G2+/+Eew=;
 b=M/SDG44ZYKWMFu+7XzZgt+nQc9i6dIZ0cHFDxCzhS+OKkmKlj+32lM8apkdv5Jrc3oWH5j
 +lapw03yyvHdLjpr70EMSKI/7/lR3yBt2DXZXKiJH9AgLmHbaJdXD/oFYp3dsYEmy+jpzG
 M0PV1flkHGd0xZybuerfwiEF3oxJ+N8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-WM12KYrjPC2AXQa484ElbA-1; Wed, 19 Feb 2020 11:18:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4E80801F96;
 Wed, 19 Feb 2020 16:18:54 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-151.ams2.redhat.com [10.36.116.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6066811F8;
 Wed, 19 Feb 2020 16:18:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 09/13] migrate/ram: Consolidate variable reset after
 placement in ram_load_postcopy()
Date: Wed, 19 Feb 2020 17:17:21 +0100
Message-Id: <20200219161725.115218-10-david@redhat.com>
In-Reply-To: <20200219161725.115218-1-david@redhat.com>
References: <20200219161725.115218-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: WM12KYrjPC2AXQa484ElbA-1
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

Let's consolidate resetting the variables.

Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 migration/ram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 80a4e4a9ea..ab1f5534cf 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3126,7 +3126,7 @@ static int ram_load_postcopy(QEMUFile *f)
     /* Temporary page that is later 'placed' */
     void *postcopy_host_page =3D mis->postcopy_tmp_page;
     void *host_page =3D NULL;
-    bool all_zero =3D false;
+    bool all_zero =3D true;
     int target_pages =3D 0;
=20
     while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
@@ -3151,7 +3151,6 @@ static int ram_load_postcopy(QEMUFile *f)
         addr &=3D TARGET_PAGE_MASK;
=20
         trace_ram_load_postcopy_loop((uint64_t)addr, flags);
-        place_needed =3D false;
         if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
                      RAM_SAVE_FLAG_COMPRESS_PAGE)) {
             block =3D ram_block_from_stream(f, flags);
@@ -3179,9 +3178,7 @@ static int ram_load_postcopy(QEMUFile *f)
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
@@ -3198,7 +3195,6 @@ static int ram_load_postcopy(QEMUFile *f)
              */
             if (target_pages =3D=3D (block->page_size / TARGET_PAGE_SIZE))=
 {
                 place_needed =3D true;
-                target_pages =3D 0;
             }
         }
=20
@@ -3274,6 +3270,10 @@ static int ram_load_postcopy(QEMUFile *f)
                 ret =3D postcopy_place_page(mis, host_page, postcopy_host_=
page,
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
2.24.1


